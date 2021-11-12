package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import sys.FileSystem;
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState {
	var curSelected:Int = 1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Dynamic> = [];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		bg = new FlxSprite().loadGraphic(Paths.image('menus/creditbg'));
		bg.setGraphicSize(Std.int(bg.width * 2/3));
		bg.updateHitbox();
		add(bg);

		//
		var upperbarrier:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('menus/main/upperbarrier'));
		upperbarrier.scrollFactor.set(0, 0);
		upperbarrier.antialiasing = ClientPrefs.globalAntialiasing;
		add(upperbarrier);

		var lowerbarrier:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('menus/main/lowerbarrier'));
		lowerbarrier.scrollFactor.set(0, 0);
		lowerbarrier.antialiasing = ClientPrefs.globalAntialiasing;
		add(lowerbarrier);

		//
		var creditSprite:FlxSprite = new FlxSprite();
		creditSprite.frames = Paths.getSparrowAtlas('menus/main/menu_credits');
		creditSprite.animation.addByPrefix('idle', "credits white", 12);
		creditSprite.animation.play('idle');
		add(creditSprite);
		//
		creditSprite.setGraphicSize(Std.int(creditSprite.width * 2/3));
		creditSprite.updateHitbox();
		creditSprite.antialiasing = true;
		//
		creditSprite.screenCenter(X);
		creditSprite.y += 60;
		//

		// left n right
		var left:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('menus/main/leftbutton'));
		left.setGraphicSize(Std.int(left.width * 2/3));
		left.updateHitbox();
		left.screenCenter();
		left.x = left.width * 2;
		add(left);
		var right:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('menus/main/rightbutton'));
		right.setGraphicSize(Std.int(right.width * 2/3));
		right.updateHitbox();
		right.screenCenter();
		right.x = FlxG.width - (right.width * 2);
		add(right);

		var markX:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('menus/main/x'));
		markX.setGraphicSize(Std.int(markX.width * 2/3));
		markX.updateHitbox();
		markX.setPosition(FlxG.width - (markX.width + 20), 20);
		add(markX);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		super.update(elapsed);
	}
}
