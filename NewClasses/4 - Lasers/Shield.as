package  {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.Shape;
	
	
	public class Shield extends Sprite implements IPoolable, IGameObject {
		
		
		// variables
		private var _destroyed : Boolean;
		
		private var pVec:Vector.<IPoolable>;
		private var pRef:NewEmojiGameplay;
		
		public var points : int;
		public var _destroysLasers : Boolean = true;

		public var _comboCount : int;
		
		
		// Constructor
		public function Shield() {
			
			_destroyed = true;
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;

			points = 0;
			
			_comboCount = 0;
		}
		
		
		// Update object
		public function update() : void {
			
			x = pRef.avatar.x;
			y = pRef.avatar.y;
		}
		
		
		// set vector
		public function setVector(parentVector : Vector.<IPoolable>) : void {
			pVec = parentVector;
		}
		
		// set parent
		public function setParent(parRef:NewEmojiGameplay):void {
			pRef = parRef;
			
			x = pRef.avatar.x;
			y = pRef.avatar.y;
			
			pRef.avatar._isShielded = true;
		}
		
		
		// combo
		public function comboUp() : void {
			return;
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
			
			pRef.avatar._isShielded = false;
			
			pRef = null;
			
			_destroyed = true;
			
			points = null;
			
			_comboCount = null;
		}

		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}

	}
	
}
