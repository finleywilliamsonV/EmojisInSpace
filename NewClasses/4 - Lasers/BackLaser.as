package {
	
	import flash.display.Sprite;	
	
	public class BackLaser extends Sprite implements IPoolable, IGameObject {

		// private variables
		private var _destroyed : Boolean;

		private var _stateCounter : int;
		private var _buffer : int;
		
		private var pVec:Vector.<IPoolable>;
		private var pRef:NewEmojiGameplay;
		
		public var points : int;
		public var _destroysLasers : Boolean = true;
		
		public var _comboCount : int;
		
		
		public function BackLaser(): void {
			_destroyed = true;
			
			renew();
		}
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			_stateCounter = 0;
			points = 0;
			_buffer = 30;
			_comboCount = 0;
		}
		
		public function update(): void {
			_stateCounter ++
			//if (_stateCounter % 2 == 0) {
				y += 1 + _buffer;
				_buffer /= 1.1; 
				if (_buffer < 1) {
					parent.removeChild(this);
					ObjectPool.instance.returnObj(this);
				}
			//}
		}
		
		// set vector
		public function setVector(parentVector : Vector.<IPoolable>) : void {
			pVec = parentVector;
		}
		
		// set parent
		public function setParent(parRef:NewEmojiGameplay):void {
			pRef = parRef;
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
			_buffer = null;
			
			points = null;
			
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