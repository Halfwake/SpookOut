package  
{
	public class PaddleEnemy  extends Paddle
	{
		static var SPEED:int = 8;
		
		public var owner;
		public function PaddleEnemy(x:int, y:int, owner)
		{
			super(x, y, false);
			this.owner = owner;
		}
		override public function update():void
		{
			if (! (owner.ball.x > x && owner.ball.x + owner.ball.x < x + width))
			{
				if(owner.ball.x > x + halfWidth)
				{
					this.x += SPEED;
				}
				else if (owner.ball.x < x + halfWidth)
				{
					this.x -= SPEED;
				}
			}
		}
		
	}

}