package  {
	
	public interface ISituation {

		// Interface methods:
		function renew() : void;
		function update() : void;
		function setup(parRef: NewEmojiGameplay, newClass : Class, newDropCount : int, newTicksPerDrop : int, newRemoveCount : int) : void;
		function setupItem(parRef: NewEmojiGameplay, newClass : Class, newDropCount : int, newTicksPerDrop : int, newRemoveCount : int) : void;
		function destroy() : void;
	}
	
}
