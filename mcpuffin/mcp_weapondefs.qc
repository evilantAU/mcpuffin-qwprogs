

typedef struct 
{
	string namestr;
	float type;
	string modelblue;
	string modelred;
	string modelgrey;
	float clipsize;
	float ammotype;
	string shootsound;
	float fullreloadtime;
	string reloadsound;
	string reloadcompletesound;
} mcpweaptype;

mcpweaptype MCPWEAPDICT[16] = 
{
	{
		"none",			//name
		MCPWEAP_NONE,		//type#
		"",			//mdlblue
		"",			//mdlred
		"",			//mdlgrey
		0,			//clipsize
		0,			//hudammoicon
		"",			//shootsound
		0,			//fullreloadtime
		"",			//reloadsound
		""			//reloadcomplete
		
	}
	,
	{
		"axe",			//name
		MCPWEAP_AXE,		//type#
		MDL_BLUEAXE,		//mdlblue
		MDL_REDAXE,		//mdlred
		MDL_GREYAXE,		//mdlgrey
		0,			//clipsize
		0,			//hudammoicon
		SND_SHOOTAXE,		//shootsound
		0,			//fullreloadtime
		"",			//reloadsound
		""			//reloadcomplete
	}
	,
	{
		"shotgun",		//name
		MCPWEAP_SHOTGUN,	//type#
		MDL_BLUESHOTGUN,	//mdlblue
		MDL_REDSHOTGUN,		//mdlred
		MDL_GREYSHOTGUN,	//mdlgrey
		8,			//clipsize
		IT_SHELLS,		//hudammoicon
		SND_SHOOTSHOTGUN,	//shootsound
		2,			//fullreloadtime
		SND_RELOADSHELL,	//reloadsound
		SND_RELOADSHELL	//reloadcomplete
	}
	,
	{
		"double barrel shotgun",//name
		MCPWEAP_DBLBARREL,	//type#
		MDL_BLUEDBLBARREL,	//mdlblue
		MDL_REDDBLBARREL,	//mdlred
		MDL_GREYDBLBARREL,	//mdlgrey
		2,			//clipsize
		IT_SHELLS,		//hudammoicon
		SND_SHOOTDBLBARREL,	//shootsound
		2,			//fullreloadtime
		SND_RELOADDBLBARREL,	//reloadsound
		SND_RELOADDBLBARREL	//reloadendsound
	}
	,
	{
		"super nailgun",	//name
		MCPWEAP_SNG,		//type#
		MDL_BLUESNG,		//mdlblue
		MDL_REDSNG,		//mdlred
		"",			//mdlgrey
		30,			//clipsize
		IT_NAILS,		//hudammoicon
		SND_SHOOTSNG,		//shootsound
		3,			//fullreloadtime
		SND_RELOADNAIL,		//reloadsound
		SND_RELOADNAIL		//reloadendsound
	}
	,
	{
		"railgun",		//name
		MCPWEAP_RAILGUN,	//type#
		MDL_BLUERAILGUN,	//mdlblue
		MDL_REDRAILGUN,		//mdlred
		MDL_GREYRAILGUN,	//mdlgrey
		1,			//clipsize
		IT_NAILS,		//hudammoicon
		SND_SHOOTRAILGUN,	//shootsound
		1.5,			//fullreloadtime
		SND_RELOADRAILGUN,	//reloadsound
		SND_RELOADRAILGUN	//reloadendsound
	}
	,
	{
		"rocket launcher",	//name
		MCPWEAP_RL,		//type#
		MDL_BLUERL,		//mdlblue
		MDL_REDRL,		//mdlred
		MDL_GREYRL,		//mdlgrey
		4,			//clipsize
		IT_ROCKETS,		//hudammoicon
		SND_SHOOTRL,		//shootsound
		5,			//fullreloadtime
		SND_RELOADROCKET,	//reloadsound
		SND_RELOADROCKET	//reloadendsound
	}
	,
	{
		"sticky launcher",	//name
		MCPWEAP_GL,		//type#
		MDL_BLUEGL,		//mdlblue
		MDL_REDGL,		//mdlred
		"",			//mdlgrey
		6,			//clipsize
		IT_ROCKETS,		//hudammoicon
		SND_SHOOTGL,		//shootsound
		4,			//fullreloadtime
		SND_RELOADROCKET,	//reloadsound
		SND_RELOADROCKET	//reloadendsound
	}
	,
	{
		"shaft",		//name
		MCPWEAP_SHAFT,		//type#
		MDL_BLUESHAFT,		//mdlblue
		MDL_REDSHAFT,		//mdlred
		MDL_GREYSHAFT,		//mdlgrey
		30,			//clipsize
		IT_CELLS,		//hudammoicon
		SND_SHOOTSHAFT,		//shootsound
		3,			//fullreloadtime
		SND_RELOADCELL,		//reloadsound
		SND_RELOADCELL		//reloadendsound
	}
	,
	{
		"minigun",		//name
		MCPWEAP_MINIGUN,	//type#
		MDL_BLUEMINIGUN,	//mdlblue
		MDL_REDMINIGUN,		//mdlred
		"",			//mdlgrey
		100,			//clipsize
		IT_SHELLS,		//hudammoicon
		SND_SHOOTMINIGUN,	//shootsound
		5,			//fullreloadtime
		SND_RELOADSHELL,	//reloadsound
		SND_RELOADSHELL		//reloadendsound
	}
	,
	{
		"flame thrower",	//name
		MCPWEAP_FLAMER,		//type#
		MDL_BLUEFLAMER,		//mdlblue
		MDL_REDFLAMER,		//mdlred
		"",			//mdlgrey
		15,			//clipsize
		IT_CELLS,		//hudammoicon
		SND_SHOOTFLAMER,	//shootsound
		2.25,			//fullreloadtime
		SND_RELOADCELL,		//reloadsound
		SND_RELOADCELL		//reloadendsound
	}
	,
	{
		"lasergun",		//name
		MCPWEAP_LASERGUN,	//type#
		MDL_BLUELASERGUN,	//mdlblue
		MDL_REDLASERGUN,	//mdlred
		"",			//mdlgrey
		5,			//clipsize
		IT_NAILS,		//hudammoicon
		SND_SHOOTLASERGUN,	//shootsound	
		1.25,			//fullreloadtime
		SND_RELOADCELL,		//reloadsound
		SND_RELOADCELL		//reloadendsound
	}
	,
	{
		"dronegun",		//name
		MCPWEAP_DRONEGUN,	//type#
		MDL_BLUEDRONEGUN,	//mdlblue
		MDL_REDDRONEGUN,	//mdlred
		"",			//mdlgrey
		999,			//clipsize
		IT_CELLS,		//hudammoicon
		SND_SHOOTLASERGUN,	//shootsound	
		0,			//fullreloadtime
		SND_RELOADCELL,		//reloadsound
		SND_RELOADCELL		//reloadendsound
	}
	,
	{
		"fiend claws",		//name
		MCPWEAP_FIENDCLAWS,	//type#
		MDL_FIENDARMS,		//mdlblue
		MDL_FIENDARMS,		//mdlred
		MDL_FIENDARMS,		//mdlgrey
		0,			//clipsize
		0,			//hudammoicon
		SND_SHOOTLASERGUN,	//shootsound	
		0,			//fullreloadtime
		"",		//reloadsound
		""		//reloadendsound
	}
	,
		{
		"shaft",		//name
		MCPWEAP_SHAFTUNLIM,	//type#
		MDL_BLUESHAFT,		//mdlblue
		MDL_REDSHAFT,		//mdlred
		MDL_GREYSHAFT,		//mdlgrey
		0,			//clipsize
		IT_CELLS,		//hudammoicon
		SND_SHOOTSHAFT,		//shootsound
		0,			//fullreloadtime
		SND_RELOADCELL,		//reloadsound
		SND_RELOADCELL		//reloadendsound
	}
	,
	{
		"rocket launcher",	//name
		MCPWEAP_RLUNLIM,	//type#
		MDL_BLUERL,		//mdlblue
		MDL_REDRL,		//mdlred
		MDL_GREYRL,		//mdlgrey
		0,			//clipsize
		IT_ROCKETS,		//hudammoicon
		SND_SHOOTRL,		//shootsound
		0,			//fullreloadtime
		SND_RELOADROCKET,	//reloadsound
		SND_RELOADROCKET	//reloadendsound
	}
	
};