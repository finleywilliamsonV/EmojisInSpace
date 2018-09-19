package  {
	
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	
	public class Level_Transition implements ILevel, IPoolable {

		
		// variables
		private var _destroyed : Boolean;
		private var pRef : NewEmojiGameplay;
		
		private var tickCount : int;
		private var ticksBtw: int;
		
		private var _nextLevel;
		private var _nextLevelClass : Class;
		
		
		// Constructor		
		public function Level_Transition() {
			
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
			
			if (pRef.enemies.length == 0) {
				
					tickCount++;
				
				// level change logic
				if (tickCount == 10) {
					
					var tempRef : LevelTextBanner = ObjectPool.instance.getObj(LevelTextBanner) as LevelTextBanner;
					tempRef.setText(_nextLevel.levelNumber);
					tempRef.setParent(pRef);
					pRef.addChild(tempRef);
					
				} else if (tickCount == 50) {
					
					changeLevels();
				}
			}
		}
		
		// set parent
		public function setParent(parRef:NewEmojiGameplay):void {
			
			pRef = parRef;
		}
		
		public function setNextLevel( newLvl : ILevel ) : void {
			_nextLevel = newLvl;
			_nextLevelClass = Class(getDefinitionByName(getQualifiedClassName(_nextLevel)));
		}
   
		public function changeLevels() : void {
			
			pRef.endLevelTransition(ObjectPool.instance.getObj(_nextLevelClass) as ILevel);
		}
		
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			_destroyed = true;
			
			tickCount = null;
			
			pRef = null;
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
}
