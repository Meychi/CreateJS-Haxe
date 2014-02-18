package createjs.easeljs;

/**
* Global utility for generating sequential unique ID numbers. The UID class uses a static interface (ex. <code>UID.get()</code>)
*	and should not be instantiated.
*/
@:native("createjs.UID")
extern class UID
{
	private var _nextID:Float;
	
	/**
	* Returns the next unique id.
	*/
	public static function get():Float;
	
}
