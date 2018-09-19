

/*		MY OBJECT POOL		*/

package {

	import flash.utils.getQualifiedClassName;

	public class ObjectPool {

		private static var _instance: ObjectPool;
		private static var _allowInstantiation: Boolean;

		private var _pools: Object;

		
		public static function get instance(): ObjectPool {

			if (!_instance) {
				_allowInstantiation = true;
				_instance = new ObjectPool();
				_allowInstantiation = false;
			}

			return _instance;
		}

		
		public function ObjectPool() {
			if (!_allowInstantiation) {
				throw new Error("ERROR: STOP IT FOOL, DON'T INITIALIZE!!");
			}

			_pools = {};
		}

		
		public function registerPool(objectClass: Class, size: int = 1): void {

			// removed check for IPoolable

				var qualifiedName: String = getQualifiedClassName(objectClass);

				if (!_pools[qualifiedName]) {
					_pools[qualifiedName] = new PoolInfo(objectClass, size);
				}
			}
			
			
		public function getObj(objectClass: Class): IPoolable {

			var qualifiedName: String = getQualifiedClassName(objectClass);

			if (!_pools[qualifiedName]) {
				throw new Error("ERROR: Can't get object from unregistered pool!");
				return;
			}

			var returnObj: IPoolable;

			//if the # active = pool size, create a new Obj and add it to the pool.
			if (PoolInfo(_pools[qualifiedName]).active == PoolInfo(_pools[qualifiedName]).size) {

				returnObj = new objectClass();

				PoolInfo(_pools[qualifiedName]).size++;
				PoolInfo(_pools[qualifiedName]).items.push(returnObj);

			} else { //if there are objects available, retrieve the item from the pool and renew() it.

				returnObj = PoolInfo(_pools[qualifiedName]).items[PoolInfo(_pools[qualifiedName]).active];

				returnObj.renew();
			}

			PoolInfo(_pools[qualifiedName]).active++; // increase the active count;
			
			//trace("Current Count: " + PoolInfo(_pools[qualifiedName]).active);

			return returnObj;
			
		} // end getObj
		
		
		public function getPoolData(objectClass: Class) : void {
			
			var qualifiedName: String = getQualifiedClassName(objectClass);
			
			if (!_pools[qualifiedName]) {
				throw new Error("ERROR: Can't get object from unregistered pool!");
				return;
			}
			
			//trace("\nNumber Active: " + PoolInfo(_pools[qualifiedName]).active);
			//trace("Size of Pool: " + PoolInfo(_pools[qualifiedName]).size);
		}

		public function returnObj(obj:IPoolable):void {
			
			var qualifiedName: String = getQualifiedClassName(obj);
			
			if(!_pools[qualifiedName]) {
				throw new Error("ERROR: Can't return object from unregistered pool!");
				return;
			}
			
			var objIndex:int = PoolInfo(_pools[qualifiedName]).items.indexOf(obj);
			
			if (objIndex >= 0) {
				
				PoolInfo(_pools[qualifiedName]).items.splice(objIndex, 1);
				
				//var len : int = PoolInfo(_pools[qualifiedName]).items.length - 1;
				//PoolInfo(_pools[qualifiedName]).items[objIndex] = PoolInfo(_pools[qualifiedName]).items[len];
				//PoolInfo(_pools[qualifiedName]).items.length = len;
				
				obj.destroy();
				PoolInfo(_pools[qualifiedName]).items.push(obj);
				PoolInfo(_pools[qualifiedName]).active--;
			}
			
			
			
		}

	
	} // end ObjectPool class
} // end package

					
class PoolInfo {

	public var items: Vector.<IPoolable>;
	public var itemClass: Class;
	public var size: int;
	public var active: int;
	public var isDynamic: Boolean;

	public function PoolInfo(itemClass: Class, size: int): void {

		this.itemClass = itemClass;
		items = new Vector.<IPoolable>(size);
		this.size = size;
		active = 0;

		initialize();
	}

	private function initialize(): void {

		for (var i: int = 0; i < size; i++) {
			items[i] = new itemClass();
		}
	}
}