package createjs.soundjs;

/**
* Play sounds using HTML &lt;audio&gt; tags in the browser. This plugin is the second priority plugin installed
*	by default, after the {{#crossLink "WebAudioPlugin"}}{{/crossLink}}.  For older browsers that do not support html
*	audio, include and install the {{#crossLink "FlashAudioPlugin"}}{{/crossLink}}.
*	
*	<h4>Known Browser and OS issues for HTML Audio</h4>
*	<b>All browsers</b><br />
*	Testing has shown in all browsers there is a limit to how many audio tag instances you are allowed.  If you exceed
*	this limit, you can expect to see unpredictable results. Please use {{#crossLink "Sound.MAX_INSTANCES"}}{{/crossLink}} as
*	a guide to how many total audio tags you can safely use in all browsers.  This issue is primarily limited to IE9.
*	
*	<b>IE html limitations</b><br />
*	<ul><li>There is a delay in applying volume changes to tags that occurs once playback is started. So if you have
*	muted all sounds, they will all play during this delay until the mute applies internally. This happens regardless of
*	when or how you apply the volume change, as the tag seems to need to play to apply it.</li>
*	<li>MP3 encoding will not always work for audio tags if it's not default.  We've found default encoding with
*	64kbps works.</li>
*	<li>Occasionally very short samples will get cut off.</li>
*	<li>There is a limit to how many audio tags you can load or play at once, which appears to be determined by
*	hardware and browser settings.  See {{#crossLink "HTMLAudioPlugin.MAX_INSTANCES"}}{{/crossLink}} for a safe estimate.
*	Note that audio sprites can be used as a solution to this issue.</li></ul>
*	
*	<b>Safari limitations</b><br />
*	<ul><li>Safari requires Quicktime to be installed for audio playback.</li></ul>
*	
*	<b>iOS 6 limitations</b><br />
*	<ul><li>can only have one &lt;audio&gt; tag</li>
*			<li>can not preload or autoplay the audio</li>
*			<li>can not cache the audio</li>
*			<li>can not play the audio except inside a user initiated event.</li>
*			<li>Note it is recommended to use {{#crossLink "WebAudioPlugin"}}{{/crossLink}} for iOS (6+)</li>
*			<li>audio sprites can be used to mitigate some of these issues and are strongly recommended on iOS</li>
*	</ul>
*	
*	<b>Android Native Browser limitations</b><br />
*	<ul><li>We have no control over audio volume. Only the user can set volume on their device.</li>
*	     <li>We can only play audio inside a user event (touch/click).  This currently means you cannot loop sound or use a delay.</li></ul>
*	<b> Android Chrome 26.0.1410.58 specific limitations</b><br />
*	<ul> <li>Can only play 1 sound at a time.</li>
*	     <li>Sound is not cached.</li>
*	     <li>Sound can only be loaded in a user initiated touch/click event.</li>
*	     <li>There is a delay before a sound is played, presumably while the src is loaded.</li>
*	</ul>
*	
*	See {{#crossLink "Sound"}}{{/crossLink}} for general notes on known issues.
*/
@:native("createjs.HTMLAudioPlugin")
extern class HTMLAudioPlugin extends AbstractPlugin
{
	/**
	* Event constant for the "canPlayThrough" event for cleaner code.
	*/
	public static var _AUDIO_READY:String;
	
	/**
	* Event constant for the "ended" event for cleaner code.
	*/
	public static var _AUDIO_ENDED:String;
	
	/**
	* Event constant for the "seeked" event for cleaner code.  We utilize this event for maintaining loop events.
	*/
	public static var _AUDIO_SEEKED:String;
	
	/**
	* Event constant for the "stalled" event for cleaner code.
	*/
	public static var _AUDIO_STALLED:String;
	
	/**
	* Event constant for the "timeupdate" event for cleaner code.  Utilized for looping audio sprites. This event callsback ever 15 to 250ms and can be dropped by the browser for performance.
	*/
	public static var _TIME_UPDATE:String;
	
	/**
	* The capabilities of the plugin. This is generated via the {{#crossLink "HTMLAudioPlugin/_generateCapabilities"}}{{/crossLink}} method. Please see the Sound {{#crossLink "Sound/getCapabilities"}}{{/crossLink}} method for an overview of all of the available properties.
	*/
	public static var _capabilities:Dynamic;
	
	/**
	* The maximum number of instances that can be loaded or played. This is a browser limitation, primarily limited to IE9. The actual number varies from browser to browser (and is largely hardware dependant), but this is a safe estimate. Audio sprites work around this limitation.
	*/
	public static var MAX_INSTANCES:Float;
	
	/**
	* This is no longer needed as we are now using object pooling for tags.  <b>NOTE this property only exists as a limitation of HTML audio.</b>
	*/
	public var defaultNumChannels:Float;
	
	/**
	* Determine if the plugin can be used in the current browser/OS. Note that HTML audio is available in most modern
	*	browsers, but is disabled in iOS because of its limitations.
	*/
	public static function isSupported():Bool;
	
	/**
	* Determine the capabilities of the plugin. Used internally. Please see the Sound API {{#crossLink "Sound/getCapabilities"}}{{/crossLink}}
	*	method for an overview of plugin capabilities.
	*/
	private static function _generateCapabilities():Dynamic;
	
	/**
	* Play sounds using HTML &lt;audio&gt; tags in the browser. This plugin is the second priority plugin installed
	*	by default, after the {{#crossLink "WebAudioPlugin"}}{{/crossLink}}.  For older browsers that do not support html
	*	audio, include and install the {{#crossLink "FlashAudioPlugin"}}{{/crossLink}}.
	*	
	*	<h4>Known Browser and OS issues for HTML Audio</h4>
	*	<b>All browsers</b><br />
	*	Testing has shown in all browsers there is a limit to how many audio tag instances you are allowed.  If you exceed
	*	this limit, you can expect to see unpredictable results. Please use {{#crossLink "Sound.MAX_INSTANCES"}}{{/crossLink}} as
	*	a guide to how many total audio tags you can safely use in all browsers.  This issue is primarily limited to IE9.
	*	
	*	<b>IE html limitations</b><br />
	*	<ul><li>There is a delay in applying volume changes to tags that occurs once playback is started. So if you have
	*	muted all sounds, they will all play during this delay until the mute applies internally. This happens regardless of
	*	when or how you apply the volume change, as the tag seems to need to play to apply it.</li>
	*	<li>MP3 encoding will not always work for audio tags if it's not default.  We've found default encoding with
	*	64kbps works.</li>
	*	<li>Occasionally very short samples will get cut off.</li>
	*	<li>There is a limit to how many audio tags you can load or play at once, which appears to be determined by
	*	hardware and browser settings.  See {{#crossLink "HTMLAudioPlugin.MAX_INSTANCES"}}{{/crossLink}} for a safe estimate.
	*	Note that audio sprites can be used as a solution to this issue.</li></ul>
	*	
	*	<b>Safari limitations</b><br />
	*	<ul><li>Safari requires Quicktime to be installed for audio playback.</li></ul>
	*	
	*	<b>iOS 6 limitations</b><br />
	*	<ul><li>can only have one &lt;audio&gt; tag</li>
	*			<li>can not preload or autoplay the audio</li>
	*			<li>can not cache the audio</li>
	*			<li>can not play the audio except inside a user initiated event.</li>
	*			<li>Note it is recommended to use {{#crossLink "WebAudioPlugin"}}{{/crossLink}} for iOS (6+)</li>
	*			<li>audio sprites can be used to mitigate some of these issues and are strongly recommended on iOS</li>
	*	</ul>
	*	
	*	<b>Android Native Browser limitations</b><br />
	*	<ul><li>We have no control over audio volume. Only the user can set volume on their device.</li>
	*	     <li>We can only play audio inside a user event (touch/click).  This currently means you cannot loop sound or use a delay.</li></ul>
	*	<b> Android Chrome 26.0.1410.58 specific limitations</b><br />
	*	<ul> <li>Can only play 1 sound at a time.</li>
	*	     <li>Sound is not cached.</li>
	*	     <li>Sound can only be loaded in a user initiated touch/click event.</li>
	*	     <li>There is a delay before a sound is played, presumably while the src is loaded.</li>
	*	</ul>
	*	
	*	See {{#crossLink "Sound"}}{{/crossLink}} for general notes on known issues.
	*/
	public function new():Void;
	
}
