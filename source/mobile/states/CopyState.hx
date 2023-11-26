/* KNNOWN ISSUES:
    - Errors while copying .txt, .ttf and .otf
   TODO: 
    - Figure out a way to calculate the ammount files in FileSystem directory to get the exact ammount of files that should be copied
    - Add a loading bar (probably wont)    
*/
package mobile.states;

import flixel.addons.util.FlxAsyncLoop;
import lime.utils.Assets as LimeAssets;
import openfl.utils.Assets as OpenflAssets;
import haxe.io.Path;
import flixel.ui.FlxBar;
import states.TitleState;
import lime.utils.Bytes;
import states.MainMenuState;
#if (target.threaded)
import sys.thread.Thread;
#end
#if android
import android.widget.Toast;
#end

class CopyState extends MusicBeatState {
    public static var filesToCopy:Array<String>;
    public var loadingImage:FlxSprite;
    public var bottomBG:FlxSprite;
    public var loadedText:FlxText;
    public var copyLoop:FlxAsyncLoop;
    var loopTimes:Int = 0;
    var maxLoopTimes:Int = 0;
    var failedFiles:Int = 0;
    var failedFilesStr:String = '';
    var shouldCopy:Bool = false;
    override function create() {
        if(!SUtil.filesExists()){
            shouldCopy = true;
			FlxG.stage.application.window.alert(
			"The game have noticed that there are missing files so it'll begin copying them\nThis operation might take time so please wait\nWhen copying is done the game will run normally",
			"Notice!");
            filesToCopy = LimeAssets.list();
            // removes unwanted paths
            var assets = filesToCopy.filter(folder -> folder.startsWith('assets/'));
            var mods = filesToCopy.filter(folder -> folder.startsWith('mods/'));
            var allPaths = assets.concat(mods);
            filesToCopy = allPaths;

            maxLoopTimes = filesToCopy.length;
            loadingImage = new FlxSprite(0, 0, Paths.image('funkin'));
            loadingImage.scale.set(0.8, 0.8);
            loadingImage.screenCenter();
            add(loadingImage);

            bottomBG = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
		    bottomBG.alpha = 0.6;
		    add(bottomBG);
            loadedText = new FlxText(bottomBG.x, bottomBG.y + 4, FlxG.width, '', 16);
            loadedText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, CENTER);
            add(loadedText);
            #if (target.threaded) Thread.create(() -> {#end
            copyLoop = new FlxAsyncLoop(maxLoopTimes, copyAsset, 17);
            add(copyLoop);
            copyLoop.start();
            #if (target.threaded) }); #end
        } else
            FlxG.switchState(new TitleState());
        super.create();
    }

    override function update(elapsed:Float) {
        if(shouldCopy){
            if(copyLoop.finished){
                if(failedFiles > 0)
                    FlxG.stage.application.window.alert(failedFilesStr, 'Failed To Copy $failedFiles File.');
                FlxG.switchState(new TitleState());
            }
            loadedText.text = '$loopTimes/$maxLoopTimes';
        }
        super.update(elapsed);
    }

    public function copyAsset() {
        ++loopTimes;
        var file = filesToCopy[loopTimes];
		if(!FileSystem.exists(file)) {
			var directory = Path.directory(file);
		    if(!FileSystem.exists(directory))
					SUtil.mkDirs(directory);
            try{
                File.saveBytes(file, getFileBytes('${getFileLibrary(file)}$file'));
            }catch(e:Dynamic){
                --loopTimes;
                ++failedFiles;
                failedFilesStr += '$file\n';
            }
		}
	}

    public static function getFileBytes(file:String):Bytes {
		switch(Path.extension(file)) {
			case 'otf' | 'ttf':
				return cast LimeAssets.getAsset(file, FONT, false);
            case 'txt':
				return cast LimeAssets.getAsset(file, TEXT, false);
			default:
				return OpenflAssets.getBytes(file);
		}
	}
	public static function getFileLibrary(file:String):String {
		for(index in 1...8)
			if(file.contains('/week$index/'))
				return 'week_assets:';
		if(file.contains('videos'))
			return 'videos:';
		else if(file.contains('songs'))
			return 'songs:';
		else if(!MainMenuState.psychEngineVersion.contains('7.2')) // for versions with preload
			return 'shared:';
		else
			return '';
	}
}