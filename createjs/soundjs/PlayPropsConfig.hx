package createjs.soundjs;

import js.html.svg.Number;

/**
* A class to store the optional play properties passed in {{#crossLink "Sound/play"}}{{/crossLink}} and
*	{{#crossLink "AbstractSoundInstance/play"}}{{/crossLink}} calls.
*	
*	Optional Play Properties Include:
*	<ul>
*	<li>interrupt - How to interrupt any currently playing instances of audio with the same source,
*	if the maximum number of instances of the sound are already playing. Values are defined as <code>INTERRUPT_TYPE</code>
*	constants on the Sound class, with the default defined by {{#crossLink "Sound/defaultInterruptBehavior:property"}}{{/crossLink}}.</li>
*	<li>delay - The amount of time to delay the start of audio playback, in milliseconds.</li>
*	<li>offset - The offset from the start of the audio to begin playback, in milliseconds.</li>
*	<li>loop - How many times the audio loops when it reaches the end of playback. The default is 0 (no
*	loops), and -1 can be used for infinite playback.</li>
*	<li>volume - The volume of the sound, between 0 and 1. Note that the master volume is applied
*	against the individual volume.</li>
*	<li>pan - The left-right pan of the sound (if supported), between -1 (left) and 1 (right).</li>
*	<li>startTime - To create an audio sprite (with duration), the initial offset to start playback and loop from, in milliseconds.</li>
*	<li>duration - To create an audio sprite (with startTime), the amount of time to play the clip for, in milliseconds.</li>
*	</ul>
*	
*	<h4>Example</h4>
*	
*		var ppc = new createjs.PlayPropsConfig().set({interrupt: createjs.Sound.INTERRUPT_ANY, loop: -1, volume: 0.5})
*		createjs.Sound.play("mySound", ppc);
*		mySoundInstance.play(ppc);
*/
@:native("createjs.PlayPropsConfig")
extern class PlayPropsConfig
{
	/**
	* How many times the audio loops when it reaches the end of playback. The default is 0 (no loops), and -1 can be used for infinite playback.
	*/
	public var loop:Number;
	
	/**
	* How to interrupt any currently playing instances of audio with the same source, if the maximum number of instances of the sound are already playing. Values are defined as <code>INTERRUPT_TYPE</code> constants on the Sound class, with the default defined by {{#crossLink "Sound/defaultInterruptBehavior:property"}}{{/crossLink}}.
	*/
	public var interrupt:String;
	
	/**
	* The amount of time to delay the start of audio playback, in milliseconds.
	*/
	public var delay:Float;
	
	/**
	* The left-right pan of the sound (if supported), between -1 (left) and 1 (right).
	*/
	public var pan:Number;
	
	/**
	* The offset from the start of the audio to begin playback, in milliseconds.
	*/
	public var offset:Number;
	
	/**
	* The volume of the sound, between 0 and 1. Note that the master volume is applied against the individual volume.
	*/
	public var volume:Number;
	
	/**
	* Used to create an audio sprite (with duration), the initial offset to start playback and loop from, in milliseconds.
	*/
	public var startTime:Number;
	
	/**
	* Used to create an audio sprite (with startTime), the amount of time to play the clip for, in milliseconds.
	*/
	public var duration:Number;
	
	/**
	* A class to store the optional play properties passed in {{#crossLink "Sound/play"}}{{/crossLink}} and
	*	{{#crossLink "AbstractSoundInstance/play"}}{{/crossLink}} calls.
	*	
	*	Optional Play Properties Include:
	*	<ul>
	*	<li>interrupt - How to interrupt any currently playing instances of audio with the same source,
	*	if the maximum number of instances of the sound are already playing. Values are defined as <code>INTERRUPT_TYPE</code>
	*	constants on the Sound class, with the default defined by {{#crossLink "Sound/defaultInterruptBehavior:property"}}{{/crossLink}}.</li>
	*	<li>delay - The amount of time to delay the start of audio playback, in milliseconds.</li>
	*	<li>offset - The offset from the start of the audio to begin playback, in milliseconds.</li>
	*	<li>loop - How many times the audio loops when it reaches the end of playback. The default is 0 (no
	*	loops), and -1 can be used for infinite playback.</li>
	*	<li>volume - The volume of the sound, between 0 and 1. Note that the master volume is applied
	*	against the individual volume.</li>
	*	<li>pan - The left-right pan of the sound (if supported), between -1 (left) and 1 (right).</li>
	*	<li>startTime - To create an audio sprite (with duration), the initial offset to start playback and loop from, in milliseconds.</li>
	*	<li>duration - To create an audio sprite (with startTime), the amount of time to play the clip for, in milliseconds.</li>
	*	</ul>
	*	
	*	<h4>Example</h4>
	*	
	*		var ppc = new createjs.PlayPropsConfig().set({interrupt: createjs.Sound.INTERRUPT_ANY, loop: -1, volume: 0.5})
	*		createjs.Sound.play("mySound", ppc);
	*		mySoundInstance.play(ppc);
	*/
	public function new():Void;
	
	/**
	* Creates a PlayPropsConfig from another PlayPropsConfig or an Object.
	* @param value The play properties
	*/
	public static function create(value:Dynamic):PlayPropsConfig;
	
	/**
	* Provides a chainable shortcut method for setting a number of properties on the instance.
	*	
	*	<h4>Example</h4>
	*	
	*	     var PlayPropsConfig = new createjs.PlayPropsConfig().set({loop:-1, volume:0.7});
	* @param props A generic object containing properties to copy to the PlayPropsConfig instance.
	*/
	public function set(props:Dynamic):PlayPropsConfig;
	
}
