package  {
	
	import flash.display.Sprite;
	
	public class SmartBomb extends Sprite implements IPoolable {

		// private variables
		private var _destroyed : Boolean;
		private var _ySpeed : int;

		private var pVec:Vector.<IPoolable>;
		private var pRef:NewEmojiGameplay;
		
		public var points : int = 0;
		
		// Constructor
		public function SmartBomb() : void {
			
			_destroyed = true;
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			x = int(Math.random() * 1334);
			y = int(-1 * (height * .5));
			
			
			scaleX *= 1 - (int(Math.random() * 2) * 2);
			
			_ySpeed = 5 + (Math.random() * 2);
		}
		
		
		// Update object
		public function update() : void {
			
			y += _ySpeed;
			
			if (y > 750 + (height/2)) {
				pRef.removeChild(this);
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
		}
		
		
		// explode
		
		public function explode() : void {
			var tempRef = ObjectPool.instance.getObj(SmartBombLaser);
			tempRef.x = x;
			tempRef.y = y;
			pRef.addGameObject(tempRef, pRef.shots);
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
			
			graphics.clear();
			
			scaleX = 1;
			scaleY = 1;
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}

	}
	
}
