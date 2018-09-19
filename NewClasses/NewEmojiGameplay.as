package  {
		
	
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.display.DisplayObject;
	
	import flash.sensors.Accelerometer;
	import flash.events.AccelerometerEvent;
	import flash.display.MovieClip;
	
	public class NewEmojiGameplay extends Sprite implements IPoolable {
		
		private var _destroyed: Boolean;
		
		public var pRef : NewDocumentClass;
		
		private var blackSpace : Sprite = new Sprite();
		public var avatar : Avatar;
		
		private var _lives : int;
		
		public var timer : Timer;
		public var _ticks : int;
		
		private var _ticksPerFruitDrop : int;
		private var _ticksPerItemDrop: int;
		private var _ticksPerHeartDrop: int;
		private var _ticksPerSmartBombDrop: int;
		private var _ticksPerLaserUpgradeDrop: int;
		
		
		private var _ticksPerShieldDrop: int;
		
		public var _sideDiamondRate : Number;
		public var _backDiamondRate : Number;
		public var _laserUpgradeRate : Number;

		public var currentLevel;
		
		public var currentScore : int;
		
		public var enemies : Vector.<IPoolable>;
		public var shots : Vector.<IPoolable>;
		public var items : Vector.<IPoolable>;
		public var situations : Vector.<IPoolable>;
		
		private var previousCount : int;
		
		public var laserUpgradeCount : int;
		public var sideLaserCount : int;
		public var backLaserCount : int;
		
		public var _isPaused : Boolean;
		private var _genPaused : Boolean;
		public var _ticksPaused : Boolean;
		
		private var backgroundStars : BackgroundStars;
		private var backgroundBigStars : BackgroundBigStars;
		
		public var acc : Accelerometer;
		private var accX : int;
		private var accY : int;
		
		private var scoreText : ScoreText;
		private var laserLevelDisplay : LaserLevelDisplay;
		private var sideLaserDisplay : SideLaserDisplay;
		private var backLaserDisplay : BackLaserDisplay;
		
		private var _primaryLaserClass : Class;
		private var _primaryLaserRate : int;		// in ticks
		private var _primaryLaserScale : Number;
		
		public var livesContainer : LivesContainer;
		
		private var _isUnlocked_1UpDrops : Boolean;
		private var _isUnlocked_SideLaser : Boolean;
		private var _isUnlocked_BackLaser : Boolean;
		private var _isUnlocked_SmartBombs : Boolean;
		
		public var sharedObject_infAmmoSelected : Boolean;
		public var sharedObject_infLivesSelected : Boolean;
		public var sharedObject_currentLevelSelected : int;
		
		
		private var _laserLevel : int;
		
		public var _diedThisRound : Boolean;
		
		public var _isTouchMode : Boolean;
		public var _isReadyToShoot : Boolean;
		public var _isMousePressed : Boolean;
		public var _shotTimer : int;
		
		private var _currentSoundPosition : int;
		
		// NewEmojiGameplay Constructor
		
		
		public function NewEmojiGameplay() {
			
			_destroyed = true;
			
			renew();
		}
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			
			
			_ticks = 0;
			
			_ticksPerFruitDrop = 50 + (Math.random() * 300);
			_ticksPerItemDrop = 300 + (Math.random() * 500);
			_ticksPerHeartDrop = 1500 + (Math.random() * 1500);
			_ticksPerSmartBombDrop = 650 + (Math.random() * 400);
			_ticksPerLaserUpgradeDrop = 200 + (Math.random() * 2000);			
			_ticksPerShieldDrop = 1000 + (Math.random() * 1000);
			

			
			//		IDEA : separate item drops?
			//
			//			level 1 : fruit
			//  		level 2 : back and side lasers
			//  		level 3 : laser upgrade, shield
			//  		level 4 : 1-Up
			
			
			_backDiamondRate = .45;
			_sideDiamondRate = .55;
			
			currentScore = 0;
			_isPaused = false;
			_genPaused = false;
			_ticksPaused = false;
			laserUpgradeCount = 0;
			
			
			
			
			
			previousCount = 0;
			
			_laserLevel = 1;
			
			_diedThisRound = false;
			
			
			_currentSoundPosition = 0;
			
			
			// Primary Laser
			//GlobalVariables.instance.currentPrimaryLaser = LaserBall_v2Cluster;
			//GlobalVariables.instance.currentPrimaryLaser = LaserBall;
		
			// add black rectangle sprite for space background
			blackSpace.graphics.beginFill(0,1);
			blackSpace.graphics.drawRect(0, 0, 1334, 750);
			blackSpace.graphics.endFill();
			addChild(blackSpace);
			setChildIndex(blackSpace, 0);
			
			
			//add small stars
			backgroundStars = ObjectPool.instance.getObj(BackgroundStars) as BackgroundStars;
			addChild(backgroundStars);
			setChildIndex(backgroundStars, 1);
			
			//add big stars
			backgroundBigStars = ObjectPool.instance.getObj(BackgroundBigStars) as BackgroundBigStars;
			addChild(backgroundBigStars);
			setChildIndex(backgroundBigStars, 1);
			
			
			// add sprite for avatar
			avatar = ObjectPool.instance.getObj(Avatar) as Avatar;
			avatar.x = 667;
			avatar.y = 667;
			addChild(avatar);
			
			
			// add timer for movement
			timer = GlobalVariables.instance.gameTimer2;
			
			
			
			enemies = new Vector.<IPoolable>();
			shots = new Vector.<IPoolable>();
			items = new Vector.<IPoolable>();
			situations = new Vector.<IPoolable>();
			
			
			//currentLevel = ObjectPool.instance.getObj(Level_Boss) as Level_Boss;
			//currentLevel.setParent(this);integerToNextLevel(sharedObject_currentLevelSelected);
			
			
			
			scoreText = ObjectPool.instance.getObj(ScoreText) as ScoreText;
			addChild(scoreText);
			
			laserLevelDisplay = ObjectPool.instance.getObj(LaserLevelDisplay) as LaserLevelDisplay;
			addChild(laserLevelDisplay);
			
			sideLaserDisplay = ObjectPool.instance.getObj(SideLaserDisplay) as SideLaserDisplay;
			addChild(sideLaserDisplay);
			
			
			backLaserDisplay = ObjectPool.instance.getObj(BackLaserDisplay) as BackLaserDisplay;
			addChild(backLaserDisplay);
			
			
			//progressBar_Laser = ObjectPool.instance.getObj(ProgressBar_Laser) as ProgressBar_Laser;
			//progressBar_Laser.x = 150;
			//progressBar_Laser.y = 700;
			//addChild(progressBar_Laser);
			
			livesContainer = ObjectPool.instance.getObj(LivesContainer) as LivesContainer;
			addChild(livesContainer);
			
			addEventListener(Event.ADDED_TO_STAGE, startGame);
		}
		
		
		// onTick Function
		
		public function onTick( te : TimerEvent ) : void {
			
			if (! _ticksPaused) _ticks++;
			
			
			if (_isTouchMode) {
				
				avatar.x = mouseX;	avatar.y = mouseY;		// find it
				
				trace(_shotTimer);
				
				if (_shotTimer > 0) {
					_shotTimer --;
					
					if (_shotTimer == 0) {
						_isReadyToShoot = true;
					}
				} else {
					
					if (_isMousePressed && _isReadyToShoot) {
						fireLasers();
						_isReadyToShoot = false;
						_shotTimer = _primaryLaserClass._shotRate * 1.5;
					}
				}
			}
			
			
			// check for bgm
			
			//if (GlobalSounds.instance.bgmSoundChannel.position == _currentSoundPosition) {
			//	GlobalSounds.instance.playBGM();
			//}
				
			//_currentSoundPosition = GlobalSounds.instance.bgmSoundChannel.position;
			
			// Update All
			// eventually switch with updates for each vector, will be faster in long run
			// Phantom index out of bounds ???
			for (var k : int = numChildren - 1; k >= 0 ; k--) {
				
				//trace("k: " + k + ", numChildren: " + numChildren);
				
				tempObj = getChildAt(k);
				
				if (tempObj is IPoolable) {
					tempObj.update();
				}
			}
			
			
			if (! _genPaused) currentLevel.update();
			
			for (var s : int = situations.length - 1; s >= 0; s--) {
				situations[s].update();
			}
			
			
			// drop items
			
			if (! _ticksPaused) {
				
				_ticksPerFruitDrop--;
				if (_ticksPerFruitDrop <= 0) dropFruit();
				
				_ticksPerItemDrop--;
				if (_ticksPerItemDrop <= 0) dropItems();
				
				_ticksPerHeartDrop--;
				if (_ticksPerHeartDrop <= 0 && _isUnlocked_1UpDrops) drop1Up();
				
				_ticksPerSmartBombDrop--;
				if (_ticksPerSmartBombDrop <= 0 && _isUnlocked_SmartBombs) dropSmartBomb();
				
				_ticksPerShieldDrop--;
				if (_ticksPerShieldDrop <= 0) dropShield();
				
				_ticksPerLaserUpgradeDrop--;
				if (_ticksPerLaserUpgradeDrop <= 0) dropLaserUpgrade();
			}
			
			
			var tempObj;
			var tempShot;
			
			
				
			// CHECK ITEMS
			for (var h : int = items.length - 1; h >= 0 ; h--) {
				//trace("h: " + h + "----" + items.length);
				tempObj = items[h];
				
				if (tempObj.hitTestObject(avatar)) {
					if (PixelPerfectCollisionDetection.isColliding(tempObj, avatar, this, true)) {
						
						if (tempObj is PortalCrystal) {
							currentLevel.collectCrystal();
							
						} else if (tempObj is LDiamondSide) {
							sideLaserCount += 20;
							sideLaserDisplay.modifyNum(20);
							
						} else if (tempObj is LDiamondBack) {
							backLaserCount += 20;
							backLaserDisplay.modifyNum(20);
							
						} else if (tempObj is AllZod) {
							GlobalSharedObject.instance.recordNewZodiac(tempObj._currentZodShowing);
							addPoints(tempObj.points);
							
						} else if (tempObj is Item1Up) {
							
							if (_lives < GlobalSharedObject.instance.maxLives) {
								livesContainer.addHeart();
								_lives ++;
							}
							addPoints(tempObj.points);
							
						} else if (tempObj is SmartBomb) {
							
							tempObj.explode();
							
						} else if (tempObj is ShieldContainer) {
							
							var tempShield = ObjectPool.instance.getObj(Shield) as Shield;
			
							addGameObject(tempShield, shots);
							
						} else if (tempObj is LaserUpgrade) {
							
							levelUpLaser();
							
						} else {
							addPoints(tempObj.points);
						}

						GlobalSounds.instance.setSound(4 + (Math.random() * 3));
						
						removeChild(tempObj);
						ObjectPool.instance.returnObj(tempObj);
					}
				}
				
			} // end item check
			
			// CHECK FOR ENEMIES
			for (var i : int = enemies.length - 1; i >= 0 ; i--) {
				
				tempObj = enemies[i];
				
				if (!avatar._isHit) {
					
					if (tempObj.hitTestObject(avatar)) {
						if (PixelPerfectCollisionDetection.isColliding(tempObj, avatar, this, true)) {
							
							if (!(tempObj is Gust || tempObj is BossGust)) {
								
								if (avatar._isShielded == false) {
									
									GlobalSounds.instance.setSound(3);
									
									_primaryLaserClass = GlobalVariables.instance.currentPrimaryLaser;
									_laserLevel = 1;
									laserLevelDisplay.setDisplay(_laserLevel);
									
									//avatar.x = 667;
									//avatar.y = 667;
									
									//GlobalVariables.instance.shrinker(this, avatar, 667, 667);
									
									
									if (sharedObject_infLivesSelected == false) {
										_lives --;
										livesContainer.subHeart();
									}
									
									
									if (_lives == 0) {
										pRef.EGtoGO();
										return;
									} else {
										avatar.onHit();
										_diedThisRound = true;
										previousCount = 0;
									}
									
									break;
								}
								
							} else {
								avatar.x -= tempObj._direction * 10;
							}
							
						}
					}
				}
				
				
				
				// CHECK FOR LASERS
				for (var j : int = shots.length - 1; j >= 0 ; j--) {
				
					tempShot = shots[j];
					
					if (!tempObj._destroyableByRegularLaser) {
						if (!tempShot._destroysLasers) {
							continue;
						}
					}
					
					if (tempObj is Gust) break;
					
					if (tempShot.hitTestObject(tempObj)) {
						if (PixelPerfectCollisionDetection.isColliding(tempShot, tempObj, this, true)) {
							
							if (tempObj is Boss_Kitty) {
								
								tempObj.onHit(tempShot);
								
							} else {
								
								if (tempObj is E_ShrinkFace || tempObj is E_Big) {
								
									if (!tempObj.onHitAndDead(tempShot)) {
										
										if (tempShot is Shield || tempShot is SideLaser) {
											removeChild(tempShot);
											ObjectPool.instance.returnObj(tempShot);
										}
										break;
									}
									
								} else if (tempObj is E_Luvvies) {
									if(currentLevel is Level_Boss) {
										launchBossHearts(tempObj);
									} else {
										launchHearts(tempObj);
									}
								}
								
								var tempInt : int = tempObj.points;
								
								if (tempInt > 0) {
									tempShot._comboCount++;
									tempInt *= tempShot._comboCount;
								}
								
								if (tempInt != 0) addPoints(tempInt);
								
								
								var tempExp = ObjectPool.instance.getObj(Explosion) as Explosion;
								tempExp.setParent(this, tempObj.x, tempObj.y, tempObj.width / 50);	// found it
								addChild(tempExp);
								tempExp.explode();
								
								if (tempShot is Shield || tempShot is SideLaser) {
									removeChild(tempShot);
									ObjectPool.instance.returnObj(tempShot);
								}
								
								removeChild(tempObj);
								ObjectPool.instance.returnObj(tempObj);
								break;	
							}
							
						}
					}
				}
				
			}
			
			GlobalSounds.instance.playAllSounds();
			
		} // end onTick()
		
		public function toggleClicks() : void {
			if( this.willTrigger(MouseEvent.MOUSE_DOWN) ) {
				removeEventListener(MouseEvent.MOUSE_DOWN, onClick);
			} else {
				addEventListener(MouseEvent.MOUSE_DOWN, onClick);
			}
		}
		
		// onClick Function
		
		public function onClick(mE : MouseEvent) : void {
			
			if (mE.stageX < 90 && mE.stageY < 120) {
				GlobalSounds.instance.click();
				toPauseScreen();
				return;
			}
			
			/*
			if (mE.target is EG_Button_Pause) {
				toPauseScreen();
				return;
			}
			*/
				
			if (_isTouchMode) {
				
				trace("Mouse Pressed");

				_isMousePressed = true;
				
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
				
			} else {
				
				if (timer.currentCount - previousCount > _primaryLaserRate || previousCount == 0) {
				
					previousCount = timer.currentCount;
					
					fireLasers();
					
				}
			}
			
		}
		
		public function onMouseUp( mE: MouseEvent) : void {

			trace("Mouse Up");
			
			_isMousePressed = false;

			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
		}
		
		
		private function fireLasers() : void {
			
			GlobalSounds.instance.setSound(0);
				
			var tempRef = ObjectPool.instance.getObj(_primaryLaserClass) as _primaryLaserClass;
			
			tempRef.scaleX = _primaryLaserScale;
			tempRef.scaleY = tempRef.scaleX;
			
			addGameObject(tempRef, shots);
			setChildIndex(tempRef, getChildIndex(avatar) - 1);

			shootBackLasers();
			
			shootSideLasers();
		}
		
		public function onAccUpdate(aE: AccelerometerEvent): void {
			
			//trace(aE);
			
			accX = aE.accelerationX * 42;
			accY = aE.accelerationY * 42;

			// Avatar Movement Boundries
			if (avatar.x <= 50) { //left bound
				avatar.x = 50;
				
				if (accX > 0) {
					accX = 0;
				}
				
			} else if (avatar.x >= 1284) { //right bound
				avatar.x = 1284;
				
				if (accX < 0) {
					accX = 0;
				}
			}

			if (avatar.y <= 40) { //top bound
				avatar.y = 40;
				
				if (accY < 0) {
					accY = 0;
				}
			} else if (avatar.y >= 710) { //bottom bound
				avatar.y = 710;
				
				if (accY > 0) {
					accY = 0;
				}
			}
			
			avatar.x -= accX;
			avatar.y += accY;

		}
		
		// set parent
		public function setParent(parRef:NewDocumentClass):void {
			pRef = parRef;
		}
		
		// to pause
		public function toPauseScreen() : void {
			pauseGame();
			removeEventListener(MouseEvent.MOUSE_DOWN, onClick);
			if(_isTouchMode == false) acc.removeEventListener(AccelerometerEvent.UPDATE, onAccUpdate);
			pRef.EGtoPS();
		}
		
		//return from pause
		public function returnFromPause() : void {
			unpauseGame();
			addEventListener(MouseEvent.MOUSE_DOWN, onClick);
			if(_isTouchMode == false) acc.addEventListener(AccelerometerEvent.UPDATE, onAccUpdate);
		}
		
		
		// integer to next level
		public function integerToNextLevel( newInt : int ) : void {

			var tempLevelObject : Class;
			
			if (newInt == 1) {
				tempLevelObject = Level_1;
				
			} else if (newInt == 1) {
				tempLevelObject = Level_1;
				
			} else if (newInt == 2) {
				tempLevelObject = Level_2;
				
			} else if (newInt == 3) {
				tempLevelObject = Level_3;
				
			} else if (newInt == 4) {
				tempLevelObject = Level_4;
				
			} else if (newInt == 5) {
				tempLevelObject = Level_5;
				
			} else if (newInt == 6) {
				tempLevelObject = Level_6;
				
			} else if (newInt == 7) {
				tempLevelObject = Level_7;
				
			} else if (newInt == 8) {
				tempLevelObject = Level_8;
				
			} else if (newInt == 9) {
				tempLevelObject = Level_9;
				
			} else if (newInt == 10) {
				tempLevelObject = Level_10;
				
			} else if (newInt == 11) {
				tempLevelObject = Level_11;
				
			} else if (newInt == 12) {
				tempLevelObject = Level_12;
				
			} else if (newInt == 13) {
				tempLevelObject = Level_Boss;
				
			} 
			
			nextLevel(ObjectPool.instance.getObj(tempLevelObject) as tempLevelObject);
		}
		
		
		
		// Queue next level
 		
		public function nextLevel( newLvl : * ) : void {
			
			_diedThisRound = false;
			
			if (currentLevel) {
				ObjectPool.instance.returnObj(currentLevel);
				currentLevel = null;
			}
			
			// transition w/ banner
			currentLevel = ObjectPool.instance.getObj(Level_Transition) as Level_Transition;
			currentLevel.setParent(this);
			currentLevel.setNextLevel(newLvl);
		}
		
		public function endLevelTransition( newLvl : ILevel ) : void {
			ObjectPool.instance.returnObj(currentLevel);
			currentLevel = null;
			
			currentLevel = newLvl;
			currentLevel.setParent(this);
		}
		
		// pause game
		
		public function pauseForTicks( numTicks : int ) : void {
			
			pauseGame();
		}
		
		public function pauseGame() : void {
			_isPaused = true;
			timer.stop();
			modAllMC(false);
		}
		
		public function unpauseGame() : void {
			_isPaused = false;
			timer.start();
			modAllMC(true);
		}
		
		public function modAllMC(tf : Boolean) : void {
			var tempObj;
			
			for (var k : int = numChildren - 1; k >= 0 ; k--) {
				tempObj = getChildAt(k);
				
				if (tempObj is MovieClip && tempObj is IGameObject && !(tempObj is Boss_Kitty) && !(tempObj is TutorialBanner)) {
					if (tf) tempObj.play();
					else tempObj.stop();
				}
				
			}
		}
		
		public function pauseGen() : void {
			_genPaused = true;
		}
		
		public function unpauseGen() : void {
			_genPaused = false;
		}

		public function startGame( e : Event ) : void {
			
			removeEventListener(Event.ADDED_TO_STAGE, startGame);
			
			// add listener for timer
			timer.addEventListener(TimerEvent.TIMER, onTick);
			
			// add listener for clicks
			addEventListener(MouseEvent.MOUSE_DOWN, onClick);
			
			//avatar.x = 200;
			//avatar.y = 200;
			
			// mouse?
			
			//addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			//addEventListener(MouseEvent.MOUSE_UP, onUp);

			timer.start();
			e.stopPropagation();
			
			//GlobalSharedObject.instance.modifyBothScoreCounts(25000);
			
			_lives = GlobalSharedObject.instance.maxLives;
			
			
			
			// find touch	
			
			_isTouchMode = GlobalSharedObject.instance.isTouchMode;
			_isReadyToShoot = false;
			_isMousePressed = false;
			
			trace("FROM GAMEPLAY: isTouchMode = " + GlobalSharedObject.instance.isTouchMode)
			
			if(_isTouchMode == false) {
				
				trace("acc created");
				
				// add accelerometer
				acc = new Accelerometer();
				acc.setRequestedUpdateInterval(18);
				
				// add listener for acc
				acc.addEventListener(AccelerometerEvent.UPDATE, onAccUpdate);
			}
			
			
			_primaryLaserClass = GlobalVariables.instance.currentPrimaryLaser;
			_primaryLaserRate = _primaryLaserClass._shotRate;
			_primaryLaserScale = GlobalSharedObject.instance.laserScale;
			
			_shotTimer = 1;
			trace(_shotTimer);
			
			//trace(_primaryLaserScale);
			
			_isUnlocked_1UpDrops = GlobalSharedObject.instance.isPurchased[2];
			_isUnlocked_SideLaser = GlobalSharedObject.instance.isPurchased[6];
			_isUnlocked_BackLaser = GlobalSharedObject.instance.isPurchased[7];
			_isUnlocked_SmartBombs = GlobalSharedObject.instance.isPurchased[8];
			
			sharedObject_infAmmoSelected = GlobalSharedObject.instance._infAmmoSelected;
			sharedObject_infLivesSelected = GlobalSharedObject.instance._infLivesSelected;
			sharedObject_currentLevelSelected = GlobalSharedObject.instance._currentLevelSelected;
			
			
			_ticksPerHeartDrop = 1500 + (Math.random() * 1500);
			
			//trace(sharedObject_infAmmoSelected);
			//trace(sharedObject_infLivesSelected);
			//trace(sharedObject_currentLevelSelected);
			
			if (sharedObject_infAmmoSelected) {
				sideLaserCount = 999;
				backLaserCount = 999;
				_ticksPerItemDrop = 99999;				// stop item drops
				
			} else {
				sideLaserCount = 0;
				backLaserCount = 0;
			}
			
			if (sharedObject_infLivesSelected) {
				_ticksPerHeartDrop = 99999;				// stop heart drops
			}
			
			sideLaserDisplay.modifyNum(sideLaserCount);
			backLaserDisplay.modifyNum(backLaserCount);
			
			
			if (GlobalSharedObject.instance._tutorialOn) {
				
				currentLevel = ObjectPool.instance.getObj(Level_Tutorial) as Level_Tutorial;
				currentLevel.setParent(this);
				currentLevel.TB.setText();
				
			} else {
				
				integerToNextLevel(sharedObject_currentLevelSelected);
			}
		
			
			
		}
		
		// add points
		
		public function addPoints(newPoints : int) : void {
			scoreText.modifyScore(newPoints);
			currentScore += newPoints;
			//trace(" + " + newPoints + " = " + currentScore);
		}
		
		
		// change item rates
		
		public function changeRates(fruitTicks : int, itemTicks : int, heartTicks : int, sideRate : Number, backRate : Number) : void {
			_ticksPerFruitDrop = fruitTicks;
			_ticksPerItemDrop = itemTicks;
			_ticksPerHeartDrop = heartTicks;
			_sideDiamondRate = sideRate;
			_backDiamondRate = backRate;
		}

		
		// Destroy All Enemies Function - used on avatar hit
		
		public function destroyAllEnemies() : void {
			
			var tempObj;
			
			for (var i : int = numChildren - 1 ; i >= 0 ; i--) {
				
				tempObj = getChildAt(i);
				
				if (tempObj is IGameObject) {
					removeChild(tempObj);
					ObjectPool.instance.returnObj(tempObj);
				}
			}
		}
		
		
		// boss destroy all
		
		public function bossDestroyAllEnemies() : void {
			
			if (numChildren > 0) {
				var tempObj;
			
				for (var i : int = numChildren - 1 ; i >= 0 ; i--) {
					
					tempObj = getChildAt(i);
					
					if (tempObj is IGameObject && !(tempObj is Boss_Kitty)) {
						var tempExp : Explosion = ObjectPool.instance.getObj(Explosion) as Explosion;
						tempExp.setParent(this, tempObj.x, tempObj.y);
						addChild(tempExp);
						tempExp.explode();
						
						removeChild(tempObj);
						ObjectPool.instance.returnObj(tempObj);
					}
				}
			}
			
		}
		
		// Destroy All Situations Function - used on avatar hit
		
		public function destroyAllSituations() : void {

			for (var s : int = situations.length - 1; s >= 0; s--) {
				ObjectPool.instance.returnObj(situations[s]);
			}
		}

		
		// SHOOT SIDE LASERS		
		
		private function shootSideLasers() : void {
			
			if (sideLaserCount > 0) {
				
				if (sharedObject_infAmmoSelected == false) {
					sideLaserDisplay.modifyNum(-1);
					sideLaserCount--;
				}
				
				
				for (var j : int = -1; j <= 2; j += 2) { 	// left then right
					
					var tempSideLaser1 : SideLaser = ObjectPool.instance.getObj(SideLaser) as SideLaser;
					shootSideLasers_Helper(tempSideLaser1, 0, j);
					
					if (_laserLevel > 1) {

						tempSideLaser1.setTilt(1);
						
						var tempSideLaser2 : SideLaser = ObjectPool.instance.getObj(SideLaser) as SideLaser;
						shootSideLasers_Helper(tempSideLaser2, -1, j);
						
					} 
					
					if (_laserLevel == 3) {
						
						var tempSideLaser3 : SideLaser = ObjectPool.instance.getObj(SideLaser) as SideLaser;
						shootSideLasers_Helper(tempSideLaser3, 0, j);
						
					}
				}
			}
			
		}
		
		private function shootSideLasers_Helper(tempRef : SideLaser, myI : int, myJ : int): void {
			
			shots.push(tempRef);
			tempRef.setVector(shots);
			tempRef.setParent(this);
			
			tempRef.x = avatar.x;
			tempRef.y = avatar.y;
			tempRef.setDirection(myJ);
			tempRef.setTilt(myI);
			
			addChild(tempRef);
			setChildIndex(tempRef, getChildIndex(avatar) - 1);
		}
		
		private function shootBackLasers() : void {

			if (backLaserCount > 0) {
				
				var tempRef = ObjectPool.instance.getObj(BackLaser) as BackLaser;
				
				if (sharedObject_infAmmoSelected == false) {
					backLaserDisplay.modifyNum(-1);
					backLaserCount--;
				}
				
				
				shots.push(tempRef);
				tempRef.setVector(shots);
				tempRef.setParent(this);
				
				tempRef.x = avatar.x;
				tempRef.y = avatar.y;
				
				addChild(tempRef);
				setChildIndex(tempRef, getChildIndex(avatar) - 1);
				
				tempRef.scaleX = .66 + ( .33 * (_laserLevel - 1));
				tempRef.scaleY = tempRef.scaleX;
			}
			
		}
		
		// DROP FRUIT
		
		private function dropFruit() : void {
			
			var tempRef;
			var tempRand : int = Math.random() * 5;
			
			_ticksPerFruitDrop = 50 + (Math.random() * 300);
			
			if (tempRand == 0) {
				
				tempRef = ObjectPool.instance.getObj(ItemEggplant) as ItemEggplant;
				tempRef.setVector(items);
				tempRef.setParent(this);
				
				items.push(tempRef);
				addChild(tempRef);
				
			} else if (tempRand == 1) {
				
				tempRef = ObjectPool.instance.getObj(ItemGreenApple) as ItemGreenApple;
				tempRef.setVector(items);
				tempRef.setParent(this);
				
				items.push(tempRef);
				addChild(tempRef);
				
			} else if (tempRand == 2) {
				
				tempRef = ObjectPool.instance.getObj(ItemOrange) as ItemOrange;
				tempRef.setVector(items);
				tempRef.setParent(this);
				
				items.push(tempRef);
				addChild(tempRef);
				
			} else if (tempRand == 3) {
				
				tempRef = ObjectPool.instance.getObj(ItemPeach) as ItemPeach;
				tempRef.setVector(items);
				tempRef.setParent(this);
				
				items.push(tempRef);
				addChild(tempRef);
				
			} else {
				
				tempRef = ObjectPool.instance.getObj(ItemStrawberry) as ItemStrawberry;
				tempRef.setVector(items);
				tempRef.setParent(this);
				
				items.push(tempRef);
				addChild(tempRef);
				
			}
			
			tempRef = null;
		}
		
		private function dropLaserUpgrade() : void {
			
			if (_laserLevel < 3) {
				var tempRef;
				
				_ticksPerLaserUpgradeDrop = 1000 + (Math.random() * 1000);
					
				tempRef = ObjectPool.instance.getObj(LaserUpgrade) as LaserUpgrade;
				tempRef.setVector(items);
				tempRef.setParent(this);
					
				items.push(tempRef);
				addChild(tempRef);
				
				tempRef.displayLaser.gotoAndPlay(1);
			}
		}
		
		// DROP ITEMS
		
		private function dropItems() : void {
			
			var tempRef;
			var tempRand = Math.random();
			
			_ticksPerItemDrop = 150 + (Math.random() * 250);
			
			if (tempRand < _backDiamondRate && _isUnlocked_BackLaser) {
				tempRef = ObjectPool.instance.getObj(LDiamondBack) as LDiamondBack;
				
			} else if ( (tempRand < _backDiamondRate + _sideDiamondRate) && _isUnlocked_SideLaser) {
				tempRef = ObjectPool.instance.getObj(LDiamondSide) as LDiamondSide;
			}
			
			if (!(tempRef == null)) {				// remove?
				tempRef.setVector(items);
				tempRef.setParent(this);
				
				tempRef.x = (Math.random() * (1334 - tempRef.width)) + (tempRef.width * .5);
				tempRef.y = -tempRef.width * .5;
				
				items.push(tempRef);
				addChild(tempRef);
			}
			
		}
		
		
		// DROP 1 UP
		
		private function drop1Up() : void {
			
			var tempRef = ObjectPool.instance.getObj(Item1Up) as Item1Up;
			
			_ticksPerHeartDrop = 1500 + (Math.random() * 1500);
			
			tempRef.x = (Math.random() * (1334 - tempRef.width)) + (tempRef.width * .5);
			tempRef.y = -tempRef.width * .5;
			
			tempRef.play();
			
			addGameObject(tempRef, items);
		}
		
		
		// DROP Smart Bomb
		
		private function dropSmartBomb() : void {
			
			var tempRef = ObjectPool.instance.getObj(SmartBomb) as SmartBomb;
			
			_ticksPerSmartBombDrop = 650 + (Math.random() * 400);
			
			addGameObject(tempRef, items);
		}
		
		// DROP Shield
		
		private function dropShield() : void {
			
			if (!avatar._isShielded) {
				// drop smart bomb?
				
				var tempRef = ObjectPool.instance.getObj(ShieldContainer) as ShieldContainer;
			
				_ticksPerShieldDrop = 1000 + (Math.random() * 500);
			
				addGameObject(tempRef, items);
			}
			
		}
		
		
		// increment laser level
		public function levelUpLaser() : void {
			
			if (_laserLevel < 3) {
				_laserLevel ++;
				laserLevelDisplay.setDisplay(_laserLevel);
			}
			
			
			if (GlobalVariables.instance.currentPrimaryLaser == LaserBall) {
				if (_laserLevel == 2) {
					_primaryLaserClass = LaserBall_Level_2;
				} else {
					_primaryLaserClass = LaserBall_Level_3;
				}
				
			} else if (GlobalVariables.instance.currentPrimaryLaser == LaserBall_v2Cluster) {
				if (_laserLevel == 2) {
					_primaryLaserClass = LaserBall_v2Cluster_Level_2;
				} else {
					_primaryLaserClass = LaserBall_v2Cluster_Level_3;
				}
				
			} else if (GlobalVariables.instance.currentPrimaryLaser == LaserBall_v3Cluster) {
				if (_laserLevel == 2) {
					_primaryLaserClass = LaserBall_v3Cluster_Level_2;
				} else {
					_primaryLaserClass = LaserBall_v3Cluster_Level_3;
				}
			}
		}
		
		
		// integer to next level
		
		// push things
		
		public function addGameObject(tempRef : *, vec : Vector.<IPoolable>) : void {
			
			tempRef.setVector(vec);
			tempRef.setParent(this);
			
			vec.push(tempRef);
			addChild(tempRef);
		}
		
		
		// LAUNCH HEARTS
		
		private function launchHearts(tempObj : *) : void {
			
			var tempRef : HeartSprite;
			
			for (var i : int = -1; i < 2; i += 2) {
				tempRef = ObjectPool.instance.getObj(HeartSprite) as HeartSprite;
				tempRef.x = tempObj.x;
				tempRef.y = tempObj.y;
				tempRef.setLeftOrRight(i);
				addGameObject(tempRef, shots);
			}
		}
		
		
		// LAUNCH BOSS HEARTS
		
		private function launchBossHearts(tempObj : *) : void {
			var tempRef : HeartSprite;
			
			for (var i : int = -1; i < 2; i += 2) {
				for (var ii : int = 0; ii < 2; ii ++) {
					tempRef = ObjectPool.instance.getObj(HeartSprite) as HeartSprite;
					tempRef.x = tempObj.x;
					tempRef.y = tempObj.y;
					tempRef._ySpeed += ii * 4;
					tempRef.setLeftOrRight(i);
					tempRef.scaleX = i;
					addGameObject(tempRef, shots);
				}
			}
		}
		
		// Destroy Function
			
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			_destroyed = true;
			
			// remove pRef
			pRef = null;
			
			// clear graphics
			//graphics.clear();
			
			
			// remove current level
			
			ObjectPool.instance.returnObj(currentLevel);
			currentLevel.destroy();
			currentLevel = null;
			
			
			// REMOVE VECTORS
			
			var tempObj;
			
			// destroy enemies
			for (var i : int = enemies.length - 1; i >= 0; i--) {
				tempObj = enemies[i];
				removeChild(tempObj);
				ObjectPool.instance.returnObj(tempObj);
			}
			enemies.length = 0;
			enemies = null;
			
			// destroy shots
			for (var j : int = shots.length - 1; j >= 0; j--) {
				tempObj = shots[j];
				removeChild(tempObj);
				ObjectPool.instance.returnObj(tempObj);
			}
			shots.length = 0;
			shots = null;
			
			// destroy items
			for (var k : int = items.length - 1; k >= 0; k--) {
				tempObj = items[k];
				removeChild(tempObj);
				ObjectPool.instance.returnObj(tempObj);
			}
			items.length = 0;
			items = null;
			
			//trace("\nEG Destroyed:\nEnemies: " + enemies.length + "\nShots: " + shots.length + "\nItems: " + items.length);

			_lives = null;
			_ticks = null;
			
			_ticksPerFruitDrop = null;
			_ticksPerItemDrop = null;
			_ticksPerHeartDrop = null;
			_ticksPerSmartBombDrop = null;
			_ticksPerLaserUpgradeDrop = null;
			
			_ticksPerShieldDrop = null;
			
			_sideDiamondRate = null;
			_backDiamondRate = null;
			_laserUpgradeRate = null;
			
			currentScore = null;
			_isPaused = null;
			_genPaused = null;
			_ticksPaused = null;
			laserUpgradeCount = null;
			sideLaserCount = null;
			backLaserCount = null;
			previousCount = null;
			
			_primaryLaserClass = null;
			_primaryLaserRate = null;
			_primaryLaserScale = null;
			
			_isUnlocked_1UpDrops = null;
			_isUnlocked_SideLaser = null;
			_isUnlocked_BackLaser = null;
			_isUnlocked_SmartBombs = null;
			
			_laserLevel = null;
			
			_diedThisRound = null;
			
			tempObj = null;
			
			// remove blackSpace
			blackSpace.graphics.clear();
			removeChild(blackSpace);
			
			// remove small stars
			removeChild(backgroundStars);
			ObjectPool.instance.returnObj(backgroundStars);
			backgroundStars = null;
			
			// remove large stars
			removeChild(backgroundBigStars);
			ObjectPool.instance.returnObj(backgroundBigStars);
			backgroundBigStars = null;
			
			// remove avatar
			removeChild(avatar);
			ObjectPool.instance.returnObj(avatar);
			avatar = null;
			
			// remove timer & listener
			//timer.reset();
			//timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, onTick);
			
			
			if(_isTouchMode == false) {
				acc.removeEventListener(AccelerometerEvent.UPDATE, onAccUpdate);
				acc = null;
			}
			
			accX = null;
			accY = null;
			
			// remove onClick listener
			removeEventListener(MouseEvent.MOUSE_DOWN, onClick);
			
			// remove GUI elements
			removeChild(scoreText);
			ObjectPool.instance.returnObj(scoreText);
			scoreText = null;
			
			removeChild(laserLevelDisplay);
			ObjectPool.instance.returnObj(laserLevelDisplay);
			laserLevelDisplay = null;
			
			removeChild(sideLaserDisplay);
			ObjectPool.instance.returnObj(sideLaserDisplay);
			sideLaserDisplay = null;
			
			removeChild(backLaserDisplay);
			ObjectPool.instance.returnObj(backLaserDisplay);
			backLaserDisplay = null;
			
			//removeChild(progressBar_Laser);
			//ObjectPool.instance.returnObj(progressBar_Laser);
			//progressBar_Laser = null;
			
			
			// v v v v v 
			// - Remove Lives container
			
			// destroy everything else
			for (var i : int = numChildren - 1; i >= 0; i--) {
				
				tempObj = getChildAt(i);

				if (tempObj is IPoolable) {
					removeChild(tempObj);
					ObjectPool.instance.returnObj(tempObj);
				}
			}
			
			tempObj = null;

		} // end destroy() method
		

		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
		//empty update
		public function update() : void {
			
		}
		
	} // end class
} // end package
