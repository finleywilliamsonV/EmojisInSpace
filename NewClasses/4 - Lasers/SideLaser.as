package  {
	
	import flash.display.Sprite;
	import flash.display.Shape;

	public class SideLaser extends Sprite implements IPoolable, IGameObject {
		
		// private variables
		private var _destroyed : Boolean;
		private var _xSpeed : Number;
		private var _ySpeed : Number;
		private var _buffer : Number;

		private var _stateCounter : int;
		private var _direction : int;
		
		private var pVec:Vector.<IPoolable>;
		private var pRef:NewEmojiGameplay;
		
		public var points : int;
		public var _destroysLasers : Boolean = false;
		
		private var _shapeA : Shape = new Shape();
		private var _shapeB : Shape = new Shape();
		
		public var _comboCount : int;
		
		
		public function SideLaser() {
			
			_destroyed = true;
			
			//_shapeA.graphics.beginFill(0x66FF99);
			_shapeA.graphics.beginFill(0xFFA57E);
			_shapeA.graphics.drawCircle(0, 0, 12);
			_shapeA.graphics.endFill();
		
			_shapeA.graphics.beginFill(0x000000);
			_shapeA.graphics.drawCircle(0, 0, 9);
			_shapeA.graphics.endFill();
			
			_shapeB.graphics.clear();
			//_shapeB.graphics.beginFill(0xBFC0FF);
			_shapeB.graphics.beginFill(0xFFC389);
			_shapeB.graphics.drawCircle(0, 0, 14);
			_shapeB.graphics.endFill();
			
			_shapeB.graphics.beginFill(0x000000);
			_shapeB.graphics.drawCircle(0, 0, 11);
			_shapeB.graphics.endFill();
			
			renew();
		}
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			_xSpeed = int( (12 - (Math.random() * 2)) *10)/10;
			_ySpeed = 0;
			_buffer = 15;
			
			_stateCounter = 0;
			points = 0;
			_comboCount = 0;
			
			addChild(_shapeA);
		}
		
		public function update(): void {
			
			_stateCounter++;
			
			if (_stateCounter % 3 == 0) {
				if (_stateCounter % 6 != 0) {
					
					removeChild(_shapeA);
					addChild(_shapeB);
					
				} else {
					
					removeChild(_shapeB);
					addChild(_shapeA);
				}
			}

			x -= (_xSpeed + _buffer) * _direction;
			y += _ySpeed;
			
			_buffer *= .75;
			
			if (x > 1334 + (width * .5) || x < -width * .5) {
				parent.removeChild(this);
				ObjectPool.instance.returnObj(this);
			}
		}
		

		
		public function setDirection(dir : int) : void {
			_direction = dir;
		}
		
		public function setTilt(tilt : int) : void {
			_ySpeed = tilt;
		}
		
		// set vector
		public function setVector(parentVector : Vector.<IPoolable>) : void {
			pVec = parentVector;
		}
		
		// set parent
		public function setParent(parRef:NewEmojiGameplay):void {
			pRef = parRef;
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
			_stateCounter = null;
			_xSpeed = null;
			_ySpeed = null;
			_buffer = null;
			_direction = null;
			points = null;
			_destroyed = true;
			
			_comboCount = null;
			
			removeChildren();
		}

		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}

	}
	
}
