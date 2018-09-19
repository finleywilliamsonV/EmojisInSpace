package  {
	
	import flash.display.Sprite;
	
	
	public class US_Button_A3 extends Sprite implements IUpgradeScreenButton {
		
		public var _isPurchased : Boolean;
		public var _isUnlocked : Boolean;
		public var _description : String = "Unlocks 1-Up Drops";
		public var _price : int = 18000;
		
		public function US_Button_A3() {
			reset();
		}
		
		public function reset() : void {
			_isPurchased = GlobalSharedObject.instance.isPurchased[2];
			_isUnlocked = GlobalSharedObject.instance.isUnlocked[2];
			
			if (_isUnlocked) visible = true;
			else visible = false;
		}
		
		// activate purchase
		public function purchase(refToUS : UpgradeScreen) : void {
			
			GlobalSharedObject.instance.modifyGlobalScore(-_price);
			refToUS.pRef.MM.setGlobalScoreText();
			//GlobalSharedObject.instance.modifyMaxLives(3);
			
			_isPurchased = true;
			refToUS.a3.shadow.visible = true;
			
			GlobalSharedObject.instance.modifyIsPurchased(2, true);
		
		}
	}
	
}
