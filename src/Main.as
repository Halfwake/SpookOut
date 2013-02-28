package 
{
	import net.flashpunk.FP;
	import net.flashpunk.Engine;
	
	public class Main extends Engine
	{
		public static const SCREEN_WIDTH:int = 800;
		public static const SCREEN_HEIGHT:int = 600;
		
		public function Main()
		{
			super(SCREEN_WIDTH, SCREEN_HEIGHT, 60, false);
			FP.world = new MenuScreen;
		}
	}
	
}