package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	public class Brick extends Entity
	{
		static public var brickCount:int = 0;
		
		static public var BRICK_OFFSET_WIDTH:int = 16;
		static public var BRICK_OFFSET_HEIGHT:int = 16;
		
		static private var hitSound:Sfx = new Sfx(Content.BrickSound);
		static private var brickVolume:Number = 0.3;
		
		private var image:Image;
		private var owner:BreakoutScreen;
		
		public function Brick(x:int, y:int, owner:BreakoutScreen) 
		{
			brickCount += 1;
			
			this.owner = owner;
			
			image = new Image(Content.BrickImage);
			graphic = image;
			
			setHitbox(image.width, image.height);
			type = "brick";
			
			this.x = x;
			this.y = y;
		}
		public function destroy():void
		{
			brickCount -= 1;
			FP.world.remove(this);
			hitSound.play(brickVolume);
			if (brickCount <= 0)
			{
				owner.EndGame();
			}
		}
	}

}