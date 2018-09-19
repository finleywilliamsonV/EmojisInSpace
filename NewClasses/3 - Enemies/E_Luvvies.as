package  {
	
	import flash.display.MovieClip;
	
	
	public class E_Luvvies extends MovieClip implements IPoolable, IGameObject {
		
		// variables
		private var _destroyed : Boolean;
		private var _ySpeed : Number;
	
		
		public var pVec:Vector.<IPoolable>;
		public var pRef:NewEmojiGameplay;
		
		public var points : int;
		public var _destroyableByRegularLaser : Boolean = true;
		
		// Constructor
		public function E_Luvvies() : void {
			
			_destroyed = true;
			
			stop();
			
			visible = false;
			
			renew();
		}
		
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			visible = true;
			
			scaleX = int(10 * (1.2 - (Math.random() * .3)))/10;
			scaleY = scaleX;
			
			x = (Math.random() * (1334 - width)) + (width/2);
			y = -width/2;
			
			_ySpeed = 8 - (Math.random() * 6);
			points = 20;
		}
		
		public function update() : void { 
			
			if (y > 750 + (height * .5)) {
				pRef.removeChild(this);
				ObjectPool.instance.returnObj(this);
				return;
			}
			
			y += _ySpeed;
		}
		
		// boss mode
		public function bossMode() : void {
			
		}
		
		// set vector
		public function setVector(parentVector : Vector.<IPoolable>) : void {
			pVec = parentVector;
		}
		
		
		// set parent
		public function setParent(parRef:NewEmojiGameplay):void {
			pRef = parRef;
		}
		
		// Destroy object
		public function destroy() : void {
			
			
			if (_destroyed) {
				return;
			}
			
			GlobalSounds.instance.setSound(1);
			
			if (pVec) {

				var len : int = pVec.length - 1;
				var index : int = pVec.indexOf(this);
				
				pVec[index] = pVec[len];
				pVec.length = len;
				
				pVec = null;
			}
			
			pRef = null;
			
			gotoAndStop(0);
			
			_destroyed = true;
			visible = false;
			scaleX = 1;
			scaleY = 1;
			_ySpeed = null;
			points = null;
		}
			

		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
