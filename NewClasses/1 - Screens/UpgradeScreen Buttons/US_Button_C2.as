package {

	import flash.display.Sprite;


	public class US_Button_C2 extends Sprite implements IUpgradeScreenButton {

		public var _isPurchased: Boolean;
		public var _isUnlocked: Boolean;
		public var _description: String = "Unlocks Back-Laser Drops";
		public var _price: int = 12500;

		public function US_Button_C2() {
			reset();
		}
		
		public function reset() : void {
			_isPurchased = GlobalSharedObject.instance.isPurchased[7];
			_isUnlocked = GlobalSharedObject.instance.isUnlocked[7];
			
			if (_isUnlocked) visible = true;
			else visible = false;
		}

		// activate purchase
		public function purchase(refToUS : UpgradeScreen): void {

			GlobalSharedObject.instance.modifyGlobalScore(-_price);
			refToUS.pRef.MM.setGlobalScoreText();

			_isPurchased = true;
			GlobalSharedObject.instance.modifyIsPurchased(7, true);

			refToUS.c3._isUnlocked = true;
			refToUS.c3.visible = true;
			refToUS.c2.shadow.visible = true;

			GlobalSharedObject.instance.modifyIsUnlocked(8, true);

		}
	}

}