package engine 
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class Obj 
	{
		public var x:Number;
		public var y:Number;
		public var image:BitmapData;
		public var battleIcon:BitmapData;
		public var name:String;
		public var chrClass:Number;
		public var maxAP:Number;
		public var curAP:Number;
		public var maxHP:Number;
		public var curHP:Number;
		public var maxMP:Number;
		public var curMP:Number;
		public var attack:Number;
		public var defense:Number;
		public var strength:Number;
		public var magic:Number;
		public var level:Number;
		public var steps:Number;
		public var experience:Number;
		public var gold:Number;
		public var drinks:Number;
		public var drunk:Boolean;
		public var items:Vector.<ShopItem> = new Vector.<ShopItem>();
		public var spells:Vector.<ShopSpell> = new Vector.<ShopSpell>();
		public var equipped:Vector.<String> = new Vector.<String>();
			
		public function Obj() {}	
	}
}