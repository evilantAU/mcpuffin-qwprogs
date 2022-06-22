void mcp_DiedWithMCPFlag (entity e) =
{
	e.impulse = 0;
	if(mcpmode != MCPMODE_SACRIFICE)
		return;
	if(e.classname != CN_PLAYER)
		return;
	if(mcpgoal.owner != e)
		return;
		
		
	//AddStat(e, STAT_FLAGDIEDWITH, 1);	
	mcp_ChangeMCPGoalState(MCPGOALSTATE_DROPPED, e);
	e.items = e.items - (e.items & IT_KEY1);
};

void mcp_ThrowMCPFlag (entity e) =
{
	e.impulse = 0;
	if(e.classname != CN_PLAYER)
		return;
	if(mcpgoal.owner != e)
		return;
	
	mcp_ChangeMCPGoalState(MCPGOALSTATE_THROWN, e);
	e.items = e.items - (e.items & IT_KEY1);
	
	mcpgoal.velocity_z = MCPFLAG_TOSSSPEED;
	mcpgoal.velocity_x = -50 + (random() * 100);
	mcpgoal.velocity_y = -50 + (random() * 100);
	
	 makevectors(e.v_angle);
        if (e.v_angle_x < 25) {
            mcpgoal.velocity = (v_forward * MCPFLAG_TOSSSPEED) + (v_up * 200);
        } else {
            mcpgoal.velocity = aim(e, 10000);
            mcpgoal.velocity = mcpgoal.velocity * MCPFLAG_TOSSSPEED;
            mcpgoal.velocity_z = 200;
        }

};


void mcp_ScoreTick() =
{
	local entity te = find(world, classname, CN_PLAYER);
	while (te) 
	{
		if (te.team_no == mcpgoal.team_no) 
		{
			if(infokey(te, "scoreticktext") != "0")
				sprint(te,PRINT_HIGH, "your team controls flag (+1 point)\n");
			if(infokey(te, "scoreticksound") != "0")
				stuffsound(te, SND_SCORETICKTEAM);
		}
		else
		{
			if(infokey(te, "scoreticktext") != "0")
				sprint(te,PRINT_HIGH, "enemy team controls flag (+1 point)\n");
			if(infokey(te, "scoreticksound") != "0")
				stuffsound(te, SND_SCORETICKENEMY);
		}
		
		te = find(te, classname, CN_PLAYER);
	}
	
	
};

void mcp_SpawnMCPFlag() =
{
	mcpgoal = spawn();
	mcpgoal.classname = CN_MCPFLAG;
	mcpgoal.owner = mcpgm;
	mcpgoal.nextthink = time + 1;	
	
	setsize(mcpgoal, VEC_HULL_MIN, VEC_HULL_MAX);
	mcp_ChangeMCPGoalState(MCPGOALSTATE_RESET,mcpgm);
	
};

void touch_mcpflag() = 
{
	if(matchstate != MATCHSTATE_LIVE)
		return;
	if (other.classname != CN_PLAYER)
		return;	
	if (other.team_no == MCPTEAM_NONE)
		return;
	if(other.team_no == mcpgoal.owner.team_no)
		return;

	mcp_ChangeMCPGoalState(MCPGOALSTATE_CARRIED, other);
};

void capped_mcpflag() =
{
	if(matchstate != MATCHSTATE_LIVE)
		return;
		
	mcpgoal.nextthink = time + SACRIFICE_POINTINTERVAL;
	
	if(mcpgoal.owner.team_no == MCPTEAM_BLUE)
		bluescore++;
		
	if(mcpgoal.owner.team_no == MCPTEAM_RED)
		redscore++;
	
	if(mcpgoal.owner.team_no == MCPTEAM_BLUE && (bluescore - redscore) == 1)
	{
		bprint(2, "the \sblue team\s has taken the lead!\n");
		stuffsoundall(SND_BLUELEADS,world);
	}
	if(mcpgoal.owner.team_no == MCPTEAM_RED && (redscore - bluescore) == 1)
	{
		bprint(2, "the \sred team\s has taken the lead!\n");
		stuffsoundall(SND_REDLEADS,world);
	}
	if(bluescore == redscore)
	{
		bprint(2, "the teams are tied!\n");
		stuffsoundall(SND_TEAMSTIED,world);
	}
	mcp_ScoreTick();
};

void carried_mcpflag()=
{
	if(matchstate != MATCHSTATE_LIVE)
		return;
	self.nextthink = time + 1;	
};

