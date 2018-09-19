package  {
	
	import flash.text.Font;
	import flash.text.TextFormat;
	
	public class GlobalFont extends Font {
		
		private static var _instance: GlobalFont;
		private static var _format: TextFormat;
		private static var _allowInstantiation: Boolean;
		
		public static function get instance(): GlobalFont {

			if (!_instance) {
				_allowInstantiation = true;
				_instance = new GlobalFont();
				_format = new TextFormat(_instance.fontName);
				_allowInstantiation = false;
			}

			return _instance;
		}
		
		public function get globalTextFormat(): TextFormat {
			return _format;
		}
		
		public function GlobalFont() {
			if (!_allowInstantiation) {
				throw new Error("ERROR: STOP IT FOOL, DON'T INITIALIZE!!");
			}
		}
		
	}
	
}
