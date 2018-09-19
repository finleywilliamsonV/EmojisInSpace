package  {
	
	import flash.display.MovieClip;
	
	
	public class PhoneWithDirections extends MovieClip implements IPoolable {
		
		// variables
		private var _destroyed : Boolean;
		
		public var pRef:HowToPlayScreen;
		
		//(367, 5)
		
		
		// Constructor
		public function PhoneWithDirections() : void {
			
			_destroyed = true;
			
			renew();
			
			stop();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
		}
		
		public function update() : void {
		}
		
		// set parent
		public function setParent(parRef:HowToPlayScreen):void {
			pRef = parRef;
		}
		
		
		// Destroy object and return to ObjectPool
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			_destroyed = true;
			pRef = null;
			
			stop();
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
