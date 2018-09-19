package  {
		
	import flash.display.Sprite;
	import flash.display.Shape;
	
	public class E_Dollar extends Sprite implements IPoolable, IGameObject {
		
		// variables
		private var _destroyed : Boolean;
		private var _xSpeed : Number;

		private var _ticks : int;
		private var _divBy : int;
		

		public var pVec:Vector.<IPoolable>;
		public var pRef:NewEmojiGameplay;
		
		public var points : int;
		public var _destroyableByRegularLaser : Boolean = true;
		
		public var _dropClass : Class;
		
		// Constructor
		public function E_Dollar() : void {
			
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
			
			points = -1;
			
			_dropClass = Dollar;
			
			///////////////////////////////////////////
			
			scaleX *= 1.2 + int( (Math.random()*.2) *10) /10;
			scaleY *= scaleX;
			
			if (Math.random() < .5) {
				x = -25;
				_xSpeed = 5;
			} else {
				x = 1359;
				_xSpeed = -5;
			}
			
			_xSpeed *= 1 + int( (Math.random()*2) *10) /10;
			
			y = (Math.random() * 50) + (width * .5);
			
			_ticks = 0;
			_divBy = 40 + (Math.random() * 40);
			
		}
		
		// Update object
		public function update() : void {
			
			_ticks ++;
			
			if (_ticks % _divBy == 0 && Math.abs(x-667) < 660 ) {
				
				var tempRef = ObjectPool.instance.getObj(_dropClass) as _dropClass;
				tempRef.setVector(pRef.items);
				tempRef.setParent(pRef);
				
				tempRef.x = x;
				tempRef.y = y;
				
				pRef.items.push(tempRef);
				pRef.addChild(tempRef);
				
			}
				
			x += _xSpeed;
			
			if (x > 1334 + (width * .5) || x < -width * .5) {
				pRef.removeChild(this);
				ObjectPool.instance.returnObj(this);
			}

		}
		
		// boss mode
		public function bossMode() : void {
			_dropClass = MoneyBag;
			_divBy /= 4;
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
			_ticks = null;
			_divBy = null;
			points = null;
			
			_dropClass = null;
			
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
