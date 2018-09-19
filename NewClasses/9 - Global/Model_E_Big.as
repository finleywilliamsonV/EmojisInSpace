package  {
	
	// Blue Squares Fall from Top
	
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.GradientType;
	
	public class Model_E_Big extends Sprite {
		
		// Constructor
		public function Model_E_Big() : void {
			
			//pink
			graphics.beginGradientFill(GradientType.LINEAR, [0x4C32A1, 0xCD0055], [1,1], [0,255]);
			//body.graphics.beginFill(0x00FF00);
			graphics.drawCircle(0, 0, 100);
			rotation += 45;

			//left eye
			var _eyes: Shape = new Shape();
			_eyes.graphics.beginFill(0x000000);
			_eyes.graphics.moveTo(-68.5, -20.75);
			_eyes.graphics.curveTo(-41.75, -45, -15, -20.75);
			_eyes.graphics.lineTo(-18.25, -17);
			_eyes.graphics.curveTo(-41.75, -37, -65, -17);
			_eyes.graphics.lineTo(-68.5, -20.75);

			//right eye
			_eyes.graphics.moveTo(68.5, -20.75);
			_eyes.graphics.curveTo(41.75, -45, 15, -20.75);
			_eyes.graphics.lineTo(18.25, -17);
			_eyes.graphics.curveTo(41.75, -37, 65, -17);
			_eyes.graphics.lineTo(68.5, -20.75);
			
			//black mouth
			var _mouthCir : Shape = new Shape();
			_mouthCir.graphics.beginFill(0x000000);
			_mouthCir.graphics.drawCircle(0,14.5,57);
			var _mask : Shape = new Shape();
			_mask.graphics.beginFill(0x000000);
			_mask.graphics.drawRect(-57,14.5,114,68);
			
			//white teeth
			var _teeth : Shape = new Shape();
			_teeth.graphics.beginFill(0xFFFFFF);
			_teeth.graphics.moveTo(-50.5,21);
			_teeth.graphics.lineTo(50.5,21);
			_teeth.graphics.curveTo(50, 30, 46,36.5);
			_teeth.graphics.lineTo(-46, 36.5);
			_teeth.graphics.curveTo(-50,30, -50.5, 21);
			
			
			addChild(_eyes);
			addChild(_mouthCir);
			addChild(_mask);
			addChild(_teeth);
			
			_mouthCir.mask = _mask;
		}
		
	}
}
