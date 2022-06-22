#define MAPLIST_SAC		"maplist_sacrifice.cfg"
#define MAPLIST_FIEND		"maplist_fiend.cfg"
#define MAPLIST_BABY		"maplist_babyfiend.cfg"
#define MAPLIST_COINSTEAM	"maplist_coinsteam.cfg"
#define MAPLIST_5CP		"maplist_5cp.cfg"
#define MAPLIST_COINSFFA	"maplist_coinsffa.cfg"
		
//classname
#define CN_GAMEMASTER		"mcpgm"
#define CN_PLAYER		"player"
#define CN_BUBBLE		"bubble"
#define CN_CPRINTER		"cprinter"
#define CN_DAMAGENUMBER		"damagenumber"
#define CN_RELOAD		"reload"
#define CN_CORPSE		"corpse"
#define CN_AIRBLASTROCKET	"airblastrocket"
#define CN_CLOAK		"cloak"
#define CN_HARPOON		"harpoon"
#define CN_HARPOONTIMER		"harpoontimer"
#define CN_TELEBALL		"teleball"
#define CN_ALIASMAKER		"aliasmaker"
#define CN_SPEEDTRACKER		"mcpspeedtracker"
#define CN_ROCKET		"mcprocket"
#define CN_STICKY_DIRECT	"sticky_direct"
#define CN_STICKY_TRAP		"sticky_trap"
#define CN_NAIL			"mcpnail"
#define CN_CLIMBNAIL		"mcpclimbingnail"
#define CN_LASERBOLT		"mcplaserbolt"
#define CN_DRONEBULLET		"mcpdronebullet"
#define CN_FLAMERBULLET		"mcpflamerbullet"
#define CN_DRONETIMER		"mcpdronetimer"
#define CN_MIDAIRCOUNTER	"midaircounter"
#define CN_FLAMERDOT		"mcpflamerdot"
#define CN_MOLOTOVDOT		"mcpmolotovdot"
#define CN_THROWNGRENADE	"mcpthrowngren"
#define CN_FLASHTIMER		"mcpflashtimer"
#define CN_TELEBALLDEATH	"teleballdeath"
#define CN_MCPCOIN		"mcpcoin"
#define CN_PRIMEGREN		"mcpprimegren"
#define CN_THROWNGREN		"mcpthrowngren"
#define CN_MOLOTOVFLAME		"mcpmolotovflame"
#define CN_CAPACITORINFECTION	"mcpcapacitorinfection"
#define CN_FLASHGRENTIMER	"mcpflashgrentimer"
#define CN_CLUSTERBIG		"mcpclusterbig"
#define CN_CLUSTERSMALL		"mcpclustersmall"
#define CN_SPAWNPOINTSPRITE	"spawnpointspr"
#define CN_SPAWNPOINT_DM	"info_player_deathmatch"
#define CN_SPAWNPOINT_TEAM	"info_player_teamspawn"
#define CN_READYUPSPAMMER	"readyupspammer"
#define CN_HUNTERDETECT		"hunterdetect"
#define CN_THROWMEAT		"throwmeat"
#define CN_HEALNUMBER		"healnumber"
#define CN_AIRBLASTSPRITE	"airblastspr"
#define CN_HARPOONMARKER	"harpmark"
#define CN_INFOMCPBLUECAPTURE	"info_mcp_bluecapture"
#define CN_INFOMCPREDCAPTURE	"info_mcp_redcapture"
#define CN_INFOMCPFLAGSPAWN	"info_mcp_flagspawn"
#define CN_MCPBLUECAPTURE	"mcpbluecapture"
#define CN_MCPREDCAPTURE	"mcpredcapture"
#define CN_MCPFLAGSPAWN		"mcpflagspawn"
#define CN_FLAGTIMER		"mcpflagtimer"
#define CN_FLAGTRAILMAKER	"mcpflagtrailmaker"
#define CN_FLAGTRAIL		"mcpflagtrail"
#define CN_MCPFLAG		"mcpflag"
#define CN_LOOTARMOUR		"lootarmour"
#define CN_LOOTGREN		"lootgren"
#define CN_LOOTHEALTH		"loothealth"
#define CN_FIENDLEAPTRACKER	"fiendleaptracker"
#define CN_CONTROLPOINTTRACKER	"mcpcptracker"
#define CN_CONTROLPOINTMARKER 	"mcpcpmarker"
#define CN_CP1			"info_mcp_cp1"
#define CN_CP2			"info_mcp_cp2"
#define CN_CP3			"info_mcp_cp3"
#define CN_CP4			"info_mcp_cp4"
#define CN_CP5			"info_mcp_cp5"
#define CN_BSPAWN_CP5		"bs_cp5"
#define CN_BSPAWN_CP4		"bs_cp4"
#define CN_RSPAWN_CP2		"rs_cp2"
#define CN_RSPAWN_CP1		"rs_cp1"


