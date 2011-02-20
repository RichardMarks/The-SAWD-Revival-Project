package engine.scripting 
{
	import engine.scripting.Script;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class SAWDScriptEngine extends ScriptEngine 
	{
		
		
		static public const MAX_FLAGS:int = 512;
		private var myFlags:Vector.<Boolean> = new Vector.<Boolean>(MAX_FLAGS);
		private var myVariables:Vector.<int> = new Vector.<int>(MAX_FLAGS);
		
		public function SAWDScriptEngine() 
		{
			Reset();
		}
		
		public function Reset():void
		{
			for (var i:int = 0; i < MAX_FLAGS; i++)
			{
				myFlags[i] = false;
				myVariables[i] = 0;
			}
		}
		
		override protected function Release():Boolean 
		{
			return super.Release();
		}
		
		override protected function ProcessAction(script:Script):Script 
		{
			switch(script.Type)
			{
				case ScriptActionType.END: { return SA_End(script); } break;
				case ScriptActionType.ELSE: { return SA_Else(script); } break;
				case ScriptActionType.END_IF: { return SA_EndIf(script); } break;
				case ScriptActionType.IF_FLAG_THEN: { return SA_IfFlagThen(script); } break;
				case ScriptActionType.IF_VARIABLE_THEN: { return SA_IfVariableThen(script); } break;
				case ScriptActionType.SET_FLAG: { return SA_SetFlag(script); } break;
				case ScriptActionType.SET_VARIABLE: { return SA_SetVariable(script); } break;
				case ScriptActionType.LABEL: { return SA_Label(script); } break;
				case ScriptActionType.GOTO: { return SA_Goto(script); } break;
				case ScriptActionType.MESSAGE: { return SA_Message(script); } break;
				case ScriptActionType.COMMENT: { return SA_Comment(script); } break;
				case ScriptActionType.SEPARATOR: { return SA_Comment(script); } break;
				case ScriptActionType.IF_RAND_THEN: { return SA_IfRandomThen(script); } break;
				
				default:
				{
					trace("Unsupported script action type:", script.Type);
					break;
				}
			}
			
			return super.ProcessAction(script);
		}
		
		private function SA_Comment(script:Script):Script 
		{
			return script.Next;
		}
		
		private function SA_IfThen(script:Script, skip:Boolean = false):Script 
		{
			var skipping:Boolean = skip.valueOf();
			while (script != null)
			{
				if (script.Type == ScriptActionType.ELSE)
				{
					skipping = !skipping;
				}
				
				if (script.Type == ScriptActionType.END_IF)
				{
					return script.Next;
				}
				
				if (skipping)
				{
					script = script.Next;
				}
				else
				{
					if (script.Type == ScriptActionType.GOTO)
					{
						return ProcessAction(script);
					}
					
					script = ProcessAction(script);
					if (script == null)
					{
						return null;
					}
				}
			}
			
			return null;
		}
		
		private function SA_IfRandomThen(script:Script):Script 
		{
			return SA_IfThen(script.Next, !((Math.random() * script.Entries[0].IValue) >= script.Entries[1].IValue));
		}
		
		private function SA_IfFlagThen(script:Script):Script 
		{
			return SA_IfThen(script.Next, !(myFlags[script.Entries[0].IValue] == script.Entries[1].BValue));
		}
		
		private function SA_IfVariableThen(script:Script):Script 
		{ 
			return SA_IfThen(script.Next, !(myVariables[script.Entries[0].IValue] == script.Entries[1].IValue));
		}
		
		private function SA_SetFlag(script:Script):Script 
		{
			myFlags[script.Entries[0].IValue] = script.Entries[1].BValue;
			return script.Next;
		}
		
		private function SA_SetVariable(script:Script):Script 
		{
			myVariables[script.Entries[0].IValue] = script.Entries[1].IValue;
			return script.Next;
		}
		
		private function SA_End(script:Script):Script 
		{ 
			return null; 
		}
		
		private function SA_Else(script:Script):Script 
		{ 
			return script.Next; 
		}
		
		private function SA_EndIf(script:Script):Script 
		{ 
			return script.Next; 
		}
		
		private function SA_Label(script:Script):Script 
		{
			return script.Next;
		}
		
		private function SA_Goto(scriptPtr:Script):Script 
		{ 
			var script:Script = Parent;
			while (script != null)
			{
				if (script.Entries[0].IValue == scriptPtr.Entries[0].IValue)
				{
					return script.Next;
				}
				script = script.Next;
			}
			return null;
		}
		
		private function SA_Message(script:Script):Script 
		{
			trace("SAWDScriptEngine::SA_Message() -> ", script.Entries[0].Text);
			return script.Next;
		}
		
	}

}