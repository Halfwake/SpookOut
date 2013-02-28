package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	
	public class PongScreen extends World
	{
		static var PADDLE_FROM_EDGE:int = 64;
		
		public var ball:Ball;
		public var paddle:Paddle;
		public var paddle_enemey:PaddleEnemy;
		
		public function PongScreen() 
		{
			MakeBall();
			MakePaddle();
			MakeEnemy();
			add(new Entity(128, Main.SCREEN_HEIGHT / 2, new Text("Thanks for playing!\nEnjoy this last minute attempt at adding another level.\nPress space to start.\nYou can't win, and if you lose the game crashes, and possibly your flashplayer. (Which will wreck all you videos.)")));
			
		}
		public function MakeEnemy():void
		{
			var example_enemy:PaddleEnemy = new PaddleEnemy(0, 0, this)
			paddle_enemey = new PaddleEnemy(Main.SCREEN_WIDTH / 2 - example_enemy.halfWidth, 0 + example_enemy.halfHeight + PongScreen.PADDLE_FROM_EDGE, this)
			add(paddle_enemey)
		}
		public function MakeBall():void
		{
			var example_ball:Ball = new Ball(0, 0, 0, 0, this);
			ball = new Ball(Main.SCREEN_WIDTH / 2 - example_ball.halfWidth, Main.SCREEN_HEIGHT / 2 - example_ball.halfHeight, 3, 2, this)
			add(ball);
		}
		public function MakePaddle():void
		{
			var example_paddle:Paddle = new Paddle(0, 0, false);
			paddle = new Paddle(Main.SCREEN_WIDTH / 2 - example_paddle.halfWidth, Main.SCREEN_HEIGHT - example_paddle.halfHeight - PongScreen.PADDLE_FROM_EDGE, false);
			add(paddle);
		}
	}

}