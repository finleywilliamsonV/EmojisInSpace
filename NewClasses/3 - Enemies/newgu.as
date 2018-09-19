package  {
		
	import flash.display.Sprite;
	import flash.display.Shape;
	
	public class E_GustLady extends Sprite implements IPoolable, IGameObject {
		
		// variables
		private var _destroyed : Boolean;
		private var _ySpeed : Number;
		private var _direction : int;

		private var _ticks : int;

		public var pVec:Vector.<IPoolable>;
		public var pRef:NewEmojiGameplay;
		
		public var points : int;
		public var _destroyableByRegularLaser : Boolean = true;
		
		// Constructor
		public function E_GustLady() : void {
			
			_destroyed = true;
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			visible = true;
			
			_destroyed = false;
			
			points = 6;
			
			///////////////////////////////////////////
			
			_ySpeed *= 1 + int( (Math.random()*2) *10) /10;
			
			y = (Math.random() * 670) + 40;
			
			_ticks = 0;
			int( (6 + (Math.random() * 6)) *10)/10
			setDirection();
			
		}
		
		
		// Update object
		public function update() : void {
			
			
			if (_ticks < 40) {
				
				x -= _direction;
				
				
			} else if (_ticks == 40) {
				
				//parentRef.dropEnemy(new Gust(x - (direction * 20), y, direction));
				
				var tempRef = ObjectPool.instance.getObj(Gust) as Gust;
				tempRef.setVector(pVec);
				tempRef.setParent(pRef);
				
				tempRef.x = x - (_direction * 20);
				tempRef.y = y;
				
				tempRef.setDirectionAndSpeed(_direction, _gustSpeed);
				
				pVec.push(tempRef);
				pRef.addChild(tempRef);
				
				tempRef.play();
				
				
			} else if (_ticks > 90) {
				
				pRef.removeChild(this);
				ObjectPool.instance.returnObj(this);
				
				
			} else if (_ticks > 70) {
				
				x += _direction;
			}
			
			_ticks ++;
		}
		
		public function setDirection() : void {
			_direction = 1 - (int(Math.random() * 2)*2);
			
			if (_direction < 0) {
				x = -20
			} else {
				scaleX *= -1;
				x = 1354;
			}
		}
		
		// boss mode
		public function bossMode() : void {
			
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
			_ySpeed= null;
			_ticks = null;
			_direction = null;
			points = null;
			
			visible = false;
			
			scaleX = 1;
			scaleY = 1;
			
			//height = 45;
			//width = 45;
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
}
