package createjs.soundjs;

import js.html.Event;

/**
* Loader provides a mechanism to preload Flash content via PreloadJS or internally. Instances are returned to
*	the preloader, and the load method is called when the asset needs to be requested.
*/
@:native("createjs.FlashAudioLoader")
extern class FlashAudioLoader extends AbstractLoader
{
	/**
	* A list of loader instances that tried to load before _flash was set
	*/
	private var _preloadInstances:Array<Dynamic>;
	
	/**
	* A reference to the Flash instance that gets created.
	*/
	private var flash:Dynamic;
	
	/**
	* ID used to facilitate communication with flash. Not doc'd because this should not be altered externally
	*/
	public var flashId:String;
	
	/**
	* called from flash when loading has progress
	* @param loaded 
	* @param total 
	*/
	private function handleProgress(loaded:Dynamic, total:Dynamic):Dynamic;
	
	/**
	* Called from Flash when sound is loaded.  Set our ready state and fire callbacks / events
	*/
	private function handleComplete():Dynamic;
	
	/**
	* Receive error event from flash and pass it to callback.
	* @param error 
	*/
	private function handleError(error:Event):Dynamic;
	
	/**
	* Set the Flash instance on the class, and start loading on any instances that had load called
	*	before flash was ready
	* @param flash Flash instance that handles loading and playback
	*/
	public function setFlash(flash:Dynamic):Dynamic;
	
}
