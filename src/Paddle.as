package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
		
	public class Paddle extends Entity
	{		
		private var image:Image;
		
		static public var PADDLE_OFF_GROUND:int = 32;
		
		static private var SCALE_X:Number = 0.025;
		static private var SCALE_Y:Number = 0.5;
		static private var MAX_SCALE_X:Number = (new Image(Content.PaddleImage)).width * 1.10;
		static private var MAX_SCALE_Y:Number = (new Image(Content.PaddleImage)).width * 1.10;
		
		static private var velocity:int;
		static private var scale_tween:Vector.<Function> = new Vector.<Function>();
		
		public var player:Boolean;
		
		public function Paddle(x:int, y:int, player:Boolean)
		{
			this.player = player;
			
			image = new Image(Content.PaddleImage);
			graphic = image;
			
			setHitbox(image.width, image.height);
			type = "paddle";
			
			this.x = x;
			this.y = y;
		}
		private function squeeze(velocity:Number):void
		{
			var image:Image = new Image(Content.PaddleImage);
			
			if (image.width < MAX_SCALE_X) { scale_tween.push(function():void { image.scaleX  += SCALE_X * velocity; x -= SCALE_X * velocity / 2; } ) }
			if (width < image.width) { scale_tween.push(function():void { image.scaleY -= SCALE_Y * velocity; y += SCALE_Y * velocity / 2 })}
			
			graphic = image;
		}
		private function stretch(velocity:int):void
		{
			var image:Image = new Image(Content.PaddleImage);
			
			if (width < image.width) { scale_tween.push(function():void { image.scaleX -= SCALE_X * velocity; x += SCALE_X * velocity / 2 })}
			if (image.width < MAX_SCALE_Y) { scale_tween.push(function():void { image.scaleY += SCALE_Y * velocity; y -= SCALE_Y * velocity / 2})}
			
			graphic = image;
		}
		override public function update():void
		{
			var new_x:int = (Input.mouseX - halfWidth);
			if ((0 <= new_x) && (new_x <= Main.SCREEN_WIDTH - width))
			{
				velocity = (Math.abs(new_x - x) + velocity + velocity) / 3; //Avergaes velocity for smoothing
				if (new_x != x)
				{
					squeeze(velocity)
				}
				else
				{
					stretch(velocity)
				}
				x = new_x;
			}
			while (scale_tween.length > 0) { scale_tween.pop()(); }
		}
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
	}

}