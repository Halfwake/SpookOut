package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	public class GameoverScreen extends World
	{
		private static var backgroundMusic:Sfx = new Sfx(Content.GameoverMusic);
		
		public function GameoverScreen()
		{
			backgroundMusic.loop()
			//bad hardcoding 128
			add(new Entity(128, Main.SCREEN_HEIGHT / 2, new Text("You failed! The spooky skeletons have claimed your soul!")));
			add(new Button(Content.QuitButtonImage, (Main.SCREEN_WIDTH / 2), (Main.SCREEN_HEIGHT / 4 * 3 ), function():void { backgroundMusic.stop();  FP.world = new MenuScreen(); } ));
		
		}
	}

}