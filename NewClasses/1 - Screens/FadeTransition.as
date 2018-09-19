package  {
	
	import flash.display.Sprite;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.display.DisplayObject;
	import flash.filters.DisplacementMapFilter;
	
	public class FadeTransition extends Sprite implements IPoolable {
		
		
		
		// class variables
		
		private var _destroyed : Boolean;
		
		private var pRef:NewDocumentClass;
		
		private var swap1 : IPoolable;
		private var swap2 : IPoolable;
		
		private var storedFadeObj1;
		private var storedFadeObj2;
		
		
		// constructor
		
		public function FadeTransition() : void {
			
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
			
			alpha = 1;
		}
		
		// Update object
		public function update() : void {
			// ???
		}
		
		
		// set parent
		public function setParent(parRef:NewDocumentClass):void {
			pRef = parRef;
		}
		
		public function setSwap(s1 : IPoolable, s2 : IPoolable) {
			swap1 = s1;
			swap2 = s2;
		}
		
		public function fadeIn(fadeObj : DisplayObject) : void {
			
			pRef.addChild(fadeObj);
			pRef.addChild(this);

			addEventListener(Event.ENTER_FRAME, onFadeIn);
		}
		
		public function onFadeIn(e : Event) : void {

			e.stopPropagation();
			
			if (this.alpha > 0) {
				this.alpha -= .07;
			} else {
				removeEventListener(Event.ENTER_FRAME, onFadeIn);
				pRef.removeChild(this);
				ObjectPool.instance.returnObj(this);
			}
		}
		
		public function transition(obj1 : DisplayObject, obj2 : DisplayObject) : void {
			
			alpha = 0;
			
			storedFadeObj1 = obj1;
			storedFadeObj2 = obj2;
			
			pRef.addChild(this);

			addEventListener(Event.ENTER_FRAME, onTransitionFadeOut);
		}
		
		public function onTransitionFadeOut(e : Event) : void {

			e.stopPropagation();
			
			if (this.alpha < 1) {
				this.alpha += .07;
			} else {
				removeEventListener(Event.ENTER_FRAME, onTransitionFadeOut);
				
				pRef.removeChild(storedFadeObj1);
				ObjectPool.instance.returnObj(storedFadeObj1);
				
				pRef.addChild(storedFadeObj2);
				pRef.setChildIndex(this, pRef.numChildren - 1);
				addEventListener(Event.ENTER_FRAME, onTransitionFadeIn);
			}
		}
		
		public function onTransitionFadeIn(e : Event) : void {

			e.stopPropagation();
			
			if (this.alpha > 0) {
				this.alpha -= .07;
			} else {
				removeEventListener(Event.ENTER_FRAME, onTransitionFadeIn);
				pRef.removeChild(this);
				ObjectPool.instance.returnObj(this);
			}
		}

		
		// Destroy object and return to ObjectPool
		public function destroy() : void {
			
			if (_destroyed) {
				return;
			}
			
			pRef.fadeTransition = null;
			
			pRef = null;
			
			_destroyed = true;
			
			visible = false;
			
			
		}
		
		public function swap() : void {
			
		}
		
		
		// Return whether object is currently destroyed
		public function get destroyed() : Boolean {
			return _destroyed;
		}
	}
	
}
