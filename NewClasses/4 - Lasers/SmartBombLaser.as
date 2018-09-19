package  {
	
	import flash.display.Sprite;
	
	public class SmartBombLaser extends Sprite implements IPoolable, IGameObject {
		
		// private variables
		private var _destroyed : Boolean;
		private var _xSpeed : int;
		private var _ySpeed : int;

		private var pVec:Vector.<IPoolable>;
		private var pRef:NewEmojiGameplay;
		
		public var points : int = 0;
		public var _destroysLasers : Boolean = true;
		public var _comboCount : int;
		
		private var ramp : Number = 1;
		
		public static var _shotRate : int = 50;
		
		// Constructor
		public function SmartBombLaser() {
			
			_destroyed = true;
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			//graphics.clear();
			graphics.beginFill(0x66FFCC, 1);
			graphics.drawCircle(0,0, 100);
			graphics.endFill();
			
			graphics.beginFill(0x22BBCC, 1);
			graphics.drawCircle(0,0, 95);
			graphics.endFill();
			
			_ySpeed = 2 + (Math.random() * 5);
			_comboCount = 0;
		}
		
		
		// Update object
		public function update() : void {
		
			ramp *= 1.2;
			
			scaleX *= ramp;
			scaleY *= ramp;
			
			y = pRef.avatar.y;
			x = pRef.avatar.x;
			
			if (width > 2000) {

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
			
			scaleX = 1;
			scaleY = 1;
			
			ramp = 1;
			
			graphics.clear();
			
			_comboCount = null;
		}

		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}

	}
	
}
