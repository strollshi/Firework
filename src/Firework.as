package
{
	import com.FireStar;
	import com.FireStar1;
	import com.FireworkController;
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	[SWF(backgroundColor="0x000000",  frameRate="24")] 
	
	public class Firework extends Sprite
	{
		public static var _Stage:Stage;
		private var fireWorkCtrl1:FireworkController;
		private var fireWorkCtrl2:FireworkController;
		public function Firework()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			_Stage = this.stage;
			
			fireWorkCtrl2 = new FireworkController(FireStar,190);
			this.addChild(fireWorkCtrl2);
			TweenMax.delayedCall(0.3,play2);
			
			fireWorkCtrl1 = new FireworkController(FireStar1,250);
			this.addChild(fireWorkCtrl1);
			play1();
		}
		
		private function play1():void {
			fireWorkCtrl1.play();
			TweenMax.delayedCall(4,play1);
		}
		
		private function play2():void {
			fireWorkCtrl2.play();
			TweenMax.delayedCall(4,play2);
		}
	}
}