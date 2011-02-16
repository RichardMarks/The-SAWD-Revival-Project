package clib 
{
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class CL 
	{
		// core functions
		static public function Initialize():void
		{
			
		}
		
		static public function SetBackgroundColor(color:uint):void
		{
			
		}
		
		static public function SetForegroundColor(color:uint):void
		{
			
		}
		
		static public function SetCursorPosition(x:int, y:int):void
		{
			
		}
		
		static public function ClearScreen():void
		{
			
		}
		
		static public function OutChar(x:int, y:int, c:uint):void
		{
			
		}
		
		static public function OutChars(x:int, y:int, c:String):void
		{
			
		}
		
		static public function OutCharsF(x:int, y:int, format:String, ...opt):void
		{
			
		}
		
		// UI functions
		
		static public function OpenWindow(x:int, y:int, width:int, height:int, backColor:uint, foreColor:uint):Window
		{
			
		}
		
		static public function OpenWindowNoFrame(x:int, y:int, width:int, height:int, backColor:uint, foreColor:uint):Window
		{
			
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