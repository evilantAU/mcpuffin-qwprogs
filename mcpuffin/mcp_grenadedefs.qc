typedef struct 
{
	string namestr;
	float type;
	string modelstr;
	string throwsound;
	string grensound;
	vector avel;
	string stickyprefix;
	string stickypostfix;
	
} mcpgrentype;

mcpgrentype MCPGRENDICT[9] = 
{
	{
		"error grenade",	//name
		MCPGREN_NONE,		//type
		"",			//model
		SND_ERROR,		//throwsound
		SND_ERROR,		//grensound
		'0 0 0',		//avel
		"uhoh",			//sticky prefix
		"something is wrong"			//sticky postfix
	}
	,
	{
		"shatter grenade",	//name
		MCPGREN_SHATTER,	//type
		MDL_GREN_SHATTER,	//model
		SND_GRENTHROW_GENERIC,	//throwsound
		"",			//grensound
		'300 300 300',		//avel
		"uhh",			//sticky prefix
		"swallowing the grenade isn't very effective!"			//sticky postfix	
	}
	,
	{
		"flash grenade",	//name
		MCPGREN_FLASH,		//type
		MDL_GREN_FLASH,		//model
		SND_GRENTHROW_GENERIC,	//throwsound
		SND_FLASHGREN,		//grensound
		'300 300 300',		//avel
		"no",			//sticky prefix
		"you cannot take a selfie with it!"			//sticky postfix
	}
	,
	{
		"frag grenade",		//name
		MCPGREN_FRAG,		//type
		MDL_GREN_FRAG,		//model
		SND_GRENTHROW_GENERIC,	//throwsound
		"",			//grensound
		'300 300 300',		//avel
		"umm",			//sticky prefix
		"you're meant to THROW the grenade!"	//sticky postfix	
	}
	,
	{
		"cluster grenade",		//name
		MCPGREN_CLUSTER,		//type
		MDL_GREN_CLUSTERBIG,		//model
		SND_GRENTHROW_GENERIC,		//throwsound
		"",				//grensound
		'300 300 300',			//avel
		"err",				//sticky prefix
		"it's not a chocolate cluster!"	//sticky postfix	
	}
	,
	{
		"leech grenade",		//name
		MCPGREN_LEECH,			//type
		MDL_GREN_LEECH,			//model
		SND_GRENTHROW_GENERIC,		//throwsound
		"",			//grensound
		'300 300 300',			//avel
		"yuck",				//sticky prefix
		"eating the leeches is bad!"	//sticky postfix	
	}
	,
	{
		"pushup grenade",		//name
		MCPGREN_PUSHUP,			//type
		MDL_GREN_PUSHUP,		//model
		SND_GRENTHROW_GENERIC,		//throwsound
		"",				//grensound
		'300 300 300',			//avel
		"it seems",			//sticky prefix
		"needs to learn how to count!"	//sticky postfix	
	}
	,
	{
		"molotov",			//name
		MCPGREN_MOLOTOV,		//type
		MDL_GREN_MOLOTOV,		//model
		SND_GRENTHROW_MOLOTOV,		//throwsound
		"",				//grensound
		'300 300 300',			//avel
		"eww",				//sticky prefix
		"dont drink your molotov!"	//sticky postfix	
	}
	,
	{
		"capacitor grenade",		//name
		MCPGREN_CAPACITOR,		//type
		MDL_GREN_CAPACITOR,		//model
		SND_GRENTHROW_GENERIC,	//throwsound
		"",				//grensound
		'300 300 300',			//avel
		"oof",				//sticky prefix
		"that was shocking!"		//sticky postfix	
	}
	
	
	
};