void loose_mcpflag() =
{
	if(self.touch != touch_mcpflag)
		self.touch = touch_mcpflag;
		
	self.nextthink = time + 1;
	
	if(self.bubble_count == 10)
	{
		mcp_ChangeMCPGoalState(MCPGOALSTATE_RESET, mcpgm);
		return;
	}
	
	if(self.bubble_count == 0 || self.bubble_count >= 5 && self.bubble_count < 10)
	{
		if(self.bubble_count == 9)
			bprint(2, strcat("flag returning in \s[\s",ftos(10-self.bubble_count),"\s]\s second.\n"));
		else
			bprint(2, strcat("flag returning in \s[\s",ftos(10-self.bubble_count),"\s]\s seconds.\n"));
			
		stuffsoundall(SND_COUNTDOWNTICK,world);

	}
	
	// look hurt_touch() for returning flag in maps like xpress3
	local float pos = pointcontents(mcpgoal.origin);
	if(pos == CONTENT_SKY || pos == CONTENT_LAVA)
	{
		if(self.bubble_count < 5)
			self.bubble_count = 5;
	}
	self.bubble_count++;
};

void mcp_ChangeMCPGoalState(float s, entity e) =
{
	if(s == mcpgoal.mcpweapstate)
		return;
	
	mcpgoal.mcpweapstate = s;
	
	if(s == MCPGOALSTATE_RESET)
	{
		stuffsoundall(SND_FLAGEVENT,world);
		bprint(2, "\sthe flag has spawned!\s\n");
		mcpgoal.owner = mcpgm;
		mcp_SetModel(mcpgoal,MDL_MCPFLAG, DIM_FLAG);
		setorigin(mcpgoal, mcp_GetEntByClassname(CN_MCPFLAGSPAWN).origin + '0 0 64');
		mcpgoal.skin = MCPTEAM_NONE;
		mcpgoal.solid = SOLID_TRIGGER;
		mcpgoal.movetype = MOVETYPE_TOSS;
		mcpgoal.touch = touch_mcpflag;
		mcpgoal.effects = 0;
		mcpgoal.effects = mcpgoal.effects | EF_BRIGHTLIGHT;
		mcpgoal.effects = mcpgoal.effects | EF_DIMLIGHT;
		mcpgoal.effects = mcpgoal.effects | EF_GREEN;
		return;
	}
	if(s == MCPGOALSTATE_THROWN || s == MCPGOALSTATE_DROPPED)
	{
		if(e.team_no == MCPTEAM_BLUE)
		{
				stuffsoundall(SND_FLAGEVENT,world);
				mcpgoal.effects = 0;
				mcpgoal.effects = mcpgoal.effects | EF_BRIGHTLIGHT;
				mcpgoal.effects = mcpgoal.effects | EF_DIMLIGHT;
				mcpgoal.effects = mcpgoal.effects | EF_GREEN;
		}
		if(e.team_no == MCPTEAM_RED)
		{
				stuffsoundall(SND_FLAGEVENT,world);
				mcpgoal.effects = 0;
				mcpgoal.effects = mcpgoal.effects | EF_BRIGHTLIGHT;
				mcpgoal.effects = mcpgoal.effects | EF_DIMLIGHT;
				mcpgoal.effects = mcpgoal.effects | EF_GREEN;
		}
		if(s == MCPGOALSTATE_THROWN)
		{
			bprint(2, strcat(mcpgoal.owner.netname, " \shas thrown the flag!\s\n"));
			//AddStat(mcpgoal.owner, STAT_FLAGTHROW, 1);
		}
		if(s == MCPGOALSTATE_DROPPED)
		{
			bprint(2, strcat(mcpgoal.owner.netname, " \sdropped the flag!\s\n"));
			mcpgoal.origin = e.origin;
			mcpgoal.velocity_z = 300;
			mcpgoal.velocity_x = -100 + random() * 200;
			mcpgoal.velocity_y = -100 + random() * 200;
		}
		mcpgoal.owner.effects = 0;
		if(!(mcpgoal.owner.dimension_see & DIM_FLAG)  && mcpgoal.owner.FlashTime <= 0)
			mcpgoal.owner.dimension_see = mcpgoal.owner.dimension_see | DIM_FLAG;
		
		
		mcp_SetModel(mcpgoal,MDL_MCPFLAG, DIM_FLAG);
		mcpgoal.angles = '0 0 0';
		mcpgoal.owner = mcpgm;
		mcpgoal.skin = MCPTEAM_NONE;
		mcpgoal.solid = SOLID_TRIGGER;
		mcpgoal.movetype = MOVETYPE_TOSS;
		mcpgoal.touch = SUB_Null;
		mcpgoal.think = loose_mcpflag;	
		mcpgoal.nextthink = time + 1;
		mcpgoal.bubble_count = 0;
	}
	if(s == MCPGOALSTATE_CARRIED)
	{
		stuffsound(e, SND_YOUHAVEFLAG);

		if(e.team_no == MCPTEAM_BLUE)
		{

			stuffsoundteam (MCPTEAM_RED, SND_ENEMYHASFLAG,e);
			stuffsoundteam (MCPTEAM_BLUE, SND_TEAMHASFLAG,e);
			mcpgoal.effects = 0;
			mcpgoal.effects = mcpgoal.effects | EF_BRIGHTLIGHT;
			mcpgoal.effects = mcpgoal.effects | EF_DIMLIGHT;
			mcpgoal.effects = mcpgoal.effects | EF_BLUE;
		}
		if(e.team_no == TEAM_RED)
		{
			stuffsoundteam (MCPTEAM_RED, SND_TEAMHASFLAG,e);
			stuffsoundteam (MCPTEAM_BLUE, SND_ENEMYHASFLAG,e);
			mcpgoal.effects = 0;
			mcpgoal.effects = mcpgoal.effects | EF_BRIGHTLIGHT;
			mcpgoal.effects = mcpgoal.effects | EF_DIMLIGHT;
			mcpgoal.effects = mcpgoal.effects | EF_RED;
		}
		
		e.effects = 0;
		e.effects = e.effects | EF_BRIGHTLIGHT;
		bprint(2, strcat(e.netname, " \shas picked up the flag!\s\n"));
		
		//if(mcpgoal.owner.classname == "redcap" || mcpgoal.owner.classname == "bluecap")
		//	AddStat(o, STAT_FLAGSTEAL, 1);
		//else
		//	AddStat(o, STAT_FLAGTOUCH, 1);
		
		if(mcp_ContainsVisDimension(e,DIM_FLAG))
		{
			mcp_RemoveVisDimension(e, DIM_FLAG);
		}
			
		mcpgoal.owner = e;

		local vector org = e.origin + '-15 0 0';
		setorigin (mcpgoal, org);
		mcp_SetModel(mcpgoal,MDL_MCPFLAG, DIM_FLAG);
		mcpgoal.view_ofs = mcpgoal.origin - e.origin;
		e.items = e.items | IT_KEY1;
		mcpgoal.skin = MCPTEAM_NONE;
		
		mcpgoal.movetype = MOVETYPE_FOLLOW;
		mcpgoal.aiment = e;
		//mcpflag.solid = SOLID_NOT;
		mcpgoal.solid = SOLID_TRIGGER;
			
		mcpgoal.touch = SUB_Null;
		mcpgoal.think = carried_mcpflag;
		mcpgoal.nextthink = time + 2;
	}
	if(s == MCPGOALSTATE_CAPPED)
	{
		mcpgoal.owner.items = mcpgoal.owner.items - (mcpgoal.owner.items & IT_KEY1);
		
		if(e.team_no == MCPTEAM_BLUE)
		{
			mcpgoal.skin = MCPTEAM_BLUE;
			bprint(2, strcat(mcpgoal.owner.netname, " \scaptured the flag for blue!\s\n"));
			stuffsoundall(SND_BLUESCORES,world);
			
			mcpgoal.team_no = MCPTEAM_BLUE;
			mcpgoal.effects = 0;
			mcpgoal.effects = mcpgoal.effects | EF_BRIGHTLIGHT;
			mcpgoal.effects = mcpgoal.effects | EF_DIMLIGHT;
			mcpgoal.effects = mcpgoal.effects | EF_BLUE;
		}
		if(e.team_no == MCPTEAM_RED)
		{
			mcpgoal.skin = MCPTEAM_RED;
			bprint(2, strcat(mcpgoal.owner.netname, " \scaptured the flag for red!\s\n"));
			stuffsoundall(SND_REDSCORES,world);
			mcpgoal.team_no = MCPTEAM_RED;
			mcpgoal.effects = 0;
			mcpgoal.effects = mcpgoal.effects | EF_BRIGHTLIGHT;
			mcpgoal.effects = mcpgoal.effects | EF_DIMLIGHT;
			mcpgoal.effects = mcpgoal.effects | EF_RED;
		}
		mcpgoal.owner.effects = 0;
		//AddStat(mcpgoal.owner, STAT_FLAGCAP, 1);
		if(!(mcpgoal.owner.dimension_see & DIM_FLAG)  && mcpgoal.owner.FlashTime <= 0)
			mcpgoal.owner.dimension_see = mcpgoal.owner.dimension_see | DIM_FLAG;
		mcpgoal.owner = e;
		mcpgoal.angles = '0 0 0';
		mcp_SetModel(mcpgoal,MDL_MCPFLAG, DIM_FLAG);
		setorigin(mcpgoal,e.origin + '0 0 16');
		spawn_tfog(e.origin);	
		
		mcpgoal.movetype = MOVETYPE_NONE;
		mcpgoal.solid = SOLID_TRIGGER;
		
		mcpgoal.touch = touch_mcpflag;
		mcpgoal.think = capped_mcpflag;
		mcpgoal.nextthink = time + SACRIFICE_POINTINTERVAL;
	}
	
};

