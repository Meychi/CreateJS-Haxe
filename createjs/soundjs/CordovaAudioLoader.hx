package createjs.soundjs;

import js.html.svg.Number;

/**
* Loader provides a mechanism to preload Cordova audio content via PreloadJS or internally. Instances are returned to
*	the preloader, and the load method is called when the asset needs to be requested.
*	Currently files are assumed to be local and no loading actually takes place.  This class exists to more easily support
*	the existing architecture.
*/
@:native("createjs.CordovaAudioLoader")
extern class CordovaAudioLoader extends XHRRequest
{
	/**
	* A Media object used to determine if src exists and to get duration
	*/
	private var _media:Media;
	
	/**
	* A time counter that triggers timeout if loading takes too long
	*/
	private var _loadTime:Number;
	
	/**
	* The frequency to fire the loading timer until duration can be retrieved
	*/
	private var _TIMER_FREQUENCY:Number;
	
	/**
	* Fires if audio cannot seek, indicating that src does not exist.
	* @param error 
	*/
	private function _mediaErrorHandler(error:Dynamic):Dynamic;
	
	/**
	* will attempt to get duration of audio until successful or time passes this._item.loadTimeout
	*/
	private function _getMediaDuration():Dynamic;
	
}
