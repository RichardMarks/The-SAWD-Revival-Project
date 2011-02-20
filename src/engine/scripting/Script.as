package engine.scripting 
{
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class Script 
	{
		private var myType:int;
		
		public function set Type(value:int):void { myType = value; }
		public function get Type():int { return myType; }
		
		private var myEntries:Vector.<ScriptEntry>;
		private var myEntryCount:int;
		public function set EntryCount(value:int):void { myEntryCount = myEntryCount; }
		public function get EntryCount():int { return myEntryCount; }
		public function set Entries(value:Vector.<ScriptEntry>):void { myEntries = value; }
		public function get Entries():Vector.<ScriptEntry> { return myEntries; }
		
		private var myPreviousNode:Script;
		private var myNextNode:Script;
		
		public function set Prev(value:Script):void { myPreviousNode = value; }
		public function set Next(value:Script):void { myNextNode = value; }
		public function get Prev():Script { return myPreviousNode; }
		public function get Next():Script { return myNextNode; }
		
		public function Script() 
		{
			Type = 0;
			myEntries = null;
			myPreviousNode = null;
			myNextNode = null;
		}	
	}
}