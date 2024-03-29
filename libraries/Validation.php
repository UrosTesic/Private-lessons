<!--sa130068-->
<?php
define("EMAILCHECK", "/^[a-zA-ZčćžđšŠĐŽĆČ][a-zA-Z\dčćžđšŠĐŽĆČ]*@[a-zA-Z]+\.[a-zA-Z]+$/");
define("NAMECHECK", "/^[A-ZŠĐŽĆČ][a-zčćžđš]+ ?[a-zčćžđš]+$/");
define("PHONECHECK", "/^\d{3}\?/\d{3}\-?\d{2}\-?\d\d?$/");
define("NICKNAMECHECK", "/^[a-zA-ZčćžđšŠĐŽĆČ]+$/");
define("PASSWORDCHECK", "/.*/");

class Validation
{
	public static function Email($input)
	{
		return preg_match(EMAILCHECK, $input) === 1;
	}
	
	public static function Phone($input)
	{
		return preg_match(PHONECHECK, $input) === 1;
	}
	
	public static function Name($input)
	{
		return preg_match(NAMECHECK, $input) === 1;
	}
	
	public static function NickName($input)
	{
		return strlen($input) <= 19 && preg_match(NICKNAMECHECK, $input) === 1;
	}
	
	public static function Password($input)
	{
		return strlen($input) >= 8 && preg_match(PASSWORDCHECK, $input) === 1;
	}
	
}

?>