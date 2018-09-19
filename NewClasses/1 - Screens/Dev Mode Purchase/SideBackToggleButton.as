package  {
	
	import flash.display.MovieClip;
	
	
	public class SideBackToggleButton extends MovieClip implements IPoolable {
		

		// class variables
		
		private var _destroyed : Boolean;
		
		public var pRef : NewDocumentClass;
		
		public var _isOn : Boolean;
		
		
		// constructor
		public function SideBackToggleButton() {
			
			_destroyed = true;
			
			stop();
			
			renew();
			
			x = 414;
			y = 98;
			
			scaleX = 1.3;
			scaleY = 1.3;
		}
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			_isOn = GlobalSharedObject.instance._infAmmoSelected;
			
			if (_isOn) {
				gotoAndStop(1);
			} else {
				gotoAndStop(2);
			}
		}
		
		// click
		
		public function click() : void {
			
			if (_isOn) {

				// turn off
				_isOn = false;
				gotoAndStop(2);
				
			} else {
				
				// turn on
				_isOn = true;
				gotoAndStop(1);
			}
		}
		
		// Update object
		public function update() : void {
			// ???
		}
		
		// set parent
		public function setParent(parRef:NewDocumentClass):void {
			pRef = parRef;
		}
		
		
		public function recordPosition() : void {
			GlobalSharedObject.instance._infAmmoSelected = _isOn;
		}
		
		
		// Destroy object and return to ObjectPool
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			pRef = null;
			gotoAndStop(1);
			_destroyed = true;
			
			recordPosition();
			_isOn = null;
			
			
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
	}
}
