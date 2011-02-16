package engine 
{
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class SpellModifiers 
	{
		static public const HP:int = 0;
		static public const MP:int = 1;
		static public const ATTACK:int = 2;
		static public const DEFENSE:int = 3;
		static public const STRENGTH:int = 4;
		static public const MAGIC:int = 5;
		
		static public const MODIFIER_COUNT:int = 6;
		
		private var myFields:Vector.<Number> = new Vector.<Number>(MODIFIER_COUNT);
		
		public function get Fields():Vector.<Number> { return myFields; }
		
		public function SpellModifiers() {}
	}
}