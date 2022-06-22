//
typedef struct 
{
	string namestr;
	float type;
	float cellregentotaltime;
	float cellregentotalticks;
	string sreadysound;
	
} mcpspecialtype;

mcpspecialtype MCPSPECDICT[13] = 
{
	{
		"none",			//name
		MCPSPECIAL_NONE,	//type
		0,			//total regen time
		0,			//total ticks
		""			//ready sound
	}
	,
	{
		"dash",			//name
		MCPSPECIAL_DASH,	//type
		1,			//total regen time
		4,			//total ticks
		SND_SPECIALREADY	//ready sound
		
	}	
	,
	{
		"cloak",		//name
		MCPSPECIAL_CLOAK,	//type
		20,			//total regen time
		10,			//total ticks
		SND_SPECIALREADY		//ready sound
	}
	,
	{
		"harpoon",		//name
		MCPSPECIAL_HARPOON,	//type
		5,			//total regen time
		5,			//total ticks
		SND_SPECIALREADY		//ready sound
	}
	,
	{
		"detonatesticky",	//name
		MCPSPECIAL_DETSTICKY,	//type
		1,			//total regen time
		1,			//total ticks
		SND_SPECIALREADY		//ready sound
	}
	,
	{
		"teleball",		//name
		MCPSPECIAL_TELEBALL,	//type
		10,			//total regen time
		10,			//total ticks
		SND_SPECIALREADY		//ready sound
	}
	,
	{
		"leap",			//name
		MCPSPECIAL_LEAP,	//type
		6,			//total regen time
		6,			//total ticks
		SND_SPECIALREADY		//ready sound
	}
	,
	{
		"airblast",		//name
		MCPSPECIAL_AIRBLAST,	//type
		3,			//total regen time
		5,			//total ticks
		SND_SPECIALREADY	//ready sound
	}
	,
	{
		"drone",		//name
		MCPSPECIAL_DRONE,	//type
		20,			//total regen time
		10,			//total ticks
		SND_SPECIALREADY	//ready sound
	}
	,
	{
		"random",		//name
		MCPSPECIAL_RANDOM,	//type
		1,			//total regen time
		1,			//total ticks
		SND_SPECIALREADY	//ready sound
		
	}
	,
	{
		"throw meat",		//name
		MCPSPECIAL_THROWMEAT,	//type
		10,			//total regen time
		10,			//total ticks
		SND_SPECIALREADY	//ready sound
		
	}
	,
	{
		"detonaterocket",	//name
		MCPSPECIAL_DETROCKET,	//type
		1,			//total regen time
		1,			//total ticks
		SND_SPECIALREADY	//ready sound
		
	}
	,
	{
		"leap",			//name
		MCPSPECIAL_LEAPFIEND,	//type
		3,			//total regen time
		5,			//total ticks
		SND_SPECIALREADY	//ready sound
	}
	
};