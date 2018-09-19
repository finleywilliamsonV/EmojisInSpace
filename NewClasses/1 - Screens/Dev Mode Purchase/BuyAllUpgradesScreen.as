package {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class BuyAllUpgradesScreen extends MovieClip implements IPoolable {


		// class variables

		private var _destroyed: Boolean;

		public var pRef: NewDocumentClass;

		public var _isPurchasedDevMode: Boolean;

		public var IA: SideBackToggleButton; // infinite ammo
		public var IL: LivesToggleButton; // infinite lives
		public var LS: LevelSelector; // level select


		// constructor
		public function BuyAllUpgradesScreen() {

			_destroyed = true;

			renew();

			x = 667;
			y = 375;
		}

		// Renew object to usable state
		public function renew(): void {

			if (!_destroyed) {
				return;
			}

			_destroyed = false;

			_isPurchasedDevMode = GlobalSharedObject.instance._devModePurchased;


			if (_isPurchasedDevMode) {

				gotoAndStop(2);

				IA = ObjectPool.instance.getObj(SideBackToggleButton) as SideBackToggleButton;
				IL = ObjectPool.instance.getObj(LivesToggleButton) as LivesToggleButton;
				LS = ObjectPool.instance.getObj(LevelSelector) as LevelSelector;

				addChild(IA);
				addChild(IL);
				addChild(LS);

			} else {

				gotoAndStop(1);
			}

		}

		// click

		public function setup(): void {

			stage.addEventListener(MouseEvent.CLICK, onClick);

		}


		public function onClick(mE: MouseEvent): void {

			//trace(mE.target);

			if (mE.target is ExitButton) {

				pRef.BAtoMM();


			} else if (_isPurchasedDevMode == false) {


				if (mE.target is DeveloperModeBuyItButton) {


					pRef.makePurchase_DeveloperMode();


				} else if (mE.target is RestorePurchasesButton) {

					trace("Restore Purchases clicked");

					//pRef.billingGetPurchases();

					if (pRef.purchaseArray.length > 0) {

						switchToPurchased();

					}
				}


			} else { //   if _isPurchasedDevMode == true

				if (mE.target == IA) {
					IA.click();
				} else if (mE.target == IL) {
					IL.click();
				} else if ((mE.target is LevelSelectForwardButton) || (mE.target is LevelSelectBackButton)) {
					LS.click(mE.target);
				}

			}

		}


		// switchedto purchased mode
		public function switchToPurchased(): void {
			
			GlobalSharedObject.instance._devModePurchased = true;
			GlobalSharedObject.instance.modifyBothScoreCounts(100000);

			pRef.MM.setGlobalScoreText();


			pRef.MM.buyAll.checkPurchased();

			pRef.BAtoMM();
		}
		
		
		// Update object
		public function update(): void {
			// ???
		}

		// set parent
		public function setParent(parRef: NewDocumentClass): void {
			pRef = parRef;
		}


		// Destroy object and return to ObjectPool
		public function destroy(): void {

			if (_destroyed) {
				return;
			}

			pRef = null;
			_destroyed = true;

			gotoAndStop(1);

			if (_isPurchasedDevMode) {

				removeChild(IA);
				removeChild(IL);
				removeChild(LS);

				ObjectPool.instance.returnObj(IA);
				ObjectPool.instance.returnObj(IL);
				ObjectPool.instance.returnObj(LS);

				IA = null;
				IL = null;
				LS = null;
			}

			_isPurchasedDevMode = null;

			if (stage)
				stage.removeEventListener(MouseEvent.CLICK, onClick);
		}


		// Return whether object is currently destroyed
		public function get destroyed(): Boolean {
			return _destroyed;
		}

	}
}