package engine.clib 
{
	import engine.clib.Window;
	import engine.vs.VirtualScreen;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class CL 
	{
		// core
		static private var screen:VirtualScreen;
		
		// core functions
		static public function Initialize(renderTarget:BitmapData, columns:int = 80, rows:int = 50):void
		{
			screen = new VirtualScreen(renderTarget, columns, rows);
		}
		
		static public function Render():void
		{
			if (screen == null) { throw new Error("CL.Initialize() not called"); }
			screen.Display();
		}
		
		static public function SetBackgroundColor(color:int):void
		{
			if (screen == null) { throw new Error("CL.Initialize() not called"); }
			screen.BackgroundColor = color;
		}
		
		static public function SetForegroundColor(color:int):void
		{
			if (screen == null) { throw new Error("CL.Initialize() not called"); }
			screen.ForegroundColor = color;
		}
		
		static public function SetCursorPosition(x:int, y:int):void
		{
			if (screen == null) { throw new Error("CL.Initialize() not called"); }
			screen.SetXY(x, y);
		}
		
		static public function ClearScreen():void
		{
			if (screen == null) { throw new Error("CL.Initialize() not called"); }
			screen.Clear();
		}
		
		static public function OutChar(x:int, y:int, c:String):void
		{
			if (screen == null) { throw new Error("CL.Initialize() not called"); }
			screen.SetXY(x, y);
			screen.PutChar(c);
		}
		
		static public function OutChars(x:int, y:int, c:String):void
		{
			if (screen == null) { throw new Error("CL.Initialize() not called"); }
			screen.SetXY(x, y);
			screen.Puts(c);
		}
		
		static public function OutCharsF(x:int, y:int, format:String, ...opt):void
		{
			throw new Error("This function is not implemented at this time - sorry.");
		}
		
		// UI functions
		
		static public function OpenWindow(x:int, y:int, width:int, height:int, backColor:int, foreColor:int):Window
		{
			if (screen == null) { throw new Error("CL.Initialize() not called"); }
			
			// before drawing the window, we save the contents of the screen
			// where the window will be drawn so that we can redraw the screen
			// when the window is closed.
			var wnd:Window = new Window(x, y, width, height);
			wnd.CopyFromVS(screen, wnd.Rect);
			
			// set the colors
			SetBackgroundColor(backColor);
			SetForegroundColor(foreColor);
			
			// draw the window
			var cx:int, cy:int;
			for (cy = 1; cy < height - 1; cy++)
			{
				for (cx = 1; cx < width - 1; cx++)
				{
					OutChar(x + cx, y + cy, " ");
				}
			}
			
			// draw top and bottom edge
			for (cx = 0; cx < width; cx++)
			{
				OutChar(x + cx, y, String.fromCharCode(205));
				OutChar(x + cx, y + (height - 1), String.fromCharCode(205));
			}
			
			// draw left and right edge
			for (cy = 0; cy < height; cy++)
			{
				OutChar(x, y + cy, String.fromCharCode(186));
				OutChar(x + (width - 1), y + cy, String.fromCharCode(186));
			}
			
			// draw corners
			OutChar(x, y, String.fromCharCode(201));
			OutChar(x, y + (height - 1), String.fromCharCode(200));
			OutChar(x + (width - 1), y, String.fromCharCode(187));
			OutChar(x + (width - 1), y + (height - 1), String.fromCharCode(188));
			
			// return the saved window
			return wnd;
		}
		
		static public function OpenWindowNoFrame(x:int, y:int, width:int, height:int, backColor:uint, foreColor:uint):Window
		{
			return null;
		}
		
		static public function CloseWindow(window:Window):void
		{
			
		}
		
		static public function ShowMessage(lines:Vector.<String>):void
		{
			
		}
		
		static public function ShowMessageCentered(lines:Vector.<String>):void
		{
			
		}
		
		static public function ShowChoice(message:String):void
		{
			
		}
		
		static public function ShowChoiceEx(message:String, ...options):void
		{
			
		}
		
		static public function DrawButton(x:int, y:int, width:int, height:int, caption:String, backColor:uint, foreColor:uint):void
		{
			
		}
		
	}
}