//infokeys
//client
#define IK_KILLSTREAKS		"killstreaks"		//dont play killstreak sounds if 0
#define IK_HITSOUND		"hitsound"		//0 to turn off
#define IK_KILLSOUND		"killsound"		//killsounds 1- only enemies, 2 - enemy and team
#define IK_FLIPSLOTS		"flipslots"		//reverse slot order on keyboard 
#define IK_NOHITNUMBERS		"nohitnumbers"		//no damage numbers spawned above players head 
#define IK_SB			"sb"			//statusbar? spacebetween? whitespace newlines from top to sbar 
#define IK_EC			"ec"			//exec class configs
#define IK_ET			"et"			//exec team configs
#define IK_AI			"ai"			//autoid
#define IK_AUTOEXEC		"autoexec"		//autoexec mcpuffin.cfg	
#define IK_MINFLASH		"minflash"      	//min flashgren flash effect client - does not alter what is seen or duration
#define IK_MAXFLASH		"maxflash"		//max flashgren flash effect client - does not alter what is seen or duration
#define IK_VISGRENTIMER		"vgt"			//"" or 1 displays all, 2 slider only
#define IK_GRENTIMER		"grentimer"		//if 0 no sound played on grenprime, otherwise number set determines the grentimer sound
#define IK_GRENTIMERDELAY	"grentimerdelay"	//ent is spawned to play grentimer sound, nextthink + this 

//world
#define IK_MCPMODE		"mcpmode"		//world setting, used for detecting mode on map change
#define IK_FORCESTART		"forcestart"		//world setting, readys up all players if not 0


//deathtypes
#define MCPDEATH_AXE			1
#define MCPDEATH_SHOTGUN		2
#define MCPDEATH_DBLBARREL		3
#define MCPDEATH_SNG			4
#define MCPDEATH_RAILGUN		5
#define MCPDEATH_ROCKET_DIRECT		6
#define MCPDEATH_ROCKET_SPLASH		7
#define MCPDEATH_ROCKET_HARPOON		8
#define MCPDEATH_STICKY_AIR		9
#define MCPDEATH_STICKY_DIRECT		10
#define MCPDEATH_STICKY_TRAP		11
#define MCPDEATH_SHAFT			12
#define MCPDEATH_MINIGUN		13
#define MCPDEATH_FLAMER			14
#define MCPDEATH_LASERBOLT		15
#define MCPDEATH_DRONEBULLET		16

#define MCPDEATH_GOOMBASTOMP		17
#define MCPDEATH_HARPOON		18
#define MCPDEATH_TELEBALL		19
#define MCPDEATH_IGNITE			20
#define MCPDEATH_SHOULDERCHARGE		21

#define MCPDEATH_GREN_SHATTER		22
#define MCPDEATH_GREN_FLASH		23
#define MCPDEATH_GREN_FRAG		24
#define MCPDEATH_GREN_CLUSTERBIG	25
#define MCPDEATH_GREN_CLUSTERSMALL	26
#define MCPDEATH_GREN_LEECH		27
#define MCPDEATH_GREN_MOLOTOV		28
#define MCPDEATH_GREN_CAPACITOR		29

