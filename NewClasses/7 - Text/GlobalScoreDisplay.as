package  {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class GlobalScoreDisplay extends Sprite implements IPoolable {
		
		// class variables
		
		private var _destroyed : Boolean;
		private var _score : int;
		private var _format : TextFormat;
		
		private var pRef:NewDocumentClass;
		
		
		
		// constructor
		
		public function GlobalScoreDisplay() : void {
			
			_destroyed = true;
			
			renew();
		}
		
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			/*globalScoreText.selectable = false;
			
			_format = GlobalFont.instance.globalTextFormat;
			_format.size = 58;
			_format.align = TextFormatAlign.LEFT;
			
			globalScoreText.defaultTextFormat = _format;
			
			globalScoreText.textColor = 0x93F7B6;*/
			
			updateDisplay();
			
			//width = 550;
			
			x = 656;
			y = 45;

		}
		
		
		public function modifyScore(scoreChange : int) : void {
			_score += scoreChange;
			globalScoreText.text = _score.toString();
		}
		
		// Update object
		public function update() : void {
			// ???
		}
		
		// Update display
		public function updateDisplay() : void {
			_score = GlobalSharedObject.instance._globalScore;
			globalScoreText.text = _score.toString();
		}
		
		
		// set parent
		public function setParent(parRef:NewDocumentClass):void {
			pRef = parRef;
		}
		
		// add score
		
		
		// Destroy object and return to ObjectPool
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			pRef = null;
			
			_destroyed = true;
			_score = null;
			
			globalScoreText.text = "";
			
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
		
	}
	
}
