package engine.scripting 
{
	import adobe.utils.CustomActions;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class ScriptEntry 
	{
		private var myType:int;
		
		public function set Type(value:int):void { myType = value; }
		public function get Type():int { return myType; }
		
		private var myValue:ByteArray = new ByteArray;
		
		public function set IOValue(value:int):void { myValue.clear(); myValue.writeInt(value); myValue.position = 0; }
		public function get IOValue():int 
		{
			var r:int = myValue.readInt();
			myValue.position = 0;
			return r; 
		}
		
		public function set Length(value:int):void { myValue.clear(); myValue.writeInt(value); myValue.position = 0; }
		public function get Length():int 
		{ 
			var r:int = myValue.readInt();
			myValue.position = 0;
			return r;
		}
		
		public function set Selection(value:int):void { myValue.clear(); myValue.writeInt(value); myValue.position = 0; }
		public function get Selection():int 
		{ 
			var r:int = myValue.readInt();
			myValue.position = 0;
			return r;  
		}
		
		public function set IValue(value:int):void { myValue.clear(); myValue.writeInt(value); myValue.position = 0; }
		public function get IValue():int 
		{ 
			var r:int = myValue.readInt();
			myValue.position = 0;
			return r; 
		}
		
		public function set BValue(value:Boolean):void { myValue.clear(); myValue.writeInt((value) ? 1 : 0); myValue.position = 0; }
		public function get BValue():Boolean 
		{
			var r:Boolean = !(myValue.readInt() == 0);
			myValue.position = 0;
			return r; 
		}
		
		public function set FValue(value:Number):void { myValue.clear(); myValue.writeFloat(value); myValue.position = 0; }
		public function get FValue():Number 
		{ 
			var r:Number = myValue.readFloat(); 
			myValue.position = 0; 
			return r; 
		}
		
		private var myText:String;
		public function set Text(value:String):void { myText = value; }
		public function get Text():String { return myText; }
		
		public function ScriptEntry() 
		{
			Type = ScriptType.NONE;
			IOValue = 0;
			Text = null;
		}
		
	}

}