#define MCPDEATH_FALL			30
#define MCPDEATH_FLAMERDOT		31
#define MCPDEATH_MOLOTOVDOT		32
#define MCPDEATH_FIENDCLAWS		33
#define MCPDEATH_ROCKET_DETONATE	34
#define MCPDEATH_HUNTERDECAY		35
#define MCPDEATH_LEAPFIEND		36


//DIMENSIONS
//#define DIM_WORLD		1	
#define DIM_BLUETEAM		2
#define DIM_REDTEAM		4
#define DIM_FLAG		8
#define DIM_FLAGSOUND		16
#define DIM_WORLD		256    //changed to this to match fo dmn_noflash

#define DIM_PLAYER1		512
#define DIM_PLAYER2		1028
#define DIM_PLAYER3		2048
#define DIM_PLAYER4		4096
#define DIM_PLAYER5		8192
#define DIM_PLAYER6		16384
#define DIM_PLAYER7		32768
#define DIM_PLAYER8		65536
#define DIM_PLAYER9		131072
#define DIM_PLAYER10		262144
#define DIM_PLAYER11		524288
#define DIM_PLAYER12		1048576
#define DIM_PLAYER13		2097152
#define DIM_PLAYER14		4194304
#define DIM_PLAYER15		8388608
#define DIM_PLAYER16		16777216
#define DIM_PLAYER17		33554432
#define DIM_PLAYER18		67108864
#define DIM_PLAYER19		134217728
#define DIM_PLAYER20		268435456

//MATCHSTATES
#define MATCHSTATE_WAITFORPLAYERS	1
#define MATCHSTATE_COUNTDOWN		2
#define MATCHSTATE_LIVE			3
#define MATCHSTATE_RESULT		4
#define MATCHSTATE_AWARDS		5
#define MATCHSTATE_VOTEMAP		6
#define MATCHSTATE_VOTEMODE		7

//GOATSTATE
#define MCPGOALSTATE_NONE			0
#define MCPGOALSTATE_RESET			1
#define MCPGOALSTATE_CARRIED			2
#define MCPGOALSTATE_DROPPED			3
#define MCPGOALSTATE_CAPPED			4
#define MCPGOALSTATE_THROWN			5
#define MCPGOALSTATE_LIMBO			6

//controlpoints - ordering is important coz of struct
#define MCPCP_BLUE1			0	//info_mcp_cp1
#define MCPCP_BLUE2			1	//info_mcp_cp2
#define MCPCP_MID			2	//info_mcp_cp3
#define MCPCP_RED2			3	//info_mcp_cp4
#define MCPCP_RED1			4	//info_mcp_cp5

//CONTROLPOINTSTATE
#define MCPCPSTATE_NEUTRAL		0
#define MCPCPSTATE_BLUEOWNED		1
#define MCPCPSTATE_REDOWNED		2

//RESPAWN DELAY
#define RESPAWNPENALTY_SUICIDE		4
#define RESPAWNPENALTY_INCONTROL	4
#define RESPAWNPENALTY_OUTOFCONTROL	2

#define READYSTATE_NOT			0
#define READYSTATE_READY		1
#define READYSTATE_FORCE		2

#define CPRINT_TICKRATE		0.2
#define MCPGRENTIME		3.8
	
#define CPRINT_NONE		0
#define CPRINT_REMOVE 		1
#define CPRINT_WELCOME		2
#define CPRINT_SELECTTEAM	3
#define CPRINT_SELECTROLE	4
#define CPRINT_COUNTDOWN	5
#define CPRINT_RESULT		6
#define CPRINT_VOTEMAP		7
#define CPRINT_VOTEMODE		8
#define CPRINT_VOTEMODERESULT	9
#define CPRINT_VOTEMAPRESULT    10

#define MCPMODE_NONE			0
#define MCPMODE_SACRIFICE		1
#define MCPMODE_FIEND			2
#define MCPMODE_COINSTEAM		3
#define MCPMODE_BABYFIEND		4
#define MCPMODE_5CP			5
#define MCPMODE_COINSFFA		6

