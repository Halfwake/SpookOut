package  
{
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.utils.Key;
	
	public class BreakoutScreen extends World
	{	
		static public var BRICKS_WIDTH:int = 8;
		static public var BRICKS_HEIGHT:int = 8;
		private var backgroundMusic:Sfx = new Sfx(Content.MonsterMashSound);
		private var endMusic:Sfx = new Sfx(Content.EndSound);
		public var paddle:Paddle;
		private var ball:Ball;
		private var bricks:Vector.<Vector.<Brick>>;
		private var startPrompt:Prompt;
		
		public var healthBar:HealthBar;
		
		
		public function BreakoutScreen() 
		{
			NewGame();
		}
		public function NewGame():void
		{
			Brick.brickCount = 0;
			backgroundMusic.play();
			MakePaddle();
			MakeHealth();
			NewRound();
			
		}
		public function MakePaddle():void
		{
			var example_paddle:Paddle = new Paddle(0, 0, false);
			paddle = new Paddle(Main.SCREEN_WIDTH / 2 - example_paddle.halfWidth, Main.SCREEN_HEIGHT - example_paddle.halfHeight - Paddle.PADDLE_OFF_GROUND, true);
			add(paddle);
		}
		public function NewRound():void
		{	
			CreateBricks();
			MakeBall();
			PromptPlay();
		
		}
		public function CreateBricks():void
		{
			var example_brick:Brick = new Brick(0, 0, this);
			Brick.brickCount -= 1;
			
			var bricks_x:int = ((Main.SCREEN_WIDTH - ((BRICKS_WIDTH * (example_brick.width + Brick.BRICK_OFFSET_WIDTH) - Brick.BRICK_OFFSET_WIDTH))) / 2);
			var bricks_y:int = example_brick.height;
			
			bricks = new Vector.<Vector.<Brick>>
			for (var i:int = 0; i < BRICKS_WIDTH; i += 1)
			{
				var a_row:Vector.<Brick> = new Vector.<Brick>
				for (var j:int = 0; j < BRICKS_HEIGHT; j += 1)
				{
					var brick_x:int = (i * example_brick.width) + (Brick.BRICK_OFFSET_WIDTH * i) + bricks_x + Brick.BRICK_OFFSET_WIDTH;
					var brick_y:int = (j * example_brick.height) + (Brick.BRICK_OFFSET_HEIGHT * j)  + bricks_y;
					var new_brick:Brick = new Brick(brick_x, brick_y, this);
					a_row.push(new_brick);
					add(new_brick);
				}
				bricks.push(a_row);
			}
		}
		public function MakeHealth():void
		{
			var health_bar:HealthBar = new HealthBar(0, 0, HealthItem.image.width / 4, this);
			healthBar = health_bar;
		}
		public function GoMenu():void
		{
			backgroundMusic.stop();
			FP.world = new MenuScreen;
		}
		public function NewBall():void
		{
			MakeBall();
			PromptPlay();
		}
		public function MakeBall():void
		{
			var example_ball:Ball = new Ball(0, 0, 0, 0, this);
			var example_paddle:Paddle = new Paddle(0, 0, false);
			ball = new Ball(Main.SCREEN_WIDTH / 2 - example_ball.halfWidth, Main.SCREEN_HEIGHT - example_paddle.height - Paddle.PADDLE_OFF_GROUND - Ball.BALL_OFF_PADDLE, 0, Ball.MIN_SPEED, this)
			add(ball);
		}
		public function PromptPlay():void
		{
			var new_prompt:Prompt = new Prompt(Main.SCREEN_WIDTH - 500, Main.SCREEN_HEIGHT - 128, Key.SPACE, "Press  SPACEBAR to begin!"); //Hardcoding
			startPrompt = new_prompt;
			add(new_prompt);
		}
		public function EndGame():void
		{
			backgroundMusic.stop();
			endMusic.play();
			paddle.destroy();
			ball.destroy();
			while (true)
			{
				if (endMusic.position >= endMusic.length - 1)
				{
					if (healthBar.Empty())
					{
						LoseGame();
					}
					else
					{
						backgroundMusic.stop();
						FP.world = new PongScreen();
					}
					break;
				}
			}
		}
		public function LoseGame()
		{
			backgroundMusic.stop();
			FP.world = new GameoverScreen();
		}
	}
}