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
	* Determines if the audio is currently muted.  <br />Note this uses a getter setter, which is not supported by Firefox versions 3.6 or lower, Opera versions 11.50 or lower, and Internet Explorer 8 or lower.  Instead use {{#crossLink "AbstractSoundInstance/setMute"}}{{/crossLink}} and {{#crossLink "AbstractSoundInstance/getMute"}}{{/crossLink}}.
	*/
	public var muted:Bool;
	
	/**
	* Object that holds plugin specific resource need for audio playback. This is set internally by the plugin.  For example, WebAudioPlugin will set an array buffer, HTMLAudioPlugin will set a tag, FlashAudioPlugin will set a flash reference.
	*/
	public var playbackResource:Dynamic;
	
	/**
	* Tells you if the audio is currently paused.  <br />Note this uses a getter setter, which is not supported by Firefox versions 3.6 or lower, Opera versions 11.50 or lower, and Internet Explorer 8 or lower. Use {{#crossLink "AbstractSoundInstance/pause:method"}}{{/crossLink}} and {{#crossLink "AbstractSoundInstance/resume:method"}}{{/crossLink}} to set.
	*/
	public var paused:Bool;
	
	/**
	* The length of the audio clip, in milliseconds.  <br />Note this uses a getter setter, which is not supported by Firefox versions 3.6 or lower, Opera versions 11.50 or lower, and Internet Explorer 8 or lower.  Instead use {{#crossLink "AbstractSoundInstance/setDuration"}}{{/crossLink}} and {{#crossLink "AbstractSoundInstance/getDuration"}}{{/crossLink}}.
	*/
	public var duration:Float;
	
	/**
	* The number of play loops remaining. Negative values will loop infinitely.  <br />Note this uses a getter setter, which is not supported by Firefox versions 3.6 or lower, Opera versions 11.50 or lower, and Internet Explorer 8 or lower.  Instead use {{#crossLink "AbstractSoundInstance/setLoop"}}{{/crossLink}} and {{#crossLink "AbstractSoundInstance/getLoop"}}{{/crossLink}}.
	*/
	public var loop:Float;
	
	/**
	* The pan of the sound, between -1 (left) and 1 (right). Note that pan is not supported by HTML Audio.  <br />Note this uses a getter setter, which is not supported by Firefox versions 3.6 or lower, Opera versions 11.50 or lower, and Internet Explorer 8 or lower.  Instead use {{#crossLink "AbstractSoundInstance/setPan"}}{{/crossLink}} and {{#crossLink "AbstractSoundInstance/getPan"}}{{/crossLink}}. <br />Note in WebAudioPlugin this only gives us the "x" value of what is actually 3D audio.
	*/
	public var pan:Float;
	
	/**
	* The play state of the sound. Play states are defined as constants on {{#crossLink "Sound"}}{{/crossLink}}.
	*/
	public var playState:String;
	
	/**
	* The position of the playhead in milliseconds. This can be set while a sound is playing, paused, or stopped.  <br />Note this uses a getter setter, which is not supported by Firefox versions 3.6 or lower, Opera versions 11.50 or lower, and Internet Explorer 8 or lower.  Instead use {{#crossLink "AbstractSoundInstance/setPosition"}}{{/crossLink}} and {{#crossLink "AbstractSoundInstance/getPosition"}}{{/crossLink}}.
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
	* The volume of the sound, between 0 and 1. <br />Note this uses a getter setter, which is not supported by Firefox versions 3.6 or lower and Opera versions 11.50 or lower, and Internet Explorer 8 or lower.  Instead use {{#crossLink "AbstractSoundInstance/setVolume"}}{{/crossLink}} and {{#crossLink "AbstractSoundInstance/getVolume"}}{{/crossLink}}.  The actual output volume of a sound can be calculated using: <code>myInstance.volume * createjs.Sound.getVolume();</code>
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
	* @param offset How far into the sound to begin playback, in milliseconds.
	* @param loop The number of times to loop the audio. Use -1 for infinite loops.
	* @param volume The volume of the sound, between 0 and 1.
	* @param pan The pan of the sound between -1 (left) and 1 (right). Note that pan does not work for HTML Audio.
	*/
	private function _beginPlaying(offset:Float, loop:Float, volume:Float, pan:Float):Bool;
	
	/**
	* Clean up the instance. Remove references and clean up any additional properties such as timers.
	*/
	private function _cleanUp():Dynamic;
	
	/**
	* Deprecated, please use {{#crossLink "AbstractSoundInstance/paused:property"}}{{/crossLink}} instead.
	*/
	public function pause():Bool;
	
	/**
	* Deprecated, please use {{#crossLink "AbstractSoundInstance/paused:property"}}{{/crossLink}} instead.
	*/
	public function resume():Bool;
	
	/**
	* Handles starting playback when the sound is ready for playing.
	*/
	private function _handleSoundReady():Dynamic;
	
	/**
	* Internal function called when AbstractSoundInstance has played to end and is looping
	*/
	private function _handleCleanUp():Dynamic;
	
	/**
	* Internal function called when looping is added during playback.
	*/
	private function _addLooping():Dynamic;
	
	/**
	* Internal function called when looping is removed during playback.
	*/
	private function _removeLooping():Dynamic;
	
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
	* Internal function used to update the volume based on the instance volume, master volume, instance mute value,
	*	and master mute value.
	*/
	private function _updateVolume():Dynamic;
	
	/**
	* NOTE {{#crossLink "AbstractSoundInstance/duration:property"}}{{/crossLink}} can be accessed directly as a property,
	*	getDuration exists to allow support for IE8 with FlashAudioPlugin.
	*	
	*	Get the duration of the instance, in milliseconds.
	*	Note a sound needs to be loaded before it will have duration, unless it was set manually to create an audio sprite.
	*	
	*	<h4>Example</h4>
	*	
	*	    var soundDur = myInstance.getDuration();
	*/
	public function getDuration():Float;
	
	/**
	* NOTE {{#crossLink "AbstractSoundInstance/duration:property"}}{{/crossLink}} can be accessed directly as a property,
	*	setDuration exists to allow support for IE8 with FlashAudioPlugin.
	*	
	*	Set the duration of the audio.  Generally this is not called, but it can be used to create an audio sprite out of an existing AbstractSoundInstance.
	* @param value The new duration time in milli seconds.
	*/
	public function setDuration(value:Float):AbstractSoundInstance;
	
	/**
	* NOTE {{#crossLink "AbstractSoundInstance/loop:property"}}{{/crossLink}} can be accessed directly as a property,
	*	getLoop exists to allow support for IE8 with FlashAudioPlugin.
	*	
	*	The number of play loops remaining. Negative values will loop infinitely.
	*/
	public function getLoop():Float;
	
	/**
	* NOTE {{#crossLink "AbstractSoundInstance/loop:property"}}{{/crossLink}} can be accessed directly as a property,
	*	setLoop exists to allow support for IE8 with FlashAudioPlugin.
	*	
	*	Set the number of play loops remaining.
	* @param value The number of times to loop after play.
	*/
	public function setLoop(value:Float):Dynamic;
	
	/**
	* NOTE {{#crossLink "AbstractSoundInstance/muted:property"}}{{/crossLink}} can be accessed directly as a property,
	*	getMuted remains to allow support for IE8 with FlashAudioPlugin.
	*	
	*	Get the mute value of the instance.
	*	
	*	<h4>Example</h4>
	*	
	*	     var isMuted = myInstance.getMuted();
	*/
	public function getMute():Bool;
	
	/**
	* NOTE {{#crossLink "AbstractSoundInstance/muted:property"}}{{/crossLink}} can be accessed directly as a property,
	*	setMuted exists to allow support for IE8 with FlashAudioPlugin.
	*	
	*	Mute and unmute the sound. Muted sounds will still play at 0 volume. Note that an unmuted sound may still be
	*	silent depending on {{#crossLink "Sound"}}{{/crossLink}} volume, instance volume, and Sound muted.
	*	
	*	<h4>Example</h4>
	*	
	*	    myInstance.setMuted(true);
	* @param value If the sound should be muted.
	*/
	public function setMute(value:Bool):AbstractSoundInstance;
	
	/**
	* NOTE {{#crossLink "AbstractSoundInstance/pan:property"}}{{/crossLink}} can be accessed directly as a property,
	*	getPan remains to allow support for IE8 with FlashAudioPlugin.
	*	
	*	Get the left/right pan of the instance. Note in WebAudioPlugin this only gives us the "x" value of what is
	*	actually 3D audio.
	*	
	*	<h4>Example</h4>
	*	
	*	    var myPan = myInstance.getPan();
	*/
	public function getPan():Float;
	
	/**
	* NOTE {{#crossLink "AbstractSoundInstance/pan:property"}}{{/crossLink}} can be accessed directly as a property,
	*	getPan remains to allow support for IE8 with FlashAudioPlugin.
	*	
	*	Set the left(-1)/right(+1) pan of the instance. Note that {{#crossLink "HTMLAudioPlugin"}}{{/crossLink}} does not
	*	support panning, and only simple left/right panning has been implemented for {{#crossLink "WebAudioPlugin"}}{{/crossLink}}.
	*	The default pan value is 0 (center).
	*	
	*	<h4>Example</h4>
	*	
	*	    myInstance.setPan(-1);  // to the left!
	* @param value The pan value, between -1 (left) and 1 (right).
	*/
	public function setPan(value:Float):AbstractSoundInstance;
	
	/**
	* NOTE {{#crossLink "AbstractSoundInstance/paused:property"}}{{/crossLink}} can be accessed directly as a property,
	*	and getPaused remains to allow support for IE8 with FlashAudioPlugin.
	*	
	*	Returns true if the instance is currently paused.
	*/
	public function getPaused():Bool;
	
	/**
	* NOTE {{#crossLink "AbstractSoundInstance/paused:property"}}{{/crossLink}} can be accessed directly as a property,
	*	setPaused remains to allow support for IE8 with FlashAudioPlugin.
	*	
	*	Pause or resume the instance.  Note you can also resume playback with {{#crossLink "AbstractSoundInstance/play"}}{{/crossLink}}.
	* @param value 
	*/
	public function setPaused(value:Bool):AbstractSoundInstance;
	
	/**
	* NOTE {{#crossLink "AbstractSoundInstance/playbackResource:property"}}{{/crossLink}} can be accessed directly as a property,
	*	getPlaybackResource exists to allow support for IE8 with FlashAudioPlugin.
	*	
	*	An object containing any resources needed for audio playback, usually set by the plugin.
	* @param value The new playback resource.
	*/
	public function setPlayback(value:Dynamic):Dynamic;
	
	/**
	* NOTE {{#crossLink "AbstractSoundInstance/position:property"}}{{/crossLink}} can be accessed directly as a property,
	*	getPosition remains to allow support for IE8 with FlashAudioPlugin.
	*	
	*	Get the position of the playhead of the instance in milliseconds.
	*	
	*	<h4>Example</h4>
	*	
	*	    var currentOffset = myInstance.getPosition();
	*/
	public function getPosition():Float;
	
	/**
	* NOTE {{#crossLink "AbstractSoundInstance/position:property"}}{{/crossLink}} can be accessed directly as a property,
	*	setPosition remains to allow support for IE8 with FlashAudioPlugin.
	*	
	*	Set the position of the playhead in the instance. This can be set while a sound is playing, paused, or
	*	stopped.
	*	
	*	<h4>Example</h4>
	*	
	*	     myInstance.setPosition(myInstance.getDuration()/2); // set audio to its halfway point.
	* @param value The position to place the playhead, in milliseconds.
	*/
	public function setPosition(value:Float):AbstractSoundInstance;
	
	/**
	* NOTE {{#crossLink "AbstractSoundInstance/volume:property"}}{{/crossLink}} can be accessed directly as a property,
	*	getVolume remains to allow support for IE8 with FlashAudioPlugin.
	*	
	*	Get the volume of the instance. The actual output volume of a sound can be calculated using:
	*	<code>myInstance.getVolume() * createjs.Sound.getVolume();</code>
	*/
	public function getVolume():Float;
	
	/**
	* NOTE {{#crossLink "AbstractSoundInstance/volume:property"}}{{/crossLink}} can be accessed directly as a property,
	*	setVolume remains to allow support for IE8 with FlashAudioPlugin.
	*	
	*	Set the volume of the instance.
	*	
	*	<h4>Example</h4>
	*	
	*	     myInstance.setVolume(0.5);
	*	
	*	Note that the master volume set using the Sound API method {{#crossLink "Sound/setVolume"}}{{/crossLink}}
	*	will be applied to the instance volume.
	* @param value The volume to set, between 0 and 1.
	*/
	public function setVolume(value:Float):AbstractSoundInstance;
	
	/**
	* Play an instance. This method is intended to be called on SoundInstances that already exist (created
	*	with the Sound API {{#crossLink "Sound/createInstance"}}{{/crossLink}} or {{#crossLink "Sound/play"}}{{/crossLink}}).
	*	
	*	<h4>Example</h4>
	*	
	*	     var myInstance = createjs.Sound.createInstance(mySrc);
	*	     myInstance.play({offset:1, loop:2, pan:0.5});	// options as object properties
	*	     myInstance.play(createjs.Sound.INTERRUPT_ANY);	// options as parameters
	*	
	*	Note that if this sound is already playing, this call will do nothing.
	* @param interrupt How to interrupt any currently playing instances of audio with the same source,
	*	if the maximum number of instances of the sound are already playing. Values are defined as <code>INTERRUPT_TYPE</code>
	*	constants on the Sound class, with the default defined by Sound {{#crossLink "Sound/defaultInterruptBehavior:property"}}{{/crossLink}}.
	*	<br /><strong>OR</strong><br />
	*	This parameter can be an object that contains any or all optional properties by name, including: interrupt,
	*	delay, offset, loop, volume, and pan (see the above code sample).
	* @param delay The delay in milliseconds before the sound starts
	* @param offset How far into the sound to begin playback, in milliseconds.
	* @param loop The number of times to loop the audio. Use -1 for infinite loops.
	* @param volume The volume of the sound, between 0 and 1.
	* @param pan The pan of the sound between -1 (left) and 1 (right). Note that pan is not supported
	*	for HTML Audio.
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
	*	will fail.  To start playback again, call {{#crossLink "AbstractSoundInstance/play"}}{{/crossLink}}.
	*	
	*	<h4>Example</h4>
	*	
	*	    myInstance.stop();
	*/
	public function stop():AbstractSoundInstance;
	
	/**
	* The sound has been interrupted.
	*/
	private function _interrupt():Dynamic;
	
}
