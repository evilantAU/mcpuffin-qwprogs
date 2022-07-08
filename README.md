MCPUFFIN 
========

Binds
-----
replace x with desired key. ie. bind g gren1

Misc
* `bind x special`      	- uses the classes special skill (all classes have a special skill ie. fiend leap)
* `bind x reload`       	- reloads current weapon (depending on gamemode)
* `bind x reloadnext`    	- attempts to reload current weapon, if full will attempt to reload any weapon needing a reload
* `bind x throwflag`		- throws the flag in sacrifice mode
* `bind x dropflag`			- throws the flag in sacrifice mode
* `bind x dropitems`		- throws the flag in sacrifice mode

Change Weapon & Menu Input
* `bind x weapnext`    		- cycles UP through weapon slots
* `bind x weapprev`    		- cycles DOWN through weapon slots
* `bind x weaplast`    		- changes to last held weapon

* `bind x slot1`			- changes to weapon in slot1 also option 1 input for menus
* `bind x slot2`			- changes to weapon in slot2 also option 2 input for menus
* `bind x slot3`			- changes to weapon in slot3 also option 3 input for menus
* `bind x slot4`			- changes to weapon in slot4 also option 4 input for menus

* `bind x "impulse 1"`		- changes to weapon in slot1 also option 1 input for menus
* `bind x "impulse 2"`		- changes to weapon in slot2 also option 2 input for menus
* `bind x "impulse 3"`		- changes to weapon in slot3 also option 3 input for menus
* `bind x "impulse 4"`		- changes to weapon in slot4 also option 4 input for menus
* `bind x "impulse 5"`		- option 5 input for menus
* `bind x "impulse 6"`		- option 6 input for menus
* `bind x "impulse 7"`		- option 7 input for menus
* `bind x "impulse 8"`		- option 8 input for menus
* `bind x "impulse 9"`		- option 9 input for menus
* `bind x "impulse 10"`		- option 0 input for menus

Quickshots
* `bind x +slot1`			- switches to and fires the slot1 weapon while held, returns to previous weapon on release
* `bind x +slot2`			- switches to and fires the slot2 weapon while held, returns to previous weapon on release
* `bind x +slot3`			- switches to and fires the slot3 weapon while held, returns to previous weapon on release
* `bind x +slot4`			- switches to and fires the slot4 weapon while held, returns to previous weapon on release

Two Tap Grenade
* `bind x grenade`        	- first keypress primes a grenade, second keypress throws grenade
* `bind x gren1`        	- first keypress primes a grenade, second keypress throws grenade
* `bind x gren2`        	- first keypress primes a grenade, second keypress throws grenade

Press & Hold Grenade (for savages like loki)
* `bind x +gren`       		- grenade starts to prime on keypress, throws on release
* `bind x +gren1`       	- grenade starts to prime on keypress, throws on release
* `bind x +gren2`       	- grenade starts to prime on keypress, throws on release

Two Key Grenade
* `bind x primegren`    	- primes a grenade
* `bind x primeone`			- primes a grenade
* `bind x primetwo`    		- primes a grenade
* `bind x throwgren`    	- throws a primed grenade


Console Commands
----------------
* `ready`			- flags you as ready to start match during prematch

* `changeteam`		- brings up change team menu
* `joinblue`		- joins blue team (if possible)
* `goblue`			- joins blue team (if possible)
* `joinred`			- joins red team (if possible)
* `gored`			- joins red team (if possible)
* `swapteam`		- joins opposing team (if possible)
* `goloser`			- toggle on/off to place yourself on losing team each respawn (depending on numbers/score/gamemode)
* `joinloser`		- toggle on/off to place yourself on losing team each respawn (depending on numbers/score/gamemode)

