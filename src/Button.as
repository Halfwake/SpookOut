package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	
	public class Button extends Entity
	{	
		private var command:Function;
		private var sound:Sfx;
		
		public function Button(image_name:Class, x:int, y:int, command:Function) 
		{
			var image:Image = new Image(image_name);
			graphic = image
			
			sound = new Sfx(Content.ButtonSound);
			
			setHitbox(image.width, image.height)
			
			this.x = x - ((right - left) / 2);
			this.y = y - ((top - bottom) / 2);
			this.command = command;
		}
		override public function update():void
		{
			if (Input.mousePressed)
			{
				if ((x < Input.mouseX) && (Input.mouseX < (x + width)))
				{
					if ((y < Input.mouseY) && (Input.mouseY < (y + height)))
					{
						sound.play()
						while (true) { if (sound.position >= sound.length - 1) { this.command(); break; } }
					}
				}
			}
		}
		
	}

}