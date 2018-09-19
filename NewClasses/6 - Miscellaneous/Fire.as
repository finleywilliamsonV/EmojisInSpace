package  {
	
	import flash.display.MovieClip;
	
	
	public class Fire extends MovieClip implements IPoolable, IGameObject {
		
		// variables
		private var _destroyed : Boolean;
		private var _ySpeed : Number;
		
		private var pVec:Vector.<IPoolable>;
		private var pRef:NewEmojiGameplay;
		
		public var points : int;
		public var _destroyableByRegularLaser : Boolean = false;
		
		
		// Constructor
		public function Fire() : void {
			
			_destroyed = true;
			
			stop();
			
			renew();
		}
		
		public function renew(): void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			visible = true;
			
			_ySpeed = -int( (3 + (Math.random() * 5)) *10)/10;
			
			points = 0;
		}
		
		
		public function update() : void {
			
			if (y > 750 + (height * .5)) {
				pRef.removeChild(this);
				ObjectPool.instance.returnObj(this);
				return;
			}
			
			y += _ySpeed;
			_ySpeed += .25;
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
			
			visible = false;
			
			gotoAndStop(1);
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
}