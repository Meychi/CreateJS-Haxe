package createjs;

/**
* Various utilities that the CreateJS Suite uses. Utilities are created as separate files, and will be available on the createjs namespace directly
*/
@:native("createjs")
extern class CreateJS
{
	/**
	* Finds the first occurrence of a specified value searchElement in the passed in array, and returns the index of
	*	that value.  Returns -1 if value is not found.
	*	
	*	     var i = createjs.indexOf(myArray, myElementToFind);
	* @param array Array to search for searchElement
	* @param searchElement Element to find in array.
	*/
	public function indexOf(array:Array<Dynamic>, searchElement:Dynamic):Float;
	
	/**
	* Promotes any methods on the super class that were overridden, by creating an alias in the format `prefix_methodName`.
	*	It is recommended to use the super class's name as the prefix.
	*	An alias to the super class's constructor is always added in the format `prefix_constructor`.
	*	This allows the subclass to call super class methods without using `function.call`, providing better performance.
	*	
	*	For example, if `MySubClass` extends `MySuperClass`, and both define a `draw` method, then calling `promote(MySubClass, "MySuperClass")`
	*	would add a `MySuperClass_constructor` method to MySubClass and promote the `draw` method on `MySuperClass` to the
	*	prototype of `MySubClass` as `MySuperClass_draw`.
	*	
	*	This should be called after the class's prototype is fully defined.
	*	
	*		function ClassA(name) {
	*			this.name = name;
	*		}
	*		ClassA.prototype.greet = function() {
	*			return "Hello "+this.name;
	*		}
	*	
	*		function ClassB(name, punctuation) {
	*			this.ClassA_constructor(name);
	*			this.punctuation = punctuation;
	*		}
	*		createjs.extend(ClassB, ClassA);
	*		ClassB.prototype.greet = function() {
	*			return this.ClassA_greet()+this.punctuation;
	*		}
	*		createjs.promote(ClassB, "ClassA");
	*	
	*		var foo = new ClassB("World", "!?!");
	*		console.log(foo.greet()); // Hello World!?!
	* @param subclass The class to promote super class methods on.
	* @param prefix The prefix to add to the promoted method names. Usually the name of the superclass.
	*/
	public function promote(subclass:Dynamic, prefix:String):Dynamic;
	
	/**
	* Sets up the prototype chain and constructor property for a new class.
	*	
	*	This should be called right after creating the class constructor.
	*	
	*		function MySubClass() {}
	*		createjs.extend(MySubClass, MySuperClass);
	*		MySubClass.prototype.doSomething = function() { }
	*	
	*		var foo = new MySubClass();
	*		console.log(foo instanceof MySuperClass); // true
	*		console.log(foo.prototype.constructor === MySubClass); // true
	* @param subclass The subclass.
	* @param superclass The superclass to extend.
	*/
	public function extend(subclass:Dynamic, superclass:Dynamic):Dynamic;
	
}
