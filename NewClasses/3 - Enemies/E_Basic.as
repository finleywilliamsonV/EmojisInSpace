package  {
	
	// Blue Squares Fall from Top
	
	import flash.display.Sprite;
	import flash.display.Shape;
	
	public class E_Basic extends Sprite implements IPoolable, IGameObject {
		
		// private variables
		private var _destroyed : Boolean;
		private var _xSpeed : Number;
		public var _ySpeed : Number;
		private var _lifetime: int;
		private var _rotSpeed : int;

		public var pVec:Vector.<IPoolable>;
		public var pRef:NewEmojiGameplay;
		
		public var points : int;
		public var _destroyableByRegularLaser : Boolean = true;
		
		private var mouth : Shape = new Shape();
		
		private var hWidth : int;
		
		// Constructor
		public function E_Basic() : void {
			
			_destroyed = true;
			
			// body
			graphics.beginFill(0xFFDD67);			
			graphics.drawCircle(0, 0, 25);
			graphics.endFill();
			
			//left eye
			graphics.beginFill(0x000000);
			graphics.drawCircle(-7.75, -2.5, 11);

			//right eye
			graphics.drawCircle(14, 2, 6);

			//mouth
			mouth.graphics.beginFill(0x000000);
			mouth.graphics.moveTo(-11,16);
			mouth.graphics.curveTo(0,4,11,16);
			mouth.graphics.curveTo(0,10,-11,16);
			mouth.scaleY = -1;
			mouth.y = 30;
			addChild(mouth);
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			points = 1;
			
			// condense 
			scaleX = 1.4 - (int( Math.random() * 6 )/10);		//changed from 65
			scaleY = scaleX;
			scaleX *= 1 - (int(Math.random() * 2) * 2);
			
			_ySpeed = int(70 - (Math.random()*45))/10;
			_xSpeed = 0;
			_rotSpeed = 10 - int(Math.random () * 20);
			
			x = int( Math.random() * ( 1334 - (width) ) ) + width/2;
			y = -width/2 - int(Math.random() * 20);
			
			rotation += int(Math.random() * 360) + 1;
			
			hWidth = width/2;
		}
		
		
		// Update object
		public function update() : void {
			
			y += _ySpeed;
			x += _xSpeed;
			rotation += _rotSpeed;
			
			if (y > 750 + hWidth || x < -hWidth || x > 1334 + hWidth) {
				pRef.removeChild(this);
				ObjectPool.instance.returnObj(this);
			}
		}
		
		// boss mode
		public function bossMode() : void {
			
			var tempRand : Number = Math.random();

			if (tempRand < .25) {
				_ySpeed *= 4;
			} else if (tempRand < .75) {
				_xSpeed = -3 + (int(Math.random() * 60)/10);
			} else {
				scaleX = .5;
				scaleY = .5;
				pRef.setChildIndex(this, pRef.getChildIndex(pRef.currentLevel.BK) - 1);
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
		
		
		// Destroy object
		public function destroy() : void {
			
			
			if (_destroyed) {
				return;
			}
			
			if (pVec) {

				var len : int = pVec.length - 1;
				var index : int = pVec.indexOf(this);
				
				pVec[index] = pVec[len];
				pVec.length = len;
				
				pVec = null;
			}
			
			pRef = null;
			
			_destroyed = true;
			_xSpeed = null;
			_ySpeed = null;
			_lifetime = null;
			_rotSpeed = null;
			points = null;
			
			scaleX = 1;
			scaleY = 1;
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
