package  {
	
	public class Level_Tutorial implements ILevel, IPoolable {

		
		// variables
		private var _destroyed : Boolean;
		private var pRef : NewEmojiGameplay;
		private var pVecEnemies : Vector.<IPoolable>;
		private var pVecItems : Vector.<IPoolable>;
		
		private var _crystalsCollected : Boolean;
		private var _crystalCount : int;
		
		private var tickCount : int;
		
		public var levelNumber : int = 0;
		
		public var TB : TutorialBanner;
		
		// Constructor		
		public function Level_Tutorial() {
			
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
			
			_crystalsCollected = false;
			_crystalCount = 0;
			
			TB = ObjectPool.instance.getObj(TutorialBanner) as TutorialBanner;
			TB.x = 667;
			TB.y = 375;
			TB.setText();
		}
		
		
		public function update():void {

			tickCount++;
			
			// level change logic
			if (tickCount == 1) {
				
				// add banner
				pRef.addChild(TB);
				pRef.setChildIndex(TB, pRef.getChildIndex(pRef.avatar) - 2);
				
				
				// set up crystal 1
				var tempRef = ObjectPool.instance.getObj(PortalCrystal) as PortalCrystal;
				tempRef.setParent(pRef);
				tempRef.setVector(pVecItems);
				pVecItems.push(tempRef);
				pRef.addChild(tempRef);
				
				tempRef.x = 300;
				tempRef.y = 250;
				
				// set up crystal 2
				var tempRef = ObjectPool.instance.getObj(PortalCrystal) as PortalCrystal;
				tempRef.setParent(pRef);
				tempRef.setVector(pVecItems);
				pVecItems.push(tempRef);
				pRef.addChild(tempRef);
				
				tempRef.x = 1034;
				tempRef.y = 250;
				
				// set up crystal 3
				var tempRef = ObjectPool.instance.getObj(PortalCrystal) as PortalCrystal;
				tempRef.setParent(pRef);
				tempRef.setVector(pVecItems);
				pVecItems.push(tempRef);
				pRef.addChild(tempRef);
				
				tempRef.x = 300;
				tempRef.y = 500;
				
				// set up crystal 4
				var tempRef = ObjectPool.instance.getObj(PortalCrystal) as PortalCrystal;
				tempRef.setParent(pRef);
				tempRef.setVector(pVecItems);
				pVecItems.push(tempRef);
				pRef.addChild(tempRef);
				
				tempRef.x = 1034;
				tempRef.y = 500;
				
				// add "collect the crystals"
				
			} else if (_crystalsCollected) {
				
				// add portal
				// expand
				// change level
				
				changeLevels();
				
			}
		}
	
		
		
		public function collectCrystal() {
			_crystalCount ++;
			
			if (_crystalCount == 4) {
				_crystalsCollected = true;
			}
		}
		
		// set parent
		public function setParent(parRef:NewEmojiGameplay):void {
			pRef = parRef;
			pVecEnemies = pRef.enemies;
			pVecItems = pRef.items;
			
			pRef._ticksPaused = true;
		}

		public function changeLevels() : void {
			
			pRef.removeChild(TB);
			ObjectPool.instance.returnObj(TB);
			TB = null;
			
			
			
			var tempExp = ObjectPool.instance.getObj(Explosion) as Explosion;
			tempExp.setParent(pRef, 667, 375, 30);
			pRef.addChild(tempExp);
			tempExp.explode();
			
			pRef._ticksPaused = false;
			pRef.integerToNextLevel(pRef.sharedObject_currentLevelSelected);
		}
		
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			_destroyed = true;
			
			pVecEnemies = null;
			pVecItems = null;
			
			_crystalsCollected = null;
			_crystalCount = null;
			
			pRef = null;
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
