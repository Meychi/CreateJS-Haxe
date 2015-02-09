package createjs.preloadjs;

import js.html.ProgressEvent;

/**
* A CreateJS {{#crossLink "Event"}}{{/crossLink}} that is dispatched when progress changes.
*/
@:native("createjs.ProgressEvent")
extern class ProgressEvent
{
	/**
	* The amount that has been loaded (out of a total amount)
	*/
	public var loaded:Float;
	
	/**
	* The percentage (out of 1) that the load has been completed. This is calculated using `loaded/total`.
	*/
	public var progress:Float;
	
	/**
	* The total "size" of the load.
	*/
	public var total:Float;
	
	/**
	* A CreateJS {{#crossLink "Event"}}{{/crossLink}} that is dispatched when progress changes.
	* @param loaded The amount that has been loaded. This can be any number relative to the total.
	* @param total The total amount that will load. This will default to 1, so if the `loaded` value is
	*	a percentage (between 0 and 1), it can be omitted.
	*/
	public function new(loaded:Float, ?total:Float):Void;
	
	/**
	* Returns a clone of the ProgressEvent instance.
	*/
	public function clone():ProgressEvent;
	
}
