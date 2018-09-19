package  {
	
	public interface ILevel {

		function ILevel():void;

		function update():void;

		function setParent(pRef:NewEmojiGameplay):void;
		
		function changeLevels(): void;
		
		function destroy():void;
	}
	
}
