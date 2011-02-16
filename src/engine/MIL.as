package engine 
{
	/**
	 * master item list - item management and asset loading
	 * @author Richard Marks
	 */
	public class MIL 
	{
		static private var items:Vector.<ShopItem>;
		
		static public function Create(milDefinitions:Class):void
		{
			var xmlDocRoot:XML = new XML(new milDefinitions);
			LoadMILDefinitionsXML(xmlDocRoot);
		}
		
		static private function LoadMILDefinitionsXML(xmlDocRoot:XML):void
		{
			
		}
		
		static public function AddMasterItem(item:ShopItem):void
		{
			
		}
		
		static public function GetItemID(name:String):int
		{
			
		}
		
		static public function GetMasterItem(name:String):ShopItem
		{
			
		}
		
	}
}