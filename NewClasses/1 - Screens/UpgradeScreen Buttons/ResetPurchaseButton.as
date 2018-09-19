package  {
	
	import flash.display.Sprite;
	
	
	public class ResetPurchaseButton extends Sprite {
		
		public function ResetPurchaseButton() {
			
		}
		
		// activate reset purchases
		public function click(refToUS : UpgradeScreen) : void {
			GlobalVariables.instance.currentPrimaryLaser = null;
			GlobalSharedObject.instance.resetPurchases();
			refToUS.pRef.MM.setGlobalScoreText();
			refToUS.resetIsPurchased();
			refToUS.updateNotifications(refToUS._storedUpgradeButton);
			refToUS.pRef.UStoMM();
		}
	}
}