//mode stuff
#define COINS_WINTOTAL		50
#define COINS_DURATION		20
#define COINS_GRACEPERIOD	0.5
#define SACRIFICE_POINTINTERVAL	2	
#define MCPFLAG_RESETTIME	15
#define MCPFLAG_TOSSSPEED	600

#define SACRIFICE_WINTOTAL	100
#define FIEND_WINTOTAL		25
#define BABY_WINTOTAL		25

#define MCPCP_TICKRATE			1
#define MCPCP_PROGRESSNEEDED_MAIN	50
#define MCPCP_PROGRESSNEEDED_NORMAL	100
#define MCPCP_CPDEFAULTRADIUS		160
#define MCPCP_PROGRESSPERPLAYER		5

#define LOOT_DURATION		15
#define LOOT_ARMOURAMOUNT	20
#define LOOT_HEALTHAMOUNT	20
#define LOOT_GRENAMOUNT		1

#define MCP_VOTETIME		10

#define MCPTEAM_NONE		0
#define MCPTEAM_BLUE		1
#define MCPTEAM_RED		2
#define MCPTEAM_AUTO		3
#define MCPTEAM_LOSER		4

#define ROLE_NONE		0
#define ROLE_RECON		1
#define ROLE_ASSASSIN		2
#define ROLE_FIGHTER		3
#define ROLE_BOMBER		4
#define ROLE_DOCTOR		5
#define ROLE_MINIGUNNER		6
#define ROLE_ARSONIST		7
#define ROLE_TECHNICIAN		8
#define ROLE_RANDOM		9
#define ROLE_FIEND		10
#define ROLE_FIENDHUMAN		11
#define ROLE_MUGGER		12
#define ROLE_HUNTER		13
#define ROLE_BABYFIEND		14

#define MCPGREN_NONE		0
#define MCPGREN_SHATTER		1
#define MCPGREN_FLASH		2
#define MCPGREN_FRAG		3
#define MCPGREN_CLUSTER		4
#define MCPGREN_LEECH		5
#define MCPGREN_PUSHUP		6
#define MCPGREN_MOLOTOV		7
#define MCPGREN_CAPACITOR	8

#define MCPSPECIAL_NONE		0
#define MCPSPECIAL_DASH		1
#define MCPSPECIAL_CLOAK	2
#define MCPSPECIAL_HARPOON	3
#define MCPSPECIAL_DETSTICKY	4
#define MCPSPECIAL_TELEBALL	5
#define MCPSPECIAL_LEAP		6
#define MCPSPECIAL_AIRBLAST	7
#define MCPSPECIAL_DRONE	8
#define MCPSPECIAL_RANDOM	9
#define MCPSPECIAL_THROWMEAT	10
#define MCPSPECIAL_DETROCKET	11
#define MCPSPECIAL_LEAPFIEND	12

//WEAPONS
#define MCPWEAP_NONE		0
#define MCPWEAP_AXE		1
#define MCPWEAP_SHOTGUN		2
#define MCPWEAP_DBLBARREL	3
#define MCPWEAP_SNG		4
#define MCPWEAP_RAILGUN		5
#define MCPWEAP_RL		6
#define MCPWEAP_GL		7
#define MCPWEAP_SHAFT		8
#define MCPWEAP_MINIGUN		9
#define MCPWEAP_FLAMER		10
#define MCPWEAP_LASERGUN	11
#define MCPWEAP_DRONEGUN	12
#define MCPWEAP_FIENDCLAWS	13
#define MCPWEAP_SHAFTUNLIM	14
#define MCPWEAP_RLUNLIM		15


#define MCPWEAPSTATE_NONE	0
#define MCPWEAPSTATE_SPINUP	1
#define MCPWEAPSTATE_SPINNING	2
#define MCPWEAPSTATE_SPINDOWN	3
#define MCPWEAPSTATE_DRONE	4
#define MCPWEAPSTATE_DRONESHOOT	5

