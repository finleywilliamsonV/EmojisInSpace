package  {
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	
	public class TutorialBanner extends MovieClip implements IPoolable, IGameObject {
		
		
		
		private var _destroyed : Boolean;
		
		private var pVec:Vector.<IPoolable>;
		private var pRef:NewEmojiGameplay;

		
		// Constructor
		public function TutorialBanner() {
			
			_destroyed = true;
			
			renew();
		}
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			gotoAndStop(1);
			
			_destroyed = false;

		}
		
		
		public function setText() : void {
			
			if (GlobalSharedObject.instance.isTouchMode == true) {
				gotoAndStop(2);
			} else {
				gotoAndStop(1);
			}
		}
		
		
		// Update object
		public function update() : void {
			
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
			
			_destroyed = true;

		}

		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}

	}
	
}
