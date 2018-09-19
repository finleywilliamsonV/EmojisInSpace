package  {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.Shape;
	
	
	/*
	
		adds 2 LaserBall_v3
	
	*/
	
	
	public class LaserBall_v2Cluster extends Sprite implements IPoolable, IGameObject {
		
		// variables
		private var _destroyed : Boolean;
		
		private var pVec:Vector.<IPoolable>;
		private var pRef:NewEmojiGameplay;
		
		public static var _shotRate : int = 6;
		
		
		// Constructor
		public function LaserBall_v2Cluster() {
			
			_destroyed = true;
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
		}
		
		
		// Update object
		public function update() : void {
			
			var tempRef;
			var tempRandomSpeed : Number = 8 + int(Math.random() * 40)/10;
			
			var setX = x;
			var setY = y;
			
			for (var i : int = -1; i < 2; i += 2) {
				
				tempRef = ObjectPool.instance.getObj(LaserBall_v3) as LaserBall_v3;
				
				tempRef.x = setX;
				tempRef.y = setY;
				tempRef.setSpeed(i * 4, tempRandomSpeed);

				pRef.addGameObject(tempRef, pRef.shots);
				
				pRef.setChildIndex(tempRef, 2);
			}
	
			parent.removeChild(this);
			ObjectPool.instance.returnObj(this);
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
			
			scaleX = 1;
			scaleY = 1;
		}

		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}

	}
	
}
