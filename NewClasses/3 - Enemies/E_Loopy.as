package  {
		
	import flash.display.Sprite;
	import flash.display.Shape;
	
	public class E_Loopy extends Sprite implements IPoolable, IGameObject {
		
		// private variables
		private var _destroyed : Boolean;
		private var _xSpeed : int;
		private var _ySpeed : int;
		private var _rotSpeed : int;

		public var pVec:Vector.<IPoolable>;
		public var pRef:NewEmojiGameplay;
		
		public var points : int;
		public var _destroyableByRegularLaser : Boolean = true;
		
		private var _body : Shape;
		
		// Constructor
		public function E_Loopy() : void {
			
			_destroyed = true;
			
			//Body Color
			_body = new Shape();
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			visible = true;
			
			_destroyed = false;
			
			points = 7;
			
			_body.graphics.beginFill(0xD5C4FF);
			_body.graphics.drawCircle(0, 0, 22.5);
			_body.graphics.endFill();
			_body.x = -33.5;
			_body.y = -20.5;
			addChild(_body);
			setChildIndex(_body,0);
			
			///////////////////////////////////////////
			
			
			scaleX *= int((1.2 - (Math.random() * .4))*10)/10;
			scaleY *= scaleX;
			
			
			_rotSpeed = (Math.random() * 3) + 3;
			
			if (Math.random() < .5) {
				_rotSpeed *= -1;
				scaleX *= -1;
			}
		
			_xSpeed = int((2 + (Math.random()*1.3))*10)/10;
			_ySpeed = int((_xSpeed * (1.2 - Math.random() * .4))*10)/10;
			
			if (Math.random() <.2) {
				_rotSpeed = 4 - (int(Math.random() * 2) * 8);
				scaleX *= 1.5;
				scaleY *= 1.5;
				//_xSpeed /= 1.5;
				//_ySpeed /= 1.5;
			}
			
			if (Math.random() <.25) {
				_xSpeed *= 2;
			}
			
			if (Math.random() <.25) {
				_ySpeed *= 2;
			}
			
			
						
			var choice:int = Math.random() * 4;			
			
			if (choice == 0) {						//upper left
				x = -40;
				y = -67 + (Math.random() * 100);
				
			} else if (choice == 1) {				//lower left
				x = -67;
				y = 817 - (Math.random() * 100);
				_ySpeed *= -1;
			
			} else if (choice == 2) {				//upper right
				x = 1334 + width;
				y = -67 + (Math.random() * 100);
				_xSpeed *= -1;
				
			} else {								//lower right
				x = 1334 + width;
				y = 817 - (Math.random() * 100);
				_xSpeed *= -1;
				_ySpeed *= -1;
			}
		}
		
		// Update object
		public function update() : void {
			
			x += _xSpeed;
			y += _ySpeed;
			rotation += _rotSpeed;
			
			
			if (y > 917 || y < -167 || x > 1400 || x < -167) {
				pRef.removeChild(this);
				ObjectPool.instance.returnObj(this);
			}

		}
		
		// boss mode
		public function bossMode() : void {
			
			if (Math.random() < .25) {
				_rotSpeed *= 3;
				_xSpeed *= .5;
			}
			
			_body.scaleX = .75 + (int(Math.random() * 10) / 10);
			_body.scaleY = .75 + (int(Math.random() * 10) / 10);
			
			if (Math.random() < .5) pRef.setChildIndex(this, pRef.getChildIndex(pRef.currentLevel.BK) - 1);
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
			_rotSpeed = null;
			points = null;
			
			visible = false;
			
			scaleX = 1;
			scaleY = 1;
			
			_body.scaleX = 1;
			_body.scaleY = 1;
			_body.graphics.clear();

		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
}
