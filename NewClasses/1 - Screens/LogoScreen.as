package  {
	
	import flash.display.Sprite;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	public class LogoScreen extends Sprite implements IPoolable {
		
		
		
		// class variables
		
		private var _destroyed : Boolean;
		
		private var pRef:NewDocumentClass;
		
		private var counter : int;
		
		
		
		// constructor
		
		public function LogoScreen() : void {
			
			_destroyed = true;
			
			renew();
		}
		
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			visible = true;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function onEnterFrame(e : Event) : void {
			
			e.stopPropagation();

			counter++;
			
			if (counter > 40) {
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				pRef.LStoMM();
			}
		}
		
		// Update object
		public function update() : void {
			// ???
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
			
			visible = false;
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
