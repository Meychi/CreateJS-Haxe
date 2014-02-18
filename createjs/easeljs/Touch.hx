package createjs.easeljs;

/**
* Global utility for working with multi-touch enabled devices in EaselJS. Currently supports W3C Touch API (iOS and
*	modern Android browser) and the Pointer API (IE), including ms-prefixed events in IE10, and unprefixed in IE11.
*	
*	Ensure that you {{#crossLink "Touch/disable"}}{{/crossLink}} touch when cleaning up your application. You do not have
*	to check if touch is supported to enable it, as it will fail gracefully if it is not supported.
*	
*	<h4>Example</h4>
*	
*	     var stage = new createjs.Stage("canvasId");
*	     createjs.Touch.enable(stage);
*	
*	<strong>Note:</strong> It is important to disable Touch on a stage that you are no longer using:
*	
*	     createjs.Touch.disable(stage);
*/
@:native("createjs.Touch")
extern class Touch
{
	/**
	* Enables touch interaction for the specified EaselJS {{#crossLink "Stage"}}{{/crossLink}}. Currently supports iOS
	*	(and compatible browsers, such as modern Android browsers), and IE10/11. Supports both single touch and
	*	multi-touch modes. Extends the EaselJS {{#crossLink "MouseEvent"}}{{/crossLink}} model, but without support for
	*	double click or over/out events. See the MouseEvent {{#crossLink "MouseEvent/pointerId:property"}}{{/crossLink}}
	*	for more information.
	* @param stage The {{#crossLink "Stage"}}{{/crossLink}} to enable touch on.
	* @param singleTouch If `true`, only a single touch will be active at a time.
	* @param allowDefault If `true`, then default gesture actions (ex. scrolling, zooming) will be
	*	allowed when the user is interacting with the target canvas.
	*/
	public static function enable(stage:Stage, ?singleTouch:Bool, ?allowDefault:Bool):Bool;
	
	/**
	* Removes all listeners that were set up when calling `Touch.enable()` on a stage.
	* @param stage The {{#crossLink "Stage"}}{{/crossLink}} to disable touch on.
	*/
	public static function disable(stage:Stage):Dynamic;
	
	/**
	* Returns `true` if touch is supported in the current browser.
	*/
	public static function isSupported():Bool;
	
	private function _handleEnd(stage:Stage, id:Dynamic, e:Dynamic):Dynamic;
	
	private function _handleMove(stage:Stage, id:Dynamic, e:Dynamic, x:Float, y:Float):Dynamic;
	
	private function _handleStart(stage:Stage, id:Dynamic, e:Dynamic, x:Float, y:Float):Dynamic;
	
	private static function _IE_disable(stage:Stage):Dynamic;
	
	private static function _IE_enable(stage:Stage):Dynamic;
	
	private static function _IE_handleEvent(stage:Stage, e:Dynamic):Dynamic;
	
	private static function _IOS_disable(stage:Stage):Dynamic;
	
	private static function _IOS_enable(stage:Stage):Dynamic;
	
	private static function _IOS_handleEvent(stage:Stage, e:Dynamic):Dynamic;
	
}
