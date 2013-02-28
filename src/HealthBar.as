package  
{
	import net.flashpunk.FP;
	
	public class HealthBar 
	{
		static public var maxHealth:int = 3;
		static public var startHealth:int = 3;
		
		private var health:Vector.<HealthItem> = new Vector.<HealthItem>;
		public var owner;
		
		public function HealthBar(x:int, y:int, seperation_width:int, owner) 
		{
			this.owner = owner;
			for (var i:int = 0; i < startHealth; i++)
			{
				var health_item:HealthItem = new HealthItem(HealthItem.image.width * i + seperation_width * i + x, y, this);
				health.push(health_item);
			}
		}
		public function LoseHealth():void
		{
			health.pop().destroy();
			if (health.length == 0) { owner.LoseGame(); }
		}
		public function Empty():Boolean
		{
			return (0 == health.length)
		}
		
	}

}