package createjs.soundjs;

/**
* Play sounds using a Flash instance. This plugin is not used by default, and must be registered manually in
*	{{#crossLink "Sound"}}{{/crossLink}} using the {{#crossLink "Sound/registerPlugins"}}{{/crossLink}} method. This
*	plugin is recommended to be included if sound support is required in older browsers such as IE8.
*	
*	This plugin requires FlashAudioPlugin.swf and swfObject.js, which is compiled
*	into the minified FlashAudioPlugin-X.X.X.min.js file. You must ensure that {{#crossLink "FlashAudioPlugin/swfPath:property"}}{{/crossLink}}
*	is set when using this plugin, so that the script can find the swf.
*	
*	<h4>Example</h4>
*	
*	     createjs.FlashAudioPlugin.swfPath = "../src/soundjs/flashaudio";
*	     createjs.Sound.registerPlugins([createjs.WebAudioPlugin, createjs.HTMLAudioPlugin, createjs.FlashAudioPlugin]);
*	     // Adds FlashAudioPlugin as a fallback if WebAudio and HTMLAudio do not work.
*	
*	Note that the SWF is embedded into a container DIV (with an id and classname of "SoundJSFlashContainer"), and
*	will have an id of "flashAudioContainer". The container DIV is positioned 1 pixel off-screen to the left to avoid
*	showing the 1x1 pixel white square.
*	
*	<h4>Known Browser and OS issues for Flash Audio</h4>
*	<b>All browsers</b><br />
*	<ul><li> There can be a delay in flash player starting playback of audio.  This has been most noticeable in Firefox.
*	Unfortunely this is an issue with the flash player and the browser and therefore cannot be addressed by SoundJS.</li></ul>
*/
@:native("createjs.FlashAudioPlugin")
extern class FlashAudioPlugin extends AbstractPlugin
{
	/**
	* A developer flag to output all flash events to the console (if it exists).  Used for debugging.       createjs.Sound.activePlugin.showOutput = true;
	*/
	public var showOutput:Bool;
	
	/**
	* A hash of Sound Preload instances indexed by the related ID in Flash. This lookup is required to connect a preloading sound in Flash with its respective instance in JavaScript.
	*/
	private var _flashPreloadInstances:Dynamic;
	
	/**
	* A hash of SoundInstances indexed by the related ID in Flash. This lookup is required to connect sounds in JavaScript to their respective instances in Flash.
	*/
	private var _flashInstances:Dynamic;
	
	/**
	* A reference to the DIV container that gets created to hold the Flash instance.
	*/
	private var _container:HTMLDivElement;
	
	/**
	* A reference to the Flash instance that gets created.
	*/
	private var flash:Dynamic;
	
	/**
	* Determines if the Flash object has been created and initialized. This is required to make <code>ExternalInterface</code> calls from JavaScript to Flash.
	*/
	public var flashReady:Bool;
	
	/**
	* Event constant for the "registerFlashID" event for cleaner code.
	*/
	public static var _REG_FLASHID:String;
	
	/**
	* Event constant for the "unregisterFlashID" event for cleaner code.
	*/
	public static var _UNREG_FLASHID:String;
	
	/**
	* The build date for this release in UTC format.
	*/
	public static var buildDate:String;
	
	/**
	* The capabilities of the plugin. This is generated via the {{#crossLink "WebAudioPlugin/_generateCapabilities"}}{{/crossLink}} method. Please see the Sound {{#crossLink "Sound/getCapabilities"}}{{/crossLink}} method for a list of available capabilities.
	*/
	public static var _capabilities:Dynamic;
	
	/**
	* The id name of the DIV that gets created for Flash content.
	*/
	private var _CONTAINER_ID:String;
	
	/**
	* The id name of the DIV wrapper that contains the Flash content.
	*/
	private var _WRAPPER_ID:String;
	
	/**
	* The path relative to the HTML page that the FlashAudioPlugin.swf resides. Note if this is not correct, this plugin will not work.
	*/
	public static var swfPath:String;
	
	/**
	* The version string for this release.
	*/
	public static var version:String;
	
	/**
	* Determine if the plugin can be used in the current browser/OS.
	*/
	public static function isSupported():Bool;
	
	/**
	* Determine the capabilities of the plugin. Used internally. Please see the Sound API {{#crossLink "Sound/getCapabilities"}}{{/crossLink}}
	*	method for an overview of plugin capabilities.
	*/
	private static function _generateCapabilities():Dynamic;
	
	/**
	* Internal function used to set the gain value for master audio.  Should not be called externally.
	*/
	//private function _updateVolume():Bool;
	
	/**
	* Play sounds using a Flash instance. This plugin is not used by default, and must be registered manually in
	*	{{#crossLink "Sound"}}{{/crossLink}} using the {{#crossLink "Sound/registerPlugins"}}{{/crossLink}} method. This
	*	plugin is recommended to be included if sound support is required in older browsers such as IE8.
	*	
	*	This plugin requires FlashAudioPlugin.swf and swfObject.js, which is compiled
	*	into the minified FlashAudioPlugin-X.X.X.min.js file. You must ensure that {{#crossLink "FlashAudioPlugin/swfPath:property"}}{{/crossLink}}
	*	is set when using this plugin, so that the script can find the swf.
	*	
	*	<h4>Example</h4>
	*	
	*	     createjs.FlashAudioPlugin.swfPath = "../src/soundjs/flashaudio";
	*	     createjs.Sound.registerPlugins([createjs.WebAudioPlugin, createjs.HTMLAudioPlugin, createjs.FlashAudioPlugin]);
	*	     // Adds FlashAudioPlugin as a fallback if WebAudio and HTMLAudio do not work.
	*	
	*	Note that the SWF is embedded into a container DIV (with an id and classname of "SoundJSFlashContainer"), and
	*	will have an id of "flashAudioContainer". The container DIV is positioned 1 pixel off-screen to the left to avoid
	*	showing the 1x1 pixel white square.
	*	
	*	<h4>Known Browser and OS issues for Flash Audio</h4>
	*	<b>All browsers</b><br />
	*	<ul><li> There can be a delay in flash player starting playback of audio.  This has been most noticeable in Firefox.
	*	Unfortunely this is an issue with the flash player and the browser and therefore cannot be addressed by SoundJS.</li></ul>
	*/
	public function new():Void;
	
	/**
	* The Flash application that handles preloading and playback is ready. We wait for a callback from Flash to
	*	ensure that everything is in place before playback begins.
	*/
	private function _handleFlashReady():Dynamic;
	
	/**
	* The SWF used for sound preloading and playback has been initialized.
	* @param event Contains a reference to the swf.
	*/
	private function _handleSWFReady(event:Dynamic):Dynamic;
	
}
