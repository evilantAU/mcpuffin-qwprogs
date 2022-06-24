void mcp_ModifyTeamScore(float t, float amnt) =
{
	if(matchstate != MATCHSTATE_LIVE)
		return;
		
	if(mcpmode == MCPMODE_FIEND || mcpmode == MCPMODE_BABYFIEND)
	{
		if(t == MCPTEAM_RED)
			redscore = redscore + amnt;
		if(t == MCPTEAM_BLUE)
			bluescore = bluescore + amnt;
	}
};

void mcp_SetVictoryTotal() =
{
	localcmd(strcat("localinfo ", IK_ADMINCHANGEVICTORYTOTAL," -1\n"));
	if(mcpmode == MCPMODE_FIEND)
		victorytotal = VICTORYTOTAL_FIEND;
	if(mcpmode == MCPMODE_BABYFIEND)
		victorytotal = VICTORYTOTAL_BABYFIEND;
	if(mcpmode == MCPMODE_COINSFFA)
		victorytotal = VICTORYTOTAL_COINSFFA;
	if(mcpmode == MCPMODE_COINSTEAM)
		victorytotal = VICTORYTOTAL_COINSTEAM;
	if(mcpmode == MCPMODE_SACRIFICE)
		victorytotal = VICTORYTOTAL_SACRIFICE;
	if(mcpmode == MCPMODE_5CP)
		victorytotal = VICTORYTOTAL_5CP;
};

float mcp_GetTeamPlacement(float victor) =
{

	if(redscore>bluescore)
	{
		if(victor)
			return MCPTEAM_RED;
		else
			return MCPTEAM_BLUE;
	}
	if(victor)
		return MCPTEAM_BLUE;
	else
		return MCPTEAM_RED;

	return MCPTEAM_NONE;
};

void mcp_ChangeMode(entity e, float m) =
{
	bprint(2,strcat(e.netname, " is attempting to change mode to ",mcp_ModeString(m,1),"\n"));
	stuffcmd(e,strcat("rcon localinfo ",IK_ADMINCHANGEMODE," ",ftos(m),"\n"));
	stuffcmd(e,strcat("rcon map ",mapname,"\n"));
};

void mcp_ForceVote() =
{
	mcpgm.nextthink = time;
	mcpgm.think = mcpgmthink_votemode;
	mcpgm.bubble_count = 0;
	mcpgm.cnt = 0;
};

void() info_mcp_flagspawn =
{
	self.classname = "info_mcp_flagspawn";


};

void() info_mcp_bluecapture =
{
	self.classname = "info_mcp_bluecapture";

};

void() info_mcp_redcapture =
{
	self.classname = "info_mcp_redcapture";

};



void mcp_SpawnSpawnPointSprites() =
{
	local entity te;
	local float found = 0;
	local entity spr;

	te = find(world, classname, CN_SPAWNPOINT_TEAM);
	{
		while(te != world)
		{
			found++;
			spr = spawn();
			spr.classname = CN_SPAWNPOINTSPRITE;
			spr.origin = te.origin;
			mcp_SetModel(spr, SPR_SPAWNPOINT, DIM_WORLD);
				
			if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
			{
				
				if(te.team_no == 1)
					spr.frame = MCPTEAM_BLUE;
			
				else if(te.team_no == 2)
					spr.frame = MCPTEAM_RED;
				else
					spr.frame = MCPTEAM_NONE;
			}
			else
			{
				spr.frame = MCPTEAM_NONE;
			}
					
			te = find(te,classname,CN_SPAWNPOINT_TEAM);
		}
	}
	
	if(found > 0)
		return;
			
	te = find(world,classname,CN_SPAWNPOINT_DM);
	{
		while(te != world)
		{
			found++;
			spr = spawn();
			spr.classname = CN_SPAWNPOINTSPRITE;
			spr.origin = te.origin;
			mcp_SetModel(spr, SPR_SPAWNPOINT, DIM_WORLD);
			spr.frame = MCPTEAM_NONE;
			
			te = find(te,classname,CN_SPAWNPOINT_DM);
		}
			
	}
};

