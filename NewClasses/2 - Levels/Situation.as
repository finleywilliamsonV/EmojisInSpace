package  {
	
	import flash.display.MovieClip;
	
	public class Situation implements IPoolable, ISituation {
		
		// variables
		private var _destroyed : Boolean;
		private var pRef : NewEmojiGameplay;
		private var pVec : Vector.<IPoolable>;
		private var pVecEnemies : Vector.<IPoolable>;
		private var pVecItems : Vector.<IPoolable>;
		
		private var _dropClass : Class;
		private var _dropCount : int;
		private var _ticksBtwDrop : int;
		private var _removeCount : int;
		
		private var _tickCount : int;
		private var _repeatCount : int;
		
		// Constructor		
		public function Situation() {
			
			_destroyed = true;
			
			renew();
			
		}
			
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			_tickCount = 0;
			_repeatCount = 0;
			
		}
		
		public function update():void {

			_tickCount++;

			//trace(this + " updating");
			
			if (_tickCount % _ticksBtwDrop == 0) {
				
				var tempRef;
				
				for (var i : int = 0; i < _dropCount; i++) {
					
					tempRef = ObjectPool.instance.getObj(_dropClass) as _dropClass;
					tempRef.setVector(pVecEnemies);
					tempRef.setParent(pRef);
					
					if (tempRef is MovieClip) {
						tempRef.play();
					}
					
					pVecEnemies.push(tempRef);
					pRef.addChild(tempRef);
				}
			}
			
			
			// remove logic
			if (_tickCount == _removeCount) ObjectPool.instance.returnObj(this);
			
		}
		

		// set situation
		public function setup(parRef: NewEmojiGameplay, newClass : Class, newDropCount : int, newTicksPerDrop : int, newRemoveCount : int) : void {

			pRef = parRef;
			pVec = pRef.situations;
			pVecEnemies = pRef.enemies;
			
			_dropClass = newClass;
			_dropCount = newDropCount;
			_ticksBtwDrop = newTicksPerDrop;
			_removeCount = newRemoveCount;
			
			pVec.push(this);
		}
		
		
		// set situation
		public function setupItem(parRef: NewEmojiGameplay, newClass : Class, newDropCount : int, newTicksPerDrop : int, newRemoveCount : int) : void {

			pRef = parRef;
			pVec = pRef.situations;
			pVecEnemies = pRef.items;
			
			_dropClass = newClass;
			_dropCount = newDropCount;
			_ticksBtwDrop = newTicksPerDrop;
			_removeCount = newRemoveCount;
			
			pVec.push(this);
		}
		
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
			
			_destroyed = true;
			
			_dropClass = null;
			_dropCount = null;
			_ticksBtwDrop = null;
			_removeCount = null;
			
			_tickCount = null;
			_repeatCount = null;

			pRef = null;
			pVec = null;
			pVecEnemies = null;
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
