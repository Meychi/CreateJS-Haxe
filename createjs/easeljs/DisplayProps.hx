package createjs.easeljs;

/**
* Used for calculating and encapsulating display related properties.
*/
@:native("createjs.DisplayProps")
extern class DisplayProps
{
	/**
	* Property representing the alpha that will be applied to a display object.
	*/
	public var alpha:Float;
	
	/**
	* Property representing the compositeOperation that will be applied to a display object. You can find a list of valid composite operations at: <a href="https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API/Tutorial/Compositing">https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API/Tutorial/Compositing</a>
	*/
	public var compositeOperation:String;
	
	/**
	* Property representing the shadow that will be applied to a display object.
	*/
	public var shadow:Shadow;
	
	/**
	* Property representing the value for visible that will be applied to a display object.
	*/
	public var visible:Bool;
	
	/**
	* The transformation matrix that will be applied to a display object.
	*/
	public var matrix:Matrix2D;
	
	/**
	* Appends the specified display properties. This is generally used to apply a child's properties its parent's.
	* @param visible desired visible value
	* @param alpha desired alpha value
	* @param shadow desired shadow value
	* @param compositeOperation desired composite operation value
	* @param matrix a Matrix2D instance
	*/
	public function append(visible:Bool, alpha:Float, shadow:Shadow, compositeOperation:String, ?matrix:Matrix2D):DisplayProps;
	
	/**
	* Prepends the specified display properties. This is generally used to apply a parent's properties to a child's.
	*	For example, to get the combined display properties that would be applied to a child, you could use:
	*	
	*		var o = myDisplayObject;
	*		var props = new createjs.DisplayProps();
	*		do {
	*			// prepend each parent's props in turn:
	*			props.prepend(o.visible, o.alpha, o.shadow, o.compositeOperation, o.getMatrix());
	*		} while (o = o.parent);
	* @param visible desired visible value
	* @param alpha desired alpha value
	* @param shadow desired shadow value
	* @param compositeOperation desired composite operation value
	* @param matrix a Matrix2D instance
	*/
	public function prepend(visible:Bool, alpha:Float, shadow:Shadow, compositeOperation:String, ?matrix:Matrix2D):DisplayProps;
	
	/**
	* Reinitializes the instance with the specified values.
	* @param visible Visible value.
	* @param alpha Alpha value.
	* @param shadow A Shadow instance or null.
	* @param compositeOperation A compositeOperation value or null.
	* @param matrix A transformation matrix. Defaults to an identity matrix.
	*/
	public function setValues(?visible:Float, ?alpha:Float, ?shadow:Float, ?compositeOperation:Float, ?matrix:Float):DisplayProps;
	
	/**
	* Resets this instance and its matrix to default values.
	*/
	public function identity():DisplayProps;
	
	/**
	* Returns a clone of the DisplayProps instance. Clones the associated matrix.
	*/
	public function clone():DisplayProps;
	
	/**
	* Used for calculating and encapsulating display related properties.
	* @param visible Visible value.
	* @param alpha Alpha value.
	* @param shadow A Shadow instance or null.
	* @param compositeOperation A compositeOperation value or null.
	* @param matrix A transformation matrix. Defaults to a new identity matrix.
	*/
	public function new(?visible:Float, ?alpha:Float, ?shadow:Float, ?compositeOperation:Float, ?matrix:Float):Void;
	
}
