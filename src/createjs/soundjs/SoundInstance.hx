package createjs.soundjs;

import js.html.audio.AudioNode;
import js.html.audio.GainNode;
import createjs.EventDispatcher;

/**
* A SoundInstance is created when any calls to the Sound API method {{#crossLink "Sound/play"}}{{/crossLink}} or
*	{{#crossLink "Sound/createInstance"}}{{/crossLink}} are made. The SoundInstance is returned by the active plugin
*	for control by the user.
*	
*	<h4>Example</h4>
*	
*	     var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3");
*	
*	A number of additional parameters provide a quick way to determine how a sound is played. Please see the Sound
*	API method {{#crossLink "Sound/play"}}{{/crossLink}} for a list of arguments.
*	
*	Once a SoundInstance is created, a reference can be stored that can be used to control the audio directly through
*	the SoundInstance. If the reference is not stored, the SoundInstance will play out its audio (and any loops), and
*	is then de-referenced from the {{#crossLink "Sound"}}{{/crossLink}} class so that it can be cleaned up. If audio
*	playback has completed, a simple call to the {{#crossLink "SoundInstance/play"}}{{/crossLink}} instance method
*	will rebuild the references the Sound class need to control it.
*	
*	     var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3", {loop:2});
*	     myInstance.addEventListener("loop", handleLoop);
*	     function handleLoop(event) {
*	         myInstance.volume = myInstance.volume * 0.5;
*	     }
*	
*	Events are dispatched from the instance to notify when the sound has completed, looped, or when playback fails
*	
*	     var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3");
*	     myInstance.addEventListener("complete", handleComplete);
*	     myInstance.addEventListener("loop", handleLoop);
*	     myInstance.addEventListener("failed", handleFailed);
*/
@:native("createjs.SoundInstance")
extern class SoundInstance extends EventDispatcher
{
	/**
	* A Timeout created by {{#crossLink "Sound"}}{{/crossLink}} when this SoundInstance is played with a delay. This allows SoundInstance to remove the delay if stop or pause or cleanup are called before playback begins.
	*/
	private var delayTimeoutId:Dynamic;
	
	/**
	* Determines if the audio is currently muted. Use {{#crossLink "SoundInstance/getMute:method"}}{{/crossLink}} and {{#crossLink "SoundInstance/setMute:method"}}{{/crossLink}} to access.
	*/
	private var _muted:Bool;
	
	/**
	* How far into the sound to begin playback in milliseconds. This is passed in when play is called and used by pause and setPosition to track where the sound should be at. Note this is converted from milliseconds to seconds for consistency with the WebAudio API.
	*/
	private var _offset:Float;
	
	/**
	* NOTE this only exists as a {{#crossLink "WebAudioPlugin"}}{{/crossLink}} property and is only intended for use by advanced users. <br />A panNode allowing left and right audio channel panning only. Connected to SoundInstance {{#crossLink "SoundInstance/gainNode:property"}}{{/crossLink}}.
	*/
	public var panNode:Dynamic;
	
	/**
	* NOTE this only exists as a {{#crossLink "WebAudioPlugin"}}{{/crossLink}} property and is only intended for use by advanced users. <br />GainNode for controlling <code>SoundInstance</code> volume. Connected to the WebAudioPlugin {{#crossLink "WebAudioPlugin/gainNode:property"}}{{/crossLink}} that sequences to <code>context.destination</code>.
	*/
	public var gainNode:GainNode;
	
	/**
	* NOTE this only exists as a {{#crossLink "WebAudioPlugin"}}{{/crossLink}} property and is only intended for use by advanced users. <br />sourceNode is the audio source. Connected to SoundInstance {{#crossLink "SoundInstance/panNode:property"}}{{/crossLink}}.
	*/
	public var sourceNode:AudioNode;
	
	/**
	* NOTE this only exists as a {{#crossLink "WebAudioPlugin"}}{{/crossLink}} property and is only intended for use by advanced users. _sourceNodeNext is the audio source for the next loop, inserted in a look ahead approach to allow for smooth looping. Connected to {{#crossLink "SoundInstance/gainNode:property"}}{{/crossLink}}.
	*/
	private var _sourceNodeNext:AudioNode;
	
	/**
	* Read only value that tells you if the audio is currently paused. Use {{#crossLink "SoundInstance/pause:method"}}{{/crossLink}} and {{#crossLink "SoundInstance/resume:method"}}{{/crossLink}} to set.
	*/
	public var paused:Bool;
	
	/**
	* REMOVED. Use {{#crossLink "EventDispatcher/addEventListener"}}{{/crossLink}} and the {{#crossLink "SoundInstance/complete:event"}}{{/crossLink}} event.
	*/
	public var onComplete:Dynamic;
	
	/**
	* The length of the audio clip, in milliseconds. Use {{#crossLink "SoundInstance/getDuration:method"}}{{/crossLink}} to access.
	*/
	private var _duration:Float;
	
	/**
	* The number of play loops remaining. Negative values will loop infinitely.
	*/
	private var _remainingLoops:Float;
	
	/**
	* The pan of the sound, between -1 (left) and 1 (right). Note that pan is not supported by HTML Audio.  <br />Note this uses a getter setter, which is not supported by Firefox versions 3.6 or lower, Opera versions 11.50 or lower, and Internet Explorer 8 or lower.  Instead use {{#crossLink "SoundInstance/setPan"}}{{/crossLink}} and {{#crossLink "SoundInstance/getPan"}}{{/crossLink}}. <br />Note in WebAudioPlugin this only gives us the "x" value of what is actually 3D audio.
	*/
	public var pan:Float;
	
	/**
	* The play state of the sound. Play states are defined as constants on {{#crossLink "Sound"}}{{/crossLink}}.
	*/
	public var playState:String;
	
	/**
	* The plugin that created the instance
	*/
	private var _owner:WebAudioPlugin;
	
	/**
	* The source of the sound.
	*/
	public var src:String;
	
	/**
	* The time in milliseconds before the sound starts. Note this is handled by {{#crossLink "Sound"}}{{/crossLink}}.
	*/
	private var _delay:Float;
	
	/**
	* The unique ID of the instance. This is set by {{#crossLink "Sound"}}{{/crossLink}}.
	*/
	public var uniqueId:Dynamic;
	
	/**
	* The volume of the sound, between 0 and 1. <br />Note this uses a getter setter, which is not supported by Firefox versions 3.6 or lower and Opera versions 11.50 or lower, and Internet Explorer 8 or lower.  Instead use {{#crossLink "SoundInstance/setVolume"}}{{/crossLink}} and {{#crossLink "SoundInstance/getVolume"}}{{/crossLink}}.  The actual output volume of a sound can be calculated using: <code>myInstance.volume * createjs.Sound.getVolume();</code>
	*/
	public var volume:Float;
	
	/**
	* Timeout that is created internally to handle sound playing to completion. Stored so we can remove it when stop, pause, or cleanup are called
	*/
	private var _soundCompleteTimeout:Dynamic;
	
	/**
	* WebAudioPlugin only. Time audio started playback, in seconds. Used to handle set position, get position, and resuming from paused.
	*/
	private var _startTime:Float;
	
	/**
	* A helper method that dispatches all events for SoundInstance.
	* @param type The event type
	*/
	private function _sendEvent(type:String):Dynamic;
	
	/**
	* A SoundInstance is created when any calls to the Sound API method {{#crossLink "Sound/play"}}{{/crossLink}} or
	*	{{#crossLink "Sound/createInstance"}}{{/crossLink}} are made. The SoundInstance is returned by the active plugin
	*	for control by the user.
	*	
	*	<h4>Example</h4>
	*	
	*	     var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3");
	*	
	*	A number of additional parameters provide a quick way to determine how a sound is played. Please see the Sound
	*	API method {{#crossLink "Sound/play"}}{{/crossLink}} for a list of arguments.
	*	
	*	Once a SoundInstance is created, a reference can be stored that can be used to control the audio directly through
	*	the SoundInstance. If the reference is not stored, the SoundInstance will play out its audio (and any loops), and
	*	is then de-referenced from the {{#crossLink "Sound"}}{{/crossLink}} class so that it can be cleaned up. If audio
	*	playback has completed, a simple call to the {{#crossLink "SoundInstance/play"}}{{/crossLink}} instance method
	*	will rebuild the references the Sound class need to control it.
	*	
	*	     var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3", {loop:2});
	*	     myInstance.addEventListener("loop", handleLoop);
	*	     function handleLoop(event) {
	*	         myInstance.volume = myInstance.volume * 0.5;
	*	     }
	*	
	*	Events are dispatched from the instance to notify when the sound has completed, looped, or when playback fails
	*	
	*	     var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3");
	*	     myInstance.addEventListener("complete", handleComplete);
	*	     myInstance.addEventListener("loop", handleLoop);
	*	     myInstance.addEventListener("failed", handleFailed);
	* @param src The path to and file name of the sound.
	* @param owner The plugin instance that created this SoundInstance.
	*/
	public function new(src:String, owner:Dynamic):Void;
	
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
	private function _beginPlaying(offset:Float, loop:Float, volume:Float, pan:Float):Dynamic;
	
	/**
	* Clean up the instance. Remove references and clean up any additional properties such as timers.
	*/
	private function _cleanUp():Dynamic;
	
	/**
	* Creates an audio node using the current src and context, connects it to the gain node, and starts playback.
	* @param startTime The time to add this to the web audio context, in seconds.
	* @param offset The amount of time into the src audio to start playback, in seconds.
	*/
	private function _createAndPlayAudioNode(startTime:Float, offset:Float):AudioNode;
	
	/**
	* Get the duration of the instance, in milliseconds. Note in most cases, you need to play a sound using
	*	{{#crossLink "SoundInstance/play"}}{{/crossLink}} or the Sound API {{#crossLink "Sound/play"}}{{/crossLink}}
	*	method before its duration can be reported accurately.
	*	
	*	<h4>Example</h4>
	*	
	*	    var soundDur = myInstance.getDuration();
	*/
	public function getDuration():Float;
	
	/**
	* Get the mute value of the instance.
	*	
	*	<h4>Example</h4>
	*	
	*	     var isMuted = myInstance.getMute();
	*/
	public function getMute():Bool;
	
	/**
	* Get the position of the playhead of the instance in milliseconds.
	*	
	*	<h4>Example</h4>
	*	
	*	    var currentOffset = myInstance.getPosition();
	*/
	public function getPosition():Float;
	
	/**
	* Handles starting playback when the sound is ready for playing.
	*/
	private function _handleSoundReady():Dynamic;
	
	/**
	* Initialize the SoundInstance. This is called from the constructor.
	* @param src The source of the audio.
	* @param owner The plugin that created this instance.
	*/
	private function _init(src:String, owner:Dynamic):Dynamic;
	
	/**
	* Internal function used to update the volume based on the instance volume, master volume, instance mute value,
	*	and master mute value.
	*/
	private function _updateVolume():Bool;
	
	/**
	* Mute and unmute the sound. Muted sounds will still play at 0 volume. Note that an unmuted sound may still be
	*	silent depending on {{#crossLink "Sound"}}{{/crossLink}} volume, instance volume, and Sound mute.
	*	
	*	<h4>Example</h4>
	*	
	*	    myInstance.setMute(true);
	* @param value If the sound should be muted.
	*/
	public function setMute(value:Bool):Bool;
	
	/**
	* NOTE that you can access pan directly as a property, and getPan remains to allow support for IE8 with FlashPlugin.
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
	* NOTE that you can access volume directly as a property, and getVolume remains to allow support for IE8 with FlashPlugin.
	*	
	*	Get the volume of the instance. The actual output volume of a sound can be calculated using:
	*	<code>myInstance.getVolume() * createjs.Sound.getVolume();</code>
	*/
	public function getVolume():Dynamic;
	
	/**
	* NOTE that you can set pan directly as a property, and getPan remains to allow support for IE8 with FlashPlugin.
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
	public function setPan(value:Float):Float;
	
	/**
	* NOTE that you can set volume directly as a property, and setVolume remains to allow support for IE8 with FlashPlugin.
	*	Set the volume of the instance. You can retrieve the volume using {{#crossLink "SoundInstance/getVolume"}}{{/crossLink}}.
	*	
	*	<h4>Example</h4>
	*	
	*	     myInstance.setVolume(0.5);
	*	
	*	Note that the master volume set using the Sound API method {{#crossLink "Sound/setVolume"}}{{/crossLink}}
	*	will be applied to the instance volume.
	* @param value The volume to set, between 0 and 1.
	*/
	public function setVolume(value:Dynamic):Bool;
	
	/**
	* Pause the instance. Paused audio will stop at the current time, and can be resumed using
	*	{{#crossLink "SoundInstance/resume"}}{{/crossLink}}.
	*	
	*	<h4>Example</h4>
	*	
	*	     myInstance.pause();
	*/
	public function pause():Bool;
	
	/**
	* Play an instance. This method is intended to be called on SoundInstances that already exist (created
	*	with the Sound API {{#crossLink "Sound/createInstance"}}{{/crossLink}} or {{#crossLink "Sound/play"}}{{/crossLink}}).
	*	
	*	<h4>Example</h4>
	*	     var myInstance = createjs.Sound.createInstance(mySrc);
	*	     myInstance.play({offset:1, loop:2, pan:0.5});	// options as object properties
	*	     myInstance.play(createjs.Sound.INTERRUPT_ANY);	// options as parameters
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
	public function play(?interrupt:Dynamic, ?delay:Float, ?offset:Float, ?loop:Float, ?volume:Float, ?pan:Float):Dynamic;
	
	/**
	* Resume an instance that has been paused using {{#crossLink "SoundInstance/pause"}}{{/crossLink}}. Audio that
	*	has not been paused will not playback when this method is called.
	*	
	*	<h4>Example</h4>
	*	
	*	    myInstance.pause();
	*	    // do some stuff
	*	    myInstance.resume();
	*/
	public function resume():Bool;
	
	/**
	* Set the position of the playhead in the instance. This can be set while a sound is playing, paused, or
	*	stopped.
	*	
	*	<h4>Example</h4>
	*	
	*	     myInstance.setPosition(myInstance.getDuration()/2); // set audio to its halfway point.
	* @param value The position to place the playhead, in milliseconds.
	*/
	public function setPosition(value:Float):Dynamic;
	
	/**
	* Stop playback of the instance. Stopped sounds will reset their position to 0, and calls to {{#crossLink "SoundInstance/resume"}}{{/crossLink}}
	*	will fail.  To start playback again, call {{#crossLink "SoundInstance/play"}}{{/crossLink}}.
	*	
	*	<h4>Example</h4>
	*	
	*	    myInstance.stop();
	*/
	public function stop():Bool;
	
	/**
	* The sound has been interrupted.
	*/
	private function _interrupt():Dynamic;
	
	/**
	* Turn off and disconnect an audioNode, then set reference to null to release it for garbage collection
	* @param audioNode 
	*/
	private function _cleanUpAudioNode(audioNode:Dynamic):AudioNode;
	
}
