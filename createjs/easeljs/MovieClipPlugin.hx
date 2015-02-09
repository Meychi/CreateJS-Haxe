package createjs.easeljs;

/**
* This plugin works with <a href="http://tweenjs.com" target="_blank">TweenJS</a> to prevent the startPosition
*	property from tweening.
*/
@:native("createjs.MovieClipPlugin")
extern class MovieClipPlugin
{
	/**
	* This plugin works with <a href="http://tweenjs.com" target="_blank">TweenJS</a> to prevent the startPosition
	*	property from tweening.
	*/
	public function new():Void;
	
	private function init(tween:Tween, prop:String, value:Dynamic):Dynamic;
	
	private function install():Dynamic;
	
	private function priority():Dynamic;
	
	private function step():Dynamic;
	
	public function tween(tween:Tween, prop:String, value:Dynamic, startValues:Array<Dynamic>, endValues:Array<Dynamic>, ratio:Float, wait:Dynamic, end:Dynamic):*;
	
}
