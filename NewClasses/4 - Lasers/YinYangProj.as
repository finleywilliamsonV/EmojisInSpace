package {
	
	import flash.display.Sprite;
	
	public class YinYangProj extends Sprite implements IPoolable {

		// variables
		private var _destroyed : Boolean;
		private var _ySpeed: Number;
		private var _rotSpeed : Number;
		
		private var pVec:Vector.<IPoolable>;
		private var pRef:NewEmojiGameplay;
		
		public var _destroysLasers : Boolean = true;
		
		public var _comboCount : int;
		
		public static var _shotRate : int = 20;
		
		
		public function YinYangProj(): void {
			
			_destroyed = true;
			
			renew();
		}
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			_ySpeed = 5;
			_rotSpeed = 1;
			
			scaleX = .3;
			scaleY = .3;
			_comboCount = 0;
		}
		
		
		public function update(): void {
			y -= _ySpeed;
			rotation += _rotSpeed;
			
			if (_ySpeed < 25) _ySpeed *= 1.1;
			
			if (scaleX < 3.5) {
				scaleX += .1;
				scaleY += .1;
			}
			
			if (_rotSpeed < 50) _rotSpeed *= 1.35;
			
			if (y < - (width/2)) {
				parent.removeChild(this);
				ObjectPool.instance.returnObj(this);
			}
		}
		
		// set vector
		public function setVector(parentVector : Vector.<IPoolable>) : void {
			pVec = parentVector;
		}
		
		// set parent
		public function setParent(parRef:NewEmojiGameplay):void {
			pRef = parRef;
			
			x = pRef.avatar.x;
			y = pRef.avatar.y;
		}
		
		
		// combo
		
		public function comboUp() : void {
			_comboCount ++;
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
			
			_ySpeed = null;
			_rotSpeed = null;
			
			scaleX = 1;
			scaleY = 1;
			
			_comboCount = null;
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
	}
}