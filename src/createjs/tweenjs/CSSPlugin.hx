package createjs.tweenjs;

/**
* A TweenJS plugin for working with numeric CSS string properties (ex. top, left). To use simply install after
*	TweenJS has loaded:
*	
*	     createjs.CSSPlugin.install();
*	
*	You can adjust the CSS properties it will work with by modifying the <code>cssSuffixMap</code> property. Currently,
*	the top, left, bottom, right, width, height have a "px" suffix appended.
*	
*	Please note that the CSS Plugin is not included in the TweenJS minified file.
*/
@:native("createjs.CSSPlugin")
extern class CSSPlugin
{
	/**
	* Defines the default suffix map for CSS tweens. This can be overridden on a per tween basis by specifying a cssSuffixMap value for the individual tween. The object maps CSS property names to the suffix to use when reading or setting those properties. For example a map in the form {top:"px"} specifies that when tweening the "top" CSS property, it should use the "px" suffix (ex. target.style.top = "20.5px"). This only applies to tweens with the "css" config property set to true.
	*/
	public static var cssSuffixMap:Dynamic;
	
	public static var priority:Dynamic;
	
	/**
	* A TweenJS plugin for working with numeric CSS string properties (ex. top, left). To use simply install after
	*	TweenJS has loaded:
	*	
	*	     createjs.CSSPlugin.install();
	*	
	*	You can adjust the CSS properties it will work with by modifying the <code>cssSuffixMap</code> property. Currently,
	*	the top, left, bottom, right, width, height have a "px" suffix appended.
	*	
	*	Please note that the CSS Plugin is not included in the TweenJS minified file.
	*/
	public function new():Void;
	
	/**
	* Installs this plugin for use with TweenJS. Call this once after TweenJS is loaded to enable this plugin.
	*/
	public static function install():Dynamic;
	
	private static function init():Dynamic;
	
	private static function step():Dynamic;
	
	private static function tween():Dynamic;
	
}
