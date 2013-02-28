package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	public class Prompt extends Entity
	{
		private var key:int;
		private var image:Image;
		
		public function Prompt(x:int, y:int, key:int, message:String) 
		{
			image = new Text(message, x, y);
			graphic = image;
			setHitbox(image.width, image.height);
			
			this.key = key;
		}
		override public function update():void
		{
			if (Input.pressed(key)) { FP.world.remove(this); }
		}
		public function destroy():void
		{
			FP.world.remove(this);
		}
	}

}