package  {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.sampler.Sample;
	
	
	public class Boss_Kitty extends MovieClip implements IPoolable, IGameObject {
		
		
		// variables
		private var _destroyed : Boolean;
		public var _xSpeed : Number;
		public var _ySpeed : Number;
		public var _rotSpeed : int;

		private var _ticks : int;
		public var _logicTicks : int;
		private var _logicTimer : int;
		

		public var pVec:Vector.<IPoolable>;
		public var pRef:NewEmojiGameplay;
		public var pLevel : Level_Boss;
		
		public var points : int;
		public var health : int;
		private var _divBy : int;
		
		public var nextZodiacChange : int;
		
		public var framePointer : int;
		public var currentState : int;
		
		public var xBand : Number;	// -400 - 400
		public var yBand : Number;	// 0 - 200
		
		public var xInc : Boolean;	// starts to left
		public var yInc : Boolean;	// starts moving down
		
		public var isPlayingAnimation : Boolean;
		public var isMoving : Boolean;
		public var endFrame : int;
		public var resetFrame : int;
		
		public var onHitAnimationBuffer : int;
		
		public var allZodRandom : AllZodRandom;
		
		public var _destroyableByRegularLaser : Boolean;
		public var _invincible : Boolean;
		
		public var isChoosingNewZod : Boolean;
				
		public function Boss_Kitty() : void {
			
			_destroyed = true;
			
			stop();
			
			renew();
		}
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			visible = true;
			
			_destroyed = false;
			
			isChoosingNewZod = true;
			
			_logicTicks = 0;
			
			points = 10000;
			health = 300;
			_divBy = health / 3;
			
			_xSpeed = 8;
			_ySpeed = 1;
			_rotSpeed = 0;
			
			refresh();
			
			x = 667;
			y = -width/2;
			
			///////////////////////////////////////////
			
		}
		
		// refresh
		public function refresh(newZod : Boolean = true) : void {
			
			gotoAndStop(1);
			
			_ticks = 0;
			
			//trace("====****++++ " + health, _divBy, nextZodiacChange);
			
			if (newZod) {
				_logicTimer = 0;
				nextZodiacChange = health - _divBy;
				//trace("==== " +nextZodiacChange);
			}
			
			
			framePointer = 1;
			currentState = 1;
			
			xBand = 0;
			yBand = 0;
			
			xInc = Boolean(Math.random());
			yInc = Boolean(Math.random());
			
			isPlayingAnimation = false;
			isMoving = false;
			endFrame = 1;
			resetFrame = 1;
			
			onHitAnimationBuffer = 0;
			
			_destroyableByRegularLaser = false;
		}
		
		
		// Update object
		public function update() : void {
			
			
			_ticks ++;
			
			//rotation += _rotSpeed;
			
			
			// logic timer check
			if (_logicTimer > 0) {
				_logicTimer--;
				if (_logicTimer == 0) {
					_logicTicks++;
				}
			}
			
			
			// animation check
			if (isPlayingAnimation) {
				if (currentFrame < endFrame) {
					gotoAndStop(currentFrame + 1);
				} else {
					isPlayingAnimation = false;
					gotoAndStop(resetFrame);
				}
			}
			
			
			// movement check
			if (isMoving) {
				
				if (xInc) {
					x += _xSpeed;
				} else {
					x -= _xSpeed;
				}
				
				if (yInc) {
					y += _ySpeed;
				} else {
					y -= _ySpeed;
				}
				
				if (x > 1337 - (width/2)) {
					xInc = false;
				} else if (x < width/2) {
					xInc = true;
				}
				
				if (y > 250 + (height/2)) {
					yInc = false;
				} else if (y < height/2) {
					yInc = true;
				}
				
			}
			
			
			// health check
			if (health <= 0) {
				onDestruction();
				return;
				
			} else if (health <= nextZodiacChange) {
				
				_xSpeed = 8;
				_ySpeed = 1;
				
				gotoAndStop(5);
				setChildIndex(allZodRandom, numChildren - 1);
				resetBoss();
				var e : Explosion = ObjectPool.instance.getObj(Explosion) as Explosion;
				e.setParent(pRef, x, y, allZodRandom.width / 50);
				pRef.addChild(e);
				e.explode();
			}
			
			
			// on hit action check
			if (onHitAnimationBuffer > 0) {
				
				if (onHitAnimationBuffer % 2 == 0) x += 30;
				else x -= 30;
				
				onHitAnimationBuffer--;
				
				if (onHitAnimationBuffer == 0) {
					gotoAndStop(1);
				}
			}
			
			//trace("\n" + health + " / " + nextZodiacChange);
			//trace("Boss : " + _logicTicks);
			
			// logic check
			if (_logicTicks == 0) {
				
				// add all zod
				allZodRandom = ObjectPool.instance.getObj(AllZodRandom) as AllZodRandom;
				addChild(allZodRandom);
				allZodRandom.x = 0;
				allZodRandom.y = -70;
				setChildIndex(allZodRandom, numChildren - 1);
				allZodRandom.visible = false;
				
				_logicTicks ++;
			
			} else if (_logicTicks == 1) {
				
				if (y < (height/2)) {
					y += 5;
				} else {
					animationStartFight();
					_logicTicks++;
				}
				
 			} else if (_logicTicks == 2) {
				
				// wait for logic timer (animation Intro)

			} else if (_logicTicks == 3) {

				gotoAndStop(1);
				isMoving = true;
				_destroyableByRegularLaser = true;
				_logicTicks++;
				pLevel.logicCount++;
				
			} else if (_logicTicks == 4) {
				
				// movement
				
			} else if (_logicTicks == 5) {
				
				// recovery
				isMoving = true;
				_logicTicks = 4;
				_destroyableByRegularLaser = true;
				pLevel.pRef.addEventListener(MouseEvent.MOUSE_DOWN, pLevel.pRef.onClick);
				pRef._ticksPaused = false;
			}
			
			
			/*else if (_logicTicks == 2) {
				
			} else if (_logicTicks == 2) {
				
			} else if (_logicTicks == 2) {
				
			}*/

		}
		
		// onHit
		
		public function onHit(hitObj : *) : void {
			
			if (_destroyableByRegularLaser) {
				
				if (hitObj is YinYangProj) {
					health -= 10;
				} else {
					health --;
				}
				
				
				//trace(hitObj.width, health);
				
				if (health > 0) {
					onHitAnimationBuffer = 10;
					gotoAndStop(4);
					setChildIndex(allZodRandom, numChildren - 1);
					GlobalSounds.instance.ouch();
				}
			}
			
			if (!(hitObj is YinYangProj)) {
				hitObj.parent.removeChild(hitObj);
				ObjectPool.instance.returnObj(hitObj);
			}
		}
		
		// reset boss
		
		public function resetBoss(chooseNewZod : Boolean = true) {
			
			pRef.bossDestroyAllEnemies();
			pRef.destroyAllSituations();
			
			pRef._ticksPaused = true;
			
			_rotSpeed = 0;
			rotation = 0;
			
			// sad face, shrink, choose new zodiac
			pLevel.pRef.removeEventListener(MouseEvent.MOUSE_DOWN, pLevel.pRef.onClick);
			_destroyableByRegularLaser = false;
			
			refresh(chooseNewZod);
			
			isChoosingNewZod = chooseNewZod;
			
			GlobalVariables.instance.shrinker(this, this, 667, height/2);
		}
		
		// onDestruction
		
		public function onDestruction() : void {
			pLevel.changeLevels();
		}
		
		// ANIMATIONS
		
		public function animationStartFight() : void {
			gotoAndStop(6);
			setChildIndex(allZodRandom, numChildren - 1);
			_logicTimer = 50;
			
			//trace(isChoosingNewZod);
			if (isChoosingNewZod) {
				allZodRandom.visible = true;
				allZodRandom.startRandomChoice();
			}
		}
		
		
		public function doneShrinking() : void {
			animationStartFight();
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
			
			gotoAndStop(1);
			
			pRef = null;
			pLevel = null;
			
			_destroyed = true;
			_xSpeed = null;
			_ySpeed = null;
			_ticks = null;
			_logicTicks = null;
			_logicTimer = null;
			_divBy = null;
			points = null;
			health = null;
			
			nextZodiacChange = null;
			
			framePointer = null;
			currentState = null;
			
			xBand = null;
			yBand = null;
			
			xInc = null;
			yInc = null;
			
			isPlayingAnimation = null;
			isMoving = null;
			endFrame = null;
			resetFrame = null;
			
			isChoosingNewZod = null;
			
			onHitAnimationBuffer = null;
			
			allZodRandom = null;
			
			visible = false;
			
			scaleX = 1;
			scaleY = 1;
			
			//height = 45;
			//width = 45;
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
}
