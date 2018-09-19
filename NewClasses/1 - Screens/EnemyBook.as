package  {
	
	import flash.display.MovieClip;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	public class EnemyBook extends MovieClip implements IPoolable {
		
		
		// class variables
		
		private var _destroyed : Boolean;
		
		public var pRef:NewDocumentClass;
		
		
		// constructor
		public function EnemyBook() {
			
			_destroyed = true;
			
			stop();
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
		}
		
		
		// onClick Function
		public function onClick(mE : MouseEvent) : void {
			
			mE.stopPropagation();
			
			if (mE.target is BackButton) gotoAndStop(currentFrame - 1);
			else if (mE.target is ForwardButton) gotoAndStop(currentFrame + 1);
			else if (mE.target is ExitButton) pRef.EBtoMM();
		}
		
		// Update object
		public function update() : void {
			// ???
		}
		
		
		public function setup() : void {
			stage.addEventListener(MouseEvent.CLICK, onClick);
			gotoAndStop(1);
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
			
			pRef = null;
			gotoAndStop(1);
			_destroyed = true;
			
			stage.removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
	}
}
