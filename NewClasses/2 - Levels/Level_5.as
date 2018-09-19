package  {
	
	public class Level_5 implements ILevel, IPoolable {

		
		// variables
		private var _destroyed : Boolean;
		private var pRef : NewEmojiGameplay;
		private var pVecEnemies : Vector.<IPoolable>;
		private var pVecItems : Vector.<IPoolable>;
		
		private var tickCount : int;
		
		public var levelNumber : int = 5;
		
		// Constructor		
		public function Level_5() {
			
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
				tempRef.setup(pRef, E_GustLady, 4, 1, 1);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Dollar, 2, 25, 25);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Robot, 1, 40, 50);
				
			} else if (tickCount == 200) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_GustLady, 1, 75, 150);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Dollar, 1, 200, 200);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Robot, 1, 50, 200);
				
			} else if (tickCount == 400) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_GustLady, 1, 70, 200);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Dollar, 1, 200, 200);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Robot, 1, 67, 200);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Robot, 1, 87, 200);
				
			} else if (tickCount == 600) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_GustLady, 1, 123, 300);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Dollar, 1, 50, 300);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Robot, 3, 80, 300);

				
			} else if (tickCount == 900) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_GustLady, 1, 85, 300);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Dollar, 2, 66, 300);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Robot, 2, 1, 1);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Robot, 3, 150, 150);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Robot, 2, 51, 300);
				
			} else if (tickCount > 900 && tickCount < 1200) {			
				
				if (tickCount % 87 == 0 && Math.random() < .4) {
					var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
					tempRef.setup(pRef, E_GustLady, 1, 15, 15);
					
					tempRef = ObjectPool.instance.getObj(Situation) as Situation;
					tempRef.setup(pRef, E_Robot, 1, 1, 1);
				}
				
			} else if (tickCount > 1200) {			
				
				if (pRef.enemies.length == 0 && pRef.situations.length == 0) {
					if( !pRef._diedThisRound ) dropZod();
					changeLevels();
				}
			}
			
			if (tickCount % 100 == 0) {
				if (Math.random() < .5) {
					var tempRef = ObjectPool.instance.getObj(E_Robot) as E_Robot;
					tempRef.setVector(pRef.enemies);
					tempRef.setParent(pRef);
					pRef.enemies.push(tempRef);
					pRef.addChild(tempRef);
					tempRef.play();
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
			pRef.nextLevel(ObjectPool.instance.getObj(Level_6) as Level_6);
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
