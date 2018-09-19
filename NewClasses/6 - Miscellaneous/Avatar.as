package  {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Avatar extends Sprite implements IPoolable {
		
		private var _destroyed : Boolean;
		public var _isShielded : Boolean;
		
		private var _onEnterCount : int;
		
		public var _isHit : Boolean;
		
		public function Avatar() : void {
			
			_destroyed = true;
			
			renew();
			
		}
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = true;
			
			visible = true;
			
			_isShielded = false;
			
			_onEnterCount = 0;
			
			_isHit = false;
		}
		

		public function update() : void {
			
		}
		
		
		public function onHit() : void {
			visible = false;
			_isHit = true;
			GlobalVariables.instance.gameTimer2.addEventListener(TimerEvent.TIMER, onEnterFrame, false, 0, true);
		}
		
		public function onEnterFrame( tE : TimerEvent ) : void {
			
			_onEnterCount ++;
			
			if (_onEnterCount % 6 == 0) {
				if ( visible == true ) {
					visible = false;
				} else {
					visible = true;
				}
			}
			
			if (_onEnterCount == 80) {
				visible = true;
				_isHit = false;
				_onEnterCount = 0;
				GlobalVariables.instance.gameTimer2.removeEventListener(TimerEvent.TIMER, onEnterFrame);
			}
		}
		
		
		// Destroy object
		public function destroy() : void {
			
			
			if (_destroyed) {
				return;
			}
			
			_destroyed = true;
			
			_onEnterCount = null;
			
			visible = false;
			
			_isHit = null;
			
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
	}
	
}
