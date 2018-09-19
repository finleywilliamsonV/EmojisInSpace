package {

	import flash.display.Sprite;
	import flash.system.System;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;

	// Billing
	import com.myflashlab.air.extensions.billing.Billing;
	import com.myflashlab.air.extensions.billing.BillingType;
	import com.myflashlab.air.extensions.billing.Purchase;
	import com.myflashlab.air.extensions.billing.Product;

	import com.milkmangames.nativeextensions.ios.*;
	import com.milkmangames.nativeextensions.ios.events.*;

	import flash.desktop.NativeApplication;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.desktop.SystemIdleMode;
	import flash.events.Event;

	public class NewDocumentClass extends Sprite {



		// Main Objects
		public var LS: LogoScreen;
		public var MM: MainMenu;
		public var US: UpgradeScreen;
		public var EB: EnemyBook;
		public var HTP: HowToPlayScreen;
		public var EG: NewEmojiGameplay;
		public var PS: PauseScreen;
		public var GO: GameOverScreen;
		public var BA: BuyAllUpgradesScreen;
		public var credits: CreditsButtonDisplayGameOver;
		public var legalScreen: LegalScreen;
		public var CGM : ChooseGameModeScreen;

		private var starsTimer: Timer;
		public var backgroundStars: BackgroundStars;
		private var backgroundBigStars: BackgroundBigStars;

		public var fadeTransition: FadeTransition;

		public var purchaseArray: Array;



		public function NewDocumentClass(): void {

			// Register Object Pool
			ObjectPool.instance.registerPool(Avatar, 1);

			ObjectPool.instance.registerPool(E_Basic, 30);
			ObjectPool.instance.registerPool(E_Big, 10);
			ObjectPool.instance.registerPool(E_Angry, 20);
			ObjectPool.instance.registerPool(E_Loopy, 10);
			ObjectPool.instance.registerPool(E_Robot, 10);
			ObjectPool.instance.registerPool(E_RobotHorizontal, 10);
			ObjectPool.instance.registerPool(E_Dollar, 10);
			ObjectPool.instance.registerPool(MoneyBag, 15);
			ObjectPool.instance.registerPool(Dollar, 10);
			ObjectPool.instance.registerPool(E_GustLady, 10);
			ObjectPool.instance.registerPool(Gust, 10);
			ObjectPool.instance.registerPool(BossGust, 10);
			ObjectPool.instance.registerPool(E_Baddie, 10);
			ObjectPool.instance.registerPool(Fire, 10);
			ObjectPool.instance.registerPool(BossFire, 10);
			ObjectPool.instance.registerPool(E_ShrinkFace, 10);
			ObjectPool.instance.registerPool(E_Luvvies, 10);
			ObjectPool.instance.registerPool(HeartSprite, 10);

			ObjectPool.instance.registerPool(PortalCrystal, 4);
			ObjectPool.instance.registerPool(TutorialBanner, 1);
			ObjectPool.instance.registerPool(Level_Tutorial, 1);
			ObjectPool.instance.registerPool(LegalScreen, 1);


			ObjectPool.instance.registerPool(CreditsButtonDisplayGameOver, 1);


			ObjectPool.instance.registerPool(AllZodRandom, 1);
			ObjectPool.instance.registerPool(Boss_Kitty, 1);
			ObjectPool.instance.registerPool(Boss_Kitty_Destroy, 1);


			ObjectPool.instance.registerPool(Explosion, 20);
			ObjectPool.instance.registerPool(LightningBoltVertical, 10);
			ObjectPool.instance.registerPool(LightningBoltHorizontal, 10);

			ObjectPool.instance.registerPool(LaserBall, 15);
			ObjectPool.instance.registerPool(LaserBall_Level_2, 15);
			ObjectPool.instance.registerPool(LaserBall_Level_3, 15);
			ObjectPool.instance.registerPool(LaserBall_v2Cluster, 10);
			ObjectPool.instance.registerPool(LaserBall_v2Cluster_Level_2, 10);
			ObjectPool.instance.registerPool(LaserBall_v2Cluster_Level_3, 10);
			ObjectPool.instance.registerPool(LaserBall_v3, 20);
			ObjectPool.instance.registerPool(LaserBall_v3Cluster, 10);
			ObjectPool.instance.registerPool(LaserBall_v3Cluster_Level_2, 10);
			ObjectPool.instance.registerPool(LaserBall_v3Cluster_Level_3, 10);
			ObjectPool.instance.registerPool(BackLaser, 5);
			ObjectPool.instance.registerPool(SideLaser, 25);
			ObjectPool.instance.registerPool(YinYangProj, 5);

			ObjectPool.instance.registerPool(SmartBombLaser, 5);

			ObjectPool.instance.registerPool(Shield, 5);
			ObjectPool.instance.registerPool(ShieldContainer, 5);

			ObjectPool.instance.registerPool(LaserUpgrade, 10);
			ObjectPool.instance.registerPool(LDiamondBack, 10);
			ObjectPool.instance.registerPool(LDiamondSide, 10);

			ObjectPool.instance.registerPool(SmartBomb, 3);

			ObjectPool.instance.registerPool(AllZod, 1);

			ObjectPool.instance.registerPool(Item1Up, 5);

			ObjectPool.instance.registerPool(ItemEggplant, 5);
			ObjectPool.instance.registerPool(ItemGreenApple, 5);
			ObjectPool.instance.registerPool(ItemOrange, 5);
			ObjectPool.instance.registerPool(ItemPeach, 5);
			ObjectPool.instance.registerPool(ItemStrawberry, 5);

			ObjectPool.instance.registerPool(ScoreText, 1);
			ObjectPool.instance.registerPool(SideLaserDisplay, 1);
			ObjectPool.instance.registerPool(BackLaserDisplay, 1);
			ObjectPool.instance.registerPool(LaserLevelDisplay, 1);
			ObjectPool.instance.registerPool(LevelTextBanner, 1);

			ObjectPool.instance.registerPool(GlobalScoreDisplay, 2);

			ObjectPool.instance.registerPool(ChooseGameModeScreen, 1);	

			ObjectPool.instance.registerPool(ZodiacToggleButton, 1);
			ObjectPool.instance.registerPool(SideBackToggleButton, 1);
			ObjectPool.instance.registerPool(LivesToggleButton, 1);
			ObjectPool.instance.registerPool(LevelSelector, 1);

			ObjectPool.instance.registerPool(BuyAllUpgradesButton, 1);
			ObjectPool.instance.registerPool(BuyAllUpgradesScreen, 1);


			ObjectPool.instance.registerPool(NotificationIcon, 5);

			ObjectPool.instance.registerPool(LivesContainer, 1);

			ObjectPool.instance.registerPool(HowToPlayAvatar, 1);
			ObjectPool.instance.registerPool(FlashingFruit, 1);
			ObjectPool.instance.registerPool(PhoneWithDirections, 1);
			ObjectPool.instance.registerPool(ComboDisplay, 1);
			ObjectPool.instance.registerPool(ZodiacHowTo, 1);

			ObjectPool.instance.registerPool(BackgroundStars, 1);
			ObjectPool.instance.registerPool(BackgroundBigStars, 1);
			ObjectPool.instance.registerPool(MainMenu, 1);
			ObjectPool.instance.registerPool(UpgradeScreen, 1);
			ObjectPool.instance.registerPool(HowToPlayScreen, 1);
			ObjectPool.instance.registerPool(PauseScreen, 1);
			ObjectPool.instance.registerPool(EnemyBook, 1);
			ObjectPool.instance.registerPool(GameOverScreen, 1);

			ObjectPool.instance.registerPool(FadeTransition, 1);
			ObjectPool.instance.registerPool(LogoScreen, 1);

			ObjectPool.instance.registerPool(DisplayGameOver, 1);

			ObjectPool.instance.registerPool(Level_1, 1);
			ObjectPool.instance.registerPool(Level_2, 1);
			ObjectPool.instance.registerPool(Level_3, 1);
			ObjectPool.instance.registerPool(Level_4, 1);
			ObjectPool.instance.registerPool(Level_5, 1);
			ObjectPool.instance.registerPool(Level_6, 1);
			ObjectPool.instance.registerPool(Level_7, 1);
			ObjectPool.instance.registerPool(Level_8, 1);
			ObjectPool.instance.registerPool(Level_9, 1);
			ObjectPool.instance.registerPool(Level_10, 1);
			ObjectPool.instance.registerPool(Level_11, 1);
			ObjectPool.instance.registerPool(Level_12, 1);
			ObjectPool.instance.registerPool(Level_Transition, 1);
			ObjectPool.instance.registerPool(Level_Boss, 1);
			ObjectPool.instance.registerPool(Level_Finale, 1);

			ObjectPool.instance.registerPool(Situation, 10);
			ObjectPool.instance.registerPool(BossSituation, 5);

			//ObjectPool.instance.registerPool(Sound_KickLow, 1);

			ObjectPool.instance.registerPool(NewEmojiGameplay, 1);


			/*
			//START ANDROID HANDLERS

			//NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, handleActivate, false, 0, true);
			//NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate, false, 0, true);
			//NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys, false, 0, true);

			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, handleActivate);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys);


			function handleActivate(event: Event): void {

				//GlobalSounds.instance.ouch();

				trace("handleActivate\n");

				GlobalSounds.instance.playBGM();

				if (EG) {
					if (!EG._isPaused) {
						GlobalVariables.instance.gameTimer2.start();
					}
				} else {
					GlobalVariables.instance.gameTimer2.start();
				}


				//NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;


			}

			function handleDeactivate(event: Event): void {

				trace("\nhandleDeactivate");

				GlobalSounds.instance.songPosition = GlobalSounds.instance.bgmSoundChannel.position;
				GlobalSounds.instance.bgmSoundChannel.stop();
				//GlobalSounds.instance.sfxSoundChannel.stop();


				GlobalVariables.instance.gameTimer2.stop();

				//GlobalSounds.instance.click();

				//NativeApplication.nativeApplication.exit();

			}

			function handleKeys(event: KeyboardEvent): void {

				trace("\nhandleKeys");

				if (event.keyCode == Keyboard.BACK) {

					//GlobalSounds.instance.playSound(7); //jingle
					NativeApplication.nativeApplication.exit();

				}

			}


			//end android handlers


*/


			purchaseArray = [];


			// Start Game
			showLS();


			//MMtoEG();
			//EGtoGO();
		}

		public function onTick(te: TimerEvent): void {
			backgroundStars.update();
			backgroundBigStars.update();
		}


		public function initiateGameCenter(): void {

			if (GlobalVariables.instance.gameCenterCreated == false) {


				if (GameCenter.isSupported()) {
					GameCenter.create();
					GlobalVariables.instance.gameCenterCreated = true;
				} else {
					trace("this device is not running iOS.");
					return;
				}

				if (!GameCenter.gameCenter.isGameCenterAvailable()) {
					trace("GameCenter is not enabled on this device.");
					return;
				}


				GameCenter.gameCenter.addEventListener(GameCenterEvent.AUTH_SUCCEEDED, onAuthSucceeded);
				GameCenter.gameCenter.addEventListener(GameCenterErrorEvent.AUTH_FAILED, onAuthFailed);

				function onAuthSucceeded(e: GameCenterEvent): void {
					trace("game center logged in.");
				}

				function onAuthFailed(e: GameCenterErrorEvent): void {
					trace("game center login failed.");
				}
			}

			GameCenter.gameCenter.authenticateLocalUser();
		}


		public function initiateIAP(): void {
			trace("start initiateIAP()");

			//Billing.IS_DEBUG_MODE = true;

			Billing.init("MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApCyJ/EqpW3CBPv847dIf3TEROAVvhTblfcgIOm3SRjjPdN0ZXw3kFtG4Y/5PMkMC2VHHCl1BzkFaBcI/ZGMBHTKh3yVFbLAVCdMa5m4H1InGYOS/tjKbs+hOSeJi/z8oWtQE6YW1EEY0dTgeRU0n8Guhrm6PyToGWtg5aQ3UqerxrZdLtdlTlGYkBhsMl1k8AGJkWkv2fq/fQ1uq+iZhWdwNi4l8gz2BA3x0qAbg221YC9m5AKN5mNGvdzcmtGmPe3z/JnM3GQ5TX8FulXtMtl4PO+l1NygsP1tBngHc0WTHOR87+XQ6lVmkQ35vo+W/HuVEB8mub2uneXaKpS+NMwIDAQAB",

				[ // Android product IDs which you have already set in your Google Play console.
					"eis_android_purchasedevmode",
				],

				[ // iOS product IDs which you have already set in your iTunes Connect.
					"com.vortextmarketing.emojisinspaceIOS.PurchaseDeveloperMode",
				],

				onInitResult);
		}

		private function onInitResult($status: int, $msg: String): void {

			trace("onInitResult");

			if (!Boolean($status)) {
				// if $status is 0 it means that the initialization was not successful and this may happen because of many different reasons
				// which we have talked about them in the demo project sample codes. Please check FD/src/MainFinal.as file for more details.
				trace("!!! - initiation unsuccessful - !!!");
				return;

			} else {

				// Trace the list of available/online products which you can make purchases on them:
				var availableProducts: Array = Billing.products;
				var currProduct: Product;

				for (var i: int = 0; i < availableProducts.length; i++) {
					currProduct = availableProducts[i];
					trace("\t productId = " + currProduct.productId);
					trace("\t title = " + currProduct.title);
					trace("\t description = " + currProduct.description);
					trace("\t price = " + currProduct.price);
					trace("\t currency = " + currProduct.currency);
					trace("---------------------------------------");
				}

				billingGetPurchases();

			}


		}

		public function billingGetPurchases(): void {
			Billing.getPurchases(onGetPurchasesResult);
		}

		private function onGetPurchasesResult($purchases: Array): void {

			trace("onGetPurchasesResult");

			if ($purchases) { // means we have successfully connected the server. 

				purchaseArray = $purchases;

				if ($purchases.length > 0) {

					var purchaseData: Purchase;
					var lng: int = $purchases.length;
					var i: int;

					for (i = 0; i < lng; i++) {
						purchaseData = $purchases[i];
						trace("----------------");
						trace("purchaseData.orderId = " + purchaseData.orderId);
						trace("purchaseData.productId = " + purchaseData.productId);
						trace("purchaseData.purchaseState = " + purchaseData.purchaseState);
						trace("purchaseData.purchaseTime = " + purchaseData.purchaseTime);
						trace("purchaseData.purchaseToken = " + purchaseData.purchaseToken);
						trace("----------------");
					}

				} else { // if it's an empty Array, it means there are no purchase records for this user on the server.

					trace("\n There are no purchase records for this user on Google or Apple servers.");
				}

			} else {

				trace("\n Error while trying to get the list of previously purchased records.")
			}
		}


		private function onPurchaseResult($status: int, $data: Purchase, $msg: String): void {
			trace("\n purchase was successful? " + Boolean($status));

			if ($status == true) {


				//    *****     buy the upgrades     *****

				GlobalSharedObject.instance._devModePurchased = true;
				GlobalSharedObject.instance.modifyBothScoreCounts(100000);

				MM.setGlobalScoreText();


				MM.buyAll.checkPurchased();

				BAtoMM();
			}


			if ($msg == Billing.ALREADY_OWNED_ITEM) {
				trace($msg);
				if (BA.stage) {
					BA.switchToPurchased();
				}
			} else if ($msg == Billing.NOT_FOUND_ITEM) {
				trace($msg);
			} else {
				trace("purchase result message = " + $msg);
			}

			if ($data) {
				trace("----------------");
				trace("$data.billingType = " + $data.billingType);
				trace("$data.orderId = " + $data.orderId);
				trace("$data.developerPayload = " + $data.developerPayload);
				trace("$data.productId = " + $data.productId);
				trace("$data.purchaseState = " + $data.purchaseState);
				trace("$data.purchaseTime = " + $data.purchaseTime);
				trace("$data.purchaseToken = " + $data.purchaseToken);
				trace("----------------");
			}
		}

		public function makePurchase_DeveloperMode(): void {
			trace("attempting purchase");
			Billing.doPayment(BillingType.PERMANENT, "com.vortextmarketing.emojisinspaceIOS.PurchaseDeveloperMode", "Payload DEVELOPER MODE UNLOCKED", onPurchaseResult);
			//Billing.doPayment(BillingType.PERMANENT, "eis_android_purchasedevmode", "Payload DEVELOPER MODE UNLOCKED", onPurchaseResult);
		}



		public function MMtoLegalScreen(): void {

			MM.removeEventListener(MouseEvent.CLICK, MM.onClick);
			removeChild(MM);

			legalScreen = ObjectPool.instance.getObj(LegalScreen) as LegalScreen;
			legalScreen.setParent(this);
			addChild(legalScreen);
		}

		public function LegalScreenToMM(): void {

			removeChild(legalScreen);
			ObjectPool.instance.returnObj(legalScreen);
			legalScreen = null;

			addChild(MM);
			MM.addEventListener(MouseEvent.CLICK, MM.onClick);
		}


	
		// choose game mode
		
		public function MMtoCGM(): void {

			MM.removeEventListener(MouseEvent.CLICK, MM.onClick);
			removeChild(MM);

			CGM = ObjectPool.instance.getObj(ChooseGameModeScreen) as ChooseGameModeScreen;
			CGM.setParent(this);
			addChild(CGM);
			CGM.setup();
		}

		public function CGMtoEG(): void {
			removeStars();

			fadeTransition = ObjectPool.instance.getObj(FadeTransition) as FadeTransition;
			fadeTransition.setParent(this);

			EG = ObjectPool.instance.getObj(NewEmojiGameplay) as NewEmojiGameplay;
			EG.setParent(this);

			EG.livesContainer.setup();
			
			fadeTransition.transition(CGM, EG);
		}
		
		public function GOtoCGM() : void {
			
			GO.removeEventListener(MouseEvent.CLICK, GO.onClick);
			removeChild(GO);

			CGM = ObjectPool.instance.getObj(ChooseGameModeScreen) as ChooseGameModeScreen;
			CGM.setParent(this);
			addChild(CGM);
			CGM.setup();
		}
		

		public function showLS(): void {
			addStars();
			LS = ObjectPool.instance.getObj(LogoScreen) as LogoScreen;
			LS.setParent(this);

			fadeTransition = ObjectPool.instance.getObj(FadeTransition) as FadeTransition;
			fadeTransition.setParent(this);
			fadeTransition.fadeIn(LS);

			initiateIAP();
			initiateGameCenter();

			//GlobalSharedObject.instance.resetSharedObject();

		}

		public function LStoMM(): void {

			fadeTransition = ObjectPool.instance.getObj(FadeTransition) as FadeTransition;
			fadeTransition.setParent(this);

			MM = ObjectPool.instance.getObj(MainMenu) as MainMenu;
			MM.setParent(this);

			fadeTransition.transition(LS, MM);

			// queue music
			GlobalSounds.instance.playBGM();

		}

		public function updateNotifications(): void {
			US = ObjectPool.instance.getObj(UpgradeScreen) as UpgradeScreen;
			US.setParent(this);
			US.updateNotifications(MM.upgradeButton);
			ObjectPool.instance.returnObj(US);
			US = null;
		}

		public function MMtoCredits(): void {

			MM.removeEventListener(MouseEvent.CLICK, MM.onClick);
			removeChild(MM);

			credits = ObjectPool.instance.getObj(CreditsButtonDisplayGameOver) as CreditsButtonDisplayGameOver;
			credits.setParent(this);
			addChild(credits);
			starsTimer.addEventListener(TimerEvent.TIMER, onTickCredits);

			stage.addEventListener(MouseEvent.CLICK, onClickCredits);
		}

		public function onTickCredits(tE: TimerEvent): void {

			credits.update();
		}

		public function onClickCredits(tE: MouseEvent): void {

			creditsToMM();
		}

		public function creditsToMM(): void {

			stage.removeEventListener(MouseEvent.CLICK, onClickCredits);
			starsTimer.removeEventListener(TimerEvent.TIMER, onTickCredits);
			removeChild(credits);
			ObjectPool.instance.returnObj(credits);
			credits = null;

			addChild(MM);
			MM.addEventListener(MouseEvent.CLICK, MM.onClick);
		}

		public function MMtoEB(): void {
			EB = ObjectPool.instance.getObj(EnemyBook) as EnemyBook;
			EB.setParent(this);
			addChild(EB);
			setChildIndex(EB, numChildren - 1);
			EB.x = 667;
			EB.y = 375;
			EB.setup();
		}


		public function EBtoMM(): void {

			ObjectPool.instance.returnObj(EB);
			removeChild(EB);
			EB = null;

			MM.returnFromEnemyBook();
		}



		public function MMtoHTP(): void {
			HTP = ObjectPool.instance.getObj(HowToPlayScreen) as HowToPlayScreen;
			HTP.setParent(this);
			addChild(HTP);
			setChildIndex(HTP, numChildren - 1);
			HTP.x = 667;
			HTP.y = 375;
			HTP.setup();


		}


		public function HTPtoMM(): void {

			ObjectPool.instance.returnObj(HTP);
			removeChild(HTP);
			HTP = null;

			MM.returnFromHowToPlayScreen();
		}


		public function MMtoUS(): void {
			US = ObjectPool.instance.getObj(UpgradeScreen) as UpgradeScreen;
			US.setParent(this);
			addChild(US);
			setChildIndex(US, numChildren - 1);
			US.setup();
		}


		public function UStoMM(): void {

			ObjectPool.instance.returnObj(US);
			removeChild(US);
			US = null;

			MM.returnFromUpgradeScreen();
		}

		public function MMtoBA(): void {
			BA = ObjectPool.instance.getObj(BuyAllUpgradesScreen) as BuyAllUpgradesScreen;
			BA.setParent(this);
			addChild(BA);
			setChildIndex(BA, numChildren - 1);
			//BA.x = 667;
			//BA.y = 375;
			BA.setup();
		}

		public function BAtoMM(): void {

			ObjectPool.instance.returnObj(BA);
			removeChild(BA);
			BA = null;

			MM.returnFromBuyAllScreen();
		}

		public function MMtoEG(): void {
			removeStars();

			//MM.zodToggle.recordPosition();

			fadeTransition = ObjectPool.instance.getObj(FadeTransition) as FadeTransition;
			fadeTransition.setParent(this);

			EG = ObjectPool.instance.getObj(NewEmojiGameplay) as NewEmojiGameplay;
			EG.setParent(this);
			
			EG.livesContainer.setup();

			fadeTransition.transition(MM, EG);
		}

		public function EGtoPS(): void {
			PS = ObjectPool.instance.getObj(PauseScreen) as PauseScreen;
			PS.setParent(this);
			addChild(PS);
			setChildIndex(PS, numChildren - 1);
			PS.x = 667;
			PS.y = 375;
		}

		public function PStoEG(): void {
			removeChild(PS);
			ObjectPool.instance.returnObj(PS);
			PS = null;

			EG.returnFromPause();
		}

		public function PStoGO(): void {
			removeChild(PS);
			ObjectPool.instance.returnObj(PS);
			PS = null;

			fadeTransition = ObjectPool.instance.getObj(FadeTransition) as FadeTransition;
			fadeTransition.setParent(this);

			GO = ObjectPool.instance.getObj(GameOverScreen) as GameOverScreen;
			GO.setParent(this);
			GO.setFinalScore(EG.currentScore);



			fadeTransition.transition(EG, GO);

			addStars();
		}

		public function EGtoGO(): void {

			fadeTransition = ObjectPool.instance.getObj(FadeTransition) as FadeTransition;
			fadeTransition.setParent(this);

			GO = ObjectPool.instance.getObj(GameOverScreen) as GameOverScreen;
			GO.setParent(this);
			GO.setFinalScore(EG.currentScore);



			fadeTransition.transition(EG, GO);

			addStars();
		}

		public function GOtoMM(): void {

			fadeTransition = ObjectPool.instance.getObj(FadeTransition) as FadeTransition;
			fadeTransition.setParent(this);

			MM = ObjectPool.instance.getObj(MainMenu) as MainMenu;
			MM.setParent(this);

			fadeTransition.transition(GO, MM);
		}

		public function GOtoEG(): void {
			fadeTransition = ObjectPool.instance.getObj(FadeTransition) as FadeTransition;
			fadeTransition.setParent(this);

			EG = ObjectPool.instance.getObj(NewEmojiGameplay) as NewEmojiGameplay;
			EG.setParent(this);

			removeStars();
			
			EG.livesContainer.setup();

			fadeTransition.transition(GO, EG);
		}


		private function addStars(): void {
			//add small stars
			backgroundStars = ObjectPool.instance.getObj(BackgroundStars) as BackgroundStars;
			addChild(backgroundStars);
			setChildIndex(backgroundStars, 0);

			//add big stars
			backgroundBigStars = ObjectPool.instance.getObj(BackgroundBigStars) as BackgroundBigStars;
			addChild(backgroundBigStars);
			setChildIndex(backgroundBigStars, 0);

			starsTimer = GlobalVariables.instance.gameTimer2;
			starsTimer.addEventListener(TimerEvent.TIMER, onTick);
			starsTimer.start();
		}

		private function removeStars(): void {
			// remove small stars
			removeChild(backgroundStars);
			ObjectPool.instance.returnObj(backgroundStars);
			backgroundStars = null;

			// remove large stars
			removeChild(backgroundBigStars);
			ObjectPool.instance.returnObj(backgroundBigStars);
			backgroundBigStars = null;

			starsTimer.removeEventListener(TimerEvent.TIMER, onTick);
			starsTimer.reset();
			starsTimer.stop();
			starsTimer = null;
		}


		// Destroy Function

		public function destroy(): void { // possibly better if reverse for-loop iterates each child, given DocClass has any, calling destroy() on & nulling each.

			removeChildren();

			if (MM) {
				ObjectPool.instance.returnObj(MM);
				MM = null;
			} else if (EG) {
				ObjectPool.instance.returnObj(EG);
				EG = null;
			} else if (PS) {
				ObjectPool.instance.returnObj(PS);
				PS = null;
			} else if (GO) {
				ObjectPool.instance.returnObj(GO);
				GO = null;
			}

			// nullify object pool?
		}

	} // end class
} // end package