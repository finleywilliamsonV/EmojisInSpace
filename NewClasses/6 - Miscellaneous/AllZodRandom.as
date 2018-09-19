package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class AllZodRandom extends MovieClip implements IPoolable {
		
		// variables
		private var _destroyed : Boolean;
		public var _currentZodShowing : int;
		private var _iterator : int;
		private var enterFrameCount : int;
		private var isCycling : Boolean;
		private var cycleCount: int;
		private var waitTime: int;
		
		public var points : int;
		
		
		// Constructor
		public function AllZodRandom() : void {
			
			_destroyed = true;
			
			stop();
			
			renew();
			
			scaleX = .38;
			scaleY = .38;
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			gotoAndStop(1);
			
			_destroyed = false;
			_iterator = 0;
			enterFrameCount = 0;
			isCycling = false;
			waitTime = 0;
		}
		
		
		public function update() : void {
			
			
		}
		
		
		public function returnPosition() : int {
			return _currentZodShowing - 1;
		}
		
		public function startRandomChoice() : void {
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			darkness.visible = true;
			isCycling = true;
			cycleCount = 8;
		}
		
		public function onEnterFrame(e : Event) : void {
			
			enterFrameCount ++;

			if (isCycling) {
				if (cycleCount > 0) {
					if (waitTime == 0) {
						gotoAndStop(1 + int(Math.random() * 12));
						cycleCount --;
						waitTime = 4;
					} else {
						waitTime--;
					}
				} else {
					isCycling = false;
					darkness.visible = false;
					stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					
					// remove
					var randBuffer = currentFrame;
					while (randBuffer == currentFrame) {
						randBuffer = 1 + int(Math.random() * 12);
					}
					gotoAndStop(randBuffer);
					//gotoAndStop(2);
				}
			}
			
			
			// here
		}
		
		// Destroy object and return to ObjectPool
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			gotoAndStop(1);
			
			_destroyed = true;
			_currentZodShowing = null;
			_iterator = null;
			enterFrameCount = null;
			isCycling = null;
			cycleCount = null;
			waitTime = null;
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
