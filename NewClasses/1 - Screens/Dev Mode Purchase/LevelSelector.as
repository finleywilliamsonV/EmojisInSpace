package  {
	
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	
	
	public class LevelSelector extends Sprite implements IPoolable {
		

		// class variables
		
		private var _destroyed : Boolean;
		
		public var pRef : NewDocumentClass;
		
		public var _currentLevel : int;
		
		
		
		// constructor
		public function LevelSelector() {
			
			_destroyed = true;
			
			renew();
			
			x = 0;
			y = 93;
			
			scaleX = 1.3;
			scaleY = 1.3;
		}
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			
			_currentLevel = GlobalSharedObject.instance._currentLevelSelected;

			setCurrentLevel();
			
		}
		
		
		
		// click
		
		public function click( target : * ) : void {
			
			//trace (target);
			
			if (target == forward) {

				_currentLevel ++;
				setCurrentLevel();
				
				
			} else if (target == back) {
				
				_currentLevel --;
				setCurrentLevel();
			}
			
		}
		
		
		
		
		public function setCurrentLevel() : void {
			
			if (_currentLevel == 1) {
				
				levelSelectText.text = _currentLevel.toString();
				back.visible = false;
				
			} else if (_currentLevel > 1 && _currentLevel < 13) {
				
				levelSelectText.text = _currentLevel.toString();
				back.visible = true;
				forward.visible = true;
				
				
			} else if (_currentLevel == 13) {
				
				levelSelectText.text = "BOSS";
				forward.visible = false;
			}
		}
		
		// Update object
		public function update() : void {
			// ???
		}
		
		// set parent
		public function setParent(parRef:NewDocumentClass):void {
			pRef = parRef;
		}
		
		
		public function recordPosition() : void {
			GlobalSharedObject.instance._currentLevelSelected = _currentLevel;
		}
		
		
		// Destroy object and return to ObjectPool
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			pRef = null;
			_destroyed = true;
			
			recordPosition();
			_currentLevel = null;
			
			levelSelectText.text = "";
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
	}
}
