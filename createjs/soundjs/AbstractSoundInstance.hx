package createjs.soundjs;

/**
* A AbstractSoundInstance is created when any calls to the Sound API method {{#crossLink "Sound/play"}}{{/crossLink}} or
*	{{#crossLink "Sound/createInstance"}}{{/crossLink}} are made. The AbstractSoundInstance is returned by the active plugin
*	for control by the user.
*	
*	<h4>Example</h4>
*	
*	     var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3");
*	
*	A number of additional parameters provide a quick way to determine how a sound is played. Please see the Sound
*	API method {{#crossLink "Sound/play"}}{{/crossLink}} for a list of arguments.
*	
*	Once a AbstractSoundInstance is created, a reference can be stored that can be used to control the audio directly through
*	the AbstractSoundInstance. If the reference is not stored, the AbstractSoundInstance will play out its audio (and any loops), and
*	is then de-referenced from the {{#crossLink "Sound"}}{{/crossLink}} class so that it can be cleaned up. If audio
*	playback has completed, a simple call to the {{#crossLink "AbstractSoundInstance/play"}}{{/crossLink}} instance method
*	will rebuild the references the Sound class need to control it.
*	
*	     var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3", {loop:2});
*	     myInstance.on("loop", handleLoop);
*	     function handleLoop(event) {
*	         myInstance.volume = myInstance.volume * 0.5;
*	     }
*	
*	Events are dispatched from the instance to notify when the sound has completed, looped, or when playback fails
*	
*	     var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3");
*	     myInstance.on("complete", handleComplete);
*	     myInstance.on("loop", handleLoop);
*	     myInstance.on("failed", handleFailed);
*/
@:native("createjs.AbstractSoundInstance")
extern class AbstractSoundInstance extends EventDispatcher
{
	/**
	* A Timeout created by {{#crossLink "Sound"}}{{/crossLink}} when this AbstractSoundInstance is played with a delay. This allows AbstractSoundInstance to remove the delay if stop, pause, or cleanup are called before playback begins.
	*/
	private var delayTimeoutId:Dynamic;
	
	/**
	* Audio sprite property used to determine the starting offset.
	*/
	public var startTime:Float;
	
	/**
	* Mutes or unmutes the current audio instance.
	*/
	public var muted:Bool;
	
	/**
	* Object that holds plugin specific resource need for audio playback. This is set internally by the plugin.  For example, WebAudioPlugin will set an array buffer, HTMLAudioPlugin will set a tag, FlashAudioPlugin will set a flash reference.
	*/
	public var playbackResource:Dynamic;
	
	/**
	* Pauses or resumes the current audio instance.
	*/
	public var paused:Bool;
	
	/**
	* Sets or gets the length of the audio clip, value is in milliseconds.
	*/
	public var duration:Float;
	
	/**
	* The number of play loops remaining. Negative values will loop infinitely.
	*/
	public var loop:Float;
	
	/**
	* The pan of the sound, between -1 (left) and 1 (right). Note that pan is not supported by HTML Audio.  <br />Note in WebAudioPlugin this only gives us the "x" value of what is actually 3D audio.
	*/
	public var pan:Float;
	
	/**
	* The play state of the sound. Play states are defined as constants on {{#crossLink "Sound"}}{{/crossLink}}.
	*/
	public var playState:String;
	
	/**
	* The position of the playhead in milliseconds. This can be set while a sound is playing, paused, or stopped.
	*/
	public var position:Float;
	
	/**
	* The source of the sound.
	*/
	public var src:String;
	
	/**
	* The unique ID of the instance. This is set by {{#crossLink "Sound"}}{{/crossLink}}.
	*/
	public var uniqueId:Dynamic;
	
	/**
	* The volume of the sound, between 0 and 1.  The actual output volume of a sound can be calculated using: <code>myInstance.volume * createjs.Sound.getVolume();</code>
	*/
	public var volume:Float;
	
	/**
	* A AbstractSoundInstance is created when any calls to the Sound API method {{#crossLink "Sound/play"}}{{/crossLink}} or
	*	{{#crossLink "Sound/createInstance"}}{{/crossLink}} are made. The AbstractSoundInstance is returned by the active plugin
	*	for control by the user.
	*	
	*	<h4>Example</h4>
	*	
	*	     var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3");
	*	
	*	A number of additional parameters provide a quick way to determine how a sound is played. Please see the Sound
	*	API method {{#crossLink "Sound/play"}}{{/crossLink}} for a list of arguments.
	*	
	*	Once a AbstractSoundInstance is created, a reference can be stored that can be used to control the audio directly through
	*	the AbstractSoundInstance. If the reference is not stored, the AbstractSoundInstance will play out its audio (and any loops), and
	*	is then de-referenced from the {{#crossLink "Sound"}}{{/crossLink}} class so that it can be cleaned up. If audio
	*	playback has completed, a simple call to the {{#crossLink "AbstractSoundInstance/play"}}{{/crossLink}} instance method
	*	will rebuild the references the Sound class need to control it.
	*	
	*	     var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3", {loop:2});
	*	     myInstance.on("loop", handleLoop);
	*	     function handleLoop(event) {
	*	         myInstance.volume = myInstance.volume * 0.5;
	*	     }
	*	
	*	Events are dispatched from the instance to notify when the sound has completed, looped, or when playback fails
	*	
	*	     var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3");
	*	     myInstance.on("complete", handleComplete);
	*	     myInstance.on("loop", handleLoop);
	*	     myInstance.on("failed", handleFailed);
	* @param src The path to and file name of the sound.
	* @param startTime Audio sprite property used to apply an offset, in milliseconds.
	* @param duration Audio sprite property used to set the time the clip plays for, in milliseconds.
	* @param playbackResource Any resource needed by plugin to support audio playback.
	*/
	public function new(src:String, startTime:Float, duration:Float, playbackResource:Dynamic):Void;
	
	/**
	* A helper method that dispatches all events for AbstractSoundInstance.
	* @param type The event type
	*/
	private function _sendEvent(type:String):Dynamic;
	
	/**
	* Audio has finished playing. Manually loop it if required.
	* @param event 
	*/
	private function _handleSoundComplete(event:Dynamic):Dynamic;
	
	/**
	* Called by the Sound class when the audio is ready to play (delay has completed). Starts sound playing if the
	*	src is loaded, otherwise playback will fail.
	* @param playProps A PlayPropsConfig object.
	*/
	private function _beginPlaying(playProps:PlayPropsConfig):Bool;
	
	/**
	* Clean up the instance. Remove references and clean up any additional properties such as timers.
	*/
	private function _cleanUp():Dynamic;
	
	/**
	* DEPRECATED, please use {{#crossLink "AbstractSoundInstance/duration:property"}}{{/crossLink}} directly as a property
	* @param value The new duration time in milli seconds.
	*/
	public function setDuration(value:Float):AbstractSoundInstance;
	
	/**
	* DEPRECATED, please use {{#crossLink "AbstractSoundInstance/duration:property"}}{{/crossLink}} directly as a property
	*/
	public function getDuration():Float;
	
	/**
	* DEPRECATED, please use {{#crossLink "AbstractSoundInstance/loop:property"}}{{/crossLink}} directly as a property
	*/
	public function getLoop():Float;
	
	/**
	* DEPRECATED, please use {{#crossLink "AbstractSoundInstance/loop:property"}}{{/crossLink}} directly as a property,
	* @param value The number of times to loop after play.
	*/
	public function setLoop(value:Float):Dynamic;
	
	/**
	* DEPRECATED, please use {{#crossLink "AbstractSoundInstance/muted:property"}}{{/crossLink}} directly as a property
	* @param value If the sound should be muted.
	*/
	public function setMuted(value:Bool):AbstractSoundInstance;
	
	/**
	* DEPRECATED, please use {{#crossLink "AbstractSoundInstance/muted:property"}}{{/crossLink}} directly as a property
	*/
	public function getMuted():Bool;
	
	/**
	* DEPRECATED, please use {{#crossLink "AbstractSoundInstance/pan:property"}}{{/crossLink}} directly as a property
	* @param value The pan value, between -1 (left) and 1 (right).
	*/
	public function setPan(value:Float):AbstractSoundInstance;
	
	/**
	* DEPRECATED, please use {{#crossLink "AbstractSoundInstance/pan:property"}}{{/crossLink}} directly as a property
	*/
	public function getPan():Float;
	
	/**
	* DEPRECATED, please use {{#crossLink "AbstractSoundInstance/paused:property"}}{{/crossLink}} directly as a property
	* @param value 
	*/
	public function setPaused(value:Bool):AbstractSoundInstance;
	
	/**
	* DEPRECATED, please use {{#crossLink "AbstractSoundInstance/paused:property"}}{{/crossLink}} directly as a property,
	*/
	public function getPaused():Bool;
	
	/**
	* DEPRECATED, please use {{#crossLink "AbstractSoundInstance/playbackResource:property"}}{{/crossLink}} directly as a property
	* @param value The new playback resource.
	*/
	public function setPlayback(value:Dynamic):Dynamic;
	
	/**
	* DEPRECATED, please use {{#crossLink "AbstractSoundInstance/position:property"}}{{/crossLink}} directly as a property
	* @param value The position to place the playhead, in milliseconds.
	*/
	public function setPosition(value:Float):AbstractSoundInstance;
	
	/**
	* DEPRECATED, please use {{#crossLink "AbstractSoundInstance/position:property"}}{{/crossLink}} directly as a property
	*/
	public function getPosition():Float;
	
	/**
	* DEPRECATED, please use {{#crossLink "AbstractSoundInstance/startTime:property"}}{{/crossLink}} directly as a property
	* @param value The new startTime time in milli seconds.
	*/
	public function setStartTime(value:Float):AbstractSoundInstance;
	
	/**
	* DEPRECATED, please use {{#crossLink "AbstractSoundInstance/startTime:property"}}{{/crossLink}} directly as a property
	*/
	public function getStartTime():Float;
	
	/**
	* DEPRECATED, please use {{#crossLink "AbstractSoundInstance/volume:property"}}{{/crossLink}} directly as a property
	* @param value The volume to set, between 0 and 1.
	*/
	public function setVolume(value:Float):AbstractSoundInstance;
	
	/**
	* DEPRECATED, please use {{#crossLink "AbstractSoundInstance/volume:property"}}{{/crossLink}} directly as a property
	*/
	public function getVolume():Float;
	
	/**
	* Handles starting playback when the sound is ready for playing.
	*/
	private function _handleSoundReady():Dynamic;
	
	/**
	* Internal function called when AbstractSoundInstance has played to end and is looping
	*/
	private function _handleLoop():Dynamic;
	
	/**
	* Internal function called when AbstractSoundInstance is being cleaned up
	*/
	private function _handleCleanUp():Dynamic;
	
	/**
	* Internal function called when looping is added during playback.
	* @param value The number of times to loop after play.
	*/
	private function _addLooping(value:Float):Dynamic;
	
	/**
	* Internal function called when looping is removed during playback.
	* @param value The number of times to loop after play.
	*/
	private function _removeLooping(value:Float):Dynamic;
	
	/**
	* Internal function called when pausing playback
	*/
	private function _pause():Dynamic;
	
	/**
	* Internal function called when resuming playback
	*/
	private function _resume():Dynamic;
	
	/**
	* Internal function called when stopping playback
	*/
	private function _handleStop():Dynamic;
	
	/**
	* Internal function that calculates the current position of the playhead and sets this._position to that value
	*/
	private function _calculateCurrentPosition():Dynamic;
	
	/**
	* Internal function used to get the duration of the audio from the source we'll be playing.
	*/
	private function _updateDuration():Dynamic;
	
	/**
	* Internal function used to update the pan
	*/
	private function _updatePan():Dynamic;
	
	/**
	* Internal function used to update the position of the playhead.
	*/
	private function _updatePosition():Dynamic;
	
	/**
	* Internal function used to update the startTime of the audio.
	*/
	private function _updateStartTime():Dynamic;
	
	/**
	* Internal function used to update the volume based on the instance volume, master volume, instance mute value,
	*	and master mute value.
	*/
	private function _updateVolume():Dynamic;
	
	/**
	* Play an instance. This method is intended to be called on SoundInstances that already exist (created
	*	with the Sound API {{#crossLink "Sound/createInstance"}}{{/crossLink}} or {{#crossLink "Sound/play"}}{{/crossLink}}).
	*	
	*	<h4>Example</h4>
	*	
	*	     var myInstance = createjs.Sound.createInstance(mySrc);
	*	     myInstance.play({interrupt:createjs.Sound.INTERRUPT_ANY, loop:2, pan:0.5});
	*	
	*	Note that if this sound is already playing, this call will still set the passed in parameters.
	*	
	*	<b>Parameters Deprecated</b><br />
	*	The parameters for this method are deprecated in favor of a single parameter that is an Object or {{#crossLink "PlayPropsConfig"}}{{/crossLink}}.
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
	*	Note that pan is not supported for HTML Audio.
	*/
	public function play(?interrupt:Dynamic, ?delay:Float, ?offset:Float, ?loop:Float, ?volume:Float, ?pan:Float):AbstractSoundInstance;
	
	/**
	* Play has failed, which can happen for a variety of reasons.
	*	Cleans up instance and dispatches failed event
	*/
	private function _playFailed():Dynamic;
	
	/**
	* Remove all external references and resources from AbstractSoundInstance.  Note this is irreversible and AbstractSoundInstance will no longer work
	*/
	public function destroy():Dynamic;
	
	/**
	* Stop playback of the instance. Stopped sounds will reset their position to 0, and calls to {{#crossLink "AbstractSoundInstance/resume"}}{{/crossLink}}
	*	will fail. To start playback again, call {{#crossLink "AbstractSoundInstance/play"}}{{/crossLink}}.
	*	
	*	If you don't want to lose your position use yourSoundInstance.paused = true instead. {{#crossLink "AbstractSoundInstance/paused"}}{{/crossLink}}.
	*	
	*	<h4>Example</h4>
	*	
	*	    myInstance.stop();
	*/
	public function stop():AbstractSoundInstance;
	
	/**
	* Takes an PlayPropsConfig or Object with the same properties and sets them on this instance.
	* @param playProps A PlayPropsConfig or object containing the same properties.
	*/
	public function applyPlayProps(playProps:Dynamic):AbstractSoundInstance;
	
	/**
	* The sound has been interrupted.
	*/
	private function _interrupt():Dynamic;
	
}
