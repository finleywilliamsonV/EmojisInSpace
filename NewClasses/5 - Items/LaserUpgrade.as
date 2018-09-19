package  {
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class LaserUpgrade extends Sprite implements IPoolable, IGameObject {
		
		// variables
		private var _destroyed : Boolean;
		private var _xSpeed : int;
		private var _ySpeed : int;

		private var pVec:Vector.<IPoolable>;
		private var pRef:NewEmojiGameplay;
		
		public var points : int;
		
		// Constructor
		public function LaserUpgrade() : void {
			
			_destroyed = true;
			
			renew();
			
			displayLaser.stop();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			
			x = int(Math.random() * (1334-width)) + int(width/2);
			y = int(- height / 2);
			
			_ySpeed = 1 + (Math.random() * 10);
			points = 100;
		}
		
		
		// Update object
		public function update() : void {
			
			y += _ySpeed;
			
			if (y > 750 + (height/2)) {
				pRef.removeChild(this);
				ObjectPool.instance.returnObj(this);
			}
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
			
			points = null;
			
			displayLaser.gotoAndStop(1);
			
			graphics.clear();
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
