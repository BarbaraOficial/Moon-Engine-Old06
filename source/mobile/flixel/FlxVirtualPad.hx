package mobile.flixel;
import mobile.flixel.FlxButton;
import mobile.flixel.FlxButton.ButtonsStates;
import flixel.graphics.frames.FlxTileFrames;
import flixel.math.FlxPoint;
import haxe.ds.Map;

/**
 * A gamepad.
 * It's easy to customize the layout.
 *
 * @original author Ka Wing Chin & Mihai Alexandru
 * @modification's author: Karim Akra (UTFan) & Lily (mcagabe19)
 */
class FlxVirtualPad extends FlxSpriteGroup
{
	public var buttonLeft:FlxButton = new FlxButton(0, 0);
	public var buttonUp:FlxButton = new FlxButton(0, 0);
	public var buttonRight:FlxButton = new FlxButton(0, 0);
	public var buttonDown:FlxButton = new FlxButton(0, 0);
	public var buttonLeft2:FlxButton = new FlxButton(0, 0);
	public var buttonUp2:FlxButton = new FlxButton(0, 0);
	public var buttonRight2:FlxButton = new FlxButton(0, 0);
	public var buttonDown2:FlxButton = new FlxButton(0, 0);
	public var buttonA:FlxButton = new FlxButton(0, 0);
	public var buttonB:FlxButton = new FlxButton(0, 0);
	public var buttonC:FlxButton = new FlxButton(0, 0);
	public var buttonD:FlxButton = new FlxButton(0, 0);
	public var buttonE:FlxButton = new FlxButton(0, 0);
    public var buttonF:FlxButton = new FlxButton(0, 0);
    public var buttonG:FlxButton = new FlxButton(0, 0);
    public var buttonS:FlxButton = new FlxButton(0, 0);
	public var buttonV:FlxButton = new FlxButton(0, 0);
	public var buttonX:FlxButton = new FlxButton(0, 0);
	public var buttonY:FlxButton = new FlxButton(0, 0);
	public var buttonZ:FlxButton = new FlxButton(0, 0);
	public var buttonP:FlxButton = new FlxButton(0, 0);

	public var buttonsMap:Map<FlxMobileControlsID, FlxButton>;
	// kill me -Karim
	public var buttons:Array<FlxMobileControlsID> = [
		FlxMobileControlsID.A,
		FlxMobileControlsID.B,
		FlxMobileControlsID.C,
		FlxMobileControlsID.D,
		FlxMobileControlsID.E,
		FlxMobileControlsID.F,
		FlxMobileControlsID.G,
		FlxMobileControlsID.S,
		FlxMobileControlsID.V,
		FlxMobileControlsID.X,
		FlxMobileControlsID.Y,
		FlxMobileControlsID.Z,
		FlxMobileControlsID.P,
		FlxMobileControlsID.UP,
		FlxMobileControlsID.UP2,
		FlxMobileControlsID.DOWN,
		FlxMobileControlsID.DOWN2,
		FlxMobileControlsID.LEFT,
		FlxMobileControlsID.LEFT2,
		FlxMobileControlsID.RIGHT,
		FlxMobileControlsID.RIGHT2,
		FlxMobileControlsID.noteUP,
		FlxMobileControlsID.noteDOWN,
		FlxMobileControlsID.noteLEFT,
		FlxMobileControlsID.noteRIGHT
	];

