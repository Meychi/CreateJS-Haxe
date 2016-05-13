package createjs.tweenjs;

/**
* A TweenJS plugin for working with motion guides.
*	
*	To use, install the plugin after TweenJS has loaded. Next tween the 'guide' property with an object as detailed below.
*	
*	      createjs.MotionGuidePlugin.install();
*	
*	<h4>Example</h4>
*	
*	     // Using a Motion Guide
*		    createjs.Tween.get(target).to({guide:{ path:[0,0, 0,200,200,200, 200,0,0,0] }},7000);
*		    // Visualizing the line
*		    graphics.moveTo(0,0).curveTo(0,200,200,200).curveTo(200,0,0,0);
*	
*	Each path needs pre-computation to ensure there's fast performance. Because of the pre-computation there's no
*	built in support for path changes mid tween. These are the Guide Object's properties:<UL>
*	     <LI> path: Required, Array : The x/y points used to draw the path with a moveTo and 1 to n curveTo calls.</LI>
*	     <LI> start: Optional, 0-1 : Initial position, default 0 except for when continuing along the same path.</LI>
*	     <LI> end: Optional, 0-1 : Final position, default 1 if not specified.</LI>
*	     <LI> orient: Optional, string : "fixed"/"auto"/"cw"/"ccw"<UL>
*					<LI>"fixed" forces the object to face down the path all movement (relative to start rotation),</LI>
*	     		<LI>"auto" rotates the object along the path relative to the line.</LI>
*	     		<LI>"cw"/"ccw" force clockwise or counter clockwise rotations including Adobe Flash/Animate-like
*	     		behaviour</LI>
*			</UL></LI>
*	</UL>
*	Guide objects should not be shared between tweens even if all properties are identical, the library stores
*	information on these objects in the background and sharing them can cause unexpected behaviour. Values
*	outside 0-1 range of tweens will be a "best guess" from the appropriate part of the defined curve.
*/
@:native("createjs.MotionGuidePlugin")
extern class MotionGuidePlugin
{
	public static var priority:Dynamic;
	
	public static var temporary variable storage:Dynamic;
	
	/**
	* A TweenJS plugin for working with motion guides.
	*	
	*	To use, install the plugin after TweenJS has loaded. Next tween the 'guide' property with an object as detailed below.
	*	
	*	      createjs.MotionGuidePlugin.install();
	*	
	*	<h4>Example</h4>
	*	
	*	     // Using a Motion Guide
	*		    createjs.Tween.get(target).to({guide:{ path:[0,0, 0,200,200,200, 200,0,0,0] }},7000);
	*		    // Visualizing the line
	*		    graphics.moveTo(0,0).curveTo(0,200,200,200).curveTo(200,0,0,0);
	*	
	*	Each path needs pre-computation to ensure there's fast performance. Because of the pre-computation there's no
	*	built in support for path changes mid tween. These are the Guide Object's properties:<UL>
	*	     <LI> path: Required, Array : The x/y points used to draw the path with a moveTo and 1 to n curveTo calls.</LI>
	*	     <LI> start: Optional, 0-1 : Initial position, default 0 except for when continuing along the same path.</LI>
	*	     <LI> end: Optional, 0-1 : Final position, default 1 if not specified.</LI>
	*	     <LI> orient: Optional, string : "fixed"/"auto"/"cw"/"ccw"<UL>
	*					<LI>"fixed" forces the object to face down the path all movement (relative to start rotation),</LI>
	*	     		<LI>"auto" rotates the object along the path relative to the line.</LI>
	*	     		<LI>"cw"/"ccw" force clockwise or counter clockwise rotations including Adobe Flash/Animate-like
	*	     		behaviour</LI>
	*			</UL></LI>
	*	</UL>
	*	Guide objects should not be shared between tweens even if all properties are identical, the library stores
	*	information on these objects in the background and sharing them can cause unexpected behaviour. Values
	*	outside 0-1 range of tweens will be a "best guess" from the appropriate part of the defined curve.
	*/
	public function new():Void;
	
	/**
	* Installs this plugin for use with TweenJS. Call this once after TweenJS is loaded to enable this plugin.
	*/
	public static function install():Dynamic;
	
	private static function init():Dynamic;
	
	private static function step():Dynamic;
	
	private static function testRotData():Dynamic;
	
	private static function tween():Dynamic;
	
}
