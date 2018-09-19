package  {
	
	public class Level_11 implements ILevel, IPoolable {

		
		// variables
		private var _destroyed : Boolean;
		private var pRef : NewEmojiGameplay;
		private var pVecEnemies : Vector.<IPoolable>;
		private var pVecItems : Vector.<IPoolable>;
		
		private var tickCount : int;
		
		public var levelNumber : int = 11;
		
		// Constructor		
		public function Level_11() {
			
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
				tempRef.setup(pRef, E_Robot, 3, 100, 100);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_RobotHorizontal, 3, 200, 200);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 1, 20, 60);
				
			} else if (tickCount == 400) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Robot, 2, 113, 1200);	// --> 1600
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Robot, 1, 33, 700); // --> 1000
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_RobotHorizontal, 3, 157, 700); // --> 1000
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_RobotHorizontal, 1, 91, 700);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 1, 20, 60);
		
				
			} else if (tickCount == 600) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 1, 20, 60);
				
			} else if (tickCount == 800) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 1, 40, 200);
				
			} else if (tickCount == 1000) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Robot, 2, 163, 600);	// --> 1700
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Robot, 2, 53, 600); // --> 1700
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_RobotHorizontal, 1, 87, 600); // --> 1000
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_RobotHorizontal, 2, 147, 600); // --> 1000
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 1, 50, 600);
				
			} else if (tickCount == 1500) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Robot, 2, 33, 60);	// --> 1700
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_RobotHorizontal, 1, 18, 40); // --> 1700
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 1, 10, 100);
				
			} else if (tickCount > 1600) {			
				
				if (pRef.enemies.length == 0 && pRef.situations.length == 0) {
					if( !pRef._diedThisRound ) dropZod();
					changeLevels();
				}
			}
			
			if (tickCount % 137 == 0 && tickCount < 1500) {
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 1, 1, 1);
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
			pRef.nextLevel(ObjectPool.instance.getObj(Level_12) as Level_12);
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
