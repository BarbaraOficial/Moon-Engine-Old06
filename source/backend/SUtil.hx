package backend;

#if android
import android.widget.Toast;
#end
import haxe.io.Path;
import haxe.CallStack;
import lime.system.System as LimeSystem;
import lime.utils.Assets as LimeAssets;
import lime.utils.Log as LimeLogger;
import openfl.events.UncaughtErrorEvent;
import openfl.Lib;
import lime.utils.AssetType;

using StringTools;

/**
 * ...
 * @author Mihai Alexandru (M.A. Jigsaw)
 */
class SUtil
{

	public static function copyAssets(?to:String = '') {
		if(!FileSystem.exists('assets') || !FileSystem.exists('mods'))
			Lib.application.window.alert(
			"The game have noticed that there are missing files so it'll begin copying them\nThis operation might take time so please wait\nWhen copying is done the game will run normally",
			"Notice!");
		for(file in LimeAssets.list()) {
			var fixedPath = Path.join([to, file]);
			if((file.contains('mods') || file.contains('assets')) && !FileSystem.exists(fixedPath)) {
				var directory = Path.directory(file);
				if(!FileSystem.exists(directory))
					mkDirs(directory);
				var extension = Path.extension(file);
				if(extension == 'otf' || extension == 'ttf')
					File.saveBytes(fixedPath, cast LimeAssets.getFont(file));
				else if(extension == 'txt')
					File.saveBytes(fixedPath, cast LimeAssets.getText(file));
				else
					File.saveBytes(fixedPath, LimeAssets.getBytes(file));
			}
		}
	}

	/**
	 * A simple function that checks for game files/folders.
	 */
	public static function checkFiles():Void
	{
		#if mobile
		if (!FileSystem.exists('assets') && !FileSystem.exists('mods'))
		{
			Lib.application.window.alert("Whoops, seems like you didn't extract the files from the .APK!\nPlease copy the files from the .APK to\n"
				+ Sys.getCwd(), 'Error!');
			LimeSystem.exit(1);
		}
		else if ((FileSystem.exists('assets') && !FileSystem.isDirectory('assets'))
			&& (FileSystem.exists('mods') && !FileSystem.isDirectory('mods')))
		{
			Lib.application.window.alert("Why did you create two files called assets and mods instead of copying the folders from the .APK?, expect a crash.",
				'Error!');
			LimeSystem.exit(1);
		}
		else
		{
			if (!FileSystem.exists('assets'))
			{
				Lib.application.window.alert("Whoops, seems like you didn't extract the assets/assets folder from the .APK!\nPlease copy the assets/assets folder from the .APK to\n"
					+ Sys.getCwd(),
					'Error!');
				LimeSystem.exit(1);
			}
			else if (FileSystem.exists('assets') && !FileSystem.isDirectory('assets'))
			{
				Lib.application.window.alert("Why did you create a file called assets instead of copying the assets directory from the .APK?, expect a crash.",
					'Error!');
				LimeSystem.exit(1);
			}

			if (!FileSystem.exists('mods'))
			{
				Lib.application.window.alert("Whoops, seems like you didn't extract the assets/mods folder from the .APK!\nPlease copy the assets/mods folder from the .APK to\n"
					+ Sys.getCwd(),
					'Error!');
				LimeSystem.exit(1);
			}
			else if (FileSystem.exists('mods') && !FileSystem.isDirectory('mods'))
			{
				Lib.application.window.alert("Why did you create a file called mods instead of copying the mods directory from the .APK?, expect a crash.",
					'Error!');
				LimeSystem.exit(1);
			}
		}
		#end
	}

