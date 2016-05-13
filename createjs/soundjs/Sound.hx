package createjs.soundjs;

/**
* The Sound class is the public API for creating sounds, controlling the overall sound levels, and managing plugins.
*	All Sound APIs on this class are static.
*	
*	<b>Registering and Preloading</b><br />
*	Before you can play a sound, it <b>must</b> be registered. You can do this with {{#crossLink "Sound/registerSound"}}{{/crossLink}},
*	or register multiple sounds using {{#crossLink "Sound/registerSounds"}}{{/crossLink}}. If you don't register a
*	sound prior to attempting to play it using {{#crossLink "Sound/play"}}{{/crossLink}} or create it using {{#crossLink "Sound/createInstance"}}{{/crossLink}},
*	the sound source will be automatically registered but playback will fail as the source will not be ready. If you use
*	<a href="http://preloadjs.com" target="_blank">PreloadJS</a>, registration is handled for you when the sound is
*	preloaded. It is recommended to preload sounds either internally using the register functions or externally using
*	PreloadJS so they are ready when you want to use them.
*	
*	<b>Playback</b><br />
*	To play a sound once it's been registered and preloaded, use the {{#crossLink "Sound/play"}}{{/crossLink}} method.
*	This method returns a {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} which can be paused, resumed, muted, etc.
*	Please see the {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} documentation for more on the instance control APIs.
*	
*	<b>Plugins</b><br />
*	By default, the {{#crossLink "WebAudioPlugin"}}{{/crossLink}} or the {{#crossLink "HTMLAudioPlugin"}}{{/crossLink}}
*	are used (when available), although developers can change plugin priority or add new plugins (such as the
*	provided {{#crossLink "FlashAudioPlugin"}}{{/crossLink}}). Please see the {{#crossLink "Sound"}}{{/crossLink}} API
*	methods for more on the playback and plugin APIs. To install plugins, or specify a different plugin order, see
*	{{#crossLink "Sound/installPlugins"}}{{/crossLink}}.
*	
*	<h4>Example</h4>
*	
*	     createjs.FlashAudioPlugin.swfPath = "../src/soundjs/flashaudio";
*	     createjs.Sound.registerPlugins([createjs.WebAudioPlugin, createjs.FlashAudioPlugin]);
*	     createjs.Sound.alternateExtensions = ["mp3"];
*	     createjs.Sound.on("fileload", this.loadHandler, this);
*	     createjs.Sound.registerSound("path/to/mySound.ogg", "sound");
*	     function loadHandler(event) {
*	         // This is fired for each sound that is registered.
*	         var instance = createjs.Sound.play("sound");  // play using id.  Could also use full source path or event.src.
*	         instance.on("complete", this.handleComplete, this);
*	         instance.volume = 0.5;
*	     }
*	
*	The maximum number of concurrently playing instances of the same sound can be specified in the "data" argument
*	of {{#crossLink "Sound/registerSound"}}{{/crossLink}}.  Note that if not specified, the active plugin will apply
*	a default limit.  Currently HTMLAudioPlugin sets a default limit of 2, while WebAudioPlugin and FlashAudioPlugin set a
*	default limit of 100.
*	
*	     createjs.Sound.registerSound("sound.mp3", "soundId", 4);
*	
*	Sound can be used as a plugin with PreloadJS to help preload audio properly. Audio preloaded with PreloadJS is
*	automatically registered with the Sound class. When audio is not preloaded, Sound will do an automatic internal
*	load. As a result, it may fail to play the first time play is called if the audio is not finished loading. Use
*	the {{#crossLink "Sound/fileload:event"}}{{/crossLink}} event to determine when a sound has finished internally
*	preloading. It is recommended that all audio is preloaded before it is played.
*	
*	     var queue = new createjs.LoadQueue();
*			queue.installPlugin(createjs.Sound);
*	
*	<b>Audio Sprites</b><br />
*	SoundJS has added support for {{#crossLink "AudioSprite"}}{{/crossLink}}, available as of version 0.6.0.
*	For those unfamiliar with audio sprites, they are much like CSS sprites or sprite sheets: multiple audio assets
*	grouped into a single file.
*	
*	<h4>Example</h4>
*	
*			var assetsPath = "./assets/";
*			var sounds = [{
*				src:"MyAudioSprite.ogg", data: {
*					audioSprite: [
*						{id:"sound1", startTime:0, duration:500},
*						{id:"sound2", startTime:1000, duration:400},
*						{id:"sound3", startTime:1700, duration: 1000}
*					]}
*				}
*			];
*			createjs.Sound.alternateExtensions = ["mp3"];
*			createjs.Sound.on("fileload", loadSound);
*			createjs.Sound.registerSounds(sounds, assetsPath);
*			// after load is complete
*			createjs.Sound.play("sound2");
*	
*	<b>Mobile Playback</b><br />
*	Devices running iOS require the WebAudio context to be "unlocked" by playing at least one sound inside of a user-
*	initiated event (such as touch/click). Earlier versions of SoundJS included a "MobileSafe" sample, but this is no
*	longer necessary as of SoundJS 0.6.2.
*	<ul>
*	    <li>
*	        In SoundJS 0.4.1 and above, you can either initialize plugins or use the {{#crossLink "WebAudioPlugin/playEmptySound"}}{{/crossLink}}
*	        method in the call stack of a user input event to manually unlock the audio context.
*	    </li>
*	    <li>
*	        In SoundJS 0.6.2 and above, SoundJS will automatically listen for the first document-level "mousedown"
*	        and "touchend" event, and unlock WebAudio. This will continue to check these events until the WebAudio
*	        context becomes "unlocked" (changes from "suspended" to "running")
*	    </li>
*	    <li>
*	        Both the "mousedown" and "touchend" events can be used to unlock audio in iOS9+, the "touchstart" event
*	        will work in iOS8 and below. The "touchend" event will only work in iOS9 when the gesture is interpreted
*	        as a "click", so if the user long-presses the button, it will no longer work.
*	    </li>
*	    <li>
*	        When using the <a href="http://www.createjs.com/docs/easeljs/classes/Touch.html">EaselJS Touch class</a>,
*	        the "mousedown" event will not fire when a canvas is clicked, since MouseEvents are prevented, to ensure
*	        only touch events fire. To get around this, you can either rely on "touchend", or:
*	        <ol>
*	            <li>Set the `allowDefault` property on the Touch class constructor to `true` (defaults to `false`).</li>
*	            <li>Set the `preventSelection` property on the EaselJS `Stage` to `false`.</li>
*	        </ol>
*	        These settings may change how your application behaves, and are not recommended.
*	    </li>
*	</ul>
*	
*	<b>Loading Alternate Paths and Extension-less Files</b><br />
*	SoundJS supports loading alternate paths and extension-less files by passing an object instead of a string for
*	the `src` property, which is a hash using the format `{extension:"path", extension2:"path2"}`. These labels are
*	how SoundJS determines if the browser will support the sound. This also enables multiple formats to live in
*	different folders, or on CDNs, which often has completely different filenames for each file.
*	
*	Priority is determined by the property order (first property is tried first).  This is supported by both internal loading
*	and loading with PreloadJS.
*	
*	<em>Note: an id is required for playback.</em>
*	
*	<h4>Example</h4>
*	
*			var sounds = {path:"./audioPath/",
*					manifest: [
*					{id: "cool", src: {mp3:"mp3/awesome.mp3", ogg:"noExtensionOggFile"}}
*			]};
*	
*			createjs.Sound.alternateExtensions = ["mp3"];
*			createjs.Sound.addEventListener("fileload", handleLoad);
*			createjs.Sound.registerSounds(sounds);
*	
*	<h3>Known Browser and OS issues</h3>
*	<b>IE 9 HTML Audio limitations</b><br />
*	<ul><li>There is a delay in applying volume changes to tags that occurs once playback is started. So if you have
*	muted all sounds, they will all play during this delay until the mute applies internally. This happens regardless of
*	when or how you apply the volume change, as the tag seems to need to play to apply it.</li>
*	<li>MP3 encoding will not always work for audio tags, particularly in Internet Explorer. We've found default
*	encoding with 64kbps works.</li>
*	<li>Occasionally very short samples will get cut off.</li>
*	<li>There is a limit to how many audio tags you can load and play at once, which appears to be determined by
*	hardware and browser settings.  See {{#crossLink "HTMLAudioPlugin.MAX_INSTANCES"}}{{/crossLink}} for a safe
*	estimate.</li></ul>
*	
*	<b>Firefox 25 Web Audio limitations</b>
*	<ul><li>mp3 audio files do not load properly on all windows machines, reported
*	<a href="https://bugzilla.mozilla.org/show_bug.cgi?id=929969" target="_blank">here</a>. </br>
*	For this reason it is recommended to pass another FF supported type (ie ogg) first until this bug is resolved, if
*	possible.</li></ul>
*	
*	<b>Safari limitations</b><br />
*	<ul><li>Safari requires Quicktime to be installed for audio playback.</li></ul>
*	
*	<b>iOS 6 Web Audio limitations</b><br />
*	<ul><li>Sound is initially locked, and must be unlocked via a user-initiated event. Please see the section on
*	Mobile Playback above.</li>
*	<li>A bug exists that will distort un-cached web audio when a video element is present in the DOM that has audio
*	at a different sampleRate.</li>
*	</ul>
*	
*	<b>Android HTML Audio limitations</b><br />
*	<ul><li>We have no control over audio volume. Only the user can set volume on their device.</li>
*	<li>We can only play audio inside a user event (touch/click).  This currently means you cannot loop sound or use
*	a delay.</li></ul>
*	
*	<b>Web Audio and PreloadJS</b><br />
*	<ul><li>Web Audio must be loaded through XHR, therefore when used with PreloadJS, tag loading is not possible.
*	This means that tag loading can not be used to avoid cross domain issues.</li><ul>
*/
@:native("createjs.Sound")
extern class Sound
{
	/**
	* A list of the default supported extensions that Sound will <i>try</i> to play. Plugins will check if the browser can play these types, so modifying this list before a plugin is initialized will allow the plugins to try to support additional media types.  NOTE this does not currently work for {{#crossLink "FlashAudioPlugin"}}{{/crossLink}}.  More details on file formats can be found at <a href="http://en.wikipedia.org/wiki/Audio_file_format" target="_blank">http://en.wikipedia.org/wiki/Audio_file_format</a>.<br /> A very detailed list of file formats can be found at <a href="http://www.fileinfo.com/filetypes/audio" target="_blank">http://www.fileinfo.com/filetypes/audio</a>.
	*/
	public static var SUPPORTED_EXTENSIONS:Array<String>;
	
	/**
	* An array containing all currently playing instances. This allows Sound to control the volume, mute, and playback of all instances when using static APIs like {{#crossLink "Sound/stop"}}{{/crossLink}} and {{#crossLink "Sound/setVolume"}}{{/crossLink}}. When an instance has finished playback, it gets removed via the {{#crossLink "Sound/finishedPlaying"}}{{/crossLink}} method. If the user replays an instance, it gets added back in via the {{#crossLink "Sound/_beginPlaying"}}{{/crossLink}} method.
	*/
	public static var _instances:Array<Dynamic>;
	
	/**
	* An array of extensions to attempt to use when loading sound, if the default is unsupported by the active plugin. These are applied in order, so if you try to Load Thunder.ogg in a browser that does not support ogg, and your extensions array is ["mp3", "m4a", "wav"] it will check mp3 support, then m4a, then wav. The audio files need to exist in the same location, as only the extension is altered.  Note that regardless of which file is loaded, you can call {{#crossLink "Sound/createInstance"}}{{/crossLink}} and {{#crossLink "Sound/play"}}{{/crossLink}} using the same id or full source path passed for loading.  <h4>Example</h4>  	var sounds = [ 		{src:"myPath/mySound.ogg", id:"example"}, 	]; 	createjs.Sound.alternateExtensions = ["mp3"]; // now if ogg is not supported, SoundJS will try asset0.mp3 	createjs.Sound.on("fileload", handleLoad); // call handleLoad when each sound loads 	createjs.Sound.registerSounds(sounds, assetPath); 	// ... 	createjs.Sound.play("myPath/mySound.ogg"); // works regardless of what extension is supported.  Note calling with ID is a better approach
	*/
	public static var alternateExtensions:Array<Dynamic>;
	
	/**
	* An object hash storing objects with sound sources, startTime, and duration via there corresponding ID.
	*/
	public static var _idHash:Dynamic;
	
	/**
	* An object hash storing {{#crossLink "PlayPropsConfig"}}{{/crossLink}} via the parsed source that is passed as defaultPlayProps in {{#crossLink "Sound/registerSound"}}{{/crossLink}} and {{#crossLink "Sound/registerSounds"}}{{/crossLink}}.
	*/
	public static var _defaultPlayPropsHash:Dynamic;
	
	/**
	* An object hash that stores preloading sound sources via the parsed source that is passed to the plugin.  Contains the source, id, and data that was passed in by the user.  Parsed sources can contain multiple instances of source, id, and data.
	*/
	public static var _preloadHash:Dynamic;
	
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
	public static var _pluginsRegistered:Bool;
	
	/**
	* Determines the default behavior for interrupting other currently playing instances with the same source, if the maximum number of instances of the sound are already playing.  Currently the default is {{#crossLink "Sound/INTERRUPT_NONE:property"}}{{/crossLink}} but this can be set and will change playback behavior accordingly.  This is only used when {{#crossLink "Sound/play"}}{{/crossLink}} is called without passing a value for interrupt.
	*/
	public static var defaultInterruptBehavior:String;
	
	/**
	* Get the active plugins capabilities, which help determine if a plugin can be used in the current environment, or if the plugin supports a specific feature. Capabilities include: <ul>     <li><b>panning:</b> If the plugin can pan audio from left to right</li>     <li><b>volume;</b> If the plugin can control audio volume.</li>     <li><b>tracks:</b> The maximum number of audio tracks that can be played back at a time. This will be -1     if there is no known limit.</li> <br />An entry for each file type in {{#crossLink "Sound/SUPPORTED_EXTENSIONS:property"}}{{/crossLink}}:     <li><b>mp3:</b> If MP3 audio is supported.</li>     <li><b>ogg:</b> If OGG audio is supported.</li>     <li><b>wav:</b> If WAV audio is supported.</li>     <li><b>mpeg:</b> If MPEG audio is supported.</li>     <li><b>m4a:</b> If M4A audio is supported.</li>     <li><b>mp4:</b> If MP4 audio is supported.</li>     <li><b>aiff:</b> If aiff audio is supported.</li>     <li><b>wma:</b> If wma audio is supported.</li>     <li><b>mid:</b> If mid audio is supported.</li> </ul>  You can get a specific capability of the active plugin using standard object notation  <h4>Example</h4>       var mp3 = createjs.Sound.capabilities.mp3;  Note this property is read only.
	*/
	public static var capabilities:Dynamic;
	
	/**
	* Mute/Unmute all audio. Note that muted audio still plays at 0 volume. This global mute value is maintained separately and when set will override, but not change the mute property of individual instances. To mute an individual instance, use AbstractSoundInstance {{#crossLink "AbstractSoundInstance/muted:property"}}{{/crossLink}} instead.  <h4>Example</h4>      createjs.Sound.muted = true;
	*/
	public var muted:Bool;
	
	/**
	* Set the master volume of Sound. The master volume is multiplied against each sound's individual volume.  For example, if master volume is 0.5 and a sound's volume is 0.5, the resulting volume is 0.25. To set individual sound volume, use AbstractSoundInstance {{#crossLink "AbstractSoundInstance/volume:property"}}{{/crossLink}} instead.  <h4>Example</h4>      createjs.Sound.volume = 0.5;
	*/
	public var volume:Float;
	
	/**
	* Some extensions use another type of extension support to play (one of them is a codex).  This allows you to map that support so plugins can accurately determine if an extension is supported.  Adding to this list can help plugins determine more accurately if an extension is supported.  A useful list of extensions for each format can be found at <a href="http://html5doctor.com/html5-audio-the-state-of-play/" target="_blank">http://html5doctor.com/html5-audio-the-state-of-play/</a>.
	*/
	public static var EXTENSION_MAP:Dynamic;
	
	/**
	* The currently active plugin. If this is null, then no plugin could be initialized. If no plugin was specified, Sound attempts to apply the default plugins: {{#crossLink "WebAudioPlugin"}}{{/crossLink}}, followed by {{#crossLink "HTMLAudioPlugin"}}{{/crossLink}}.
	*/
	public static var activePlugin:Dynamic;
	
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
	* The RegExp pattern used to parse file URIs. This supports simple file names, as well as full domain URIs with query strings. The resulting match is: protocol:$1 domain:$2 path:$3 file:$4 extension:$5 query:$6.
	*/
	public static var FILE_PATTERN:EReg;
	
	/**
	* Used internally to assign unique IDs to each AbstractSoundInstance.
	*/
	public static var _lastID:Float;
	
	/**
	* <strong>REMOVED</strong>. Removed in favor of using `MySuperClass_constructor`.
	*	See {{#crossLink "Utility Methods/extend"}}{{/crossLink}} and {{#crossLink "Utility Methods/promote"}}{{/crossLink}}
	*	for details.
	*	
	*	There is an inheritance tutorial distributed with EaselJS in /tutorials/Inheritance.
	*/
	private function initialize():Dynamic;
	
	/**
	* A sound has completed playback, been interrupted, failed, or been stopped. This method removes the instance from
	*	Sound management. It will be added again, if the sound re-plays. Note that this method is called from the
	*	instances themselves.
	* @param instance The instance that finished playback.
	*/
	private static function _playFinished(instance:AbstractSoundInstance):Dynamic;
	
	/**
	* Begin playback. This is called immediately or after delay by {{#crossLink "Sound/playInstance"}}{{/crossLink}}.
	* @param instance A {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} to begin playback.
	* @param playProps A PlayPropsConfig object.
	*/
	private static function _beginPlaying(instance:AbstractSoundInstance, playProps:PlayPropsConfig):Bool;
	
	/**
	* Check if a source has been loaded by internal preloaders. This is necessary to ensure that sounds that are
	*	not completed preloading will not kick off a new internal preload if they are played.
	*	
	*	<h4>Example</h4>
	*	
	*	    var mySound = "assetPath/asset0.ogg";
	*	    if(createjs.Sound.loadComplete(mySound) {
	*	        createjs.Sound.play(mySound);
	*	    }
	* @param src The src or id that is being loaded.
	*/
	public static function loadComplete(src:String):Bool;
	
	/**
	* Creates a {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} using the passed in src. If the src does not have a
	*	supported extension or if there is no available plugin, a default AbstractSoundInstance will be returned that can be
	*	called safely but does nothing.
	*	
	*	<h4>Example</h4>
	*	
	*	     var myInstance = null;
	*	     createjs.Sound.on("fileload", handleLoad);
	*	     createjs.Sound.registerSound("myAudioPath/mySound.mp3", "myID", 3);
	*	     function handleLoad(event) {
	*	     	myInstance = createjs.Sound.createInstance("myID");
	*	     	// alternately we could call the following
	*	     	myInstance = createjs.Sound.createInstance("myAudioPath/mySound.mp3");
	*	     }
	*	
	*	NOTE to create an audio sprite that has not already been registered, both startTime and duration need to be set.
	*	This is only when creating a new audio sprite, not when playing using the id of an already registered audio sprite.
	* @param src The src or ID of the audio.
	* @param startTime To create an audio sprite (with duration), the initial offset to start playback and loop from, in milliseconds.
	* @param duration To create an audio sprite (with startTime), the amount of time to play the clip for, in milliseconds.
	*/
	public static function createInstance(src:String, ?startTime:Float, ?duration:Float):AbstractSoundInstance;
	
	/**
	* Deprecated, please use {{#crossLink "Sound/capabilities:property"}}{{/crossLink}} instead.
	* @param key The capability to retrieve
	*/
	public static function getCapability(key:String):Dynamic;
	
	/**
	* Deprecated, please use {{#crossLink "Sound/capabilities:property"}}{{/crossLink}} instead.
	*/
	public static function getCapabilities():Dynamic;
	
	/**
	* Deprecated, please use {{#crossLink "Sound/muted:property"}}{{/crossLink}} instead.
	* @param value Whether the audio should be muted or not.
	*/
	public static function setMute(value:Bool):Bool;
	
	/**
	* Deprecated, please use {{#crossLink "Sound/muted:property"}}{{/crossLink}} instead.
	*/
	public static function getMute():Bool;
	
	/**
	* Deprecated, please use {{#crossLink "Sound/volume:property"}}{{/crossLink}} instead.
	* @param value The master volume value. The acceptable range is 0-1.
	*/
	public static function setVolume(value:Float):Dynamic;
	
	/**
	* Deprecated, please use {{#crossLink "Sound/volume:property"}}{{/crossLink}} instead.
	*/
	public static function getVolume():Float;
	
	/**
	* Determines if Sound has been initialized, and a plugin has been activated.
	*	
	*	<h4>Example</h4>
	*	This example sets up a Flash fallback, but only if there is no plugin specified yet.
	*	
	*		if (!createjs.Sound.isReady()) {
	*			createjs.FlashAudioPlugin.swfPath = "../src/soundjs/flashaudio/";
	*			createjs.Sound.registerPlugins([createjs.WebAudioPlugin, createjs.HTMLAudioPlugin, createjs.FlashAudioPlugin]);
	*		}
	*/
	public static function isReady():Bool;
	
	/**
	* Get the default playback properties for the passed in src or ID.  These properties are applied to all
	*	new SoundInstances.  Returns null if default does not exist.
	* @param src The src or ID used to register the audio.
	*/
	public function getDefaultPlayProps(src:String):PlayPropsConfig;
	
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
	private static function _getSrcById(value:String):String;
	
	/**
	* Initialize the default plugins. This method is automatically called when any audio is played or registered before
	*	the user has manually registered plugins, and enables Sound to work without manual plugin setup. Currently, the
	*	default plugins are {{#crossLink "WebAudioPlugin"}}{{/crossLink}} followed by {{#crossLink "HTMLAudioPlugin"}}{{/crossLink}}.
	*	
	*	<h4>Example</h4>
	*	
	*		if (!createjs.initializeDefaultPlugins()) { return; }
	*/
	public static function initializeDefaultPlugins():Bool;
	
	/**
	* Internal method for loading sounds.  This should not be called directly.
	* @param src The object to load, containing src property and optionally containing id and data.
	*/
	private static function _registerSound(src:Dynamic):Dynamic;
	
	/**
	* Parse the path of a sound based on properties of src matching with supported extensions.
	*	Returns false if none of the properties are supported
	* @param value The paths to an audio source, indexed by extension type.
	*/
	private static function _parseSrc(value:Dynamic):Dynamic;
	
	/**
	* Parse the path of a sound. Alternate extensions will be attempted in order if the
	*	current extension is not supported
	* @param value The path to an audio source.
	*/
	private static function _parsePath(value:String):Dynamic;
	
	/**
	* Play a sound and get a {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} to control. If the sound fails to play, a
	*	AbstractSoundInstance will still be returned, and have a playState of {{#crossLink "Sound/PLAY_FAILED:property"}}{{/crossLink}}.
	*	Note that even on sounds with failed playback, you may still be able to call AbstractSoundInstance {{#crossLink "AbstractSoundInstance/play"}}{{/crossLink}},
	*	since the failure could be due to lack of available channels. If the src does not have a supported extension or
	*	if there is no available plugin, a default AbstractSoundInstance will be returned which will not play any audio, but will not generate errors.
	*	
	*	<h4>Example</h4>
	*	
	*	     createjs.Sound.on("fileload", handleLoad);
	*	     createjs.Sound.registerSound("myAudioPath/mySound.mp3", "myID", 3);
	*	     function handleLoad(event) {
	*	     	createjs.Sound.play("myID");
	*	     	// store off AbstractSoundInstance for controlling
	*	     	var myInstance = createjs.Sound.play("myID", {interrupt: createjs.Sound.INTERRUPT_ANY, loop:-1});
	*	     }
	*	
	*	NOTE to create an audio sprite that has not already been registered, both startTime and duration need to be set.
	*	This is only when creating a new audio sprite, not when playing using the id of an already registered audio sprite.
	*	
	*	<b>Parameters Deprecated</b><br />
	*	The parameters for this method are deprecated in favor of a single parameter that is an Object or {{#crossLink "PlayPropsConfig"}}{{/crossLink}}.
	* @param src The src or ID of the audio.
	* @param interrupt <b>This parameter will be renamed playProps in the next release.</b><br />
	*	This parameter can be an instance of {{#crossLink "PlayPropsConfig"}}{{/crossLink}} or an Object that contains any or all optional properties by name,
	*	including: interrupt, delay, offset, loop, volume, pan, startTime, and duration (see the above code sample).
	*	<br /><strong>OR</strong><br />
	*	<b>Deprecated</b> How to interrupt any currently playing instances of audio with the same source,
	*	if the maximum number of instances of the sound are already playing. Values are defined as <code>INTERRUPT_TYPE</code>
	*	constants on the Sound class, with the default defined by {{#crossLink "Sound/defaultInterruptBehavior:property"}}{{/crossLink}}.
	* @param delay <b>Deprecated</b> The amount of time to delay the start of audio playback, in milliseconds.
	* @param offset <b>Deprecated</b> The offset from the start of the audio to begin playback, in milliseconds.
	* @param loop <b>Deprecated</b> How many times the audio loops when it reaches the end of playback. The default is 0 (no
	*	loops), and -1 can be used for infinite playback.
	* @param volume <b>Deprecated</b> The volume of the sound, between 0 and 1. Note that the master volume is applied
	*	against the individual volume.
	* @param pan <b>Deprecated</b> The left-right pan of the sound (if supported), between -1 (left) and 1 (right).
	* @param startTime <b>Deprecated</b> To create an audio sprite (with duration), the initial offset to start playback and loop from, in milliseconds.
	* @param duration <b>Deprecated</b> To create an audio sprite (with startTime), the amount of time to play the clip for, in milliseconds.
	*/
	public static function play(src:String, ?interrupt:Dynamic, ?delay:Float, ?offset:Float, ?loop:Float, ?volume:Float, ?pan:Float, ?startTime:Float, ?duration:Float):AbstractSoundInstance;
	
	/**
	* Play an instance. This is called by the static API, as well as from plugins. This allows the core class to
	*	control delays.
	* @param instance The {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} to start playing.
	* @param playProps A PlayPropsConfig object.
	*/
	private static function _playInstance(instance:AbstractSoundInstance, playProps:PlayPropsConfig):Bool;
	
	/**
	* Process manifest items from <a href="http://preloadjs.com" target="_blank">PreloadJS</a>. This method is intended
	*	for usage by a plugin, and not for direct interaction.
	* @param src The object to load.
	*/
	private static function initLoad(src:Dynamic):Dynamic;
	
	/**
	* Register a list of Sound plugins, in order of precedence. To register a single plugin, pass a single element in the array.
	*	
	*	<h4>Example</h4>
	*	
	*	     createjs.FlashAudioPlugin.swfPath = "../src/soundjs/flashaudio/";
	*	     createjs.Sound.registerPlugins([createjs.WebAudioPlugin, createjs.HTMLAudioPlugin, createjs.FlashAudioPlugin]);
	* @param plugins An array of plugins classes to install.
	*/
	public static function registerPlugins(plugins:Array<Dynamic>):Bool;
	
	/**
	* Register an array of audio files for loading and future playback in Sound. It is recommended to register all
	*	sounds that need to be played back in order to properly prepare and preload them. Sound does internal preloading
	*	when required.
	*	
	*	<h4>Example</h4>
	*	
	*			var assetPath = "./myAudioPath/";
	*	     var sounds = [
	*	         {src:"asset0.ogg", id:"example"},
	*	         {src:"asset1.ogg", id:"1", data:6},
	*	         {src:"asset2.mp3", id:"works"}
	*	         {src:{mp3:"path1/asset3.mp3", ogg:"path2/asset3NoExtension"}, id:"better"}
	*	     ];
	*	     createjs.Sound.alternateExtensions = ["mp3"];	// if the passed extension is not supported, try this extension
	*	     createjs.Sound.on("fileload", handleLoad); // call handleLoad when each sound loads
	*	     createjs.Sound.registerSounds(sounds, assetPath);
	* @param sounds An array of objects to load. Objects are expected to be in the format needed for
	*	{{#crossLink "Sound/registerSound"}}{{/crossLink}}: <code>{src:srcURI, id:ID, data:Data}</code>
	*	with "id" and "data" being optional.
	*	You can also pass an object with path and manifest properties, where path is a basePath and manifest is an array of objects to load.
	*	Note id is required if src is an object with extension labeled src properties.
	* @param basePath Set a path that will be prepended to each src when loading.  When creating, playing, or removing
	*	audio that was loaded with a basePath by src, the basePath must be included.
	*/
	public static function registerSounds(sounds:Array<Dynamic>, basePath:String):Dynamic;
	
	/**
	* Register an audio file for loading and future playback in Sound. This is automatically called when using
	*	<a href="http://preloadjs.com" target="_blank">PreloadJS</a>.  It is recommended to register all sounds that
	*	need to be played back in order to properly prepare and preload them. Sound does internal preloading when required.
	*	
	*	<h4>Example</h4>
	*	
	*	     createjs.Sound.alternateExtensions = ["mp3"];
	*	     createjs.Sound.on("fileload", handleLoad); // add an event listener for when load is completed
	*	     createjs.Sound.registerSound("myAudioPath/mySound.ogg", "myID", 3);
	*	     createjs.Sound.registerSound({ogg:"path1/mySound.ogg", mp3:"path2/mySoundNoExtension"}, "myID", 3);
	* @param src The source or an Object with a "src" property or an Object with multiple extension labeled src properties.
	* @param id An id specified by the user to play the sound later.  Note id is required for when src is multiple extension labeled src properties.
	* @param data Data associated with the item. Sound uses the data parameter as the number of
	*	channels for an audio instance, however a "channels" property can be appended to the data object if it is used
	*	for other information. The audio channels will set a default based on plugin if no value is found.
	*	Sound also uses the data property to hold an {{#crossLink "AudioSprite"}}{{/crossLink}} array of objects in the following format {id, startTime, duration}.<br/>
	*	  id used to play the sound later, in the same manner as a sound src with an id.<br/>
	*	  startTime is the initial offset to start playback and loop from, in milliseconds.<br/>
	*	  duration is the amount of time to play the clip for, in milliseconds.<br/>
	*	This allows Sound to support audio sprites that are played back by id.
	* @param basePath Set a path that will be prepended to src for loading.
	* @param defaultPlayProps Optional Playback properties that will be set as the defaults on any new AbstractSoundInstance.
	*	See {{#crossLink "PlayPropsConfig"}}{{/crossLink}} for options.
	*/
	public static function registerSound(src:Dynamic, ?id:String, ?data:Dynamic, ?basePath:String, ?defaultPlayProps:Dynamic):Dynamic;
	
	/**
	* Remove a sound that has been registered with {{#crossLink "Sound/registerSound"}}{{/crossLink}} or
	*	{{#crossLink "Sound/registerSounds"}}{{/crossLink}}.
	*	<br />Note this will stop playback on active instances playing this sound before deleting them.
	*	<br />Note if you passed in a basePath, you need to pass it or prepend it to the src here.
	*	
	*	<h4>Example</h4>
	*	
	*	     createjs.Sound.removeSound("myID");
	*	     createjs.Sound.removeSound("myAudioBasePath/mySound.ogg");
	*	     createjs.Sound.removeSound("myPath/myOtherSound.mp3", "myBasePath/");
	*	     createjs.Sound.removeSound({mp3:"musicNoExtension", ogg:"music.ogg"}, "myBasePath/");
	* @param src The src or ID of the audio, or an Object with a "src" property, or an Object with multiple extension labeled src properties.
	* @param basePath Set a path that will be prepended to each src when removing.
	*/
	public static function removeSound(src:Dynamic, basePath:String):Bool;
	
	/**
	* Remove all sounds that have been registered with {{#crossLink "Sound/registerSound"}}{{/crossLink}} or
	*	{{#crossLink "Sound/registerSounds"}}{{/crossLink}}.
	*	<br />Note this will stop playback on all active sound instances before deleting them.
	*	
	*	<h4>Example</h4>
	*	
	*	    createjs.Sound.removeAllSounds();
	*/
	public static function removeAllSounds():Dynamic;
	
	/**
	* Remove an array of audio files that have been registered with {{#crossLink "Sound/registerSound"}}{{/crossLink}} or
	*	{{#crossLink "Sound/registerSounds"}}{{/crossLink}}.
	*	<br />Note this will stop playback on active instances playing this audio before deleting them.
	*	<br />Note if you passed in a basePath, you need to pass it or prepend it to the src here.
	*	
	*	<h4>Example</h4>
	*	
	*			assetPath = "./myPath/";
	*	     var sounds = [
	*	         {src:"asset0.ogg", id:"example"},
	*	         {src:"asset1.ogg", id:"1", data:6},
	*	         {src:"asset2.mp3", id:"works"}
	*	     ];
	*	     createjs.Sound.removeSounds(sounds, assetPath);
	* @param sounds An array of objects to remove. Objects are expected to be in the format needed for
	*	{{#crossLink "Sound/removeSound"}}{{/crossLink}}: <code>{srcOrID:srcURIorID}</code>.
	*	You can also pass an object with path and manifest properties, where path is a basePath and manifest is an array of objects to remove.
	* @param basePath Set a path that will be prepended to each src when removing.
	*/
	public static function removeSounds(sounds:Array<Dynamic>, basePath:String):Dynamic;
	
	/**
	* Set the default playback properties for all new SoundInstances of the passed in src or ID.
	*	See {{#crossLink "PlayPropsConfig"}}{{/crossLink}} for available properties.
	* @param src The src or ID used to register the audio.
	* @param playProps The playback properties you would like to set.
	*/
	public function setDefaultPlayProps(src:String, playProps:Dynamic):Dynamic;
	
	/**
	* Stop all audio (global stop). Stopped audio is reset, and not paused. To play audio that has been stopped,
	*	call AbstractSoundInstance {{#crossLink "AbstractSoundInstance/play"}}{{/crossLink}}.
	*	
	*	<h4>Example</h4>
	*	
	*	    createjs.Sound.stop();
	*/
	public static function stop():Dynamic;
	
	/**
	* Used by {{#crossLink "Sound/registerPlugins"}}{{/crossLink}} to register a Sound plugin.
	* @param plugin The plugin class to install.
	*/
	private static function _registerPlugin(plugin:Dynamic):Bool;
	
	/**
	* Used to dispatch fileload events from internal loading.
	* @param event A loader event.
	*/
	private static function _handleLoadComplete(event:Dynamic):Dynamic;
	
	// EventDispatcher injects...
	
	/**
	* A shortcut method for using addEventListener that makes it easier to specify an execution scope, have a listener
	*	only run once, associate arbitrary data with the listener, and remove the listener.
	*	
	*	This method works by creating an anonymous wrapper function and subscribing it with addEventListener.
	*	The created anonymous function is returned for use with .removeEventListener (or .off).
	*	
	*	<h4>Example</h4>
	*	
	*			var listener = myBtn.on("click", handleClick, null, false, {count:3});
	*			function handleClick(evt, data) {
	*				data.count -= 1;
	*				console.log(this == myBtn); // true - scope defaults to the dispatcher
	*				if (data.count == 0) {
	*					alert("clicked 3 times!");
	*					myBtn.off("click", listener);
	*					// alternately: evt.remove();
	*				}
	*			}
	* @param type The string type of the event.
	* @param listener An object with a handleEvent method, or a function that will be called when
	*	the event is dispatched.
	* @param scope The scope to execute the listener in. Defaults to the dispatcher/currentTarget for function listeners, and to the listener itself for object listeners (ie. using handleEvent).
	* @param once If true, the listener will remove itself after the first time it is triggered.
	* @param data Arbitrary data that will be included as the second parameter when the listener is called.
	* @param useCapture For events that bubble, indicates whether to listen for the event in the capture or bubbling/target phase.
	*/
	public static function on(type:String, listener:Dynamic, ?scope:Dynamic, ?once:Bool, ?data:Dynamic, ?useCapture:Bool):Dynamic;
	
	/**
	* A shortcut to the removeEventListener method, with the same parameters and return value. This is a companion to the
	*	.on method.
	* @param type The string type of the event.
	* @param listener The listener function or object.
	* @param useCapture For events that bubble, indicates whether to listen for the event in the capture or bubbling/target phase.
	*/
	public static function off(type:String, listener:Dynamic, ?useCapture:Bool):Dynamic;
	
	/**
	* Adds the specified event listener. Note that adding multiple listeners to the same function will result in
	*	multiple callbacks getting fired.
	*	
	*	<h4>Example</h4>
	*	
	*	     displayObject.addEventListener("click", handleClick);
	*	     function handleClick(event) {
	*	        // Click happened.
	*	     }
	* @param type The string type of the event.
	* @param listener An object with a handleEvent method, or a function that will be called when
	*	the event is dispatched.
	* @param useCapture For events that bubble, indicates whether to listen for the event in the capture or bubbling/target phase.
	*/
	public static function addEventListener(type:String, listener:Dynamic, ?useCapture:Bool):Dynamic;
	
	/**
	* Dispatches the specified event to all listeners.
	*	
	*	<h4>Example</h4>
	*	
	*	     // Use a string event
	*	     this.dispatchEvent("complete");
	*	
	*	     // Use an Event instance
	*	     var event = new createjs.Event("progress");
	*	     this.dispatchEvent(event);
	* @param eventObj An object with a "type" property, or a string type.
	*	While a generic object will work, it is recommended to use a CreateJS Event instance. If a string is used,
	*	dispatchEvent will construct an Event instance if necessary with the specified type. This latter approach can
	*	be used to avoid event object instantiation for non-bubbling events that may not have any listeners.
	* @param bubbles Specifies the `bubbles` value when a string was passed to eventObj.
	* @param cancelable Specifies the `cancelable` value when a string was passed to eventObj.
	*/
	public static function dispatchEvent(eventObj:Dynamic, ?bubbles:Bool, ?cancelable:Bool):Bool;
	
	/**
	* Indicates whether there is at least one listener for the specified event type on this object or any of its
	*	ancestors (parent, parent's parent, etc). A return value of true indicates that if a bubbling event of the
	*	specified type is dispatched from this object, it will trigger at least one listener.
	*	
	*	This is similar to {{#crossLink "EventDispatcher/hasEventListener"}}{{/crossLink}}, but it searches the entire
	*	event flow for a listener, not just this object.
	* @param type The string type of the event.
	*/
	public static function willTrigger(type:String):Bool;
	
	/**
	* Indicates whether there is at least one listener for the specified event type.
	* @param type The string type of the event.
	*/
	public static function hasEventListener(type:String):Bool;
	
	/**
	* Removes all listeners for the specified type, or all listeners of all types.
	*	
	*	<h4>Example</h4>
	*	
	*	     // Remove all listeners
	*	     displayObject.removeAllEventListeners();
	*	
	*	     // Remove all click listeners
	*	     displayObject.removeAllEventListeners("click");
	* @param type The string type of the event. If omitted, all listeners for all types will be removed.
	*/
	public static function removeAllEventListeners(?type:String):Dynamic;
	
	/**
	* Removes the specified event listener.
	*	
	*	<b>Important Note:</b> that you must pass the exact function reference used when the event was added. If a proxy
	*	function, or function closure is used as the callback, the proxy/closure reference must be used - a new proxy or
	*	closure will not work.
	*	
	*	<h4>Example</h4>
	*	
	*	     displayObject.removeEventListener("click", handleClick);
	* @param type The string type of the event.
	* @param listener The listener function or object.
	* @param useCapture For events that bubble, indicates whether to listen for the event in the capture or bubbling/target phase.
	*/
	public static function removeEventListener(type:String, listener:Dynamic, ?useCapture:Bool):Dynamic;
	
}
