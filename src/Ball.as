package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Ball extends Entity
	{
		static public var BALL_OFF_PADDLE:int = 128;
		
		static public var MAX_SPEED:Number = 36;
		static public var MAX_LINE_SPEED:Number = Math.sqrt(Ball.MAX_SPEED);
		static public var MIN_SPEED:Number = 2;
		static public var MIN_LINE_SPEED:Number = Math.sqrt(Ball.MIN_SPEED);
		
		private var vector_x:Number;
		private var vector_y:Number;
		
		private var owner;
		
		private var image:Image;
		
		public var held:Boolean = true;
		
		public function Ball(x:int, y:int, vector_x:Number, vector_y:Number, owner)
		{
			this.owner = owner
			
			image = new Image(Content.BallImage);
			graphic = image;
			
			setHitbox(image.width, image.height)
			
			this.x = x;
			this.y = y;
			
			this.vector_x = vector_x;
			this.vector_y = vector_y;
		}
		public function getSpeed():int
		{
			return Math.abs(vector_x) + Math.abs(vector_y);
		}
		public function paddleBounce(paddle:Paddle):void
		{	
			if (paddle.left < x && x < paddle.left + (paddle.width / 3)) { vector_x = Math.abs(vector_x) * -1; changeSpeed( -3, 0); }
			if (paddle.right > x  && x > paddle.right - (paddle.width / 3)) { vector_x = Math.abs(vector_x); changeSpeed(3, 0); }
			
			var x_bounce:Boolean = !(paddle.left < x) || !(x - width < paddle.right);
			var y_bounce:Boolean = !(paddle.bottom < y) || !(y - height < paddle.top);
			
			bounce(x_bounce, y_bounce);
		}
		public function brickBounce(brick:Brick):void
		{
			var x_bounce:Boolean = !(brick.left < x) || !(x - width < brick.right);
			var y_bounce:Boolean = !(brick.bottom < y) || !(y - height < brick.top);
			bounce(x_bounce, y_bounce);
			brick.destroy();
		}
		public function screenBounce():void
		{
			var x_bounce:Boolean = !(0 < x) || !(x < Main.SCREEN_WIDTH - width);
			var y_bounce:Boolean = !(0 < y) || !(y < Main.SCREEN_HEIGHT - height);
			bounce(x_bounce, y_bounce)
		}
		private function changeSpeed(delta_x:Number, delta_y:Number):void
		{
			var new_x:Number = vector_x + delta_x;
			var new_y:Number = vector_y + delta_y;
			
			if (Math.abs(new_x) > MAX_LINE_SPEED) { new_x = MAX_LINE_SPEED * absOne(vector_x); }
			if (Math.abs(new_x) < MIN_LINE_SPEED) { new_x = MIN_LINE_SPEED * absOne(vector_x); }
			if (Math.abs(new_y) > MAX_LINE_SPEED) { new_y = MAX_LINE_SPEED * absOne(vector_y); }
			if (Math.abs(new_y) < MIN_LINE_SPEED) { new_y = MIN_LINE_SPEED * absOne(vector_y); }
			
			vector_x = new_x;
			vector_y = new_y;
		}
		private function absOne(val:Number):int
		{
			if (val < 0) { return -1; }
			else if (val > 0) { return 1; }
			else { return 1; }
		}
		private function bounce(x_bounce:Boolean, y_bounce:Boolean):void
		{
			if (x_bounce)
			{
				changeSpeed(2 * absOne(vector_x), 0);
				changeSpeed(0, ((absOne(vector_y) == 0) ? 1 : -1 * absOne(vector_y)));
				
				vector_x *= -1;
			}
			if (y_bounce)
			{
				changeSpeed(0, 2 * absOne(vector_y));
				changeSpeed(((absOne(vector_x) == 0) ? 1 : -1 * absOne(vector_x)), 0);
				
				vector_y *= -1;
			}
		}
		override public function update():void
		{
			if (!held)
			{
				x += vector_x;
				y += vector_y;
				
				if (!onCamera)
				{
					if (y > Main.SCREEN_HEIGHT) { destroy();  owner.NewBall(); }
					screenBounce()
				}
				var brick_collision = collide("brick", x, y);
				if (brick_collision) { brickBounce(brick_collision); }
				var paddle_collision = collide("paddle", x, y);
				if (paddle_collision) { paddleBounce(paddle_collision); }
				var example_paddle:Paddle = new Paddle(0, 0, false);
				if (collide("paddle", x, y)  && owner.paddle.player) { y = Main.SCREEN_HEIGHT - Paddle.PADDLE_OFF_GROUND - height * 2; }
			}
			else if (Input.check(Key.SPACE))
			{
				held = false;
			}
		}
		public function destroy():void
		{
			owner.healthBar.LoseHealth();
			FP.world.remove(this);
		}
	}
}