package backend;

import haxe.extern.EitherType;
#if VIDEOS_ALLOWED 
#if (hxCodec >= "3.0.0") import hxcodec.flixel.FlxVideo as VideoHandler;
#elseif (hxCodec >= "2.6.1") import hxcodec.VideoHandler;
#elseif (hxCodec == "2.6.0") import VideoHandler;
#else import vlc.MP4Handler as VideoHandler; #end
#end

#if VIDEOS_ALLOWED
 /**
 * A class meant to manage Video functions from diffrent hxCodec versions
 */
class VideoManager extends VideoHandler {
    public var playbackRate(get, set):EitherType<Single, Float>;
    public var endCallBack(default, set):Void->Void;
    public var startCallBack(default, set):Void->Void;
    public var paused(default, set):Bool = false;
    public var ended(get, never):Bool;

    public function new() {
        super();
    }

    public function startVideo(path:String, loop:Bool = false) {
        #if (hxCodec >= "3.0.0")
        play(path, loop);
        #else
        playVideo(path, loop, false);
        #end
    }

    @:noCompletion
    private function set_paused(shouldPause:Bool){
        if(shouldPause){
            pause();
            if(FlxG.autoPause) {
                if(FlxG.signals.focusGained.has(pause))
                    FlxG.signals.focusGained.remove(pause);
    
                if(FlxG.signals.focusLost.has(resume))
                    FlxG.signals.focusLost.remove(resume);
            }
        } else {
            resume();
            if(FlxG.autoPause) {
                FlxG.signals.focusGained.add(pause);
                FlxG.signals.focusLost.add(resume);
            }
        }
        return shouldPause;
    }

    @:noCompletion
    private function set_startCallBack(func:Void->Void){
        if(func != null){
            #if (hxCodec >= "3.0.0")
            onOpening.add(func, true);
            #else
            openingCallback = func;
            #end
        }
        return func; // haxe forcing me to put a return i have no idea why
    }

    @:noCompletion
    private function set_endCallBack(func:Void->Void){
        if(func != null) {
            #if (hxCodec >= "3.0.0")
            onEndReached.add(func);
            #else
            finishCallback = func;
            #end
        }
        return func;
    }

    @:noCompletion
    private function set_playbackRate(multi:EitherType<Single, Float>){
        rate = multi;
        return multi;
    }

    @:noCompletion
    private function get_playbackRate():Float {
        return rate;
    }

    @:noCompletion
    private function get_ended():Bool {
        var status:Bool = false;
        #if (hxCodec >= "3.0.0") 
        if(videoWidth == 0) // hxCodec 3.0.0 and newer sets video width and hieght to 0 on end so...
            status = true;
        #else
        status = isDisplaying;
        #end        
        return status;
    }
    #end
}
