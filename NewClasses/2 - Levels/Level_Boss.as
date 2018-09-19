package  {
	import flash.events.AccelerometerEvent;
	import flash.events.MouseEvent;
	
	public class Level_Boss implements ILevel, IPoolable {

		
		// variables
		private var _destroyed : Boolean;
		public var pRef;
		private var pVecEnemies : Vector.<IPoolable>;
		private var pVecItems : Vector.<IPoolable>;
		
		private var tickCount : int;
		public var logicCount : int;
		
		private var tempAvatar : Avatar;
		
		public var levelNumber : String = "???";
		
		public var BK : Boss_Kitty;
		
		// Constructor		
		public function Level_Boss() {
			
			_destroyed = true;
			
			renew();
			
		}
			
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			tickCount = 0;
			logicCount = 0;
		}
		
		public function update():void {

			tickCount++;
			
			/*
				(music fade)
				pause avatar
				move to bottom center
				(music change)
				enter boss
				boss animation
				boss start movement
				boss gameplay situations (1-12)
				destroy boss
				credits
				(fruit game?)
				portal
				infinte level
			*/
				
			//trace("Level : " + logicCount);
			

			// time buffer to get zod
			if (logicCount == 0) {
				
				if (tickCount > 120) logicCount++;
				
			}
			
			// level change logic
			else if (logicCount == 1) {

				tempAvatar = pRef.avatar;
				
				// pause avatar, shooting
				
				 
				if (GlobalSharedObject.instance.isTouchMode == false) pRef.acc.removeEventListener(AccelerometerEvent.UPDATE, pRef.onAccUpdate);
				pRef.removeEventListener(MouseEvent.MOUSE_DOWN, pRef.onClick);
				
				// pause item generation
				pRef._ticksPaused = true;
				
				// destroy situations
				pRef.destroyAllSituations();
				
				logicCount++;
				
				GlobalVariables.instance.shrinker(this, tempAvatar, 667, 667);
				
			} else if (logicCount == 2) {			
				
				// waiting for shrinker
				
			} else if (logicCount == 3) {		
				
				// add boss
				BK = ObjectPool.instance.getObj(Boss_Kitty) as Boss_Kitty;
				BK.pLevel = this;
				pRef.addGameObject(BK, pRef.enemies);
				pRef.setChildIndex(BK, pRef.numChildren - 2);
				logicCount++;
				
			} else if (logicCount == 4) {			
				
				// wait for boss intro
				
			} else if (logicCount == 5) {
				
				// add listeners
				if (GlobalSharedObject.instance.isTouchMode == false) pRef.acc.addEventListener(AccelerometerEvent.UPDATE, pRef.onAccUpdate);
				pRef.addEventListener(MouseEvent.MOUSE_DOWN, pRef.onClick);
				logicCount ++;
				pRef._ticksPaused = false;
				
			} else if (logicCount == 6) {
				
				// fighting boss
				
				if (BK.isMoving && pRef.situations.length == 0) {
					queueBossEnemies(BK.allZodRandom.currentFrame);
				}
				
			}
			
		}
		
		// queue boss enemies
		public function queueBossEnemies(zod : int) : void {
			
			var tempRef;
			
			if (zod == 1) {
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Basic, 1, 1 + int(Math.random() * 2), 25);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Basic, 2, 44 + int(Math.random() * 8), 100);
				
			} else if (zod == 2) {
				
				//BK._xSpeed = 15 + (Math.random() * 10);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Big, 2 + int(Math.random() * 4), 1, 1);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Big, 2, 66, 300);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Big, 5, 300, 300);
				
			} else if (zod == 3) {
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Angry, 2, 1, 1);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Angry, 3, 30 + int(Math.random() * 20), 50);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Angry, 1 + int(Math.random() * 3), 100, 100);
				
			} else if (zod == 4) {
				
				//BK._rotSpeed = -5 + int(Math.random() * 10);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Loopy, 1, 6 + int(Math.random() * 5), 30);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Loopy, 1, 53, 400);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Loopy, 1, 47, 400);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Loopy, 5, 200, 400);
				
			} else if (zod == 5) {
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Robot, 3, 50, 150);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Dollar, 1, 1, 1);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Dollar, 1, 200, 300);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_GustLady, 1 + int(Math.random() * 2), 123, 300);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Robot, 1, 78, 300);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Robot, 1 + int(Math.random() * 2), 143, 300);
				
			} else if (zod == 6) {
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Baddie, 2, 1, 1);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Baddie, 1, 67, 150);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Luvvies, 1 + int(Math.random() * 2), 27, 150);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_RobotHorizontal, 2, 66, 200);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_RobotHorizontal, 1, 143, 150);

			} else if (zod == 7) {
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Basic, 1 + int(Math.random() * 1), 1 + int(Math.random() * 2), 15);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Basic, 2, 33, 100);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Basic, 4, 99, 100);
				
			} else if (zod == 8) {
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Big, 5 + int(Math.random() * 10), 1, 1);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Big, 2, 50, 50);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Big, 5, 100, 125);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Big, 2, 175, 175);
				
			} else if (zod == 9) {
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Angry, 2, 10, 20);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Angry, 2, 50, 100);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Angry, 4, 300, 300);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Luvvies, 2 + int(Math.random() * 2), 1, 1);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Luvvies, 1, 25, 100);
				
			} else if (zod == 10) {
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Loopy, 1, 6, 30);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Loopy, 1, 33, 400);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_ShrinkFace, 1, 37, 400);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Loopy, 2, 200, 400);
				
			} else if (zod == 11) {
				
				if (Math.random() < .5) {
					tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
					tempRef.setup(pRef, E_Robot, 2, 66, 200);
				} else {
					tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
					tempRef.setup(pRef, E_RobotHorizontal, 2, 66, 250);
				}
				
				if (Math.random() < .5) {
					tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
					tempRef.setup(pRef, E_Robot, 1, 144, 300);
				} else {
					tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
					tempRef.setup(pRef, E_RobotHorizontal, 1, 144, 300);
				}
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Luvvies, 1, 45, 200);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Luvvies, 2, 1, 1);
				
			} else if (zod == 12) {
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Dollar, 1, 1, 1);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Dollar, 1, 66 + int(Math.random() * 100), 300);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Baddie, 2, 1, 1);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_Baddie, 1, 81, 300);
				
				tempRef = ObjectPool.instance.getObj(BossSituation) as BossSituation;
				tempRef.setup(pRef, E_GustLady, 1 + int(Math.random() * 2), 123, 300);
				
			}
		}
		
		// done w shrinker
		public function doneShrinking() : void {
			logicCount++;
		}
			
		// drop AllZod object
		public function dropZod() : void {
			var tempRef = ObjectPool.instance.getObj(AllZod) as AllZod;
			tempRef.setWhich(levelNumber);
			tempRef.setVector(pVecItems);
			tempRef.setParent(pRef);
			
			pVecItems.push(tempRef);
			pRef.addChild(tempRef);
		}
		
		// set parent
		public function setParent(parRef:NewEmojiGameplay):void {
			pRef = parRef;
			pVecEnemies = pRef.enemies;
			pVecItems = pRef.items;
		}

		public function changeLevels() : void {
			
			pRef.bossDestroyAllEnemies();
			pRef.destroyAllSituations();
			
			pRef._ticksPaused = true;
			
			var tempBossDestroy : Boss_Kitty_Destroy = ObjectPool.instance.getObj(Boss_Kitty_Destroy) as Boss_Kitty_Destroy;
			tempBossDestroy.setParent(pRef);
			tempBossDestroy.x = BK.x;
			tempBossDestroy.y = BK.y;
			
			pRef.removeChild(BK);
			ObjectPool.instance.returnObj(BK);
			
			pRef.currentLevel = ObjectPool.instance.getObj(Level_Finale) as Level_Finale;
			pRef.currentLevel.setParent(pRef);
			
			pRef.addChild(tempBossDestroy);
			tempBossDestroy.play();
			
			ObjectPool.instance.returnObj(this);
		}
		
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			_destroyed = true;
			
			pVecEnemies = null;
			pVecItems = null;
			
			tempAvatar = null;
			
			pRef = null;
		}
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
