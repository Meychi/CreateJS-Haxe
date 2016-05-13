package createjs.soundjs;

import js.html.Element;

/**
* HTMLAudioTagPool is an object pool for HTMLAudio tag instances.
*/
@:native("createjs.HTMLAudioTagPool")
extern class HTMLAudioTagPool
{
	/**
	* A hash lookup of each base audio tag, indexed by the audio source.
	*/
	public static var _tags:Dynamic;
	
	/**
	* A hash lookup of if a base audio tag is available, indexed by the audio source
	*/
	public static var _tagsUsed:Dynamic;
	
	/**
	* An object pool for html audio tags
	*/
	public static var _tagPool:TagPool;
	
	/**
	* Delete stored tag reference and return them to pool. Note that if the tag reference does not exist, this will fail.
	* @param src The source for the tag
	*/
	public static function remove(src:String):Bool;
	
	/**
	* Get an audio tag with the given source.
	* @param src The source file used by the audio tag.
	*/
	public static function get(src:String):Dynamic;
	
	/**
	* Gets the duration of the src audio in milliseconds
	* @param src The source file used by the audio tag.
	*/
	public static function getDuration(src:String):Float;
	
	/**
	* Return an audio tag to the pool.
	* @param src The source file used by the audio tag.
	* @param tag Audio tag to set.
	*/
	public static function set(src:String, tag:Element):Dynamic;
	
}
