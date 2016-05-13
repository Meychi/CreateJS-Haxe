package createjs.soundjs;

import js.html.audio.AudioBuffer;
import js.html.audio.AudioContext;
import js.html.audio.AudioNode;
import js.html.audio.GainNode;

/**
* Play sounds using Web Audio in the browser. The WebAudioPlugin is currently the default plugin, and will be used
*	anywhere that it is supported. To change plugin priority, check out the Sound API
*	{{#crossLink "Sound/registerPlugins"}}{{/crossLink}} method.
*	
*	<h4>Known Browser and OS issues for Web Audio</h4>
*	<b>Firefox 25</b>
*	<li>
*	    mp3 audio files do not load properly on all windows machines, reported <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=929969" target="_blank">here</a>.
*	    <br />For this reason it is recommended to pass another FireFox-supported type (i.e. ogg) as the default
*	    extension, until this bug is resolved
*	</li>
*	
*	<b>Webkit (Chrome and Safari)</b>
*	<li>
*	    AudioNode.disconnect does not always seem to work.  This can cause the file size to grow over time if you
*		   are playing a lot of audio files.
*	</li>
*	
*	<b>iOS 6 limitations</b>
*	<ul>
*	    <li>
*	        Sound is initially muted and will only unmute through play being called inside a user initiated event
*	        (touch/click). Please read the mobile playback notes in the the {{#crossLink "Sound"}}{{/crossLink}}
*	        class for a full overview of the limitations, and how to get around them.
*	    </li>
*		   <li>
*		       A bug exists that will distort un-cached audio when a video element is present in the DOM. You can avoid
*		       this bug by ensuring the audio and video audio share the same sample rate.
*		   </li>
*	</ul>
*/
@:native("createjs.WebAudioPlugin")
extern class WebAudioPlugin extends AbstractPlugin
{
	/**
	* A DynamicsCompressorNode, which is used to improve sound quality and prevent audio distortion. It is connected to <code>context.destination</code>.  Can be accessed by advanced users through createjs.Sound.activePlugin.dynamicsCompressorNode.
	*/
	public var dynamicsCompressorNode:AudioNode;
	
	/**
	* A GainNode for controlling master volume. It is connected to {{#crossLink "WebAudioPlugin/dynamicsCompressorNode:property"}}{{/crossLink}}.  Can be accessed by advanced users through createjs.Sound.activePlugin.gainNode.
	*/
	public var gainNode:GainNode;
	
	/**
	* Indicated whether audio on iOS has been unlocked, which requires a touchend/mousedown event that plays an empty sound.
	*/
	private var _unlocked:Boolean;
	
	/**
	* The capabilities of the plugin. This is generated via the {{#crossLink "WebAudioPlugin/_generateCapabilities:method"}}{{/crossLink}} method and is used internally.
	*/
	public static var _capabilities:Dynamic;
	
	/**
	* The scratch buffer that will be assigned to the buffer property of a source node on close. Works around an iOS Safari bug: https://github.com/CreateJS/SoundJS/issues/102  Advanced users can set this to an existing source node, but <b>must</b> do so before they call {{#crossLink "Sound/registerPlugins"}}{{/crossLink}} or {{#crossLink "Sound/initializeDefaultPlugins"}}{{/crossLink}}.
	*/
	public static var _scratchBuffer:AudioBuffer;
	
	/**
	* The web audio context, which WebAudio uses to play audio. All nodes that interact with the WebAudioPlugin need to be created within this context.
	*/
	//public var context:AudioContext;
	
	/**
	* The web audio context, which WebAudio uses to play audio. All nodes that interact with the WebAudioPlugin need to be created within this context.  Advanced users can set this to an existing context, but <b>must</b> do so before they call {{#crossLink "Sound/registerPlugins"}}{{/crossLink}} or {{#crossLink "Sound/initializeDefaultPlugins"}}{{/crossLink}}.
	*/
	public static var context:AudioContext;
	
	/**
	* Value to set panning model to equal power for WebAudioSoundInstance.  Can be "equalpower" or 0 depending on browser implementation.
	*/
	//private var _panningModel:Dynamic;
	
	/**
	* Value to set panning model to equal power for WebAudioSoundInstance.  Can be "equalpower" or 0 depending on browser implementation.
	*/
	public static var _panningModel:Dynamic;
	
	/**
	* Determine if the plugin can be used in the current browser/OS.
	*/
	public static function isSupported():Bool;
	
	/**
	* Determine if XHR is supported, which is necessary for web audio.
	*/
	private static function _isFileXHRSupported():Bool;
	
	/**
	* Determine the capabilities of the plugin. Used internally. Please see the Sound API {{#crossLink "Sound/getCapabilities"}}{{/crossLink}}
	*	method for an overview of plugin capabilities.
	*/
	private static function _generateCapabilities():Dynamic;
	
	/**
	* Play sounds using Web Audio in the browser. The WebAudioPlugin is currently the default plugin, and will be used
	*	anywhere that it is supported. To change plugin priority, check out the Sound API
	*	{{#crossLink "Sound/registerPlugins"}}{{/crossLink}} method.
	*	
	*	<h4>Known Browser and OS issues for Web Audio</h4>
	*	<b>Firefox 25</b>
	*	<li>
	*	    mp3 audio files do not load properly on all windows machines, reported <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=929969" target="_blank">here</a>.
	*	    <br />For this reason it is recommended to pass another FireFox-supported type (i.e. ogg) as the default
	*	    extension, until this bug is resolved
	*	</li>
	*	
	*	<b>Webkit (Chrome and Safari)</b>
	*	<li>
	*	    AudioNode.disconnect does not always seem to work.  This can cause the file size to grow over time if you
	*		   are playing a lot of audio files.
	*	</li>
	*	
	*	<b>iOS 6 limitations</b>
	*	<ul>
	*	    <li>
	*	        Sound is initially muted and will only unmute through play being called inside a user initiated event
	*	        (touch/click). Please read the mobile playback notes in the the {{#crossLink "Sound"}}{{/crossLink}}
	*	        class for a full overview of the limitations, and how to get around them.
	*	    </li>
	*		   <li>
	*		       A bug exists that will distort un-cached audio when a video element is present in the DOM. You can avoid
	*		       this bug by ensuring the audio and video audio share the same sample rate.
	*		   </li>
	*	</ul>
	*/
	public function new():Void;
	
	/**
	* Plays an empty sound in the web audio context.  This is used to enable web audio on iOS devices, as they
	*	require the first sound to be played inside of a user initiated event (touch/click).  This is called when
	*	{{#crossLink "WebAudioPlugin"}}{{/crossLink}} is initialized (by Sound {{#crossLink "Sound/initializeDefaultPlugins"}}{{/crossLink}}
	*	for example).
	*	
	*	<h4>Example</h4>
	*	
	*	    function handleTouch(event) {
	*	        createjs.WebAudioPlugin.playEmptySound();
	*	    }
	*/
	public static function playEmptySound():Dynamic;
	
	/**
	* Set the gain value for master audio. Should not be called externally.
	*/
	//private function _updateVolume():Dynamic;
	
	/**
	* Set up compatibility if only deprecated web audio calls are supported.
	*	See http://www.w3.org/TR/webaudio/#DeprecationNotes
	*	Needed so we can support new browsers that don't support deprecated calls (Firefox) as well as old browsers that
	*	don't support new calls.
	*/
	private static function _compatibilitySetUp():Dynamic;
	
	/**
	* Set up needed properties on supported classes WebAudioSoundInstance and WebAudioLoader.
	*/
	private static function _addPropsToClasses():Dynamic;
	
	/**
	* Try to unlock audio on iOS. This is triggered from either WebAudio plugin setup (which will work if inside of
	*	a `mousedown` or `touchend` event stack), or the first document touchend/mousedown event. If it fails (touchend
	*	will fail if the user presses for too long, indicating a scroll event instead of a click event.
	*	
	*	Note that earlier versions of iOS supported `touchstart` for this, but iOS9 removed this functionality. Adding
	*	a `touchstart` event to support older platforms may preclude a `mousedown` even from getting fired on iOS9, so we
	*	stick with `mousedown` and `touchend`.
	*/
	private function _unlock():Dynamic;
	
}
