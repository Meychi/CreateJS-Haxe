package createjs.easeljs;

/**
* The ButtonHelper is a helper class to create interactive buttons from {{#crossLink "MovieClip"}}{{/crossLink}} or
*	{{#crossLink "Sprite"}}{{/crossLink}} instances. This class will intercept mouse events from an object, and
*	automatically call {{#crossLink "Sprite/gotoAndStop"}}{{/crossLink}} or {{#crossLink "Sprite/gotoAndPlay"}}{{/crossLink}},
*	to the respective animation labels, add a pointer cursor, and allows the user to define a hit state frame.
*	
*	The ButtonHelper instance does not need to be added to the stage, but a reference should be maintained to prevent
*	garbage collection.
*	
*	Note that over states will not work unless you call {{#crossLink "Stage/enableMouseOver"}}{{/crossLink}}.
*	
*	<h4>Example</h4>
*	
*	     var helper = new createjs.ButtonHelper(myInstance, "out", "over", "down", false, myInstance, "hit");
*	     myInstance.addEventListener("click", handleClick);
*	     function handleClick(event) {
*	         // Click Happened.
*	     }
*/
@:native("createjs.ButtonHelper")
extern class ButtonHelper
{
	/**
	* If true, then ButtonHelper will call gotoAndPlay, if false, it will use gotoAndStop. Default is false.
	*/
	public var play:Bool;
	
	/**
	* The label name or frame number to display when the user mouses out of the target. Defaults to "over".
	*/
	public var overLabel:Dynamic;
	
	/**
	* The label name or frame number to display when the user mouses over the target. Defaults to "out".
	*/
	public var outLabel:Dynamic;
	
	/**
	* The label name or frame number to display when the user presses on the target. Defaults to "down".
	*/
	public var downLabel:Dynamic;
	
	/**
	* The target for this button helper.
	*/
	public var target:Dynamic;
	
	private var _isOver:Bool;
	
	private var _isPressed:Bool;
	
	/**
	* Enables or disables the button functionality on the target.
	* @param value 
	*/
	public function setEnabled(value:Bool):Dynamic;
	
	/**
	* Initialization method.
	* @param target The instance to manage.
	* @param outLabel The label or animation to go to when the user rolls out of the button.
	* @param overLabel The label or animation to go to when the user rolls over the button.
	* @param downLabel The label or animation to go to when the user presses the button.
	* @param play If the helper should call "gotoAndPlay" or "gotoAndStop" on the button when changing
	*	states.
	* @param hitArea An optional item to use as the hit state for the button. If this is not defined,
	*	then the button's visible states will be used instead. Note that the same instance as the "target" argument can be
	*	used for the hitState.
	* @param hitLabel The label or animation on the hitArea instance that defines the hitArea bounds. If this is
	*	null, then the default state of the hitArea will be used.
	*/
	private function initialize(target:Dynamic, ?outLabel:String, ?overLabel:String, ?downLabel:String, ?play:Bool, ?hitArea:DisplayObject, ?hitLabel:String):Dynamic;
	
	/**
	* Returns a string representation of this object.
	*/
	public function toString():String;
	
	/**
	* The ButtonHelper is a helper class to create interactive buttons from {{#crossLink "MovieClip"}}{{/crossLink}} or
	*	{{#crossLink "Sprite"}}{{/crossLink}} instances. This class will intercept mouse events from an object, and
	*	automatically call {{#crossLink "Sprite/gotoAndStop"}}{{/crossLink}} or {{#crossLink "Sprite/gotoAndPlay"}}{{/crossLink}},
	*	to the respective animation labels, add a pointer cursor, and allows the user to define a hit state frame.
	*	
	*	The ButtonHelper instance does not need to be added to the stage, but a reference should be maintained to prevent
	*	garbage collection.
	*	
	*	Note that over states will not work unless you call {{#crossLink "Stage/enableMouseOver"}}{{/crossLink}}.
	*	
	*	<h4>Example</h4>
	*	
	*	     var helper = new createjs.ButtonHelper(myInstance, "out", "over", "down", false, myInstance, "hit");
	*	     myInstance.addEventListener("click", handleClick);
	*	     function handleClick(event) {
	*	         // Click Happened.
	*	     }
	* @param target The instance to manage.
	* @param outLabel The label or animation to go to when the user rolls out of the button.
	* @param overLabel The label or animation to go to when the user rolls over the button.
	* @param downLabel The label or animation to go to when the user presses the button.
	* @param play If the helper should call "gotoAndPlay" or "gotoAndStop" on the button when changing
	*	states.
	* @param hitArea An optional item to use as the hit state for the button. If this is not defined,
	*	then the button's visible states will be used instead. Note that the same instance as the "target" argument can be
	*	used for the hitState.
	* @param hitLabel The label or animation on the hitArea instance that defines the hitArea bounds. If this is
	*	null, then the default state of the hitArea will be used. *
	*/
	public function new(target:Dynamic, ?outLabel:String, ?overLabel:String, ?downLabel:String, ?play:Bool, ?hitArea:DisplayObject, ?hitLabel:String):Void;
	
	private function handleEvent(evt:Dynamic):Dynamic;
	
}
