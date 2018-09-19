package {

	
	import flash.display.MovieClip;

	
	public class E_RobotHorizontal extends MovieClip implements IPoolable, IGameObject {

		
		private var _destroyed : Boolean;
		private var iterator: int = 0;
		private var _direction : int;
		
		public var pVec:Vector.<IPoolable>;
		public var pRef:NewEmojiGameplay;
		
		public var points : int;
		public var _destroyableByRegularLaser : Boolean = true;
		
		public var bossMod : int;
		
		
		public function E_RobotHorizontal() : void {
			
			_destroyed = true;
			
			stop();
			
			renew();
		}

		public function renew() : void {

			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			points = 12;
			
			y = (Math.random() * 670) + 40;
			
			setDirection();
			
			bossMod = 1;
		}
		
		public function update(): void {
			
			
			if (iterator < 36 / bossMod) {
				x -= 2 * _direction * bossMod;
				
			} else if (iterator == 48 / bossMod || iterator == 54 / bossMod) {
				
				var tempRef = ObjectPool.instance.getObj(LightningBoltHorizontal) as LightningBoltHorizontal;
				tempRef.setVector(pVec);
				tempRef.setParent(pRef);
				
				tempRef.x = x;
				tempRef.y = y;
				
				tempRef.setDirection(_direction);
				
				pVec.push(tempRef);
				pRef.addChild(tempRef);
				
			} else  if (iterator > 90 / bossMod) {
				pRef.removeChild(this);
				ObjectPool.instance.returnObj(this);
			} else  if (iterator > 70 / bossMod) {
				x += 4 * _direction * bossMod;
			}
			iterator ++;
		}

		public function setDirection() : void {
			_direction = 1 - (int(Math.random() * 2)*2);
			
			if(_direction == -1) {
				x = -40;
			} else {
				x = 1374;
				scaleX = -1;
			}
		}
		
		// boss mode
		public function bossMode() : void {
			bossMod = 2;
		}
		
		// set vector
		public function setVector(parentVector : Vector.<IPoolable>) : void {
			pVec = parentVector;
		}
		
		
		// set parent
		public function setParent(parRef:NewEmojiGameplay):void {
			pRef = parRef;
		}
		
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
			
			_destroyed = true;
			
			iterator = null;
			points = null;
			
			pRef = null;
			gotoAndStop(1);
			
			bossMod = null;
			
			scaleX = 1;
			scaleY = 1;
		}

		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
}

