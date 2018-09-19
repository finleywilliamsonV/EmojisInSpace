package  {
	
	import flash.display.Sprite;
	import flash.display.Bitmap; 
	import flash.display.BitmapData; 
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.display.Graphics;
	
	
	public class BackgroundStars extends Bitmap implements IPoolable {

		
		// private variables
		
		private var ticks : int = 0;
		private var _destroyed : Boolean;
		private var _bitmapData : BitmapData = new BitmapData(1334, 1500, true, 0x000000);
		
		
		// Constructor
		
		public function BackgroundStars() : void {
			
			super();
			
			_destroyed = true;
			
			renew();
		}
		
		
		// Renew object to usable state
		
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			bitmapData = _bitmapData;
			
			// create stars
			for (var smallNum : int = 0; smallNum < 200; smallNum ++) {
				_bitmapData.setPixel32(Math.random() * 1334, Math.random() * 1500, 0xFFFFFFFF);
			}
			
			y = -750;
		}
		
		
		// empty set parent function
		public function setParent(parRef:NewEmojiGameplay):void {
			// N/A
		}
		
		
		// Update object
		
		public function update() : void {
			
			ticks++;
			
			if (ticks % 4 == 0) {
				ticks = 0;
				
				if (y < 0) {
					y++;
				} else {
					_bitmapData.copyPixels(_bitmapData, GlobalVariables.instance.rectangleS, GlobalVariables.instance.point);
					_bitmapData.fillRect(GlobalVariables.instance.rectangleS, 0x00000000);
					y = -750;
					
					for (var moreSmallStars : int = 0; moreSmallStars < 100; moreSmallStars ++) {
						_bitmapData.setPixel32(Math.random() * 1334, Math.random() * 750, 0xFFFFFFFF);
					}
				}
			}
			
		} // end update()
		
		
		
		
		// Destroy object
		
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			_destroyed = true;
			
			//parent.removeChild(this);
			bitmapData = null;
			
			_bitmapData.fillRect(GlobalVariables.instance.rectangleL, 0x00000000);
			//_bitmapData.dispose();
		}

		
		
		// Return whether object is currently destroyed
		
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
	}
	
}
