package createjs.soundjs;

import js.html.audio.AudioContext;

/**
* Loader provides a mechanism to preload Web Audio content via PreloadJS or internally. Instances are returned to
*	the preloader, and the load method is called when the asset needs to be requested.
*/
@:native("createjs.WebAudioLoader")
extern class WebAudioLoader extends XHRRequest
{
	/**
	* web audio context required for decoding audio
	*/
	public static var context:AudioContext;
	
	/**
	* The audio has been decoded.
	* @param decoded 
	*/
	private function handleAudioDecoded(decoded:Dynamic):Dynamic;
	
}
