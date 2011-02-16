package engine 
{
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class ItemTarget 
	{
		private var mySelf:Object;
		private var myTarget:Object;
		
		public function get Self():Object { return mySelf; }
		public function get Target():Object { return myTarget; }
		
		public function ItemTarget(self:Object, target:Object) 
		{
			mySelf = self;
			myTarget = target;
		}
	}
}