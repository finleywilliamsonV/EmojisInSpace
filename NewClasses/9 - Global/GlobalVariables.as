package {

	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.display.Bitmap;
	import flash.utils.Timer;
	import flash.display.Shape;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.display.MovieClip;
	import flash.desktop.NativeApplication;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.desktop.SystemIdleMode;
	import flash.events.TimerEvent;
	
	import com.milkmangames.nativeextensions.ios.*;
	import com.milkmangames.nativeextensions.ios.events.*;
	
	public class GlobalVariables {

		private static var _instance: GlobalVariables;
		private static var _allowInstantiation: Boolean;

		private static var _modelEBig: Model_E_Big;
		private static var _modelBigStar: BitmapData;
		private static var _modelProgressBar: BitmapData;
		private static var _modelProgressBarUnit: BitmapData;
		private static var _modelProgressBarPoint: Point;

		private static var _rectangleL: Rectangle = new Rectangle(0, 0, 1334, 1500);
		private static var _rectangleS: Rectangle = new Rectangle(0, 0, 1334, 750);
		private static var _rectangleXS: Rectangle = new Rectangle(0, 0, 2, 2);
		private static var _point: Point = new Point(0, 750);

		private static var _timer: Timer;
		private static var _gameTimer: Timer;

		private static var isShrinking: Boolean;
		private static var storedWidth: int;
		private static var storedHeight: int;
		private var obj: DisplayObject;
		private var pObj;
		private static var finalX: int;
		private static var finalY: int;

		private static var _colorTransform: ColorTransform;
		
		private static var _gameCenterCreated : Boolean;
		
		private static var listenersAdded: Boolean;
		
		

		private var _currentPrimaryLaser: Class;

		public static function get instance(): GlobalVariables {

			if (!_instance) {
				_allowInstantiation = true;
				_instance = new GlobalVariables();
				_allowInstantiation = false;

				_modelEBig = new Model_E_Big();

				_modelBigStar = new BitmapData(2, 2, false, 0xFFFFFF);

				_modelProgressBar = new BitmapData(300, 2, true, 0x000000);
				_modelProgressBarUnit = new BitmapData(30, 2, false, 0x66FFCC);
				_modelProgressBarPoint = new Point();

				//_timer = new Timer(25);
				_gameTimer = new Timer(25);

				_colorTransform = new ColorTransform();

				_gameCenterCreated = false;			
				
				listenersAdded = false;
				




				//		function handleDeactivate(event:Event):void {
				//			//the app is now losing focus
				////			GlobalSounds.instance.bgmSoundChannel.stop();
				////			GlobalSounds.instance.sfxSoundChannel.stop();
				////			
				////			_timer.stop();
				////			_gameTimer.stop();
				//		}
				//
				//	function handleActivate(event:Event):void {
				//		GlobalSounds.instance.playBGM();
				//		
				//		_timer.start();
				//		_gameTimer.start();
				//	}



			}

			return _instance;
		}
		
		// check login and add listeners
		public function checkLogin(): Boolean {

			if (listenersAdded == false) {

				if (_gameCenterCreated == true) {

					if (GameCenter.gameCenter.isGameCenterAvailable()) {

						if (GameCenter.gameCenter.isUserAuthenticated()) {

							GameCenter.gameCenter.addEventListener(GameCenterEvent.LEADERBOARD_VIEW_OPENED, onViewOpened);
							GameCenter.gameCenter.addEventListener(GameCenterEvent.LEADERBOARD_VIEW_CLOSED, onViewClosed);

							GameCenter.gameCenter.addEventListener(GameCenterEvent.SCORE_REPORT_SUCCEEDED, onScoreReported);
							GameCenter.gameCenter.addEventListener(GameCenterErrorEvent.SCORE_REPORT_FAILED, onScoreFailed);

							listenersAdded = true;
						}
					}
				}
			}

			return listenersAdded;
		}
		
		private function onViewOpened(e: GameCenterEvent): void {
			// view opened- you might want to stop sounds or pause here.
		}

		private function onViewClosed(e: GameCenterEvent): void {
			// view closed – you might want to restore sounds, unapause, etc. here.
		}

		private function onScoreReported(e: GameCenterEvent): void {
			trace("score submitted!");
		}

		private function onScoreFailed(e: GameCenterErrorEvent): void {
			trace("an error occurred reporting score.");
		}

		public function get gameCenterCreated() : Boolean {
			return _gameCenterCreated;
		}
		
		public function set gameCenterCreated( tf : Boolean ) : void {
			_gameCenterCreated = tf;
		}

		public function get timer2() : Timer {
			return _timer;
		}
		
		public function get gameTimer2() : Timer {
			return _gameTimer;
		}

		public function shrinker(parentObj: * , newObj: DisplayObject, fX: int, fY: int): void {

			obj = newObj;
			pObj = parentObj;

			finalX = fX;
			finalY = fY;

			storedWidth = obj.width;
			storedHeight = obj.height;

			//pObj.pRef.addEventListener(Event.ENTER_FRAME, onObjEnterFrame, false, 0, true);
			
			GlobalVariables.instance.gameTimer2.addEventListener(TimerEvent.TIMER, onObjEnterFrame);

			
			isShrinking = true;
		}

		public function onObjEnterFrame(e: Event): void {

			// move to bottom center
			if (isShrinking) {
				if (obj.width > 1) {
					obj.scaleX *= .8;
					obj.scaleY *= .8;
				} else {
					isShrinking = false;
					obj.visible = false;
					obj.x = finalX;
					obj.y = finalY;
					obj.visible = true;
				}
			} else {
				if (obj.width < storedWidth) {
					obj.scaleX /= .8;
					obj.scaleY /= .8;
				} else {
					obj.width = storedWidth;
					obj.height = storedHeight;
					clearShrinker();
				}
			}
		}

		public function clearShrinker(): void {
			//pObj.pRef.removeEventListener(Event.ENTER_FRAME, onObjEnterFrame);

			GlobalVariables.instance.gameTimer2.removeEventListener(TimerEvent.TIMER, onObjEnterFrame);
			
			nullOut();
		}

		public function nullOut(): void {
			finalX = null;
			finalY = null;
			obj = null;
			storedWidth = null;
			storedHeight = null;
			isShrinking = null;

			pObj.doneShrinking();
			pObj = null;
		}

		public function get colorTransform(): ColorTransform {
			return _colorTransform;
		}

		public function get modelEBig(): Model_E_Big {
			return _modelEBig;
		}

		public function get modelBigStar(): BitmapData {
			return _modelBigStar;
		}

		public function get modelProgressBar(): BitmapData {
			return _modelProgressBar;
		}

		public function get modelProgressBarUnit(): BitmapData {
			return _modelProgressBarUnit;
		}

		public function get modelProgressBarPoint(): Point {
			return _modelProgressBarPoint;
		}



		public function get rectangleL(): Rectangle {
			return _rectangleL;
		}

		public function get rectangleS(): Rectangle {
			return _rectangleS;
		}

		public function get rectangleXS(): Rectangle {
			return _rectangleXS;
		}

		public function get point(): Point {
			return _point;
		}

		public function get timer(): Timer {
			_timer.reset();
			_timer.stop();
			return _timer;
		}

		public function get gameTimer(): Timer {
			_gameTimer.reset();
			_gameTimer.stop();
			return _gameTimer;
		}


		public function get currentPrimaryLaser(): Class {

			if (GlobalSharedObject.instance._allZodiacsCollected && ((GlobalSharedObject.instance._yinYangSelected))) {
				_currentPrimaryLaser = YinYangProj;

			} else if (GlobalSharedObject.instance.isPurchased[5]) {
				_currentPrimaryLaser = LaserBall_v3Cluster;

			} else if (GlobalSharedObject.instance.isPurchased[4]) {
				_currentPrimaryLaser = LaserBall_v2Cluster;

			} else if (_currentPrimaryLaser == null) {
				_currentPrimaryLaser = LaserBall;
			}

			return _currentPrimaryLaser;
		}

		public function set currentPrimaryLaser(newLaser: Class): void {

			_currentPrimaryLaser = newLaser;
		}


		public function GlobalVariables() {
			if (!_allowInstantiation) {
				throw new Error("ERROR: STOP IT FOOL, DON'T INITIALIZE!!");
			}
		}

	}

}