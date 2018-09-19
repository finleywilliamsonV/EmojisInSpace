package  {
	
	public class Level_3 implements ILevel, IPoolable {

		
		// variables
		private var _destroyed : Boolean;
		private var pRef : NewEmojiGameplay;
		private var pVecEnemies : Vector.<IPoolable>;
		private var pVecItems : Vector.<IPoolable>;
		
		private var tickCount : int;
		
		public var levelNumber : int = 3;
		
		// Constructor		
		public function Level_3() {
			
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
				tempRef.setup(pRef, E_Angry, 1, 50, 100);
				
			} else if (tickCount == 200) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Angry, 1, 40, 550);
				
			} else if (tickCount == 700) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Angry, 1, 80, 500);
				
				var tempRef2 = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef2.setup(pRef, E_Angry, 2, 120, 500);
				
				var tempRef3 = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef3.setup(pRef, E_Angry, 2, 10, 10);
				
			} else if (tickCount > 700 && tickCount < 1300) {			
				
				if (tickCount % 100 == 0 && Math.random() < .2) {
					var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
					tempRef.setup(pRef, E_Angry, 1, 15, 30);
				}
				
			} else if (tickCount == 1300) {			
				
				var tempRef = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef.setup(pRef, E_Angry, 3, 150, 300);
				
				var tempRef2 = ObjectPool.instance.getObj(Situation) as Situation;
				tempRef2.setup(pRef, E_Angry, 1, 30, 300);
				
			} else if (tickCount > 1700) {			
				
				if (pRef.enemies.length == 0 && pRef.situations.length == 0) {
					if( !pRef._diedThisRound ) dropZod();
					changeLevels();
				}
			}
			
			if (tickCount % 189 == 0) {
				if (Math.random() < .3) {
					var tempRef = ObjectPool.instance.getObj(E_Angry) as E_Angry;
					tempRef.setVector(pRef.enemies);
					tempRef.setParent(pRef);
					pRef.enemies.push(tempRef);
					pRef.addChild(tempRef);
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
			pRef.nextLevel(ObjectPool.instance.getObj(Level_4) as Level_4);
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
