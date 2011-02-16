package engine.vs 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class VirtualScreen
	{
		protected var myBuffer:Vector.<VSCharacterInfo>;
		protected var myCaret:Point = new Point;
		protected var myRows:int;
		protected var myColumns:int;
		protected var mySize:int;
		protected var myForegroundColor:int;
		protected var myBackgroundColor:int;
		protected var myRenderTarget:BitmapData;
		protected var myTabSize:int = 4;
		
		public function VirtualScreen(renderTarget:BitmapData, columns:int = 80, rows:int = 25) 
		{
			myRenderTarget = renderTarget;
			Home();
			Create(columns, rows);
		}
		
		public function Create(columns:int = 80, rows:int = 25):void
		{
			mySize = columns * rows;
			myColumns = columns;
			myRows = rows;
			myBuffer = new Vector.<VSCharacterInfo>(length);
			for (var i:int = 0; i < mySize; i++)
			{
				myBuffer[i] = new VSCharacterInfo;
			}
		}
		
		public function Clear(fillCharacter:String = " "):void
		{
			var filler:String = fillCharacter.substr(0, 1);
			for (var i:int = 0; i < mySize; i++)
			{
				var cell:VSCharacterInfo = myBuffer[i];
				cell.character = filler;
				cell.foreground = myForegroundColor;
				cell.background = myBackgroundColor;
			}
		}
		
		public function PutChar(c:String):void
		{
			var index:int = int(myCaret.x + (myCaret.y * myColumns));
			var cell:VSCharacterInfo = myBuffer[index];
			
			cell.character = c.substr(0, 1);
			cell.background = myBackgroundColor;
			cell.foreground = myForegroundColor;
			
			myCaret.x++;
			if (myCaret.x >= myColumns)
			{
				CrLf();
			}
		}
		
		public function Puts(s:String):void
		{
			var sLength:int = s.length;
			for (var i:int = 0; i < sLength; i++)
			{
				var ch:String = s.charAt(i);
				if (ch == "\n")
				{
					CrLf();
				}
				else if (ch == "\t")
				{
					HTab();
				}
				else
				{
					PutChar(ch);
				}
			}
		}
		
		public function GetChar():String
		{
			return VSCharacterInfo(myBuffer[int(myCaret.x + (myCaret.y * myColumns))]).character;
		}
		
		public function SetXY(x:Number, y:Number):void
		{
			CaretX = x;
			CaretY = y;
		}
		
		public function Home():void 
		{
			myCaret.x = 0;
			myCaret.y = 0;
		}
		
		public function CrLf(reps:int = 1):void 
		{
			for (var rep:int = 0; rep < reps; rep++)
			{
				myCaret.x = 0;
				myCaret.y++;
				if (myCaret.y >= myRows)
				{
					var len:int = myColumns + (myColumns * (myRows - 1));
					for (var i:int = myColumns; i < len; i++)
					{
						myBuffer[i - myColumns].copy(myBuffer[i]);
					}
					myCaret.y--;
				}
			}
		}
		
		public function HTab(reps:int = 1):void 
		{
			for (var rep:int = 0; rep < reps; rep++)
			{
				myCaret.x += myTabSize;
				if (myCaret.x >= myColumns)
				{
					var offset:int = myCaret.x - myColumns;
					CrLf();
					myCaret.x += offset;
				}
			}
		}
		
		
		public function get Caret():Point { return myCaret; }
		public function set CaretX(value:int):void 
		{ 
			myCaret.x = int((value >= 0 && value < myColumns) ? value : myCaret.x);
		}
		
		public function set CaretY(value:int):void 
		{ 
			myCaret.y = int((value >= 0 && value < myRows) ? value : myCaret.y);
		}
		
		public function get Buffer():Vector.<VSCharacterInfo> { return myBuffer; }
		public function get ForegroundColor():int { return myForegroundColor; }
		public function get BackgroundColor():int { return myBackgroundColor; }
		
		public function set ForegroundColor(value:int):void
		{
			myForegroundColor = 0;
			if (value & 1) { myForegroundColor |= VSColorAttribute.FOREGROUND_RED; }
			if (value & 2) { myForegroundColor |= VSColorAttribute.FOREGROUND_GREEN; }
			if (value & 4) { myForegroundColor |= VSColorAttribute.FOREGROUND_BLUE; }
			if (value & 8) { myForegroundColor |= VSColorAttribute.FOREGROUND_BRIGHT; }
		}
		
		public function set BackgroundColor(value:int):void
		{
			myBackgroundColor = 0;
			if (value & 1) { myBackgroundColor |= VSColorAttribute.BACKGROUND_RED; }
			if (value & 2) { myBackgroundColor |= VSColorAttribute.BACKGROUND_GREEN; }
			if (value & 4) { myBackgroundColor |= VSColorAttribute.BACKGROUND_BLUE; }
			if (value & 8) { myBackgroundColor |= VSColorAttribute.BACKGROUND_BRIGHT; }
		}
		
		public function Display():void
		{
			
		}
		
		// font printing system below
		
		static public const LETTER_WIDTH:int = 8;
		static public const LETTER_HEIGHT:int = 8;
		protected var myLetterCoordX:Vector.<int> = new Vector.<int>(256);
		protected var myLetterCoordY:Vector.<int> = new Vector.<int>(256);
		protected var myPalette:Vector.<uint> = new Vector.<uint>(16);
		protected var myFontSurface:BitmapData = new BitmapData(2048, 128, false, 0xFF000000);
		
		protected function GenerateFonts():void
		{
			
		}
		
		static public function Make32BitColor(r:uint, g:uint, b:uint, a:uint = 0xFF):uint
		{
			return (a << 24) | (r << 16) | (g << 8) | b;
		}
	}

}