float mcp_AllPlayersReady() =
{
	
	mcpgm.message = "";
	local float totalplayers = 0;
	local float readyplayers = 0;
	local float forceplayers = 0;
	if(infokey(world, IK_ADMINFORCESTART) == "1")
	{
		bprint(2,"\sadmin forcestarted the game! get psyched!\s\n");
		localcmd(strcat("localinfo ", IK_ADMINFORCESTART," 0\n"));
		return 1;
	}

	local entity te = find(world, classname, CN_PLAYER);
	while(te)
	{
		if(te != world && te.has_disconnected == 0 && te.team_no != MCPTEAM_NONE && te.netname != "")
		{
			totalplayers++;
			if(te.is_ready == READYSTATE_READY)
			{
				readyplayers++;
			}
			else if(te.is_ready == READYSTATE_FORCE)
			{
				forceplayers++;
				
			}
			else
			{
				mcpgm.message = strcat(mcpgm.message,te.netname," ");
			}
		}
		te = find(te,classname,CN_PLAYER);
	}
	
	if(totalplayers == 0)
		return 0;
	
	if(time > mcpgm.mgun_spindownfinish)
	{
		bprint(2,strcat("(",mcp_ModeString(mcpmode,0),") waiting for players: ",mcpgm.message,"\n"));
		mcpgm.mgun_spindownfinish = time + 3;
	}
	
	if(readyplayers == totalplayers || forceplayers > (totalplayers/2))
	{
		return 1;
	}
	return 0;
};

void mcp_ChangeMatchState(float ms) =
{
	matchstate = ms;
	if(ms == MATCHSTATE_WAITFORPLAYERS)
		dprint("changed matchstate : waitforplayers\n");
	else if(ms == MATCHSTATE_LIVE)
		dprint("changed matchstate : live\n");
	else if(ms == MATCHSTATE_COUNTDOWN)
		dprint("changed matchstate : countdown\n");
	else if(ms == MATCHSTATE_RESULT)
		dprint("changed matchstate : results\n");
	else if(ms == MATCHSTATE_AWARDS)
		dprint("changed matchstate : awards\n");
	else if(ms == MATCHSTATE_VOTEMAP)
		dprint("changed matchstate : votemap\n");
	else if(ms == MATCHSTATE_VOTEMODE)
		dprint("changed matchstate : votemode\n");
	else
		dprint("changed matchstate : unknown\n");
	
};

void KillExistingMCPGM() =
{
	if(mcpgm == world)
		return;
		
	mcpgm.nextthink = time;
	mcpgm.think = SUB_Remove;
};

float hasBothTeamSpawns() =
{
	return 0;
};

float mcp_isMapSacViable() =
{
	local float bluecp = 0;
	local float redcp = 0;
	local float flagspawn = 0;
	local entity te = find(world, classname, CN_INFOMCPBLUECAPTURE);
	while(te)
	{
		if(te != world)
		{
			bluecp = 1;
		}
		te = find(te,classname,CN_INFOMCPBLUECAPTURE);
	}
		
	te = find(world, classname, CN_INFOMCPREDCAPTURE);
	while(te)
	{
		if(te != world)
		{
			redcp = 1;
		}
		te = find(te,classname,CN_INFOMCPREDCAPTURE);
	}
	te = find(world, classname, CN_INFOMCPFLAGSPAWN);
	while(te)
	{
		if(te != world)
		{
			flagspawn = 1;
		}
		te = find(te,classname,CN_INFOMCPFLAGSPAWN);
	}
	
	if (bluecp == 1 && redcp == 1 && flagspawn == 1)
		return 1;
	else
		return 0;
};

