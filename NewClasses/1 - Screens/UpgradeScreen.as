package  {
	
	import flash.display.Sprite;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import avmplus.describeType;
	
	public class UpgradeScreen extends Sprite implements IPoolable {
		
		
		// class variables
		
		private var _destroyed : Boolean;
		
		public var pRef:NewDocumentClass;
		
		public var _currentUpgradeSelected;
		
		public var _storedUpgradeButton : UpgradeButton;
		
		public var _lastUpgradeButtonPressed;
		
		public var US_gs : GlobalScoreDisplay;
		
		// constructor
		public function UpgradeScreen() {
			
			_destroyed = true;
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			US_gs = ObjectPool.instance.getObj(GlobalScoreDisplay) as GlobalScoreDisplay;
			addChild(US_gs);
			setChildIndex(US_gs, numChildren-1);
			
			
			
			//US_gs.x = 895;
			//US_gs.y = 71;
		}
		
		
		// onClick Function
		public function onClick(mE : MouseEvent) : void {
			
			mE.stopPropagation();

			var clickTarget = mE.target;
			
			if (clickTarget is US_Button_Shadow) clickTarget = clickTarget.parent;
				
			if ( clickTarget is US_Button_BuyIt && _currentUpgradeSelected) {
				
				if ( (!_currentUpgradeSelected._isPurchased) && _currentUpgradeSelected._isUnlocked && GlobalSharedObject.instance._globalScore >= _currentUpgradeSelected._price ) {
					_currentUpgradeSelected.purchase(this);
					buyItButton.shadow.visible = true;
					US_gs.updateDisplay();
					updateNotifications(_storedUpgradeButton);
					
					if (_currentUpgradeSelected._isPurchased) {
						descriptionText.text = _currentUpgradeSelected._description + "  (PURCHASED!)";
					} else {
						descriptionText.text = _currentUpgradeSelected._description;
					}
				}
				
			} else if ( clickTarget is IUpgradeScreenButton ) {
				
				
				if ( _currentUpgradeSelected ) {
					
					/* if the button pressed is different
					if ( _lastUpgradeButtonPressed != clickTarget ) {
						GlobalSounds.instance.click();
						_lastUpgradeButtonPressed = clickTarget;
					}
					*/

					
					if ( _currentUpgradeSelected != clickTarget ) {
						_currentUpgradeSelected.isSelectedGraphic.visible = false;
					}
						
				}
					
					
				
				if (clickTarget._isPurchased) {
					descriptionText.text = clickTarget._description + "  (PURCHASED!)";
				} else {
					descriptionText.text = clickTarget._description;
				}
				
				upgradeCostText.text = clickTarget._price;
				buyItButton.shadow.visible = clickTarget._isPurchased;
				_currentUpgradeSelected = clickTarget;
				_currentUpgradeSelected.isSelectedGraphic.visible = true;
				
			} else if (clickTarget is ExitButton) {
				pRef.UStoMM();
				
			} else if (clickTarget is ResetPurchaseButton) {
				clickTarget.click(this);
			} 
				
		}
		
		// Update object
		public function update() : void {
			// ???
		}
		
		// Update Notification Icons
		public function updateNotifications(mm_upgradeButton : UpgradeButton) : void {
			
			_storedUpgradeButton = mm_upgradeButton;
			
			var anyNotifications : Boolean = false;
			var tempGlobalScore : int = GlobalSharedObject.instance._globalScore;
			var newNotificationIcon;
			
			if (a1._price <= tempGlobalScore && a1._isPurchased == false) {
				newNotificationIcon = ObjectPool.instance.getObj(NotificationIcon) as NotificationIcon;
				a1.addChild(newNotificationIcon);
				anyNotifications = true;
				
			} else {
				removeIcon(a1);
			}
			
			if (a2._price <= tempGlobalScore && a2._isPurchased == false) {
				newNotificationIcon = ObjectPool.instance.getObj(NotificationIcon) as NotificationIcon;
				a2.addChild(newNotificationIcon);
				anyNotifications = true;
				
			} else {
				removeIcon(a2);
			}
			
			if (a3._price <= tempGlobalScore && a3._isPurchased == false) {
				newNotificationIcon = ObjectPool.instance.getObj(NotificationIcon) as NotificationIcon;
				a3.addChild(newNotificationIcon);
				anyNotifications = true;
				
			} else {
				removeIcon(a3);
			}
			
			if (b1._price <= tempGlobalScore && b1._isPurchased == false) {
				newNotificationIcon = ObjectPool.instance.getObj(NotificationIcon) as NotificationIcon;
				b1.addChild(newNotificationIcon);
				anyNotifications = true;
				
			} else {
				removeIcon(b1);
			}
			
			if (b2._price <= tempGlobalScore && b2._isPurchased == false) {
				newNotificationIcon = ObjectPool.instance.getObj(NotificationIcon) as NotificationIcon;
				b2.addChild(newNotificationIcon);
				anyNotifications = true;
				
			} else {
				removeIcon(b2);
			}
			
			if (b3._price <= tempGlobalScore && b3._isPurchased == false) {
				newNotificationIcon = ObjectPool.instance.getObj(NotificationIcon) as NotificationIcon;
				b3.addChild(newNotificationIcon);
				anyNotifications = true;
				
			} else {
				removeIcon(b3);
			}
			
			if (c1._price <= tempGlobalScore && c1._isPurchased == false) {
				newNotificationIcon = ObjectPool.instance.getObj(NotificationIcon) as NotificationIcon;
				c1.addChild(newNotificationIcon);
				anyNotifications = true;
				
			} else {
				removeIcon(c1);
			}
			
			if (c2._price <= tempGlobalScore && c2._isPurchased == false) {
				newNotificationIcon = ObjectPool.instance.getObj(NotificationIcon) as NotificationIcon;
				c2.addChild(newNotificationIcon);
				anyNotifications = true;
				
			} else {
				removeIcon(c2);
			}
			
			if (c3._price <= tempGlobalScore && c3._isPurchased == false) {
				newNotificationIcon = ObjectPool.instance.getObj(NotificationIcon) as NotificationIcon;
				c3.addChild(newNotificationIcon);
				anyNotifications = true;
			} else {
				removeIcon(c3);
			}
			
			if (anyNotifications) {
				newNotificationIcon = ObjectPool.instance.getObj(NotificationIcon) as NotificationIcon;
				_storedUpgradeButton.addChild(newNotificationIcon);
				newNotificationIcon.x = 150;
				newNotificationIcon.y = -35;
			} else {
				removeIcon(_storedUpgradeButton);
			}
		}
		
		public function removeIcon(objCont : *) : void {
			for (var i : int = objCont.numChildren - 1; i >= 0; i--) {
				if (objCont.getChildAt(i) is NotificationIcon) {
					var tempObj = objCont.removeChildAt(i);
					ObjectPool.instance.returnObj(tempObj);
				}
			}
		}
		
		public function setup() : void {
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
			
			buyItButton.shadow.visible = false;
			
			var temp : Array = GlobalSharedObject.instance.isPurchased;
			
			a1.isSelectedGraphic.visible = false;
			a2.isSelectedGraphic.visible = false;
			a3.isSelectedGraphic.visible = false;
			b1.isSelectedGraphic.visible = false;
			b2.isSelectedGraphic.visible = false;
			b3.isSelectedGraphic.visible = false;
			c1.isSelectedGraphic.visible = false;
			c2.isSelectedGraphic.visible = false;
			c3.isSelectedGraphic.visible = false;
			
			a1.shadow.visible = temp[0];
			a2.shadow.visible = temp[1];
			a3.shadow.visible = temp[2];
			b1.shadow.visible = temp[3];
			b2.shadow.visible = temp[4];
			b3.shadow.visible = temp[5];
			c1.shadow.visible = temp[6];
			c2.shadow.visible = temp[7];
			c3.shadow.visible = temp[8];
			
			temp = GlobalSharedObject.instance.isUnlocked;
			
			a1.visible = temp[0];
			a2.visible = temp[1];
			a3.visible = temp[2];
			b1.visible = temp[3];
			b2.visible = temp[4];
			b3.visible = temp[5];
			c1.visible = temp[6];
			c2.visible = temp[7];
			c3.visible = temp[8];
			
			descriptionText.text = "Click an Upgrade to Learn More";
			
			updateNotifications(_storedUpgradeButton);
		}
		
		public function resetIsPurchased() : void {
			a1.reset();
			a2.reset();
			a3.reset();
			b1.reset();
			b2.reset();
			b3.reset();
			c1.reset();
			c2.reset();
			c3.reset();
		}
		
		
		// set parent
		public function setParent(parRef:NewDocumentClass):void {
			pRef = parRef;
		}
		
		
		// Destroy object and return to ObjectPool
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			pRef = null;
			
			_destroyed = true;
			
			//maxLivesText.text = "";
			
			if (stage) {
				stage.removeEventListener(MouseEvent.CLICK, onClick);
			}
			
			
			_currentUpgradeSelected = null;
			_lastUpgradeButtonPressed = null;
			//_storedUpgradeButton = null;
			
			removeChild(US_gs);
			ObjectPool.instance.returnObj(US_gs);
			US_gs = null;
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
	}
}
