package createjs.easeljs;

import js.html.Point;

/**
* Represents an affine transformation matrix, and provides tools for constructing and concatenating matrixes.
*/
@:native("createjs.Matrix2D")
extern class Matrix2D
{
	/**
	* An identity matrix, representing a null transformation.
	*/
	public static var identity:Matrix2D;
	
	/**
	* Multiplier for converting degrees to radians. Used internally by Matrix2D.
	*/
	public static var DEG_TO_RAD:Float;
	
	/**
	* Position (0, 0) in a 3x3 affine transformation matrix.
	*/
	public var a:Float;
	
	/**
	* Position (0, 1) in a 3x3 affine transformation matrix.
	*/
	public var b:Float;
	
	/**
	* Position (1, 0) in a 3x3 affine transformation matrix.
	*/
	public var c:Float;
	
	/**
	* Position (1, 1) in a 3x3 affine transformation matrix.
	*/
	public var d:Float;
	
	/**
	* Position (2, 0) in a 3x3 affine transformation matrix.
	*/
	public var tx:Float;
	
	/**
	* Position (2, 1) in a 3x3 affine transformation matrix.
	*/
	public var ty:Float;
	
	/**
	* Property representing the alpha that will be applied to a display object. This is not part of matrix operations, but is used for operations like getConcatenatedMatrix to provide concatenated alpha values.
	*/
	public var alpha:Float;
	
	/**
	* Property representing the compositeOperation that will be applied to a display object. This is not part of matrix operations, but is used for operations like getConcatenatedMatrix to provide concatenated compositeOperation values. You can find a list of valid composite operations at: <a href="https://developer.mozilla.org/en/Canvas_tutorial/Compositing">https://developer.mozilla.org/en/Canvas_tutorial/Compositing</a>
	*/
	public var compositeOperation:String;
	
	/**
	* Property representing the shadow that will be applied to a display object. This is not part of matrix operations, but is used for operations like getConcatenatedMatrix to provide concatenated shadow values.
	*/
	public var shadow:Shadow;
	
	/**
	* Property representing the value for visible that will be applied to a display object. This is not part of matrix operations, but is used for operations like getConcatenatedMatrix to provide concatenated visible values.
	*/
	public var visible:Bool;
	
	/**
	* Appends the specified matrix properties with this matrix. All parameters are required.
	* @param a 
	* @param b 
	* @param c 
	* @param d 
	* @param tx 
	* @param ty 
	*/
	public function append(a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float):Matrix2D;
	
	/**
	* Appends the specified matrix with this matrix.
	* @param matrix 
	*/
	public function appendMatrix(matrix:Matrix2D):Matrix2D;
	
	/**
	* Appends the specified visual properties to the current matrix.
	* @param alpha desired alpha value
	* @param shadow desired shadow value
	* @param compositeOperation desired composite operation value
	* @param visible desired visible value
	*/
	public function appendProperties(alpha:Float, shadow:Shadow, compositeOperation:String, visible:Bool):Matrix2D;
	
	/**
	* Applies a rotation transformation to the matrix.
	* @param angle The angle in radians. To use degrees, multiply by <code>Math.PI/180</code>.
	*/
	public function rotate(angle:Float):Matrix2D;
	
	/**
	* Applies a scale transformation to the matrix.
	* @param x The amount to scale horizontally
	* @param y The amount to scale vertically
	*/
	public function scale(x:Float, y:Float):Matrix2D;
	
	/**
	* Applies a skew transformation to the matrix.
	* @param skewX The amount to skew horizontally in degrees.
	* @param skewY The amount to skew vertically in degrees.
	*/
	public function skew(skewX:Float, skewY:Float):Matrix2D;
	
	/**
	* Concatenates the specified matrix properties with this matrix. All parameters are required.
	* @param a 
	* @param b 
	* @param c 
	* @param d 
	* @param tx 
	* @param ty 
	*/
	public function prepend(a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float):Matrix2D;
	
	/**
	* Copies all properties from the specified matrix to this matrix.
	* @param matrix The matrix to copy properties from.
	*/
	public function copy(matrix:Matrix2D):Matrix2D;
	
	/**
	* Decomposes the matrix into transform properties (x, y, scaleX, scaleY, and rotation). Note that this these values
	*	may not match the transform properties you used to generate the matrix, though they will produce the same visual
	*	results.
	* @param target The object to apply the transform properties to. If null, then a new object will be returned.
	*/
	public function decompose(target:Dynamic):Matrix2D;
	
	/**
	* Generates matrix properties from the specified display object transform properties, and appends them with this matrix.
	*	For example, you can use this to generate a matrix from a display object: var mtx = new Matrix2D();
	*	mtx.appendTransform(o.x, o.y, o.scaleX, o.scaleY, o.rotation);
	* @param x 
	* @param y 
	* @param scaleX 
	* @param scaleY 
	* @param rotation 
	* @param skewX 
	* @param skewY 
	* @param regX Optional.
	* @param regY Optional.
	*/
	public function appendTransform(x:Float, y:Float, scaleX:Float, scaleY:Float, rotation:Float, skewX:Float, skewY:Float, ?regX:Float, ?regY:Float):Matrix2D;
	
	/**
	* Generates matrix properties from the specified display object transform properties, and prepends them with this matrix.
	*	For example, you can use this to generate a matrix from a display object: var mtx = new Matrix2D();
	*	mtx.prependTransform(o.x, o.y, o.scaleX, o.scaleY, o.rotation);
	* @param x 
	* @param y 
	* @param scaleX 
	* @param scaleY 
	* @param rotation 
	* @param skewX 
	* @param skewY 
	* @param regX Optional.
	* @param regY Optional.
	*/
	public function prependTransform(x:Float, y:Float, scaleX:Float, scaleY:Float, rotation:Float, skewX:Float, skewY:Float, regX:Float, regY:Float):Matrix2D;
	
	/**
	* Initialization method. Can also be used to reinitialize the instance.
	* @param a Specifies the a property for the new matrix.
	* @param b Specifies the b property for the new matrix.
	* @param c Specifies the c property for the new matrix.
	* @param d Specifies the d property for the new matrix.
	* @param tx Specifies the tx property for the new matrix.
	* @param ty Specifies the ty property for the new matrix.
	*/
	public function initialize(?a:Float, ?b:Float, ?c:Float, ?d:Float, ?tx:Float, ?ty:Float):Matrix2D;
	
	/**
	* Inverts the matrix, causing it to perform the opposite transformation.
	*/
	public function invert():Matrix2D;
	
	/**
	* Prepends the specified matrix with this matrix.
	* @param matrix 
	*/
	public function prependMatrix(matrix:Matrix2D):Matrix2D;
	
	/**
	* Prepends the specified visual properties to the current matrix.
	* @param alpha desired alpha value
	* @param shadow desired shadow value
	* @param compositeOperation desired composite operation value
	* @param visible desired visible value
	*/
	public function prependProperties(alpha:Float, shadow:Shadow, compositeOperation:String, visible:Bool):Matrix2D;
	
	/**
	* Reinitializes all matrix properties to those specified.
	* @param a Specifies the a property for the new matrix.
	* @param b Specifies the b property for the new matrix.
	* @param c Specifies the c property for the new matrix.
	* @param d Specifies the d property for the new matrix.
	* @param tx Specifies the tx property for the new matrix.
	* @param ty Specifies the ty property for the new matrix.
	* @param alpha desired alpha value
	* @param shadow desired shadow value
	* @param compositeOperation desired composite operation value
	* @param visible desired visible value
	*/
	public function reinitialize(?a:Float, ?b:Float, ?c:Float, ?d:Float, ?tx:Float, ?ty:Float, ?alpha:Float, ?shadow:Shadow, ?compositeOperation:String, ?visible:Bool):Matrix2D;
	
	/**
	* Represents an affine transformation matrix, and provides tools for constructing and concatenating matrixes.
	* @param a Specifies the a property for the new matrix.
	* @param b Specifies the b property for the new matrix.
	* @param c Specifies the c property for the new matrix.
	* @param d Specifies the d property for the new matrix.
	* @param tx Specifies the tx property for the new matrix.
	* @param ty Specifies the ty property for the new matrix.
	*/
	public function new(?a:Float, ?b:Float, ?c:Float, ?d:Float, ?tx:Float, ?ty:Float):Void;
	
	/**
	* Returns a clone of the Matrix2D instance.
	*/
	public function clone():Matrix2D;
	
	/**
	* Returns a string representation of this object.
	*/
	public function toString():String;
	
	/**
	* Returns true if the matrix is an identity matrix.
	*/
	public function isIdentity():Bool;
	
	/**
	* Sets the properties of the matrix to those of an identity matrix (one that applies a null transformation).
	*/
	//public function identity():Matrix2D;
	
	/**
	* Transforms a point according to this matrix.
	* @param x The x component of the point to transform.
	* @param y The y component of the point to transform.
	* @param pt An object to copy the result into. If omitted a generic object with x/y properties will be returned.
	*/
	public function transformPoint(x:Float, y:Float, ?pt:Dynamic):Point;
	
	/**
	* Translates the matrix on the x and y axes.
	* @param x 
	* @param y 
	*/
	public function translate(x:Float, y:Float):Matrix2D;
	
}
