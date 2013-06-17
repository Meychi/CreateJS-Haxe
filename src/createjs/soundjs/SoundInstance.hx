package createjs.soundjs;

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
*	     var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3");
*	     myInstance.addEventListener("complete", playAgain);
*	     function playAgain(event) {
*	         myInstance.play();
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
extern class SoundInstance
{
	
	/**
	* A Timout created by <code>Sound</code> when this SoundInstance is played with a delay. This allows SoundInstance to remove the delay if stop or pause or cleanup are called before playback begins.
	*/
	private var delayTimeoutId:Dynamic;
	
	/**
	* Determines if the audio is currently muted. Use <code>getMute</code> and <code>setMute</code> to access.
	*/
	private var muted:Bool;
	
	/**
	* Determines if the audio is currently paused. Use <code>pause()</code> and <code>resume()</code> to set.
	*/
	private var paused:Bool;
	
	/**
	* How far into the sound to begin playback in milliseconds. This is passed in when play is called and used by pause and setPosition to track where the sound should be at. Note this is converted from milliseconds to seconds for consistency with the WebAudio API.
	*/
	private var offset:Float;
	
	/**
	* NOTE this only exists as a <code>WebAudioPlugin</code> property and is only intended for use by advanced users. A panNode allowing left and right audio channel panning only. Connected to our <code>WebAudioPlugin.gainNode</code> that sequences to <code>context.destination</code>.
	*/
	public var panNode:Dynamic;
	
	/**
	* NOTE this only exists as a <code>WebAudioPlugin</code> property and is only intended for use by advanced users. GainNode for controlling <code>SoundInstance</code> volume. Connected to <code>panNode</code>.
	*/
	public var gainNode:Dynamic;
	
	/**
	* NOTE this only exists as a <code>WebAudioPlugin</code> property and is only intended for use by advanced users. sourceNode is the audio source. Connected to <code>gainNode</code>.
	*/
	public var sourceNode:Dynamic;
	
	/**
	* NOTE this only exists as a <code>WebAudioPlugin</code> property and is only intended for use by advanced users. sourceNodeNext is the audio source for the next loop, inserted in a look ahead approach to allow for smooth looping. Connected to <code>gainNode</code>.
	*/
	private var sourceNodeNext:Dynamic;
	
	/**
	* The callback that is fired when a sound has been interrupted.
	*/
	public var onPlayInterrupted:Dynamic;
	
	/**
	* The callback that is fired when a sound has completed playback, but has loops remaining.
	*/
	public var onLoop:Dynamic;
	
	/**
	* The callback that is fired when a sound has completed playback.
	*/
	public var onComplete:Dynamic;
	
	/**
	* The callback that is fired when a sound has failed to start.
	*/
	public var onPlayFailed:Dynamic;
	
	/**
	* The callback that is fired when a sound is ready to play.
	*/
	public var onReady:Dynamic;
	
	/**
	* The callback that is fired when playback has started successfully.
	*/
	public var onPlaySucceeded:Dynamic;
	
	/**
	* The length of the audio clip, in milliseconds. Use <code>getDuration</code> to access.
	*/
	private var pan:Float;
	
	/**
	* The number of play loops remaining. Negative values will loop infinitely.
	*/
	private var remainingLoops:Float;
	
	/**
	* The play state of the sound. Play states are defined as constants on <code>Sound</code>.
	*/
	public var playState:String;
	
	/**
	* The plugin that created the instance
	*/
	private var owner:WebAudioPlugin;
	
	/**
	* The source of the sound.
	*/
	private var src:String;
	
	/**
	* The time in milliseconds before the sound starts. Note this is handled by <code>Sound</code>.
	*/
	private var delay:Float;
	
	/**
	* The unique ID of the instance. This is set by <code>Sound</code>.
	*/
	public var uniqueId:Dynamic;
	
	/**
	* The volume of the sound, between 0 and 1. Use <code>getVolume</code> and <code>setVolume</code> to access.
	*/
	private var volume:Float;
	
	/**
	* Timeout that is created internally to handle sound playing to completion. Stored so we can remove it when stop, pause, or cleanup are called
	*/
	private var soundCompleteTimeout:Dynamic;
	
	/**
	* WebAudioPlugin only. Time audio started playback, in seconds. Used to handle set position, get position, and resuming from paused.
	*/
	private var startTime:Float;
	
	/**
	* A helper method that dispatches all events for SoundInstance.
	* @param type The event type
	*/
	private function sendEvent(type:String):Dynamic;
	
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
	*	     var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3");
	*	     myInstance.addEventListener("complete", playAgain);
	*	     function playAgain(event) {
	*	         myInstance.play();
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
	* Called by the Sound class when the audio is ready to play (delay has completed). Starts sound playing if the
	*	src is loaded, otherwise playback will fail.
	* @param offset How far into the sound to begin playback, in milliseconds.
	* @param loop The number of times to loop the audio. Use -1 for infinite loops.
	* @param volume The volume of the sound, between 0 and 1.
	* @param pan The pan of the sound between -1 (left) and 1 (right). Note that pan does not work for HTML Audio.
	*/
	private function beginPlaying(offset:Float, loop:Float, volume:Float, pan:Float):Dynamic;
	
	/**
	* Clean up the instance. Remove references and clean up any additional properties such as timers.
	*/
	private function cleanup():Dynamic;
	
	/**
	* Creates an audio node using the current src and context, connects it to the gain node, and starts playback.
	* @param startTime The time to add this to the web audio context, in seconds.
	* @param offset The amount of time into the src audio to start playback, in seconds.
	*/
	private function createAudioNode(startTime:Float, offset:Float):Dynamic;
	
	/**
	* Get the duration of the instance, in milliseconds. Note in most cases, you need to play a sound using
	*	{{#crossLink "SoundInstance/play"}}{{/crossLink}} or the Sound API {{#crossLink "Sound.play"}}{{/crossLink}}
	*	method before its duration can be reported accurately.
	*	
	*	<h4>Example</h4>
	*	
	*	    var soundDur = myInstance.getDuration();
	*/
	public function getDuration():Float;
	
	/**
	* Get the left/right pan of the instance. Note in WebAudioPlugin this only gives us the "x" value of what is
	*	actually 3D audio.
	*	
	*	<h4>Example</h4>
	*	
	*	    var myPan = myInstance.getPan();
	*/
	public function getPan():Float;
	
	/**
	* Get the mute value of the instance.
	*	
	*	<h4>Example</h4>
	*	
	*	     var isMuted = myInstance.getMute();
	*/
	public function getMute():Bool;
	
	/**
	* Get the position of the playhead in the instance in milliseconds.
	*	
	*	<h4>Example</h4>
	*	
	*	    var currentOffset = myInstance.getPosition();
	*/
	public function getPosition():Float;
	
	/**
	* Get the volume of the instance. The actual output volume of a sound can be calculated using:
	*	<code>myInstance.getVolume() * createjs.Sound.getVolume();</code>
	*/
	public function getVolume():Dynamic;
	
	/**
	* Initialize the SoundInstance. This is called from the constructor.
	* @param src The source of the audio.
	* @param owner The plugin that created this instance.
	*/
	private function init(src:String, owner:Dynamic):Dynamic;
	
	/**
	* Internal function used to update the volume based on the instance volume, master volume, instance mute value,
	*	and master mute value.
	*/
	private function updateVolume():Bool;
	
	/**
	* Mute and unmute the sound. <strong>Please use {{#crossLink "SoundInstance/setMute"}}{{/crossLink}} instead</strong>.
	* @param value If the sound should be muted or not.
	*/
	public function mute(value:Bool):Bool;
	
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
	*	
	*	     var myInstance = createJS.Sound.createInstance(mySrc);
	*	     myInstance.play(createJS.Sound.INTERRUPT_ANY);
	* @param interrupt How this sound interrupts other instances with the same source. Interrupt values
	*	are defined as constants on {{#crossLink "Sound"}}{{/crossLink}}. The default value is <code>Sound.INTERRUPT_NONE</code>.
	* @param delay The delay in milliseconds before the sound starts
	* @param offset How far into the sound to begin playback, in milliseconds.
	* @param loop The number of times to loop the audio. Use -1 for infinite loops.
	* @param volume The volume of the sound, between 0 and 1.
	* @param pan The pan of the sound between -1 (left) and 1 (right). Note that pan is not supported
	*	for HTML Audio.
	*/
	public function play(?interrupt:String, ?delay:Float, ?offset:Float, ?loop:Float, ?volume:Float, ?pan:Float):Dynamic;
	
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
	* Set the left(-1)/right(+1) pan of the instance. Note that {{#crossLink "HTMLAudioPlugin"}}{{/crossLink}} does not
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
	* Set the position of the playhead in the instance. This can be set while a sound is playing, paused, or even
	*	stopped.
	*	
	*	<h4>Example</h4>
	*	
	*	     myInstance.setPosition(myInstance.getDuration()/2); // set audio to its halfway point.
	* @param value The position to place the playhead, in milliseconds.
	*/
	public function setPosition(value:Float):Dynamic;
	
	/**
	* Set the volume of the instance. You can retrieve the volume using {{#crossLink "SoundInstance/getVolume"}}{{/crossLink}}.
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
	private function interrupt():Dynamic;
}
