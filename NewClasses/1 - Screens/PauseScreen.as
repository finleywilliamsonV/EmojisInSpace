package  {
	
	import flash.display.Sprite;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	public class PauseScreen extends Sprite implements IPoolable {
		
		
		
		// class variables
		
		private var _destroyed : Boolean;
		
		private var pRef:NewDocumentClass;
		
		
		
		// constructor
		
		public function PauseScreen() : void {
			
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
			
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		
		// onClick Function
		public function onClick(mE : MouseEvent) : void {
			
			mE.stopPropagation();
  
			var clickTarget = mE.target;
			
			if (clickTarget is PS_Button_EndGame) {
				GlobalSounds.instance.click();
				pRef.PStoGO();
			}
			else if (clickTarget is PS_Button_Resume) {
				
				pRef.PStoEG();
			}
			
			else if ( clickTarget is SFXSwitch ) {
				
				if (sfxSwitch.currentFrame == 1) {
					sfxSwitch.gotoAndStop(2);
					GlobalSounds.instance.setMuted_SFX(true);
					
				} else {
					sfxSwitch.gotoAndStop(1);
					GlobalSounds.instance.setMuted_SFX(false);
				}
				
			} else if (clickTarget is MusicSwitch ) {
				
				if (musicSwitch.currentFrame == 1) {
					musicSwitch.gotoAndStop(2);
					GlobalSounds.instance.setMuted_Music(true);
					
				} else {
					musicSwitch.gotoAndStop(1);
					GlobalSounds.instance.setMuted_Music(false);
				}
			}
			
			//else GlobalSharedObject.instance.resetSharedObject();
		}
		
		// Update object
		public function update() : void {
			// ???
		}
		
		
		// set parent
		public function setParent(parRef:NewDocumentClass):void {
			pRef = parRef;
			
			musicSwitch.gotoAndStop(GlobalSounds.instance.isMuted_Music);
			sfxSwitch.gotoAndStop(GlobalSounds.instance.isMuted_SFX);
		}
		
		
		// Destroy object and return to ObjectPool
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			pRef = null;
			
			_destroyed = true;
			
			visible = false;
			
			removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
