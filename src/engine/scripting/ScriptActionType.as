package engine.scripting 
{
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class ScriptActionType 
	{
		static public const END:int = 0;
		static public const ELSE:int = 1;
		static public const END_IF:int = 2;
		static public const IF_FLAG_THEN:int = 3;
		static public const IF_VARIABLE_THEN:int = 4;
		static public const SET_FLAG:int = 5;
		static public const SET_VARIABLE:int = 6;
		static public const LABEL:int = 7;
		static public const GOTO:int = 8;
		static public const MESSAGE:int = 9;
		
		static public const COMMENT:int = 47;
		static public const SEPARATOR:int = 48;
		
		static public const IF_RAND_THEN:int = 50;
	}
}