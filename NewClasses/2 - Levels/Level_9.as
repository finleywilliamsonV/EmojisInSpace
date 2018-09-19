package  {
	
	public class Level_9 implements ILevel, IPoolable {

		
		// variables
		private var _destroyed : Boolean;
		private var pRef : NewEmojiGameplay;
		private var pVecEnemies : Vector.<IPoolable>;
		private var pVecItems : Vector.<IPoolable>;
		
		private var tickCount : int;
		
		public var levelNumber : int = 9;
		
		// Constructor		
		public function Level_9() {
			
			_destroyed = true;
			
			renew();
			
		}
			
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			tickCount = 0;
		}
		
		public function update():void {

			tickCount++;
			
			// level change logic
			if (tickCount == 1) {					
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Angry, 2, 10, 20);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 1, 20, 20);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 1, 50, 50);
				
			} else if (tickCount == 100) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Angry, 2, 75, 400);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Angry, 1, 54, 400);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 1, 85, 400);
				
			} else if (tickCount == 500) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Angry, 3, 95, 400);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Angry, 2, 63, 400);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 1, 38, 400);
				
			} else if (tickCount == 900) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Angry, 3, 95, 200);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 2, 62, 200);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 3, 100, 200);
				
			} else if (tickCount == 1200) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Angry, 1, 43, 200);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Angry, 2, 66, 200);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 1, 32, 200);
				
			} else if (tickCount > 1200) {			
				
				if (pRef.enemies.length == 0 && pRef.situations.length == 0) {
					if( !pRef._diedThisRound ) dropZod();
					changeLevels();
				}
			}
			
			//if (tickCount % 167 == 0) {
				
				//var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				//tempRef.setup(pRef, E_Angry, 5, 1, 1);
			//}
			
		}
	
		
		// drop AllZod object
		public function dropZod() : void {
			var tempRef = ObjectPool.instance.getObj(AllZod) as AllZod;
			tempRef.setWhich(levelNumber);
			tempRef.setVector(pVecItems);
			tempRef.setParent(pRef);
			
			pVecItems.push(tempRef);
			pRef.addChild(tempRef);
		}
		
		// set parent
		public function setParent(parRef:NewEmojiGameplay):void {
			pRef = parRef;
			pVecEnemies = pRef.enemies;
			pVecItems = pRef.items;
		}

		public function changeLevels() : void {
			pRef.nextLevel(ObjectPool.instance.getObj(Level_10) as Level_10);
		}
		
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			_destroyed = true;
			
			pVecEnemies = null;
			pVecItems = null;
			
			pRef = null;
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
