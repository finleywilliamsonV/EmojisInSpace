package  {
	
	import flash.display.Sprite;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	public class ChooseGameModeScreen extends Sprite implements IPoolable {
		
		
		// class variables
		
		private var _destroyed : Boolean;
		
		public var pRef:NewDocumentClass;
		
		
		// constructor
		public function ChooseGameModeScreen() {
			
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
		
		
		// onClick Function
		public function onClick(mE : MouseEvent) : void {
			
			mE.stopPropagation();
			
			if (mE.target is ChooseGameMode_Classic) {
				
				stage.removeEventListener(MouseEvent.CLICK, onClick);
				
				// set mode to tilt
				GlobalSharedObject.instance.isTouchMode = false;
				GlobalSharedObject.instance.isGameModeChosen = true;
				pRef.CGMtoEG();
				
			} else if (mE.target is ChooseGameMode_Touch) {
				
				stage.removeEventListener(MouseEvent.CLICK, onClick);
				
				// set mode to touch
				GlobalSharedObject.instance.isTouchMode = true;
				GlobalSharedObject.instance.isGameModeChosen = true;
				pRef.CGMtoEG();
			}
			
		}
		
		// Update object
		public function update() : void {
			// ???
		}
		
		
		public function setup() : void {
			stage.addEventListener(MouseEvent.CLICK, onClick);
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
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
	}
}
