package mobile.flixel;
import flixel.system.macros.FlxMacroUtil;
/**
* A enum based off for handling mobile virtualpad buttons and hitbox hints.
* @author Karim Akra
*/
@:enum 
abstract FlxMobileControlsID(Int) from Int to Int
{
    public static var fromStringMap(default, null):Map<String, FlxMobileControlsID> = FlxMacroUtil.buildMap("mobile.flixel.FlxMobileControlsID");
	public static var toStringMap(default, null):Map<FlxMobileControlsID, String> = FlxMacroUtil.buildMap("mobile.flixel.FlxMobileControlsID", true);
    var A = 1;
    var B = 2;
    var C = 3;
    var UP = 4;
    var DOWN = 5;
    var LEFT = 6;
    var RIGHT = 7;
    var D = 8;
    var E = 9;
    var V = 10;
    var X = 11;
    var Y = 12;
    var Z = 13;
    var dpadLEFT2 = 14;
    var dpadUP2 = 15;
    var dpadRIGHT2 = 16;
    var dpadDOWN2 = 17;
    var hitboxUP = 18;
    var hitboxDOWN = 19;
    var hitboxLEFT = 20;
    var hitboxRIGHT = 21;
    var noteUP = 22;
    var noteDOWN = 23;
    var noteLEFT = 24;
    var noteRIGHT = 25;

    var NONE = -1;

    @:from
	public static inline function fromString(s:String)
	{
		s = s.toUpperCase();
		return fromStringMap.exists(s) ? fromStringMap.get(s) : NONE;
	}

	@:to
	public inline function toString():String
	{
		return toStringMap.get(this);
	}
}
