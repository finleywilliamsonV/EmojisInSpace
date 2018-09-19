package  {
	
	public class Level_Finale implements ILevel, IPoolable {

		
		// variables
		private var _destroyed : Boolean;
		private var pRef : NewEmojiGameplay;
		private var pVecEnemies : Vector.<IPoolable>;
		private var pVecItems : Vector.<IPoolable>;
		
		private var tickCount : int;
		
		
		// Constructor		
		public function Level_Finale() {
			
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
			
			if (tickCount == 80) {
				var tempGO = ObjectPool.instance.getObj(DisplayGameOver) as DisplayGameOver;
				tempGO.setParent(pRef);
				pRef.addChild(tempGO);
				tempGO.play();
			}
			
			else if (tickCount == 1200) {
				pRef.pRef.EGtoGO();
			} 
			
		}
	
		
		//// drop AllZod object
		//public function dropZod() : void {
		//	var tempRef = ObjectPool.instance.getObj(AllZod) as AllZod;
		//	tempRef.setWhich(levelNumber);
		//	tempRef.setVector(pVecItems);
		//	tempRef.setParent(pRef);
		//	
		//	pVecItems.push(tempRef);
		//	pRef.addChild(tempRef);
		//}
		
		// set parent
		public function setParent(parRef:NewEmojiGameplay):void {
			pRef = parRef;
			pVecEnemies = pRef.enemies;
			pVecItems = pRef.items;
		}

		public function changeLevels() : void {
			//pRef.nextLevel(ObjectPool.instance.getObj(Level_2) as Level_2);
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