void touch_flagtrail() =
{
	if(other.classname == CN_PLAYER)
	{
		if(other.team_no != self.team_no)
		{
			if(time >= mcpgoal.heat)
			{
				mcp_Sound(self, CHAN_ITEM, SND_WAKA, 1, ATTN_NORM);
				mcpgoal.heat = time + 0.35;
				//AddStat(other, STAT_FLAGTRAILTOUCH, 1);
			}
			if(other.health < MCPROLEDICT[other.playerclass].maxhealth)
				other.health = other.health + 1;
			remove(self);
		}
	}
};

void think_flagtrailmaker() =
{
	self.nextthink = time + 0.15;
	
	if(mcpgoal.mcpweapstate != MCPGOALSTATE_CARRIED)
		return;
	
	if (fabs(mcpgoal.owner.velocity_x) <= 10 || fabs(mcpgoal.owner.velocity_y) <= 10)
		return;
		
	local entity trail = spawn();
	mcp_SetModel(trail, SPR_TRAIL, DIM_WORLD);
	setorigin (trail,mcpgoal.owner.origin);
	trail.movetype = MOVETYPE_NONE;
	trail.solid = SOLID_TRIGGER;
	
	trail.nextthink = time + 2;
	trail.think = SUB_Remove;
	trail.touch = touch_flagtrail;
	trail.classname = CN_FLAGTRAIL;
	trail.team_no = mcpgoal.owner.team_no;
	if(trail.team_no == TEAM_BLUE)
		trail.frame = 1;
	else
		trail.frame = 2;
	setsize (trail, '-8 -8 -8', '8 8 8');
};