void think_readyupspammer() =
{
	self.nextthink = time + 5;
	if(matchstate != MATCHSTATE_WAITFORPLAYERS)
	{
		self.nextthink = time;
		self.think = SUB_Remove;
		return;
	}
	
	local float totalplayers = 0;
	local float readyplayers = 0;
	
	//get total players + ready players
	local entity te = find(world, classname, CN_PLAYER);
	while(te)
	{
		if(te != world && te.has_disconnected == 0 && te.team_no != MCPTEAM_NONE)
		{
			totalplayers++;
			if(te.is_ready != READYSTATE_NOT)
				readyplayers++;
		}
		te = find(te,classname,CN_PLAYER);
	}
	if(totalplayers <= 0)
		return;
	//spam unready players
	te = find(world, classname, CN_PLAYER);
	while(te)
	{
		if(te != world && te.has_disconnected == 0 && te.team_no != MCPTEAM_NONE)
		{
			if(te.is_ready == READYSTATE_NOT)
			{
				if(readyplayers/totalplayers >= 0.75)
					stuffsound(te,SND_HURRYUP2);
					
				else if(readyplayers/totalplayers >= 0.5)
					stuffsound(te,SND_HURRYUP1);
					
				stuffnotice(te,"you are \snot ready\s. type ready in console.");
			}
			else
				sprint(te,PRINT_HIGH,"you are \sready\s, good job!\n");
		}
		te = find(te,classname,CN_PLAYER);
	}
	
	
};

void mcp_SetMapVoteWinner() =
{
	local float w = 0;
	local float i = 1;
	for(i = 1; i <= 9; i++)
	{
		if(VOTECHOICE[i].mapvotes > w)
			w = i;
	}
	if(w == 0)
	{
		bprint(2,"no votes? defaulting to option 1\n");
		w = 1;
	}

	mcpgm.reload_rocket_launcher = w;
};

void mcp_SetModeVoteWinner() =
{
	local float w = 0;
	local float i = 1;
	for(i = 1; i <= 6; i++)
	{
		if(VOTECHOICE[i].modevotes > w)
			w = i;
	}
		if(w == 0)
	{
		bprint(2,"no votes? defaulting to option 1\n");
		w = 1;
	}
	mcpgm.reload_grenade_launcher = w;
};


//using .reload_grenade_launcher to remember self modevote
//using .reload_rocket_launcher to remember self mapvote

void mcp_CastModeVote(entity e, float choice) =
{
	local float lastchoice = e.reload_grenade_launcher;
	if(lastchoice == choice)
	{
		stuffnotice(e,strcat("you vote for ",VOTECHOICE[choice].modestring));
		return;
	}
	if(choice == 0)
	{
		bprint(2,"error : mcp_castmodevote()\n");
		return;
	}
	if(lastchoice != 0)
		VOTECHOICE[lastchoice].modevotes--;
		
	e.reload_grenade_launcher = choice;
	VOTECHOICE[choice].modevotes++;
	stuffnotice(e,strcat("you vote for ",VOTECHOICE[choice].modestring));
		
};

void mcp_CastMapVote(entity e, float choice) =
{
	local float lastchoice = e.reload_rocket_launcher;
	if(lastchoice == choice)
	{
		stuffnotice(e,strcat("you vote for ",VOTECHOICE[choice].mapstring));
		return;
	}
	if(choice == 0)
	{
		bprint(2,"error : mcp_castmapvote()\n");
		return;
	}
	if(lastchoice != 0)
		VOTECHOICE[lastchoice].mapvotes--;
		
	e.reload_rocket_launcher = choice;
	VOTECHOICE[choice].mapvotes++;
	stuffnotice(e,strcat("you vote for ",VOTECHOICE[choice].mapstring));
};

float mcp_UniqueMapRNG(float tot) =
{
	local float res = 0;
	local float maxattempts = 200;
	local float attempts = 0;	
	for(attempts = 0; attempts < maxattempts; attempts++)
	{
		local float rng = RNG(tot);
		if(rng != VOTECHOICE[1].maprng && rng != VOTECHOICE[2].maprng && rng != VOTECHOICE[3].maprng && rng != VOTECHOICE[4].maprng && rng != VOTECHOICE[5].maprng && rng != VOTECHOICE[6].maprng && rng != VOTECHOICE[7].maprng && rng != VOTECHOICE[8].maprng && rng != VOTECHOICE[9].maprng)
		{
			res = rng;
			return res;
		}
	}
	return res;
};

