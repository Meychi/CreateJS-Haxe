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
	
	private function init():Dynamic;
	
	private function install():Dynamic;
	
	private function priority():Dynamic;
	
	private function step():Dynamic;
	
	private function tween():Dynamic;
	
}
