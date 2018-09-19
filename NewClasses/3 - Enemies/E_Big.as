package  {
	
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.GradientType;
	import flash.geom.ColorTransform;
	
	public class E_Big extends Sprite implements IPoolable, IGameObject {
		
		// private variables
		private var _destroyed : Boolean;
		private var _xSpeed : Number;
		private var _ySpeed : Number;
		private var _lifetime: int;
		private var _rotSpeed : int;
		private var _hitCount: int;
		private var _lastHit: String;
		private var _hitsTillDead: int;

		public var pVec:Vector.<IPoolable>;
		public var pRef:NewEmojiGameplay;
		
		private var _myColorTransform : ColorTransform;
		
		public var points : int;
		public var _destroyableByRegularLaser : Boolean = true;
		
		private var _body: Shape = new Shape();
		private var _bossBody: Shape = new Shape();
		
		private var _eyes: Shape = new Shape();
		private var _mouthCir : Shape = new Shape();
		private var _mask : Shape = new Shape();
		private var _teeth : Shape = new Shape();
		
		private var _hitFace : Shape = new Shape();
		
		private var _onHitActive : int;
		
		// Constructor
		public function E_Big() : void {
			
			_destroyed = true;
			
			//gradient body
			_body.graphics.beginGradientFill(GradientType.LINEAR, [0x4C32A1, 0xCD0055], [1,1], [0,255]);
			_body.graphics.drawCircle(0, 0, 100);
			_body.graphics.endFill();
			
			//pink body
			_bossBody.graphics.beginFill(0xFFB1F1);
			_bossBody.graphics.drawCircle(0, 0, 100);
			_bossBody.graphics.endFill();

			//left eye
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
			_mouthCir.graphics.beginFill(0x000000);
			_mouthCir.graphics.drawCircle(0,14.5,57);
			_mask.graphics.beginFill(0x000000);
			_mask.graphics.drawRect(-57,14.5,114,68);
			
			//white teeth
			_teeth.graphics.beginFill(0xFFFFFF);
			_teeth.graphics.moveTo(-50.5,21);
			_teeth.graphics.lineTo(50.5,21);
			_teeth.graphics.curveTo(50, 30, 46,36.5);
			_teeth.graphics.lineTo(-46, 36.5);
			_teeth.graphics.curveTo(-50,30, -50.5, 21);
			
			
			addChild(_body);
			
			addChild(_bossBody);
			_bossBody.visible = false;
			
			addChild(_eyes);
			addChild(_mouthCir);
			addChild(_mask);
			addChild(_teeth);
			
			_mouthCir.mask = _mask;
			
			
			// hit face
			
			_hitFace.graphics.beginFill(0x000000);
			_hitFace.graphics.drawEllipse(-50, 30, 100, 25);
			_hitFace.graphics.drawCircle(-40, -25, 12);
			_hitFace.graphics.drawCircle(44, -48, 22);
			_hitFace.graphics.endFill();
			
			_hitFace.graphics.beginFill(0xFFFFFF);
			_hitFace.graphics.drawCircle(44, -48, 12);
			_hitFace.graphics.drawCircle(-40, -25, 5);
			_hitFace.graphics.endFill();
			
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			points = 10;
			
			_onHitActive = -1;
			
			_myColorTransform = GlobalVariables.instance.colorTransform;
			_hitsTillDead = 3;
			
			///////////////////////////////////////////
			
			_xSpeed = int((2 - (Math.random() * 4)) * 10)/10;
			_ySpeed = int((4 + (Math.random() * 5)) * 10)/10;
			
			_hitCount = 0;
			
			//trace(_xSpeed, _ySpeed);
			
			scaleX = int(7 * (3 - (Math.random() * 1.5)))/10;
			scaleY = scaleX;
			
			_rotSpeed = 4 - (Math.random() * 9);
			
			x = int( Math.random() * ( 1334 - (width) ) ) + width/2;
			y = -height/2;
			
			if ( (x<400 && _xSpeed<-.25) || (x>934 && _xSpeed>.25) ) {
				_xSpeed *= -.5;
			}
			
			rotation += int(Math.random() * 360) + 1;
			
			//cacheAsBitmapMatrix = transform.concatenatedMatrix;
			//cacheAsBitmap = true;
		}
		
		
		// Update object
		public function update() : void {
			
			if (_onHitActive >= 0) _onHitActive --;
			if (_onHitActive == 0) deactivate();
			
			y += _ySpeed;
			x += _xSpeed;
			rotation += _rotSpeed;
			
			if (y > 750 + (width/2) || x > 1334 + (width * .5) || x < -width * .5) {
				pRef.removeChild(this);
				ObjectPool.instance.returnObj(this);
			}
		}
		
		// boss mode
		public function bossMode() : void {
			scaleX = 5;
			scaleY = 5;
			_bossBody.visible = true;
			y = -height/2;
			_ySpeed *= .66;
			_rotSpeed *= 1 + int(Math.random() * 5);
			_hitsTillDead = 9;
			
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
		
		public function onHitAndDead(thisLaser: *): Boolean { // returns false if still alive
			
			if (thisLaser is YinYangProj) return true;
			
			else if (_lastHit != thisLaser.name) {
				
				activate();
				
				_hitCount++;
				
				scaleX *= .66;
				scaleY = scaleX;
				
				if (y < -width/2) {
					y = -width/2;
				}

				if (_hitCount < _hitsTillDead) {
					_lastHit = thisLaser.name;
					return false;
				} else {
					return true;
				}
				
			} else {
				_lastHit = thisLaser.name;
				return false;
			}
		}
		
		
		// activate hit face
		
		public function activate() : void {
			
			GlobalSounds.instance.setSound(1);
			
			_onHitActive = 10;
			
			_eyes.visible = false;
			_mask.visible = false;
			_mouthCir.visible = false;
			_teeth.visible = false;
			
			addChild(_hitFace);
			//addChild(_eyesHitFace);
		}
		
		
		// deactivate hit face
		
		public function deactivate() : void {

			removeChild(_hitFace);
			//removeChild(_eyesHitFace);
			
			_eyes.visible = true;
			_mask.visible = true;
			_mouthCir.visible = true;
			_teeth.visible = true;
		}
		
		// Destroy object
		public function destroy() : void {
			
			
			if (_destroyed) {
				return;
			}
			
			if (_hitFace.parent) deactivate();
			
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
			_hitCount = null;
			_lastHit = null;
			
			//_body.scaleX = 1;
			//_body.scaleY = 1;
			
			_bossBody.visible = false;
			
			_onHitActive = null;
			
			scaleX = 1;
			scaleY = 1;
			
			//trace(width, height);
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
