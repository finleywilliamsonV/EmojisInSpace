package  {
	
	import flash.display.MovieClip;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	public class HowToPlayScreen extends MovieClip implements IPoolable {
		
		
		// class variables
		
		private var _destroyed : Boolean;
		
		public var pRef:NewDocumentClass;
		
		private var _howToPlayAvatar : HowToPlayAvatar;
		private var _flashingFruits : FlashingFruit;
		private var _phoneWithDirections : PhoneWithDirections;
		private var _comboDisplay : ComboDisplay;
		private var _zodiacHowTo : ZodiacHowTo;
		
		
		// constructor
		public function HowToPlayScreen() {
			
			_destroyed = true;
			
			stop();
			
			renew();
		}
		
		
		// Renew object to usable state
		public function renew() : void {
			
			if (!_destroyed) {
				return;
			}
			
			_destroyed = false;
			
			
			
			// HowToPlayAvatar
			
			_howToPlayAvatar = ObjectPool.instance.getObj(HowToPlayAvatar) as HowToPlayAvatar;
			_howToPlayAvatar.x = 200;
			_howToPlayAvatar.y = 210;
			_howToPlayAvatar.setParent(this);
			
			
			// FlashingFruit
			
			_flashingFruits = ObjectPool.instance.getObj(FlashingFruit) as FlashingFruit;
			_flashingFruits.x = -230;
			_flashingFruits.y = 110;
			_flashingFruits.setParent(this);
			
			
			// PhoneWithDirections
			
			_phoneWithDirections = ObjectPool.instance.getObj(PhoneWithDirections) as PhoneWithDirections;
			_phoneWithDirections.x = 367;
			_phoneWithDirections.y = 5;
			_phoneWithDirections.setParent(this);
			
			
			// ComboDisplay
			
			_comboDisplay = ObjectPool.instance.getObj(ComboDisplay) as ComboDisplay;
			_comboDisplay.x = 224;
			_comboDisplay.y = 66.7;
			_comboDisplay.setParent(this);
			
			
			// ZodiacHowTo
			
			_zodiacHowTo = ObjectPool.instance.getObj(ZodiacHowTo) as ZodiacHowTo;
			_zodiacHowTo.x = 0;
			_zodiacHowTo.y = 66.7;
			_zodiacHowTo.setParent(this);
			
			openPage(1);
		}
		
		
		// onClick Function
		public function onClick(mE : MouseEvent) : void {
			
			mE.stopPropagation();
			
			
			
			
			if (mE.target is BackButton) {
				closePage(currentFrame);
				gotoAndStop(currentFrame - 1);
				openPage(currentFrame);
			}
			
			else if (mE.target is ForwardButton) {
				closePage(currentFrame);
				gotoAndStop(currentFrame + 1);
				openPage(currentFrame);
			}
			
			else if (mE.target is ExitButton) {
				pRef.HTPtoMM();
				return;
			}
		}
		
		// Update object
		public function update() : void {
			// ???
		}
		
		private function openPage(num : int) : void {
			
			if (num == 1) {
				
				addChild(_howToPlayAvatar);
				_howToPlayAvatar.play();
				
				addChild(_flashingFruits);
				_flashingFruits.play();
				
				addChild(_phoneWithDirections);
				_phoneWithDirections.play();
				
			} else if (num == 2) {
				
				addChild(_comboDisplay);
				_comboDisplay.play();
				
			} else {
				
				addChild(_zodiacHowTo);
				_zodiacHowTo.play();
			}
		}
		
		private function closePage(num : int) : void {
			
			if (num == 1) {
				
				removeChild(_howToPlayAvatar);
				_howToPlayAvatar.gotoAndStop(1);
				
				removeChild(_flashingFruits);
				_flashingFruits.gotoAndStop(1);
				
				removeChild(_phoneWithDirections);
				_phoneWithDirections.gotoAndStop(1);
				
			} else if (num == 2) {
				
				removeChild(_comboDisplay);
				_comboDisplay.gotoAndStop(1);
				
			} else {
				
				removeChild(_zodiacHowTo);
				_zodiacHowTo.gotoAndStop(1);
			}
		}
		
		
		
		
		public function setup() : void {
			stage.addEventListener(MouseEvent.CLICK, onClick);
			gotoAndStop(1);
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
			
			closePage(currentFrame);
			
			gotoAndStop(1);
			
			ObjectPool.instance.returnObj(_howToPlayAvatar);
			ObjectPool.instance.returnObj(_flashingFruits);
			ObjectPool.instance.returnObj(_phoneWithDirections);
			ObjectPool.instance.returnObj(_comboDisplay);
			ObjectPool.instance.returnObj(_zodiacHowTo);
			_howToPlayAvatar = null;
			_flashingFruits = null;
			_phoneWithDirections = null;
			_comboDisplay = null;
			_zodiacHowTo = null;
			
			stage.removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
		
	}
}
