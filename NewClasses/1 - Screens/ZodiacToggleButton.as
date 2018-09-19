package  {
	
	import flash.display.MovieClip;
	
	
	public class ZodiacToggleButton extends MovieClip implements IPoolable {
		

		// class variables
		
		private var _destroyed : Boolean;
		
		public var pRef : NewDocumentClass;
		
		public var _isOn : Boolean;
		
		
		// constructor
		public function ZodiacToggleButton() {
			
			_destroyed = true;
			
			stop();
			
			renew();
			
			x = 1267;
			y = 200;
			
			scaleX = .9;
			scaleY = .9;
		}
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			_isOn = GlobalSharedObject.instance._yinYangSelected;
			
			if (_isOn) {
				gotoAndStop(1);
			} else {
				gotoAndStop(2);
			}
		}
		
		// click
		
		public function click() : void {
			
			if (_isOn) {

				// turn off yin yang
				_isOn = false;
				gotoAndStop(2);
				GlobalVariables.instance.currentPrimaryLaser = null;
				recordPosition();
				
			} else {
				
				// turn on yin yang
				_isOn = true;
				gotoAndStop(1);
				recordPosition();
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
			GlobalSharedObject.instance._yinYangSelected = _isOn;
			//trace("in Zod togg;e: " + _isOn);
		}
		
		
		public function checkVisible() : void {
			if (GlobalSharedObject.instance._allZodiacsCollected) {
				visible = true;
			} else {
				visible = false;
			}
		}
		
		
		// Destroy object and return to ObjectPool
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			pRef = null;
			gotoAndStop(1);
			_destroyed = true;
			_isOn = null;
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
	}
}
