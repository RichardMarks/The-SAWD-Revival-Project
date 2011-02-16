package engine 
{
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class ItemModifiers 
	{
		static public const HP:int = 0;
		static public const MP:int = 1;
		static public const ATTACK:int = 2;
		static public const DEFENSE:int = 3;
		static public const STRENGTH:int = 4;
		static public const MAGIC:int = 5;
		static public const MAX_HP:int = 6;
		static public const MAX_MP:int = 7;
		static public const AP:int = 8;
		static public const MAX_AP:int = 9;
		static public const MODIFIER_COUNT:int = 10;
		
		private var myFields:Vector.<Number> = new Vector.<Number>(MODIFIER_COUNT);
		
		public function get Fields():Vector.<Number> { return myFields; }
		
		public function ItemModifiers() { }	
		
		public function Clone(source:ItemModifiers):void
		{
			var length:int = source.Fields.length;
			for (var i:int = 0; i < length; i++)
			{
				myFields[i] = Number(source.Fields[i]);
			}
		}
	}
}