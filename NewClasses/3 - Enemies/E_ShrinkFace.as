package {

	import flash.display.Sprite;


	public class E_ShrinkFace extends Sprite implements IPoolable, IGameObject {
		
		// variables
		private var _destroyed : Boolean;
		private var _ySpeed : Number;
		
		private var hitCount: int;
		private var lastHit: String;
		private var isFalling: Boolean;
		
		public var pVec:Vector.<IPoolable>;
		public var pRef:NewEmojiGameplay;
		
		public var points : int;
		public var _destroyableByRegularLaser : Boolean = true;
		
		private var _randomIncrement : Number;
		
		public var _isBossMode : Boolean;
		
		// Constructor
		public function E_ShrinkFace() : void {
			
			_destroyed = true;
			
			renew();
		}
		
		public function renew(): void {
			
			if (!_destroyed) {
				return;
			}
			
			visible = true;
			
			_destroyed = false;
			
			_randomIncrement = 1.04 + Math.random() * .03;
			
			scaleX = int(10 * (1 - (Math.random() * .3)))/10;
			scaleY = scaleX;

			x = int(((Math.random() * (1334 - width) + width/2))*10)/10;
			y = -width/2;
			
			_ySpeed = int(1 + (Math.random() * 2));
			hitCount = 0;
			isFalling = false;
			points = 50;
			_isBossMode = false;
		}
		

		public function update(): void {
				
			if (y > 750 + (height * .5)) {
				pRef.removeChild(this);
				ObjectPool.instance.returnObj(this);
				return;
			}
			
			y += _ySpeed;
			
			if (isFalling) _ySpeed *= _randomIncrement;
		}


		public function onHitAndDead(thisLaser: *): Boolean { // returns false if still alive
			
			if (thisLaser is YinYangProj) return true;
			
			if (lastHit != thisLaser.name) {
				hitCount++;
				
				if (_isBossMode) {
					scaleX = 1;
					scaleY = 1;
				} else {
					scaleX = .15;
					scaleY = .15;
				}
				
				isFalling = true;
				_ySpeed = 1;
				
				if (y < -width/2) {
					y = -width/2;
				}
				
				GlobalSounds.instance.setSound(1);

				if (hitCount < 2) {
					lastHit = thisLaser.name;
					return false;
				} else {
					return true;
				}
				
			} else {
				lastHit = thisLaser.name;
				return false;
			}
		}
		
		// boss mode
		public function bossMode() : void {
			_isBossMode = true;
			scaleX = .15;
			scaleY = .15;
			_randomIncrement -= .03;
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
			
			if (pVec) {

				var len : int = pVec.length - 1;
				var index : int = pVec.indexOf(this);
				
				pVec[index] = pVec[len];
				pVec.length = len;
				
				pVec = null;
			}
			
			pRef = null;
			
			_destroyed = true;
			visible = false;
			scaleX = 1;
			scaleY = 1;
			_ySpeed = null;
			hitCount = null;
			lastHit = null;
			isFalling = null;
			points = null;
			_isBossMode = null;
		}
			

		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
}