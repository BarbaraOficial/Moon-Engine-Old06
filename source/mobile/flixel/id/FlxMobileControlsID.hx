package mobile.flixel.id;
import flixel.system.macros.FlxMacroUtil;

    /**
    * A high-level list of unique values for gamepad inputs.
    * These do NOT correspond to any actual hardware values but
    * are the basis for all hardware-specific lookups.
    * Maps enum values and strings to unique integer codes
    *
    * @author Karim Akra (UTFan) & Lily(mcagabe19)
    */
    enum abstract FlxMobileControlsID(Int) from Int to Int
    {
    public static var fromStringMap(default, null):Map<String, FlxMobileControlsID> = FlxMacroUtil.buildMap("mobile.flixel.id.FlxMobileControlsID");
    public static var toStringMap(default, null):Map<FlxMobileControlsID, String> = FlxMacroUtil.buildMap("mobile.flixel.id.FlxMobileControlsID", true);
    // Nothing & Anything
    var ANY = -2;
    var NONE = -1;
    // VPad Action Buttons
    var A = 1;
    var B = 2;
    var C = 3;
    var D = 4;
    var E = 5;
    var F = 6;
    var G = 7;
    var P = 8;
    var S = 9;
    var V = 10;
    var X = 11;
    var Y = 12;
    var Z = 13;
    // VPad DPad Buttons
    var UP = 14;
    var UP2 = 15;
    var DOWN = 16;
    var DOWN2 = 17;
    var LEFT = 18;
    var LEFT2 = 19;
    var RIGHT = 20;
    var RIGHT2 = 21;
    // Hitbox Buttons
    var hitboxUP = 22;
    var hitboxDOWN = 23;
    var hitboxLEFT = 24;
    var hitboxRIGHT = 25;
    // PlayState Controls
    var noteUP = 26;
    var noteDOWN = 27;
    var noteLEFT = 28;
    var noteRIGHT = 29;

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
