package 
{
	import engine.vs.VirtualScreen;
	import engine.vs.VSColorAttribute;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	/**
	 * ...
	 * @author Richard Marks
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		private var buffer:BitmapData;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			buffer = new BitmapData(stage.stageWidth, stage.stageHeight, false, 0xFF000000);
			addChild(new Bitmap(buffer, PixelSnapping.NEVER));
			
			var screen:VirtualScreen = new VirtualScreen(buffer, 10, 10);
			
			screen.BackgroundColor = 4;
			//screen.Clear();
			
			//screen.SetXY(10, 10);
			screen.Puts("A");
			
			//screen.BackgroundColor = 1 | 8;
			//screen.ForegroundColor = 1 | 2 | 4;
			//screen.Puts("Testing Red");
			
			screen.Display();
			
			//buffer.copyPixels(VirtualScreen.masterFontSurface, VirtualScreen.masterFontSurface.rect, new Point);
		}

	}

}