package  {
	
	
	import flash.display.Sprite;
	
	public class E_Baddie extends Sprite implements IPoolable, IGameObject {
		
		private var _destroyed : Boolean;
		
		public var pVec:Vector.<IPoolable>;
		public var pRef:NewEmojiGameplay;
		
		public var points : int;
		
		private var tempCount : int;
		private var xSpeed: Number;
		private var divBy : int;
		
		public var _destroyableByRegularLaser : Boolean = true;
		
		public var _dropClass : Class;
		
		public function E_Baddie() : void {
			
			_destroyed = true;
			
			renew();
		}
		
		public function renew(): void {
			if (!_destroyed) {
				return;
			}
			
			visible = true;
			
			points = 10;
			
			_destroyed = false;
			
			_dropClass = Fire;
			
			scaleX = int((1.1 - (Math.random() * .3))*10)/10;
			scaleY = scaleX;
			
			if (Math.random() < .5) {
				x = -width/2;
				xSpeed = 3 + int((Math.random() * 6)*10)/10;
			} else {
				x = 1334 + (width/2);
				xSpeed = -3 - int((Math.random() * 6)*10)/10;
			}
			
			y = (Math.random() * 150) + 50;
			
			tempCount = 1;
		
			divBy = 66 + (Math.random() * 66);
		}
		

		public function update() : void {

			if (x > 1334 + (width * .5) || x < -width * .5) {
				pRef.removeChild(this);
				ObjectPool.instance.returnObj(this);
				return;
			}
			
			if (tempCount % divBy == 0) {
				var tempRef = ObjectPool.instance.getObj(_dropClass) as _dropClass;
				tempRef.setVector(pVec);
				tempRef.setParent(pRef);
				
				tempRef.x = x;
				tempRef.y = y;
				
				tempRef.play();
				
				pVec.push(tempRef);
				pRef.addChild(tempRef);
			}
			
			x += xSpeed;
			
			tempCount++;
		}
		
		// boss mode
		public function bossMode() : void {
			_dropClass = BossFire;
			divBy /= 1.5;
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
			
			points = null;
			xSpeed = null;
			divBy = null;
			tempCount = null;
			
			visible = false;
			
			scaleX = 1;
			scaleY = 1;
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
}