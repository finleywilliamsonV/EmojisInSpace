package  {
	
	import flash.display.Sprite;
	
	
	public class US_Button_B2 extends Sprite implements IUpgradeScreenButton {
		
		public var _isPurchased : Boolean;
		public var _isUnlocked : Boolean;
		public var _description : String = "Shoot Two Lasers";
		public var _price : int = 8000;
		
		public function US_Button_B2() {
			reset();
		}
		
		public function reset() : void {
			_isPurchased = GlobalSharedObject.instance.isPurchased[4];
			_isUnlocked = GlobalSharedObject.instance.isUnlocked[4];
			
			if (_isUnlocked) visible = true;
			else visible = false;
		}
		
		
		// activate purchase
		public function purchase(refToUS : UpgradeScreen) : void {
			
			GlobalSharedObject.instance.modifyGlobalScore(-_price);
			refToUS.pRef.MM.setGlobalScoreText();
			
			GlobalVariables.instance.currentPrimaryLaser = LaserBall_v2Cluster;
			
			_isPurchased = true;
			GlobalSharedObject.instance.modifyIsPurchased(4, true);
			
			refToUS.b3._isUnlocked = true;
			refToUS.b3.visible = true;
			refToUS.b2.shadow.visible = true;
			
			GlobalSharedObject.instance.modifyIsUnlocked(5, true);
		}
	}
	
}
