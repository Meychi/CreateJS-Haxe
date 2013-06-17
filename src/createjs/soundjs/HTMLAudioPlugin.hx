package createjs.soundjs;

import js.html.Element;

/**
* Play sounds using HTML &lt;audio&gt; tags in the browser. This plugin is the second priority plugin installed
*	by default, after the {{#crossLink "WebAudioPlugin"}}{{/crossLink}}, which is supported on Chrome, Safari, and
*	iOS. This handles audio in all other modern browsers. For older browsers that do not support html audio, include
*	and install the {{#crossLink "FlashPlugin"}}{{/crossLink}}.
*	
*	<h4>Known Browser and OS issues for HTML Audio</h4>
*	<b>All browsers</b><br />
*	Testing has shown in all browsers there is a limit to how many audio tag instances you are allowed.  If you exceed
*	this limit, you can expect to see unpredictable results.  This will be seen as soon as you register sounds, as
*	tags are precreated to all Chrome to load them.  Please use {{#crossLink "Sound.MAX_INSTANCES"}}{{/crossLink}} as
*	a guide to how many total audio tags you can safely use in all browsers.
*	
*	<b>IE 9 html limitations</b><br />
*	<ul><li>There is a delay in applying volume changes to tags that occurs once playback is started. So if you have
*	muted all sounds, they will all play during this delay until the mute applies internally. This happens regardless of
*	when or how you apply the volume change, as the tag seems to need to play to apply it.</li>
*	<li>MP3 encoding will not always work for audio tags if it's not default.  We've found default encoding with
*	64kbps works.</li>
*	<li>There is a limit to how many audio tags you can load and play at once, which appears to be determined by
*	hardware and browser settings.  See {{#crossLink "HTMLAudioPlugin.MAX_INSTANCES"}}{{/crossLink}} for a safe estimate.</li></ul>
*	
*	<b>Safari limitations</b><br />
*	<ul><li>Safari requires Quicktime to be installed for audio playback.</li></ul>
*	
*	<b>iOS 6 limitations</b><br />
*	Note it is recommended to use {{#crossLink "WebAudioPlugin"}}{{/crossLink}} for iOS (6+). HTML Audio is disabled by
*	default as it can only have one &lt;audio&gt; tag, can not preload or autoplay the audio, can not cache the audio,
*	and can not play the audio except inside a user initiated event.
*	
*	<b>Android HTML Audio limitations</b><br />
*	<ul><li>We have no control over audio volume. Only the user can set volume on their device.</li>
*	     <li>We can only play audio inside a user event (touch/click).  This currently means you cannot loop sound or use a delay.</li>
*	<b> Android Chrome 26.0.1410.58 specific limitations</b><br />
*			<li>Chrome reports true when you run createjs.Sound.BrowserDetect.isChrome, but is a different browser
*	     with different abilities.</li>
*	     <li>Can only play 1 sound at a time.</li>
*	     <li>Sound is not cached.</li>
*	     <li>Sound can only be loaded in a user initiated touch/click event.</li>
*	     <li>There is a delay before a sound is played, presumably while the src is loaded.</li>
*	</ul>
*	
*	See {{#crossLink "Sound"}}{{/crossLink}} for general notes on known issues.
*/
@:native("createjs.HTMLAudioPlugin")
extern class HTMLAudioPlugin
{
	
	/**
	* Event constant for the "canPlayThrough" event for cleaner code.
	*/
	public static var AUDIO_READY:String;
	
	/**
	* Event constant for the "ended" event for cleaner code.
	*/
	public static var AUDIO_ENDED:String;
	
	/**
	* Event constant for the "error" event for cleaner code.
	*/
	public static var AUDIO_ERROR:String;
	
	/**
	* Event constant for the "seeked" event for cleaner code.  We utilize this event for maintaining loop events.
	*/
	public static var AUDIO_SEEKED:String;
	
	/**
	* Event constant for the "stalled" event for cleaner code.
	*/
	public static var AUDIO_STALLED:String;
	
	/**
	* Object hash indexed by the source of each file to indicate if an audio source is loaded, or loading.
	*/
	private var audioSources:Dynamic;
	
	/**
	* The capabilities of the plugin. This is generated via the the SoundInstance {{#crossLink "TMLAudioPlugin/generateCapabilities"}}{{/crossLink}} method. Please see the Sound {{#crossLink "Sound/getCapabilities"}}{{/crossLink}} method for an overview of all of the available properties.
	*/
	public static var capabilities:Dynamic;
	
	/**
	* The default number of instances to allow.  Passed back to {{#crossLink "Sound"}}{{/crossLink}} when a source is registered using the {{#crossLink "Sound/register"}}{{/crossLink}} method.  This is only used if a value is not provided.  <b>NOTE this property only exists as a limitation of HTML audio.</b>
	*/
	public var defaultNumChannels:Float;
	
	/**
	* The maximum number of instances that can be loaded and played. This is a browser limitation, primarily limited to IE9. The actual number varies from browser to browser (and is largely hardware dependant), but this is a safe estimate.
	*/
	public static var MAX_INSTANCES:Float;
	
	/**
	* An initialization function run by the constructor
	*/
	private function init():Dynamic;
	
	/**
	* Checks if preloading has started for a specific source.
	* @param src The sound URI to check.
	*/
	public function isPreloadStarted(src:String):Bool;
	
	/**
	* Create a sound instance. If the sound has not been preloaded, it is internally preloaded here.
	* @param src The sound source to use.
	*/
	public function create(src:String):SoundInstance;
	
	/**
	* Create an HTML audio tag.
	* @param src The source file to set for the audio tag.
	*/
	private function createTag(src:String):Element;
	
	/**
	* Determine if the plugin can be used in the current browser/OS. Note that HTML audio is available in most modern
	*	browsers, but is disabled in iOS because of its limitations.
	*/
	public static function isSupported():Bool;
	
	/**
	* Determine the capabilities of the plugin. Used internally. Please see the Sound API {{#crossLink "Sound/getCapabilities"}}{{/crossLink}}
	*	method for an overview of plugin capabilities.
	*/
	private static function generateCapabiities():Dynamic;
	
	/**
	* Internally preload a sound.
	* @param src The sound URI to load.
	* @param instance An object containing a tag property that is an HTML audio tag used to load src.
	*/
	public function preload(src:String, instance:Dynamic):Dynamic;
	
	/**
	* Play sounds using HTML &lt;audio&gt; tags in the browser. This plugin is the second priority plugin installed
	*	by default, after the {{#crossLink "WebAudioPlugin"}}{{/crossLink}}, which is supported on Chrome, Safari, and
	*	iOS. This handles audio in all other modern browsers. For older browsers that do not support html audio, include
	*	and install the {{#crossLink "FlashPlugin"}}{{/crossLink}}.
	*	
	*	<h4>Known Browser and OS issues for HTML Audio</h4>
	*	<b>All browsers</b><br />
	*	Testing has shown in all browsers there is a limit to how many audio tag instances you are allowed.  If you exceed
	*	this limit, you can expect to see unpredictable results.  This will be seen as soon as you register sounds, as
	*	tags are precreated to all Chrome to load them.  Please use {{#crossLink "Sound.MAX_INSTANCES"}}{{/crossLink}} as
	*	a guide to how many total audio tags you can safely use in all browsers.
	*	
	*	<b>IE 9 html limitations</b><br />
	*	<ul><li>There is a delay in applying volume changes to tags that occurs once playback is started. So if you have
	*	muted all sounds, they will all play during this delay until the mute applies internally. This happens regardless of
	*	when or how you apply the volume change, as the tag seems to need to play to apply it.</li>
	*	<li>MP3 encoding will not always work for audio tags if it's not default.  We've found default encoding with
	*	64kbps works.</li>
	*	<li>There is a limit to how many audio tags you can load and play at once, which appears to be determined by
	*	hardware and browser settings.  See {{#crossLink "HTMLAudioPlugin.MAX_INSTANCES"}}{{/crossLink}} for a safe estimate.</li></ul>
	*	
	*	<b>Safari limitations</b><br />
	*	<ul><li>Safari requires Quicktime to be installed for audio playback.</li></ul>
	*	
	*	<b>iOS 6 limitations</b><br />
	*	Note it is recommended to use {{#crossLink "WebAudioPlugin"}}{{/crossLink}} for iOS (6+). HTML Audio is disabled by
	*	default as it can only have one &lt;audio&gt; tag, can not preload or autoplay the audio, can not cache the audio,
	*	and can not play the audio except inside a user initiated event.
	*	
	*	<b>Android HTML Audio limitations</b><br />
	*	<ul><li>We have no control over audio volume. Only the user can set volume on their device.</li>
	*	     <li>We can only play audio inside a user event (touch/click).  This currently means you cannot loop sound or use a delay.</li>
	*	<b> Android Chrome 26.0.1410.58 specific limitations</b><br />
	*			<li>Chrome reports true when you run createjs.Sound.BrowserDetect.isChrome, but is a different browser
	*	     with different abilities.</li>
	*	     <li>Can only play 1 sound at a time.</li>
	*	     <li>Sound is not cached.</li>
	*	     <li>Sound can only be loaded in a user initiated touch/click event.</li>
	*	     <li>There is a delay before a sound is played, presumably while the src is loaded.</li>
	*	</ul>
	*	
	*	See {{#crossLink "Sound"}}{{/crossLink}} for general notes on known issues.
	*/
	public function new():Void;
	
	/**
	* Pre-register a sound instance when preloading/setup. This is called by {{#crossLink "Sound"}}{{/crossLink}}.
	*	Note that this provides an object containing a tag used for preloading purposes, which
	*	<a href="http://preloadjs.com">PreloadJS</a> can use to assist with preloading.
	* @param src The source of the audio
	* @param instances The number of concurrently playing instances to allow for the channel at any time.
	*/
	public function register(src:String, instances:Float):Dynamic;
	
	/**
	* Remove a sound added using {{#crossLink "HTMLAudioPlugin/register"}}{{/crossLink}}. Note this does not cancel
	*	a preload.
	* @param src The sound URI to unload.
	*/
	public function removeSound(src:String):Dynamic;
	
	/**
	* Remove all sounds added using {{#crossLink "HTMLAudioPlugin/register"}}{{/crossLink}}. Note this does not cancel a preload.
	* @param src The sound URI to unload.
	*/
	public function removeAllSounds(src:String):Dynamic;
}
