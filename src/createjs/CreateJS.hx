package createjs;

/**
* Various utilities that the CreateJS Suite uses. Utilities are created as separate files, and will be available on the
*	createjs namespace directly:
*	
*	<h4>Example</h4>
*	     myObject.addEventListener("change", createjs.proxy(myMethod, scope));
*/
@:native("createjs")
extern class CreateJS
{
	/**
	* A function proxy for methods. By default, JavaScript methods do not maintain scope, so passing a method as a
	*	callback will result in the method getting called in the scope of the caller. Using a proxy ensures that the
	*	method gets called in the correct scope.
	*	
	*	Additional arguments can be passed that will be applied to the function when it is called.
	*	
	*	<h4>Example</h4>
	*	     myObject.addEventListener("event", createjs.proxy(myHandler, this, arg1, arg2));
	*	
	*	     function myHandler(arg1, arg2) {
	*	          // This gets called when myObject.myCallback is executed.
	*	     }
	* @param method The function to call
	* @param scope The scope to call the method name on
	* @param arg * Arguments that are appended to the callback for additional params.
	*/
	public static function proxy(method:Dynamic, scope:Dynamic, ?arg:Dynamic):Dynamic;
	
	/**
	* Finds the first occurrence of a specified value searchElement in the passed in array, and returns the index of
	*	that value.  Returns -1 if value is not found.
	*	
	*	     var i = createjs.indexOf(myArray, myElementToFind);
	* @param array Array to search for searchElement
	* @param searchElement Element to find in array.
	*/
	public function indexOf(array:Array<Dynamic>, searchElement:Dynamic):Float;
	
}
