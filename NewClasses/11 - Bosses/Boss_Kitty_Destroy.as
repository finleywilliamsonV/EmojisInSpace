package  {
	
	import flash.display.MovieClip;
	
	
	public class Boss_Kitty_Destroy extends MovieClip implements IPoolable, IGameObject {
		
		// private variables
		private var _destroyed : Boolean;

		private var pRef:NewEmojiGameplay;
		
		private var _updateCounter : int;
		
		// Constructor
		public function LevelTextBanner() : void {
			
			_destroyed = true;
			
			stop();
			
			renew();
		}
		
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			_updateCounter = 0;
			
			gotoAndStop(1);
		}
		
		public function update() : void {

			_updateCounter ++;
			
			if (_updateCounter % 4 == 0) {
				var tempExp = ObjectPool.instance.getObj(Explosion) as Explosion;
				tempExp.setParent(pRef, x - ( (-width/2) + int(Math.random() * width) ), y - ( (-height/2) + int(Math.random() * height) ), 2);
				pRef.addChild(tempExp);
				tempExp.explode();
				pRef.addPoints(100 + int(Math.random() * 50));
			}
			
			if (Math.random() < .33) _updateCounter ++;
			
			if (_updateCounter >= 250) {
				var tempExp = ObjectPool.instance.getObj(Explosion) as Explosion;
				tempExp.setParent(pRef, x, y, 5);
				pRef.addChild(tempExp);
				tempExp.explode();
				pRef.addPoints(1000 + int(Math.random() * 1000));
				
				pRef.removeChild(this);
				ObjectPool.instance.returnObj(this);
			}
		}
		
		// set parent
		public function setParent(parRef:NewEmojiGameplay):void {
			pRef = parRef;
		}
		
		// set parent
		public function setVector(parVec:Vector.<IPoolable>):void {
			
		}
		
		// Destroy object and return to ObjectPool
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			pRef = null;
			
			_destroyed = true;
			
			_updateCounter = null;
			
			
			gotoAndStop(1);
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
	}
}
