package  {
	import flash.display.Sprite;
	import flash.display.Bitmap; 
	import flash.display.BitmapData; 
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.profiler.Telemetry;
	
	public class ProgressBar_Laser extends Bitmap implements IPoolable {
		
		// class variables
		
		private var _destroyed : Boolean;
		private var _PercentRegionCount : int;
		
		private var _tempPoint : Point;
		
		private var pRef:NewEmojiGameplay;
		
		private var _bitmapData : BitmapData;
		
		// constructor
		
		public function ProgressBar_Laser() : void {
			
			super();
			
			_destroyed = true;
			
			_bitmapData = GlobalVariables.instance.modelProgressBar;
			
			_tempPoint = GlobalVariables.instance.modelProgressBarPoint;
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			visible = true;
			
			_PercentRegionCount = 0;

			bitmapData = _bitmapData;
			
			build(10);
		}
		
		public function build(mod : int) : void {
			
			for (var i : int = 0 ; i < mod ; i++) {
				_tempPoint.x = _PercentRegionCount * 30;
				_bitmapData.copyPixels(GlobalVariables.instance.modelProgressBarUnit, GlobalVariables.instance.modelProgressBarUnit.rect, _tempPoint); 
				_PercentRegionCount++;
				
				//if (_10PercentRegionCount == 10) _bitmapData.fillRect(_bitmapData.rect, 0x66FFCC);
			}
		}
		
		// Update object
		public function update() : void {
			
			if (_PercentRegionCount < 10) {
				build(1);
			}
		}
		
		public function reset() : void {
			_PercentRegionCount = 0;
			_bitmapData.fillRect(_bitmapData.rect, 0x000000);
		}
		
		// set parent
		public function setParent(parRef:NewEmojiGameplay):void {
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
			
			_PercentRegionCount = 0;
			
			_bitmapData.fillRect(_bitmapData.rect, 0x000000);
			
			bitmapData = null;

			visible = false;
			
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
		
	}
	
}
