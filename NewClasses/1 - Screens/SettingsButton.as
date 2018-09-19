package {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import com.milkmangames.nativeextensions.ios.*;
	import com.milkmangames.nativeextensions.ios.events.*;
	
	
	public class SettingsButton extends MovieClip {

		// private variables
		private var _destroyed: Boolean;

		private var pRef: MainMenu;

		// Constructor
		public function SettingsButton(): void {

			_destroyed = true;

			renew();
		}

		public function renew(): void {

			if (!_destroyed) {
				return;
			}

			_destroyed = false;

			x = 1296;
			y = 38;

			gotoAndStop(1);
		}

		public function update(): void {}

		public function openSettings(): void {
			gotoAndStop(2);
			addEventListener(MouseEvent.CLICK, onClick);

			optionsScreen.musicSwitch.gotoAndStop(GlobalSounds.instance.isMuted_Music);
			optionsScreen.sfxSwitch.gotoAndStop(GlobalSounds.instance.isMuted_SFX);
			
			optionsScreen.touchModeButton.gotoAndStop(GlobalSharedObject.instance.touchModeOnInt());
			
			optionsScreen.tutorialSwitch.gotoAndStop(GlobalSharedObject.instance.tutorialOnInt());
		}

		public function onClick(mE: MouseEvent): void {
			
			mE.stopPropagation();
		
			if (mE.target is SFXSwitch) {

				if (optionsScreen.sfxSwitch.currentFrame == 1) {
					optionsScreen.sfxSwitch.gotoAndStop(2);
					GlobalSounds.instance.setMuted_SFX(true);

				} else {
					optionsScreen.sfxSwitch.gotoAndStop(1);
					GlobalSounds.instance.setMuted_SFX(false);
				}

			} else if (mE.target is MusicSwitch) {

				if (optionsScreen.musicSwitch.currentFrame == 1) {
					optionsScreen.musicSwitch.gotoAndStop(2);
					GlobalSounds.instance.setMuted_Music(true);

				} else {
					optionsScreen.musicSwitch.gotoAndStop(1);
					GlobalSounds.instance.setMuted_Music(false);
				}

			} else if (mE.target is TutorialOnOffSwitch) {

				if (optionsScreen.tutorialSwitch.currentFrame == 1) {
					optionsScreen.tutorialSwitch.gotoAndStop(2);
					GlobalSharedObject.instance._tutorialOn = false;

				} else {
					optionsScreen.tutorialSwitch.gotoAndStop(1);
					GlobalSharedObject.instance._tutorialOn = true;
				}

			} else if (mE.target is TouchModeButton) {

				if (optionsScreen.touchModeButton.currentFrame == 1) {
					optionsScreen.touchModeButton.gotoAndStop(2);
					GlobalSharedObject.instance.isTouchMode = true;

				} else {
					optionsScreen.touchModeButton.gotoAndStop(1);
					GlobalSharedObject.instance.isTouchMode = false;
				}

			} else if (mE.target is CreditsButton) {
				pRef.pRef.MMtoCredits();

			} else if (mE.target is OpenSourceButton) {
				pRef.pRef.MMtoLegalScreen();

			} else if (mE.target is ExitButton) {
				closeSettings();
			}
		}

		public function closeSettings(): void {
			gotoAndStop(1);
			removeEventListener(MouseEvent.CLICK, onClick);
			pRef.closeSettings();
		}

		// set parent
		public function setParent(parRef: MainMenu): void {
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
		}

		// Return whether object is currently destroyed
		public function get destroyed(): Boolean {
			return _destroyed;
		}

	}
}