//SLOTS
#define MCPSLOTNONE		-1
#define MCPSLOT1		0
#define MCPSLOT2		1
#define MCPSLOT3		2
#define MCPSLOT4		3

//melee
#define MELEEDAMAGE_GENERAL		20
#define MELEEDAMAGE_FIEND		200
#define MELEEDAMAGE_ASSASSIN		999
#define MELEEDAMAGE_BABYFIEND		5

//STICKY
#define STICKYDAMAGE_DIRECT		120	
#define STICKYDAMAGE_SURFACEDET		120
#define STICKYDAMAGE_AIRDET		60

//SHAFT
#define SHAFT_DAMAGE			8
#define SHAFT_HEAL			5
#define SHAFT_SELFHEAL			5
#define SHAFT_OVERHEAL			50

#define MGUNNERTOUCH_MAXDAMAGE  	400
#define MGUNNERTOUCH_MINDAMAGE 	 	10
#define MGUNNERTOUCH_MINSPEED  		300
#define MGUNNERTOUCH_MAXSPEED  		1000

#define MGUNNER_DAMAGEREDUCTION		0.5	//damage is multiplied by this
#define MGUNNER_BOUNCEREDUCTION		0.25    
#define MGUNNER_BOUNCETHRESHOLD		10	//if damage is less than this 0 bounce applied

#define MINIGUN_SPINUPTIME		0.75
#define MINIGUN_SPINDOWNTIME		0.5
#define MINIGUN_SPINWALKSPEED		80

#define	MCP_NAIL_SPEED			1500
#define MCP_CLIMBNAIL_DURATION		3
#define MCP_CLIMBNAIL_BOOST		350
#define MCP_ROCKET_SPEED		1000
#define MCP_AIRBLASTROCKET_SPEED	1000
#define MCP_LASERBOLT_SPEED		1500
#define MCP_LASERBOLT_DAMAGE		20
#define MCP_DRONEBULLET_SPEED		1000
#define MCP_DRONEBULLET_DAMAGE		10
#define MCP_FLAMER_SPEED		1000
#define MCP_FLAMER_DAMAGE		2
#define MCP_FLAMER_DURATION		0.6
#define MCP_FLAMER_TARGFINDRADIUS	70
#define MCP_FLAMERDOT_DAMAGE		2
#define MCP_FLAMERDOT_STACKS		5


//SPECIALS
#define CLOAK_DURATION			6
#define HARPOON_QUADWINDOW		2
#define HARPOON_SPEED			1750
#define HARPOON_DAMAGE			25
#define AIRBLAST_RADIUS			150
#define AIRBLAST_MAXPLAYERPUSH		1100
#define AIRBLAST_MINPLAYERPUSH		500
#define DRONE_DURATION			10
#define DRONE_SPINWALKSPEED		150
#define DRONE_FLYSPEED			350
#define DRONE_BULLETSPEED		1000
#define DRONE_BULLETDMG			10
#define LEAPBABYFIEND_VELOCITY		800
#define LEAP_VELOCITY			800
#define LEAPFIEND_VELOCITY		900
#define TELEBALL_DURATION		10
#define TELEBALL_SPEED			600
#define FLAMER_DOTEXPLODE		3
#define MOLOTOV_DOTEXPLODE		5
#define LEAPFIEND_MINWINDOW		0.5	//time + this
#define LEAPFIEND_MAXWINDOW		5	//time + this	
#define LEAPFIEND_DAMAGE		100
#define THROWMEAT_DURATION		5

