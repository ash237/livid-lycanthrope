package;

import flixel.FlxSprite;

class Credit extends FlxSprite
{
	public var link:String;
	public var name:String;

	public function new(x:Float = 0, y:Float = -1000000, iconname:String = 'Ardolf', ?linkname:String = 'https://linktr.ee/ardolf',xx:Float = 1, yy:Float = 1)
	{
		super(x, y);
		scale.set(xx,yy);
		link = linkname;
		name = iconname;
		loadGraphic(Paths.image('credits/' + iconname));
	}
}
