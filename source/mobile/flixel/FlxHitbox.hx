package mobile.flixel;

import openfl.display.Shape;
import openfl.display.BitmapData;
import mobile.flixel.FlxButton;

/**
 * A zone with 4 hint's (A hitbox).
 * It's really easy to customize the layout.
 *
 * @author: Mihai Alexandru
 * @modification's author: Karim Akra (UTFan) & Lily (mcagabe19)
 */
class FlxHitbox extends FlxSpriteGroup
{
	final offsetFir:Int = (ClientPrefs.data.hitbox2 ? Std.int(FlxG.height / 4) * 3 : 0);
	final offsetSec:Int = (ClientPrefs.data.hitbox2 ? 0 : Std.int(FlxG.height / 4));

	public var buttonLeft:FlxButton = new FlxButton(0, 0);
	public var buttonDown:FlxButton = new FlxButton(0, 0);
	public var buttonUp:FlxButton = new FlxButton(0, 0);
	public var buttonRight:FlxButton = new FlxButton(0, 0);
	public var buttonExtra:FlxButton = new FlxButton(0, 0);
	public var buttonExtra1:FlxButton = new FlxButton(0, 0);

	public var buttonsMap:Map<FlxMobileControlsID, FlxButton>;
	public var buttons:Array<FlxMobileControlsID> = [
		FlxMobileControlsID.hitboxUP,
		FlxMobileControlsID.hitboxDOWN,
		FlxMobileControlsID.hitboxLEFT,
		FlxMobileControlsID.hitboxRIGHT
	];

	/**
	 * Create the zone.
	 */
	 
	public function new(mode:Modes)
	{
		super();
		buttonsMap = new Map<FlxMobileControlsID, FlxButton>();
		buttonsMap.set(FlxMobileControlsID.hitboxUP, buttonUp);
		buttonsMap.set(FlxMobileControlsID.hitboxRIGHT, buttonRight);
		buttonsMap.set(FlxMobileControlsID.hitboxLEFT, buttonLeft);
		buttonsMap.set(FlxMobileControlsID.hitboxDOWN, buttonDown);

		buttonsMap.set(FlxMobileControlsID.noteUP, buttonUp);
		buttonsMap.set(FlxMobileControlsID.noteRIGHT, buttonRight);
		buttonsMap.set(FlxMobileControlsID.noteLEFT, buttonLeft);
		buttonsMap.set(FlxMobileControlsID.noteDOWN, buttonDown);		

		var buttonsColors:Array<FlxColor> = [];
		var data:Dynamic;
		if(ClientPrefs.data.dynamicColors)
			data = ClientPrefs.data;
		else
			data = ClientPrefs.defaultData;

		buttonsColors.push(data.arrowRGB[0][0]);
		buttonsColors.push(data.arrowRGB[1][0]);
		buttonsColors.push(data.arrowRGB[2][0]);
		buttonsColors.push(data.arrowRGB[3][0]);

		switch (mode)
		{
			case DEFAULT:
				add(buttonLeft = createHint(0, 0, Std.int(FlxG.width / 4), FlxG.height, buttonsColors[0]));
				add(buttonDown = createHint(FlxG.width / 4, 0, Std.int(FlxG.width / 4), FlxG.height, buttonsColors[1]));
				add(buttonUp = createHint(FlxG.width / 2, 0, Std.int(FlxG.width / 4), FlxG.height, buttonsColors[2]));
				add(buttonRight = createHint((FlxG.width / 2) + (FlxG.width / 4), 0, Std.int(FlxG.width / 4), FlxG.height, buttonsColors[3]));
			case SINGLE:
				add(buttonLeft = createHint(0, offsetSec, Std.int(FlxG.width / 4), Std.int(FlxG.height / 4) * 3, buttonsColors[0]));
				add(buttonDown = createHint(FlxG.width / 4, offsetSec, Std.int(FlxG.width / 4), Std.int(FlxG.height / 4) * 3, buttonsColors[1]));
				add(buttonUp = createHint(FlxG.width / 2, offsetSec, Std.int(FlxG.width / 4), Std.int(FlxG.height / 4) * 3, buttonsColors[2]));
				add(buttonRight = createHint((FlxG.width / 2) + (FlxG.width / 4), offsetSec, Std.int(FlxG.width / 4), Std.int(FlxG.height / 4) * 3, buttonsColors[3]));
				add(buttonExtra = createHint(0, offsetFir, FlxG.width, Std.int(FlxG.height / 4), 0xFF0066FF));
			case DOUBLE:
				add(buttonLeft = createHint(0, offsetSec, Std.int(FlxG.width / 4), Std.int(FlxG.height / 4) * 3, buttonsColors[0]));
				add(buttonDown = createHint(FlxG.width / 4, offsetSec, Std.int(FlxG.width / 4), Std.int(FlxG.height / 4) * 3, buttonsColors[1]));
				add(buttonUp = createHint(FlxG.width / 2, offsetSec, Std.int(FlxG.width / 4), Std.int(FlxG.height / 4) * 3, buttonsColors[2]));
				add(buttonRight = createHint((FlxG.width / 2) + (FlxG.width / 4), offsetSec, Std.int(FlxG.width / 4), Std.int(FlxG.height / 4) * 3, buttonsColors[3]));
				add(buttonExtra = createHint(Std.int(FlxG.width / 2), offsetFir, Std.int(FlxG.width / 2), Std.int(FlxG.height / 4), 0xFF0066FF));
				add(buttonExtra1 = createHint(0, offsetFir, Std.int(FlxG.width / 2), Std.int(FlxG.height / 4), 0x00FFF7));
			
		}

		scrollFactor.set();
	}

