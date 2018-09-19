package  {
	
	import flash.display.Sprite;
	
	
	public class US_Button_C3 extends Sprite implements IUpgradeScreenButton {
		
		public var _isPurchased : Boolean;
		public var _isUnlocked : Boolean;
		public var _description : String = "Unlocks Smart-Bomb Drops";
		public var _price : int = 30000;
		
		public function US_Button_C3() {
			reset();
		}
		
		public function reset() : void {
			_isPurchased = GlobalSharedObject.instance.isPurchased[8];
			_isUnlocked = GlobalSharedObject.instance.isUnlocked[8];
			
			if (_isUnlocked) visible = true;
			else visible = false;
		}
		
		// activate purchase
		public function purchase(refToUS : UpgradeScreen) : void {
			
			GlobalSharedObject.instance.modifyGlobalScore(-_price);
			refToUS.pRef.MM.setGlobalScoreText();
			
			refToUS.c3.shadow.visible = true;
			
			_isPurchased = true;
			GlobalSharedObject.instance.modifyIsPurchased(8, true);
		}
	}
	
}
