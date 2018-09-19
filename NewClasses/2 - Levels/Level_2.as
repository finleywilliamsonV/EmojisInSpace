package  {
	
	public class Level_2 implements ILevel, IPoolable {

		
		// variables
		private var _destroyed : Boolean;
		private var pRef : NewEmojiGameplay;
		private var pVecEnemies : Vector.<IPoolable>;
		private var pVecItems : Vector.<IPoolable>;
		
		private var tickCount : int;
		
		public var levelNumber : int = 2;
		
		// Constructor		
		public function Level_2() {
			
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
				tempRef.setup(pRef, E_Big, 1, 25, 25);
				
				var tempRef2 = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef2.setup(pRef, E_Big, 1, 50, 50);
				
			} else if (tickCount == 150) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Big, 1, 40, 650);
				
			} else if (tickCount == 800) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Big, 1, 42, 600);
				
				var tempRef2 = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef2.setup(pRef, E_Big, 1, 100, 600);
				
			/*} else if (tickCount == 1400) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Big, 1, 30, 200);
				
				var tempRef2 = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef2.setup(pRef, E_Big, 1, 88, 200);
				
				var tempRef3 = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef3.setup(pRef, E_Big, 1, 148, 200);*/
				
			} else if (tickCount > 1400) {			
				
				if (pRef.enemies.length == 0 && pRef.situations.length == 0) {
					if( !pRef._diedThisRound ) dropZod();
					changeLevels();
				}
			}
			
			//if (tickCount % 167 == 0) {
				
				//var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				//tempRef.setup(pRef, E_Basic, 5, 1, 1);
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
			pRef.nextLevel(ObjectPool.instance.getObj(Level_3) as Level_3);
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
