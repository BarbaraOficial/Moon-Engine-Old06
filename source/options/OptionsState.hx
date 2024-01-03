package options;

import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import states.MainMenuState;
import states.MainMenuPsychState;
import backend.StageData;
import flixel.addons.transition.FlxTransitionableState;

class OptionsState extends MusicBeatState
{
	var options:Array<String> = ['Note Colors', 'Controls', 'Adjust Delay and Combo', 'Graphics', 'Visuals and UI', 'Gameplay'];
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;
	public static var onPlayState:Bool = false;
	var tipText:FlxText;

	function openSelectedSubstate(label:String) {
		persistentUpdate = false;
		if (label != "Adjust Delay and Combo") removeVirtualPad();
		switch(label) {
			case 'Note Colors':
				openSubState(new options.NotesSubState());
			case 'Controls':
				openSubState(new options.ControlsSubState());
			case 'Graphics':
				openSubState(new options.GraphicsSettingsSubState());
			case 'Visuals and UI':
				openSubState(new options.VisualsUISubState());
			case 'Gameplay':
				openSubState(new options.GameplaySettingsSubState());
			case 'Adjust Delay and Combo':
				MusicBeatState.switchState(new options.NoteOffsetState());
		    #if mobile
			case 'Mobile Options':
				openSubState(new options.MobileOptionsSubState());
		    #end
		}
	}

	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;

	override function create() {
		#if (desktop && !hl)
		DiscordClient.changePresence("Options Menu", null);
		#end

                #if mobile
                options.push('Mobile Options');
		#end

		var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33FFFFFF, 0x0));
		grid.velocity.set(40, 40);
		grid.alpha = 0;
		FlxTween.tween(grid, {alpha: 1}, 0.5, {ease: FlxEase.quadOut});
		add(grid);

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.color = 0xFFea71fd;
		bg.updateHitbox();

		bg.screenCenter();
		add(bg);

	#if mobile
        if (controls.mobileC) {
		tipText = new FlxText(150, FlxG.height - 24, 0, 'Press C to Go In Mobile Controls Menu', 16);
		tipText.setFormat("VCR OSD Mono", 17, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		tipText.borderSize = 1.25;
		tipText.scrollFactor.set();
		tipText.antialiasing = ClientPrefs.data.antialiasing;
		add(tipText);
		}
	#end

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true);
			optionText.screenCenter();
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			grpOptions.add(optionText);
		}

		selectorLeft = new Alphabet(0, 0, '>', true);
		add(selectorLeft);
		selectorRight = new Alphabet(0, 0, '<', true);
		add(selectorRight);

		changeSelection();
		ClientPrefs.saveSettings();

		addVirtualPad(UP_DOWN, A_B_C);

		super.create();
	}

	override function closeSubState() {
                controls.isInSubstate = false;
		super.closeSubState();
		ClientPrefs.saveSettings();
		ClientPrefs.loadPrefs();
                removeVirtualPad();
		addVirtualPad(UP_DOWN, A_B_C);
		persistentUpdate = true;
	}

    var exiting:Bool = false;
	override function update(elapsed:Float) {
		super.update(elapsed);

		if (!exiting) {
		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}
			
               #if mobile
		if (virtualPad.buttonC.justPressed) {
			persistentUpdate = false;

			openSubState(new MobileControlsSubState());
		}
	       #end

		if (controls.BACK) {
            exiting = true;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			if(onPlayState)
			{
				StageData.loadDirectory(PlayState.SONG);
				MusicBeatState.switchState(new PlayState());
				FlxG.sound.music.volume = 0;
			}
			else
			{
		
		switch (ClientPrefs.data.menuType){
					
			  case 'Moon Engine':
			        MusicBeatState.switchState(new MainMenuState());
					
			  case 'Psych Engine':
				MusicBeatState.switchState(new MainMenuPsychState());
				
		      }
		   }
		}
			
		else if (controls.ACCEPT) openSelectedSubstate(options[curSelected]);
	}
	}
	
	function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
				selectorLeft.x = item.x - 63;
				selectorLeft.y = item.y;
				selectorRight.x = item.x + item.width + 15;
				selectorRight.y = item.y;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	override function destroy()
	{
		ClientPrefs.loadPrefs();
		super.destroy();
	}
}
