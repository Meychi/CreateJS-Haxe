package createjs.soundjs;

/**
* HTMLAudioSoundInstance extends the base api of {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} and is used by
*	{{#crossLink "HTMLAudioPlugin"}}{{/crossLink}}.
*/
@:native("createjs.HTMLAudioSoundInstance")
extern class HTMLAudioSoundInstance extends AbstractSoundInstance
{
	/**
	* HTMLAudioSoundInstance extends the base api of {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} and is used by
	*	{{#crossLink "HTMLAudioPlugin"}}{{/crossLink}}.
	* @param src The path to and file name of the sound.
	* @param startTime Audio sprite property used to apply an offset, in milliseconds.
	* @param duration Audio sprite property used to set the time the clip plays for, in milliseconds.
	* @param playbackResource Any resource needed by plugin to support audio playback.
	*/
	public function new(src:String, startTime:Float, duration:Float, playbackResource:Dynamic):Void;
	
	/**
	* Timer used to loop audio sprites.
	*	NOTE because of the inaccuracies in the timeupdate event (15 - 250ms) and in setting the tag to the desired timed
	*	(up to 300ms), it is strongly recommended not to loop audio sprites with HTML Audio if smooth looping is desired
	* @param event 
	*/
	private function _handleAudioSpriteLoop(event:Dynamic):Dynamic;
	
	/**
	* Used to enable setting position, as we need to wait for that seek to be done before we add back our loop handling seek listener
	* @param event 
	*/
	private function _handleSetPositionSeek(event:Dynamic):Dynamic;
	
	/**
	* Used to handle when a tag is not ready for immediate playback when it is returned from the HTMLAudioTagPool.
	* @param event 
	*/
	private function _handleTagReady(event:Dynamic):Dynamic;
	
}
