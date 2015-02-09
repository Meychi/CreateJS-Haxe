package createjs.soundjs;

/**
* FlashAudioSoundInstance extends the base api of {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} and is used by
*	{{#crossLink "FlashAudioPlugin"}}{{/crossLink}}.
*	
*	NOTE audio control is shuttled to a flash player instance via the flash reference.
*/
@:native("createjs.FlashAudioSoundInstance")
extern class FlashAudioSoundInstance extends AbstractSoundInstance
{
	/**
	* FlashAudioSoundInstance extends the base api of {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} and is used by
	*	{{#crossLink "FlashAudioPlugin"}}{{/crossLink}}.
	*	
	*	NOTE audio control is shuttled to a flash player instance via the flash reference.
	* @param src The path to and file name of the sound.
	* @param startTime Audio sprite property used to apply an offset, in milliseconds.
	* @param duration Audio sprite property used to set the time the clip plays for, in milliseconds.
	* @param playbackResource Any resource needed by plugin to support audio playback.
	*/
	public function new(src:String, startTime:Float, duration:Float, playbackResource:Dynamic):Void;
	
}
