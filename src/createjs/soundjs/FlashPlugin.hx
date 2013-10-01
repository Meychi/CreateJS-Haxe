package createjs.soundjs;

/**
* Play sounds using a Flash instance. This plugin is not used by default, and must be registered manually in
*	{{#crossLink "Sound"}}{{/crossLink}} using the {{#crossLink "Sound/registerPlugins"}}{{/crossLink}} method. This
*	plugin is recommended to be included if sound support is required in older browsers such as IE8.
*	
*	This plugin requires FlashAudioPlugin.swf and swfObject.js (which is compiled
*	into the minified FlashPlugin-X.X.X.min.js file. You must ensure that {{#crossLink "FlashPlugin/BASE_PATH:property"}}{{/crossLink}}
*	is set when using this plugin, so that the script can find the swf.
*	
*	<h4>Example</h4>
*	     createjs.FlashPlugin.BASE_PATH = "../src/SoundJS/";
*	     createjs.Sound.registerPlugins([createjs.WebAudioPlugin, createjs.HTMLAudioPlugin, createjs.FlashPlugin]);
*	     // Adds FlashPlugin as a fallback if WebAudio and HTMLAudio do not work.
*	
*	Note that the SWF is embedded into a container DIV (with an id and classname of "SoundJSFlashContainer"), and
*	will have an id of "flashAudioContainer". The container DIV is positioned 1 pixel off-screen to the left to avoid
*	showing the 1x1 pixel white square.
*	
*	<h4>Known Browser and OS issues for HTML Audio</h4>
*	<b>All browsers</b><br />
*	<ul><li> There can be a delay in flash player starting playback of audio.  This has been most noticeable in Firefox.
*	Unfortunely this is an issue with the flash player and therefore cannot be addressed by SoundJS.</li></ul>
*/
@:native("createjs.FlashPlugin")
extern class FlashPlugin
{
	/**
	* A developer flag to output all flash events to the console (if it exists).  Used for debugging.       createjs.Sound.activePlugin.showOutput = true;
	*/
	public var showOutput:Bool;
	
	/**
	* A hash of Sound Preload instances indexed by the related ID in Flash. This lookup is required to connect a preloading sound in Flash with its respective instance in JavaScript.
	*/
	private var flashPreloadInstances:Dynamic;
	
	/**
	* A hash of Sound Preload instances indexed by the src. This lookup is required to load sounds if internal preloading is tried when flash is not ready.
	*/
	private var preloadInstances:Dynamic;
	
	/**
	* A hash of SoundInstances indexed by the related ID in Flash. This lookup is required to connect sounds in JavaScript to their respective instances in Flash.
	*/
	private var flashInstances:Dynamic;
	
	/**
	* A reference to the DIV container that gets created to hold the Flash instance.
	*/
	private var container:HTMLDivElement;
	
	/**
	* A reference to the Flash instance that gets created.
	*/
	private var flash:Dynamic;
	
	/**
	* An array of Sound Preload instances that are waiting to preload. Once Flash is initialized, the queued instances are preloaded.
	*/
	private var queuedInstances:Dynamic;
	
	/**
	* An object hash indexed by ID that indicates if each source is loaded or loading.
	*/
	private var audioSources:Dynamic;
	
	/**
	* Determines if the Flash object has been created and initialized. This is required to make <code>ExternalInterface</code> calls from JavaScript to Flash.
	*/
	public var flashReady:Bool;
	
	/**
	* The build date for this release in UTC format.
	*/
	public static var buildDate:String;
	
	/**
	* The capabilities of the plugin. This is generated via the {{#crossLink "WebAudioPlugin/generateCapabilities"}}{{/crossLink}} method. Please see the Sound {{#crossLink "Sound/getCapabilities"}}{{/crossLink}} method for a list of available capabilities.
	*/
	public static var capabilities:Dynamic;
	
	/**
	* The id name of the DIV that gets created for Flash content.
	*/
	private var CONTAINER_ID:String;
	
	/**
	* The id name of the DIV wrapper that contains the Flash content.
	*/
	private var WRAPPER_ID:String;
	
	/**
	* The internal volume value of the plugin.
	*/
	private var volume:Float;
	
	/**
	* The path relative to the HTML page that the FlashAudioPlugin.swf resides. Note if this is not correct, this plugin will not work.
	*/
	public static var BASE_PATH:String;
	
	/**
	* The version string for this release.
	*/
	public static var version:String;
	
	/**
	* An initialization function run by the constructor
	*/
	private function init():Dynamic;
	
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
	* Handles error events from Flash. Note this function currently does not process any events.
	* @param error Indicates the error.
	*/
	public function handleErrorEvent(error:String):Dynamic;
	
	/**
	* Handles events from Flash and routes communication to a <code>Loader</code> via the Flash ID. The method
	*	and arguments from Flash are run directly on the sound loader.
	* @param flashId Used to identify the loader instance.
	* @param method Indicates the method to run.
	*/
	public function handlePreloadEvent(flashId:String, method:String):Dynamic;
	
	/**
	* Handles events from Flash intended for the FlashPlugin class. Currently only a "ready" event is processed.
	* @param method Indicates the method to run.
	*/
	public function handleEvent(method:String):Dynamic;
	
	/**
	* Handles events from Flash, and routes communication to a {{#crossLink "SoundInstance"}}{{/crossLink}} via
	*	the Flash ID. The method and arguments from Flash are run directly on the sound instance.
	* @param flashId Used to identify the SoundInstance.
	* @param method Indicates the method to run.
	*/
	public function handleSoundEvent(flashId:String, method:String):Dynamic;
	
	/**
	* Internal function used to set the gain value for master audio.  Should not be called externally.
	*/
	private function updateVolume():Bool;
	
	/**
	* Mute all sounds via the plugin.
	* @param value If all sound should be muted or not. Note that plugin-level muting just looks up
	*	the mute value of Sound {{#crossLink "Sound/getMute"}}{{/crossLink}}, so this property is not used here.
	*/
	public function setMute(value:Bool):Bool;
	
	/**
	* Play sounds using a Flash instance. This plugin is not used by default, and must be registered manually in
	*	{{#crossLink "Sound"}}{{/crossLink}} using the {{#crossLink "Sound/registerPlugins"}}{{/crossLink}} method. This
	*	plugin is recommended to be included if sound support is required in older browsers such as IE8.
	*	
	*	This plugin requires FlashAudioPlugin.swf and swfObject.js (which is compiled
	*	into the minified FlashPlugin-X.X.X.min.js file. You must ensure that {{#crossLink "FlashPlugin/BASE_PATH:property"}}{{/crossLink}}
	*	is set when using this plugin, so that the script can find the swf.
	*	
	*	<h4>Example</h4>
	*	     createjs.FlashPlugin.BASE_PATH = "../src/SoundJS/";
	*	     createjs.Sound.registerPlugins([createjs.WebAudioPlugin, createjs.HTMLAudioPlugin, createjs.FlashPlugin]);
	*	     // Adds FlashPlugin as a fallback if WebAudio and HTMLAudio do not work.
	*	
	*	Note that the SWF is embedded into a container DIV (with an id and classname of "SoundJSFlashContainer"), and
	*	will have an id of "flashAudioContainer". The container DIV is positioned 1 pixel off-screen to the left to avoid
	*	showing the 1x1 pixel white square.
	*	
	*	<h4>Known Browser and OS issues for HTML Audio</h4>
	*	<b>All browsers</b><br />
	*	<ul><li> There can be a delay in flash player starting playback of audio.  This has been most noticeable in Firefox.
	*	Unfortunely this is an issue with the flash player and therefore cannot be addressed by SoundJS.</li></ul>
	*/
	public function new():Void;
	
	/**
	* Pre-register a sound instance when preloading/setup. Note that the FlashPlugin will return a Loader
	*	instance for preloading since Flash can not access the browser cache consistently.
	* @param src The source of the audio
	* @param instances The number of concurrently playing instances to allow for the channel at any time.
	*/
	public function register(src:String, instances:Float):Dynamic;
	
	/**
	* Preload a sound instance. This plugin uses Flash to preload and play all sounds.
	* @param src The path to the Sound
	* @param instance Not used in this plugin.
	* @param basePath A file path to prepend to the src.
	*/
	public function preload(src:String, instance:Dynamic, basePath:String):Dynamic;
	
	/**
	* Remove a sound added using {{#crossLink "FlashPlugin/register"}}{{/crossLink}}. Note this does not cancel a
	*	preload.
	* @param src The sound URI to unload.
	*/
	public function removeSound(src:String):Dynamic;
	
	/**
	* Remove all sounds added using {{#crossLink "FlashPlugin/register"}}{{/crossLink}}. Note this does not cancel a preload.
	* @param src The sound URI to unload.
	*/
	public function removeAllSounds(src:String):Dynamic;
	
	/**
	* Set the master volume of the plugin, which affects all SoundInstances.
	* @param value The volume to set, between 0 and 1.
	*/
	public function setVolume(value:Float):Bool;
	
	/**
	* The callback when Flash does not initialize. This usually means the SWF is missing or incorrectly pathed.
	*/
	private function handleTimeout():Dynamic;
	
	/**
	* The Flash application that handles preloading and playback is ready. We wait for a callback from Flash to
	*	ensure that everything is in place before playback begins.
	*/
	private function handleFlashReady():Dynamic;
	
	/**
	* The SWF used for sound preloading and playback has been initialized.
	* @param event Contains a reference to the swf.
	*/
	private function handleSWFReady(event:Dynamic):Dynamic;
	
	/**
	* Used to couple a Flash loader instance with a <code>Loader</code> instance
	* @param flashId Used to identify the Loader.
	* @param instance The actual instance.
	*/
	public function registerPreloadInstance(flashId:String, instance:Dynamic):Dynamic;
	
	/**
	* Used to couple a Flash sound instance with a {{#crossLink "SoundInstance"}}{{/crossLink}}.
	* @param flashId Used to identify the SoundInstance.
	* @param instance The actual instance.
	*/
	public function registerSoundInstance(flashId:String, instance:Dynamic):Dynamic;
	
	/**
	* Used to decouple a <code>Loader</code> instance from Flash.
	* @param flashId Used to identify the Loader.
	*/
	public function unregisterPreloadInstance(flashId:String):Dynamic;
	
	/**
	* Used to decouple a {{#crossLink "SoundInstance"}}{{/crossLink}} from Flash.
	*	instance.
	* @param flashId Used to identify the SoundInstance.
	* @param instance The actual instance.
	*/
	public function unregisterSoundInstance(flashId:String, instance:Dynamic):Dynamic;
	
	/**
	* Used to output traces from Flash to the console, if {{#crossLink "FlashPlugin/showOutput"}}{{/crossLink}} is
	*	<code>true</code>.
	* @param data The information to be output.
	*/
	public function flashLog(data:String):Dynamic;
	
}
