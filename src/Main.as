package 
{
	import engine.clib.CL;
	import engine.clib.MultipleChoiceBox;
	import engine.clib.Window;
	import engine.vs.VirtualScreen;
	import engine.vs.VSColorAttribute;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;

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
			
			CL.Initialize(stage, buffer, 80, 50);
			
			var lines:Vector.<String> = new Vector.<String>();
			lines.push("Hello World!","This is a test!","And another line that is longer than the rest. ");
			CL.ShowMessage(lines);
			lines.length = 0;
			lines.push("This is a larger message",
				"with more lines","so that we can test","the robustness","of the ShowMessage","CL function");
			CL.ShowMessage(lines);
			
			lines.length = 0;
			lines.push("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k");
			
			CL.ShowMessageCentered(lines);
			
			lines.length = 0;
			lines.push("  Yes", "  No");
			var yesNoBox:MultipleChoiceBox = new MultipleChoiceBox(CL.screen, "Choose", lines);
			yesNoBox.Open();
			
			//var wnd:Window = CL.OpenWindow(2, 2, 45, 20, 4, 1 | 2 | 4 | 8);
			
			//CL.OpenWindow(14, 14, 45, 20, 1, 1 | 2 | 8);
			
			//CL.CloseWindow(wnd);
			
			
			//CL.Render();
			
			/*
			var screen:VirtualScreen = new VirtualScreen(buffer, 80, 50);
			
			screen.BackgroundColor = 4;
			screen.Clear();
			
			for (var bgc:int = 0; bgc < 16; bgc++)
			{
				screen.BackgroundColor = bgc;
				for (var fgc:int = 0; fgc < 16; fgc++)
				{
					screen.ForegroundColor = fgc;
					for (var c:int = 0; c < 256; c++)
					{
						screen.PutChar(String.fromCharCode(c));
					}
				}
			}
			
			screen.ForegroundColor = 1 | 2 | 4 | 8;
			
			screen.SetXY(10, 10);
			screen.Puts("Hello, World!");
			
			screen.BackgroundColor = 1 | 8;
			screen.ForegroundColor = 1 | 2 | 4;
			screen.Puts("Testing Red");
			
			var start:int = getTimer();
			
			screen.Display();
			
			var end:int = getTimer();
			
			var bench:int = end - start;
			
			trace("Display 80x50 renders in", bench + "ms");
			*/
			
			//buffer.copyPixels(VirtualScreen.masterFontSurface, new Rectangle(200,0,8,8), new Point);
			
			//buffer.copyPixels(VirtualScreen.masterFontSurface, VirtualScreen.masterFontSurface.rect, new Point);
			
			//addEventListener(Event.ENTER_FRAME, MainLoop);
		}
		
		private var bltp:Point = new Point(0, 0);
		private function MainLoop(e:Event):void
		{
			buffer.fillRect(buffer.rect, 0x00000000);
			buffer.copyPixels(VirtualScreen.masterFontSurface, VirtualScreen.masterFontSurface.rect, bltp);
			bltp.x -= 2;
			trace("x", -bltp.x);
			if (bltp.x < -VirtualScreen.masterFontSurface.width)
			{
				bltp.x = 0;
			}
		}
	}

}