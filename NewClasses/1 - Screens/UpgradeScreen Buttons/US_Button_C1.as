package  {
	
	import flash.display.Sprite;
	
	
	public class US_Button_C1 extends Sprite implements IUpgradeScreenButton {
		
		public var _isPurchased : Boolean;
		public var _isUnlocked : Boolean;
		public var _description : String = "Unlocks Side-Laser Drops";
		public var _price : int = 2000;
		
		public function US_Button_C1() {
			reset();
		}
		
		public function reset() : void {
			_isPurchased = GlobalSharedObject.instance.isPurchased[6];
			_isUnlocked = GlobalSharedObject.instance.isUnlocked[6];
			
			if (_isUnlocked) visible = true;
			else visible = false;
		}
		
		// activate purchase
		public function purchase(refToUS : UpgradeScreen) : void {
			
			GlobalSharedObject.instance.modifyGlobalScore(-_price);
			refToUS.pRef.MM.setGlobalScoreText();
			
			_isPurchased = true;
			GlobalSharedObject.instance.modifyIsPurchased(6, true);
			
			refToUS.c2._isUnlocked = true;
			refToUS.c2.visible = true;
			refToUS.c1.shadow.visible = true;
			
			GlobalSharedObject.instance.modifyIsUnlocked(7, true);
			
		}
	}
	
}
