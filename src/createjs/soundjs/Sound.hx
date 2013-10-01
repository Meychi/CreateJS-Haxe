package createjs.soundjs;

/**
* The Sound class is the public API for creating sounds, controlling the overall sound levels, and managing plugins.
*	All Sound APIs on this class are static.
*	
*	<b>Registering and Preloading</b><br />
*	Before you can play a sound, it <b>must</b> be registered. You can do this with {{#crossLink "Sound/registerSound"}}{{/crossLink}},
*	or register multiple sounds using {{#crossLink "Sound/registerManifest"}}{{/crossLink}}. If you don't register a
*	sound prior to attempting to play it using {{#crossLink "Sound/play"}}{{/crossLink}} or create it using {{#crossLink "Sound/createInstance"}}{{/crossLink}},
*	the sound source will be automatically registered but playback will fail as the source will not be ready. If you use
*	<a href="http://preloadjs.com" target="_blank">PreloadJS</a>, this is handled for you when the sound is
*	preloaded. It is recommended to preload sounds either internally using the register functions or externally using
*	PreloadJS so they are ready when you want to use them.
*	
*	<b>Playback</b><br />
*	To play a sound once it's been registered and preloaded, use the {{#crossLink "Sound/play"}}{{/crossLink}} method.
*	This method returns a {{#crossLink "SoundInstance"}}{{/crossLink}} which can be paused, resumed, muted, etc.
*	Please see the {{#crossLink "SoundInstance"}}{{/crossLink}} documentation for more on the instance control APIs.
*	
*	<b>Plugins</b><br />
*	By default, the {{#crossLink "WebAudioPlugin"}}{{/crossLink}} or the {{#crossLink "HTMLAudioPlugin"}}{{/crossLink}}
*	are used (when available), although developers can change plugin priority or add new plugins (such as the
*	provided {{#crossLink "FlashPlugin"}}{{/crossLink}}). Please see the {{#crossLink "Sound"}}{{/crossLink}} API
*	methods for more on the playback and plugin APIs. To install plugins, or specify a different plugin order, see
*	{{#crossLink "Sound/installPlugins"}}{{/crossLink}}.
*	
*	<h4>Example</h4>
*	     createjs.Sound.registerPlugins([createjs.WebAudioPlugin, createjs.FlashPlugin]);
*	     createjs.Sound.addEventListener("fileload", createjs.proxy(this.loadHandler, (this));
*	     createjs.Sound.registerSound("path/to/mySound.mp3|path/to/mySound.ogg", "sound");
*	     function loadHandler(event) {
*	         // This is fired for each sound that is registered.
*	         var instance = createjs.Sound.play("sound");  // play using id.  Could also use full source path or event.src.
*	         instance.addEventListener("complete", createjs.proxy(this.handleComplete, this));
*	         instance.volume = 0.5;
*	     }
*	
*	The maximum number of concurrently playing instances of the same sound can be specified in the "data" argument
*	of {{#crossLink "Sound/registerSound"}}{{/crossLink}}.  Note that if not specified, the active plugin will apply
*	a default limit.  Currently HTMLAudioPlugin sets a default limit of 2, while WebAudioPlugin and FlashPlugin set a
*	default limit of 100.
*	
*	     createjs.Sound.registerSound("sound.mp3", "soundId", 4);
*	
*	Sound can be used as a plugin with PreloadJS to help preload audio properly. Audio preloaded with PreloadJS is
*	automatically registered with the Sound class. When audio is not preloaded, Sound will do an automatic internal
*	load. As a result, it may not play immediately the first time play is called. Use the
*	{{#crossLink "Sound/fileload"}}{{/crossLink}} event to determine when a sound has finished internally preloading.
*	It is recommended that all audio is preloaded before it is played.
*	
*	     createjs.PreloadJS.installPlugin(createjs.Sound);
*	
*	<b>Mobile Safe Approach</b><br />
*	Mobile devices require sounds to be played inside of a user initiated event (touch/click) in varying degrees.
*	As of SoundJS 0.4.1, you can launch a site inside of a user initiated event and have audio playback work. To
*	enable as broadly as possible, the site needs to setup the Sound plugin in its initialization (for example via
*	<code>createjs.Sound.initializeDefaultPlugins();</code>), and all sounds need to be played in the scope of the
*	application.  See the MobileSafe demo for a working example.
*	
*	<h4>Example</h4>
*	    document.getElementById("status").addEventListener("click", handleTouch, false);    // works on Android and iPad
*	    function handleTouch(event) {
*	      document.getElementById("status").removeEventListener("click", handleTouch, false);    // remove the listener
*	      var thisApp = new myNameSpace.MyApp();    // launch the app
*	    }
*	
*	<h4>Known Browser and OS issues</h4>
*	<b>IE 9 HTML Audio limitations</b><br />
*	<ul><li>There is a delay in applying volume changes to tags that occurs once playback is started. So if you have
*	muted all sounds, they will all play during this delay until the mute applies internally. This happens regardless of
*	when or how you apply the volume change, as the tag seems to need to play to apply it.</li>
*	<li>MP3 encoding will not always work for audio tags, particularly in Internet Explorer. We've found default
*	encoding with 64kbps works.</li>
*	<li>There is a limit to how many audio tags you can load and play at once, which appears to be determined by
*	hardware and browser settings.  See {{#crossLink "HTMLAudioPlugin.MAX_INSTANCES"}}{{/crossLink}} for a safe estimate.</li></ul>
*	
*	<b>Safari limitations</b><br />
*	<ul><li>Safari requires Quicktime to be installed for audio playback.</li></ul>
*	
*	<b>iOS 6 Web Audio limitations</b><br />
*	<ul><li>Sound is initially muted and will only unmute through play being called inside a user initiated event
*	(touch/click).</li>
*	<li>Despite suggestions to the opposite, we have control over audio volume through our gain nodes.</li>
*	<li>A bug exists that will distort un-cached web audio when a video element is present in the DOM.</li>
*	<li>Note HTMLAudioPlugin is not supported on iOS by default.  See {{#crossLink "HTMLAudioPlugin"}}{{/crossLink}}
*	for more details.<li>
*	</ul>
*	
*	<b>Android HTML Audio limitations</b><br />
*	<ul><li>We have no control over audio volume. Only the user can set volume on their device.</li>
*	<li>We can only play audio inside a user event (touch/click).  This currently means you cannot loop sound or use
*	a delay.</li></ul>
*	
*	<b>Android HTML Audio Chrome 26.0.1410.58+ specific limitations</b><br />
*	<ul><li>Chrome reports true when you run createjs.Sound.BrowserDetect.isChrome, but is a different browser
*	with different abilities.</li>
*	<li>Can only play 1 sound at a time.</li>
*	<li>Sound is not cached.</li>
*	<li>Sound can only be loaded in a user initiated touch/click event.</li>
*	<li>There is a delay before a sound is played, presumably while the src is loaded.</li>
*	</ul>
*/
@:native("createjs.Sound")
extern class Sound
{
	/**
	* A list of the default supported extensions that Sound will <i>try</i> to play. Plugins will check if the browser can play these types, so modifying this list before a plugin is initialized will allow the plugins to try to support additional media types.  NOTE this does not currently work for {{#crossLink "FlashPlugin"}}{{/crossLink}}.  More details on file formats can be found at http://en.wikipedia.org/wiki/Audio_file_format. A very detailed list of file formats can be found at http://www.fileinfo.com/filetypes/audio. A useful list of extensions for each format can be found at http://html5doctor.com/html5-audio-the-state-of-play/
	*/
	public var SUPPORTED_EXTENSIONS:Array<String>;
	
	/**
	* An array containing all currently playing instances. This allows Sound to control the volume, mute, and playback of all instances when using static APIs like {{#crossLink "Sound/stop"}}{{/crossLink}} and {{#crossLink "Sound/setVolume"}}{{/crossLink}}. When an instance has finished playback, it gets removed via the {{#crossLink "Sound/finishedPlaying"}}{{/crossLink}} method. If the user replays an instance, it gets added back in via the {{#crossLink "Sound/beginPlaying"}}{{/crossLink}} method.
	*/
	public static var instances:Array<Dynamic>;
	
	/**
	* An object hash storing sound sources via there corresponding ID.
	*/
	public static var idHash:Dynamic;
	
	/**
	* An object hash that stores preloading sound sources via the parsed source that is passed to the plugin.  Contains the source, id, and data that was passed in by the user.  Parsed sources can contain multiple instances of source, id, and data.
	*/
	public static var preloadHash:Dynamic;
	
	/**
	* An object that stands in for audio that fails to play. This allows developers to continue to call methods on the failed instance without having to check if it is valid first. The instance is instantiated once, and shared to keep the memory footprint down.
	*/
	public static var defaultSoundInstance:Dynamic;
	
	/**
	* Defines the playState of an instance that completed playback.
	*/
	public static var PLAY_FINISHED:String;
	
	/**
	* Defines the playState of an instance that failed to play. This is usually caused by a lack of available channels when the interrupt mode was "INTERRUPT_NONE", the playback stalled, or the sound could not be found.
	*/
	public static var PLAY_FAILED:String;
	
	/**
	* Defines the playState of an instance that is currently playing or paused.
	*/
	public static var PLAY_SUCCEEDED:String;
	
	/**
	* Defines the playState of an instance that is still initializing.
	*/
	public static var PLAY_INITED:String;
	
	/**
	* Defines the playState of an instance that was interrupted by another instance.
	*/
	public static var PLAY_INTERRUPTED:String;
	
	/**
	* Determines if the plugins have been registered. If false, the first call to play() will instantiate the default plugins ({{#crossLink "WebAudioPlugin"}}{{/crossLink}}, followed by {{#crossLink "HTMLAudioPlugin"}}{{/crossLink}}). If plugins have been registered, but none are applicable, then sound playback will fail.
	*/
	public static var pluginsRegistered:Bool;
	
	/**
	* Determines the default behavior for interrupting other currently playing instances with the same source, if the maximum number of instances of the sound are already playing.  Currently the default is {{#crossLink "Sound/INTERRUPT_NONE:property"}}{{/crossLink}} but this can be set and will change playback behavior accordingly.  This is only used when {{#crossLink "Sound/play"}}{{/crossLink}} is called without passing a value for interrupt.
	*/
	public static var defaultInterruptBehavior:String;
	
	
	/**
	* Some extensions use another type of extension support to play (one of them is a codex).  This allows you to map that support so plugins can accurately determine if an extension is supported.  Adding to this list can help plugins determine more accurately if an extension is supported.
	*/
	public var EXTENSION_MAP:Dynamic;
	
	/**
	* The character (or characters) that are used to split multiple paths from an audio source.
	*/
	public static var DELIMITER:String;
	
	/**
	* The currently active plugin. If this is null, then no plugin could be initialized. If no plugin was specified, Sound attempts to apply the default plugins: {{#crossLink "WebAudioPlugin"}}{{/crossLink}}, followed by {{#crossLink "HTMLAudioPlugin"}}{{/crossLink}}.
	*/
	public static var activePlugin:Dynamic;
	
	/**
	* The duration in milliseconds to determine a timeout.
	*/
	public static var AUDIO_TIMEOUT:Float;
	
	/**
	* The interrupt value to interrupt any currently playing instance with the same source, if the maximum number of instances of the sound are already playing.
	*/
	public static var INTERRUPT_ANY:String;
	
	/**
	* The interrupt value to interrupt the currently playing instance with the same source that progressed the most distance in the audio track, if the maximum number of instances of the sound are already playing.
	*/
	public static var INTERRUPT_LATE:String;
	
	/**
	* The interrupt value to interrupt the earliest currently playing instance with the same source that progressed the least distance in the audio track, if the maximum number of instances of the sound are already playing.
	*/
	public static var INTERRUPT_EARLY:String;
	
	/**
	* The interrupt value to not interrupt any currently playing instances with the same source, if the maximum number of instances of the sound are already playing.
	*/
	public static var INTERRUPT_NONE:String;
	
	/**
	* The master mute value, which affects all sounds.  This is applies to all sound instances.  This value can be set through {{#crossLink "Sound/setMute"}}{{/crossLink}} and accessed via {{#crossLink "Sound/getMute"}}{{/crossLink}}.
	*/
	public static var masterMute:Bool;
	
	/**
	* The master volume value, which affects all sounds. Use {{#crossLink "Sound/getVolume"}}{{/crossLink}} and {{#crossLink "Sound/setVolume"}}{{/crossLink}} to modify the volume of all audio.
	*/
	private var masterVolume:Float;
	
	/**
	* The RegExp pattern used to parse file URIs. This supports simple file names, as well as full domain URIs with query strings. The resulting match is: protocol:$1 domain:$2 path:$3 file:$4 extension:$5 query:$6.
	*/
	public static var FILE_PATTERN:EReg;
	
	/**
	* Used internally to assign unique IDs to each SoundInstance.
	*/
	public static var lastID:Float;
	
	/**
	* A sound has completed playback, been interrupted, failed, or been stopped. This method removes the instance from
	*	Sound management. It will be added again, if the sound re-plays. Note that this method is called from the
	*	instances themselves.
	* @param instance The instance that finished playback.
	*/
	private static function playFinished(instance:SoundInstance):Dynamic;
	
	/**
	* Begin playback. This is called immediately or after delay by {{#crossLink "Sound/playInstance"}}{{/crossLink}}.
	* @param instance A {{#crossLink "SoundInstance"}}{{/crossLink}} to begin playback.
	* @param interrupt How this sound interrupts other instances with the same source. Defaults to
	*	{{#crossLink "Sound/INTERRUPT_NONE:property"}}{{/crossLink}}. Interrupts are defined as <code>INTERRUPT_TYPE</code>
	*	constants on Sound.
	* @param offset Time in milliseconds into the sound to begin playback.  Defaults to the current value on
	*	the instance.
	* @param loop The number of times to loop the audio. Use 0 for no loops, and -1 for an infinite loop.
	* @param volume The volume of the sound between 0 and 1. Defaults to the current value on the instance.
	* @param pan The pan of the sound between -1 and 1. Defaults to current instance value.
	*/
	private static function beginPlaying(instance:SoundInstance, ?interrupt:String, ?offset:Float, ?loop:Float, ?volume:Float, ?pan:Float):Bool;
	
	/**
	* Check if a source has been loaded by internal preloaders. This is necessary to ensure that sounds that are
	*	not completed preloading will not kick off a new internal preload if they are played.
	*	
	*	<h4>Example</h4>
	*	    var mySound = "assetPath/asset0.mp3|assetPath/asset0.ogg";
	*	    if(createjs.Sound.loadComplete(mySound) {
	*	        createjs.Sound.play(mySound);
	*	    }
	* @param src The src or id that is being loaded.
	*/
	public function loadComplete(src:String):Bool;
	
	/**
	* Creates a {{#crossLink "SoundInstance"}}{{/crossLink}} using the passed in src. If the src does not have a
	*	supported extension or if there is no available plugin, a {{#crossLink "Sound/defaultSoundInstance:property"}}{{/crossLink}}
	*	will be returned that can be called safely but does nothing.
	*	
	*	<h4>Example</h4>
	*	     var myInstance = null;
	*	     createjs.Sound.addEventListener("fileload", handleLoad);
	*	     createjs.Sound.registerSound("myAudioPath/mySound.mp3", "myID", 3);
	*	     function handleLoad(event) {
	*	     	myInstance = createjs.Sound.createInstance("myID");
	*	     	// alternately we could call the following
	*	     	myInstance = createjs.Sound.createInstance("myAudioPath/mySound.mp3");
	*	     }
	* @param src The src or ID of the audio.
	*/
	public function createInstance(src:String):SoundInstance;
	
	/**
	* Determines if Sound has been initialized, and a plugin has been activated.
	*	
	*	<h4>Example</h4>
	*	This example sets up a Flash fallback, but only if there is no plugin specified yet.
	*	
	*	     if (!createjs.Sound.isReady()) {
	*				createjs.FlashPlugin.BASE_PATH = "../src/SoundJS/";
	*	     	createjs.Sound.registerPlugins([createjs.WebAudioPlugin, createjs.HTMLAudioPlugin, createjs.FlashPlugin]);
	*	     }
	*/
	public static function isReady():Bool;
	
	/**
	* Get a specific capability of the active plugin. See {{#crossLink "Sound/getCapabilities"}}{{/crossLink}} for a
	*	full list of capabilities.
	*	
	*	<h4>Example</h4>
	*	     var maxAudioInstances = createjs.Sound.getCapability("tracks");
	* @param key The capability to retrieve
	*/
	public static function getCapability(key:String):Dynamic;
	
	/**
	* Get the active plugins capabilities, which help determine if a plugin can be used in the current environment,
	*	or if the plugin supports a specific feature. Capabilities include:
	*	<ul>
	*	    <li><b>panning:</b> If the plugin can pan audio from left to right</li>
	*	    <li><b>volume;</b> If the plugin can control audio volume.</li>
	*	    <li><b>mp3:</b> If MP3 audio is supported.</li>
	*	    <li><b>ogg:</b> If OGG audio is supported.</li>
	*	    <li><b>wav:</b> If WAV audio is supported.</li>
	*	    <li><b>mpeg:</b> If MPEG audio is supported.</li>
	*	    <li><b>m4a:</b> If M4A audio is supported.</li>
	*	    <li><b>mp4:</b> If MP4 audio is supported.</li>
	*	    <li><b>aiff:</b> If aiff audio is supported.</li>
	*	    <li><b>wma:</b> If wma audio is supported.</li>
	*	    <li><b>mid:</b> If mid audio is supported.</li>
	*	    <li><b>tracks:</b> The maximum number of audio tracks that can be played back at a time. This will be -1
	*	    if there is no known limit.</li>
	*/
	public static function getCapabilities():Dynamic;
	
	/**
	* Get the master volume of Sound. The master volume is multiplied against each sound's individual volume.
	*	To get individual sound volume, use SoundInstance {{#crossLink "SoundInstance/volume"}}{{/crossLink}} instead.
	*	
	*	<h4>Example</h4>
	*	    var masterVolume = createjs.Sound.getVolume();
	*/
	public static function getVolume():Float;
	
	/**
	* Get the preload rules to allow Sound to be used as a plugin by <a href="http://preloadjs.com" target="_blank">PreloadJS</a>.
	*	Any load calls that have the matching type or extension will fire the callback method, and use the resulting
	*	object, which is potentially modified by Sound. This helps when determining the correct path, as well as
	*	registering the audio instance(s) with Sound. This method should not be called, except by PreloadJS.
	*/
	private static function getPreloadHandlers():Dynamic;
	
	/**
	* Get the source of a sound via the ID passed in with a register call. If no ID is found the value is returned
	*	instead.
	* @param value The ID the sound was registered with.
	*/
	private static function getSrcById(value:String):String;
	
	/**
	* Initialize the default plugins. This method is automatically called when any audio is played or registered before
	*	the user has manually registered plugins, and enables Sound to work without manual plugin setup. Currently, the
	*	default plugins are {{#crossLink "WebAudioPlugin"}}{{/crossLink}} followed by {{#crossLink "HTMLAudioPlugin"}}{{/crossLink}}.
	*	
	*	 * <h4>Example</h4>
	*	     if (!createjs.initializeDefaultPlugins()) { return; }
	*/
	public static function initializeDefaultPlugins():Bool;
	
	/**
	* Mute/Unmute all audio. Note that muted audio still plays at 0 volume. This global mute value is maintained
	*	separately and when set will override, but not change the mute property of individual instances. To mute an individual
	*	instance, use SoundInstance {{#crossLink "SoundInstance/setMute"}}{{/crossLink}} instead.
	*	
	*	<h4>Example</h4>
	*	    createjs.Sound.setMute(true);
	* @param value Whether the audio should be muted or not.
	*/
	public static function setMute(value:Bool):Bool;
	
	/**
	* Parse the path of a sound, usually from a manifest item. Manifest items support single file paths, as well as
	*	composite paths using {{#crossLink "Sound/DELIMITER:property"}}{{/crossLink}}, which defaults to "|". The first path supported by the
	*	current browser/plugin will be used.
	* @param value The path to an audio source.
	* @param type The type of path. This will typically be "sound" or null.
	* @param id The user-specified sound ID. This may be null, in which case the src will be used instead.
	* @param data Arbitrary data appended to the sound, usually denoting the
	*	number of channels for the sound. This method doesn't currently do anything with the data property.
	*/
	private function parsePath(value:String, ?type:String, ?id:String, ?data:Dynamic):Dynamic;
	
	/**
	* Play a sound and get a {{#crossLink "SoundInstance"}}{{/crossLink}} to control. If the sound fails to play, a
	*	SoundInstance will still be returned, and have a playState of {{#crossLink "Sound/PLAY_FAILED:property"}}{{/crossLink}}.
	*	Note that even on sounds with failed playback, you may still be able to call SoundInstance {{#crossLink "SoundInstance/play"}}{{/crossLink}},
	*	since the failure could be due to lack of available channels. If the src does not have a supported extension or
	*	if there is no available plugin, {{#crossLink "Sound/defaultSoundInstance:property"}}{{/crossLink}} will be
	*	returned, which will not play any audio, but will not generate errors.
	*	
	*	<h4>Example</h4>
	*	     createjs.Sound.addEventListener("fileload", handleLoad);
	*	     createjs.Sound.registerSound("myAudioPath/mySound.mp3", "myID", 3);
	*	     function handleLoad(event) {
	*	     	createjs.Sound.play("myID");
	*	     	// alternately we could call the following
	*	     	var myInstance = createjs.Sound.play("myAudioPath/mySound.mp3", createjs.Sound.INTERRUPT_ANY, 0, 0, -1, 1, 0);
	*	     	// another alternative is to pass in just the options we want to set inside of an object
	*	     	var myInstance = createjs.Sound.play("myAudioPath/mySound.mp3", {interrupt: createjs.Sound.INTERRUPT_ANY, loop:-1});
	*	     }
	* @param src The src or ID of the audio.
	* @param interrupt How to interrupt any currently playing instances of audio with the same source,
	*	if the maximum number of instances of the sound are already playing. Values are defined as <code>INTERRUPT_TYPE</code>
	*	constants on the Sound class, with the default defined by {{#crossLink "Sound/defaultInterruptBehavior:property"}}{{/crossLink}}.
	*	<br /><strong>OR</strong><br />
	*	This parameter can be an object that contains any or all optional properties by name, including: interrupt,
	*	delay, offset, loop, volume, and pan (see the above code sample).
	* @param delay The amount of time to delay the start of audio playback, in milliseconds.
	* @param offset The offset from the start of the audio to begin playback, in milliseconds.
	* @param loop How many times the audio loops when it reaches the end of playback. The default is 0 (no
	*	loops), and -1 can be used for infinite playback.
	* @param volume The volume of the sound, between 0 and 1. Note that the master volume is applied
	*	against the individual volume.
	* @param pan The left-right pan of the sound (if supported), between -1 (left) and 1 (right).
	*/
	public static function play(src:String, ?interrupt:Dynamic, ?delay:Float, ?offset:Float, ?loop:Float, ?volume:Float, ?pan:Float):SoundInstance;
	
	/**
	* Play an instance. This is called by the static API, as well as from plugins. This allows the core class to
	*	control delays.
	* @param instance The {{#crossLink "SoundInstance"}}{{/crossLink}} to start playing.
	* @param interrupt How to interrupt any currently playing instances of audio with the same source,
	*	if the maximum number of instances of the sound are already playing. Values are defined as <code>INTERRUPT_TYPE</code>
	*	constants on the Sound class, with the default defined by {{#crossLink "Sound/defaultInterruptBehavior"}}{{/crossLink}}.
	*	<br /><strong>OR</strong><br />
	*	This parameter can be an object that contains any or all optional properties by name, including: interrupt,
	*	delay, offset, loop, volume, and pan (see the above code sample).
	* @param delay Time in milliseconds before playback begins.
	* @param offset Time into the sound to begin playback in milliseconds.  Defaults to the
	*	current value on the instance.
	* @param loop The number of times to loop the audio. Use 0 for no loops, and -1 for an infinite loop.
	* @param volume The volume of the sound between 0 and 1. Defaults to current instance value.
	* @param pan The pan of the sound between -1 and 1. Defaults to current instance value.
	*/
	private static function playInstance(instance:SoundInstance, ?interrupt:Dynamic, ?delay:Float, ?offset:Float, ?loop:Float, ?volume:Float, ?pan:Float):Bool;
	
	/**
	* Process manifest items from <a href="http://preloadjs.com" target="_blank">PreloadJS</a>. This method is intended
	*	for usage by a plugin, and not for direct interaction.
	* @param src The src or object to load. This is usually a string path, but can also be an
	*	HTMLAudioElement or similar audio playback object.
	* @param type The type of object. Will likely be "sound" or null.
	* @param id An optional user-specified id that is used to play sounds.
	* @param data Data associated with the item. Sound uses the data parameter as the
	*	number of channels for an audio instance, however a "channels" property can be appended to the data object if
	*	this property is used for other information. The audio channels will default to 1 if no value is found.
	*/
	private static function initLoad(src:Dynamic, ?type:String, ?id:String, ?data:Dynamic):Dynamic;
	
	/**
	* Register a list of Sound plugins, in order of precedence. To register a single plugin, use
	*	{{#crossLink "Sound/registerPlugin"}}{{/crossLink}}.
	*	
	*	<h4>Example</h4>
	*	     createjs.FlashPlugin.BASE_PATH = "../src/SoundJS/";
	*	     createjs.Sound.registerPlugins([createjs.WebAudioPlugin, createjs.HTMLAudioPlugin, createjs.FlashPlugin]);
	* @param plugins An array of plugins classes to install.
	*/
	public static function registerPlugins(plugins:Array<Dynamic>):Bool;
	
	/**
	* Register a manifest of audio files for loading and future playback in Sound. It is recommended to register all
	*	sounds that need to be played back in order to properly prepare and preload them. Sound does internal preloading
	*	when required.
	*	
	*	<h4>Example</h4>
	*	     var manifest = [
	*	         {src:"asset0.mp3|asset0.ogg", id:"example"}, // Note the Sound.DELIMITER '|'
	*	         {src:"asset1.mp3|asset1.ogg", id:"1", data:6},
	*	         {src:"asset2.mp3", id:"works"}
	*	     ];
	*	     createjs.Sound.addEventListener("fileload", handleLoad); // call handleLoad when each sound loads
	*	     createjs.Sound.registerManifest(manifest, assetPath);
	* @param manifest An array of objects to load. Objects are expected to be in the format needed for
	*	{{#crossLink "Sound/registerSound"}}{{/crossLink}}: <code>{src:srcURI, id:ID, data:Data, preload:UseInternalPreloader}</code>
	*	with "id", "data", and "preload" being optional.
	* @param basePath Set a path that will be prepending to each src when loading.
	*/
	public static function registerManifest(manifest:Array<Dynamic>, basePath:String):Dynamic;
	
	/**
	* Register a Sound plugin. Plugins handle the actual playback of audio. The default plugins are
	*	({{#crossLink "WebAudioPlugin"}}{{/crossLink}} followed by {{#crossLink "HTMLAudioPlugin"}}{{/crossLink}}),
	*	and are installed if no other plugins are present when the user attempts to start playback or register sound.
	*	<h4>Example</h4>
	*	     createjs.FlashPlugin.BASE_PATH = "../src/SoundJS/";
	*	     createjs.Sound.registerPlugin(createjs.FlashPlugin);
	*	
	*	To register multiple plugins, use {{#crossLink "Sound/registerPlugins"}}{{/crossLink}}.
	* @param plugin The plugin class to install.
	*/
	public static function registerPlugin(plugin:Dynamic):Bool;
	
	/**
	* Register an audio file for loading and future playback in Sound. This is automatically called when using
	*	<a href="http://preloadjs.com" target="_blank">PreloadJS</a>.  It is recommended to register all sounds that
	*	need to be played back in order to properly prepare and preload them. Sound does internal preloading when required.
	*	
	*	<h4>Example</h4>
	*	     createjs.Sound.addEventListener("fileload", handleLoad); // add an event listener for when load is completed
	*	     createjs.Sound.registerSound("myAudioPath/mySound.mp3|myAudioPath/mySound.ogg", "myID", 3);
	* @param src The source or an Objects with a "src" property
	* @param id An id specified by the user to play the sound later.
	* @param data Data associated with the item. Sound uses the data parameter as the number of
	*	channels for an audio instance, however a "channels" property can be appended to the data object if it is used
	*	for other information. The audio channels will set a default based on plugin if no value is found.
	* @param preload If the sound should be internally preloaded so that it can be played back
	*	without an external preloader.
	* @param basePath Set a path that will be prepending to src for loading.
	*/
	public static function registerSound(src:Dynamic, ?id:String, ?data:Dynamic, ?preload:Bool, ?basePath:String):Dynamic;
	
	/**
	* Remove a manifest of audio files that have been registered with {{#crossLink "Sound/registerSound"}}{{/crossLink}} or
	*	{{#crossLink "Sound/registerManifest"}}{{/crossLink}}.
	*	Note this will stop playback on active instances playing this audio before deleting them.
	*	Note if you passed in a basePath, you do not need to pass it or add it to the src here.
	*	
	*	<h4>Example</h4>
	*	     var manifest = [
	*	         {src:"asset0.mp3|asset0.ogg", id:"example"}, // Note the Sound.DELIMITER '|'
	*	         {src:"asset1.mp3|asset1.ogg", id:"1", data:6},
	*	         {src:"asset2.mp3", id:"works"}
	*	     ];
	*	     createjs.Sound.removeManifest(manifest);
	* @param manifest An array of objects to remove. Objects are expected to be in the format needed for
	*	{{#crossLink "Sound/removeSound"}}{{/crossLink}}: <code>{srcOrID:srcURIorID}</code>
	*/
	public static function removeManifest(manifest:Array<Dynamic>):Dynamic;
	
	/**
	* Remove a sound that has been registered with {{#crossLink "Sound/registerSound"}}{{/crossLink}} or
	*	{{#crossLink "Sound/registerManifest"}}{{/crossLink}}.
	*	Note this will stop playback on active instances playing this sound before deleting them.
	*	Note if you passed in a basePath, you do not need to pass it or add assetPath to the src here.
	*	
	*	<h4>Example</h4>
	*	     createjs.Sound.removeSound("myAudioPath/mySound.mp3|myAudioPath/mySound.ogg");
	*	     createjs.Sound.removeSound("myID");
	* @param src The src or ID of the audio, or an Object with a "src" property
	*/
	public static function removeSound(src:Dynamic):Bool;
	
	/**
	* Remove all sounds that have been registered with {{#crossLink "Sound/registerSound"}}{{/crossLink}} or
	*	{{#crossLink "Sound/registerManifest"}}{{/crossLink}}.
	*	Note this will stop playback on all active sound instances before deleting them.
	*	
	*	<h4>Example</h4>
	*	    createjs.Sound.removeAllSounds();
	*/
	public static function removeAllSounds():Dynamic;
	
	
	/**
	* Returns the global mute value. To get the mute value of an individual instance, use SoundInstance
	*	{{#crossLink "SoundInstance/getMute"}}{{/crossLink}} instead.
	*	
	*	<h4>Example</h4>
	*	    var masterMute = createjs.Sound.getMute();
	*/
	public static function getMute():Bool;
	
	/**
	* Set the master volume of Sound. The master volume is multiplied against each sound's individual volume.  For
	*	example, if master volume is 0.5 and a sound's volume is 0.5, the resulting volume is 0.25. To set individual
	*	sound volume, use SoundInstance {{#crossLink "SoundInstance/setVolume"}}{{/crossLink}} instead.
	*	
	*	<h4>Example</h4>
	*	    createjs.Sound.setVolume(0.5);
	* @param value The master volume value. The acceptable range is 0-1.
	*/
	public static function setVolume(value:Float):Dynamic;
	
	/**
	* Stop all audio (global stop). Stopped audio is reset, and not paused. To play audio that has been stopped,
	*	call {{#crossLink "SoundInstance.play"}}{{/crossLink}}.
	*	
	*	<h4>Example</h4>
	*	    createjs.Sound.stop();
	*/
	public static function stop():Dynamic;
	
	/**
	* Used by external plugins to dispatch file load events.
	* @param src A sound file has completed loading, and should be dispatched.
	*/
	private static function sendFileLoadEvent(src:String):Dynamic;
	
}
