package  {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.Shape;
	
	public class LaserBall_v3 extends Sprite implements IPoolable, IGameObject {
		
		// variables
		private var _destroyed : Boolean;
		private var _ySpeed : Number;
		private var _xSpeed :Number;

		private var _stateCounter : int;
		
		private var pVec:Vector.<IPoolable>;
		private var pRef:NewEmojiGameplay;
		
		public var points : int;
		public var _destroysLasers : Boolean = false;
		
		private var _shapeA : Shape = new Shape();
		private var _shapeB : Shape = new Shape();
		
		public var _comboCount : int;
		
		
		// Constructor
		public function LaserBall_v3() {
			
			_destroyed = true;
			
			_shapeA.graphics.beginFill(0x7BFFFF, 1);
			_shapeA.graphics.drawCircle(0,0, 25);
			_shapeA.graphics.endFill();
			
			_shapeA.graphics.beginFill(0x66FFCC, 1);
			_shapeA.graphics.drawCircle(0,0, 24);
			_shapeA.graphics.endFill();
			
			_shapeB.graphics.beginFill(0x7BFFFF, 1);
			_shapeB.graphics.drawCircle(0,0, 20);
			_shapeB.graphics.endFill();
			
			_shapeB.graphics.beginFill(0x0099FF, 1);
			_shapeB.graphics.drawCircle(0,0, 19);
			_shapeB.graphics.endFill();
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			_stateCounter = 0;
			
			addChild(_shapeA);
			
			_ySpeed = 0;
			_xSpeed = 0;
			points = 0;
			_comboCount = 0;
		}
		
		
		// Update object
		public function update() : void {
			
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
			
			y -= _ySpeed;
			x += _xSpeed;
			
			_ySpeed += .5;
			
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
		}
		
		
		public function setSpeed( newXSpeed : int, newYSpeed : int ) : void {
			_xSpeed = newXSpeed;
			_ySpeed = newYSpeed;
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
			
			_stateCounter = null;
			
			_ySpeed = null;
			_xSpeed = null;
			
			_comboCount = null;
			
			points = null;
			
			scaleX = 1;
			scaleY = 1;
			
			removeChildren();
		}

		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}

	}
	
}
