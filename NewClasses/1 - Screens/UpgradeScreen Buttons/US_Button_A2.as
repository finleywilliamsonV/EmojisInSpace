package  {
	
	import flash.display.Sprite;
	
	
	public class US_Button_A2 extends Sprite implements IUpgradeScreenButton {
		
		public var _isPurchased : Boolean;
		public var _isUnlocked : Boolean;
		public var _description : String = "6 Lives >> 9 Lives";
		public var _price : int = 4000;
		
		public function US_Button_A2() {
			reset();
		}
		
		public function reset() : void {
			_isPurchased = GlobalSharedObject.instance.isPurchased[1];
			_isUnlocked = GlobalSharedObject.instance.isUnlocked[1];
			
			if (_isUnlocked) visible = true;
			else visible = false;
		}
		
		
		// activate purchase
		public function purchase(refToUS : UpgradeScreen) : void {
			
			GlobalSharedObject.instance.modifyGlobalScore(-_price);
			
			refToUS.pRef.MM.setGlobalScoreText();
			GlobalSharedObject.instance.modifyMaxLives(3);
			
			_isPurchased = true;
			GlobalSharedObject.instance.modifyIsPurchased(1, true);
			
			refToUS.a3._isUnlocked = true;
			refToUS.a3.visible = true;
			refToUS.a2.shadow.visible = true;
			
			GlobalSharedObject.instance.modifyIsUnlocked(2, true);
		}
	}
	
}
