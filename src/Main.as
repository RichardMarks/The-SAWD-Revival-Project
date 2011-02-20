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
			
			
			
			
			
			
			/*
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
			*/
			
			/*
			lines.length = 0;
			lines.push("  Yes", "  No", "  Maybe", "  Perhaps");
			var yesNoBox:MultipleChoiceBox = new MultipleChoiceBox(CL.screen, "Choose", lines);
			yesNoBox.Open();
			stage.addEventListener(MultipleChoiceBox.FINISHED, function(e:Event):void 
			{
				trace("Choice made: ", yesNoBox.Choice);
			} );
			*/
			
			//trace("CL.ShowChoice =",CL.ShowChoice("Want to save?"));
			
		}
	}

}