	/**
	 * Uncaught error handler, original made by: Sqirra-RNG and YoshiCrafter29
	 */
	public static function uncaughtErrorHandler():Void
	{
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onError);
	}

	private static function onError(error:UncaughtErrorEvent):Void
	{
		final log:Array<String> = [error.error];

		for (item in CallStack.exceptionStack(true))
		{
			switch (item)
			{
				case CFunction:
					log.push('C Function');
				case Module(m):
					log.push('Module [$m]');
				case FilePos(s, file, line, column):
					log.push('$file [line $line]');
				case Method(classname, method):
					log.push('$classname [method $method]');
				case LocalFunction(name):
					log.push('Local Function [$name]');
			}
		}

		final msg:String = log.join('\n');

		#if sys
		try
		{
			if (!FileSystem.exists('logs'))
				FileSystem.createDirectory('logs');

			File.saveContent('logs/' + Date.now().toString().replace(' ', '-').replace(':', "'") + '.txt', msg + '\n');
		}
		catch (e:Dynamic)
		{
			#if (android && debug)
			Toast.makeText("Error!\nClouldn't save the crash dump because:\n" + e, Toast.LENGTH_LONG);
			#else
			LimeLogger.println("Error!\nClouldn't save the crash dump because:\n" + e);
			#end
		}
		#end

		LimeLogger.println(msg);
		Lib.application.window.alert(msg, 'Error!');

		#if (desktop && !hl)
		DiscordClient.shutdown();
		#end

		LimeSystem.exit(1);
	}

	/**
	 * This is mostly a fork of https://github.com/openfl/hxp/blob/master/src/hxp/System.hx#L595
	 */
	#if sys
	public static function mkDirs(directory:String):Void
	{
		var total:String = '';
		if (directory.substr(0, 1) == '/')
			total = '/';

		var parts:Array<String> = directory.split('/');
		if (parts.length > 0 && parts[0].indexOf(':') > -1)
			parts.shift();

		for (part in parts)
		{
			if (part != '.' && part != '')
			{
				if (total != '' && total != '/')
					total += '/';

				total += part;

				if (!FileSystem.exists(total))
					FileSystem.createDirectory(total);
			}
		}
	}

	public static function saveContent(fileName:String = 'file', fileExtension:String = '.json',
			fileData:String = 'you forgot to add something in your code lol'):Void
	{
		try
		{
			if (!FileSystem.exists('saves'))
				FileSystem.createDirectory('saves');

			File.saveContent('saves/' + fileName + fileExtension, fileData);
			Lib.application.window.alert(fileName + " file has been saved", "Success!");
		}
		catch (e:Dynamic)
		{
			#if (android && debug)
			Toast.makeText("Error!\nClouldn't save the file because:\n" + e, Toast.LENGTH_LONG);
			#else
			LimeLogger.println("Error!\nClouldn't save the file because:\n" + e);
			#end
		}
	}

	public static function copyContent(copyPath:String, savePath:String):Void
	{
		try {
			if (!FileSystem.exists(savePath) && LimeAssets.exists(copyPath))
			{
				if (!FileSystem.exists(Path.directory(savePath)))
					mkDirs(Path.directory(savePath));
				if(copyPath.endsWith('.otf') || copyPath.endsWith('.ttf'))
					File.saveBytes(savePath, cast LimeAssets.getFont(copyPath));
				else if(copyPath.endsWith('.txt'))
					File.saveBytes(savePath, cast LimeAssets.getText(copyPath));
				else
					File.saveBytes(savePath, LimeAssets.getBytes(copyPath));
			}
		}
		catch (e:Dynamic)
		{
			#if (android && debug)
			Toast.makeText('Error!\nClouldn\'t copy the $copyPath because:\n' + e, Toast.LENGTH_LONG);
			#else
			LimeLogger.println('Error!\nClouldn\'t copy the $copyPath because:\n' + e);
			#end
		}
	}
	#end
	public static function getFileType(file:String):AssetType {
		switch(Path.extension(file)) {
			case 'png' | 'jpg' | 'jpeg':
				return IMAGE;
			case 'txt' | 'xml' | 'json' | 'lua' | 'hx':
				return TEXT;
			case 'otf' | 'ttf':
				return FONT;
			case 'ogg' | 'mp3':
				return SOUND;
			default:
				return BINARY;
		}
	}
}
