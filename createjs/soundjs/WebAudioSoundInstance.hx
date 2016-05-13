package createjs.soundjs;

import js.html.audio.AudioBufferSourceNode;
import js.html.audio.AudioContext;
import js.html.audio.AudioNode;
import js.html.audio.GainNode;

/**
* WebAudioSoundInstance extends the base api of {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} and is used by
*	{{#crossLink "WebAudioPlugin"}}{{/crossLink}}.
*	
*	WebAudioSoundInstance exposes audioNodes for advanced users.
*/
@:native("createjs.WebAudioSoundInstance")
extern class WebAudioSoundInstance extends AbstractSoundInstance
{
	/**
	* Note this is only intended for use by advanced users. <br /> Audio node from WebAudioPlugin that sequences to <code>context.destination</code>
	*/
	public static var destinationNode:AudioNode;
	
	/**
	* NOTE this is only intended for use by advanced users. <br />A panNode allowing left and right audio channel panning only. Connected to WebAudioSoundInstance {{#crossLink "WebAudioSoundInstance/gainNode:property"}}{{/crossLink}}.
	*/
	public var panNode:AudioPannerNode;
	
	/**
	* Note this is only intended for use by advanced users. <br />Audio context used to create nodes.  This is and needs to be the same context used by {{#crossLink "WebAudioPlugin"}}{{/crossLink}}.
	*/
	public static var context:AudioContext;
	
	/**
	* NOTE this is only intended for use by advanced users. <br />GainNode for controlling <code>WebAudioSoundInstance</code> volume. Connected to the {{#crossLink "WebAudioSoundInstance/destinationNode:property"}}{{/crossLink}}.
	*/
	public var gainNode:GainNode;
	
	/**
	* NOTE this is only intended for use by advanced users. <br />sourceNode is the audio source. Connected to WebAudioSoundInstance {{#crossLink "WebAudioSoundInstance/panNode:property"}}{{/crossLink}}.
	*/
	public var sourceNode:AudioNode;
	
	/**
	* Note this is only intended for use by advanced users. <br />The scratch buffer that will be assigned to the buffer property of a source node on close.   This is and should be the same scratch buffer referenced by {{#crossLink "WebAudioPlugin"}}{{/crossLink}}.
	*/
	public static var _scratchBuffer:AudioBufferSourceNode;
	
	/**
	* NOTE this is only intended for use by very advanced users. _sourceNodeNext is the audio source for the next loop, inserted in a look ahead approach to allow for smooth looping. Connected to {{#crossLink "WebAudioSoundInstance/gainNode:property"}}{{/crossLink}}.
	*/
	private var _sourceNodeNext:AudioNode;
	
	/**
	* Time audio started playback, in seconds. Used to handle set position, get position, and resuming from paused.
	*/
	private var _playbackStartTime:Float;
	
	/**
	* Timeout that is created internally to handle sound playing to completion. Stored so we can remove it when stop, pause, or cleanup are called
	*/
	private var _soundCompleteTimeout:TimeoutVariable;
	
	/**
	* Value to set panning model to equal power for WebAudioSoundInstance.  Can be "equalpower" or 0 depending on browser implementation.
	*/
	public static var _panningModel:Dynamic;
	
	/**
	* Creates an audio node using the current src and context, connects it to the gain node, and starts playback.
	* @param startTime The time to add this to the web audio context, in seconds.
	* @param offset The amount of time into the src audio to start playback, in seconds.
	*/
	private function _createAndPlayAudioNode(startTime:Float, offset:Float):AudioNode;
	
	/**
	* Turn off and disconnect an audioNode, then set reference to null to release it for garbage collection
	* @param audioNode 
	*/
	private function _cleanUpAudioNode(audioNode:Dynamic):AudioNode;
	
	/**
	* WebAudioSoundInstance extends the base api of {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} and is used by
	*	{{#crossLink "WebAudioPlugin"}}{{/crossLink}}.
	*	
	*	WebAudioSoundInstance exposes audioNodes for advanced users.
	* @param src The path to and file name of the sound.
	* @param startTime Audio sprite property used to apply an offset, in milliseconds.
	* @param duration Audio sprite property used to set the time the clip plays for, in milliseconds.
	* @param playbackResource Any resource needed by plugin to support audio playback.
	*/
	public function new(src:String, startTime:Float, duration:Float, playbackResource:Dynamic):Void;
	
}
