package engine 
{
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class MapEventManager 
	{
		private var myEvents:Vector.<MapEvent>;
		
		public function MapEventManager() {}
		
		public function AddWarp(x:Number, y:Number, mapID:Number, func:Function, target:WarpTarget):Number
		{
			var e:MapEvent = new MapEvent;
			
			e.enabled = true;
			e.oneTime = false;
			
			e.x = x;
			e.y = y;
			e.mapID = mapID;
			
			e.data = target;
			e.func = func;
			
			myEvents.push(e);
			
			return myEvents.length;
		}
		
		public function AddEvent(x:Number, y:Number, mapID:Number, func:Function, data:Object, oneTime:Boolean, enabled:Boolean):Number
		{
			var e:MapEvent = new MapEvent;
			
			e.enabled = enabled;
			e.oneTime = oneTime;
			
			e.x = x;
			e.y = y;
			e.mapID = mapID;
			
			e.data = data;
			e.func = func;
			
			myEvents.push(e);
			
			return myEvents.length;
		}
		
		public function RemoveEvent(index:int):void
		{
			if (index >= myEvents.length)
			{
				return;
			}
			
			myEvents.splice(index, 1);
		}
		
		public function GetEvent(index:int):MapEvent
		{
			if (index >= myEvents.length)
			{
				return null;
			}
			return myEvents[index];
		}
		
		public function get EventCount():Number { return myEvents.length; }
	}

}