package createjs.easeljs;

/**
* Represents an affine transformation matrix, and provides tools for constructing and concatenating matrices.
*	
*	This matrix can be visualized as:
*	
*		[ a  c  tx
*		  b  d  ty
*		  0  0  1  ]
*	
*	Note the locations of b and c.
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
	* <strong>REMOVED</strong>. Removed in favor of using `MySuperClass_constructor`.
	*	See {{#crossLink "Utility Methods/extend"}}{{/crossLink}} and {{#crossLink "Utility Methods/promote"}}{{/crossLink}}
	*	for details.
	*	
	*	There is an inheritance tutorial distributed with EaselJS in /tutorials/Inheritance.
	*/
	private function initialize():Dynamic;
	
	/**
	* Appends the specified matrix properties to this matrix. All parameters are required.
	*	This is the equivalent of multiplying `(this matrix) * (specified matrix)`.
	* @param a 
	* @param b 
	* @param c 
	* @param d 
	* @param tx 
	* @param ty 
	*/
	public function append(a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float):Matrix2D;
	
	/**
	* Appends the specified matrix to this matrix.
	*	This is the equivalent of multiplying `(this matrix) * (specified matrix)`.
	* @param matrix 
	*/
	public function appendMatrix(matrix:Matrix2D):Matrix2D;
	
	/**
	* Applies a clockwise rotation transformation to the matrix.
	* @param angle The angle to rotate by, in degrees. To use a value in radians, multiply it by `180/Math.PI`.
	*/
	public function rotate(angle:Float):Matrix2D;
	
	/**
	* Applies a scale transformation to the matrix.
	* @param x The amount to scale horizontally. E.G. a value of 2 will double the size in the X direction, and 0.5 will halve it.
	* @param y The amount to scale vertically.
	*/
	public function scale(x:Float, y:Float):Matrix2D;
	
	/**
	* Applies a skew transformation to the matrix.
	* @param skewX The amount to skew horizontally in degrees. To use a value in radians, multiply it by `180/Math.PI`.
	* @param skewY The amount to skew vertically in degrees.
	*/
	public function skew(skewX:Float, skewY:Float):Matrix2D;
	
	/**
	* Copies all properties from the specified matrix to this matrix.
	* @param matrix The matrix to copy properties from.
	*/
	public function copy(matrix:Matrix2D):Matrix2D;
	
	/**
	* Decomposes the matrix into transform properties (x, y, scaleX, scaleY, and rotation). Note that these values
	*	may not match the transform properties you used to generate the matrix, though they will produce the same visual
	*	results.
	* @param target The object to apply the transform properties to. If null, then a new object will be returned.
	*/
	public function decompose(target:Dynamic):Dynamic;
	
	/**
	* Generates matrix properties from the specified display object transform properties, and appends them to this matrix.
	*	For example, you can use this to generate a matrix representing the transformations of a display object:
	*	
	*		var mtx = new Matrix2D();
	*		mtx.appendTransform(o.x, o.y, o.scaleX, o.scaleY, o.rotation);
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
	public function appendTransform(x:Float, y:Float, scaleX:Float, scaleY:Float, rotation:Float, skewX:Float, skewY:Float, regX:Float, regY:Float):Matrix2D;
	
	/**
	* Generates matrix properties from the specified display object transform properties, and prepends them to this matrix.
	*	For example, you could calculate the combined transformation for a child object using:
	*	
	*		var o = myDisplayObject;
	*		var mtx = new createjs.Matrix2D();
	*		do  {
	*			// prepend each parent's transformation in turn:
	*			mtx.prependTransform(o.x, o.y, o.scaleX, o.scaleY, o.rotation, o.skewX, o.skewY, o.regX, o.regY);
	*		} while (o = o.parent);
	*		
	*		Note that the above example would not account for {{#crossLink "DisplayObject/transformMatrix:property"}}{{/crossLink}}
	*		values. See {{#crossLink "Matrix2D/prependMatrix"}}{{/crossLink}} for an example that does.
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
	* Inverts the matrix, causing it to perform the opposite transformation.
	*/
	public function invert():Matrix2D;
	
	/**
	* Prepends the specified matrix properties to this matrix.
	*	This is the equivalent of multiplying `(specified matrix) * (this matrix)`.
	*	All parameters are required.
	* @param a 
	* @param b 
	* @param c 
	* @param d 
	* @param tx 
	* @param ty 
	*/
	public function prepend(a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float):Matrix2D;
	
	/**
	* Prepends the specified matrix to this matrix.
	*	This is the equivalent of multiplying `(specified matrix) * (this matrix)`.
	*	For example, you could calculate the combined transformation for a child object using:
	*	
	*		var o = myDisplayObject;
	*		var mtx = o.getMatrix();
	*		while (o = o.parent) {
	*			// prepend each parent's transformation in turn:
	*			o.prependMatrix(o.getMatrix());
	*		}
	* @param matrix 
	*/
	public function prependMatrix(matrix:Matrix2D):Matrix2D;
	
	/**
	* Represents an affine transformation matrix, and provides tools for constructing and concatenating matrices.
	*	
	*	This matrix can be visualized as:
	*	
	*		[ a  c  tx
	*		  b  d  ty
	*		  0  0  1  ]
	*	
	*	Note the locations of b and c.
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
	* Returns true if this matrix is equal to the specified matrix (all property values are equal).
	* @param matrix The matrix to compare.
	*/
	public function equals(matrix:Matrix2D):Bool;
	
	/**
	* Sets the properties of the matrix to those of an identity matrix (one that applies a null transformation).
	*/
	//public function identity():Matrix2D;
	
	/**
	* Sets the specified values on this instance.
	* @param a Specifies the a property for the new matrix.
	* @param b Specifies the b property for the new matrix.
	* @param c Specifies the c property for the new matrix.
	* @param d Specifies the d property for the new matrix.
	* @param tx Specifies the tx property for the new matrix.
	* @param ty Specifies the ty property for the new matrix.
	*/
	public function setValues(?a:Float, ?b:Float, ?c:Float, ?d:Float, ?tx:Float, ?ty:Float):Matrix2D;
	
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