	/**
	 * Clean up memory.
	 */
	override function destroy()
	{
		super.destroy();

		buttonLeft = FlxDestroyUtil.destroy(buttonLeft);
		buttonDown = FlxDestroyUtil.destroy(buttonDown);
		buttonUp = FlxDestroyUtil.destroy(buttonUp);
		buttonRight = FlxDestroyUtil.destroy(buttonRight);
		buttonExtra = FlxDestroyUtil.destroy(buttonExtra);
		buttonExtra1 = FlxDestroyUtil.destroy(buttonExtra1);
	}

	private function createHintGraphic(Width:Int, Height:Int, Color:Int = 0xFFFFFF):BitmapData
	{
		var shape:Shape = new Shape();

			shape.graphics.beginFill(Color);
			shape.graphics.lineStyle(3, Color, 1);
			shape.graphics.drawRect(0, 0, Width, Height);
			shape.graphics.lineStyle(0, 0, 0);
			shape.graphics.drawRect(3, 3, Width - 6, Height - 6);
			shape.graphics.endFill();
			shape.graphics.beginGradientFill(RADIAL, [Color, FlxColor.TRANSPARENT], [0.6, 0], [0, 255], null, null, null, 0.5);
			shape.graphics.drawRect(3, 3, Width - 6, Height - 6);
			shape.graphics.endFill();

		var bitmap:BitmapData = new BitmapData(Width, Height, true, 0);
		bitmap.draw(shape);
		return bitmap;
	}

	private function createHint(X:Float, Y:Float, Width:Int, Height:Int, Color:Int = 0xFFFFFF):FlxButton
	{
		var hintTween:FlxTween = null;
		var hint:FlxButton = new FlxButton(X, Y);
		hint.loadGraphic(createHintGraphic(Width, Height, Color));
		hint.solid = false;
		hint.immovable = true;
		hint.multiTouch = true;
		hint.moves = false;
		hint.scrollFactor.set();
		hint.alpha = 0.00001;
		hint.onDown.callback = function()
		{
			if (hintTween != null)
				hintTween.cancel();

			hintTween = FlxTween.tween(hint, {alpha: ClientPrefs.data.controlsAlpha}, ClientPrefs.data.controlsAlpha / 100, {
				ease: FlxEase.circInOut,
				onComplete: function(twn:FlxTween)
				{
					hintTween = null;
				}
			});
		}
		hint.onUp.callback = function()
		{
			if (hintTween != null)
				hintTween.cancel();

			hintTween = FlxTween.tween(hint, {alpha: 0.00001}, ClientPrefs.data.controlsAlpha / 10, {
				ease: FlxEase.circInOut,
				onComplete: function(twn:FlxTween)
				{
					hintTween = null;
				}
			});
		}
		hint.onOut.callback = function()
		{
			if (hintTween != null)
				hintTween.cancel();

			hintTween = FlxTween.tween(hint, {alpha: 0.00001}, ClientPrefs.data.controlsAlpha / 10, {
				ease: FlxEase.circInOut,
				onComplete: function(twn:FlxTween)
				{
					hintTween = null;
				}
			});
		}
		#if FLX_DEBUG
		hint.ignoreDrawDebug = true;
		#end
		return hint;
	}

