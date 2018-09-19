package  {
	
	import flash.net.SharedObject;
	import flash.utils.getQualifiedClassName;
	import flash.net.getClassByAlias;
	import flash.text.ReturnKeyLabel;
	
	public class GlobalSharedObject {
		
		private static var _instance: GlobalSharedObject;
		private static var _allowInstantiation: Boolean;
		
		private static var sharedObject:SharedObject;
		
		//private static var congratsScreen : CongratsScreen;
		
		//private static var _allZodiacsCollected : Boolean;
		
		// v v v v v
		// Stored:
		//
		//    _highScore  				-  GameOverScreen
		//    _zodiacsCollected
		//    _allZodiacsCollected
		//    _yinYangSelected
		//    _highScoreArray
		//    _globalScore
		//    _allTimeScore
		//    _laserScale
		
		//    _infAmmoSelected
		//    _infLivesSelected
		//    _currentLevelSelected
		
		//    _maxLives
		
		//    _US_Button_isPurchased[]
		//    _US_Button_isUnlocked[]
		
		//    _savedLaserClass
		
		//    _tutorialOn
		
		//    _isTouchMode
		
		//    _isGameModeChosen
		
		
		public static function get instance(): GlobalSharedObject {

			if (!_instance) {
				_allowInstantiation = true;
				_instance = new GlobalSharedObject();
				_allowInstantiation = false;
				
				sharedObject = SharedObject.getLocal( "EmojiMojo14" );
				
			}

			return _instance;
		}
		
		
		// number of checks
		
		
		public function numberOfChecksCheck() : void {
			if ( sharedObject.data._numberOfChecksRemaining == null ) {
				sharedObject.data._numberOfChecksRemaining = 3;
				sharedObject.flush();
			}
		}
		
		public function get _numberOfChecksRemaining() : int {
			numberOfChecksCheck();
			
			return sharedObject.data._numberOfChecksRemaining;
		}
		
		public function set _numberOfChecksRemaining(newInt : int) : void {
			numberOfChecksCheck();
			
			sharedObject.data._numberOfChecksRemaining = newInt;
			sharedObject.flush();
		}
		
		
		// check for game mode
		
		public function isGameModeCheck() : void {
			if ( sharedObject.data._isGameModeChosen == null) {
				sharedObject.data._isGameModeChosen = false;
				sharedObject.flush();
			}
		}
		
		public function get isGameModeChosen() : Boolean {		// t for active f for inactive
			trace("get isGameModeChosen");
			isGameModeCheck();
			
			return sharedObject.data._isGameModeChosen
			//return false;
		}
		
		public function set isGameModeChosen( tf : Boolean ) : void {
			trace("set isGameModeChosen to " + tf);
			isGameModeCheck();
			
			sharedObject.data._isGameModeChosen = tf;
			sharedObject.flush();
		}

		// touch mode switch
		
		public function touchModeCheck() : void {
			if ( sharedObject.data._isTouchMode == null ) {
				sharedObject.data._isTouchMode = false;
				sharedObject.flush();
			}
		}
		
		public function touchModeOnInt() : int {		// 2 for active 1 for inactive
			trace("touchModeOnInt()");
			touchModeCheck();
			
			if (sharedObject.data._isTouchMode) {
				return 2;
			} else {
				return 1;
			}
		}
		
		public function get isTouchMode() : Boolean {		// t for active f for inactive
			trace("get isTouchMode()");
			touchModeCheck();
			
			return sharedObject.data._isTouchMode;
		}
		
		public function set isTouchMode( tf : Boolean ) : void {
			trace("set isTouchMode to " + tf);
			touchModeCheck();
			
			sharedObject.data._isTouchMode = tf;
			sharedObject.flush();
			//trace(" - - result: " + sharedObject.data._isTouchMode);
		}
		
		
		// tutorial switch
		
		public function tutorialCheck() : void {
			if ( sharedObject.data._tutorialOn == null ) {
				sharedObject.data._tutorialOn = true;
				sharedObject.flush();
			}
		}
		
		public function tutorialOnInt() : int {		// 1 for active 0 for inactive
			tutorialCheck();
			
			if (sharedObject.data._tutorialOn) {
				return 1;
			} else {
				return 2;
			}
		}
		
		public function get _tutorialOn() : Boolean {		// 1 for active 0 for inactive
			tutorialCheck();
			
			return sharedObject.data._tutorialOn;
		}
		
		public function set _tutorialOn( tf : Boolean ) : void {
			tutorialCheck();
			
			sharedObject.data._tutorialOn = tf;
			sharedObject.flush();
		}
		
		
		
		// Developer Mode
		
		public function get _devModePurchased() : Boolean {
			if ( sharedObject.data._devModePurchased == null ) {
				sharedObject.data._devModePurchased = false;
				sharedObject.flush();
			}
			
			return sharedObject.data._devModePurchased;
		}
		
		public function set _devModePurchased( tf : Boolean ) : void {
			sharedObject.data._devModePurchased = tf;
			sharedObject.flush();
		}
		
		
		
		//    _infAmmoSelected
		
		public function get _infAmmoSelected() : Boolean {
			if ( sharedObject.data._infAmmoSelected == null ) {
				sharedObject.data._infAmmoSelected = false;
				sharedObject.flush();
			}
			
			return sharedObject.data._infAmmoSelected;
		}
		
		public function set _infAmmoSelected( tf : Boolean ) : void {
			sharedObject.data._infAmmoSelected = tf;
			sharedObject.flush();
		}
		
		
		
		//    _infLivesSelected
		
		public function get _infLivesSelected() : Boolean {
			if ( sharedObject.data._infLivesSelected == null ) {
				sharedObject.data._infLivesSelected = false;
				sharedObject.flush();
			}
			
			return sharedObject.data._infLivesSelected;
		}
		
		public function set _infLivesSelected( tf : Boolean ) : void {
			sharedObject.data._infLivesSelected = tf;
			sharedObject.flush();
		}
	
		

		//    _currentLevelSelected
		
		public function get _currentLevelSelected() : int {
			if ( sharedObject.data._currentLevelSelected == null ) {
				sharedObject.data._currentLevelSelected = 1;
				sharedObject.flush();
			}
			
			return sharedObject.data._currentLevelSelected;
		}
		
		public function set _currentLevelSelected( lvl : int) : void {
			sharedObject.data._currentLevelSelected = lvl;
			sharedObject.flush();
		}
		
		
		// Check High Score
		
		public function checkHighScore( newScore : int ) : void {
			
			if ( sharedObject.data._highScore == null ) {
					sharedObject.data._highScore = newScore;
					
				} else if ( newScore > sharedObject.data._highScore) {
					sharedObject.data._highScore = newScore;
				}
				
				sharedObject.flush();
		}
		
		// Get High Score
		
		public function get _highScore() : int {
			
			if ( sharedObject.data._highScore == null ) {
				sharedObject.data._highScore = 0;
				sharedObject.flush();
			}
				
			return sharedObject.data._highScore;
		}
		
		
		
		// Check High Score Array
		
		public function checkHighScoreArray( newScore : int ) : int {  		// returns index of name to change
			
			//text 0 , 2 , 4
			//nums 1 , 3 , 5
			
			var nameToChange : int = -1;
			
			if ( sharedObject.data._highScoreArray == null ) {
				sharedObject.data._highScoreArray = ["Felbert", 5555, "Delbert", 3333, "Melbert", 1111];
				sharedObject.flush();
			}
			
			if (newScore > sharedObject.data._highScoreArray[1]) {
				nameToChange = 0;
				sharedObject.data._highScoreArray[5] = sharedObject.data._highScoreArray[3];
				sharedObject.data._highScoreArray[4] = sharedObject.data._highScoreArray[2];
				sharedObject.data._highScoreArray[3] = sharedObject.data._highScoreArray[1];
				sharedObject.data._highScoreArray[2] = sharedObject.data._highScoreArray[0];
				sharedObject.data._highScoreArray[1] = newScore;
				
			} else if (newScore > sharedObject.data._highScoreArray[3]) {
				nameToChange = 2;
				sharedObject.data._highScoreArray[5] = sharedObject.data._highScoreArray[3];
				sharedObject.data._highScoreArray[4] = sharedObject.data._highScoreArray[2];
				sharedObject.data._highScoreArray[3] = newScore;
				
			} else if (newScore > sharedObject.data._highScoreArray[5]) {
				nameToChange = 4;
				sharedObject.data._highScoreArray[5] = newScore;
			}
			
			sharedObject.flush();
			
			return(nameToChange);
		}
		
		
		
		// change high score name
		
		public function changeHighScoreName( nameIndex : int, newName : String ) : void {
			
			sharedObject.data._highScoreArray[nameIndex] = newName;
			sharedObject.flush();
		}
		
		
		// Get High Score Array
		
		public function get _highScoreArray() : Array {
			
			if ( sharedObject.data._highScoreArray == null ) {
				sharedObject.data._highScoreArray = ["Felbert", 5555, "Delbert", 333, "Melbert", 111];
				sharedObject.flush();
			}
			return sharedObject.data._highScoreArray;
		}
		
		
		// Check Zodiac Container
		
		public function get _zodiacsCollected() : Array {
			
			if (sharedObject.data._zodiacsCollected == null) {
				sharedObject.data._zodiacsCollected = [false, false, false, false, false, false, false, false, false, false, false, false];
				sharedObject.flush();
			}
			
			return sharedObject.data._zodiacsCollected;
		}
		
		
		
		// Record new zodiac
		
		public function recordNewZodiac(zodNum : int) : void {
			sharedObject.data._zodiacsCollected[zodNum - 1] = true;
			sharedObject.flush();
 		}
		
		
		
		
		
		// methods for yin yang selector button
		
		public function get _yinYangSelected() : Boolean {
			checkYinYangSelected();
			return sharedObject.data._yinYangSelected;
		}
		
		public function set _yinYangSelected(tf : Boolean) : void {
			checkYinYangSelected();
			sharedObject.data._yinYangSelected = tf;
			sharedObject.flush();
		}
		
		public function checkYinYangSelected() : void {
			
			if (sharedObject.data._yinYangSelected == null) {
				sharedObject.data._yinYangSelected = false;
				sharedObject.flush();
			}
			
		}
		
		
		// check if all zodiacs have been collected
		
		public function checkForAllZod() : void {
			
			if (sharedObject.data._allZodiacsCollected == null) {
				sharedObject.data._allZodiacsCollected = false;
				sharedObject.flush();
			}
			
			var tempBoolean : Boolean = true;
			for (var i : int = 0; i < 12; i++) {
				if (sharedObject.data._zodiacsCollected[i] == false) {
					tempBoolean = false;
				}
			}
			
			sharedObject.data._allZodiacsCollected = tempBoolean;
			sharedObject.flush();
		}

		
		// return true if all zodiacs collected
		
		public function get _allZodiacsCollected() : Boolean {
			checkForAllZod();
			return sharedObject.data._allZodiacsCollected;
		}
		

		public function checkScores() : void {
			
			if ( sharedObject.data._globalScore == null ) {
				sharedObject.data._globalScore = 0;
				sharedObject.flush();
			}
			
			if (sharedObject.data._allTimeScore == null) {
				sharedObject.data._allTimeScore = 0;
				sharedObject.flush();
			}
		}
		
		
		// set global score
		
		public function setGlobalScoreToAllTime() : void {
			
			checkScores();
			
			sharedObject.data._globalScore = sharedObject.data._allTimeScore;
			sharedObject.flush();
		}
		
		// modify global score
		
		public function modifyGlobalScore( plusMinus : int ) : void {
			
			checkScores();
			
			sharedObject.data._globalScore += plusMinus;
			sharedObject.flush();
		}
		
		// modify both scores
		
		public function modifyBothScoreCounts( plusMinus : int ) : void {
			
			checkScores();
			
			sharedObject.data._globalScore += plusMinus;
			sharedObject.data._allTimeScore += plusMinus;
			sharedObject.flush();
		}
		
		// return global score
		
		public function get _globalScore() : int {
			
			if ( sharedObject.data._globalScore == null ) {
				sharedObject.data._globalScore = 0;
				sharedObject.flush();
			}
				
			return sharedObject.data._globalScore;
		}
		

		// GET LASER SCALE
		public function get laserScale() : Number {
			
			if ( sharedObject.data._laserScale == null ) {
				sharedObject.data._laserScale = 1;
				sharedObject.flush();
			}
			
			return sharedObject.data._laserScale;
		}
		
		// SET LASER SCALE
		public function modifyLaserScale( newScale : Number) : void {
			if ( sharedObject.data._laserScale == null ) {
				sharedObject.data._laserScale = 1;
				sharedObject.flush();
			}
			
			sharedObject.data._laserScale = newScale;
			sharedObject.flush();
		}
		
		
		/* STORE 		
		
			inlcudes:
			- _maxLives
		
		*/
		
		
		// dev mode high score
		
		public function devScoreCheck() : void {
			if (sharedObject.data._devModeHighScore == null) {
				sharedObject.data._devModeHighScore = 1;
				sharedObject.flush();
			}
		}
		
		// Get dev high score
		public function get devModeHighScore() : int {
			
			devScoreCheck();
			
			return sharedObject.data._devModeHighScore;
		}
		
		// Set dev high score
		public function set devModeHighScore( newScore : int) : void {
			
			devScoreCheck();
			
			sharedObject.data._devModeHighScore = newScore;
			sharedObject.flush();
		}
		
		
		
		// max lives
		
		public function maxLivesCheck() : void {
			
			if (sharedObject.data._maxLives == null) {
				sharedObject.data._maxLives = 3;
				sharedObject.flush();
			}
		}
		
		// Get max lives
		public function get maxLives() : int {
			
			maxLivesCheck();
			
			return sharedObject.data._maxLives;
		}
		
		// Set max lives
		public function modifyMaxLives( plusMinus : int) : void {
			
			maxLivesCheck();
			
			sharedObject.data._maxLives += plusMinus;
			sharedObject.flush();
		}
		

		// is purchased check
		public function isPurchasedCheck() : void {
			
			if (sharedObject.data._isPurchased == null) {
				sharedObject.data._isPurchased = [false, false, false, false, false, false, false, false, false];
				sharedObject.flush();
			}
		}
		
		// get Upgrade Screen is purchased
		public function get isPurchased() : Array {
			isPurchasedCheck();
			return sharedObject.data._isPurchased;
		}
		
		// mod is purchased
		public function modifyIsPurchased(index : int, setTo : Boolean) : void {
			isPurchasedCheck();
			sharedObject.data._isPurchased[index] = setTo;
			sharedObject.flush();
		}
		
		
		
		// is unlocked check
		public function isUnlockedCheck() : void {
			
			if (sharedObject.data._isUnlocked == null) {
				sharedObject.data._isUnlocked = [true, false, false, true, false, false, true, false, false];
				sharedObject.flush();
			}
		}
		
		// get Upgrade Screen is purchased
		public function get isUnlocked() : Array {
			isUnlockedCheck();
			return sharedObject.data._isUnlocked;
		}
		
		// mod is purchased
		public function modifyIsUnlocked(index : int, setTo : Boolean) : void {
			isUnlockedCheck();
			sharedObject.data._isUnlocked[index] = setTo;
			sharedObject.flush();
		}
		
		
		
		// *** reset function ***
		
		public function resetSharedObject() : void {
			sharedObject.clear();
			sharedObject = SharedObject.getLocal( "EmojiMojo14" );
		}
		
		
		// reset purchases
		//	- resets state of all purchases
		//	- resets isUnlocked
		//  - sets global score equal to all time score
		
		public function resetPurchases() : void {
			sharedObject.data._laserScale = null;
			sharedObject.data._maxLives = null;
			sharedObject.data._isPurchased = null;
			sharedObject.data._isUnlocked = null;
			
			sharedObject.flush();
			
			setGlobalScoreToAllTime();
		
		}
		
		public function GlobalSharedObject() : void {
			if (!_allowInstantiation) {
				throw new Error("ERROR: STOP IT FOOL, DON'T INITIALIZE!!");
			}
		}
		
	}
	
}