void mcp_SetMapName(float option) =
{
	float filehandle;
	if(VOTECHOICE[mcpgm.reload_grenade_launcher].modetype == MCPMODE_SACRIFICE)
		filehandle = fopen(MAPLIST_SAC, FILE_READ);
	else if(VOTECHOICE[mcpgm.reload_grenade_launcher].modetype == MCPMODE_5CP)
		filehandle = fopen(MAPLIST_5CP, FILE_READ);
	else if(VOTECHOICE[mcpgm.reload_grenade_launcher].modetype == MCPMODE_COINSTEAM)
		filehandle = fopen(MAPLIST_COINSTEAM, FILE_READ);
	else if(VOTECHOICE[mcpgm.reload_grenade_launcher].modetype == MCPMODE_COINSFFA)
		filehandle = fopen(MAPLIST_COINSFFA, FILE_READ);
	else if(VOTECHOICE[mcpgm.reload_grenade_launcher].modetype == MCPMODE_FIEND)
		filehandle = fopen(MAPLIST_FIEND, FILE_READ);
	else
		filehandle = fopen(MAPLIST_BABY, FILE_READ);
	local float i;
	if (filehandle >= 0) 
	{
		// get number of lines                  
		string ln;
		ln = fgets(filehandle);
			
		while (ln)
		{
			if (strlen(ln) > 0)
			{
				i++;
				if(i == VOTECHOICE[option].maprng)
				{
					VOTECHOICE[option].mapstring = ln;
				}
			}
			ln = fgets(filehandle);
		}
		fclose(filehandle);
	}
};

void mcp_CreateVoteMapList() =
{
	// fte does weird stuff and writes/reads this to/from a "gamedir/data/file"
	local float totalcands = 0;
	
	float filehandle;
	if(VOTECHOICE[mcpgm.reload_grenade_launcher].modetype == MCPMODE_SACRIFICE)
		filehandle = fopen(MAPLIST_SAC, FILE_READ);
	else if(VOTECHOICE[mcpgm.reload_grenade_launcher].modetype == MCPMODE_5CP)
		filehandle = fopen(MAPLIST_5CP, FILE_READ);
	else if(VOTECHOICE[mcpgm.reload_grenade_launcher].modetype == MCPMODE_COINSTEAM)
		filehandle = fopen(MAPLIST_COINSTEAM, FILE_READ);
	else if(VOTECHOICE[mcpgm.reload_grenade_launcher].modetype == MCPMODE_COINSFFA)
		filehandle = fopen(MAPLIST_COINSFFA, FILE_READ);
	else if(VOTECHOICE[mcpgm.reload_grenade_launcher].modetype == MCPMODE_FIEND)
		filehandle = fopen(MAPLIST_FIEND, FILE_READ);
	else 
		filehandle = fopen(MAPLIST_BABY, FILE_READ);

	if (filehandle >= 0) 
	{
		// get number of lines                  
		string ln;
		ln = fgets(filehandle);
			
		while (ln)
		{
			if (strlen(ln) > 0)
			{
				totalcands++;
			}
			ln = fgets(filehandle);
		}
		fclose(filehandle);
	}
	
	local float maxcands = 9;
	
	
	local float i;
	for(i = 1; i <= maxcands; i++)
	{
		VOTECHOICE[i].mapvotes = 0;
		VOTECHOICE[i].maprng = 0;
		VOTECHOICE[i].maprng = mcp_UniqueMapRNG(totalcands);
		mcp_SetMapName(i);
	}
};

