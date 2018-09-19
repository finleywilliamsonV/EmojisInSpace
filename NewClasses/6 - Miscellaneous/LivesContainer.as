package  {
	
	import flash.display.Sprite;
	
	public class LivesContainer extends Sprite implements IPoolable {
		
		private var _destroyed : Boolean;
		private var iterator : int;
		
		public function LivesContainer() : void {
			
			_destroyed = true;
			visible = true;
			renew();
		}
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			visible = true;
		
			iterator = 0;
			
			x = 165;
			y = 30;
		}
		
		public function subHeart() : void {
			
			if (iterator == 9) {
				h9.visible = false;
			}
			
			else if (iterator == 8) {
				h8.visible = false;
			}
			
			else if (iterator == 7) {
				h7.visible = false;
			}
			
			else if (iterator == 6) {
				h6.visible = false;
			}
			
			else if (iterator == 5) {
				h5.visible = false;
			}
			
			else if (iterator == 4) {
				h4.visible = false;
			}
			
			else if (iterator == 3) {
				h3.visible = false;
			}
			
			else if (iterator == 2) {
				h2.visible = false;
			}
			
			else if (iterator == 1) {
				h1.visible = false;
			}
			
			iterator --;
		}
		
		public function addHeart() {

			iterator ++;
			
			if (iterator == 9) {
				h9.visible = true;
			}
			
			else if (iterator == 8) {
				h8.visible = true;
			}
			
			else if (iterator == 7) {
				h7.visible = true;
			}
			
			else if (iterator == 6) {
				h6.visible = true;
			}
			
			else if (iterator == 5) {
				h5.visible = true;
			}
			
			else if (iterator == 4) {
				h4.visible = true;
			}
			
			else if (iterator == 3) {
				h3.visible = true;
			}
			
			else if (iterator == 2) {
				h2.visible = true;
			}
			
			else if (iterator == 1) {
				h1.visible = true;
			}
		}
		
		
		// setup
		
		public function setup() : void {
			
			for ( var i : int = 0; i < GlobalSharedObject.instance.maxLives; i ++) {
				addHeart();
			}
			
		}
		
		
		// Update object
		public function update() : void {
			// ???
		}
		
		
		// Destroy object and return to ObjectPool
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			_destroyed = true;
			
			// set all children to visible
			for (var i : int = numChildren - 1; i >= 0; i--) {
				getChildAt(i).visible = false;
			}
			
			visible = false;
			
			iterator = null;
			
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
	}
	
}
