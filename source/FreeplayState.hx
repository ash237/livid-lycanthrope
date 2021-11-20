package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import flixel.system.FlxSound;
import openfl.utils.Assets as OpenFlAssets;
import WeekData;

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	var selector:FlxText;
	private static var curSelected:Int = 0;
	private static var curDifficulty:Int = 1;

	var scoreBG:FlxSprite;
	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;

	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];
	var backgroundArray:FlxTypedGroup<FlxSprite>;
	var lockarray:FlxTypedGroup<FlxSprite>;
	var locka:FlxSprite;
	var x:FlxSprite;

	var cover1:FlxSprite;
	var cover2:FlxSprite;
	var cover3:FlxSprite;
	var cover4:FlxSprite;
	var coverlock:FlxSprite;

	var normal:FlxSprite;
	var expert:FlxSprite;

	var fc:FlxSprite;
	var fcexp:FlxSprite;

	var funnytween:FlxTween;
	var funnytween2:FlxTween;

	var funnytween3:FlxTween;
	var funnytween4:FlxTween;

	override function create()
	{
		FlxG.mouse.visible = true;
		#if MODS_ALLOWED
		Paths.destroyLoadedImages();
		#end
		WeekData.reloadWeekFiles(false);
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		trace(FlxG.save.data.fcall2);
		if (FlxG.save.data.fcall2)
			FlxG.save.data.fcall = true;

		if (FlxG.save.data.songone80 && FlxG.save.data.songtwo80 && FlxG.save.data.songthree80)
			FlxG.save.data.all80 = true;

		for (i in 0...WeekData.weeksList.length) {
			var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var leSongs:Array<String> = [];
			var leChars:Array<String> = [];
			for (j in 0...leWeek.songs.length) {
				leSongs.push(leWeek.songs[j][0]);
				leChars.push(leWeek.songs[j][1]);
			}

			WeekData.setDirectoryFromWeek(leWeek);
			for (song in leWeek.songs) {
				var colors:Array<Int> = song[2];
				if(colors == null || colors.length < 3) {
					colors = [146, 113, 253];
				}
				addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]));
			}
		}
		WeekData.setDirectoryFromWeek();

		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));
		for (i in 0...initSonglist.length)
		{
			if(initSonglist[i] != null && initSonglist[i].length > 0) {
				var songArray:Array<String> = initSonglist[i].split(":");
				addSong(songArray[0], 0, songArray[1], Std.parseInt(songArray[2]));
			}
		}

		backgroundArray = new FlxTypedGroup<FlxSprite>();
		add(backgroundArray);
		for (i in 1...3) {
			var bg = new FlxSprite().loadGraphic(Paths.image('menus/freeplay/select_song_bg' + i));
			bg.antialiasing = ClientPrefs.globalAntialiasing;
			bg.setGraphicSize(Std.int(bg.width * 2/3));
			bg.updateHitbox();

			backgroundArray.add(bg);
		}
		var leftdot:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('menus/freeplay/leftdot'));
		leftdot.scrollFactor.set(0, 0);
		leftdot.antialiasing = ClientPrefs.globalAntialiasing;
		leftdot.y += 50;
		add(leftdot);

		var rightdot:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('menus/freeplay/rightdot'));
		rightdot.scrollFactor.set(0, 0);
		rightdot.antialiasing = ClientPrefs.globalAntialiasing;
		rightdot.y += 50;
		add(rightdot);

		cover1 = new FlxSprite().loadGraphic(Paths.image('menus/freeplay/firstsongcover'));
		cover1.antialiasing = ClientPrefs.globalAntialiasing;
		cover1.screenCenter();
		cover1.x -= 270;
		cover1.y += 20;
		cover1.setGraphicSize(Std.int(cover1.width * 2/3 + 0.25));
		add(cover1);

		cover2 = new FlxSprite().loadGraphic(Paths.image('menus/freeplay/secondsongcover'));
		cover2.antialiasing = ClientPrefs.globalAntialiasing;
		cover2.screenCenter();
		cover2.x -= 270;
		cover2.y += 20;
		cover2.setGraphicSize(Std.int(cover2.width * 2/3 + 0.25));
		add(cover2);

		cover3 = new FlxSprite().loadGraphic(Paths.image('menus/freeplay/thirdsongcover'));
		cover3.antialiasing = ClientPrefs.globalAntialiasing;
		cover3.screenCenter();
		cover3.x -= 270;
		cover3.y += 20;
		cover3.setGraphicSize(Std.int(cover3.width * 2/3 + 0.25));
		add(cover3);

		cover4 = new FlxSprite().loadGraphic(Paths.image('menus/freeplay/varcolaccover'));
		cover4.antialiasing = ClientPrefs.globalAntialiasing;
		cover4.screenCenter();
		cover4.x -= 270;
		cover4.y += 20;
		cover4.setGraphicSize(Std.int(cover4.width * 2/3 + 0.25));
		add(cover4);

		coverlock = new FlxSprite().loadGraphic(Paths.image('menus/freeplay/lockedcover'));
		coverlock.antialiasing = ClientPrefs.globalAntialiasing;
		coverlock.screenCenter();
		coverlock.x -= 270;
		coverlock.y += 20;
		coverlock.setGraphicSize(Std.int(coverlock.width * 2/3 + 0.25));
		add(coverlock);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		lockarray = new FlxTypedGroup<FlxSprite>();
		add(lockarray);

		for (i in 0...3)
			{
					var lock = new FlxSprite().loadGraphic(Paths.image('menus/freeplay/lock1'));
					lock.antialiasing = ClientPrefs.globalAntialiasing;
					lock.scale.set(0.75,0.75);
					lockarray.add(lock);
			}

		locka = new FlxSprite().loadGraphic(Paths.image('menus/freeplay/lock3'));
		locka.antialiasing = ClientPrefs.globalAntialiasing;
		locka.scale.set(0.75,0.75);
		add(locka);

		for (i in 0...songs.length)	
		{
			var songText:Alphabet = new Alphabet(-5, (70 * i) + 30, songs[i].songName, true, false,0,0.75);
			songText.isMenuItem = true;
			songText.targetY = i;
			songText.isFreeplay = true;
			songText.x += 725;
			grpSongs.add(songText);

			Paths.currentModDirectory = songs[i].folder;
			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}

		var upperbarrier:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('menus/main/upperbarrier'));
		upperbarrier.scrollFactor.set(0, 0);
		upperbarrier.antialiasing = ClientPrefs.globalAntialiasing;
		add(upperbarrier);

		var lowerbarrier:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('menus/main/lowerbarrier'));
		lowerbarrier.scrollFactor.set(0, 0);
		lowerbarrier.antialiasing = ClientPrefs.globalAntialiasing;
		add(lowerbarrier);

		var freeplaySprite:FlxSprite = new FlxSprite();
		freeplaySprite.frames = Paths.getSparrowAtlas('menus/main/menu_freeplay');
		freeplaySprite.animation.addByPrefix('idle', "freeplay white", 12);
		freeplaySprite.animation.play('idle');
		add(freeplaySprite);
		//
		freeplaySprite.setGraphicSize(Std.int(freeplaySprite.width * 2/3));
		freeplaySprite.updateHitbox();
		freeplaySprite.antialiasing = true;
		//
		freeplaySprite.x += 30;
		freeplaySprite.y += 60;
		
		WeekData.setDirectoryFromWeek();

		scoreText = new FlxText(45, 610, 0, "", 32);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
		scoreText.scale.set(1.3,1.3);

		scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		add(diffText);

		add(scoreText);

		if(curSelected >= songs.length) 
			curSelected = 0;

		x = new FlxSprite(1280 - 84,10).loadGraphic(Paths.image('credits/x'));
		x.updateHitbox();
		x.scale.set(0.8,0.8);
		x.antialiasing = true;
		add(x);

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);
		#if PRELOAD_ALL
		var leText:String = "";
		#else
		var leText:String = "";
		#end
		var text:FlxText = new FlxText(textBG.x, textBG.y + 4, FlxG.width, leText, 18);
		text.setFormat(Paths.font("vcr.ttf"), 18, FlxColor.WHITE, RIGHT);
		text.scrollFactor.set();
		add(text);

		cover1.alpha = 0;
		cover2.alpha = 0;
		cover3.alpha = 0;
		cover4.alpha = 0;
		coverlock.alpha = 0;

		var bs:FlxSprite = new FlxSprite(-70,540).loadGraphic(Paths.image('menus/freeplay/best_score'));
		bs.scrollFactor.set(0, 0);
		bs.antialiasing = ClientPrefs.globalAntialiasing;
		bs.scale.set(0.6,0.6);
		add(bs);

		var difftext:Alphabet = new Alphabet(0, 30, 'Difficulty', true, false,0,0.5);
		difftext.diff2 = true;
		add(difftext);

		expert = new FlxSprite(-448,35).loadGraphic(Paths.image('menus/story/exp'));
		expert.scrollFactor.set(0, 0);
		expert.scale.set(0.16,0.16);
		expert.antialiasing = ClientPrefs.globalAntialiasing;
		add(expert);

		normal = new FlxSprite(-850,35).loadGraphic(Paths.image('menus/story/nrm'));
		normal.scrollFactor.set(0, 0);
		normal.scale.set(0.12,0.12);
		normal.antialiasing = ClientPrefs.globalAntialiasing;
		add(normal);

		leftArrow = new FlxSprite(1163).loadGraphic(Paths.image('credits/leftbutton'));
		leftArrow.updateHitbox();
		leftArrow.antialiasing = true;
		leftArrow.angle += 90;
		add(leftArrow);

		rightArrow = new FlxSprite(1163).loadGraphic(Paths.image('credits/rightbutton'));
		rightArrow.updateHitbox();
		rightArrow.antialiasing = true;
		rightArrow.angle += 90;
		add(rightArrow);
		rightArrow.screenCenter(Y);
		leftArrow.screenCenter(Y);
		rightArrow.y += 150;
		leftArrow.y-= 150;

		fc = new FlxSprite().loadGraphic(Paths.image('menus/freeplay/silver'));
		fc.antialiasing = true;
		fc.screenCenter();
		fc.alpha = 0;
		add(fc);

		fcexp = new FlxSprite().loadGraphic(Paths.image('menus/freeplay/gold'));
		fcexp.antialiasing = true;
		fcexp.screenCenter();
		fcexp.alpha = 0;
		add(fcexp);

		if (FlxG.save.data.fcall)
			{
				fc.alpha = 1;
				if (FlxG.save.data.fcall2)
					{
						fcexp.alpha = 1;
						fc.x -= 125;
					}
			}

		changeSelection();
		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, color));
	}

	/*public function addWeek(songs:Array<String>, weekNum:Int, weekColor:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);
			this.songs[this.songs.length-1].color = weekColor;

			if (songCharacters.length != 1)
				num++;
		}
	}*/

	var instPlaying:Int = -1;
	private static var vocals:FlxSound = null;
	override function update(elapsed:Float)
	{

		if (FlxG.mouse.overlaps(leftArrow))
			leftArrow.scale.set(1.05,1.05);
		else
			leftArrow.scale.set(1,1);

		if (FlxG.mouse.overlaps(rightArrow))
			rightArrow.scale.set(1.05,1.05);
		else
			rightArrow.scale.set(1,1);

		if (FlxG.mouse.justPressed)
			{
				if (FlxG.mouse.overlaps(leftArrow))
				{
							leftArrow.y -= 10;
							FlxTween.tween(leftArrow, {y: leftArrow.y + 10}, 0.4, {
								ease: FlxEase.expoOut,
							});
							changeSelection(-1);
				}
				if (FlxG.mouse.overlaps(rightArrow))
				{
							changeSelection(1);
							rightArrow.y += 10;
							FlxTween.tween(rightArrow, {y: rightArrow.y - 10}, 0.4, {
								ease: FlxEase.expoOut,
							});
				}
			}

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (FlxG.mouse.overlaps(x))
			x.scale.set(0.85,0.85);
		else
			x.scale.set(0.8,0.8);

		lockarray.members[0].x = grpSongs.members[0].x - 170;
		lockarray.members[0].y = grpSongs.members[0].y - 70;
		lockarray.members[1].x = grpSongs.members[1].x - 170;
		lockarray.members[1].y = grpSongs.members[1].y - 70;
		lockarray.members[2].x = grpSongs.members[2].x - 170;
		lockarray.members[2].y = grpSongs.members[2].y - 70;
		locka.x = grpSongs.members[3].x - 170;
		locka.y = grpSongs.members[3].y - 70;

		if (FlxG.mouse.justPressed)
			{
				if (FlxG.mouse.overlaps(x))
					{
						FlxG.sound.play(Paths.sound('cancelMenu'));
						MusicBeatState.switchState(new MainMenuState());
					}
			}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, CoolUtil.boundTo(elapsed * 12, 0, 1));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		scoreText.text = '' + lerpScore + ' (' + Math.floor(lerpRating * 100) + '%)';
		positionHighscore();

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;
		var space = FlxG.keys.justPressed.SPACE;

		var shiftMult:Int = 1;
		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

		if (upP)
		{
			changeSelection(-shiftMult);
		}
		if (downP)
		{
			changeSelection(shiftMult);
		}

		if (controls.UI_LEFT_P)
			changeDiff(-1);
		if (controls.UI_RIGHT_P)
			changeDiff(1);

		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		#if PRELOAD_ALL
		if(space && instPlaying != curSelected)
		{

		}
		else #end if (accepted)
		{
			if (FlxG.save.data.beatweek)
				{
					switch (curSelected)
					{
						case 3:
							if (FlxG.save.data.all80)
								{
									selectsong();
								}
						default:
							selectsong();
					}
				}
		}
		super.update(elapsed);
	}

	public static function destroyFreeplayVocals() {
		if(vocals != null) {
			vocals.stop();
			vocals.destroy();
		}
		vocals = null;
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (curDifficulty == 3)
			curDifficulty = 1;
		if (curDifficulty == 0)
			curDifficulty = 2;

		if (curDifficulty == 2)
			{
				expert.alpha = 1;
				normal.alpha = 0;
			}
		else
			{
				expert.alpha = 0;
				normal.alpha = 1;
			}
		if(funnytween != null) {
			funnytween.cancel();
		}
		if(funnytween2 != null) {
			funnytween2.cancel();
		}
		expert.scale.set(0.18,0.18);
		normal.scale.set(0.14,0.14);
		funnytween = FlxTween.tween(expert, {"scale.x": 0.16,"scale.y": 0.16}, 0.4, {ease: FlxEase.cubeOut,onComplete: function(twn:FlxTween) {
			funnytween = null;
				}
			});
		funnytween2 = FlxTween.tween(normal, {"scale.x": 0.12,"scale.y": 0.12}, 0.4, {ease: FlxEase.cubeOut,onComplete: function(twn:FlxTween) {
			funnytween2 = null;
				}
			});
		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		PlayState.storyDifficulty = curDifficulty;
		diffText.text = '';
		positionHighscore();
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;
		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		var bullShit:Int = 0;
		checkcover();

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
			if (!FlxG.save.data.beatweek)
				{
					iconArray[i].alpha = 0;
				}
		}

		if (!FlxG.save.data.beatweek)
			{
				iconArray[curSelected].alpha = 0;
			}
			else
				iconArray[curSelected].alpha = 1;
		

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (!FlxG.save.data.beatweek)
				{
					item.alpha = 0;
				}
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				if (!FlxG.save.data.beatweek)
					{
						item.alpha = 0;
					}

				// item.setGraphicSize(Std.int(item.width));
			}
		}
		if (!FlxG.save.data.all80)
			{
				grpSongs.members[3].alpha = 0;
				iconArray[3].alpha = 0;
			}
		changeDiff();
		Paths.currentModDirectory = songs[curSelected].folder;
	}

	private function positionHighscore() {
		diffText.x = Std.int(scoreBG.x + (scoreBG.width / 2));
		diffText.x -= diffText.width / 2;
	}

	function checkcover()
		{
			if(funnytween3 != null) {
				funnytween3.cancel();
			}
			if(funnytween4 != null) {
				funnytween4.cancel();
			}
			cover1.alpha = 0;
			cover2.alpha = 0;
			cover3.alpha = 0;
			cover4.alpha = 0;
			coverlock.alpha = 0;
			if (FlxG.save.data.beatweek)
				{
					for (i in 0...3)
						{
							lockarray.members[i].alpha = 0;
						}
				}
			if (FlxG.save.data.all80)
				{
					locka.alpha = 0;
				}
			if (!FlxG.save.data.beatweek)
				{
					backgroundArray.members[0].alpha = 1;
					backgroundArray.members[1].alpha = 0;
					for (i in 0...3)
						{
							lockarray.members[i].alpha = 0.7;
						}
					locka.alpha = 0.7;
				}
			switch (curSelected)
			{
				case 0:
					if (FlxG.save.data.beatweek)
						{
							funnytween3 = FlxTween.tween(backgroundArray.members[0], {alpha: 1}, 0.5, {ease: FlxEase.cubeOut,onComplete: function(twn:FlxTween) {
								funnytween3 = null;
							}
						});
							funnytween4 = FlxTween.tween(backgroundArray.members[1], {alpha: 0}, 0.5, {ease: FlxEase.cubeOut,onComplete: function(twn:FlxTween) {
								funnytween4 = null;
							}
						});
							changeinst();
						}
					cover1.alpha = 1;
					if (!FlxG.save.data.beatweek)
						{
							cover1.alpha = 0;
							coverlock.alpha = 1;
							lockarray.members[0].alpha = 1;
						}
				case 1:
					if (FlxG.save.data.beatweek)
						{
							funnytween3 = FlxTween.tween(backgroundArray.members[0], {alpha: 1}, 0.5, {ease: FlxEase.cubeOut,onComplete: function(twn:FlxTween) {
								funnytween3 = null;
							}
						});
							funnytween4 = FlxTween.tween(backgroundArray.members[1], {alpha: 0}, 0.5, {ease: FlxEase.cubeOut,onComplete: function(twn:FlxTween) {
								funnytween4 = null;
							}
						});
							changeinst();
						}
					cover2.alpha = 1;
					if (!FlxG.save.data.beatweek)
						{
							cover2.alpha = 0;
							coverlock.alpha = 1;
							lockarray.members[1].alpha = 1;
						}
				case 2:
					cover3.alpha = 1;
					if (FlxG.save.data.beatweek)
						{
							funnytween3 = FlxTween.tween(backgroundArray.members[0], {alpha: 0}, 0.5, {ease: FlxEase.cubeOut,onComplete: function(twn:FlxTween) {
								funnytween3 = null;
							}
						});
							funnytween4 = FlxTween.tween(backgroundArray.members[1], {alpha: 1}, 0.5, {ease: FlxEase.cubeOut,onComplete: function(twn:FlxTween) {
								funnytween4 = null;
							}
						});
							changeinst();
						}
					if (!FlxG.save.data.beatweek)
						{
							cover3.alpha = 0;
							coverlock.alpha = 1;
							lockarray.members[2].alpha = 1;
						}
				case 3:
					if (FlxG.save.data.beatweek)
						{
							funnytween3 = FlxTween.tween(backgroundArray.members[0], {alpha: 0}, 0.5, {ease: FlxEase.cubeOut,onComplete: function(twn:FlxTween) {
								funnytween3 = null;
							}
						});
							funnytween4 = FlxTween.tween(backgroundArray.members[1], {alpha: 1}, 0.5, {ease: FlxEase.cubeOut,onComplete: function(twn:FlxTween) {
								funnytween4 = null;
							}
						});
						}
					if (FlxG.save.data.all80)
						{
							changeinst();
						}
					cover4.alpha = 1;
					if (!FlxG.save.data.all80)
						{
							cover4.alpha = 0;
							coverlock.alpha = 1;
							locka.alpha = 1;
						}
			}
		}

		function selectsong()
			{
				var songLowercase:String = Paths.formatToSongPath(songs[curSelected].songName);
				var poop:String = Highscore.formatSong(songLowercase, curDifficulty);
				#if MODS_ALLOWED
				if(!sys.FileSystem.exists(Paths.modsJson(songLowercase + '/' + poop)) && !sys.FileSystem.exists(Paths.json(songLowercase + '/' + poop))) {
				#else
				if(!OpenFlAssets.exists(Paths.json(songLowercase + '/' + poop))) {
				#end
					poop = songLowercase;
					curDifficulty = 1;
					trace('Couldnt find file');
				}
				trace(poop);
	
				PlayState.SONG = Song.loadFromJson(poop, songLowercase);
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = curDifficulty;
	
				PlayState.storyWeek = songs[curSelected].week;
				trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
				LoadingState.loadAndSwitchState(new PlayState());
	
				FlxG.sound.music.volume = 0;
						
				destroyFreeplayVocals();
			}
		function changeinst()
			{
				destroyFreeplayVocals();
				Paths.currentModDirectory = songs[curSelected].folder;
				var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);
				PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
				FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 0.7);
				instPlaying = curSelected;
			}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var color:Int = -7179779;
	public var folder:String = "";

	public function new(song:String, week:Int, songCharacter:String, color:Int)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.color = color;
		this.folder = Paths.currentModDirectory;
		if(this.folder == null) this.folder = '';
	}
}