	/**
	 * Create a gamepad.
	 *
	 * @param   DPadMode     The D-Pad mode. `LEFT_FULL` for example.
	 * @param   ActionMode   The action buttons mode. `A_B_C` for example.
	 */
	public function new(DPad:FlxDPadMode, Action:FlxActionMode)
	{
		super();

		// DPad Buttons
		buttonsMap = new Map<FlxMobileControlsID, FlxButton>();
		buttonsMap.set(FlxMobileControlsID.UP, buttonUp);
		buttonsMap.set(FlxMobileControlsID.UP2, buttonUp2);
		buttonsMap.set(FlxMobileControlsID.DOWN, buttonDown);
		buttonsMap.set(FlxMobileControlsID.DOWN2, buttonDown2);
		buttonsMap.set(FlxMobileControlsID.LEFT, buttonLeft);
		buttonsMap.set(FlxMobileControlsID.LEFT2, buttonLeft2);
		buttonsMap.set(FlxMobileControlsID.RIGHT, buttonRight);
		buttonsMap.set(FlxMobileControlsID.RIGHT2, buttonRight2);

		buttonsMap.set(FlxMobileControlsID.noteUP, buttonUp);
		buttonsMap.set(FlxMobileControlsID.noteRIGHT, buttonRight);
		buttonsMap.set(FlxMobileControlsID.noteLEFT, buttonLeft);
		buttonsMap.set(FlxMobileControlsID.noteDOWN, buttonDown);	

		// Actions buttons
		buttonsMap.set(FlxMobileControlsID.A, buttonA);
		buttonsMap.set(FlxMobileControlsID.B, buttonB);
		buttonsMap.set(FlxMobileControlsID.C, buttonC);
		buttonsMap.set(FlxMobileControlsID.D, buttonD);
		buttonsMap.set(FlxMobileControlsID.E, buttonE);
		buttonsMap.set(FlxMobileControlsID.V, buttonV);
		buttonsMap.set(FlxMobileControlsID.X, buttonX);
		buttonsMap.set(FlxMobileControlsID.Y, buttonY);
		buttonsMap.set(FlxMobileControlsID.Z, buttonZ);
		buttonsMap.set(FlxMobileControlsID.P, buttonP);

		var buttonLeftColor:Array<FlxColor>;
		var buttonDownColor:Array<FlxColor>;
		var buttonUpColor:Array<FlxColor>;
		var buttonRightColor:Array<FlxColor>;

		buttonLeftColor = ClientPrefs.defaultData.arrowRGB[0];
		buttonDownColor = ClientPrefs.defaultData.arrowRGB[1];
		buttonUpColor = ClientPrefs.defaultData.arrowRGB[2];
		buttonRightColor = ClientPrefs.defaultData.arrowRGB[3];

		scrollFactor.set();

		switch (DPad)
		{
			case UP_DOWN:
				add(buttonUp = createButton(0, FlxG.height - 255, 132, 127, 'up', buttonUpColor[0]));
				add(buttonDown = createButton(0, FlxG.height - 135, 132, 127, 'down', buttonDownColor[0]));
			case LEFT_RIGHT:
				add(buttonLeft = createButton(0, FlxG.height - 135, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight = createButton(127, FlxG.height - 135, 132, 127, 'right', buttonRightColor[0]));
			case UP_LEFT_RIGHT:
				add(buttonUp = createButton(105, FlxG.height - 243, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft = createButton(0, FlxG.height - 135, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight = createButton(207, FlxG.height - 135, 132, 127, 'right', buttonRightColor[0]));
			case LEFT_FULL:
				add(buttonUp = createButton(105, FlxG.height - 345, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft = createButton(0, FlxG.height - 243, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight = createButton(207, FlxG.height - 243, 132, 127, 'right', buttonRightColor[0]));
				add(buttonDown = createButton(105, FlxG.height - 135, 132, 127, 'down', buttonDownColor[0]));
			case RIGHT_FULL:
				add(buttonUp = createButton(FlxG.width - 258, FlxG.height - 408, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft = createButton(FlxG.width - 384, FlxG.height - 309, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight = createButton(FlxG.width - 132, FlxG.height - 309, 132, 127, 'right', buttonRightColor[0]));
				add(buttonDown = createButton(FlxG.width - 258, FlxG.height - 201, 132, 127, 'down', buttonDownColor[0]));
			case BOTH:
				add(buttonUp = createButton(105, FlxG.height - 345, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft = createButton(0, FlxG.height - 243, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight = createButton(207, FlxG.height - 243, 132, 127, 'right', buttonRightColor[0]));
				add(buttonDown = createButton(105, FlxG.height - 135, 132, 127, 'down', buttonDownColor[0]));
				add(buttonUp2 = createButton(FlxG.width - 258, FlxG.height - 408, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft2 = createButton(FlxG.width - 384, FlxG.height - 309, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight2 = createButton(FlxG.width - 132, FlxG.height - 309, 132, 127, 'right', buttonRightColor[0]));
				add(buttonDown2 = createButton(FlxG.width - 258, FlxG.height - 201, 132, 127, 'down', buttonDownColor[0]));
			// PSYCH RELEATED BUTTONS
			case DIALOGUE_PORTRAIT:
				add(buttonUp = createButton(105, FlxG.height - 345, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft = createButton(0, FlxG.height - 243, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight = createButton(207, FlxG.height - 243, 132, 127, 'right', buttonRightColor[0]));
				add(buttonDown = createButton(105, FlxG.height - 135, 132, 127, 'down', buttonDownColor[0]));
				add(buttonUp2 = createButton(105, 0, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft2 = createButton(0, 82, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight2 = createButton(207, 82, 132, 127, 'right', buttonRightColor[0]));
				add(buttonDown2 = createButton(105, 190, 132, 127, 'down', buttonDownColor[0]));
			case MENU_CHARACTER:
				add(buttonUp = createButton(105, 0, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft = createButton(0, 82, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight = createButton(207, 82, 132, 127, 'right', buttonRightColor[0]));
				add(buttonDown = createButton(105, 190, 132, 127, 'down', buttonDownColor[0]));
			case NOTE_SPLASH_DEBUG:
				add(buttonLeft = createButton(0, 0, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight = createButton(127, 0, 132, 127, 'right', buttonRightColor[0]));
				add(buttonUp = createButton(0, 125, 132, 127, 'up', buttonUpColor[0]));
				add(buttonDown = createButton(127, 125, 132, 127, 'down', buttonDownColor[0]));
				add(buttonUp2 = createButton(127, 393, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft2 = createButton(0, 393, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight2 = createButton(1145, 393, 132, 127, 'right', buttonRightColor[0]));
				add(buttonDown2 = createButton(1015, 393, 132, 127, 'down', buttonDownColor[0]));
			case NONE: // do nothing
		}

		switch (Action)
		{
			case A:
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
			case B:
				add(buttonB = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
			case B_X:
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonX = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'x', 0x99062D));
			case A_B:
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
			case A_B_C:
				add(buttonC = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'c', 0x44FF00));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
			case A_B_E:
				add(buttonE = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'e', 0xFF7D00));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
			case A_B_X_Y:
				add(buttonX = createButton(FlxG.width - 510, FlxG.height - 135, 132, 127, 'x', 0x99062D));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonY = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'y', 0x4A35B9));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
			case A_B_C_X_Y:
				add(buttonC = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'c', 0x44FF00));
				add(buttonX = createButton(FlxG.width - 258, FlxG.height - 255, 132, 127, 'x', 0x99062D));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonY = createButton(FlxG.width - 132, FlxG.height - 255, 132, 127, 'y', 0x4A35B9));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
			case A_B_C_X_Y_Z:
				add(buttonX = createButton(FlxG.width - 384, FlxG.height - 255, 132, 127, 'x', 0x99062D));
				add(buttonC = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'c', 0x44FF00));
				add(buttonY = createButton(FlxG.width - 258, FlxG.height - 255, 132, 127, 'y', 0x4A35B9));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonZ = createButton(FlxG.width - 132, FlxG.height - 255, 132, 127, 'z', 0xCCB98E));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
			case A_B_C_D_V_X_Y_Z:
				add(buttonV = createButton(FlxG.width - 510, FlxG.height - 255, 132, 127, 'v', 0x49A9B2));
				add(buttonD = createButton(FlxG.width - 510, FlxG.height - 135, 132, 127, 'd', 0x0078FF));
				add(buttonX = createButton(FlxG.width - 384, FlxG.height - 255, 132, 127, 'x', 0x99062D));
				add(buttonC = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'c', 0x44FF00));
				add(buttonY = createButton(FlxG.width - 258, FlxG.height - 255, 132, 127, 'y', 0x4A35B9));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonZ = createButton(FlxG.width - 132, FlxG.height - 255, 132, 127, 'z', 0xCCB98E));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
			// PSYCH RELEATED BUTTONS
			case DIALOGUE_PORTRAIT:
				add(buttonX = createButton(FlxG.width - 384, 0, 132, 127, 'x', 0x99062D));
				add(buttonC = createButton(FlxG.width - 384, 125, 132, 127, 'c', 0x44FF00));
				add(buttonY = createButton(FlxG.width - 258, 0, 132, 127, 'y', 0x4A35B9));
				add(buttonB = createButton(FlxG.width - 258, 125, 132, 127, 'b', 0xFFCB00));
				add(buttonZ = createButton(FlxG.width - 132, 0, 132, 127, 'z', 0xCCB98E));
				add(buttonA = createButton(FlxG.width - 132, 125, 132, 127, 'a', 0xFF0000));
			case MENU_CHARACTER:
				add(buttonC = createButton(FlxG.width - 384, 0, 132, 127, 'c', 0x44FF00));
				add(buttonB = createButton(FlxG.width - 258, 0, 132, 127, 'b', 0xFFCB00));
				add(buttonA = createButton(FlxG.width - 132, 0, 132, 127, 'a', 0xFF0000));
			case NOTE_SPLASH_DEBUG:
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonE = createButton(FlxG.width - 132, 0, 132, 127, 'e', 0xFF7D00));
				add(buttonX = createButton(FlxG.width - 258, 0, 132, 127, 'x', 0x99062D));
				add(buttonY = createButton(FlxG.width - 132, 250, 132, 127, 'y', 0x4A35B9));
				add(buttonZ = createButton(FlxG.width - 258, 250, 132, 127, 'z', 0xCCB98E));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
				add(buttonC = createButton(FlxG.width - 132, 125, 132, 127, 'c', 0x44FF00));
				add(buttonV = createButton(FlxG.width - 258, 125, 132, 127, 'v', 0x49A9B2));
			case P:
				add(buttonP = createButton(FlxG.width - 132, 0, 132, 127, 'x', 0x99062D));
			case B_C:
				add(buttonC = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'c', 0x44FF00));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
			case NONE: // do nothing
		}
	}

	/*
	 * Clean up memory.
	 */
	override public function destroy():Void
	{
		super.destroy();

		buttonLeft = FlxDestroyUtil.destroy(buttonLeft);
		buttonUp = FlxDestroyUtil.destroy(buttonUp);
		buttonDown = FlxDestroyUtil.destroy(buttonDown);
		buttonRight = FlxDestroyUtil.destroy(buttonRight);
		buttonLeft2 = FlxDestroyUtil.destroy(buttonLeft2);
		buttonUp2 = FlxDestroyUtil.destroy(buttonUp2);
		buttonDown2 = FlxDestroyUtil.destroy(buttonDown2);
		buttonRight2 = FlxDestroyUtil.destroy(buttonRight2);
		buttonA = FlxDestroyUtil.destroy(buttonA);
		buttonB = FlxDestroyUtil.destroy(buttonB);
		buttonC = FlxDestroyUtil.destroy(buttonC);
		buttonD = FlxDestroyUtil.destroy(buttonD);
		buttonE = FlxDestroyUtil.destroy(buttonE);
        buttonF = FlxDestroyUtil.destroy(buttonF);
        buttonG = FlxDestroyUtil.destroy(buttonG);
        buttonS = FlxDestroyUtil.destroy(buttonS);
		buttonV = FlxDestroyUtil.destroy(buttonV);
		buttonX = FlxDestroyUtil.destroy(buttonX);
		buttonY = FlxDestroyUtil.destroy(buttonY);
		buttonZ = FlxDestroyUtil.destroy(buttonZ);
		buttonP = FlxDestroyUtil.destroy(buttonP);
	}

	private function createButton(X:Float, Y:Float, Width:Int, Height:Int, Graphic:String, ?Color:Int = 0xFFFFFF):FlxButton
	{
		var button:FlxButton = new FlxButton(X, Y);
		button.frames = FlxTileFrames.fromFrame(Paths.getSparrowAtlas('virtualpad').getByName(Graphic), FlxPoint.get(Width, Height));
		button.resetSizeFromFrame();
		button.solid = false;
		button.immovable = true;
		button.moves = false;
		button.scrollFactor.set();
		button.color = Color;
		#if FLX_DEBUG
		button.ignoreDrawDebug = true;
		#end
		return button;
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
		
		// it might be a weird way for doing this but that's the only way i got in mind
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
		}
		
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
	function checkButtonArrayState(Buttons:Array<FlxMobileControlsID>, state:ButtonsStates):Bool {
		if (Buttons == null || Buttons == [])
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

	function getButton(button:FlxMobileControlsID) {
		if(buttonsMap.exists(button))
			return buttonsMap.get(button);
		else
			return null;
	}
}

enum FlxDPadMode
{
	UP_DOWN;
	LEFT_RIGHT;
	UP_LEFT_RIGHT;
	LEFT_FULL;
	RIGHT_FULL;
	BOTH;
	DIALOGUE_PORTRAIT;
	MENU_CHARACTER;
	NOTE_SPLASH_DEBUG;
	NONE;
}

enum FlxActionMode
{
	A;
	B;
	B_X;
	A_B;
	A_B_C;
	A_B_E;
	A_B_X_Y;
	A_B_C_X_Y;
	A_B_C_X_Y_Z;
	A_B_C_D_V_X_Y_Z;
	DIALOGUE_PORTRAIT;
	MENU_CHARACTER;
	NOTE_SPLASH_DEBUG;
	P;
	B_C;
	NONE;
}