void mcp_CreateVoteModeList() =
{
	VOTECHOICE[1].modevotes = 0;
	VOTECHOICE[1].modetype = MCPMODE_SACRIFICE;
	VOTECHOICE[1].modestring = mcp_ModeString(MCPMODE_SACRIFICE, 0);
	
	VOTECHOICE[2].modevotes = 0;
	VOTECHOICE[2].modetype = MCPMODE_COINSTEAM;
	VOTECHOICE[2].modestring = mcp_ModeString(MCPMODE_COINSTEAM, 0);
	
	VOTECHOICE[3].modevotes = 0;
	VOTECHOICE[3].modetype = MCPMODE_FIEND;
	VOTECHOICE[3].modestring = mcp_ModeString(MCPMODE_FIEND, 0);
	
	VOTECHOICE[4].modevotes = 0;
	VOTECHOICE[4].modetype = MCPMODE_BABYFIEND;
	VOTECHOICE[4].modestring = mcp_ModeString(MCPMODE_BABYFIEND, 0);
	
	VOTECHOICE[5].modevotes = 0;
	VOTECHOICE[5].modetype = MCPMODE_5CP;
	VOTECHOICE[5].modestring = mcp_ModeString(MCPMODE_5CP, 0);
	
	VOTECHOICE[6].modevotes = 0;
	VOTECHOICE[6].modetype = MCPMODE_COINSFFA;
	VOTECHOICE[6].modestring = mcp_ModeString(MCPMODE_COINSFFA, 0);
	
};

void mcpgmthink_changemap() =
{
	self.nextthink = time + 1;
	if(self.cnt > 2)
	{	
		stuffsoundall(SND_ERROR,world);
		bprint(2,strcat("error: ",VOTECHOICE[mcpgm.reload_rocket_launcher].mapstring, " doesnt exist or something, restarting current\n"));
		changelevel(mapname);
		return;
	}

	localcmd(strcat("localinfo ",IK_ADMINCHANGEMODE," ",ftos(VOTECHOICE[mcpgm.reload_grenade_launcher].modetype),"\n"));
	changelevel(VOTECHOICE[mcpgm.reload_rocket_launcher].mapstring);
	self.cnt++;
};

void mcpgmthink_votemapresult() =
{
	self.nextthink = time + 1;
	if(self.bubble_count == 1)
	{
		bprint(2,strcat("the votes are in! winning map is : ",strconv(1,2,2,VOTECHOICE[mcpgm.reload_rocket_launcher].mapstring),"\n"));
	
		stuffsoundall(SND_MOMENT, world);
	}
	if(self.bubble_count == 5)
	{
		self.think = mcpgmthink_changemap;
		self.nextthink = time;
		self.cnt = 0;
		self.bubble_count = 0;
		return;
	}
	self.bubble_count++;
};

void mcpgmthink_votemap() =
{
	self.nextthink = time + 1;
	if(self.bubble_count == 0)
	{
		local float r = RNG(2);
		if(r == 1)
			stuffsoundall(SND_TIMETOCHOOSE1,world);
		else
			stuffsoundall(SND_TIMETOCHOOSE2,world);
			
		mcp_CreateVoteMapList();
		mcp_ChangeMatchState(MATCHSTATE_VOTEMAP);
		cprintAll(CPRINT_VOTEMAP);
		self.cnt = time + MCP_VOTETIME;
	}
	if(self.bubble_count >= 4 && self.bubble_count < 10)
		stuffsoundall(SND_COUNTDOWNTICK,world);
		
	if(self.bubble_count == 10)
	{
		mcp_SetMapVoteWinner();
		self.bubble_count = 0;
		cprintAll(CPRINT_VOTEMAPRESULT);
		self.nextthink = time;
		self.think = mcpgmthink_votemapresult;
		return;
	}
		
	
	self.bubble_count++;
};

void mcpgmthink_votemoderesult() =
{
	self.nextthink = time + 1;

	if(self.bubble_count == 1)
	{
		bprint(2,strcat("voting has closed! the winning mode is : ",strconv(1,2,2,VOTECHOICE[mcpgm.reload_grenade_launcher].modestring),"\n"));
		
		stuffsoundall(SND_WOW,world);
		mcpmode = VOTECHOICE[mcpgm.reload_grenade_launcher].modetype;
		//mcp_SetNewParms();

	}
	if(self.bubble_count == 3)
	{
		self.cnt = 0;
		self.bubble_count = 0;
		self.think = mcpgmthink_votemap;
		self.nextthink = time;
		return;
	}
	
	self.bubble_count++;
		
	
};

