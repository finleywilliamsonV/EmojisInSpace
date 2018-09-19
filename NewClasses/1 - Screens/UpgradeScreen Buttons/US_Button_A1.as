package  {
	
	import flash.display.Sprite;
	
	
	public class US_Button_A1 extends Sprite implements IUpgradeScreenButton {
		
		public var _isPurchased : Boolean;
		public var _isUnlocked : Boolean;
		public var _description : String = "3 Lives >> 6 Lives";
		public var _price : int = 500;
		
		public function US_Button_A1() : void {
			reset();
		}
		
		public function reset() : void {
			_isPurchased = GlobalSharedObject.instance.isPurchased[0];
			_isUnlocked = GlobalSharedObject.instance.isUnlocked[0];
			
			if (_isUnlocked) visible = true;
			else visible = false;
		}
		
		// activate purchase
		public function purchase(refToUS : UpgradeScreen) : void {
			
			GlobalSharedObject.instance.modifyGlobalScore(-_price);
			refToUS.pRef.MM.setGlobalScoreText();
			
			GlobalSharedObject.instance.modifyMaxLives(3);
			
			_isPurchased = true;
			GlobalSharedObject.instance.modifyIsPurchased(0, true);
			
			refToUS.a2._isUnlocked = true;
			refToUS.a2.visible = true;
			refToUS.a1.shadow.visible = true;
			GlobalSharedObject.instance.modifyIsUnlocked(1, true);
		}
	}
	
}
