package  {
	
	import flash.display.MovieClip;
	
	
	public class Explosion extends MovieClip implements IPoolable {
		
		public var pRef : NewEmojiGameplay;
		private var _destroyed : Boolean;
		
		public function Explosion() : void {
			
			_destroyed = true;
			
			stop();
			
			addFrameScript(4, removeExplosion);

			renew();
		}
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
		}
		
		public function update() : void {
			
		}
		
		public function explode() : void {
			visible = true;
			gotoAndPlay(0);
			GlobalSounds.instance.setSound(2);
		}
		
		public function removeExplosion() : void {
			pRef.removeChild(this);
			ObjectPool.instance.returnObj(this);
		}
		
		public function setParent(thisParentClip : NewEmojiGameplay, thisX : int, thisY : int, scale : Number = 1) {
			
			pRef = thisParentClip;
			
			scaleX *= scale;
			scaleY *= scale;
			
			x = thisX;
			y = thisY;
		}
		
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			_destroyed = true;
			gotoAndStop(1);
			pRef = null;
			visible = false;
			
			scaleX = 1;
			scaleY = 1;
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
	}
	
}
