package  {
	
	import flash.display.MovieClip;
	
	
	public class ComboDisplay extends MovieClip implements IPoolable {
		
		// variables
		private var _destroyed : Boolean;
		
		public var pRef:HowToPlayScreen;
		
		//(224, 66.7)
		
		
		// Constructor
		public function ComboDisplay() : void {
			
			_destroyed = true;
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			stop();
			
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
