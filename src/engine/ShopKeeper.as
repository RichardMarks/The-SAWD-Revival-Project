package engine 
{
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class ShopKeeper 
	{
		public var name:String = "Undefined";
		public var isMagicShop:Boolean = false;
		public var items:Vector.<ShopItem> = new Vector.<ShopItem>();
		public var spells:Vector.<ShopSpell> = new Vector.<ShopSpell>();
		public function ShopKeeper() {}	
	}
}