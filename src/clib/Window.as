package clib 
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class Window 
	{
		private var myBuffer:BitmapData;
		private var myLeft:int;
		private var myTop:int;
		private var myRight:int;
		private var myBottom:int;
		
		public function get Buffer():BitmapData { return myBuffer; }
		public function get Left():int { return myLeft; }
		public function get Top():int { return myTop; }
		public function get Right():int { return myRight; }
		public function get Bottom():int { return myBottom; }
		public function get Width():int { return myRight - myLeft; }
		public function get Height():int { return myBottom - myTop; }
		
		public function Window(x:int, y:int, width:int, height:int) 
		{
			myLeft = x;
			myTop = y;
			myRight = x + width;
			myBottom = y + height;
			myBuffer = new BitmapData(width, height, false, 0x00000000);
		}
		
	}

}