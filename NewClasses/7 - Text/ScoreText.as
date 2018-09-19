package  {
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class ScoreText extends TextField implements IPoolable {
		
		// class variables
		
		private var _destroyed : Boolean;
		private var _score : int;
		private var _format : TextFormat;
		
		private var pRef:NewDocumentClass;
		
		
		
		// constructor
		
		public function ScoreText() : void {
			
			_destroyed = true;
			
			renew();
		}
		
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			visible = true;
			selectable = false;
			
			_format = GlobalFont.instance.globalTextFormat;
			_format.size = 50;
			_format.align = TextFormatAlign.LEFT;
			
			defaultTextFormat = _format;
			
			textColor = 0x8EEDBC;
			_score = 0;
			text = _score.toString();
			
			width = 234;
			
			x = 1100;
			y = 0;

		}
		
		
		public function modifyScore(scoreChange : int) : void {
			_score += scoreChange;
			text = _score.toString();
		}
		
		// Update object
		public function update() : void {
			// ???
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
			_format = null;
			
			text = "";
			//defaultTextFormat = null;
			
			visible = false;
			
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
		
	}
	
}
