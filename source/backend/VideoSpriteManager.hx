package backend;

import haxe.extern.EitherType;
#if VIDEOS_ALLOWED 
#if (hxCodec >= "3.0.0") import hxcodec.flixel.FlxVideoSprite as VideoSprite;
#elseif (hxCodec >= "2.6.1") import hxcodec.VideoSprite;
#elseif (hxCodec == "2.6.0") import VideoSprite;
#else import vlc.MP4Sprite as VideoSprite; #end
#end
import states.PlayState;

#if VIDEOS_ALLOWED
 /**
 * A class meant to manage VideoSprite functions from diffrent hxCodec versions
 */
class VideoSpriteManager extends VideoSprite {
    
    var onPlayState(get, never):Bool;
    public var playbackRate(get, set):EitherType<Single, Float>;
    public var endCallBack(default, set):Void->Void;
    public var startCallBack(default, set):Void->Void;
    public var paused(default, set):Bool = false;
    public var ended(get, never):Bool;
    
    public function new(x:Float, y:Float #if (hxCodec < "2.6.0"), width:Float = 1280, height:Float = 720, autoScale:Bool = true #end){
        
        super(x, y #if (hxCodec < "2.6.0"), width, height, autoScale #end);
        
        if(onPlayState)
            PlayState.instance.videoSprites.push(this); 
    }
    
     public function startVideo(path:String, loop:Bool = false) {
        #if (hxCodec >= "3.0.0")
        play(path, loop);
        #else
        playVideo(path, loop, false);
        #end
        if(onPlayState)
            playbackRate = PlayState.instance.playbackRate;
    }

    @:noCompletion
    private function set_paused(shouldPause:Bool){
        #if (hxCodec >= "3.0.0")
        var parentResume = resume;
        var parentPause = pause;
        #else
        var parentResume = bitmap.resume;
        var parentPause = bitmap.pause;
        #end

        if(shouldPause){
            #if (hxCodec >= "3.0.0")
            pause();
            #else
            bitmap.pause();
            #end
    
            if(FlxG.autoPause) {
                if(FlxG.signals.focusGained.has(parentResume))
                    FlxG.signals.focusGained.remove(parentResume);
    
                if(FlxG.signals.focusLost.has(parentPause))
                    FlxG.signals.focusLost.remove(parentPause);
            }
        } else {
            #if (hxCodec >= "3.0.0")
            resume();
            #else
            bitmap.resume();
            #end

            if(FlxG.autoPause) {
                FlxG.signals.focusGained.add(parentResume);
                FlxG.signals.focusLost.add(parentPause);
            }
        }
        return shouldPause;
    }

    @:noCompletion
    private function set_startCallBack(func:Void->Void){
        if(func != null){
            #if (hxCodec >= "3.0.0")
            bitmap.onOpening.add(func, true);
            #else
            bitmap.openingCallback = func;
            #end
        }
        return func; // haxe forcing me to put a return i have no idea why
    }

    @:noCompletion
    private function set_endCallBack(func:Void->Void){
        if(func != null) {
            #if (hxCodec >= "3.0.0")
            bitmap.onEndReached.add(func);
            #else
            bitmap.finishCallback = func;
            #end
        }
        return func;
    }

    @:noCompletion
    private function set_playbackRate(multi:EitherType<Single, Float>){
        bitmap.rate = multi;
        return multi;
    }

    @:noCompletion
    private function get_playbackRate():Float {
        return bitmap.rate;
    }

    @:noCompletion
    private function get_onPlayState():Bool {
        return Std.isOfType(MusicBeatState.getState(), PlayState);
    }

    @:noCompletion
    private function get_ended():Bool {
        var status:Bool = false;
        #if (hxCodec >= "3.0.0") 
        if(bitmap.videoWidth == 0) // hxCodec 3.0.0 and newer sets video width and hieght to 0 on end so...
            status = true;
        #else
        status = bitmap.isDisplaying;
        #end        
        return status;
    }
    #end
}
