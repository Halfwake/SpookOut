package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class HealthItem extends Entity
	{
		static public var image:Image = new Image(Content.HealthImage);
		public var owner;
		
		public function HealthItem(x:int, y:int, owner) 
		{
			graphic = image;
			
			this.x = x;
			this.y = y
			
			this.owner = owner
			owner.owner.add(this);
		}
		public function destroy():void
		{
			owner.owner.remove(this);
		}
	}

}