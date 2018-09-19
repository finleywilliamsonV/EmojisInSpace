package  {
	
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
	public class LightningBoltVertical extends Sprite implements IPoolable, IGameObject {
		
		// variables
		private var _destroyed : Boolean;
		private var _ySpeed : Number;
		private var _myColorTransform : ColorTransform;
		private var _stateCounter: int;
		
		private var pVec:Vector.<IPoolable>;
		private var pRef:NewEmojiGameplay;
		
		public var points : int;
		public var _destroyableByRegularLaser : Boolean = false;
		
		
		// Constructor
		public function LightningBoltVertical() {
			
			_destroyed = true;
			
			_myColorTransform = new ColorTransform();
			
			graphics.beginFill(0x7495FF);
			
			graphics.moveTo(10.8, -22.85);
			graphics.lineTo(4.45, -3.1);
			graphics.lineTo(13.7, -3.1);
			graphics.lineTo(-11.3, 22.85);
			graphics.lineTo(-4.55, 3.1);
			graphics.lineTo(-13.7, 3.1);
			
			graphics.endFill();
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			_ySpeed = int( (10 - (Math.random() * 7)) *10)/10;
			
			_stateCounter = 1;
			points = 0;
		}
		
		
		// Update object
		public function update() : void {
			
			y -= _ySpeed;
			
			if (_stateCounter % 3 == 0) {
				if (_stateCounter % 6 != 0) {
					_myColorTransform.color = 0x596487;
					transform.colorTransform = _myColorTransform;
				} else {
					_myColorTransform.color = 0x7495FF;
					transform.colorTransform = _myColorTransform;
				}
			}
			
			_stateCounter++;
			
			if (y < -width/2) {
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
			_stateCounter = null;
			_ySpeed = null;
			
			_destroyed = true;
		}

		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}

	}
	
}
