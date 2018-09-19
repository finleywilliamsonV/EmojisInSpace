package {

	import flash.display.Sprite;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	import com.milkmangames.nativeextensions.ios.*;
	import com.milkmangames.nativeextensions.ios.events.*;
	import flash.net.SharedObject;

	public class GameOverScreen extends Sprite implements IPoolable {


		// class variables

		private var _destroyed: Boolean;

		private var pRef: NewDocumentClass;
		public var _scoreFromGameplay: int;

		public var sharedObject: SharedObject;


		// constructor

		public function GameOverScreen(): void {

			_destroyed = true;

			renew();
		}



		// Renew object to usable state
		public function renew(): void {

			if (!_destroyed) {
				return;
			}

			_destroyed = false;
			
			if (GlobalSharedObject.instance._currentLevelSelected > 1 || GlobalSharedObject.instance._infAmmoSelected || GlobalSharedObject.instance._infLivesSelected) {
				devModeActiveDisplay.visible = true;
			} else {
				devModeActiveDisplay.visible = false;
			}

			addEventListener(MouseEvent.CLICK, onClick);
		}


		// onClick Function
		public function onClick(mE: MouseEvent): void {

			mE.stopPropagation();

			if (mE.target is GO_Button_Restart) {

				GlobalSounds.instance.playSound(7);
				
				if (GlobalSharedObject.instance._numberOfChecksRemaining > 0) {
					GlobalSharedObject.instance._numberOfChecksRemaining --;
					pRef.GOtoCGM();
				} else {
					pRef.GOtoEG();
					return;
				}

			} else if (mE.target is GO_Button_MainMenu) {

				GlobalSounds.instance.click();
				pRef.GOtoMM();

			} else if (mE.target is LeaderboardsButton) {

				if (GlobalVariables.instance.checkLogin()) {
					
					if (GlobalSharedObject.instance._currentLevelSelected > 1 || GlobalSharedObject.instance._infAmmoSelected || GlobalSharedObject.instance._infLivesSelected) {
						GameCenter.gameCenter.showLeaderboardForCategory("HoL_Dev_Leaderboard");
					} else {
						GameCenter.gameCenter.showLeaderboardForCategory("HoL_Leaderboard");
					}
					
				} else {
					pRef.initiateGameCenter();
				}
			}
		}


		// Update object
		public function update(): void {
			// ???
		}


		// set parent
		public function setParent(parRef: NewDocumentClass): void {
			pRef = parRef;
		}

		// set score
		public function setFinalScore(newScore: int): void {

			GlobalVariables.instance.checkLogin();

			// store score from game
			_scoreFromGameplay = newScore;


			// set final score numbers on screen
			if (_scoreFromGameplay > 0) {

				_scoreText.text = _scoreFromGameplay.toString();
				addNewToGlobalScore(_scoreFromGameplay); // if > 0 store to global score

			} else {

				_scoreText.text = "UR BAD";
			}



			if (GlobalVariables.instance.checkLogin()) {

				if (GlobalSharedObject.instance._currentLevelSelected > 1 || GlobalSharedObject.instance._infAmmoSelected || GlobalSharedObject.instance._infLivesSelected) {

					// post score to dev mode leaderboards
					//GameServices.google.leaderboards.submitScore("CgkI_ezV2OAcEAIQBw", _scoreFromGameplay, true, "HoL_Dev");
					GameCenter.gameCenter.reportScoreForCategory(_scoreFromGameplay, "HoL_Dev_Leaderboard");
					
				} else {

					// post score to regular leaderboards
					GameCenter.gameCenter.reportScoreForCategory(_scoreFromGameplay, "HoL_Leaderboard");
				}
			}


			setFinalScoreText();
		}





		public function setFinalScoreText(): void {

			if (_scoreFromGameplay < 100) dingusText.text = "dingus";
			else if (_scoreFromGameplay < 200) dingusText.text = "Lemon";
			else if (_scoreFromGameplay < 300) dingusText.text = "Eggshell";
			else if (_scoreFromGameplay < 400) dingusText.text = "Apprentice";
			else if (_scoreFromGameplay < 500) dingusText.text = "Tiny Teacup";
			else if (_scoreFromGameplay < 750) dingusText.text = "Most Improved";
			else if (_scoreFromGameplay < 1000) dingusText.text = "Smart Lemon";
			else if (_scoreFromGameplay < 1500) dingusText.text = "Pizza Bird";
			else if (_scoreFromGameplay < 2000) dingusText.text = "Small Business";
			else if (_scoreFromGameplay < 2500) dingusText.text = "Good as Soup";
			else if (_scoreFromGameplay < 3000) dingusText.text = "Respectable";
			else if (_scoreFromGameplay < 4000) dingusText.text = "RIP H8Rs";
			else if (_scoreFromGameplay < 5000) dingusText.text = "Yeti Friend";
			else if (_scoreFromGameplay < 6000) dingusText.text = "(o.O)";
			else if (_scoreFromGameplay < 7000) dingusText.text = "Stan Banana";
			else if (_scoreFromGameplay < 8000) dingusText.text = "Log Friend";
			else if (_scoreFromGameplay < 9000) dingusText.text = "Cup o' Joe";
			else if (_scoreFromGameplay < 10000) dingusText.text = "Skills for Bills";
			else if (_scoreFromGameplay < 12500) dingusText.text = "Fern Gal";
			else if (_scoreFromGameplay < 15000) dingusText.text = "Opti-Miser";
			else if (_scoreFromGameplay < 17500) dingusText.text = "Infininte Fresh";
			else if (_scoreFromGameplay < 20000) dingusText.text = "Nekst Leval";
			else if (_scoreFromGameplay < 25000) dingusText.text = "PANDA MONEY";
			else if (_scoreFromGameplay < 30000) dingusText.text = "Dance 4 Ever";
			else if (_scoreFromGameplay < 35000) dingusText.text = "Epiphinal";
			else if (_scoreFromGameplay < 40000) dingusText.text = "Benefactor";
			else if (_scoreFromGameplay < 45000) dingusText.text = "FISH DEITY";
			else if (_scoreFromGameplay < 50000) dingusText.text = "BATTLE RAM";
			else if (_scoreFromGameplay < 60000) dingusText.text = "MECHASAURUS";
			else if (_scoreFromGameplay < 75000) dingusText.text = "ASCENDANT";
			else if (_scoreFromGameplay < 100000) dingusText.text = "DINGUS GOD";

			else dingusText.text = "Top 1337";
		}

		// store new score in global score count

		public function addNewToGlobalScore(newScore: int): void {
			GlobalSharedObject.instance.modifyBothScoreCounts(newScore);
		}


		// Destroy object and return to ObjectPool
		public function destroy(): void {

			if (_destroyed) {
				return;
			}

			pRef = null;

			_destroyed = true;

			_scoreFromGameplay = null;

			removeEventListener(MouseEvent.CLICK, onClick);
		}


		// Return whether object is currently destroyed
		public function get destroyed(): Boolean {
			return _destroyed;
		}
	}

}