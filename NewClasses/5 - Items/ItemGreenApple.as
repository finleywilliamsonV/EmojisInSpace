package  {
	
	import flash.display.Sprite;
	
	
	public class ItemGreenApple extends Sprite implements IPoolable {
		
		// variables
		private var _destroyed : Boolean;
		private var _ySpeed : Number;
		
		private var pVec:Vector.<IPoolable>;
		private var pRef:NewEmojiGameplay;
		
		public var points : int;
		
		
		// Constructor
		public function ItemGreenApple() : void {
			
			_destroyed = true;
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			_ySpeed = 10 - int(Math.random() * 50)/10;
			points = 10;
			
			x = (Math.random() * (1334 - width)) + (width * .5);
			y = -height * .5;
		}
		
		public function update() : void {
			y += _ySpeed;
			
			if (y > 1334 + (width/2)) {
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
			points = null;
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
