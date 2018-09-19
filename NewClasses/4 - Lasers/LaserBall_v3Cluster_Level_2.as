package  {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.Shape;
	
	
	/*
	
		Shoots a regular LaserBall, then adds 2 LaserBall_v3
	
	*/
	
	
	public class LaserBall_v3Cluster_Level_2 extends Sprite implements IPoolable, IGameObject {
		
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
		
		public static var _shotRate : int = 10;
		
		
		// Constructor
		public function LaserBall_v3Cluster_Level_2() {
			
			_destroyed = true;
			
			_shapeA.graphics.beginFill(0x7BFFFF, 1);
			_shapeA.graphics.drawCircle(0,0, 20);
			_shapeA.graphics.endFill();
			
			_shapeA.graphics.beginFill(0x66FFCC, 1);
			_shapeA.graphics.drawCircle(0,0, 19);
			_shapeA.graphics.endFill();
			
			_shapeB.graphics.beginFill(0x7BFFFF, 1);
			_shapeB.graphics.drawCircle(0,0, 16);
			_shapeB.graphics.endFill();
			
			_shapeB.graphics.beginFill(0xFF99FF, 1);
			_shapeB.graphics.drawCircle(0,0, 15);
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
			
			_ySpeed =  12;
			_ySpeed *= 1.25;
			points = 0;
			
			_comboCount = 0;
		}
		
		
		// Update object
		public function update() : void {
			
			_stateCounter++;
			
			if (_stateCounter == 1) addExtraLasers();
			
			if (_stateCounter % 2 == 0) {
				if (_stateCounter % 4 != 0) {
					removeChild(_shapeA);
					addChild(_shapeB);
				} else {
					removeChild(_shapeB);
					addChild(_shapeA);
				}
			}
			
			y -= _ySpeed;
			
			if (_ySpeed < 50) _ySpeed *= 1.1;
			
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
			y = pRef.avatar.y - 40;
		}
		
		
		// add extra

		public function addExtraLasers() : void {
			
			var tempRef;
			var tempRandomSpeed : Number = 12 + int(Math.random() * 40)/10;
			tempRandomSpeed /= 2;
			
			var setX = x;
			var setY = y;
			
			for (var i : int = -2; i < 3; i ++) {
				
				tempRef = ObjectPool.instance.getObj(LaserBall_v3) as LaserBall_v3;
				
				tempRef.x = setX;
				tempRef.y = setY;
				
				tempRef.scaleX = 1.15;
				tempRef.scaleY = 1.15;
				
				if (i == -1 || i == 1) {
					tempRef.setSpeed(i * 2, tempRandomSpeed * 1.125);
					tempRef.scaleX = .75;
					tempRef.scaleY = .75;
				} else if (i == -2 || i == 2) {
					tempRef.setSpeed(i * 3, tempRandomSpeed);
					tempRef.scaleX = .5;
					tempRef.scaleY = .5;
				} 

				if (i != 0) {
					pRef.addGameObject(tempRef, pVec);
					pRef.setChildIndex(tempRef, 2);
				}
			}
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
			
			points = null;
			
			scaleX = 1;
			scaleY = 1;
			
			_comboCount = null;
			
			removeChildren();	// for shapes
		}

		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}

	}
	
}
