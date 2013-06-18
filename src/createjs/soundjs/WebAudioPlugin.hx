package createjs.soundjs;

import js.html.audio.AudioContext;
import js.html.audio.AudioNode;
import js.html.audio.GainNode;

/**
* Play sounds using Web Audio in the browser. The WebAudio plugin has been successfully tested with:
*	<ul><li>Google Chrome, version 23+ on OS X and Windows</li>
*	     <li>Safari 6+ on OS X</li>
*	     <li>Mobile Safari on iOS 6+</li>
*	</ul>
*	
*	The WebAudioPlugin is currently the default plugin, and will be used anywhere that it is supported. Currently
*	Chrome and Safari offer support.  Firefox and Android Chrome both offer support for web audio in upcoming
*	releases.  To change plugin priority, check out the Sound API {{#crossLink "Sound/registerPlugins"}}{{/crossLink}} method.
*	
*	<h4>Known Browser and OS issues for Web Audio Plugin</h4>
*	<b>Webkit (Chrome and Safari)</b><br />
*	<ul><li>AudioNode.disconnect does not always seem to work.  This can cause the file size to grow over time if you
*	are playing a lot of audio files.</li>
*	
*	<b>iOS 6 limitations</b><br />
*	<ul><li>Sound is initially muted and will only unmute through play being called inside a user initiated event (touch/click).</li>
*	     <li>Despite suggestions to the opposite, we have relative control over audio volume through the gain nodes.</li>
*			<li>A bug exists that will distort uncached audio when a video element is present in the DOM.</li>
*	</ul>
*/
@:native("createjs.WebAudioPlugin")
extern class WebAudioPlugin
{
	/**
	* A DynamicsCompressorNode, which is used to improve sound quality and prevent audio distortion according to http://www.w3.org/TR/webaudio/#DynamicsCompressorNode. It is connected to <code>context.destination</code>.
	*/
	public var dynamicsCompressorNode:AudioNode;
	
	/**
	* A GainNode for controlling master volume. It is connected to <code>dynamicsCompressorNode</code>.
	*/
	public var gainNode:AudioGainNode;
	
	/**
	* An object hash used internally to store ArrayBuffers, indexed by the source URI used  to load it. This prevents having to load and decode audio files more than once. If a load has been started on a file, <code>arrayBuffers[src]</code> will be set to true. Once load is complete, it is set the the loaded ArrayBuffer instance.
	*/
	private var arrayBuffers:Dynamic;
	
	/**
	* The capabilities of the plugin. This is generated via the <code>"WebAudioPlugin/generateCapabilities</code> method and is used internally.
	*/
	public static var capabilities:Dynamic;
	
	/**
	* The internal volume value of the plugin.
	*/
	private var volume:Float;
	
	/**
	* The web audio context, which WebAudio uses to play audio. All nodes that interact with the WebAudioPlugin need to be created within this context.
	*/
	public var context:AudioContext;
	
	/**
	* Add loaded results to the preload object hash.
	* @param src The sound URI to unload.
	*/
	public function addPreloadResults(src:String):Bool;
	
	/**
	* An initialization function run by the constructor
	*/
	private function init():Dynamic;
	
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
	* Determine the capabilities of the plugin. Used internally. Please see the Sound API {{#crossLink "Sound/getCapabilities"}}{{/crossLink}}
	*	method for an overview of plugin capabilities.
	*/
	private static function generateCapabiities():Dynamic;
	
	/**
	* Get the master volume of the plugin, which affects all SoundInstances.
	*/
	public function getVolume():Dynamic;
	
	/**
	* Handles internal preload completion.
	*/
	private function handlePreloadComplete():Dynamic;
	
	/**
	* Internally preload a sound. Loading uses XHR2 to load an array buffer for use with WebAudio.
	* @param src The sound URI to load.
	* @param instance Not used in this plugin.
	*/
	private function preload(src:String, instance:Dynamic):Dynamic;
	
	/**
	* Mute all sounds via the plugin.
	* @param value If all sound should be muted or not. Note that plugin-level muting just looks up
	*	the mute value of Sound {{#crossLink "Sound/getMute"}}{{/crossLink}}, so this property is not used here.
	*/
	public function setMute(value:Bool):Bool;
	
	/**
	* Play sounds using Web Audio in the browser. The WebAudio plugin has been successfully tested with:
	*	<ul><li>Google Chrome, version 23+ on OS X and Windows</li>
	*	     <li>Safari 6+ on OS X</li>
	*	     <li>Mobile Safari on iOS 6+</li>
	*	</ul>
	*	
	*	The WebAudioPlugin is currently the default plugin, and will be used anywhere that it is supported. Currently
	*	Chrome and Safari offer support.  Firefox and Android Chrome both offer support for web audio in upcoming
	*	releases.  To change plugin priority, check out the Sound API {{#crossLink "Sound/registerPlugins"}}{{/crossLink}} method.
	*	
	*	<h4>Known Browser and OS issues for Web Audio Plugin</h4>
	*	<b>Webkit (Chrome and Safari)</b><br />
	*	<ul><li>AudioNode.disconnect does not always seem to work.  This can cause the file size to grow over time if you
	*	are playing a lot of audio files.</li>
	*	
	*	<b>iOS 6 limitations</b><br />
	*	<ul><li>Sound is initially muted and will only unmute through play being called inside a user initiated event (touch/click).</li>
	*	     <li>Despite suggestions to the opposite, we have relative control over audio volume through the gain nodes.</li>
	*			<li>A bug exists that will distort uncached audio when a video element is present in the DOM.</li>
	*	</ul>
	*/
	public function new():Void;
	
	/**
	* Plays an empty sound in the web audio context.  This is used to enable web audio on iOS devices, as they
	*	require the first sound to be played inside of a user initiated event (touch/click).  This is called when
	*	{{#crossLink "WebAudioPlugin"}}{{/crossLink}} is initialized (by {{#crossLink "Sound/initializeDefaultPlugins"}}{{/crossLink}}
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
	*	Note that WebAudio provides a <code>WebAudioLoader</code> instance, which <a href="http://preloadjs.com">PreloadJS</a>
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
	* Remove a source from our preload list. Note this does not cancel a preload.
	* @param src The sound URI to unload.
	*/
	public function removeFromPreload(src:String):Dynamic;
	
	/**
	* Remove all sounds added using {{#crossLink "WebAudioPlugin/register"}}{{/crossLink}}. Note this does not cancel a preload.
	* @param src The sound URI to unload.
	*/
	public function removeAllSounds(src:String):Dynamic;
	
	/**
	* Set the gain value for master audio. Should not be called externally.
	*/
	private function updateVolume():Dynamic;
	
	/**
	* Set the master volume of the plugin, which affects all SoundInstances.
	* @param value The volume to set, between 0 and 1.
	*/
	public function setVolume(value:Float):Bool;
	
}