void mcp_SpawnFlagTrailMaker() =
{
	if(find(world,classname,CN_FLAGTRAILMAKER) == world)
	{
		local entity te = spawn();
		te.classname = CN_FLAGTRAILMAKER;
		te.nextthink = time + 0.15;
		te.think = think_flagtrailmaker;
	}
};



void think_flagtimer() =
{
	self.nextthink = time + 0.1;
	if(time - mcpgoal.cnt > 10)
	{
		
	}
		
	
};


void mcp_CreateFlagTimers() =
{
	//at spawn point
	local entity flagspawntimer = spawn();
	flagspawntimer.think = think_flagtimer;
	flagspawntimer.classname = CN_FLAGTIMER;
	flagspawntimer.nextthink = time + 0.1;
	flagspawntimer.origin = mcp_GetEntByClassname(CN_MCPFLAGSPAWN).origin;
	
	//above flag if exist

	local entity flagtimer = spawn();
	flagtimer.think = think_flagtimer;
	flagtimer.classname = CN_FLAGTIMER;
	flagtimer.nextthink = time + 0.1;
	flagtimer.origin = mcpgoal.origin;
	
};

void touch_mcpcappoint() =
{
	if (other.classname != CN_PLAYER)
		return;	
		
	if(mcpmode != MCPMODE_SACRIFICE)
		return;
		
	if(mcpgoal.owner == other)
	{
		if(mcpgoal.owner.team_no == self.team_no)
		{
			mcp_ChangeMCPGoalState(MCPGOALSTATE_CAPPED, self);
		}
	}
};




