package dependency;

import flixel.FlxSprite;

class FNFSprite extends FlxSprite {
    public var animOffsets:Map<String, Array<Dynamic>>;
    public function new(x:Float = 0, y:Float = 0) {
        super(x, y);
        animOffsets = new Map<String, Array<Dynamic>>();
    }

    public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
    {
        animation.play(AnimName, Force, Reversed, Frame);
    
        var daOffset = animOffsets.get(AnimName);
        if (animOffsets.exists(AnimName)) {
            offset.set(daOffset[0] * scale.x, daOffset[1] * scale.y);
        }
        else
            offset.set(0, 0);
    }
    
    public function addOffset(name:String, x:Float = 0, y:Float = 0)
        animOffsets[name] = [x, y];
}