void mcpgmthink_votemode() = 
{
	self.nextthink = time + 1;
	if(self.bubble_count == 0)
	{
		local float r = RNG(2);
		if(r == 1)
			stuffsoundall(SND_TIMETOCHOOSE1,world);
		else
			stuffsoundall(SND_TIMETOCHOOSE2,world);
			
		mcp_CreateVoteModeList();
		mcp_ChangeMatchState(MATCHSTATE_VOTEMODE);
		cprintAll(CPRINT_VOTEMODE);
		self.cnt = time + MCP_VOTETIME;
	}
	
	if(self.bubble_count >= 4 && self.bubble_count < 10)
		stuffsoundall(SND_COUNTDOWNTICK,world);
		
	if(self.bubble_count == 10)
	{
		mcp_SetModeVoteWinner();
		self.bubble_count = 0;
		cprintAll(CPRINT_VOTEMODERESULT);
		self.nextthink = time;
		self.think = mcpgmthink_votemoderesult;
		return;
	}
		
	self.bubble_count++;
};

void mcpgmthink_countdown() =
{
	self.nextthink = time + 1;
	
	if(self.bubble_count == 0)
	{
		bprint(2,"\sthe match is now live!\s\n");
		mcp_KillAllPlayers();
		stuffsoundall(SND_FIGHT,world);
		
		lightstyle(0, "m");
		
		local entity p = find(world, classname, CN_PLAYER);
		while (p != world) 
		{	
			if (p.frags != 0) 
			{
				p.frags = 0;
			}
			p = find(p, classname, CN_PLAYER);
		}
		if(mcpmode == MCPMODE_COINSTEAM)
			self.think = mcpgmthink_live_coinsteam;
		else if(mcpmode == MCPMODE_SACRIFICE)
			self.think = mcpgmthink_live_sac;
		else if(mcpmode == MCPMODE_FIEND)
			self.think = mcpgmthink_live_fiend;
		else if(mcpmode == MCPMODE_BABYFIEND)
			self.think = mcpgmthink_live_baby;
		else if(mcpmode == MCPMODE_5CP)
			self.think = mcpgmthink_live_5cp;
		else if(mcpmode == MCPMODE_COINSFFA)
			self.think = mcpgmthink_live_coinsffa;
		else
			self.think = SUB_Null;
		self.nextthink = time + 0.5;
		self.bubble_count = 0;
		return;
	}
		
	if(self.bubble_count == 1)
		bprint(2,strcat("\s[\s",ftos(self.bubble_count),"\s]\s second.\n"));
	else
		bprint(2, strcat("\s[\s",ftos(self.bubble_count),"\s]\s seconds.\n"));
	
	if(self.bubble_count == 1)
		stuffsoundall(SND_COUNTDOWN1, world);
	if(self.bubble_count == 2)
		stuffsoundall(SND_COUNTDOWN2, world);
	if(self.bubble_count == 3)
		stuffsoundall(SND_COUNTDOWN3, world);
	if(self.bubble_count == 4)
		stuffsoundall(SND_COUNTDOWN4, world);
	if(self.bubble_count == 5)
		stuffsoundall(SND_COUNTDOWN5, world);
	if(self.bubble_count <= 10)
		stuffsoundall(SND_COUNTDOWNTICK,world);
	if(self.bubble_count == 10)
		lightstyle(0, "e");
	self.bubble_count = self.bubble_count - 1;
};

