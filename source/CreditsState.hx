package;

import Controls.KeyboardScheme;
import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.utils.Assets;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = 0;

	var bg:FlxSprite;
	var upthing:FlxSprite;
	var downthing:FlxSprite;

	var x:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	var credits:FlxTypedGroup<Credit>;
	var canmove:Bool = false;
	var cSprite:FlxSprite;

	override function create()
	{
		bg = new FlxSprite().loadGraphic(Paths.image('credits/creditbg'));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		FlxG.camera.zoom = 1.2;
		FlxTween.tween(FlxG.camera, {zoom: 1}, 0.8);

		upthing = new FlxSprite(0,-720).loadGraphic(Paths.image('credits/upperbarrier'));
		upthing.antialiasing = true;
		add(upthing);

		FlxTween.tween(upthing, {y: 0}, 0.8, {
			ease: FlxEase.quadOut,
			startDelay: 0.2,
		});

		downthing = new FlxSprite(0,720).loadGraphic(Paths.image('credits/lowerbarrier'));
		downthing.antialiasing = true;
		add(downthing);

		FlxTween.tween(downthing, {y: 0}, 0.8, {
			ease: FlxEase.quadOut,
			startDelay: 0.2,
		});

		cSprite = new FlxSprite(0,-100);
		cSprite.frames = Paths.getSparrowAtlas('menus/main/menu_credits');
		cSprite.animation.addByPrefix('idle', "credits white", 24);
		cSprite.animation.play('idle');
		cSprite.screenCenter(X);
		cSprite.setGraphicSize(Std.int(cSprite.width * 2/3));
		add(cSprite);

		FlxTween.tween(cSprite, {y: 10}, 0.8, {
			ease: FlxEase.quadOut,
			startDelay: 0.2,
		});

		x = new FlxSprite(1280 - 84,10).loadGraphic(Paths.image('credits/x'));
		x.updateHitbox();
		x.scale.set(0.8,0.8);
		x.alpha = 0;
		x.antialiasing = true;
		add(x);

		FlxTween.tween(x, {alpha: 1}, 0.8, {
			ease: FlxEase.quadOut,
			startDelay: 0.6,
		});


		credits = new FlxTypedGroup<Credit>();
		add(credits);

		for (i in 0...24) {
			var iconthingy:Credit = new Credit();
			switch (i) {
				case 0:
					iconthingy = new Credit(80, 138, 'Ardolf', 'https://linktr.ee/ardolf',0.7,0.7);
				case 1:
					iconthingy = new Credit(80, 260, 'Clarre', 'https://twitter.com/Clarrenight',0.7,0.7);
				case 2:
					iconthingy = new Credit(80, 368, 'Eyes', 'https://twitter.com/DingoDoggo2',0.7,0.7);
				case 3:
					iconthingy = new Credit(80, 483, 'Borb', 'https://twitter.com/OneBorb',0.7,0.7);
				case 4:
					iconthingy = new Credit(410, 138, 'scorch', 'https://twitter.com/ScorchVx',0.7,0.7);
				case 5:
					iconthingy = new Credit(410, 250, 'Obliv', 'https://www.instagram.com/obliviondowning/',0.7,0.7);
				case 6:
					iconthingy = new Credit(410, 358, 'racoon', 'https://twitter.com/MaiRaccooN_',0.7,0.7);
				case 7:
					iconthingy = new Credit(410, 463, 'direlinq', 'https://mobile.twitter.com/Direlinqqed',0.7,0.7);
				case 8:
					iconthingy = new Credit(770, 138, 'unii', 'https://twitter.com/uniianimates',0.7,0.7);
				case 9:
					iconthingy = new Credit(770, 250, 'vanilla', 'https://twitter.com/OhSoVanilla64',0.7,0.7);
				case 10:
					iconthingy = new Credit(770, 358, 'vlusky', 'https://linktr.ee/VluskyHusky',0.7,0.7);
				case 11:
					iconthingy = new Credit(785, 473, 'cyrus', 'https://twitter.com/CyrusFox11',0.7,0.7);
				case 12:
					iconthingy = new Credit(85, 138, 'Avery', 'https://twitter.com/averyavary?t=bMH638T4Z74VQjK6bT1m3A&s=09',0.7,0.7);
				case 13:
					iconthingy = new Credit(85, 250, 'JRF', 'https://twitter.com/superjrf',0.7,0.7);
				case 14:
					iconthingy = new Credit(85, 358, 'maya', 'https://twitter.com/vMayaa_',0.7,0.7);
				case 16:
					iconthingy = new Credit(60, 460, 'kayn', 'https://twitter.com/kayndeez?t=PYy7Qy1GaFv39Qd4aGqSiw&s=09',0.7,0.7);
				case 17:
					iconthingy = new Credit(445, 138, 'cougar', 'https://twitter.com/cougarmacdowal1?lang=en',0.7,0.7);
				case 18:
					iconthingy = new Credit(465, 240, 'skie', 'https://twitter.com/skieonsta',0.7,0.7);
				case 19:
					iconthingy = new Credit(465, 348, 'Cerb', 'https://www.youtube.com/channel/UCgfJjMiNGlI7uZu1cVag5NA',0.7,0.7);
				case 20:
					iconthingy = new Credit(485, 460, 'ash', 'https://twitter.com/ash__i_guess_',0.7,0.7);
				case 21:
					iconthingy = new Credit(825, 138, 'Shadowfi', 'https://twitter.com/Shadowfi1385',0.7,0.7);
				case 22:
					iconthingy = new Credit(825,  240, 'jyro', 'https://twitter.com/jyrocopter_',0.7,0.7);
				case 23:
					iconthingy = new Credit(815, 138, 'specialthanks', '',1,1);
					iconthingy.screenCenter();
					iconthingy.x += 1280 * 2;
			}
			iconthingy.antialiasing = true;
			credits.add(iconthingy);
		}

		
		leftArrow = new FlxSprite(40 - 1280).loadGraphic(Paths.image('credits/leftbutton'));
		leftArrow.updateHitbox();
		leftArrow.antialiasing = true;
		add(leftArrow);

		rightArrow = new FlxSprite(1163 + 1280).loadGraphic(Paths.image('credits/rightbutton'));
		rightArrow.updateHitbox();
		rightArrow.antialiasing = true;
		add(rightArrow);
		rightArrow.screenCenter(Y);
		leftArrow.screenCenter(Y);

		FlxTween.tween(leftArrow, {x: 20},1, {
			ease: FlxEase.quadOut,
			startDelay: 0.4,
		});

		FlxTween.tween(rightArrow, {x: 1183}, 1, {
			ease: FlxEase.quadOut,
			startDelay: 0.4,
		});



		for (i in 12...23) 
		{
			credits.members[i].x += 1280;
		}
		for (i in 0...12) 
		{
			credits.members[i].x += 1280;
		}

		new FlxTimer().start(0.6, function(tmr:FlxTimer)
			{
				for (i in 0...4) {
					FlxTween.tween(credits.members[i], {x: credits.members[i].x - FlxG.width}, 1, {
						ease: FlxEase.cubeOut,
						startDelay: 0.2,
					});
				}
		
				for (i in 4...8) {
					FlxTween.tween(credits.members[i], {x: credits.members[i].x - FlxG.width}, 1, {
						ease: FlxEase.cubeOut,
						startDelay: 0.6,
					});
				}
				for (i in 8...12) {
					FlxTween.tween(credits.members[i], {x: credits.members[i].x - FlxG.width}, 1, {
						ease: FlxEase.cubeOut,
						startDelay: 1,
						onComplete: function(twn:FlxTween) {
							canmove = true;
							FlxG.mouse.visible = true;
						}
					});
				}
			});

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (canmove)
			{
				if (FlxG.mouse.overlaps(leftArrow))
					leftArrow.scale.set(1.05,1.05);
				else
					leftArrow.scale.set(1,1);
		
				if (FlxG.mouse.overlaps(rightArrow))
					rightArrow.scale.set(1.05,1.05);
				else
					rightArrow.scale.set(1,1);
		
				if (FlxG.mouse.overlaps(x))
					x.scale.set(0.85,0.85);
				else
					x.scale.set(0.8,0.8);
		
				if (FlxG.mouse.justPressed)
					{
						if (FlxG.mouse.overlaps(x))
							leave();

						if (FlxG.mouse.overlaps(leftArrow))
						{
							if (curSelected != 0)
								{
									leftArrow.x -= 10;
									FlxTween.tween(leftArrow, {x: leftArrow.x + 10}, 0.4, {
										ease: FlxEase.expoOut,
									});
									changeSelection(-1);
									canmove =false;
								}
						}
						if (FlxG.mouse.overlaps(rightArrow))
						{
							if (curSelected != 2)
								{
									canmove =false;
									changeSelection(1);
									rightArrow.x += 10;
									FlxTween.tween(rightArrow, {x: rightArrow.x - 10}, 0.4, {
										ease: FlxEase.expoOut,
									});
								}
						}
					}
		
				if (controls.BACK)
					leave();
		
				for (i in credits) {
					if (FlxG.mouse.overlaps(i) && !FlxG.mouse.overlaps(rightArrow) && !FlxG.mouse.overlaps(leftArrow) && i.name != 'specialthanks') {
								i.scale.set(0.75, 0.75);
								if (FlxG.mouse.justPressed) {
									#if linux
									Sys.command('/usr/bin/xdg-open', [i.link, "&"]);
									#else
									FlxG.openURL(i.link);
									#end
								}
							}
							else
								{
									if (i.name == 'specialthanks')
										i.scale.set(1,1);
									else
										i.scale.set(0.7,0.7);
								}
					}
		
				if (controls.UI_LEFT_P)
					{
						if (curSelected != 0)
							{
								leftArrow.x -= 10;
								FlxTween.tween(leftArrow, {x: leftArrow.x + 10}, 0.4, {
									ease: FlxEase.expoOut,
								});
								changeSelection(-1);
								canmove =false;
							}
					}
		
					if (controls.UI_RIGHT_P)
					{
						if (curSelected != 2)
							{
								canmove =false;
								changeSelection(1);
								rightArrow.x += 10;
								FlxTween.tween(rightArrow, {x: rightArrow.x - 10}, 0.4, {
									ease: FlxEase.expoOut,
								});
							}
					}
			}

	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected == 3)
			curSelected = 2;
		if (curSelected == -1)
			curSelected = 0;

		if (change == -1)
			{
				credits.forEach(function(spr:FlxSprite)
					{
						FlxTween.tween(spr, {x: spr.x + 1280}, 1, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween) {
								canmove = true;
							}
						});
					});
			}
		else
			{
				credits.forEach(function(spr:FlxSprite)
					{
						FlxTween.tween(spr, {x: spr.x - 1280}, 1, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween) {
								canmove = true;
							}
						});
					});
			}

	}

	function leave() {
		FlxG.sound.play(Paths.sound('cancelMenu'));
		FlxTween.tween(cSprite, {y: cSprite.y - 300}, 1, {
			ease: FlxEase.quadOut,
			startDelay: 0.1,
		});
		credits.forEach(function(spr:FlxSprite)
			{
				FlxTween.tween(spr, {y: spr.y - 1280}, 1.4, {
					ease: FlxEase.quadOut,
				});
			});
			FlxTween.tween(leftArrow, {x: 20 - 1280},1.4, {
				ease: FlxEase.quadOut,
			});
	
			FlxTween.tween(rightArrow, {x: 1183 + 1280}, 1.4, {
				ease: FlxEase.quadOut,
			});
			FlxTween.tween(x, {y: x.y - 1280}, 1.4, {
				ease: FlxEase.quadOut,
			});

			FlxTween.tween(upthing, {y: -1280}, 1.4, {
				ease: FlxEase.quadOut,
			});
	
			FlxTween.tween(downthing, {y: 1280}, 1.4, {
				ease: FlxEase.quadOut,
			});
			new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxG.switchState(new MainMenuState());
				});

			FlxTween.tween(FlxG.camera, {zoom: 1.8}, 1.2);
			FlxTween.tween(bg, {alpha: 0}, 0.9, {
				ease: FlxEase.quadOut,
			});
	}
}
