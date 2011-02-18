package engine.clib 
{
	import engine.vs.VirtualScreen;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class MultipleChoiceBox 
	{
		static public function Show(vs:VirtualScreen, choices:Vector.<String>):MultipleChoiceBox
		{
			return null;
		}
		
		private var myVS:VirtualScreen;
		private var myChoice:int;
		private var myChoices:Vector.<String>;
		private var myMessage:String;
		
		private var myOpenWindowList:Vector.<Window> = new Vector.<Window>();
		private var myCursor:Point = new Point;
		private var myMessagePos:Point = new Point;
		private var myOptionsPos:Point = new Point;
		private var myPos:Point = new Point;
		
		public function MultipleChoiceBox(vs:VirtualScreen, message:String, choices:Vector.<String>) 
		{
			myVS = vs;
			myChoice = 0;
			myChoices = choices;
			myMessage = message;
		}
		
		public function Open():void
		{
			var box:Vector.<int> = new Vector.<int>();
			box.push(23, 12 - int((myChoices.length + 4) * 0.5), 34, myChoices.length + 4);
			
			myPos.x = box[0] + 2;
			myPos.y = box[1] + 2;
			
			myOptionsPos.y = 0;
			myMessagePos.x = myPos.x - 1 + int(box[2] * 0.5) - int(myMessage.length * 0.5);
			
			myCursor.y = 0;
			myCursor.x = 0;
			
			myOpenWindowList.unshift(CL.OpenWindow(box[0], box[1], box[2], box[3]));
			myOpenWindowList.unshift(CL.OpenWindow(box[0], box[1] - 2, box[2], 3));
			
			CL.OutChars(myMessagePos.x, myPos.y - 5, myMessage);
			for each(var choice:String in myChoices)
			{
				CL.OutChars(myPos.x + 2, myPos.y + myOptionsPos.y, choice);
				myPos.y++;
			}
			myPos.y -= myChoices.length;
			RefreshDisplay();
			CL.stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyHandler, false, int.MAX_VALUE, false);
		}
		
		private function KeyHandler(e:KeyboardEvent):void
		{
			trace("MultipleChoiceBox::KeyHandler()");
			if (e.keyCode == Key.SPACE || e.keyCode == Key.ENTER)
			{
				myChoice = myCursor.y + 1;
				while (myOpenWindowList.length)
				{
					CL.CloseWindow(myOpenWindowList.shift());
				}
				CL.Render();
				CL.stage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyHandler);
			}
			else if (e.keyCode == Key.UP)
			{
				if (myCursor.y > 0)
				{
					myCursor.y--;
					RefreshDisplay();
				}
			}
			else if (e.keyCode == Key.DOWN)
			{
				if (myCursor.y < myChoices.length - 1)
				{
					myCursor.y++;
					RefreshDisplay();
				}
			}
		}
		
		private function RefreshDisplay():void
		{
			var count:int = myChoices.length;
			for (var i:int = 0; i < count; i++)
			{
				CL.OutChar(myPos.x, myPos.y + myOptionsPos.y + i, " ");
			}
			CL.OutChar(myPos.x, myPos.y + myOptionsPos.y + myCursor.y, String.fromCharCode(175));
			CL.Render();
		}
		
	}

}