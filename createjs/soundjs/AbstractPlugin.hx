package createjs.soundjs;

/**
* A default plugin class used as a base for all other plugins.
*/
@:native("createjs.AbstractPlugin")
extern class AbstractPlugin
{
	/**
	* Object hash indexed by the source URI of each file to indicate if an audio source has begun loading, is currently loading, or has completed loading.  Can be used to store non boolean data after loading is complete (for example arrayBuffers for web audio).
	*/
	private var _audioSources:Dynamic;
	
	/**
	* The capabilities of the plugin. This is generated via the _generateCapabilities method and is used internally.
	*/
	public static var _capabilities:Dynamic;
	
	/**
	* The internal master volume value of the plugin.
	*/
	private var _volume:Float;
	
	/**
	* <strong>REMOVED</strong>. Removed in favor of using `MySuperClass_constructor`.
	*	See {{#crossLink "Utility Methods/extend"}}{{/crossLink}} and {{#crossLink "Utility Methods/promote"}}{{/crossLink}}
	*	for details.
	*	
	*	There is an inheritance tutorial distributed with EaselJS in /tutorials/Inheritance.
	*/
	private function initialize():Dynamic;
	
	/**
	* A default plugin class used as a base for all other plugins.
	*/
	public function new():Void;
	
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
	* @param startTime Audio sprite property used to apply an offset, in milliseconds.
	* @param duration Audio sprite property used to set the time the clip plays for, in milliseconds.
	*/
	public function create(src:String, startTime:Float, duration:Float):AbstractSoundInstance;
	
	/**
	* Determine if the plugin can be used in the current browser/OS.
	*/
	public static function isSupported():Bool;
	
	/**
	* Get the master volume of the plugin, which affects all SoundInstances.
	*/
	public function getVolume():Float;
	
	/**
	* Handles internal preload completion.
	*/
	private function _handlePreloadComplete():Dynamic;
	
	/**
	* Handles internal preload erros
	* @param event 
	*/
	private function _handlePreloadError(event:Dynamic):Dynamic;
	
	/**
	* Internally preload a sound.
	* @param loader The sound URI to load.
	*/
	public function preload(loader:Loader):Dynamic;
	
	/**
	* Mute all sounds via the plugin.
	* @param value If all sound should be muted or not. Note that plugin-level muting just looks up
	*	the mute value of Sound {{#crossLink "Sound/getMute"}}{{/crossLink}}, so this property is not used here.
	*/
	public function setMute(value:Bool):Bool;
	
	/**
	* Pre-register a sound for preloading and setup. This is called by {{#crossLink "Sound"}}{{/crossLink}}.
	*	Note all plugins provide a <code>Loader</code> instance, which <a href="http://preloadjs.com" target="_blank">PreloadJS</a>
	*	can use to assist with preloading.
	* @param loadItem An Object containing the source of the audio
	*	Note that not every plugin will manage this value.
	*/
	public function register(loadItem:String):Dynamic;
	
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
	
}
