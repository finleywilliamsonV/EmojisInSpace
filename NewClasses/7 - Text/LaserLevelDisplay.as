package  {

	import flash.display.Sprite;
	
	public class LaserLevelDisplay extends Sprite implements IPoolable {
		
		// class variables
		
		private var _destroyed : Boolean;
		public var _laserLevel : int;
		
		private var pRef:NewEmojiGameplay;
		
		
		
		// constructor
		
		public function LaserLevelDisplay() : void {
			
			_destroyed = true;
			
			shadow.stop();
			
			renew();
		}
		
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			_laserLevel = 1;
			
			x = 500;
			y = 722;
			
			setDisplay(_laserLevel);
		}
		
		
		public function setDisplay(laserLvl : int) : void {
			_laserLevel = laserLvl;
			shadow.gotoAndStop(_laserLevel);
		}
		
		// Update object
		public function update() : void {
			// ???
		}
		
		
		// set parent
		public function setParent(parRef:NewEmojiGameplay):void {
			pRef = parRef;
		}
		
		
		// Destroy object and return to ObjectPool
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			pRef = null;
			
			_destroyed = true;
			
			_laserLevel = null;
			
			shadow.gotoAndStop(1);
			
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
		
	}
	
}
