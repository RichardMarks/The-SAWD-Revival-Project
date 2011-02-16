package engine.vs 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class VirtualScreen
	{
		
		public function VirtualScreen() 
		{
			
		}
		
		protected var myBuffer:Vector.<VSCharacterInfo>;
		protected var myCaret:Point;
		protected var myRows:int;
		protected var myColumns:int;
		protected var myForegroundColor:int;
		protected var myBackgroundColor:int;
	}

}