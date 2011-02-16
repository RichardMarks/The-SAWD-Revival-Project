package engine 
{
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class MapEvent 
	{
		public var x:Number;
		public var y:Number;
		public var mapID:Number;
		public var data:Object;
		public var func:Function;
		public var oneTime:Boolean;
		public var enabled:Boolean;
		public function MapEvent() {}	
	}
}