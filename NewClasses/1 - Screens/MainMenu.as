package  {
	
	import flash.display.Sprite;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	
	public class MainMenu extends Sprite implements IPoolable {
		
		
		
		// class variables
		
		private var _destroyed : Boolean;
		
		public var pRef:NewDocumentClass;
		
		public var zodToggle : ZodiacToggleButton;
		
		public var buyAll : BuyAllUpgradesButton;
		
		public var gs : GlobalScoreDisplay;
		
		
		// constructor
		
		public function MainMenu() : void {
			
			_destroyed = true;
			
			renew();
		}
		
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			visible = true;
			
			zodiacContainer.setZodiac(GlobalSharedObject.instance._zodiacsCollected);
			
			addEventListener(MouseEvent.CLICK, onClick);
			
			//setGlobalScoreText();
			
			zodToggle = ObjectPool.instance.getObj(ZodiacToggleButton) as ZodiacToggleButton;
			addChild(zodToggle);
			setChildIndex(zodToggle, 2);
			zodToggle.checkVisible();
			
			gs = ObjectPool.instance.getObj(GlobalScoreDisplay) as GlobalScoreDisplay;
			addChild(gs);
			setChildIndex(gs, numChildren-1);
			
			buyAll = ObjectPool.instance.getObj(BuyAllUpgradesButton) as BuyAllUpgradesButton;
			addChild(buyAll);
			setChildIndex(buyAll, numChildren-1);
			
			settingsButton.setParent(this);
			setChildIndex(settingsButton, numChildren -1);
			
		}
		
		
		// onClick Function
		public function onClick(mE : MouseEvent) : void {
			
			mE.stopPropagation();
			
			// click start
			if (mE.target is StartButton) {
				GlobalSounds.instance.playSound(7);
				
				if (GlobalSharedObject.instance._numberOfChecksRemaining > 0) {
					GlobalSharedObject.instance._numberOfChecksRemaining --;
					pRef.MMtoCGM();
				} else {
					pRef.MMtoEG();
					return;
				}
			} 
			
			// enemy book
			if (mE.target is EnemyBookButton) {
				GlobalSounds.instance.click();
				toEnemyBook();
				return;
			}
			
			// click upgrade
			if (mE.target is UpgradeButton) {
				GlobalSounds.instance.click();
				toUpgradeScreen();
				return;
			}
			
			// click how to play
			if (mE.target is HowToPlayButton) {
				GlobalSounds.instance.click();
				toHowToPlayScreen();
				return;
			}
			
			// click settings
			if (mE.target is SettingsButton) {
				GlobalSounds.instance.click();
				openSettings();
				return;
			}
			
			if (mE.target is ZodiacToggleButton) {
				zodToggle.click();
			}
			
			if (mE.target is BuyAllUpgradesButton) {
				GlobalSounds.instance.click();
				toBuyAllScreen();
			}
			
			//trace(mE.target);
			
		}
		
			
		
		// Update object
		public function update() : void {
			// ???
		}
		
		
		public function toHowToPlayScreen() : void {
			removeEventListener(MouseEvent.CLICK, onClick);
			pRef.MMtoHTP();
		}
		
		public function returnFromHowToPlayScreen() : void {
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		// enemy book
		
		public function toEnemyBook() : void {
			removeEventListener(MouseEvent.CLICK, onClick);
			pRef.MMtoEB();
		}
		
		public function returnFromEnemyBook() : void {
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		// upgrade screen
		
		public function toUpgradeScreen() : void {
			removeEventListener(MouseEvent.CLICK, onClick);
			pRef.MMtoUS();
		}
		
		public function returnFromUpgradeScreen() : void {
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function toBuyAllScreen() : void {
			removeEventListener(MouseEvent.CLICK, onClick);
			pRef.MMtoBA();
		}
		
		public function returnFromBuyAllScreen() : void {
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		// settings
		
		public function openSettings() : void {
			removeEventListener(MouseEvent.CLICK, onClick);
			settingsButton.openSettings();
		}
		
		public function closeSettings() : void {
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		// set parent
		public function setParent(parRef:NewDocumentClass):void {
			pRef = parRef;
			
			pRef.updateNotifications();
		}
		
		
		// update global score
		public function setGlobalScoreText() : void {
			gs.updateDisplay();
		}
		
		
		// Destroy object and return to ObjectPool
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			pRef = null;
			
			removeChild(zodToggle);
			ObjectPool.instance.returnObj(zodToggle);
			zodToggle = null;
			
			removeChild(buyAll);
			ObjectPool.instance.returnObj(buyAll);
			buyAll = null;
			
			_destroyed = true;
			
			visible = false;
			
			removeChild(gs)
			ObjectPool.instance.returnObj(gs);
			gs = null;
			
			settingsButton.setParent(null);
			
			removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
