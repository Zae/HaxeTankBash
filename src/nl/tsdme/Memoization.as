package nl.tsdme
{
	/**
	 * I didn't actually create this function, but I don't want to clutter
	 * the program with too much namespaces, and maybe use the class in my
	 * own functions, so this is easier.
	 * http://blog.pettomato.com/?p=23
	 * 
	 * @author Ezra Pool
	 * @version 1
	 */
	public class Memoization
	{
		/*
		 * Call this function to memoize functions
		 * 
		 * @param obj *
		 * @param func Function this function will get memoized
		 * @return Function The Memoized function.
		 */
		static public function Memoize(obj:*,func:Function):Function{
			// *** Each argument to func must provide a unique value when
			// *** converted to a string. For example, something that just
			// *** prints out as [Object] will not work.
			
			var hash:Object = {};
			var f:Function = function(...args):*{
				// Check hash for result.
				var key:String = args.join(",");
				var result:* = hash[key];
				if(result == null){
					result = func.apply(obj, args);
					hash[key] = result;
				}
				return result;
			}
			return f;
		}
	}
}