//MISC
#define CLIMBINGNAIL_DURATION		3
#define CLIMBINGNAIL_BOOST		350
#define GSTOMP_DAMAGE			999
#define RECONSHOTGUNJUMPS		2
#define MCP_CELLREGENDELAY		0.2
#define PUSHUPGREN_RADIUS		240 
#define PUSHUPGREN_MAXPLAYERPUSH	1200
#define PUSHUPGREN_MINPLAYERPUSH	600
#define MOLOTOV_FLAMERANGE		0.25
#define MOLOTOV_DOTDAMAGE		5
#define MOLOTOV_DOTCOUNT		10
#define CAPACITOR_DAMAGE 		80
#define CAPACITOR_RADIUS		250
#define CAPACITOR_INFECTIONDURATION	6
#define MCPFLASHGREN_DURATION		3
#define MCPFRAG_DAMAGE			180
#define CLUSTERBIG_DAMAGE		50
#define CLUSTERSMALL_DAMAGE		100
#define HANDHELDGRENEXPLODEDELAY	0.1		

//IMPULSES -- START
#define MCPIMPULSE_0				0
#define MCPIMPULSE_KEYBOARD1			1
#define MCPIMPULSE_KEYBOARD2			2
#define MCPIMPULSE_KEYBOARD3			3
#define MCPIMPULSE_KEYBOARD4			4
#define MCPIMPULSE_KEYBOARD5			5
#define MCPIMPULSE_KEYBOARD6			6
#define MCPIMPULSE_KEYBOARD7			7
#define MCPIMPULSE_KEYBOARD8			8
#define MCPIMPULSE_KEYBOARD9			9

#define MCPIMPULSE_NEXTSLOT			11
#define MCPIMPULSE_PREVSLOT			12
#define MCPIMPULSE_LASTSLOT			13

#define MCPIMPULSE_PRIMEGREN			14
#define MCPIMPULSE_2TAPGREN			15
#define MCPIMPULSE_THROWGREN			16

#define MCPIMPULSE_QCKSLOT1_START		20
#define MCPIMPULSE_QCKSLOT2_START		21
#define MCPIMPULSE_QCKSLOT3_START		22
#define MCPIMPULSE_QCKSLOT4_START		23
#define MCPIMPULSE_QCKSLOT1_STOP		24
#define MCPIMPULSE_QCKSLOT2_STOP		25
#define MCPIMPULSE_QCKSLOT3_STOP		26
#define MCPIMPULSE_QCKSLOT4_STOP		27

#define MCPIMPULSE_RELOAD			28
#define MCPIMPULSE_RELOADNEXT			29
#define MCPIMPULSE_SPECIAL			30
#define MCPIMPULSE_INV				36
#define MCPIMPULSE_FLAGINFO			37

#define MCPIMPULSE_CHANGETEAM			100
#define MCPIMPULSE_JOINBLUE			101
#define MCPIMPULSE_JOINRED			102
#define MCPIMPULSE_JOINLOSER			103

#define MCPIMPULSE_CHANGEROLE			110
#define MCPIMPULSE_GORECON			111
#define MCPIMPULSE_GOASSASSIN			112
#define MCPIMPULSE_GOFIGHTER			113
#define MCPIMPULSE_GOBOMBER			114
#define MCPIMPULSE_GODOCTOR			115
#define MCPIMPULSE_GOMINIGUNNER			116
#define MCPIMPULSE_GOARSONIST			117
#define MCPIMPULSE_GOTECHNICIAN			118
#define MCPIMPULSE_GORANDOM			119
#define MCPIMPULSE_SWAPTEAM			120

#define MCPIMPULSE_READY			135
#define MCPIMPULSE_NOTREADY			136
#define MCPIMPULSE_FORCESTART			137
#define MCPIMPULSE_FORCESTARTALL		138
#define MCPIMPULSE_FORCEVOTE			139
#define MCPIMPULSE_THROWGOAL			148

#define MCPIMPULSE_1HP				199


#define MCPIMPULSE_CHANGEMODESACRIFICE		210
#define MCPIMPULSE_CHANGEMODECOINSTEAM		211
#define MCPIMPULSE_CHANGEMODEFIEND		212
#define MCPIMPULSE_CHANGEMODEBABYFIEND		213
#define MCPIMPULSE_CHANGEMODE5CP		214
#define MCPIMPULSE_CHANGEMODECOINSFFA		215


#define MCPIMPULSE_NULL				666
//IMPULSES -- END