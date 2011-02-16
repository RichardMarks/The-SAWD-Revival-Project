package engine 
{
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class ShopItem 
	{
		static public function CreateItem(name:String, cost:Number, useFunc:Function, dropFunc:Function, modifiers:ItemModifiers):ShopItem
		{
			var item:ShopItem = new ShopItem;
			
			item.name = name;
			item.cost = cost;
			item.canEquip = false;
			item.useFunc = useFunc;
			item.dropFunc = dropFunc;
			item.modifiers = new ItemModifiers;
			item.modifiers.Clone(modifiers);
			item.equipFunc = null;
			item.unequipFunc = null;
			
			return item;
		}
		
		static public function CreateEquipment(chrClass:Number, name:String, cost:Number, equipFunc:Function, unequipFunc:Function, modifiers:ItemModifiers):ShopItem
		{
			var item:ShopItem = new ShopItem;
			
			item.name = name;
			item.cost = cost;
			item.canEquip = true;
			item.chrClass = chrClass;
			item.useFunc = null;
			item.dropFunc = null;
			item.modifiers = new ItemModifiers;
			item.modifiers.Clone(modifiers);
			item.equipFunc = equipFunc;
			item.unequipFunc = unequipFunc;
			
			return item;
		}
		
		public var name:String;
		public var cost:Number;
		public var canEquip:Boolean;
		public var chrClass:Number;
		
		public var useFunc:Function;
		public var dropFunc:Function;
		public var equipFunc:Function;
		public var unequipFunc:Function;
		
		public var modifiers:ItemModifiers;
		
		public function ShopItem() {}	
	}
}