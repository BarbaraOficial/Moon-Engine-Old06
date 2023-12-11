package debug;

import haxe.Timer;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.Lib;
import openfl.system.System;

/**
	The FPS class provides an easy-to-use monitor to display
	the current frame rate of an OpenFL project
**/
class FPSCounter extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Int;

	/**
		The current memory usage (WARNING: this is NOT your total program memory usage, rather it shows the garbage collector memory)
	**/
	public var memoryMegas:Float = 0;

	@:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000)
	{
		super();

		this.x = x;
		this.y = y;

		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		#if mobile
                defaultTextFormat = new TextFormat('_sans', Std.int(14 * Math.min(Lib.current.stage.stageWidth / FlxG.width, Lib.current.stage.stageHeight / FlxG.height)), color);
                #else
                defaultTextFormat = new TextFormat('_sans', 14, color);
                #end
		autoSize = LEFT;
		multiline = true;
		text = "FPS: ";

		cacheCount = 0;
		currentTime = 0;
		times = [];
	}

	var deltaTimeout:Float = 0.0;

	// Event Handlers
	@:noCompletion
	private override function __enterFrame(deltaTime:Float):Void
	{
		if (deltaTimeout > 1000) {
			deltaTimeout = 0.0;
			return;
		}
		currentTime += deltaTime;
		times.push(currentTime);
		while (times[0] < currentTime - 1000)
			times.shift();

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);
		if (currentFPS > ClientPrefs.data.framerate) currentFPS = ClientPrefs.data.framerate;

		if (currentCount != cacheCount)
		{
			text = 'FPS: ${currentFPS}';

			memoryMegas = cast(System.totalMemory, UInt);
			text += '\nMemory: ${flixel.util.FlxStringUtil.formatBytes(memoryMegas)}';

			textColor = 0xFFFFFFFF;
			if (currentFPS <= ClientPrefs.data.framerate / 2)
				textColor = 0xFFFF0000;

			text += "\n";
		}

		cacheCount = currentCount;
		deltaTimeout += deltaTime;
	}
}
