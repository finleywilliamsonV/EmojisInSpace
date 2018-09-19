package  {
	
	import flash.display.MovieClip;
	
	public class BossGust extends MovieClip implements IPoolable, IGameObject {
		
		// variables
		private var _destroyed : Boolean;
		private var _xSpeed : Number;
		
		public var _direction: int;
		
		private var pVec:Vector.<IPoolable>;
		private var pRef:NewEmojiGameplay;
		
		public var points : int;
		public var _destroyableByRegularLaser : Boolean = false;
		
		
		// Constructor
		public function BossGust() {
			
			_destroyed = true;
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			_xSpeed = int( (10 + (Math.random() * 6)) *10)/10;
			
			points = 0;
			
			gotoAndStop(1);
		}
		
		
		// Update object
		public function update() : void {
			
			x -= _xSpeed;
			
			//_xSpeed += .1;
			
			if (x > 1334 + (width * .5) || x < -width * .5) {
				parent.removeChild(this);
				ObjectPool.instance.returnObj(this);
			}
		}
		
		// set direction
		public function setDirection( dir : int ) : void {
			
			_direction = dir;
			
			_xSpeed *= _direction;
			
			if (_direction > 0) {
				scaleX *= -1;
			}
				
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
			
			scaleX = 1;
			scaleY = 1;
			
			_destroyed = true;
			_xSpeed = null;
			_direction = null;
			
			gotoAndStop(1);
		}

		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}

	}
	
}
