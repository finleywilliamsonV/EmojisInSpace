package  {
	
	import flash.display.Sprite;
	import flash.display.Bitmap; 
	import flash.display.BitmapData; 
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	
	public class BackgroundBigStars extends Bitmap implements IPoolable {

		
		// private variables
		
		private var ticks : int = 0;
		private var _destroyed : Boolean;
		private var _bitmapData : BitmapData = new BitmapData(1334, 1500, true, 0x000000);
		private var _tempPoint : Point = new Point();
		
		
		// Constructor
		
		public function BackgroundBigStars() : void {
			
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
			for (var smallNum : int = 0; smallNum < 60; smallNum ++) {
				
				_tempPoint.x = (Math.random() * 1334);
				_tempPoint.y = (Math.random() * 1500);
				
				_bitmapData.copyPixels(GlobalVariables.instance.modelBigStar, GlobalVariables.instance.rectangleXS, _tempPoint);
			}
			
			y = -750;
		}
		
		
		
		// Update object
		
		public function update() : void {
			
			ticks++;
			
			if (ticks % 2 == 0) {
				ticks = 0;
				
				if (y < 0) {
					y++;
				} else {
					_bitmapData.copyPixels(_bitmapData, GlobalVariables.instance.rectangleS, GlobalVariables.instance.point);
					_bitmapData.fillRect(GlobalVariables.instance.rectangleS, 0x00000000);
					y = -750;
					
					// create more big stars
					
					for (var smallNum : int = 0; smallNum < 6; smallNum ++) {
						
						_tempPoint.x = (Math.random() * 1334);
						_tempPoint.y = (Math.random() * 1500);
				
						_bitmapData.copyPixels(GlobalVariables.instance.modelBigStar, GlobalVariables.instance.rectangleXS, _tempPoint);
					}
				}
			}
			
		} // end update()
		
		
		// empty set parent function
		public function setParent(parRef:NewEmojiGameplay):void {
			// N/A
		}
		
		
		// Destroy object
		
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			_destroyed = true;
			
			//parent.removeChild(this);
			
			_bitmapData.fillRect(GlobalVariables.instance.rectangleL, 0x00000000);
			
			bitmapData = null;
			
		}

		
		
		// Return whether object is currently destroyed
		
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
	}
	
}
