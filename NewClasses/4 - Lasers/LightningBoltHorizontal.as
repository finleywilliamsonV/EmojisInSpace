package  {
	
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
	public class LightningBoltHorizontal extends Sprite implements IPoolable, IGameObject {
		
		// variables
		private var _destroyed : Boolean;
		private var _xSpeed : Number;
		private var _myColorTransform : ColorTransform;
		private var _stateCounter: int;
		private var _direction : int;
		
		private var pVec:Vector.<IPoolable>;
		private var pRef:NewEmojiGameplay;
		
		public var points : int;
		public var _destroyableByRegularLaser : Boolean;
		
		
		// Constructor
		public function LightningBoltHorizontal() {
			
			_destroyed = true;
			
			_myColorTransform = new ColorTransform();
			
			graphics.beginFill(0xFF5263);
			
			graphics.moveTo(11, -23);
			graphics.lineTo(5, -3);
			graphics.lineTo(13, -3);
			graphics.lineTo(-11, 23);
			graphics.lineTo(-5, 3);
			graphics.lineTo(-14, 3);
			
			graphics.endFill();
			
			rotation = 90;
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			_destroyableByRegularLaser = false;
			
			_xSpeed = int( (14 - (Math.random() * 7)) *10)/10;
			
			_stateCounter = 1;
			points = 0;
		}
		
		
		// Update object
		public function update() : void {
			
			x -= _xSpeed * _direction;
			
			if (_stateCounter % 3 == 0) {
				if (_stateCounter % 6 != 0) {
					_myColorTransform.color = 0xA63540;
					transform.colorTransform = _myColorTransform;
				} else {
					_myColorTransform.color = 0xFF5263;
					transform.colorTransform = _myColorTransform;
				}
			}
			
			_stateCounter++;
			
			if (x > 1334 + (width * .5) || x < -width * .5) {
				parent.removeChild(this);
				ObjectPool.instance.returnObj(this);
			}
		}
		
		public function setDirection(dir : int) : void {
			_direction = dir;
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
			_xSpeed = null;
			_direction = null;
			points = null;
			_destroyableByRegularLaser = null;
			
			_destroyed = true;
			
		}

		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}

	}
	
}