	/**
	* Check to see if at least one button from an array of buttons is pressed.
	*
	* @param	buttonsArray 	An array of buttos names
	* @return	Whether at least one of the buttons passed in is pressed.
	*/
	public inline function anyPressed(buttonsArray:Array<FlxMobileControlsID>):Bool {
		return checkButtonArrayState(buttonsArray, PRESSED);
	}
	
	/**
	* Check to see if at least one button from an array of buttons was just pressed.
	*
	* @param	buttonsArray 	An array of buttons names
	* @return	Whether at least one of the buttons passed was just pressed.
	*/
	public inline function anyJustPressed(buttonsArray:Array<FlxMobileControlsID>):Bool {
		return checkButtonArrayState(buttonsArray, JUST_PRESSED);
	}
	
	/**
	* Check to see if at least one button from an array of buttons was just released.
	*
	* @param	buttonsArray 	An array of button names
	* @return	Whether at least one of the buttons passed was just released.
	*/
	public inline function anyJustReleased(buttonsArray:Array<FlxMobileControlsID>):Bool {
		return checkButtonArrayState(buttonsArray, JUST_RELEASED);
	}

	/**
	 * Check the status of a single button
	 *
	 * @param	Button		button to be checked.
	 * @param	state		The button state to check for.
	 * @return	Whether the provided key has the specified status.
	 */
	 public function checkStatus(button:FlxMobileControlsID, state:ButtonsStates):Bool {
		
		if (button == FlxMobileControlsID.ANY)
		{
			for(each in buttons){
				return switch (state) {
					case PRESSED: buttonsMap.get(each).pressed;
					case JUST_PRESSED: buttonsMap.get(each).justPressed;
					case JUST_RELEASED: buttonsMap.get(each).justReleased;
				}
			}
		}
		
		/* it might be a weird way for doing this but that's the only way i got in mind
		if (button == FlxMobileControlsID.NONE)
			{
				var used:Int = 0;
				for(each in buttons){
					switch (state) {
						case PRESSED:
							if(buttonsMap.get(each).pressed)
								++used;
						case JUST_PRESSED:
							if(buttonsMap.get(each).justPressed)
								++used;
						case JUST_RELEASED:
							if(buttonsMap.get(each).justReleased)
								++used;
					}
				}
				if(used == 0)
					return true;
				else
					return false;
			}*/
		if (button == FlxMobileControlsID.NONE)
			return false;
		

		if (buttonsMap.exists(button))
		{
			return CheckStatus(button, state);
		}
		
		#if debug
		throw 'Invalid button code: $button.';
		#end
		return false;
	}

	/**
	* Helper function to check the status of an array of buttons
	*
	* @param	Buttons	An array of keys as Strings
	* @param	state		The key state to check for
	* @return	Whether at least one of the keys has the specified status
	*/
	public function checkButtonArrayState(Buttons:Array<FlxMobileControlsID>, state:ButtonsStates):Bool {
		if (Buttons == null)
			{
				return false;
			}
	
			for (button in Buttons)
			{
				if (checkStatus(button, state))
					return true;
			}
	
			return false;
		}

	public function CheckStatus(button:FlxMobileControlsID, state:ButtonsStates){
		return getButton(button).hasState(state);
	}

	public function getButton(button:FlxMobileControlsID) {
		return buttonsMap.get(button);
	}
}
enum Modes
{
	DEFAULT;
	SINGLE;
	DOUBLE;
}
