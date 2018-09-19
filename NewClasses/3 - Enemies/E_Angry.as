package  {
	
	// Blue Squares Fall from Top
	
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.GradientType;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	
	public class E_Angry extends Sprite implements IPoolable, IGameObject {
		
		// private variables
		private var _destroyed : Boolean;
		private var _xSpeed : Number;
		private var _ySpeed : Number;
		private var _lifetime: int;
		private var _rotSpeed : int;
		
		private var _stateCounter : int = 0;
		
		private var _myColorTransform : ColorTransform;
		private var _body : Shape;

		public var pVec:Vector.<IPoolable>;
		public var pRef:NewEmojiGameplay;
		
		public var points : int;
		public var _destroyableByRegularLaser : Boolean = true;
		
		private var colorA : uint;
		private var colorB : uint;
		
		
		
		// Constructor
		public function E_Angry() : void {
			
			_destroyed = true;
			
			_myColorTransform = GlobalVariables.instance.colorTransform;
			
			//Body Color 1
			_body = new Shape();
			_body.graphics.beginFill(colorA);
			_body.graphics.drawCircle(0, 0, 30);
			_body.graphics.endFill();
			
			//Eyes
			var _eyes: Shape = new Shape();
			_eyes.graphics.beginFill(0xFFFFFF);
			_eyes.graphics.drawCircle(-12.85,-4.25,8.5);
			_eyes.graphics.drawCircle(12.85,-4.25,8.5);
			_eyes.graphics.endFill();
			
			_eyes.graphics.beginFill(0x000000);
			_eyes.graphics.drawCircle(-12.85,-4.25,6.5);
			_eyes.graphics.drawCircle(12.85,-4.25,6.5);
			_eyes.graphics.endFill();
			
			//Eye mask
			var _mask: Shape = new Shape();
			_mask.graphics.beginFill(0x123456);
			_mask.graphics.moveTo(-22.3,-7.55);
			_mask.graphics.curveTo(-12.65, -5.4, -4.45, .8);
			_mask.graphics.lineTo(-10,6.5);
			_mask.graphics.lineTo(-23,2.75);
			_mask.graphics.lineTo(-22.3,-7.55);
			_body.graphics.endFill();
			
			_mask.graphics.beginFill(0x123456);
			_mask.graphics.moveTo(22.3,-7.55);
			_mask.graphics.curveTo(12.65, -5.4, 4.45, .8);
			_mask.graphics.lineTo(10,6.5);
			_mask.graphics.lineTo(23,2.75);
			_mask.graphics.lineTo(22.3,-7.55);
			_mask.graphics.endFill();
			
			
			//Brow
			var _brow: Shape = new Shape();
			_brow.graphics.beginFill(0x000000);
			_brow.graphics.moveTo(-22.3,-7.55);
			_brow.graphics.curveTo(-10, -10, -4.45, .8);
			_brow.graphics.curveTo(-12.65, -5.4,-22.3,-7.55);
			
			_brow.graphics.moveTo(22.3,-7.55);
			_brow.graphics.curveTo(10, -10, 4.45, .8);
			_brow.graphics.curveTo(12.65, -5.4, 22.3,-7.55);
			_body.graphics.endFill();
			
			
			//Mouth
			var _mouth: Shape = new Shape();
			_mouth.graphics.beginFill(0x000000);
			_mouth.graphics.moveTo(-11,16);
			_mouth.graphics.curveTo(0,4,11,16);
			_mouth.graphics.curveTo(0,10,-11,16);
			_mouth.graphics.endFill();
			
			//State 1 & 2
			addChild(_body);
			addChild(_eyes);
			addChild(_mask);
			_eyes.mask = _mask;
			addChild(_brow);
			addChild(_mouth);
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			points = 5;
			
			colorA = 0xcf0c36;
			colorB = 0x66001f;
			
			_destroyableByRegularLaser = true;
			
			///////////////////////////////////////////
			
			scaleX = int(11 - (Math.random() * 3)) /10;
			scaleY = scaleX;
			
			_xSpeed = 10 - (int(50 * Math.random())/10);
			_ySpeed = 0;
			
			if (Math.random() < .5) {
				x = -width/2 + 1; 
			} else {
				x = 1334 + (width/2) - 1;
				_xSpeed *= -1;
			}
			
			y = int( Math.random() * ( 750 - (width) ) ) + width/2;
			
			
			rotation += int(Math.random() * 360) + 1;
		}
		
		
		// Update object
		public function update() : void {
			
			x += _xSpeed;
			y += _ySpeed;
			
			if (pRef.avatar.y < y) {
				_ySpeed -= .07;
			} else {
				_ySpeed += .07;
			}
			
			if (_stateCounter % 8 == 0) {
				if (_stateCounter % 16 != 0) {
					_myColorTransform.color = colorB;
					_body.transform.colorTransform = _myColorTransform;
				} else {
					_myColorTransform.color = colorA;
					_body.transform.colorTransform = _myColorTransform;
				}
			}
			
			_stateCounter++;
			
			if (y > 750 + (width * .5) || y < -width * .5 || x > 1334 + (width * .5) || x < -width * .5) {
				pRef.removeChild(this);
				ObjectPool.instance.returnObj(this);
			}
		}
		
		// boss mode
		public function bossMode() : void {
			
			if (Math.random() < .33) {
				_xSpeed /= 2;
				scaleX = .75;
				scaleY = .75;
				colorA = 0x5b4848;
				colorB = 0x352A2A;
				_destroyableByRegularLaser = false;
			}
				
			if (Math.random() < .5) pRef.setChildIndex(this, pRef.getChildIndex(pRef.currentLevel.BK) - 1);
			
		}
		
		
		// set vector
		public function setVector(parentVector : Vector.<IPoolable>) : void {
			pVec = parentVector;
		}
		
		
		// set parent
		public function setParent(parRef:NewEmojiGameplay):void {
			pRef = parRef;
		}
		
		
		// Destroy object
		public function destroy() : void {
			
			
			if (_destroyed) {
				return;
			}
			
			if (pVec) {

				var len : int = pVec.length - 1;
				var index : int = pVec.indexOf(this);
				
				pVec[index] = pVec[len];
				pVec.length = len;
				
				pVec = null;
			}
			
			pRef = null;
			
			_destroyed = true;
			_xSpeed = null;
			_ySpeed = null;
			_lifetime = null;
			_rotSpeed = null;
			points = null;
			
			scaleX = 1;
			scaleY = 1;
			
			_stateCounter = 0;
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
