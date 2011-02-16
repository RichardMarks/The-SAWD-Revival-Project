package engine.vs 
{
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class VSCharacterInfo 
	{
		public var character:String;
		public var foreground:int;
		public var background:int;
		
		public function VSCharacterInfo() 
		{
			character = " ";
			foreground = 1 | 2 | 4;
			background = 0;
		}
		
		public function copy(source:VSCharacterInfo):void
		{
			character = source.character.substr(0, 1);
			foreground = source.foreground;
			background = source.background;
		}
		
		public function toString():String
		{
			return "VSC[" + character +","+ foreground +","+ background+"]";
		}
	}

}