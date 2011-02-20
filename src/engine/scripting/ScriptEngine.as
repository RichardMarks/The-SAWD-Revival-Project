package engine.scripting 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class ScriptEngine
	{
		private var myActionCount:int;
		protected var myParentScript:Script;
		
		public function get Parent():Script { return myParentScript; }
		
		public function ScriptEngine() 
		{
			myActionCount = 0;
			myParentScript = null;
		}
		
		public function Load(source:ByteArray):Boolean
		{
			var 
				scriptHead:Script = null,
				script:Script = null,
				scriptPtr:Script = null;
			
			Free();
			
			// number of actions
			myActionCount = source.readInt();
			
			// loop over each action
			for (var i:int = 0; i < myActionCount; i++)
			{
				// allocate a script
				script = new Script;
				script.Next = null;
				if (scriptPtr == null)
				{
					scriptHead = script;
				}
				else
				{
					scriptPtr.Next = script;
				}
				scriptPtr = script;
				
				// type of action
				script.Type = source.readInt();
				script.EntryCount = source.readInt();
				
				// load entry data
				if (script.EntryCount > 0)
				{
					script.Entries = new Vector.<ScriptEntry>(script.EntryCount);
					
					// load each entry
					for (var entryIndex:int = 0; entryIndex < script.EntryCount; entryIndex++)
					{
						// get entry type and data
						script.Entries[entryIndex].Type = source.readInt();
						script.Entries[entryIndex].IOValue = source.readInt();
						
						// get text for entry if the type is text
						if (script.Entries[entryIndex].Type == ScriptType.TEXT && script.Entries[entryIndex].Length)
						{
							var textBytes:ByteArray = new ByteArray;
							source.readBytes(textBytes, 0, script.Entries[entryIndex].Length);
							script.Entries[entryIndex].Text = textBytes.toString();
						}
					}
				}
			}
			
			myParentScript = scriptHead;
			
			return true;
		}
		
		public function Free():Boolean 
		{ 
			myActionCount = 0;
			myParentScript = null;
			return true; 
		}
		public function Execute(source:ByteArray):Boolean
		{
			if (source != null)
			{
				Load(source);
			}
			
			if (!Prepare())
			{
				return false;
			}
			
			var scriptPtr:Script = myParentScript;
			if (scriptPtr == null)
			{
				return false;
			}
			
			while (scriptPtr != null)
			{
				scriptPtr = ProcessAction(scriptPtr);
			}
			
			Release();
			
			if (source != null)
			{
				Free();
			}
			
			return true;
		}
		
		protected function Prepare():Boolean { return true; }
		
		protected function Release():Boolean { return true; }
		
		protected function ProcessAction(script:Script):Script
		{
			if (script == null)
			{
				throw new Error("ScriptEngine::ProcessAction() - script should not be null");
			}
			return script.Next;
		}	
	}
}