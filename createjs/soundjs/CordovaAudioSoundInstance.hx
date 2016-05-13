package createjs.soundjs;

/**
* CordovaAudioSoundInstance extends the base api of {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} and is used by
*	{{#crossLink "CordovaAudioPlugin"}}{{/crossLink}}.
*/
@:native("createjs.CordovaAudioSoundInstance")
extern class CordovaAudioSoundInstance extends AbstractSoundInstance
{
	/**
	* A TimeOut used to trigger the end and possible loop of audio sprites.
	*/
	private var _audioSpriteTimeout:Dynamic;
	
	/**
	* Boolean value that indicates if we are using an audioSprite
	*/
	private var _audioSprite:Boolean;
	
	/**
	* Sets the playAudioWhenScreenIsLocked property for play calls on iOS devices.
	*/
	public var playWhenScreenLocked:Boolean;
	
	/**
	* Used to approximate the playback position by storing the number of milliseconds elapsed since 1 January 1970 00:00:00 UTC when playing Note that if js clock is out of sync with Media playback, this will become increasingly inaccurate.
	*/
	private var _playStartTime:Float;
	
	/**
	* CordovaAudioSoundInstance extends the base api of {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} and is used by
	*	{{#crossLink "CordovaAudioPlugin"}}{{/crossLink}}.
	* @param src The path to and file name of the sound.
	* @param startTime Audio sprite property used to apply an offset, in milliseconds.
	* @param duration Audio sprite property used to set the time the clip plays for, in milliseconds.
	* @param playbackResource Any resource needed by plugin to support audio playback.
	*/
	public function new(src:String, startTime:Float, duration:Float, playbackResource:Dynamic):Void;
	
	/**
	* Maps to <a href="http://plugins.cordova.io/#/package/org.apache.cordova.media" target="_blank">Media.getCurrentPosition</a>,
	*	which is curiously asynchronus and requires a callback.
	* @param mediaSuccess The callback that is passed the current position in seconds.
	* @param mediaError (Optional) The callback to execute if an error occurs.
	*/
	public function getCurrentPosition(mediaSuccess:Method, ?mediaError:Method):Dynamic;
	
	/**
	* media object has failed and likely will never work
	* @param error 
	*/
	private function _handleMediaError(error:Dynamic):Dynamic;
	
	/**
	* Synchronizes the best guess position with the actual current position.
	* @param pos The current position in seconds
	*/
	private function _updatePausePos(pos:Float):Dynamic;
	
}
