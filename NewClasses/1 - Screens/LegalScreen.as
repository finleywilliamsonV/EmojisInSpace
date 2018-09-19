package {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.display.BitmapData;
	import flash.display.MovieClip;


	public class LegalScreen extends MovieClip implements IPoolable {

		private var _destroyed : Boolean;
		
		private var pRef : NewDocumentClass;
		
		
		// constructor
		public function LegalScreen(): void {
			
			_destroyed = true;
			
			renew();
			
			gotoAndStop(1);
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
			
			x = 667;
			y = 375;
		}
		
		
		// empty update
		public function update(): void {
			// n/a
		}
		
		
		// on click
		public function onClick( mE : MouseEvent ) : void {
			
			mE.stopPropagation();
			
			if (currentFrame < 3) {
				
				gotoAndStop(currentFrame + 1);
				
			} else {
				
				removeEventListener(MouseEvent.CLICK, onClick);
			
				pRef.LegalScreenToMM();
			}
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
			
			_destroyed = true;
			
			gotoAndStop(1);
			
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}

}