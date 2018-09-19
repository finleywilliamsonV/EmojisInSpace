package  {
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	
	public class LevelTextBanner extends Sprite implements IPoolable {
		
		// private variables
		private var _destroyed : Boolean;

		private var pRef:NewEmojiGameplay;
		
		// Constructor
		public function LevelTextBanner() : void {
			
			_destroyed = true;
			
			renew();
		}
		
		public function renew() : void {
		
			x = 667;
			y = -100;
			
			if (!_destroyed) {
				return;
			}
			
			levelText.text = "";
			
			_destroyed = false;
		}
		
		public function update() : void {

			y += 10;
			
			if (y > 750 + (width * .5)) {
				pRef.removeChild(this);
				ObjectPool.instance.returnObj(this);
			}
			
			circles.rotation += 10;
		}
		
		// set text
		public function setText( newText : String ) : void {
			levelText.text = newText;
		}
		
		// set parent
		public function setParent(parRef:NewEmojiGameplay):void {
			pRef = parRef;
		}
		
		// Destroy object and return to ObjectPool
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			pRef = null;
			
			_destroyed = true;
			
			circles.rotation = 0;
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
	}
}
