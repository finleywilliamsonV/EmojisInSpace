package  {
	
	import flash.media.SoundChannel;	
	import flash.media.SoundTransform;
	import flash.media.Sound;
	import flash.events.Event;
	
	
	public class GlobalSounds {
		
		private static var _instance: GlobalSounds;
		private static var _allowInstantiation: Boolean;
		
		// declare sounds
		
		private static var _sfxSoundChannel : SoundChannel;
		private static var _bgmSoundChannel : SoundChannel;
		private static var _soundArray : Array;
		private static var _hasSound : Boolean;
		
		private static var _100 : SoundTransform;
		private static var _85 : SoundTransform;
		private static var _75 : SoundTransform;
		private static var _66 : SoundTransform;
		private static var _50 : SoundTransform;
		private static var _25 : SoundTransform;
		private static var _MUTE : SoundTransform;
		
		private static var _stab : Sound_Stab;
		private static var _swipe : Sound_Swipe;
		
		private static var _kickLow : Sound_KickLow;
		private static var _kickMed : Sound_KickMed;
		
		private static var _blipLow : Sound_BlipLow;
		private static var _blipMed : Sound_BlipMed;
		private static var _blipHigh : Sound_BlipHigh;
		
		private static var _jingleHigh : Sound_JingleHigh;
		
		private static var _click : Sound_Click;
		
		private static var _bgm_short : BackgroundMusic_Short;
		
		private static var _ouch_1 : Ouch_1;
		private static var _ouch_2 : Ouch_2;
		private static var _ouch_3 : Ouch_3;
		private static var _ouch_4 : Ouch_4;
		private static var _ouch_5 : Ouch_5;
		private static var _ouch_6 : Ouch_6;
		
		private static var _isMuted_SFX : Boolean;
		private static var _isMuted_Music : Boolean;
		
		
		private static var _songPosition : Number;
		
		
		
		
		
		public static function get instance(): GlobalSounds {

			if (!_instance) {
				
				// instantiate instance
				_allowInstantiation = true;
				_instance = new GlobalSounds();
				_allowInstantiation = false;
				
				
				// song position
				_songPosition = 0;
				
				// instantiate sound array, transform
				_soundArray = new Array(false, false, false, false, false, false, false, false, false, false, false, false, false, false, false);				// add more booleans w/ more sounds
				_hasSound = false;
				
				_100 = new SoundTransform(1, 0);
				_85 = new SoundTransform(.85, 0);
				_75 = new SoundTransform(.75, 0);
				_66 = new SoundTransform(.66, 0);
				_50 = new SoundTransform(.5, 0);
				_25 = new SoundTransform(.25, 0);
				_MUTE = new SoundTransform(0, 0);
				
				// instantiate sound fx
				_stab = new Sound_Stab();
				_swipe = new Sound_Swipe();
				
				_kickLow = new Sound_KickLow();
				_kickMed = new Sound_KickMed();
				
				_blipLow = new Sound_BlipLow();
				_blipMed = new Sound_BlipMed();
				_blipHigh = new Sound_BlipHigh();
				
				_jingleHigh = new Sound_JingleHigh();
				
				_click = new Sound_Click();
				
				_bgm_short = new BackgroundMusic_Short();
				
				_ouch_1 = new Ouch_1();
				_ouch_2 = new Ouch_2();
				_ouch_3 = new Ouch_3();
				_ouch_4 = new Ouch_4();
				_ouch_5 = new Ouch_5();
				_ouch_6 = new Ouch_6();
				
				// mute feature
				_isMuted_SFX = false;
				_isMuted_Music = false;
			}

			return _instance;
		}
		
		
		public function get songPosition() : Number {
			return _songPosition;
		}
		
		public function set songPosition( newPosition : Number) : void {
			_songPosition = newPosition;
		}
		
		public function get bgmSoundChannel() : SoundChannel {
			return _bgmSoundChannel;
		}
		
		public function get sfxSoundChannel() : SoundChannel {
			return _sfxSoundChannel;
		}
		
		public function setMuted_SFX(tf : Boolean) : void {
			_isMuted_SFX = tf;
		}
		
		public function setMuted_Music(tf : Boolean) : void {
			_isMuted_Music = tf;
			
			trace("Song Position on setMuted_Music: " + _bgmSoundChannel.position);
			
			//trace("\nSetMuted_Music Called:");
			
			if (_isMuted_Music) {
				_bgmSoundChannel.soundTransform = _MUTE;
				//trace("BGM muted\n");
				
			} else {
				_bgmSoundChannel.soundTransform = _66;
				//trace("BGM unmuted\n");
			}
		}
		
		public function get isMuted_Music() : int {	//returns 2 for muted, 1 for not muted
			if (_isMuted_Music) return 2;
			else return 1;
		}
		
		public function get isMuted_SFX() : int {
			if (_isMuted_SFX) return 2;
			else return 1;
		}
		
		public function setSound(which : int) : void {
			_soundArray[which] = true;
			_hasSound = true;
		}
		
		public function playSound(which : int) : void {
			setSound(which);
			playAllSounds();
		}
		
		public function playBGM() : void {
			
			//if (!_isMuted_Music){
			
				//trace("playBGM");
				//trace(_isMuted_Music);
				//trace(_songPosition);
				
				 // android!
				//_bgmSoundChannel = _bgm_short.play(_songPosition,1,_66);
				//_bgmSoundChannel = _bgm_short.play(0,1,_75);
			
				//_bgmSoundChannel.addEventListener(Event.SOUND_COMPLETE, soundComplete);
				_bgmSoundChannel = _bgm_short.play(0, 99999,_66);
			
				setMuted_Music(_isMuted_Music);
			
			
				 // android!
				//bgmSoundChannel.addEventListener(Event.SOUND_COMPLETE, soundComplete, false, 0, true);
				
				
			//}
			
		}
		
		private function soundComplete( e : Event)  : void {
			//trace("soundComplete");
			_bgmSoundChannel.removeEventListener(Event.SOUND_COMPLETE, soundComplete);
			_songPosition = 0;
			playBGM();
		}
		
		public function stopAll() : void {
			_sfxSoundChannel.stop();
			_bgmSoundChannel.stop();
		}
		
		public function click() : void {
			setSound(14);
			playAllSounds();
		}
		
		public function ouch() : void {
			setSound(1 + int(Math.random() * 6) + 7);
		}
		
		// play all sounds
		public function playAllSounds() : void {
			
			if (_hasSound) {
				
				// laser
				if (_soundArray[0]) {
					playHelper(0, _stab, _50);
				}
				
				// bigs, luvies, fall guys
				if (_soundArray[1]) {
					playHelper(1, _swipe,_25);
				}
				
				// explosion
				if (_soundArray[2]) {
					playHelper(2, _kickLow, _100);
				}
				
				// avatar death
				if (_soundArray[3]) {
					playHelper(3, _kickMed, _100);
				}
				
				// item pickup 1
				if (_soundArray[4]) {
					playHelper(4, _blipLow, _100);
				}
				
				// item pickup 2
				if (_soundArray[5]) {
					playHelper(5, _blipMed, _100);
				}
				
				// item pickup 3
				if (_soundArray[6]) {
					playHelper(6, _blipHigh, _100);
				}
				
				// menus
				if (_soundArray[7]) {
					playHelper(7, _jingleHigh,_75); 
				}
				
				// ouch
				if (_soundArray[8]) {
					playHelper(8, _ouch_1,_25); 
				}
				
				if (_soundArray[9]) {
					playHelper(9, _ouch_2,_25); 
				}
				
				if (_soundArray[10]) {
					playHelper(10, _ouch_3,_25); 
				}
				
				if (_soundArray[11]) {
					playHelper(11, _ouch_4,_25); 
				}
				
				if (_soundArray[12]) {
					playHelper(12, _ouch_5,_50); 
				}
				
				if (_soundArray[13]) {
					playHelper(13, _ouch_6,_25); 
				}
				
				if (_soundArray[14]) {
					playHelper(14, _click,_50); 
				}
				
				_hasSound = false;
			}
				
		}
		
		private function playHelper(index : int, sound : *, sT : SoundTransform) {
			if (!(_isMuted_SFX)) {
				_sfxSoundChannel = sound.play(0,0,sT);			// can be simplified if sounds are at the appropriate volume
			}
			_soundArray[index] = false;
		}
		
		// singleton constructor - unused
		public function GlobalSounds() {
			if (!_allowInstantiation) {
				throw new Error("ERROR: STOP IT FOOL, DON'T INITIALIZE!!");
			}
		}
		
	}
	
}
