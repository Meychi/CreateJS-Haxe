package createjs.soundjs;

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
*	<ul><li>mp3 audio files do not load properly on all windows machines, reported
*	<a href="https://bugzilla.mozilla.org/show_bug.cgi?id=929969" target="_blank">here</a>. </br>
*	For this reason it is recommended to pass another FF supported type (ie ogg) first until this bug is resolved, if possible.</li></ul>
*	<br />
*	<b>Webkit (Chrome and Safari)</b>
*	<ul><li>AudioNode.disconnect does not always seem to work.  This can cause the file size to grow over time if you
*	are playing a lot of audio files.</li></ul>
*	<br />
*	<b>iOS 6 limitations</b>
*		<ul><li>Sound is initially muted and will only unmute through play being called inside a user initiated event (touch/click).</li>
*		<li>A bug exists that will distort uncached audio when a video element is present in the DOM.  You can avoid this bug
*		by ensuring the audio and video audio share the same sampleRate.</li>
*	</ul>
*/
@:native("createjs.WebAudioPlugin")
extern class WebAudioPlugin
{
	/**
	* A DynamicsCompressorNode, which is used to improve sound quality and prevent audio distortion. It is connected to <code>context.destination</code>.
	*/
	public var dynamicsCompressorNode:AudioNode;
	
	/**
	* A GainNode for controlling master _volume. It is connected to {{#crossLink "WebAudioPlugin/dynamicsCompressorNode:property"}}{{/crossLink}}.
	*/
	public var gainNode:GainNode;
	
	/**
	* An object hash used internally to store ArrayBuffers, indexed by the source URI used  to load it. This prevents having to load and decode audio files more than once. If a load has been started on a file, <code>arrayBuffers[src]</code> will be set to true. Once load is complete, it is set the the loaded ArrayBuffer instance.
	*/
	private var _arrayBuffers:Dynamic;
	
	/**
	* The capabilities of the plugin. This is generated via the {{#crossLink "WebAudioPlugin/_generateCapabilities:method"}}{{/crossLink}} method and is used internally.
	*/
	public static var _capabilities:Dynamic;
	
	/**
	* The internal master volume value of the plugin.
	*/
	private var _volume:Float;
	
	/**
	* The web audio context, which WebAudio uses to play audio. All nodes that interact with the WebAudioPlugin need to be created within this context.
	*/
	public var context:AudioContext;
	
	/**
	* Value to set panning model to equal power for SoundInstance.  Can be "equalpower" or 0 depending on browser implementation.
	*/
	private var _panningModel:Dynamic;
	
	/**
	* Add loaded results to the preload object hash.
	* @param src The sound URI to unload.
	*/
	public function addPreloadResults(src:String):Bool;
	
	/**
	* An initialization function run by the constructor
	*/
	private function _init():Dynamic;
	
	/**
	* Checks if preloading has finished for a specific source.
	* @param src The sound URI to load.
	*/
	public function isPreloadComplete(src:String):Bool;
	
	/**
	* Checks if preloading has started for a specific source. If the source is found, we can assume it is loading,
	*	or has already finished loading.
	* @param src The sound URI to check.
	*/
	public function isPreloadStarted(src:String):Bool;
	
	/**
	* Create a sound instance. If the sound has not been preloaded, it is internally preloaded here.
	* @param src The sound source to use.
	*/
	public function create(src:String):SoundInstance;
	
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
	* Get the master volume of the plugin, which affects all SoundInstances.
	*/
	public function getVolume():Dynamic;
	
	/**
	* Handles internal preload completion.
	*/
	private function _handlePreloadComplete():Dynamic;
	
	/**
	* Internally preload a sound. Loading uses XHR2 to load an array buffer for use with WebAudio.
	* @param src The sound URI to load.
	* @param instance Not used in this plugin.
	*/
	public function preload(src:String, instance:Dynamic):Dynamic;
	
	/**
	* Mute all sounds via the plugin.
	* @param value If all sound should be muted or not. Note that plugin-level muting just looks up
	*	the mute value of Sound {{#crossLink "Sound/getMute"}}{{/crossLink}}, so this property is not used here.
	*/
	public function setMute(value:Bool):Bool;
	
	/**
	* Play sounds using Web Audio in the browser. The WebAudioPlugin is currently the default plugin, and will be used
	*	anywhere that it is supported. To change plugin priority, check out the Sound API
	*	{{#crossLink "Sound/registerPlugins"}}{{/crossLink}} method.
	*	
	*	<h4>Known Browser and OS issues for Web Audio</h4>
	*	<b>Firefox 25</b>
	*	<ul><li>mp3 audio files do not load properly on all windows machines, reported
	*	<a href="https://bugzilla.mozilla.org/show_bug.cgi?id=929969" target="_blank">here</a>. </br>
	*	For this reason it is recommended to pass another FF supported type (ie ogg) first until this bug is resolved, if possible.</li></ul>
	*	<br />
	*	<b>Webkit (Chrome and Safari)</b>
	*	<ul><li>AudioNode.disconnect does not always seem to work.  This can cause the file size to grow over time if you
	*	are playing a lot of audio files.</li></ul>
	*	<br />
	*	<b>iOS 6 limitations</b>
	*		<ul><li>Sound is initially muted and will only unmute through play being called inside a user initiated event (touch/click).</li>
	*		<li>A bug exists that will distort uncached audio when a video element is present in the DOM.  You can avoid this bug
	*		by ensuring the audio and video audio share the same sampleRate.</li>
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
	public function playEmptySound():Dynamic;
	
	/**
	* Pre-register a sound for preloading and setup. This is called by {{#crossLink "Sound"}}{{/crossLink}}.
	*	Note that WebAudio provides a <code>Loader</code> instance, which <a href="http://preloadjs.com" target="_blank">PreloadJS</a>
	*	can use to assist with preloading.
	* @param src The source of the audio
	* @param instances The number of concurrently playing instances to allow for the channel at any time.
	*	Note that the WebAudioPlugin does not manage this property.
	*/
	public function register(src:String, instances:Float):Dynamic;
	
	/**
	* Remove a sound added using {{#crossLink "WebAudioPlugin/register"}}{{/crossLink}}. Note this does not cancel a preload.
	* @param src The sound URI to unload.
	*/
	public function removeSound(src:String):Dynamic;
	
	/**
	* Remove all sounds added using {{#crossLink "WebAudioPlugin/register"}}{{/crossLink}}. Note this does not cancel a preload.
	* @param src The sound URI to unload.
	*/
	public function removeAllSounds(src:String):Dynamic;
	
	/**
	* Set the gain value for master audio. Should not be called externally.
	*/
	private function _updateVolume():Dynamic;
	
	/**
	* Set the master volume of the plugin, which affects all SoundInstances.
	* @param value The volume to set, between 0 and 1.
	*/
	public function setVolume(value:Float):Bool;
	
	/**
	* Set up compatibility if only deprecated web audio calls are supported.
	*	See http://www.w3.org/TR/webaudio/#DeprecationNotes
	*	Needed so we can support new browsers that don't support deprecated calls (Firefox) as well as old browsers that
	*	don't support new calls.
	*/
	private function _compatibilitySetUp():Dynamic;
	
}
