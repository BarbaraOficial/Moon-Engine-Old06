package mobile.flixel.id;
import flixel.system.macros.FlxMacroUtil;
/**
* A enum based off for handling mobile virtualpad buttons and hitbox hints.
* @author Karim Akra (UTFan) & Lily(mcagabe19)
*/
@:enum 
abstract FlxMobileControlsID(Int) from Int to Int
{
    public static var fromStringMap(default, null):Map<String, FlxMobileControlsID> = FlxMacroUtil.buildMap("mobile.flixel.id.FlxMobileControlsID");
	public static var toStringMap(default, null):Map<FlxMobileControlsID, String> = FlxMacroUtil.buildMap("mobile.flixel.id.FlxMobileControlsID", true);
    // Buttons
    var A = 1;
    var B = 2;
    var C = 3;
    var D = 4;
    var E = 5;
    var G = 6;
    var P = 7;
    var S = 8;
    var V = 9;
    var X = 10;
    var Y = 11;
    var Z = 12;
    // VPAD Buttons
    var UP = 13;
    var UP2 = 14;
    var DOWN = 15;
    var DOWN2 = 16;
    var LEFT = 17;
    var LEFT2 = 18;
    var RIGHT = 19;
    var RIGHT2 = 20;
    // HITBOX Hints
    var hitboxUP = 21;
    var hitboxDOWN = 22;
    var hitboxLEFT = 23;
    var hitboxRIGHT = 24;
    // PlayState x Controls Releated
    var noteUP = 25;
    var noteDOWN = 26;
    var noteLEFT = 27;
    var noteRIGHT = 28;
    // Nothing or null
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
