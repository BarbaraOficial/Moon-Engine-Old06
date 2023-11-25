/* KNNOWN ISSUES:
    - Beign a dick and attempt to copy flixel files
    - Unable to copy .txt and fonts
    - Almost 70% of the files are missing
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
    var shouldCopy:Bool = false;
    override function create() {
        if(!SUtil.filesExists()){
            shouldCopy = true;
			FlxG.stage.application.window.alert(
			"The game have noticed that there are missing files so it'll begin copying them\nThis operation might take time so please wait\nWhen copying is done the game will run normally",
			"Notice!");
            filesToCopy = LimeAssets.list();
            // removes unwanted paths
            for(path in filesToCopy)
                if(!path.contains('assets') || !path.contains('mods') || path.contains('flixel'))
                    filesToCopy.remove(path);
            maxLoopTimes = filesToCopy.length; // TODO: Make it use how many files should be copied and not the whole list
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
            copyLoop = new FlxAsyncLoop(maxLoopTimes, copyAsset, 1);
            add(copyLoop);
            copyLoop.start();
            #if (target.threaded) }); #end
        } else
            FlxG.switchState(new TitleState());
        super.create();
    }

    override function update(elapsed:Float) {
        if(shouldCopy){
            if(copyLoop.finished)
                FlxG.switchState(new TitleState());
            loadedText.text = '$loopTimes/$maxLoopTimes';
        }
        super.update(elapsed);
    }

    public function copyAsset() {
        var file = filesToCopy[0];
		if(!FileSystem.exists(file)) {
			var directory = Path.directory(file);
		    if(!FileSystem.exists(directory))
					SUtil.mkDirs(directory);
				//File.saveBytes(file, SUtil.getFileBytes('${SUtil.getFileLibrary(file)}$file'));
                try{
                    File.saveBytes(file, getFileBytes('${getFileLibrary(file)}$file'));
                }catch(e:Dynamic){
                    FlxG.stage.application.window.alert('Failed to copy $file because\n$e', 'Error while Copying ${Path.withoutDirectory(file)}');
                }
            ++loopTimes;
            filesToCopy.remove(filesToCopy[0]);
		}
	}

    public static function getFileBytes(file:String):Bytes {
		switch(Path.extension(file)) {
			case 'otf' | 'ttf':
				return cast OpenflAssets.getFont(file);
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