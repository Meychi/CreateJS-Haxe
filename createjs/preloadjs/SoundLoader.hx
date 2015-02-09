package createjs.preloadjs;

/**
* A loader for HTML audio files. PreloadJS can not load WebAudio files, as a WebAudio context is required, which
*	should be created by either a library playing the sound (such as <a href="http://soundjs.com">SoundJS</a>, or an
*	external framework that handles audio playback. To load content that can be played by WebAudio, use the
*	{{#crossLink "BinaryLoader"}}{{/crossLink}}, and handle the audio context decoding manually.
*/
@:native("createjs.SoundLoader")
extern class SoundLoader extends AbstractMediaLoader
{
	/**
	* A loader for HTML audio files. PreloadJS can not load WebAudio files, as a WebAudio context is required, which
	*	should be created by either a library playing the sound (such as <a href="http://soundjs.com">SoundJS</a>, or an
	*	external framework that handles audio playback. To load content that can be played by WebAudio, use the
	*	{{#crossLink "BinaryLoader"}}{{/crossLink}}, and handle the audio context decoding manually.
	* @param loadItem 
	* @param preferXHR 
	*/
	public function new(loadItem:Dynamic, preferXHR:Bool):Void;
	
	/**
	* Determines if the loader can load a specific item. This loader can only load items that are of type
	*	{{#crossLink "AbstractLoader/SOUND:property"}}{{/crossLink}}.
	* @param item The LoadItem that a LoadQueue is trying to load.
	*/
	public static function canLoadItem(item:Dynamic):Bool;
	
}
