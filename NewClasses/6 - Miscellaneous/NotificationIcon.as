package  {
	
	import flash.display.Sprite;
	
	public class NotificationIcon extends Sprite implements IPoolable {
		
		
		
		// class variables
		
		private var _destroyed : Boolean;
		
		private var pRef:NewDocumentClass;
		
		
		
		// constructor
		
		public function NotificationIcon() : void {
			
			_destroyed = true;
			
			renew();
		}
		
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			visible = true;
			
			x = 65;
			y = -65;
		}
		
		// Update object
		public function update() : void {
			// ???
		}
		
		// set parent
		public function setParent(parRef:NewDocumentClass):void {
			pRef = parRef;
		}
		
		// Destroy object and return to ObjectPool
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			pRef = null;
			
			_destroyed = true;
			
			visible = false;
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
