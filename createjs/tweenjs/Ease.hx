package createjs.tweenjs;

/**
* The Ease class provides a collection of easing functions for use with TweenJS. It does not use the standard 4 param
*	easing signature. Instead it uses a single param which indicates the current linear ratio (0 to 1) of the tween.
*	
*	Most methods on Ease can be passed directly as easing functions:
*	
*	     Tween.get(target).to({x:100}, 500, Ease.linear);
*	
*	However, methods beginning with "get" will return an easing function based on parameter values:
*	
*	     Tween.get(target).to({y:200}, 500, Ease.getPowIn(2.2));
*	
*	Please see the <a href="http://www.createjs.com/Demos/TweenJS/Tween_SparkTable">spark table demo</a> for an
*	overview of the different ease types on <a href="http://tweenjs.com">TweenJS.com</a>.
*	
*	<em>Equations derived from work by Robert Penner.</em>
*/
@:native("createjs.Ease")
extern class Ease
{
	/**
	* Configurable "back in out" ease.
	* @param amount The strength of the ease.
	*/
	public static function getBackInOut(amount:Float):Dynamic;
	
	/**
	* Configurable "back in" ease.
	* @param amount The strength of the ease.
	*/
	public static function getBackIn(amount:Float):Dynamic;
	
	/**
	* Configurable "back out" ease.
	* @param amount The strength of the ease.
	*/
	public static function getBackOut(amount:Float):Dynamic;
	
	/**
	* Configurable elastic ease.
	* @param amplitude 
	* @param period 
	*/
	public static function getElasticIn(amplitude:Float, period:Float):Dynamic;
	
	/**
	* Configurable elastic ease.
	* @param amplitude 
	* @param period 
	*/
	public static function getElasticInOut(amplitude:Float, period:Float):Dynamic;
	
	/**
	* Configurable elastic ease.
	* @param amplitude 
	* @param period 
	*/
	public static function getElasticOut(amplitude:Float, period:Float):Dynamic;
	
	/**
	* Configurable exponential ease.
	* @param pow The exponent to use (ex. 3 would return a cubic ease).
	*/
	public static function getPowIn(pow:Float):Dynamic;
	
	/**
	* Configurable exponential ease.
	* @param pow The exponent to use (ex. 3 would return a cubic ease).
	*/
	public static function getPowInOut(pow:Float):Dynamic;
	
	/**
	* Configurable exponential ease.
	* @param pow The exponent to use (ex. 3 would return a cubic ease).
	*/
	public static function getPowOut(pow:Float):Dynamic;
	
	/**
	* Identical to linear.
	* @param t 
	*/
	public static function none(t:Float):Float;
	
	/**
	* Mimics the simple -100 to 100 easing in Adobe Flash/Animate.
	* @param amount A value from -1 (ease in) to 1 (ease out) indicating the strength and direction of the ease.
	*/
	public static function get(amount:Float):Dynamic;
	
	public static function backIn(t:Float):Float;
	
	public static function backInOut(t:Float):Float;
	
	public static function backOut(t:Float):Float;
	
	public static function bounceIn(t:Float):Float;
	
	public static function bounceInOut(t:Float):Float;
	
	public static function bounceOut(t:Float):Float;
	
	public static function circIn(t:Float):Float;
	
	public static function circInOut(t:Float):Float;
	
	public static function circOut(t:Float):Float;
	
	public static function cubicIn(t:Float):Float;
	
	public static function cubicInOut(t:Float):Float;
	
	public static function cubicOut(t:Float):Float;
	
	public static function elasticIn(t:Float):Float;
	
	public static function elasticInOut(t:Float):Float;
	
	public static function elasticOut(t:Float):Float;
	
	public static function linear(t:Float):Float;
	
	public static function quadIn(t:Float):Float;
	
	public static function quadInOut(t:Float):Float;
	
	public static function quadOut(t:Float):Float;
	
	public static function quartIn(t:Float):Float;
	
	public static function quartInOut(t:Float):Float;
	
	public static function quartOut(t:Float):Float;
	
	public static function quintIn(t:Float):Float;
	
	public static function quintInOut(t:Float):Float;
	
	public static function quintOut(t:Float):Float;
	
	public static function sineIn(t:Float):Float;
	
	public static function sineInOut(t:Float):Float;
	
	public static function sineOut(t:Float):Float;
	
}
