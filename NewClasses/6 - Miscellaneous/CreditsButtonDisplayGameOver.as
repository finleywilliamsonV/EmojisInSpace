package  {
	
	import flash.display.Sprite;
	
	
	public class CreditsButtonDisplayGameOver extends Sprite implements IPoolable {
		
		// variables
		private var _destroyed : Boolean;
		private var _ySpeed : Number;
		
		private var pVec:Vector.<IPoolable>;
		private var pRef:NewDocumentClass;
		
		public var points : int;
		
		
		// Constructor
		public function CreditsButtonDisplayGameOver() : void {
			
			_destroyed = true;
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			_ySpeed = 5;
			points = 0;
			
			x = 667;
			y = -height * .5;
		}
		
		public function update() : void {
			y += _ySpeed;
			
			if (y > 750 + (height/2)) {
				pRef.creditsToMM();
			}
		}
		
		// set vector
		public function setVector(parentVector : Vector.<IPoolable>) : void {
			pVec = parentVector;
		}
		
		// set parent
		public function setParent(parRef:NewDocumentClass):void {
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
			_ySpeed = null;
			points = null;
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
