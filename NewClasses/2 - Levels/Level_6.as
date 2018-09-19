package  {
	
	public class Level_6 implements ILevel, IPoolable {

		
		// variables
		private var _destroyed : Boolean;
		private var pRef : NewEmojiGameplay;
		private var pVecEnemies : Vector.<IPoolable>;
		private var pVecItems : Vector.<IPoolable>;
		
		private var tickCount : int;
		
		public var levelNumber : int = 6;
		
		// Constructor		
		public function Level_6() {
			
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
				tempRef.setup(pRef, E_Baddie, 2, 100, 100);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 1, 1, 1);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 1, 50, 50);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_RobotHorizontal, 3, 150, 150);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_RobotHorizontal, 2, 200, 200);
				
			} else if (tickCount == 300) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Baddie, 1, 61, 400);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 1, 77, 400);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_RobotHorizontal, 1, 33, 400);
				
			} else if (tickCount == 700) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Baddie, 1, 71, 300);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Baddie, 1, 81, 300);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 2, 123, 300);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_RobotHorizontal, 1, 62, 300);
				
			} else if (tickCount == 1000) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Baddie, 2, 86, 300);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Baddie, 1, 31, 300);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Luvvies, 1, 44, 300);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_RobotHorizontal, 2, 72, 300);
				
				tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_RobotHorizontal, 1, 52, 300);
				
			} else if (tickCount > 1300) {			
				
				 if (pRef.enemies.length == 0 && pRef.situations.length == 0) {
					if( !pRef._diedThisRound ) dropZod();
					changeLevels();
				}
			}
			
			if (tickCount % 100 == 0 && tickCount < 1200) {
				if (Math.random() < .5) {
					var tempRef = ObjectPool.instance.getObj(E_RobotHorizontal) as E_RobotHorizontal;
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
			pRef.nextLevel(ObjectPool.instance.getObj(Level_7) as Level_7);
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
