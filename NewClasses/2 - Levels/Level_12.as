package  {
	
	public class Level_12 implements ILevel, IPoolable {

		
		// variables
		private var _destroyed : Boolean;
		private var pRef : NewEmojiGameplay;
		private var pVecEnemies : Vector.<IPoolable>;
		private var pVecItems : Vector.<IPoolable>;
		
		private var tickCount : int;
		
		public var levelNumber : int = 12;
		
		// Constructor		
		public function Level_12() {
			
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
				tempRef.setup(pRef, E_Baddie, 2, 1, 1);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Dollar, 2, 100, 200);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Dollar, 2, 300, 200);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_GustLady, 1, 67, 250);
				
				
				
			} else if (tickCount == 400) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Dollar, 2, 163, 1200);	// --> 1600
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_GustLady, 2, 87, 600);	// --> 1000
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Baddie, 1, 25, 100);
				
			} else if (tickCount == 600) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Baddie, 1, 20, 200);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Dollar, 1, 33, 200);
				
			} else if (tickCount == 800) {			
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Baddie, 1, 21, 200);
				
			} else if (tickCount == 1000) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Dollar, 2, 121, 800);	// --> 1800
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_GustLady, 1, 67, 600);	// --> 1600
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Baddie, 3, 87, 400);
				
			} else if (tickCount == 1300) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_GustLady, 1, 20, 80);
				
			} else if (tickCount == 1450) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Baddie, 2, 37, 200);
				
			} else if (tickCount == 1700) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Dollar, 1, 10, 100);	// --> 1800
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_GustLady, 4, 100, 100);	// --> 1600
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Baddie, 5, 1, 1);
				
			} else if (tickCount > 1900) {			
				
				if (pRef.enemies.length == 0 && pRef.situations.length == 0) {
					if( !pRef._diedThisRound ) dropZod();
					changeLevels();
				}
			}
			
			if (tickCount % 127 == 0) {
				
				var tempRate = 10 + (Math.random() * 20);
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setupItem(pRef, ItemEggplant, 2, tempRate, tempRate + (Math.random() * 3 * tempRate));
			}
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
			pRef.nextLevel(ObjectPool.instance.getObj(Level_Boss) as Level_Boss);
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
