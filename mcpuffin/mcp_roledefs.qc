typedef struct {
	float clip;
} mcpclip;

typedef struct 
{
	string namestr;
	float type;
	float skinblue;
	float skinred;
	float maxhealth;
	float maxarmour;
	float speed;
	float grentype;
	float maxgrens;
	float weapon1;
	float weapon2;
	float weapon3;
	float weapon4;
	float specialtype;

	
} mcproletype;

mcproletype MCPROLEDICT[15] = 
{
	{
		"none",		//name
		ROLE_NONE,	//role#
		0,		//skinblue
		0,		//skinred
		1,		//maxhealth
		0,		//maxarmour
		999,		//speed
		MCPGREN_NONE,	//grentype
		0,
		MCPWEAP_NONE,	
		MCPWEAP_NONE,
		MCPWEAP_NONE,
		MCPWEAP_NONE,
		MCPSPECIAL_NONE
	}
	,
	{
		"recon",	//name	
		ROLE_RECON,	//role#
		1,		//skinblue
		9,		//skinred
		100,		//maxhealth
		0,		//maxarmour
		380,		//speed
		MCPGREN_SHATTER,
		2,
		MCPWEAP_AXE,
		MCPWEAP_SHOTGUN,
		MCPWEAP_DBLBARREL,
		MCPWEAP_SNG,
		MCPSPECIAL_DASH
	}
	,
	{
		"assassin",	//name
		ROLE_ASSASSIN,	//role#
		2,		//skinblue
		10,		//skinred
		100,		//maxhealth
		0,		//maxarmour
		280,		//speed
		MCPGREN_FLASH,
		2,
		MCPWEAP_AXE,
		MCPWEAP_SHOTGUN,
		MCPWEAP_DBLBARREL,
		MCPWEAP_RAILGUN,
		MCPSPECIAL_CLOAK
	}
	,
	{
		"fighter",	//name
		ROLE_FIGHTER,	//role#
		3,		//skinblue
		11,		//skinred
		100,		//maxhealth
		150,		//maxarmour
		240,		//speed
		MCPGREN_FRAG,
		2,
		MCPWEAP_AXE,
		MCPWEAP_SHOTGUN,
		MCPWEAP_DBLBARREL,
		MCPWEAP_RL,
		MCPSPECIAL_HARPOON
	}
	,
	{
		"bomber",	//name
		ROLE_BOMBER,	//role#
		4,		//skinblue
		12,		//skinred
		100,		//health
		100,		//maxarmour
		280,		//speed
		MCPGREN_CLUSTER,
		2,
		MCPWEAP_AXE,
		MCPWEAP_SHOTGUN,
		MCPWEAP_DBLBARREL,
		MCPWEAP_GL,
		MCPSPECIAL_DETSTICKY
	}
	,
	{
		"doctor",	//name
		ROLE_DOCTOR,	//role#
		5,		//skinblue
		13,		//skinred
		100,		//maxhealth
		50,		//maxarmour
		320,		//speed
		MCPGREN_LEECH,
		2,
		MCPWEAP_AXE,
		MCPWEAP_SHOTGUN,
		MCPWEAP_DBLBARREL,
		MCPWEAP_SHAFT,
		MCPSPECIAL_TELEBALL
	}
	,
	{
		"minigunner",	//name
		ROLE_MINIGUNNER,//role#
		6,		//skinblue
		14,		//skinred
		100,		//maxhealth
		150,		//maxarmour
		230,		//speed
		MCPGREN_PUSHUP,
		2,
		MCPWEAP_AXE,
		MCPWEAP_SHOTGUN,
		MCPWEAP_DBLBARREL,
		MCPWEAP_MINIGUN,
		MCPSPECIAL_LEAP
	}
	,
	{
		"arsonist",	//name
		ROLE_ARSONIST,	//role#
		7,		//skinblue
		15,		//skinred
		100,		//maxhealth
		150,		//maxarmour
		320,		//speed
		MCPGREN_MOLOTOV,
		2,
		MCPWEAP_AXE,
		MCPWEAP_SHOTGUN,
		MCPWEAP_DBLBARREL,
		MCPWEAP_FLAMER,
		MCPSPECIAL_AIRBLAST
	}
	,
	{
		"technician",	//name
		ROLE_TECHNICIAN,//role#
		8,		//blueskin
		16,		//redskin
		100,		//maxhealth
		150,		//maxarmour
		320,		//speed
		MCPGREN_CAPACITOR,
		2,
		MCPWEAP_AXE,
		MCPWEAP_SHOTGUN,
		MCPWEAP_DBLBARREL,
		MCPWEAP_LASERGUN,
		MCPSPECIAL_DRONE
	}
	,
	{
		"random",	//name
		ROLE_RANDOM,	//role#
		0,		//blueskin
		0,		//redskin
		1,		//maxhealth
		0,		//maxarmour
		999,		//speed
		MCPGREN_NONE,
		0,
		MCPWEAP_NONE,
		MCPWEAP_NONE,
		MCPWEAP_NONE,
		MCPWEAP_NONE,
		MCPSPECIAL_NONE
	}
	,
	{
		"fiend",	//name
		ROLE_FIEND,	//role#
		0,		//skinblue
		0,		//skinred
		250,		//maxhealth
		0,		//maxarmour
		400,		//speed
		MCPGREN_NONE,
		0,
		MCPWEAP_FIENDCLAWS,
		MCPWEAP_NONE,
		MCPWEAP_NONE,
		MCPWEAP_NONE,
		MCPSPECIAL_LEAPFIEND
	}
	,
	{
		"human",	//name
		ROLE_FIENDHUMAN,//role#
		17,		//skinblue
		18,		//skinred
		100,		//maxhealth
		200,		//maxarmour
		320,		//speed
		MCPGREN_NONE,
		0,
		MCPWEAP_AXE,
		MCPWEAP_RAILGUN,
		MCPWEAP_SHAFTUNLIM,
		MCPWEAP_RLUNLIM,
		MCPSPECIAL_AIRBLAST
	}
	,
	{
		"mugger",	//name
		ROLE_MUGGER,    //role#
		17,		//skinblue
		18,		//skinred
		250,		//maxhealth
		250,		//maxarmour
		320,		//speed
		MCPGREN_NONE,
		0,
		MCPWEAP_AXE,
		MCPWEAP_RAILGUN,
		MCPWEAP_SHAFTUNLIM,
		MCPWEAP_RLUNLIM,
		MCPSPECIAL_NONE
	}
	,
	{
		"hunter",	//name
		ROLE_HUNTER,    //role#
		17,		//skinblue
		18,		//skinred
		100,		//maxhealth
		0,		//maxarmour
		300,		//speed
		MCPGREN_NONE,
		0,
		MCPWEAP_AXE,
		MCPWEAP_SHOTGUN,
		MCPWEAP_NONE,
		MCPWEAP_NONE,
		MCPSPECIAL_THROWMEAT
	}
	,
	{
		"babyfiend",	//name
		ROLE_BABYFIEND,	//role#
		0,		//skinblue
		0,		//skinred
		25,		//maxhealth
		0,		//maxarmour
		250,		//speed
		MCPGREN_NONE,
		0,
		MCPWEAP_FIENDCLAWS,
		MCPWEAP_NONE,
		MCPWEAP_NONE,
		MCPWEAP_NONE,
		MCPSPECIAL_LEAPFIEND
	}
	
	
};