void mcpgmthink_waitforplayers() =
{
	self.nextthink = time + 1;
	if(mcp_AllPlayersReady() == 1)
	{
		mcp_ChangeMatchState(MATCHSTATE_COUNTDOWN);
		//cprintAll(CPRINT_COUNTDOWN);
		self.think = mcpgmthink_countdown;
		self.nextthink = time;
		self.bubble_count = 10;
		self.cnt = time + 10;
	}
	
};
void mcp_RemoveSpecificMapItem(string c) =
{
	local entity srch; 
	srch = find(world, classname, c);
	while(srch)
	{
		if (srch != world) 
		{
			remove(srch);
		}
		srch = find(srch, classname, c);
	}
};
void mcp_RemoveMapItems() =
{
	mcp_RemoveSpecificMapItem("item_artifact_envirosuit");
	mcp_RemoveSpecificMapItem("item_artifact_invulnerability");
	mcp_RemoveSpecificMapItem("item_artifact_invisibility");
	mcp_RemoveSpecificMapItem("item_artifact_super_damage");
	mcp_RemoveSpecificMapItem("item_armorInv");
	mcp_RemoveSpecificMapItem("item_armor1");
	mcp_RemoveSpecificMapItem("item_armor2");
	mcp_RemoveSpecificMapItem("item_shells");
	mcp_RemoveSpecificMapItem("item_spikes");
	mcp_RemoveSpecificMapItem("item_rockets");
	mcp_RemoveSpecificMapItem("item_cells");
	mcp_RemoveSpecificMapItem("weapon_supershotgun");
	mcp_RemoveSpecificMapItem("weapon_nailgun");
	mcp_RemoveSpecificMapItem("weapon_supernailgun");
	mcp_RemoveSpecificMapItem("weapon_grenadelauncher");
	mcp_RemoveSpecificMapItem("weapon_rocketlauncher");
	mcp_RemoveSpecificMapItem("weapon_lightning");
	mcp_RemoveSpecificMapItem("item_health");
	mcp_RemoveSpecificMapItem("item_megahealth_rot");
	mcp_RemoveSpecificMapItem("item_key1");
	mcp_RemoveSpecificMapItem("item_key2");
	mcp_RemoveSpecificMapItem("item_sigil");
	
	mcp_RemoveSpecificMapItem("item_tfgoal");
	mcp_RemoveSpecificMapItem("info_tfgoal");
};

void think_adminchangecheck() =
{
	self.nextthink = time + 1;
	
	if(stof(infokey(world,IK_ADMINCHANGEVICTORYTOTAL)) == -1)
		return;
	
	if(infokey(world,IK_ADMINCHANGEVICTORYTOTAL) == "")
		return;

	bprint(2,strcat("\schanging victory total from: \s",ftos(victorytotal),"\s to: \s",infokey(world,IK_ADMINCHANGEVICTORYTOTAL),"\s. restart not required.\s\n"));
	stuffsoundall(SND_NOTICE, world);
	victorytotal = stof(infokey(world,IK_ADMINCHANGEVICTORYTOTAL));
	localcmd(strcat("localinfo ", IK_ADMINCHANGEVICTORYTOTAL," -1\n"));
};

void mcp_SpawnMCPGM() =
{
	if(mcpgm != world)
		KillExistingMCPGM();
		
	mcpmode =  stof(infokey(world,IK_ADMINCHANGEMODE));
	
	if(mcpmode == MCPMODE_NONE)
		mcpmode = MCPMODE_SACRIFICE;
		
	if(mcpmode == MCPMODE_SACRIFICE)
	{
		if(mcp_isMapSacViable() == 0)
		{
			bprint(2,"warning: map missing required sacrifice mode ents (flagspawn/cappoints), no victory condition possible\n");
			mapisviable = 0;
		}
		else
		{
			mapisviable = 1;
			mcp_SetupSacCappoints();
		}
	}
	if(mcpmode == MCPMODE_5CP)
	{
		if(mcp_isMap5cpViable() == 0)
		{
			bprint(2,"warning: map missing required 5cp mode ents (all 5 control points), no victory condition possible\n");
			mapisviable = 0;
		}
		else
		{
			mapisviable = 1;
			mcp_SetupControlPoints();
		}
	}
	mcp_RemoveMapItems();
	mcp_SpawnSpawnPointSprites();
	mcp_SetVictoryTotal();
	
	local entity gm = spawn();
	gm.classname = CN_GAMEMASTER;
	gm.think = mcpgmthink_waitforplayers;
	gm.nextthink = time + 1;
	mcpgm = gm;
	
	bluescore = 0;
	redscore = 0;
	
	mcp_ChangeMatchState(MATCHSTATE_WAITFORPLAYERS);
	
	local entity rs = spawn();
	rs.classname = CN_READYUPSPAMMER;
	rs.think = think_readyupspammer;
	rs.nextthink = time + 2;
	
	local entity acc = spawn();
	acc.classname = CN_ADMINCHANGECHECKER;
	acc.think = think_adminchangecheck;
	acc.nextthink = time + 1;
};
