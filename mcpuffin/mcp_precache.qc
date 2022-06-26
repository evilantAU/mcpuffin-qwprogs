void mcp_PreCache() =
{
	///////////////////////////////////////////////////////////////////////////////////////////////
	//ID1 SOUNDS
	
	
	//AMBIENCE
	#define SND_BUZZ1			"ambience/buzz1.wav"
	#define SND_COMP1			"ambience/comp1.wav"
	#define SND_DRIP1			"ambience/drip1.wav"
	#define SND_DRONE6			"ambience/drone6.wav"
	#define SND_FIRE1			"ambience/fire1.wav"
	#define SND_FL_HUM1			"ambience/fl_hum1.wav"
	#define SND_HUM1			"ambience/hum1.wav"
	#define SND_SUCK1			"ambience/suck1.wav"
	#define SND_SWAMP1			"ambience/swamp1.wav"
	#define SND_SWAMP2			"ambience/swamp2.wav"
	#define SND_THUNDER1			"ambience/thunder1.wav"
	#define SND_AWATER1			"ambience/water1.wav"
	#define SND_WIND2			"ambience/wind2.wav"
	#define SND_WINDFLY			"ambience/windfly.wav"
	//precache_sound(SND_BUZZ1);
	//precache_sound(SND_COMP1);
	//precache_sound(SND_DRIP1);
	//precache_sound(SND_DRONE6);
	//precache_sound(SND_FIRE1);
	//precache_sound(SND_FL_HUM1);
	//precache_sound(SND_HUM1);
	//precache_sound(SND_SUCK1);
	//precache_sound(SND_SWAMP1);
	//precache_sound(SND_SWAMP2);
	//precache_sound(SND_THUNDER1);
	//precache_sound(SND_AWATER1);
	//precache_sound(SND_WIND2);
	//precache_sound(SND_WINDFLY);
	
	
	//BUTTONS
	#define SND_AIRBUT1			"buttons/airbut1.wav"
	#define SND_SWITCH02			"buttons/switch02.wav"
	#define SND_SWITCH04			"buttons/switch04.wav"
	#define SND_SWITCH21			"buttons/switch21.wav"
	precache_sound(SND_AIRBUT1);
	precache_sound(SND_SWITCH02);
	precache_sound(SND_SWITCH04);
	precache_sound(SND_SWITCH21);
	
	//DEMON
	#define SND_DDEATH			"demon/ddeath.wav"
	#define SND_DHIT2			"demon/dhit2.wav"
	#define SND_DJUMP			"demon/djump.wav"
	#define SND_DLAND2			"demon/dland2.wav"
	#define SND_DPAIN1			"demon/dpain1.wav"
	#define SND_DIDLE1			"demon/idle1.wav"
	#define SND_DSIGHT2			"demon/sight2.wav"
	precache_sound(SND_DDEATH);
	precache_sound(SND_DHIT2);
	precache_sound(SND_DJUMP);
	precache_sound(SND_DLAND2);
	precache_sound(SND_DPAIN1);
	precache_sound(SND_DIDLE1);
	precache_sound(SND_DSIGHT2);
	
	
	//DOORS
	#define SND_AIRDOOR1			"doors/airdoor1.wav"
	#define SND_AIRDOOR2			"doors/airdoor2.wav"
	#define SND_BASESEC1			"doors/basesec1.wav"
	#define SND_BASESEC2			"doors/basesec2.wav"
	#define SND_BASETRY			"doors/basetry.wav"
	#define SND_BASEUSE			"doors/baseuse.wav"
	#define SND_DDOOR1			"doors/ddoor1.wav"
	#define SND_DDOOR2			"doors/ddoor2.wav"
	#define SND_DOORMV1			"doors/doormv1.wav"
	#define SND_DRCLOS4			"doors/drclos4.wav"
	#define SND_HYDRO1			"doors/hydro1.wav"
	#define SND_HYDRO2			"doors/hydro2.wav"
	#define SND_LATCH2			"doors/latch2.wav"
	#define SND_MEDTRY			"doors/medtry.wav"
	#define SND_MEDUSE			"doors/meduse.wav"
	#define SND_RUNETRY			"doors/runetry.wav"
	#define SND_RUNEUSE			"doors/runeuse.wav"
	#define SND_STNDR1			"doors/stndr1.wav"
	#define SND_STNDR2			"doors/stndr2.wav"
	#define SND_WINCH2			"doors/winch2.wav"
	precache_sound(SND_AIRDOOR1);
	precache_sound(SND_AIRDOOR2);
	precache_sound(SND_BASESEC1);
	precache_sound(SND_BASESEC2);
	precache_sound(SND_BASETRY);
	precache_sound(SND_BASEUSE);
	precache_sound(SND_DDOOR1);
	precache_sound(SND_DDOOR2);
	precache_sound(SND_DOORMV1);
	precache_sound(SND_DRCLOS4);
	precache_sound(SND_HYDRO1);
	precache_sound(SND_HYDRO2);
	precache_sound(SND_LATCH2);
	precache_sound(SND_MEDTRY);
	precache_sound(SND_MEDUSE);
	precache_sound(SND_RUNETRY);
	precache_sound(SND_RUNEUSE);
	precache_sound(SND_STNDR1);
	precache_sound(SND_STNDR2);
	precache_sound(SND_WINCH2);
	
	//ITEMS
	#define SND_ARMOR1			"items/armor1.wav"
	#define SND_DAMAGE			"items/damage.wav"
	#define SND_DAMAGE2			"items/damage2.wav"
	#define SND_DAMAGE3			"items/damage3.wav"
	#define SND_HEALTH1			"items/health1.wav"
	#define SND_INV1			"items/inv1.wav"
	#define SND_INV2			"items/inv2.wav"
	#define SND_INV3			"items/inv3.wav"
	#define SND_ITEMBK2			"items/itembk2.wav"
	#define SND_PROTECT			"items/protect.wav"
	#define SND_PROTECT2			"items/protect2.wav"
	#define SND_PROTECT3			"items/protect3.wav"
	#define SND_R_ITEM1			"items/r_item1.wav"
	#define SND_R_ITEM2			"items/r_item2.wav"
	#define SND_SUIT			"items/suit.wav"
	#define SND_SUIT2			"items/suit2.wav"
	//precache_sound(SND_ARMOR1);
	//precache_sound(SND_DAMAGE);
	//precache_sound(SND_DAMAGE2);
	//precache_sound(SND_DAMAGE3);
	//precache_sound(SND_HEALTH1);
	//precache_sound(SND_INV1);
	precache_sound(SND_INV2);
	precache_sound(SND_INV3);
	//precache_sound(SND_ITEMBK2);
	precache_sound(SND_PROTECT);
	precache_sound(SND_PROTECT2);
	precache_sound(SND_PROTECT3);
	precache_sound(SND_R_ITEM1);
	precache_sound(SND_R_ITEM2);
	//precache_sound(SND_SUIT);
	//precache_sound(SND_SUIT2);
	
	//MISC
	#define SND_BASEKEY			"misc/basekey.wav"
	#define SND_H2OHIT1			"misc/h2ohit1.wav"
	#define SND_MEDKEY			"misc/medkey.wav"
	#define SND_MENU1			"misc/menu1.wav"
	#define SND_MENU2			"misc/menu2.wav"
	#define SND_MENU3			"misc/menu3.wav"
	#define SND_NULL			"misc/null.wav"
	#define SND_OUTWATER			"misc/outwater.wav"
	#define SND_POWER			"misc/power.wav"
	#define SND_R_TELE1			"misc/r_tele1.wav"
	#define SND_R_TELE2			"misc/r_tele2.wav"
	#define SND_R_TELE3			"misc/r_tele3.wav"
	#define SND_R_TELE4			"misc/r_tele4.wav"
	#define SND_R_TELE5			"misc/r_tele5.wav"
	#define SND_RUNEKEY			"misc/runekey.wav"
	#define SND_SECRET			"misc/secret.wav"
	#define SND_TALK			"misc/talk.wav"
	#define SND_TRIGGER1			"misc/trigger1.wav"
	#define SND_WATER1			"misc/water1.wav"
	#define SND_WATER2			"misc/water2.wav"
	precache_sound(SND_BASEKEY);
	precache_sound(SND_H2OHIT1);
	precache_sound(SND_MEDKEY);
	precache_sound(SND_MENU1);
	precache_sound(SND_MENU2);
	precache_sound(SND_MENU3);
	precache_sound(SND_NULL);
	precache_sound(SND_OUTWATER);
	precache_sound(SND_POWER);
	precache_sound(SND_R_TELE1);
	precache_sound(SND_R_TELE2);
	precache_sound(SND_R_TELE3);
	precache_sound(SND_R_TELE4);
	precache_sound(SND_R_TELE5);
	precache_sound(SND_RUNEKEY);
	precache_sound(SND_SECRET);
	precache_sound(SND_TALK);
	precache_sound(SND_TRIGGER1);
	precache_sound(SND_WATER1);
	precache_sound(SND_WATER2);
	
	//PLATS
	#define SND_MEDPLAT1			"plats/medplat1.wav"
	#define SND_MEDPLAT2			"plats/medplat2.wav"
	#define SND_PLAT1			"plats/plat1.wav"
	#define SND_PLAT2			"plats/plat2.wav"
	#define SND_TRAIN1			"plats/train1.wav"
	#define SND_TRAIN2			"plats/train2.wav"
	precache_sound(SND_MEDPLAT1);
	precache_sound(SND_MEDPLAT2);
	precache_sound(SND_PLAT1);
	precache_sound(SND_PLAT2);
	precache_sound(SND_TRAIN1);
	precache_sound(SND_TRAIN2);
	
	//PLAYER SOUNDS
	#define SND_AXHIT1			"player/axhit1.wav"
	#define SND_AXHIT2			"player/axhit2.wav"
	#define SND_DEATH1			"player/death1.wav"
	#define SND_DEATH2			"player/death2.wav"
	#define SND_DEATH3			"player/death3.wav"
	#define SND_DEATH4			"player/death4.wav"
	#define SND_DEATH5			"player/death5.wav"
	#define SND_DROWN1			"player/drown1.wav"
	#define SND_DROWN2			"player/drown2.wav"
	#define SND_GASP1			"player/gasp1.wav"
	#define SND_GASP2			"player/gasp2.wav"
	#define SND_GIB				"player/gib.wav"
	#define SND_H2ODEATH			"player/h2odeath.wav"
	#define SND_H2OJUMP			"player/h2ojump.wav"
	#define SND_INH2O			"player/inh2o.wav"
	#define SND_INLAVA			"player/inlava.wav"
	#define SND_LAND			"player/land.wav"
	#define SND_LAND2			"player/land2.wav"	
	#define SND_LBURN1			"player/lburn1.wav"
	#define SND_LBURN2			"player/lburn2.wav"
	#define SND_PAIN1			"player/pain1.wav"
	#define SND_PAIN2			"player/pain2.wav"
	#define SND_PAIN3			"player/pain3.wav"
	#define SND_PAIN4			"player/pain4.wav"
	#define SND_PAIN5			"player/pain5.wav"
	#define SND_PAIN6			"player/pain6.wav"
	#define SND_PLYRJMP8			"player/plyrjmp8.wav"
	#define SND_SLIMBRN2			"player/slimbrn2.wav"
	#define SND_TELEDTH1			"player/teledth1.wav"
	#define SND_TORNOFF2			"player/tornoff2.wav"
	#define SND_UDEATH			"player/udeath.wav"
	precache_sound(SND_AXHIT1);
	precache_sound(SND_AXHIT2);
	precache_sound(SND_DEATH1);
	precache_sound(SND_DEATH2);
	precache_sound(SND_DEATH3);
	precache_sound(SND_DEATH4);
	precache_sound(SND_DEATH5);
	precache_sound(SND_DROWN1);
	precache_sound(SND_DROWN2);
	precache_sound(SND_GASP1);
	precache_sound(SND_GASP2);
	precache_sound(SND_GIB);
	precache_sound(SND_H2ODEATH);
	precache_sound(SND_H2OJUMP);
	precache_sound(SND_INH2O);
	precache_sound(SND_INLAVA);
	precache_sound(SND_LAND);
	precache_sound(SND_LAND2);
	precache_sound(SND_LBURN1);
	precache_sound(SND_LBURN2);
	precache_sound(SND_PAIN1);
	precache_sound(SND_PAIN2);
	precache_sound(SND_PAIN3);
	precache_sound(SND_PAIN4);
	precache_sound(SND_PAIN5);
	precache_sound(SND_PAIN6);
	precache_sound(SND_PLYRJMP8);
	precache_sound(SND_SLIMBRN2);
	precache_sound(SND_TELEDTH1);
	precache_sound(SND_TORNOFF2);
	precache_sound(SND_UDEATH);
	
	#define SND_FIENDJUMP			"mcpuffin_b1/fiendjump.wav"
	precache_sound(SND_FIENDJUMP);
	
	//SHAMBLER
	#define SND_SHMBLR_MELEE1		"shambler/melee1.wav"
	#define SND_SHMBLR_MELEE2		"shambler/melee2.wav"
	#define SND_SHMBLR_SATTCK1		"shambler/sattck1.wav"
	#define SND_SHMBLR_SBOOM		"shambler/sboom.wav"
	#define SND_SHMBLR_SDEATH		"shambler/sdeath.wav"
	#define SND_SHMBLR_SHURT2		"shambler/shurt2.wav"
	#define SND_SHMBLR_SIDLE		"shambler/sidle.wav"
	#define SND_SHMBLR_SMACK		"shambler/smack.wav"
	#define SND_SHMBLR_SSIGHT		"shambler/ssight.wav"
	//precache_sound(SND_SHMBLR_MELEE1);
	//precache_sound(SND_SHMBLR_MELEE2);
	//precache_sound(SND_SHMBLR_SATTCK1);
	//precache_sound(SND_SHMBLR_SBOOM);
	//precache_sound(SND_SHMBLR_SDEATH);
	//precache_sound(SND_SHMBLR_SHURT2);
	//precache_sound(SND_SHMBLR_SIDLE);
	//precache_sound(SND_SHMBLR_SMACK);
	//precache_sound(SND_SHMBLR_SSIGHT);
	
	//WEAPONS
	#define	SND_AX1				"weapons/ax1.wav"
	#define SND_BOUNCE			"weapons/bounce.wav"
	#define SND_GRENADE			"weapons/grenade.wav"
	#define SND_GUNCOCK			"weapons/guncock.wav"
	#define SND_LHIT			"weapons/lhit.wav"
	#define SND_LOCK4			"weapons/lock4.wav"
	#define SND_LSTART			"weapons/lstart.wav"
	#define SND_PKUP			"weapons/pkup.wav"
	#define SND_R_EXP3			"weapons/r_exp3.wav"
	#define SND_RIC1			"weapons/ric1.wav"
	#define SND_RIC2			"weapons/ric2.wav"
	#define SND_RIC3			"Weapons/ric3.wav"
	#define SND_ROCKET1I			"weapons/rocket1i.wav"
	#define SND_SGUN1			"weapons/sgun1.wav"
	#define SND_SHOTGN2			"weapons/shotgn2.wav"
	#define SND_SPIKE2			"weapons/spike2.wav"
	#define SND_TINK1			"weapons/tink1.wav"
	precache_sound(SND_AX1);
	precache_sound(SND_BOUNCE);
	precache_sound(SND_GRENADE);
	precache_sound(SND_GUNCOCK);
	precache_sound(SND_LHIT);
	precache_sound(SND_LOCK4);
	precache_sound(SND_LSTART);
	precache_sound(SND_PKUP);
	precache_sound(SND_R_EXP3);
	precache_sound(SND_RIC1);
	precache_sound(SND_RIC2);
	precache_sound(SND_RIC3);
	precache_sound(SND_ROCKET1I);
	precache_sound(SND_SGUN1);
	precache_sound(SND_SHOTGN2);
	precache_sound(SND_SPIKE2);
	precache_sound(SND_TINK1);
	
	#define SND_ENFSTOP			"enforcer/enfstop.wav"
	#define SND_Z_HIT			"zombie/z_hit.wav"
	#define SND_Z_MISS			"zombie/z_miss.wav"
	precache_sound(SND_ENFSTOP);
	precache_sound(SND_Z_HIT);
	precache_sound(SND_Z_MISS);
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	#define SND_BABYFIEND_HIT1		"mcpuffin_b1/babyfiend_hit1.wav"
	#define SND_BABYFIEND_DEATH		"mcpuffin_b1/babyfiend_death.wav"
	#define SND_BABYFIEND_HIT2		"mcpuffin_b1/babyfiend_hit2.wav"
	#define SND_BABYFIEND_JUMP		"mcpuffin_b1/babyfiend_jump.wav"
	#define SND_BABYFIEND_LAND		"mcpuffin_b1/babyfiend_land.wav"
	#define SND_BABYFIEND_PAIN		"mcpuffin_b1/babyfiend_pain.wav"
	#define SND_BABYFIEND_IDLE		"mcpuffin_b1/babyfiend_idle.wav"
	#define SND_BABYFIEND_SIGHT		"mcpuffin_b1/babyfiend_sight.wav"
	#define SND_BABYFIEND_FRESHMEAT		"mcpuffin_b1/babyfiend_freshmeat.wav"
	precache_sound(SND_BABYFIEND_FRESHMEAT);
	precache_sound(SND_BABYFIEND_HIT1);
	precache_sound(SND_BABYFIEND_DEATH);
	precache_sound(SND_BABYFIEND_HIT2);
	precache_sound(SND_BABYFIEND_JUMP);
	precache_sound(SND_BABYFIEND_LAND);
	precache_sound(SND_BABYFIEND_PAIN);
	precache_sound(SND_BABYFIEND_IDLE);
	precache_sound(SND_BABYFIEND_SIGHT);
	
	//UI SOUNDS
	#define SND_NOTICE 			"mcpuffin_b1/ui_notice.wav"
	precache_sound(SND_NOTICE);
	#define SND_ERROR			"mcpuffin_b1/ui_error.wav"
	precache_sound(SND_ERROR);
	#define SND_FLAGEVENT			"mcpuffin_b1/flagevent.wav"
	precache_sound(SND_FLAGEVENT);
	#define SND_READY			"mcpuffin_b1/ready.wav"
	#define SND_NOTREADY			"mcpuffin_b1/notready.wav"
	precache_sound(SND_READY);
	precache_sound(SND_NOTREADY);
	#define SND_COINPICKUP			"mcpuffin_b1/coin_pickup.wav"
	#define SND_COINDROP			"mcpuffin_b1/coin_drop.wav"
	#define SND_COINPOP			"mcpuffin_b1/coin_pop.wav"
	precache_sound(SND_COINPOP);
	precache_sound(SND_COINPICKUP);
	precache_sound(SND_COINDROP);
	
	//FLAVOUR SOUNDS
	#define SND_GHOSTBUSTER			"mcpuffin_b1/gbuster.wav"
	#define SND_GOOMBASTOMP			"mcpuffin_b1/goombastomp.wav"
	#define SND_TRANSFORMER			"mcpuffin_b1/transformer.wav"
	precache_sound(SND_GHOSTBUSTER);
	precache_sound(SND_GOOMBASTOMP);
	precache_sound(SND_TRANSFORMER);
	
	#define SND_LOOTGREN			"mcpuffin_b1/lootgren.wav"
	#define SND_LOOTHEALTH			"mcpuffin_b1/loothealth.wav"
	#define SND_LOOTARMOUR			"mcpuffin_b1/lootarmour.wav"
	precache_sound(SND_LOOTGREN);
	precache_sound(SND_LOOTHEALTH);
	precache_sound(SND_LOOTARMOUR);
	
	//WEAPON SHOOT SOUNDS
	#define SND_SHOOTAXE			"weapons/ax1.wav"
	#define SND_SHOOTSHOTGUN		"weapons/guncock.wav"
	#define SND_SHOOTDBLBARREL		"weapons/shotgn2.wav"
	precache_sound(SND_SHOOTAXE);
	precache_sound(SND_SHOOTSHOTGUN);
	precache_sound(SND_SHOOTDBLBARREL);
	
	#define SND_SHOOTSNG			"weapons/spike2.wav"
	#define SND_SHOOTRAILGUN		"mcpuffin_b1/railgun_shoot.wav"
	#define SND_SHOOTRL			"weapons/sgun1.wav"
	#define SND_SHOOTGL			"weapons/grenade.wav"		
	#define SND_SHOOTFLAMER			"mcpuffin_b1/flamer_shoot.wav"
	#define SND_SHOOTLASERGUN		"mcpuffin_b1/lasergun_shoot.wav"
	precache_sound(SND_SHOOTFLAMER);
	precache_sound(SND_SHOOTSNG);
	precache_sound(SND_SHOOTRAILGUN);
	precache_sound(SND_SHOOTRL);
	precache_sound(SND_SHOOTGL);
	precache_sound(SND_SHOOTLASERGUN);
	#define SND_SHOOTMINIGUN		"mcpuffin_b1/minigun_shoot.wav"
	precache_sound(SND_SHOOTMINIGUN);
	#define SND_MINIGUNSPINDOWN		"mcpuffin_b1/minigun_spindown.wav"
	precache_sound(SND_MINIGUNSPINDOWN);
	#define SND_MINIGUNSPINUP		"mcpuffin_b1/minigun_spinup.wav"
	precache_sound(SND_MINIGUNSPINUP);	
	#define SND_MINIGUNSPIN			"mcpuffin_b1/minigun_spin.wav"
	precache_sound(SND_MINIGUNSPIN);
	
	#define SND_SHOOTSHAFT			"weapons/lstart.wav"
	#define SND_SHAFTLOOP			"weapons/lhit.wav"

	precache_sound(SND_SHOOTSHAFT);
	precache_sound(SND_SHAFTLOOP);

	
		
	#define SND_STICKY			"mcpuffin_b1/sticky.wav"
	precache_sound(SND_STICKY);
	
	//RELOAD SOUNDS
	#define SND_RELOADSHELL			"mcpuffin_b1/reload_shell.wav"
	#define SND_RELOADNAIL			"mcpuffin_b1/reload_nail.wav"
	#define SND_RELOADROCKET		"mcpuffin_b1/reload_rocket.wav"
	#define SND_RELOADCELL			"mcpuffin_b1/reload_cell.wav"
	#define SND_RELOADDBLBARREL		"mcpuffin_b1/reload_dblbarrel.wav"
	#define SND_RELOADRAILGUN		"mcpuffin_b1/reload_railgun.wav"
	
	precache_sound(SND_RELOADSHELL);
	precache_sound(SND_RELOADNAIL);
	precache_sound(SND_RELOADDBLBARREL);
	precache_sound(SND_RELOADROCKET);
	precache_sound(SND_RELOADRAILGUN);
	precache_sound(SND_RELOADCELL);

	
	//SPECIAL SOUNDS
	#define SND_DASH			"mcpuffin_b1/dash.wav"
	#define SND_CLOAK			"mcpuffin_b1/cloak.wav"
	#define SND_UNCLOAK			"mcpuffin_b1/uncloak.wav"
	#define SND_HARPOONTHROW		"mcpuffin_b1/harpoon_throw.wav"
	#define SND_HARPOONHITMEAT		"mcpuffin_b1/harpoon_hitmeat.wav"
	#define SND_HARPOONPULL1		"mcpuffin_b1/harpoon_enemy1.wav"
	#define SND_HARPOONPULL2		"mcpuffin_b1/harpoon_enemy2.wav"
	#define SND_TELEBALLSTART		"mcpuffin_b1/teleball_start.wav"
	#define SND_TELEBALLIDLE		"mcpuffin_b1/teleball_idle.wav"
	#define SND_TELEBALLIDLE2		"mcpuffin_b1/teleball_idle2.wav"
	#define SND_TELEBALLEND			"mcpuffin_b1/teleball_end.wav"
	#define SND_LEAP			"mcpuffin_b1/charge.wav"
	#define SND_AIRBLAST			"mcpuffin_b1/airblast.wav"
	#define SND_IGNITE			"mcpuffin_b1/ignite.wav"
	#define SND_DETSTICKY			"mcpuffin_b1/detsticky.wav"
	#define SND_DRONESTART			"mcpuffin_b1/dronestart.wav"
	#define SND_DRONEEND			"mcpuffin_b1/droneend.wav"
	
	
	precache_sound(SND_DRONESTART);
	precache_sound(SND_DRONEEND);
	precache_sound(SND_DETSTICKY);
	precache_sound(SND_IGNITE);
	precache_sound(SND_AIRBLAST);
	precache_sound(SND_DASH);
	precache_sound(SND_CLOAK);
	precache_sound(SND_UNCLOAK);
	precache_sound(SND_HARPOONTHROW);
	precache_sound(SND_HARPOONHITMEAT);
	precache_sound(SND_HARPOONPULL1);
	precache_sound(SND_HARPOONPULL2);
	precache_sound(SND_TELEBALLSTART);
	precache_sound(SND_TELEBALLIDLE);
	precache_sound(SND_TELEBALLIDLE2);
	precache_sound(SND_TELEBALLEND);
	precache_sound(SND_LEAP);
	
	//SPECIAL READY SOUNDS
	#define SND_SPECIALREADY		"mcpuffin_b1/specialready.wav"
	precache_sound(SND_SPECIALREADY);

	//GREN SOUNDS
	#define SND_GRENTHROW_GENERIC		"mcpuffin_b1/throwgren.wav"
	#define SND_GRENTHROW_MOLOTOV		"mcpuffin_b1/flamer_shoot.wav"
	precache_sound(SND_GRENTHROW_GENERIC);
	precache_sound(SND_GRENTHROW_MOLOTOV);
	
	#define SND_FLASHGREN			"mcpuffin_b1/gren_flash.wav"
	#define SND_MOLOTOV			"mcpuffin_b1/gren_molotov.wav"
	precache_sound(SND_FLASHGREN);
	precache_sound(SND_MOLOTOV);
	
	//ANNOUNCER SOUNDS
	#define SND_REDLEADS			"mcpuffin_b1/redleads.wav"
	#define SND_BLUELEADS			"mcpuffin_b1/blueleads.wav"
	#define SND_TEAMSTIED			"mcpuffin_b1/teamstied.wav"
	#define SND_REDSCORES			"mcpuffin_b1/redscores.wav"
	#define SND_BLUESCORES			"mcpuffin_b1/bluescores.wav"	
	#define SND_MIDAIR1			"mcpuffin_b1/midair1.wav"
	#define SND_MIDAIR2			"mcpuffin_b1/midair2.wav"
	#define SND_MIDAIR3			"mcpuffin_b1/midair3.wav"
	#define SND_MLG				"mcpuffin_b1/mlg.wav"	
	#define SND_COMBOWHORE			"mcpuffin_b1/combowhore.wav"	
	#define SND_ACCURACY			"mcpuffin_b1/accuracy.wav"
	#define SND_INSIDEOUT			"mcpuffin_b1/insideout.wav"
	#define SND_IMPRESSIVE			"mcpuffin_b1/impressive.wav"
	#define SND_BUZZER			"mcpuffin_b1/buzzer.wav"
	#define SND_YOUWIN			"mcpuffin_b1/youwin.wav"
	#define SND_YOULOSE			"mcpuffin_b1/youlose.wav"
	#define SND_FLAWLESS			"mcpuffin_b1/flawless.wav"
	#define SND_YOUSUCK			"mcpuffin_b1/yousuck.wav"
	#define SND_HOLYSHIT			"mcpuffin_b1/holyshit.wav"
	#define SND_BOO				"mcpuffin_b1/boo.wav"
	#define SND_CLAP			"mcpuffin_b1/clap.wav"
	#define SND_FIGHT			"mcpuffin_b1/fight.wav"
	#define SND_HURRYUP1			"mcpuffin_b1/hurryup1.wav"
	#define SND_HURRYUP2			"mcpuffin_b1/hurryup2.wav"
	#define SND_TIMETOCHOOSE1		"mcpuffin_b1/time2choose1.wav"
	#define SND_TIMETOCHOOSE2		"mcpuffin_b1/time2choose2.wav"
	#define SND_BURNBABYBURN		"mcpuffin_b1/burnbabyburn.wav"
	#define SND_PANCAKE			"mcpuffin_b1/pancake.wav"
	#define SND_THOMAS			"mcpuffin_b1/thomas.wav"
	#define SND_HUMILIATION			"mcpuffin_b1/humiliation.wav"
	#define SND_TOASTY			"mcpuffin_b1/toasty.wav"
	#define SND_FRESHMEAT			"mcpuffin_b1/freshmeat.wav"
	#define SND_WOW				"mcpuffin_b1/wow.wav"
	#define SND_MOMENT			"mcpuffin_b1/moment.wav"
	#define SND_KILLSOUNDHUNTER		"mcpuffin_b1/killsound_hunter.wav"
	#define SND_KITTY1			"mcpuffin_b1/kitty1.wav"
	#define SND_KITTY2			"mcpuffin_b1/kitty2.wav"
	#define SND_KITTY3			"mcpuffin_b1/kitty3.wav"
	#define SND_KITTY4			"mcpuffin_b1/kitty4.wav"
	#define SND_WAKA			"mcpuffin_b1/waka.wav"
	#define SND_YOUHAVEFLAG			"mcpuffin_b1/youhaveflag.wav"
	#define SND_ENEMYHASFLAG		"mcpuffin_b1/enemyhasflag.wav"
	#define SND_TEAMHASFLAG			"mcpuffin_b1/teamhasflag.wav"
	#define SND_TAKENLEAD			"mcpuffin_b1/takenlead.wav"
	#define SND_LOSTLEAD			"mcpuffin_b1/lostlead.wav"
	precache_sound(SND_TAKENLEAD);
	precache_sound(SND_LOSTLEAD);
	precache_sound(SND_REDSCORES);
	precache_sound(SND_BLUESCORES);
	precache_sound(SND_YOUHAVEFLAG);
	precache_sound(SND_ENEMYHASFLAG);
	precache_sound(SND_TEAMHASFLAG);
	precache_sound(SND_WAKA);
	precache_sound(SND_KITTY1);
	precache_sound(SND_KITTY2);
	precache_sound(SND_KITTY3);
	precache_sound(SND_KITTY4);
	precache_sound(SND_KILLSOUNDHUNTER);
	precache_sound(SND_REDLEADS);
	precache_sound(SND_BLUELEADS);
	precache_sound(SND_TEAMSTIED);
	precache_sound(SND_WOW);
	precache_sound(SND_MOMENT);
	precache_sound(SND_BURNBABYBURN);
	precache_sound(SND_MIDAIR1);
	precache_sound(SND_MIDAIR2);
	precache_sound(SND_MIDAIR3);
	precache_sound(SND_MLG);
	precache_sound(SND_COMBOWHORE);
	precache_sound(SND_ACCURACY);
	precache_sound(SND_INSIDEOUT);
	precache_sound(SND_IMPRESSIVE);
	precache_sound(SND_BUZZER);
	precache_sound(SND_YOUWIN);
	precache_sound(SND_YOULOSE);
	precache_sound(SND_FLAWLESS);
	precache_sound(SND_YOUSUCK);
	precache_sound(SND_HOLYSHIT);
	precache_sound(SND_CLAP);
	precache_sound(SND_BOO);
	precache_sound(SND_FIGHT);
	precache_sound(SND_HURRYUP1);
	precache_sound(SND_HURRYUP2);
	precache_sound(SND_TIMETOCHOOSE1);
	precache_sound(SND_TIMETOCHOOSE2);
	precache_sound(SND_PANCAKE);
	precache_sound(SND_THOMAS);
	precache_sound(SND_HUMILIATION);
	precache_sound(SND_TOASTY);
	precache_sound(SND_FRESHMEAT);
	
	//KILLSTREAK SOUNDS
	#define SND_KSTREAK3			"mcpuffin_b1/killstreak_killingspree.wav"
	#define SND_KSTREAK4			"mcpuffin_b1/killstreak_dominating.wav"
	#define SND_KSTREAK5			"mcpuffin_b1/killstreak_megakill.wav"
	#define SND_KSTREAK6			"mcpuffin_b1/killstreak_unstoppable.wav"
	#define SND_KSTREAK7			"mcpuffin_b1/killstreak_ultrakill.wav"
	#define SND_KSTREAK8			"mcpuffin_b1/killstreak_monsterkill.wav"
	#define SND_KSTREAK9			"mcpuffin_b1/killstreak_godlike.wav"
	#define SND_KSTREAK10			"mcpuffin_b1/killstreak_holyshit.wav"
	precache_sound(SND_KSTREAK3);
	precache_sound(SND_KSTREAK4);
	precache_sound(SND_KSTREAK5);
	precache_sound(SND_KSTREAK6);
	precache_sound(SND_KSTREAK7);
	precache_sound(SND_KSTREAK8);
	precache_sound(SND_KSTREAK9);
	precache_sound(SND_KSTREAK10);
	
	//HITSOUNDS
	#define SND_HITSOUND			"mcpuffin_b1/hitsound_enemy.wav"
	#define SND_HITSOUNDTEAM		"mcpuffin_b1/hitsound_team.wav"
	#define SND_HITSOUNDCRIT		"mcpuffin_b1/hitsound_crit.wav"
	#define SND_HITSOUNDRAIL0		"mcpuffin_b1/hitsound_rail0.wav"
	#define SND_HITSOUNDRAIL1		"mcpuffin_b1/hitsound_rail1.wav"
	#define SND_HITSOUNDRAIL2		"mcpuffin_b1/hitsound_rail2.wav"
	#define SND_HITSOUNDRAIL3		"mcpuffin_b1/hitsound_rail3.wav"
	precache_sound(SND_HITSOUND);
	precache_sound(SND_HITSOUNDTEAM);
	precache_sound(SND_HITSOUNDCRIT);
	precache_sound(SND_HITSOUNDRAIL0);
	precache_sound(SND_HITSOUNDRAIL1);
	precache_sound(SND_HITSOUNDRAIL2);
	precache_sound(SND_HITSOUNDRAIL3);
	#define SND_KILLSOUND			"mcpuffin_b1/killsound_enemy.wav"
	#define SND_KILLSOUNDTEAM		"mcpuffin_b1/killsound_team.wav"
	#define SND_KILLSOUNDSELF		"mcpuffin_b1/killsound_self.wav"
	precache_sound(SND_KILLSOUND);
	precache_sound(SND_KILLSOUNDTEAM);
	precache_sound(SND_KILLSOUNDSELF);
	
	#define SND_COUNTDOWN1			"mcpuffin_b1/countdown1.wav"
	#define SND_COUNTDOWN2			"mcpuffin_b1/countdown2.wav"
	#define SND_COUNTDOWN3			"mcpuffin_b1/countdown3.wav"
	#define SND_COUNTDOWN4			"mcpuffin_b1/countdown4.wav"
	#define SND_COUNTDOWN5			"mcpuffin_b1/countdown5.wav"
	#define SND_COUNTDOWNTICK		"misc/menu2.wav"
	precache_sound(SND_COUNTDOWN1);
	precache_sound(SND_COUNTDOWN2);
	precache_sound(SND_COUNTDOWN3);
	precache_sound(SND_COUNTDOWN4);
	precache_sound(SND_COUNTDOWN5);
	precache_sound(SND_COUNTDOWNTICK);
							     
	#define SND_SCORETICKTEAM		"mcpuffin_b1/scoretick_team.wav"
	#define SND_SCORETICKENEMY		"mcpuffin_b1/scoretick_enemy.wav"
	precache_sound(SND_SCORETICKTEAM);
	precache_sound(SND_SCORETICKENEMY);
	
	#define SND_FOOTSTEP1			"mcpuffin_b1/footstep1.wav"
	#define SND_FOOTSTEP2			"mcpuffin_b1/footstep2.wav"
	#define SND_FOOTSTEP3			"mcpuffin_b1/footstep3.wav"
	#define SND_FOOTSTEP4			"mcpuffin_b1/footstep4.wav"
	precache_sound(SND_FOOTSTEP1);
	precache_sound(SND_FOOTSTEP2);
	//precache_sound(SND_FOOTSTEP3);
	//precache_sound(SND_FOOTSTEP4);
	
	//grentimers
	precache_sound("mcpuffin_b1/grentimers/mcp_grentimer1.wav");
	precache_sound("mcpuffin_b1/grentimers/mcp_grentimer2.wav");
	precache_sound("mcpuffin_b1/grentimers/mcp_grentimer3.wav");
	precache_sound("mcpuffin_b1/grentimers/mcp_grentimer4.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer5.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer6.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer7.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer8.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer9.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer10.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer11.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer12.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer13.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer14.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer15.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer16.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer17.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer18.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer19.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer20.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer21.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer22.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer23.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer24.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer25.wav");
	//precache_sound("mcpuffin_b1/grentimers/mcp_grentimer26.wav");
	
	//PLAYER MODELS
	#define MDL_MCPPLAYER			"progs/mcpuffin_b1/mcp_player.mdl"
	#define MDL_MCPPLAYERHEAD		"progs/mcpuffin_b1/mcp_head.mdl"
	#define MDL_MCPPLAYERGIB1		"progs/gib1.mdl"
	#define MDL_MCPPLAYERGIB2		"progs/gib2.mdl"
	#define MDL_MCPPLAYERGIB3		"progs/gib3.mdl"
	#define MDL_MCPPLAYERMEATSPRAY		"progs/zom_gib.mdl"
	precache_model(MDL_MCPPLAYER);
	precache_model(MDL_MCPPLAYERHEAD);
	precache_model(MDL_MCPPLAYERGIB1);
	precache_model(MDL_MCPPLAYERGIB2);
	precache_model(MDL_MCPPLAYERGIB3);
	precache_model(MDL_MCPPLAYERMEATSPRAY);
	
	#define MDL_MCPDRONE			"progs/mcpuffin_b1/mcp_drone.mdl"
	#define MDL_MCPDRONEGIB1		"progs/mcpuffin_b1/mcp_dronegib1.mdl"
	#define MDL_MCPDRONEGIB2		"progs/mcpuffin_b1/mcp_dronegib2.mdl"
	#define MDL_MCPDRONEGIB3		"progs/mcpuffin_b1/mcp_dronegib3.mdl"
	precache_model(MDL_MCPDRONE);
	precache_model(MDL_MCPDRONEGIB1);
	precache_model(MDL_MCPDRONEGIB2);
	precache_model(MDL_MCPDRONEGIB3);
	
	#define MDL_MCPFIEND			"progs/demon.mdl"
	#define MDL_MCPBABYFIEND		"progs/mcpuffin_b1/mcp_babyfiend.mdl"
	#define MDL_MCPFIENDHEAD		"progs/h_demon.mdl"
	precache_model(MDL_MCPFIEND);
	precache_model(MDL_MCPFIENDHEAD);
	precache_model(MDL_MCPBABYFIEND);
	
	
	//WEAPON MODELS
	#define MDL_FIENDARMS			"progs/mcpuffin_b1/wpn/fiendarms.mdl"
	precache_model(MDL_FIENDARMS);
	
	#define MDL_BLUEAXE			"progs/mcpuffin_b1/wpn/blue_axe.mdl"
	#define MDL_BLUESHOTGUN			"progs/mcpuffin_b1/wpn/blue_shotgun.mdl"
	#define MDL_BLUEDBLBARREL		"progs/mcpuffin_b1/wpn/blue_supershotgun.mdl"
	#define MDL_BLUESNG			"progs/mcpuffin_b1/wpn/blue_supernailgun.mdl"
	#define MDL_BLUERAILGUN			"progs/mcpuffin_b1/wpn/blue_railgun.mdl"
	#define MDL_BLUERL			"progs/mcpuffin_b1/wpn/blue_rocketlauncher.mdl"
	#define MDL_BLUEGL			"progs/mcpuffin_b1/wpn/blue_pipelauncher.mdl"
	#define MDL_BLUESHAFT			"progs/mcpuffin_b1/wpn/blue_shaft.mdl"
	#define MDL_BLUEMINIGUN			"progs/mcpuffin_b1/wpn/blue_minigun.mdl"
	#define MDL_BLUEFLAMER			"progs/mcpuffin_b1/wpn/blue_flamer.mdl"
	#define MDL_BLUELASERGUN		"progs/mcpuffin_b1/wpn/blue_lasergun.mdl"
	#define MDL_BLUEDRONEGUN		"progs/mcpuffin_b1/wpn/blue_dronegun.mdl"
	precache_model(MDL_BLUEFLAMER);
	precache_model(MDL_BLUEAXE);
	precache_model(MDL_BLUESHOTGUN);
	precache_model(MDL_BLUEDBLBARREL);
	precache_model(MDL_BLUESNG);
	precache_model(MDL_BLUERAILGUN);
	precache_model(MDL_BLUERL);
	precache_model(MDL_BLUEGL);
	precache_model(MDL_BLUESHAFT);
	precache_model(MDL_BLUEMINIGUN);
	precache_model(MDL_BLUELASERGUN);
	precache_model(MDL_BLUEDRONEGUN);
	
	#define MDL_REDAXE			"progs/mcpuffin_b1/wpn/red_axe.mdl"
	#define MDL_REDSHOTGUN			"progs/mcpuffin_b1/wpn/red_shotgun.mdl"
	#define MDL_REDDBLBARREL		"progs/mcpuffin_b1/wpn/red_supershotgun.mdl"
	#define MDL_REDSNG			"progs/mcpuffin_b1/wpn/red_supernailgun.mdl"
	#define MDL_REDRAILGUN			"progs/mcpuffin_b1/wpn/red_railgun.mdl"
	#define MDL_REDRL			"progs/mcpuffin_b1/wpn/red_rocketlauncher.mdl"
	#define MDL_REDGL			"progs/mcpuffin_b1/wpn/red_pipelauncher.mdl"
	#define MDL_REDSHAFT			"progs/mcpuffin_b1/wpn/red_shaft.mdl"
	#define MDL_REDMINIGUN			"progs/mcpuffin_b1/wpn/red_minigun.mdl"
	#define MDL_REDFLAMER			"progs/mcpuffin_b1/wpn/red_flamer.mdl"
	#define MDL_REDLASERGUN			"progs/mcpuffin_b1/wpn/red_lasergun.mdl"
	#define MDL_REDDRONEGUN			"progs/mcpuffin_b1/wpn/red_dronegun.mdl"
	precache_model(MDL_REDFLAMER);
	precache_model(MDL_REDAXE);
	precache_model(MDL_REDSHOTGUN);	
	precache_model(MDL_REDDBLBARREL);
	precache_model(MDL_REDSNG);
	precache_model(MDL_REDRAILGUN);
	precache_model(MDL_REDRL);
	precache_model(MDL_REDGL);
	precache_model(MDL_REDSHAFT);
	precache_model(MDL_REDMINIGUN);
	precache_model(MDL_REDLASERGUN);
	precache_model(MDL_REDDRONEGUN);
	
	#define MDL_GREYAXE			"progs/mcpuffin_b1/wpn/grey_axe.mdl"
	#define MDL_GREYSHOTGUN			"progs/mcpuffin_b1/wpn/grey_shotgun.mdl"
	#define MDL_GREYDBLBARREL		"progs/mcpuffin_b1/wpn/grey_supershotgun.mdl"
	#define MDL_GREYRAILGUN			"progs/mcpuffin_b1/wpn/grey_railgun.mdl"
	#define MDL_GREYRL			"progs/mcpuffin_b1/wpn/grey_rocketlauncher.mdl"
	#define MDL_GREYSHAFT			"progs/mcpuffin_b1/wpn/grey_shaft.mdl"
	precache_model(MDL_GREYAXE);
	precache_model(MDL_GREYSHOTGUN);	
	precache_model(MDL_GREYDBLBARREL);
	precache_model(MDL_GREYRAILGUN);
	precache_model(MDL_GREYRL);
	precache_model(MDL_GREYSHAFT);
	
	//PROJECTILES
	#define MDL_NAIL			"progs/mcpuffin_b1/mcp_nail.mdl"
	precache_model(MDL_NAIL);
	#define MDL_ROCKET			"progs/mcpuffin_b1/mcp_rocket.mdl"
	precache_model(MDL_ROCKET);
	#define MDL_HARPOON			"progs/mcpuffin_b1/mcp_harpoon.mdl"
	precache_model(MDL_HARPOON);
	#define MDL_HARPOONLINK			"progs/mcpuffin_b1/mcp_nail.mdl"
	precache_model(MDL_HARPOONLINK);
	#define MDL_TELEBALL			"progs/mcpuffin_b1/mcp_teleball.mdl"
	precache_model(MDL_TELEBALL);
	#define MDL_FLAMEV			"progs/mcpuffin_b1/mcp_flamev.mdl"
	precache_model(MDL_FLAMEV);
	#define MDL_FLAMEH			"progs/mcpuffin_b1/mcp_flameh.mdl"
	precache_model(MDL_FLAMEH);
	#define MDL_FLAMEV_BIG			"progs/mcpuffin_b1/mcp_flamev_big.mdl"
	precache_model(MDL_FLAMEV_BIG);
	#define MDL_STICKY			"progs/mcpuffin_b1/mcp_sticky.mdl"
	precache_model(MDL_STICKY);
	#define MDL_LASERBOLT			"progs/mcpuffin_b1/mcp_laserbolt.mdl"
	precache_model(MDL_LASERBOLT);
	
	//GRENADES
	#define MDL_GREN_SHATTER		"progs/mcpuffin_b1/mcp_gren_frag.mdl"
	#define MDL_GREN_FLASH			"progs/mcpuffin_b1/mcp_gren_flash.mdl"
	#define MDL_GREN_FRAG			"progs/mcpuffin_b1/mcp_gren_frag.mdl"
	#define MDL_GREN_CLUSTERBIG		"progs/mcpuffin_b1/mcp_gren_clusterbig.mdl"
	#define MDL_GREN_CLUSTERSMALL  		"progs/mcpuffin_b1/mcp_gren_clustersmall.mdl"
	#define MDL_GREN_LEECH			"progs/mcpuffin_b1/mcp_gren_leech.mdl"
	#define MDL_GREN_PUSHUP			"progs/mcpuffin_b1/mcp_gren_frag.mdl"
	#define MDL_GREN_MOLOTOV		"progs/mcpuffin_b1/mcp_gren_molotov.mdl"
	#define MDL_GREN_CAPACITOR		"progs/mcpuffin_b1/mcp_gren_capacitor.mdl"
	precache_model(MDL_GREN_SHATTER);
	precache_model(MDL_GREN_FLASH);
	precache_model(MDL_GREN_FRAG);
	precache_model(MDL_GREN_CLUSTERBIG);
	precache_model(MDL_GREN_CLUSTERSMALL);
	precache_model(MDL_GREN_LEECH);
	precache_model(MDL_GREN_PUSHUP);
	precache_model(MDL_GREN_MOLOTOV);
	precache_model(MDL_GREN_CAPACITOR);
	
	//MISC
	#define MDL_MCPCOIN			"progs/mcpuffin_b1/mcp_coin.mdl"
	precache_model(MDL_MCPCOIN);
	#define MDL_THROWMEAT			"progs/mcpuffin_b1/mcp_throwmeat.mdl"
	precache_model(MDL_THROWMEAT);
	#define MDL_MCPCAPPOINT			"progs/mcpuffin_b1/mcp_mcpcappoint.mdl"
	precache_model(MDL_MCPCAPPOINT);
	#define MDL_MCPFLAG			"progs/mcpuffin_b1/mcp_mcpflag.mdl"
	precache_model(MDL_MCPFLAG);	
	#define MDL_PINGMARKER			"progs/mcpuffin_b1/mcp_ping.mdl"
	precache_model(MDL_PINGMARKER);
	#define MDL_LOOTARMOUR			"progs/mcpuffin_b1/mcp_loot_armour.mdl"
	#define MDL_LOOTGREN			"progs/mcpuffin_b1/mcp_loot_gren.mdl"
	#define MDL_LOOTHEALTH			"progs/mcpuffin_b1/mcp_loot_health.mdl"
	precache_model(MDL_LOOTARMOUR);
	precache_model(MDL_LOOTGREN);
	precache_model(MDL_LOOTHEALTH);
	
	//SPRITES
	#define SPR_DMG512		"progs/mcpuffin_b1/mcp_spr_dmgnum512.spr"
	#define SPR_DMG999		"progs/mcpuffin_b1/mcp_spr_dmgnum999.spr"
	#define SPR_TRAIL		"progs/mcpuffin_b1/mcp_spr_trail.spr"
	#define SPR_BUBBLE		"progs/s_bubble.spr"
	#define SPR_SPAWNPOINT 		"progs/mcpuffin_b1/mcp_spr_spawnpoint.spr"
	#define SPR_HEALNUM		"progs/mcpuffin_b1/mcp_spr_healnum.spr"
	#define SPR_AIRBLAST		"progs/mcpuffin_b1/mcp_spr_airblast.spr"
	#define SPR_HARPOONMARKER	"progs/mcpuffin_b1/mcp_spr_harpoonmarker.spr"
	#define SPR_CPMARKER		"progs/mcpuffin_b1/mcp_spr_cpmarker.spr"
	#define SPR_PROGRESSBAR		"progs/mcpuffin_b1/mcp_spr_progressbar.spr"
	#define SPR_CAPPOINTS		"progs/mcpuffin_b1/mcp_spr_cappoints.spr"
	#define SPR_COUNTDOWN		"progs/mcpuffin_b1/mcp_spr_countdown.spr"
	precache_model(SPR_CAPPOINTS);
	precache_model(SPR_COUNTDOWN);
	precache_model(SPR_HARPOONMARKER);
	precache_model(SPR_AIRBLAST);
	precache_model(SPR_HEALNUM);
	precache_model(SPR_SPAWNPOINT);
	precache_model(SPR_DMG512);
	precache_model(SPR_DMG999);
	precache_model(SPR_TRAIL);
	precache_model(SPR_BUBBLE);
	precache_model(SPR_CPMARKER);
	precache_model(SPR_PROGRESSBAR);
};