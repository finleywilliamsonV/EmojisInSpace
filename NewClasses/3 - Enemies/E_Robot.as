package {

	import flash.display.MovieClip;

	public class E_Robot extends MovieClip implements IPoolable, IGameObject {

		private var _destroyed : Boolean;
		private var iterator: int = 0;
		
		public var pVec:Vector.<IPoolable>;
		public var pRef:NewEmojiGameplay;
		
		public var points;
		public var _destroyableByRegularLaser : Boolean = true;
		
		public var bossMod : int;
		
		
		public function E_Robot() : void {
			
			_destroyed = true;
			
			stop();
			
			renew();
		}

		public function renew() : void {

			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			x = (Math.random() * 1274) + 30;
			y = 780;
			
			points = 8;
			bossMod = 1;
		}

		public function update(): void {
			
			if (iterator < 28 / bossMod) {
				y -= 2 * bossMod;
			} else if (iterator == 40 / bossMod) {
				
				var tempRef = ObjectPool.instance.getObj(LightningBoltVertical) as LightningBoltVertical;
				tempRef.setVector(pVec);
				tempRef.setParent(pRef);
				
				tempRef.x = x;
				tempRef.y = 675;
				
				pVec.push(tempRef);
				pRef.addChild(tempRef);
				
			} else  if (iterator > 80 / bossMod) {
				pRef.removeChild(this);
				ObjectPool.instance.returnObj(this);
			} else if (iterator > 60 / bossMod) {
				y += 4 * bossMod;
			}
			iterator ++;
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
			bossMod = null;
			
			pRef = null;
			gotoAndStop(1);
		}

		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
}