package {

	import flash.display.Sprite;


	public class US_Button_B1 extends Sprite implements IUpgradeScreenButton {

		public var _isPurchased: Boolean;
		public var _isUnlocked: Boolean;
		public var _description: String = "Increases Size of Laser";
		public var _price: int = 1000;

		public function US_Button_B1() {
			reset();
		}
		
		public function reset() : void {
			_isPurchased = GlobalSharedObject.instance.isPurchased[3];
			_isUnlocked = GlobalSharedObject.instance.isUnlocked[3];
			
			if (_isUnlocked) visible = true;
			else visible = false;
		}


		// activate purchase
		public function purchase(refToUS : UpgradeScreen): void {
			GlobalSharedObject.instance.modifyGlobalScore(-_price);
			refToUS.pRef.MM.setGlobalScoreText();
			GlobalSharedObject.instance.modifyLaserScale(1.5);

			_isPurchased = true;
			GlobalSharedObject.instance.modifyIsPurchased(3, true);

			refToUS.b2._isUnlocked = true;
			refToUS.b2.visible = true;
			refToUS.b1.shadow.visible = true;

			GlobalSharedObject.instance.modifyIsUnlocked(4, true);
		}
	}

}