void mcp_CreateAlias(entity e, string s, float imp) =
{
    local string aliasstring = strcat("alias ",s," impulse ",ftos(imp),"\n");
    stuffcmd(e, aliasstring);
};

void mcp_CreateAliasBatch(entity e, float i) =			//doing it in batches because server doesnt like too many at once
{
	
	if(i == 0)
	{
		mcp_CreateAlias(e,"joinblue"			,	MCPIMPULSE_JOINBLUE);
		mcp_CreateAlias(e,"joinred" 			,	MCPIMPULSE_JOINRED);
		mcp_CreateAlias(e,"goblue"			,	MCPIMPULSE_JOINBLUE);
		mcp_CreateAlias(e,"gored"			, 	MCPIMPULSE_JOINRED);
		mcp_CreateAlias(e,"joinloser"			,	MCPIMPULSE_JOINLOSER);
		mcp_CreateAlias(e,"goloser"			,	MCPIMPULSE_JOINLOSER);
		mcp_CreateAlias(e,"swapteam"			,	MCPIMPULSE_SWAPTEAM);
		mcp_CreateAlias(e,"changeteam"			,	MCPIMPULSE_CHANGETEAM);
		mcp_CreateAlias(e,"changeclass"			, 	MCPIMPULSE_CHANGEROLE);
		mcp_CreateAlias(e,"ready"			, 	MCPIMPULSE_READY);
		mcp_CreateAlias(e,"forcestart"			,	MCPIMPULSE_FORCESTART);
		mcp_CreateAlias(e,"adminforcestart" 		,	MCPIMPULSE_FORCESTARTALL);
		mcp_CreateAlias(e,"adminchangemodesac"		,	MCPIMPULSE_CHANGEMODESACRIFICE);
		mcp_CreateAlias(e,"adminchangemodecoinsteam"	,	MCPIMPULSE_CHANGEMODECOINSTEAM);
		mcp_CreateAlias(e,"adminchangemodecoinsffa"	,	MCPIMPULSE_CHANGEMODECOINSFFA);
		mcp_CreateAlias(e,"adminchangemodefiend"	,	MCPIMPULSE_CHANGEMODEFIEND);
		mcp_CreateAlias(e,"adminchangemodebaby" 	,	MCPIMPULSE_CHANGEMODEBABYFIEND);
		mcp_CreateAlias(e,"adminchangemode5cp" 		,	MCPIMPULSE_CHANGEMODE5CP);
		mcp_CreateAlias(e,"adminforcevote"		,	MCPIMPULSE_FORCEVOTE);	
		
	}
	if(i == 1)
	{
		mcp_CreateAlias(e,"scout"		, 	MCPIMPULSE_GORECON);
		mcp_CreateAlias(e,"sniper"		, 	MCPIMPULSE_GOASSASSIN);
		mcp_CreateAlias(e,"soldier"		, 	MCPIMPULSE_GOFIGHTER);
		mcp_CreateAlias(e,"demoman"		, 	MCPIMPULSE_GOBOMBER);
		mcp_CreateAlias(e,"medic"		, 	MCPIMPULSE_GODOCTOR);
		mcp_CreateAlias(e,"hwguy"		, 	MCPIMPULSE_GOMINIGUNNER);
		mcp_CreateAlias(e,"pyro"		, 	MCPIMPULSE_GOARSONIST);
		mcp_CreateAlias(e,"engineer"		, 	MCPIMPULSE_GOTECHNICIAN);
		
		mcp_CreateAlias(e,"recon"		, 	MCPIMPULSE_GORECON);
		mcp_CreateAlias(e,"assassin"		, 	MCPIMPULSE_GOASSASSIN);
		mcp_CreateAlias(e,"fighter"		, 	MCPIMPULSE_GOFIGHTER);
		mcp_CreateAlias(e,"bomber"		, 	MCPIMPULSE_GOBOMBER);
		mcp_CreateAlias(e,"doctor"		, 	MCPIMPULSE_GODOCTOR);
		mcp_CreateAlias(e,"minigunner"		, 	MCPIMPULSE_GOMINIGUNNER);
		mcp_CreateAlias(e,"arsonist"		, 	MCPIMPULSE_GOARSONIST);
		mcp_CreateAlias(e,"technician"		, 	MCPIMPULSE_GOTECHNICIAN);
		mcp_CreateAlias(e,"randomclass"		, 	MCPIMPULSE_GORANDOM);
		mcp_CreateAlias(e,"randompc"		, 	MCPIMPULSE_GORANDOM);
		
	}
	if(i == 2)
	{
		mcp_CreateAlias(e,"special"		,	MCPIMPULSE_SPECIAL);
		mcp_CreateAlias(e,"primeone"		, 	MCPIMPULSE_PRIMEGREN);
		mcp_CreateAlias(e,"primetwo"		, 	MCPIMPULSE_PRIMEGREN);
		mcp_CreateAlias(e,"primegren"		, 	MCPIMPULSE_PRIMEGREN);
		mcp_CreateAlias(e,"throwgren"		, 	MCPIMPULSE_THROWGREN);
		mcp_CreateAlias(e,"+gren"		, 	MCPIMPULSE_PRIMEGREN);
		mcp_CreateAlias(e,"+gren1"		, 	MCPIMPULSE_PRIMEGREN);
		mcp_CreateAlias(e,"+gren2"		, 	MCPIMPULSE_PRIMEGREN);
		mcp_CreateAlias(e,"-gren"		, 	MCPIMPULSE_THROWGREN);
		mcp_CreateAlias(e,"-gren1"		, 	MCPIMPULSE_THROWGREN);
		mcp_CreateAlias(e,"-gren2"		, 	MCPIMPULSE_THROWGREN);
		mcp_CreateAlias(e,"gren1"		, 	MCPIMPULSE_2TAPGREN);
		mcp_CreateAlias(e,"gren2"		, 	MCPIMPULSE_2TAPGREN);
		mcp_CreateAlias(e,"grenade"		, 	MCPIMPULSE_2TAPGREN);
		
		
	}
	if(i == 3)
	{
		mcp_CreateAlias(e,"+slot1"		, 	MCPIMPULSE_QCKSLOT1_START);
		mcp_CreateAlias(e,"+slot2"		, 	MCPIMPULSE_QCKSLOT2_START);
		mcp_CreateAlias(e,"+slot3"		, 	MCPIMPULSE_QCKSLOT3_START);
		mcp_CreateAlias(e,"+slot4"		, 	MCPIMPULSE_QCKSLOT4_START);
		mcp_CreateAlias(e,"-slot1"		, 	MCPIMPULSE_QCKSLOT1_STOP);
		mcp_CreateAlias(e,"-slot2"		, 	MCPIMPULSE_QCKSLOT2_STOP);
		mcp_CreateAlias(e,"-slot3"		, 	MCPIMPULSE_QCKSLOT3_STOP);
		mcp_CreateAlias(e,"-slot4"		, 	MCPIMPULSE_QCKSLOT4_STOP);
		mcp_CreateAlias(e,"reloadnext"		, 	MCPIMPULSE_RELOADNEXT);
		mcp_CreateAlias(e,"weapnext"		, 	MCPIMPULSE_NEXTSLOT);
		mcp_CreateAlias(e,"weapprev"		, 	MCPIMPULSE_PREVSLOT);
		mcp_CreateAlias(e,"weaplast"		, 	MCPIMPULSE_LASTSLOT);
		
	}
	if(i == 4)
	{
		mcp_CreateAlias(e,"throwflag"		,	MCPIMPULSE_THROWGOAL);
		mcp_CreateAlias(e,"dropflag"		,	MCPIMPULSE_THROWGOAL);
		mcp_CreateAlias(e,"dropitems"		,	MCPIMPULSE_THROWGOAL);
		mcp_CreateAlias(e,"1hp"			,	MCPIMPULSE_1HP);	
		mcp_CreateAlias(e,"reload"		, 	MCPIMPULSE_RELOAD);
		mcp_CreateAlias(e,"slot1"		,	MCPIMPULSE_KEYBOARD1);
		mcp_CreateAlias(e,"slot2"		,	MCPIMPULSE_KEYBOARD2);
		mcp_CreateAlias(e,"slot3"		, 	MCPIMPULSE_KEYBOARD3);
		mcp_CreateAlias(e,"slot4"		,	MCPIMPULSE_KEYBOARD4);
		mcp_CreateAlias(e,"fo_menu_special"	,	MCPIMPULSE_KEYBOARD5);
			
	}
};

void think_aliasmaker()=
{
	if(self.cnt == 5)
	{
		self.think = SUB_Remove;
		self.nextthink = time;
		return;
	}
	mcp_CreateAliasBatch(self.owner, self.cnt);
	self.cnt++;
	self.nextthink = time + 0.2;
}

void mcp_SpawnAliasMaker(entity e) =
{
	local entity te = spawn();
	te.classname = CN_ALIASMAKER;
	te.owner = e;
	te.cnt = 0;
	te.nextthink = time + 0.2;
	te.think = think_aliasmaker;
};