package engine.clib 
{
	import engine.vs.VirtualScreen;
	import engine.vs.VSCharacterInfo;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class Window 
	{
		protected var myBuffer:Vector.<VSCharacterInfo>;
		protected var myRect:Rectangle;
		protected var mySize:int;
		
		public function get Buffer():Vector.<VSCharacterInfo> { return myBuffer; }
		public function get Left():int { return myRect.left; }
		public function get Top():int { return myRect.top; }
		public function get Right():int { return myRect.right; }
		public function get Bottom():int { return myRect.bottom; }
		public function get Width():int { return myRect.width; }
		public function get Height():int { return myRect.height; }
		public function get Rect():Rectangle { return myRect; }
		
		public function Window(x:int, y:int, width:int, height:int) 
		{
			//myBuffer = new BitmapData(width, height, false, 0x00000000);
			myRect = new Rectangle(x, y, width, height);
			mySize = width * height;
			myBuffer = new Vector.<VSCharacterInfo>(mySize);
			for (var i:int = 0; i < mySize; i++)
			{
				myBuffer[i] = new VSCharacterInfo;
			}
		}
		
		public function CopyFromVS(vs:VirtualScreen, area:Rectangle):void
		{
			if (vs == null) { throw new Error("source VirtualScreen cannot be null"); }
			var source:Vector.<VSCharacterInfo> = vs.Buffer;
			
			if (area == null)
			{
				area = new Rectangle(0, 0, vs.Columns-1, vs.Rows-1);
			}
			
			if (area.x < 0 || area.y < 0 || area.right >= vs.Columns || area.bottom >= vs.Rows)
			{
				throw new Error("area out of bounds "+area);
			}
			
			var w:int = area.width;
			var h:int = area.height;
			
			for (var y:int = 0; y < h; y++)
			{
				for (var x:int = 0; x < w; x++)
				{
					var s:VSCharacterInfo = vs.GetCell(area.x + x, area.y + y);
					var d:VSCharacterInfo = myBuffer[x + (y * w)];
					d.copy(s);
				}
			}
			
		}
		
		public function CopyToVS(vs:VirtualScreen):void
		{
			if (vs == null) { throw new Error("source VirtualScreen cannot be null"); }
			
			var w:int = myRect.width;
			var h:int = myRect.height;
			
			for (var y:int = 0; y < h; y++)
			{
				for (var x:int = 0; x < w; x++)
				{
					var s:VSCharacterInfo = myBuffer[x + (y * w)];
					var d:VSCharacterInfo = vs.GetCell(myRect.x + x, myRect.y + y);
					d.copy(s);
				}
			}
		}
		
	}

}