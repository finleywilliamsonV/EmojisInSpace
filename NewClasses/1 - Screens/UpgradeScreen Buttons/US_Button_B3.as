package {

	import flash.display.Sprite;


	public class US_Button_B3 extends Sprite implements IUpgradeScreenButton {

		public var _isPurchased: Boolean;
		public var _isUnlocked: Boolean;
		public var _description: String = "Shoot Three Lasers";
		public var _price: int = 24000;

		public function US_Button_B3() {
			reset();
		}
		
		public function reset() : void {
			_isPurchased = GlobalSharedObject.instance.isPurchased[5];
			_isUnlocked = GlobalSharedObject.instance.isUnlocked[5];
			
			if (_isUnlocked) visible = true;
			else visible = false;
		}


		// activate purchase
		public function purchase(refToUS : UpgradeScreen): void {

			GlobalSharedObject.instance.modifyGlobalScore(-_price);
			refToUS.pRef.MM.setGlobalScoreText();

			GlobalVariables.instance.currentPrimaryLaser = LaserBall_v3Cluster;

			_isPurchased = true;
			refToUS.b3.shadow.visible = true;

			GlobalSharedObject.instance.modifyIsPurchased(5, true);

		}
	}
}