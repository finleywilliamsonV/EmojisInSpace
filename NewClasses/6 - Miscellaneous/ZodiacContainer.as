package {

	import flash.display.Sprite;


	public class ZodiacContainer extends Sprite {


		public function ZodiacContainer(): void {
			
		}
	
		public function setZodiac(zodiacArray : Array) : void {
			ari.visible = zodiacArray[0];
			tau.visible = zodiacArray[1];
			gem.visible = zodiacArray[2];
			can.visible = zodiacArray[3];
			leo.visible = zodiacArray[4];
			vir.visible = zodiacArray[5];
			lib.visible = zodiacArray[6];
			sco.visible = zodiacArray[7];
			sag.visible = zodiacArray[8];
			cap.visible = zodiacArray[9];
			aqu.visible = zodiacArray[10];
			pis.visible = zodiacArray[11];
		}
	}
}