package createjs.easeljs;

/**
* Provides helper functions for assembling a matrix for use with the {{#crossLink "ColorMatrixFilter"}}{{/crossLink}},
*	or can be used directly as the matrix for a ColorMatrixFilter. Most methods return the instance to facilitate
*	chained calls.
*	
*	<h4>Example</h4>
*	     myColorMatrix.adjustHue(20).adjustBrightness(50);
*	
*	See {{#crossLink "Filter"}}{{/crossLink}} for an example of how to apply filters, or {{#crossLink "ColorMatrixFilter"}}{{/crossLink}}
*	for an example of how to use ColorMatrix to change a DisplayObject's color.
*/
@:native("createjs.ColorMatrix")
extern class ColorMatrix extends Array
{	
	/**
	* Array of delta values for contrast calculations.
	*/
	public static var DELTA_INDEX:Array<Dynamic>;
	
	/**
	* Identity matrix values.
	*/
	public static var IDENTITY_MATRIX:Array<Dynamic>;
	
	/**
	* The constant length of a color matrix.
	*/
	public static var LENGTH:Float;
	
	/**
	* Adjusts the brightness of pixel color by adding the specified value to the red, green and blue channels.
	*	Positive values will make the image brighter, negative values will make it darker.
	* @param value A value between -255 & 255 that will be added to the RGB channels.
	*/
	public function adjustBrightness(value:Float):ColorMatrix;
	
	/**
	* Adjusts the color saturation of the pixel.
	*	Positive values will increase saturation, negative values will decrease saturation (trend towards greyscale).
	* @param value A value between -100 & 100.
	*/
	public function adjustSaturation(value:Float):ColorMatrix;
	
	/**
	* Adjusts the contrast of pixel color.
	*	Positive values will increase contrast, negative values will decrease contrast.
	* @param value A value between -100 & 100.
	*/
	public function adjustContrast(value:Float):ColorMatrix;
	
	/**
	* Adjusts the hue of the pixel color.
	* @param value A value between -180 & 180.
	*/
	public function adjustHue(value:Float):ColorMatrix;
	
	/**
	* Concatenates (multiplies) the specified matrix with this one.
	* @param matrix An array or ColorMatrix instance.
	*/
	public function concat(matrix:Array<Dynamic>):ColorMatrix;
	
	/**
	* Copy the specified matrix's values to this matrix.
	* @param matrix An array or ColorMatrix instance.
	*/
	public function copyMatrix(matrix:Array<Dynamic>):ColorMatrix;
	
	/**
	* Initialization method.
	*/
	private function initialize():Dynamic;
	
	/**
	* Make sure values are within the specified range, hue has a limit of 180, brightness is 255, others are 100.
	*/
	private function _cleanValue():Dynamic;
	
	/**
	* Makes sure matrixes are 5x5 (25 long).
	*/
	private function _fixMatrix():Dynamic;
	
	/**
	* Provides helper functions for assembling a matrix for use with the {{#crossLink "ColorMatrixFilter"}}{{/crossLink}},
	*	or can be used directly as the matrix for a ColorMatrixFilter. Most methods return the instance to facilitate
	*	chained calls.
	*	
	*	<h4>Example</h4>
	*	     myColorMatrix.adjustHue(20).adjustBrightness(50);
	*	
	*	See {{#crossLink "Filter"}}{{/crossLink}} for an example of how to apply filters, or {{#crossLink "ColorMatrixFilter"}}{{/crossLink}}
	*	for an example of how to use ColorMatrix to change a DisplayObject's color.
	* @param brightness 
	* @param contrast 
	* @param saturation 
	* @param hue 
	*/
	public function new(brightness:Float, contrast:Float, saturation:Float, hue:Float):Void;
	
	/**
	* Resets the matrix to identity values.
	*/
	public function reset():ColorMatrix;
	
	/**
	* Return a length 25 (5x5) array instance containing this matrix's values.
	*/
	public function toArray():Array<Dynamic>;
	
	/**
	* Returns a clone of this ColorMatrix.
	*/
	public function clone():ColorMatrix;
	
	/**
	* Shortcut method to adjust brightness, contrast, saturation and hue.
	*	Equivalent to calling adjustHue(hue), adjustContrast(contrast),
	*	adjustBrightness(brightness), adjustSaturation(saturation), in that order.
	* @param brightness 
	* @param contrast 
	* @param saturation 
	* @param hue 
	*/
	public function adjustColor(brightness:Float, contrast:Float, saturation:Float, hue:Float):ColorMatrix;
	private function _multiplyMatrix():Dynamic;
}
