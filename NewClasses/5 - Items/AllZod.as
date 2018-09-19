package  {
	
	import flash.display.MovieClip;
	
	
	public class AllZod extends MovieClip implements IPoolable {
		
		// variables
		private var _destroyed : Boolean;
		public var _currentZodShowing : int;
		private var _iterator : int;
		private var _ySpeed : int;
		private var _rotationMod : int;
		
		private var pVec:Vector.<IPoolable>;
		private var pRef:NewEmojiGameplay;
		
		public var points : int;
		
		
		// Constructor
		public function AllZod() : void {
			
			_destroyed = true;
			
			stop();
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			_iterator = 0;
			_ySpeed = 3 + int(Math.random() * 30)/10;
			_rotationMod = 1 - (int(Math.random() * 2) * 2);
			points = 0;
			
			x = int(Math.random() * 1184) + 75;
			y = -75;
		}
		
		
		public function update() : void {
			
			_iterator ++;
			
			y += _ySpeed;
			
			if (_iterator % 12 == 0) {
				if (_iterator % 24 != 0) {
					gotoAndStop(_currentZodShowing * 2);
				} else {
					gotoAndStop(-1 + (_currentZodShowing * 2));
				}
			}
			
			rotation += _rotationMod;
		}
		
		
		// set which zod is showing
		public function setWhich(thisZod : int) : void {
			_currentZodShowing = thisZod;
			gotoAndStop(-1 + (_currentZodShowing * 2));
			points = _currentZodShowing * 100;
		}
		
		
		public function returnPosition() : int {
			return _currentZodShowing - 1;
		}
		
		
		// set vector
		public function setVector(parentVector : Vector.<IPoolable>) : void {
			pVec = parentVector;
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
			
			if (pVec) {
				
				var len : int = pVec.length - 1;
				pVec[pVec.indexOf(this)] = pVec[len];
				pVec.length = len;
				
				pVec = null;
			}
			
			pRef = null;
			
			_destroyed = true;
			_currentZodShowing = null;
			_iterator = null;
			_ySpeed = null;
			_rotationMod = null;
			points = null;
			
			gotoAndStop(1);
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
