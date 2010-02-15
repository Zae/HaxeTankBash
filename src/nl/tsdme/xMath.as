package nl.tsdme 
{
	/**
	 * ...
	 * @author Ezra Pool
	 * @version 1
	 */
	public class xMath
	{
		/*
		 * Map a set of values to another set of values
		 * 
		 * @since 27 December 2009
		 * @param v Number The value that will be mapped
		 * @param a Number The minimum value of the number to be mapped
		 * @param b Number The maximum value of the number to be mapped
		 * @param x Number The minimum value of the output
		 * @param y Number The maximum value of the output
		 * @return Number
		 */
		static public function map(v:Number, a:Number, b:Number, x:Number = 0, y:Number = 1):Number
		{
			return (v == a) ? x : (v - a) * (y - x) / (b - a) + x;
		}
	}
}