package  {
	
	//
	//	Includes All Enemies, Shots, and Items.
	//
	public interface IGameObject {

		//var pRef : EmojiGameplay;
		//var pVec : Vector.<IPoolable>;
		
		// set vector
		function setVector(parentVector : Vector.<IPoolable>):void;
		
		// update
		function update() : void;
		
		// set parent
		//function setParent(parRef:NewEmojiGameplay):void;
	}
	
}
