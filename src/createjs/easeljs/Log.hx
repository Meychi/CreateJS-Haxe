package createjs.easeljs;

/**
* Log provides a centralized system for outputting errors. By default it will attempt to use console.log
*	to output messages, but this can be changed by setting the out property.
*/
@:native("createjs.Log")
extern class Log
{
	/**
	* Read-only. Error messages.
	*/
	public static var ERROR:Float;
	
	/**
	* Read-only. Output all messages.
	*/
	public static var ALL:Float;
	
	/**
	* Read-only. Output no messages.
	*/
	public static var NONE:Float;
	
	/**
	* Read-only. Trace messages.
	*/
	public static var TRACE:Float;
	
	/**
	* Read-only. Warning messages.
	*/
	public static var WARNING:Float;
	
	/**
	* Specifies the level of messages to output. For example, if you set <code>Log.level = Log.WARNING</code>, then any  messages with a level of 2 (Log.WARNING) or less (ex. Log.ERROR) will be output. Defaults to Log.ALL.
	*/
	public static var out:Dynamic;
	
	public static var _keys:Array<Dynamic>;
	
	/**
	* Adds a definition object that associates one or more keys with longer messages. 
	*	These messages can optionally include "%DETAILS%" which will be replaced by any details passed
	*	with the error. For example:<br/>
	*	Log.addKeys( {MY_ERROR:"This is a description of my error [%DETAILS%]"} );
	*	Log.error( "MY_ERROR" , 5 ); // outputs "This is a description of my error [5]"
	* @param keys The generic object defining the keys and messages.
	*/
	public static function addKeys(keys:Dynamic):Dynamic;
	
	/**
	* Log provides a centralized system for outputting errors. By default it will attempt to use console.log
	*	to output messages, but this can be changed by setting the out property.
	*/
	public function new():Void;
	
	/**
	* Outputs the specified error via the method assigned to the "out" property. If the error matches a key in any of the
	*	loaded def objects, it will substitute that message.
	* @param message The error message or key to output.
	* @param details Any details associated with this message.
	* @param level A number between 1 and 254 specifying the severity of this message. See Log.level for details.
	*/
	public static function error(message:String, details:Dynamic, level:Float):Dynamic;
	
}
