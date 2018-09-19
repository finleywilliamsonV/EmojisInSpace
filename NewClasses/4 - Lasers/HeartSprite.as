package  {
	
	import flash.display.Shape;
	import flash.display.Sprite;

	public class HeartSprite extends Sprite implements IPoolable, IGameObject {
		
		// variables
		private var _destroyed : Boolean;
		private var _xSpeed : Number;
		public var _ySpeed : Number;
		
		private var pVec:Vector.<IPoolable>;
		private var pRef:NewEmojiGameplay;
		
		public var points : int;
		public var _destroyableByRegularLaser : Boolean = false;
		public var _destroysLasers : Boolean = true;
		
		public var _LeftOrRight: int;	//-1 (L) or 1 (R);
		public var _comboCount : int;
		
		// Constructor
		public function HeartSprite() : void {
			
			_destroyed = true;
			
			renew();
		}
		
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			visible = true;
			
			_xSpeed = 4 + (int(Math.random() * 20)/10);
			_ySpeed = 3;
			
			points = 0;
		}
		
		public function update(): void {
			
			x -= _xSpeed * _LeftOrRight;
			y += _ySpeed;
			
			if (scaleX > -3 && scaleX < 3) {
				scaleX *= 1.05;
				scaleY *= 1.05;
			}
			
			
			_xSpeed *= 1.05;
			_ySpeed *= 1.01;
			_comboCount = 0;
			
			if (x > 1334 + (width * .5) || x < - width * .5) {
				parent.removeChild(this);
				ObjectPool.instance.returnObj(this);
			}
		}
	
		public function setLeftOrRight(tempInt : int) : void {
			_LeftOrRight = tempInt;
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
			
			visible = false;
			
			_destroyed = true;
			
			_xSpeed = null;
			_ySpeed = null;
			points = null;
			_LeftOrRight = null;
			
			_comboCount = null;
			
			scaleX = 1;
			scaleY = 1;
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}

	}
	
}
