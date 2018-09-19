package  {
	
	import flash.display.MovieClip;
	
	
	public class BuyAllUpgradesButton extends MovieClip implements IPoolable {
		

		// class variables
		
		private var _destroyed : Boolean;
		
		public var pRef : NewDocumentClass;
		
		public var _isPurchased : Boolean;
		
		public var _buyScreen : BuyAllUpgradesScreen;
		
		// constructor
		public function BuyAllUpgradesButton() {
			
			_destroyed = true;
			
			renew();
			
			x = 1053;
			y = 45;
			
			scaleX = .6;
			scaleY = .6;
			
			gotoAndStop(1);
		}
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			checkPurchased();
		}
		
		// click
		
		public function click() : void {
			
		}
		
		// Update object
		public function update() : void {
			// ???
		}
		
		// set parent
		public function setParent(parRef:NewDocumentClass):void {
			pRef = parRef;
		}
		
		
		public function checkPurchased() : void {
			
			if (GlobalSharedObject.instance._devModePurchased) {
				gotoAndStop(2);
			} else {
				gotoAndStop(1);
			}
		}
		
		
		// Destroy object and return to ObjectPool
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			pRef = null;
			_destroyed = true;
			_isPurchased = null;
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
	}
}
