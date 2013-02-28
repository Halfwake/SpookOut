package  
{
	import net.flashpunk.World;
	import flash.system.fscommand;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	public class MenuScreen extends World
	{
		private static var backgroundMusic:Sfx = new Sfx(Content.MenuMusic);
		
		public function MenuScreen() 
		{
			backgroundMusic.loop();
			add(new Button(Content.StartButtonImage, (Main.SCREEN_WIDTH / 2), (Main.SCREEN_HEIGHT / 4 * 1), function():void { FP.world = new BreakoutScreen; backgroundMusic.stop(); } ));
			add(new Button(Content.QuitButtonImage, (Main.SCREEN_WIDTH / 2), (Main.SCREEN_HEIGHT / 4 * 3 ), function():void { fscommand("quit") }));
		}
		
	}

}