void mcp_SetupSacCappoints() =
{

	local entity bspblue = mcp_GetEntByClassname(CN_INFOMCPBLUECAPTURE);
	local entity bspred = mcp_GetEntByClassname(CN_INFOMCPREDCAPTURE); 
	local entity bspflagspawn = mcp_GetEntByClassname(CN_INFOMCPFLAGSPAWN);
	if(bspblue != world)
	{
		local entity bluecp = spawn();
		bluecp.classname = CN_MCPBLUECAPTURE;
		bluecp.origin = bspblue.origin;
		bluecp.touch = touch_mcpcappoint;
		setsize (bluecp, '-16 -16 0', '16 16 64');     
		bluecp.team_no = MCPTEAM_BLUE;
		bluecp.movetype = MOVETYPE_BOUNCE;
		bluecp.solid = SOLID_TRIGGER;
		mcp_SetModel(bluecp, MDL_MCPCAPPOINT, DIM_WORLD);
		bluecp.skin = 1;
		
	}
	if(bspred != world)
	{
		local entity redcp = spawn();
		redcp.classname = CN_MCPREDCAPTURE;
		redcp.origin =  bspred.origin;
		redcp.touch = touch_mcpcappoint;
		setsize(redcp, '-16 -16 0', '16 16 64');
		redcp.team_no = MCPTEAM_RED;
		redcp.movetype = MOVETYPE_BOUNCE;
		redcp.solid = SOLID_TRIGGER;
		mcp_SetModel(redcp, MDL_MCPCAPPOINT, DIM_WORLD);
		redcp.skin = 2;
	}
	if(bspflagspawn != world)
	{
		local entity flagspawn = spawn();
		flagspawn.classname = CN_MCPFLAGSPAWN;
		flagspawn.origin = bspflagspawn.origin;
		setsize(flagspawn, '-16 -16 0', '16 16 64');
		flagspawn.team_no = MCPTEAM_NONE;
		flagspawn.movetype = MOVETYPE_BOUNCE;
		flagspawn.solid = SOLID_TRIGGER;
		mcp_SetModel(flagspawn, MDL_MCPCAPPOINT, DIM_WORLD);
		flagspawn.skin = 0;
	}

};

void mcpgmthink_awards_sac() =
{
	//not yet done
	self.nextthink = time + 1;
	if(self.bubble_count == 0)
	{
		mcp_ChangeMatchState(MATCHSTATE_AWARDS);
		
	}
	if(self.bubble_count == 1)
	{
		self.think = mcpgmthink_votemode;
		self.bubble_count = 0;
		return;
		
	}
	self.bubble_count++;
}

void mcpgmthink_result_sac() = 
{
	self.nextthink = time + 2;
	
	if(self.bubble_count == 1)
	{
		local float w = mcp_GetTeamPlacement(1);
		local string winner = "";
		if(w == MCPTEAM_BLUE)
			winner = strconv(1,2,2,"blue");
		if (w == MCPTEAM_RED)
			winner = strconv(1,2,2,"red");
		bprint(2, strcat(winner,"\s is the winner! \s\n"));
		stuffsoundteam(mcp_GetTeamPlacement(1), SND_YOUWIN, world);
		stuffsoundteam(mcp_GetTeamPlacement(0), SND_YOULOSE,world);
		self.nextthink = time + 1.5; //just for better sound flow
	}
	if(self.bubble_count == 2)
	{
		stuffsoundteam(mcp_GetTeamPlacement(1), SND_CLAP,world);
		stuffsoundteam(mcp_GetTeamPlacement(0), SND_BOO,world);	
	}
	if(self.bubble_count == 3)
	{
		if(redscore == 0 || bluescore == 0)
		{
			stuffsoundteam(mcp_GetTeamPlacement(1),SND_FLAWLESS,world);
			stuffsoundteam(mcp_GetTeamPlacement(0),SND_YOUSUCK,world);
		}
	}
	if(self.bubble_count >= 4)
	{
			self.nextthink = time + 1;
			self.think = mcpgmthink_awards_sac;
			self.bubble_count = 0;
			return;
	}	
	self.bubble_count++;
};

void mcpgmthink_live_sac() =
{
	self.nextthink = time + 1;
	
	if(self.bubble_count == 0)
	{
		mcp_ChangeMatchState(MATCHSTATE_LIVE);
		redscore = 0;
		bluescore = 0;
		mcp_SpawnMCPFlag();
		mcp_SpawnFlagTrailMaker();

	}
	if(redscore == SACRIFICE_WINTOTAL || bluescore == SACRIFICE_WINTOTAL)
	{
		stuffsoundall(SND_BUZZER,world);
		bprint(2,"\sthe match has finished!\s\n");
		self.think = mcpgmthink_result_sac;
		mcp_ChangeMatchState(MATCHSTATE_RESULT);
		cprintAll(CPRINT_RESULT);
		self.heat = time;
		self.bubble_count = 0;
		self.nextthink = time + 2;
		
	}
	self.bubble_count++;
};

