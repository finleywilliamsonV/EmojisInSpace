package  {
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class SideLaserDisplay extends TextField implements IPoolable {
		
		// class variables
		
		private var _destroyed : Boolean;
		private var _score : int;
		private var _format : TextFormat;
		public var _numOfSideLasers : int;
		
		private var pRef:NewDocumentClass;
		
		
		
		// constructor
		
		public function SideLaserDisplay() : void {
			
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
			
			textColor = 0xFFA57E;
			_numOfSideLasers = 0;
			text = _numOfSideLasers.toString();
			
			width = 234;
			
			x = 120;
			y = 617;

		}
		
		
		public function modifyNum(mod : int) : void {
			_numOfSideLasers += mod;
			text = _numOfSideLasers.toString();
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
			_numOfSideLasers = null;
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
