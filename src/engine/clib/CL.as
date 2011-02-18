package engine.clib 
{
	import engine.clib.Window;
	import engine.vs.VirtualScreen;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class CL 
	{
		// core
		static public var screen:VirtualScreen;
		static public var stage:Stage;
		
		// core functions
		static public function Initialize(stage:Stage, renderTarget:BitmapData, columns:int = 80, rows:int = 50):void
		{
			CL.stage = stage;
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
		
		static public function OpenWindow(x:int, y:int, width:int, height:int, backColor:int = 4, foreColor:int = 15, frame:Boolean = true):Window
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
			
			if (!frame)
			{
				return wnd;
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
			return OpenWindow(x, y, width, height, backColor, foreColor, false);
		}
		
		static public function CloseWindow(window:Window):void
		{
			if (screen == null) { throw new Error("CL.Initialize() not called"); }
			if (window == null)
			{
				throw new Error("CL Window must not be null");
			}
			
			// restore to the screen the stored window buffer
			window.CopyToVS(screen);
			
			// finished with the window
			window = null;
		}
		
		static private var openWindowList:Vector.<Window> = new Vector.<Window>();
		
		static public function ShowMessage(lines:Vector.<String>, centerText:Boolean = false):void
		{
			if (screen == null) { throw new Error("CL.Initialize() not called"); }
			
			var box:Vector.<int> = new Vector.<int>();
			box.push(5, 12 - int((lines.length + 4) * 0.5), 70, lines.length + 4);
			var x:int = box[0] + 2;
			var y:int = box[1] + 2;
			openWindowList.unshift(OpenWindow(box[0], box[1], box[2], box[3]));
			
			var line:String;
			if (centerText)
			{
				var wOver2:int = int(box[2] * 0.5) + 2;
				for each(line in lines)
				{
					OutChars(wOver2 - int(line.length * 0.5), y, line);
					y++;
				}
			}
			else
			{
				for each(line in lines)
				{
					OutChars(x, y, line);
					y++;
				}
			}
			Render();
			
			LockKeyHandler();
		}
		
		static private var keyHandlerLocked:Boolean = false;
		static public function KeyHandlerIsLocked():Boolean { return keyHandlerLocked; }
		static public function LockKeyHandler():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, ShowMessageKeyHandler, false, int.MAX_VALUE);
			keyHandlerLocked = true;
		}
		
		static public function UnlockKeyHandler():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, ShowMessageKeyHandler);
			keyHandlerLocked = false;
		}
		
		static private function ShowMessageKeyHandler(e:KeyboardEvent):void
		{
			//trace("ShowMessageKeyHandler()");
			if (
				(e.keyCode == Key.BACKSPACE) ||
				(e.keyCode == Key.SPACE) ||
				(e.keyCode == Key.ENTER) ||
				(e.keyCode == Key.ESCAPE)
				)
				{
					if (openWindowList.length == 0)
					{
						throw new Error("no open windows to be closed! - a definite logic bug");
					}
					var wnd:Window = openWindowList.shift();
					CloseWindow(wnd);
					Render();
					
					// last window, remove the listener
					if (openWindowList.length == 0)
					{
						UnlockKeyHandler();
					}
				}
		}
		
		static public function ShowMessageCentered(lines:Vector.<String>):void
		{
			ShowMessage(lines, true);
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