* `changeclass`		- brings up the change class/skill menu
* `randomclass`		- you will respawn as a random class/skill
* `recon`			- you will respawn as the recon class or with dash skill (depending on gamemode)
* `scout`			- as above
* `assassin`		- you will respawn as the assassin class or with cloak skill (depending on gamemode)
* `sniper`			- as above
* `fighter`			- you will respawn as the fighter class or with harpoon skill (depending on gamemode)
* `soldier`			- as above
* `bomber`			- you will respawn as the bomber class or with detonate skill (depending on gamemode)
* `demoman`			- as above
* `doctor`			- you will respawn as the doctor class or with teleball skill (depending on gamemode)
* `medic`			- as above
* `minigunner`		- you will respawn as the minigunner class or with leap skill (depending on gamemode)
* `hwguy`			- as above
* `arsonist`		- you will respawn as the arsonist class or with airblast skill (depending on gamemode)
* `pyro`			- as above
* `technician`		- you will respawn as the technician class (depending on gamemode)
* `engineer`		- as above

SetInfos
--------
probably best to put in a cfg file for long term use

* `setinfo grentimer <number>`		- [default 1] if set to 0 no grentimer sound is played. setting to 1 will use \fortress\sound\mcpuffin_b1\grentimers\mcp_grentimer1.wav, 2 will use \fortress\sound\mcpuffin_b1\grentimers\mcp_grentimer2.wav etc etc
* `setinfo flipslots 1`				- [default 0] reverses the order of slot1-4, slot1 becomes melee, slot2 tertiary weap, slot3 secondary weap, slot4 primary weap
* `setinfo sb <number>`				- [default 20] lines from top of screen before things like id/grentimerbar/objective text is drawn
* `setinfo autoexec 0`				- [default 1] turns off auto execing mcpuffin.cfg
* `setinfo ec 0`					- [default 1] turns off auto execing class confings on spawn: recon.cfg, assassin.cfg, fighter.cfg, bomber.cfg, doctor.cfg, minigunner.cfg, arsonist.cfg, technician.cfg, drone.cfg, fiend.cfg, human.cfg, hunter.cfg, babyfiend.cfg, mugger.cfg
* `setinfo et 0`					- [default 1] turns off auto execing team confings on team change: teamblue.cfg, teamred.cfg, teamffa.cfg, teamnone.cfg
* `setinfo ai 0`					- [default 1] doesnt show targets name when aiming at another player
* `setinfo vgt 0`					- [default 1] turns off the awesome and amazing visual gren timer bar
* `setinfo grentimerdelay <number>`	- [default 0] add a delay before grentimer sound effect is played
* `setinfo hitsound <number>`		- [default 2] 0 disables all hit beep sounds when damaging other players, 1 only plays if damaging enemy players, 2 plays when damaging enemy and friendly players
* `setinfo killsound <number>`		- [default 2] 0 disables all kill sound effects, 1 only plays when killing enemy players, 2 plays when killing enemy/team/self
* `setinfo killstreaks 0`			- [default 1] turns off the announcer saying things like ultrakill megakill etc
* `setinfo scoreticksound 0`		- [default 1] turns off score tick beep sound effect in sacrifice/5cp gamemode
* `setinfo scoreticktext 0`			- [default 1] turns off score tick text in sacrifice
* `setinfo nohitnumbers 1`			- [default 0] turns off damage hit numbers above players heads

Rcon Stuff
-----------
most of these commands assume you have rcon_password set

* `rcon_password <password>`				- place the rcon password to server here
* `adminforcestart`							- forces the match to start
* `adminforcevote`							- ends the match and brings up mode/map vote menu
* `adminchangemodesac`						- switches to sacrfice gamemode and restarts map
* `adminchangemode5cp`						- switches to 5cp gamemode and restarts map
* `adminchangemodefiend`					- switches to fiend gamemode and restarts map
* `adminchangemodebaby`						- switches to babyfiend gamemode and restarts map
* `adminchangemodecoinsteam`				- switches to coinsteam gamemode and restarts map
* `adminchangemodecoinsffa`					- switches to coinsffa gamemode and restarts map
* `rcon localinfo victorytotal <number>`	- change the score needed to win (no restart required/excludes 5cp)
