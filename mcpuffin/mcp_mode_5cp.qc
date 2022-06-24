void mcp_RemoveAllControlPointMarkers() = 
{
	local entity te = find(world,classname,CN_CONTROLPOINTMARKER);
	while(te)
	{
		if(te != world)
		{
			remove(te);
		}
		te = find(te,classname,CN_CONTROLPOINTMARKER);
	}
	

};

void mcp_RemoveAllProgressBars() =
{
	local entity te2 = find(world,classname,CN_PROGRESSBAR);
	while(te2)
	{
		if(te2 != world)
		{
			remove(te2);
		}
		te2 = find(te2,classname,CN_PROGRESSBAR);
	}	
};

void mcp_RemoveAllControlPointTrackers() = 
{
	local entity te = find(world,classname,CN_CONTROLPOINTTRACKER);
	while(te)
	{
		if(te != world)
		{
			remove(te);
		}
		te = find(te,classname,CN_CONTROLPOINTTRACKER);
	}
};

void think_controlpoint() = 
{
	self.nextthink = time + MCPCP_TICKRATE;
	
	if(matchstate != MATCHSTATE_LIVE)
		return;
	local float teaminfavour = MCPTEAM_NONE;
	local float reds = 0;
	local float blues = 0;
	local float diff = 0;
	local float progressmade = 0;
	local entity head = world;
	head = findradius(CONTROLPOINT[self.mcpgrentype].origin, CONTROLPOINT[self.mcpgrentype].radius);
	while (head)
	{
		if (head != world)
		{
			if (head.classname == CN_PLAYER && head.deadflag == DEAD_NO)
			{
				if(head.team_no == MCPTEAM_BLUE)
					blues++;
				if(head.team_no == MCPTEAM_RED)
					reds++;
			}
		}
		head = head.chain;
	}
	CONTROLPOINT[self.mcpgrentype].bluesonpoint = blues;
	CONTROLPOINT[self.mcpgrentype].redsonpoint = reds;
	if(reds > blues)
	{
		teaminfavour = MCPTEAM_RED;
		diff = reds - blues;
		progressmade = MCPCP_PROGRESSPERPLAYER * diff;
		if(self.team_no == MCPTEAM_RED)
		{
			if(CONTROLPOINT[self.mcpgrentype].redprogress == 0)
				bprint(2,strcat("the \sred team\s has started to capture ", CONTROLPOINT[self.mcpgrentype].namestring,"\n"));
				
			CONTROLPOINT[self.mcpgrentype].redprogress = CONTROLPOINT[self.mcpgrentype].redprogress + progressmade;
			if(CONTROLPOINT[self.mcpgrentype].redprogress >= CONTROLPOINT[self.mcpgrentype].progressneeded)
			{
				CONTROLPOINT[self.mcpgrentype].redprogress = CONTROLPOINT[self.mcpgrentype].progressneeded;
				mcp_ControlPointCaptured(self.mcpgrentype, MCPTEAM_RED);
			}
		}
		if(self.team_no == MCPTEAM_BLUE)
		{
			CONTROLPOINT[self.mcpgrentype].blueprogress = CONTROLPOINT[self.mcpgrentype].blueprogress - progressmade;
			if(CONTROLPOINT[self.mcpgrentype].blueprogress <= 0)
			{
				CONTROLPOINT[self.mcpgrentype].blueprogress = 0;
			}
		}
	}
	else if(blues > reds)
	{
		teaminfavour = MCPTEAM_BLUE;
		diff = blues - reds;
		progressmade = MCPCP_PROGRESSPERPLAYER * diff;
		if(self.team_no == MCPTEAM_BLUE)
		{
			if(CONTROLPOINT[self.mcpgrentype].blueprogress == 0)
				bprint(2,strcat("the \sblue team\s has started to capture ", CONTROLPOINT[self.mcpgrentype].namestring,"\n"));
				
			CONTROLPOINT[self.mcpgrentype].blueprogress = CONTROLPOINT[self.mcpgrentype].blueprogress + progressmade;
			if(CONTROLPOINT[self.mcpgrentype].blueprogress >= CONTROLPOINT[self.mcpgrentype].progressneeded)
			{
				CONTROLPOINT[self.mcpgrentype].blueprogress = CONTROLPOINT[self.mcpgrentype].progressneeded;
				mcp_ControlPointCaptured(self.mcpgrentype, MCPTEAM_BLUE);
			}
		}
		if(self.team_no == MCPTEAM_RED)
		{
			CONTROLPOINT[self.mcpgrentype].redprogress = CONTROLPOINT[self.mcpgrentype].redprogress - progressmade;
			if(CONTROLPOINT[self.mcpgrentype].redprogress <= 0)
			{
				CONTROLPOINT[self.mcpgrentype].redprogress = 0;
			}
		}
	}
	else
	{
		if(CONTROLPOINT[self.mcpgrentype].blueprogress > 0)
		{
			CONTROLPOINT[self.mcpgrentype].blueprogress = CONTROLPOINT[self.mcpgrentype].blueprogress - MCPCP_PROGRESSPERPLAYER;
			
			if(CONTROLPOINT[self.mcpgrentype].blueprogress <= 0)
				CONTROLPOINT[self.mcpgrentype].blueprogress = 0;
		}
		
		if(CONTROLPOINT[self.mcpgrentype].redprogress > 0)
		{
			CONTROLPOINT[self.mcpgrentype].redprogress = CONTROLPOINT[self.mcpgrentype].redprogress - MCPCP_PROGRESSPERPLAYER;
			
			if(CONTROLPOINT[self.mcpgrentype].redprogress <= 0)
				CONTROLPOINT[self.mcpgrentype].redprogress = 0;
		}		
	}
	
	if(self.team_no == MCPTEAM_BLUE && CONTROLPOINT[self.mcpgrentype].blueprogress <= 0 )
		return;
	if(self.team_no == MCPTEAM_RED && CONTROLPOINT[self.mcpgrentype].redprogress <= 0 )
		return;
	if(reds == blues)
		return;
	head = findradius(CONTROLPOINT[self.mcpgrentype].origin, CONTROLPOINT[self.mcpgrentype].radius);
	while (head)
	{
		if (head != world)
		{
			if (head.classname == CN_PLAYER && head.deadflag == DEAD_NO)
			{
			
				if(head.team_no == teaminfavour)
					stuffsound(head, SND_SCORETICKTEAM);
				else
					stuffsound(head, SND_SCORETICKENEMY);
			}
		}
		head = head.chain;
	}
};

void mcp_SpawnControlPointTracker(float cp, float objof) =
{
	local entity te = spawn();
	te.classname = CN_CONTROLPOINTTRACKER;
	te.mcpgrentype = cp;
	te.team_no = objof;
	te.think = think_controlpoint;
	te.nextthink = time;
};

void mcp_UnLockControlPoint(float cp) =
{
	CONTROLPOINT[cp].isunlocked = 1;
	if(CONTROLPOINT[cp].ownedbyteam == MCPTEAM_BLUE)
		mcp_SpawnControlPointTracker(cp, MCPTEAM_RED);
	else
		mcp_SpawnControlPointTracker(cp, MCPTEAM_BLUE);
};

void think_progressbar() =
{
	self.nextthink = time + 0.5;
	local float prog = 0;
	if(CONTROLPOINT[self.bubble_count].ownedbyteam == MCPTEAM_RED)
	{
		prog = (((CONTROLPOINT[self.bubble_count].blueprogress/CONTROLPOINT[self.bubble_count].progressneeded) * 100) / 10);
		prog = floor(prog);
		self.frame = prog + 11;
	}
	else if(CONTROLPOINT[self.bubble_count].ownedbyteam == MCPTEAM_BLUE)
	{
		prog = (((CONTROLPOINT[self.bubble_count].redprogress/CONTROLPOINT[self.bubble_count].progressneeded) * 100) / 10);
		prog = floor(prog);
		self.frame = prog + 22;
	}
	else
	{
		if(CONTROLPOINT[self.bubble_count].redprogress > 0)
		{
			prog = (((CONTROLPOINT[self.bubble_count].redprogress/CONTROLPOINT[self.bubble_count].progressneeded) * 100) / 10);
			prog = floor(prog);
			self.frame = prog + 22;
		}
		else if (CONTROLPOINT[self.bubble_count].blueprogress > 0)
		{
			prog = (((CONTROLPOINT[self.bubble_count].blueprogress/CONTROLPOINT[self.bubble_count].progressneeded) * 100) / 10);
			prog = floor(prog);
			self.frame = prog + 11;
		}
		else
		{
			self.frame = 0;
		}
	}
};
void mcp_MarkControlPoint(float cp) =
{
	//mcp_spr_cp.spr
	//frames : 0 = whitelock, 1 = whiteshield, 2 = whitesword, 3 = bluelock, 4 = blueshield, 5 = bluesword, 6 = redlock. 7 = redshield, 8 = redsword
	
	if(CONTROLPOINT[cp].isunlocked)
	{
		local entity prog = spawn();
		prog.classname = CN_PROGRESSBAR;
		setorigin(prog,CONTROLPOINT[cp].origin + '0 0 48');
		mcp_SetModel(prog, SPR_PROGRESSBAR, DIM_WORLD);
		prog.nextthink = time + 0.5;
		prog.think = think_progressbar;
		prog.bubble_count = cp;
		
		local entity markb = spawn();
		markb.classname = CN_CONTROLPOINTMARKER;
		setorigin(markb,CONTROLPOINT[cp].origin + '0 0 48');
		mcp_SetModel(markb, SPR_CPMARKER, DIM_BLUETEAM);
		
		local entity markr = spawn();
		markr.classname = CN_CONTROLPOINTMARKER;
		setorigin(markr,CONTROLPOINT[cp].origin + '0 0 48');
		mcp_SetModel(markr, SPR_CPMARKER, DIM_REDTEAM);
		
		if(CONTROLPOINT[cp].ownedbyteam == MCPTEAM_BLUE)
		{
			markb.frame = 4;
			markr.frame = 8;
		}
		else if (CONTROLPOINT[cp].ownedbyteam == MCPTEAM_RED)
		{
			markb.frame = 5;
			markr.frame = 7;
		}
		else
		{
			markb.frame = 5;
			markr.frame = 8;
		}
	}
	else
	{
		local entity mark = spawn();
		mark.classname = CN_CONTROLPOINTMARKER;
		setorigin(mark,CONTROLPOINT[cp].origin + '0 0 48');
		mcp_SetModel(mark, SPR_CPMARKER, DIM_WORLD);
		if(CONTROLPOINT[cp].ownedbyteam == MCPTEAM_BLUE)
			mark.frame = 3;
		else
			mark.frame = 6;
	}
};

void mcp_LockControlPoint(float cp) =
{
	CONTROLPOINT[cp].bluesonpoint = 0;
	CONTROLPOINT[cp].redsonpoint = 0;
	CONTROLPOINT[cp].isunlocked = 0;
	
};

void mcp_ControlPointCaptured(float cp, float byteam) =
{
	CONTROLPOINT[cp].ownedbyteam = byteam;
	if(byteam == MCPTEAM_RED)
	{
		bprint(2,strcat("the \sred team\s has captured ",CONTROLPOINT[cp].namestring,"\n"));
		redscore++;
		bluescore--;
		stuffsoundall(SND_REDSCORES, world);
	}
	if(byteam == MCPTEAM_BLUE)
	{
		bprint(2,strcat("the \sblue team\s has captured ",CONTROLPOINT[cp].namestring,"\n"));
		bluescore++;
		redscore--;
		stuffsoundall(SND_BLUESCORES, world);
	}
	
	
	mcp_RemoveAllControlPointTrackers();
	mcp_RemoveAllControlPointMarkers();
	mcp_RemoveAllProgressBars();
	
	mcp_LockControlPoint(MCPCP_BLUE1);
	mcp_LockControlPoint(MCPCP_BLUE2);
	mcp_LockControlPoint(MCPCP_MID);
	mcp_LockControlPoint(MCPCP_RED2);
	mcp_LockControlPoint(MCPCP_RED1);
	
	CONTROLPOINT[MCPCP_BLUE1].redprogress = 0;
	CONTROLPOINT[MCPCP_BLUE1].blueprogress = 0;
	CONTROLPOINT[MCPCP_BLUE2].redprogress = 0;
	CONTROLPOINT[MCPCP_BLUE2].blueprogress = 0;
	CONTROLPOINT[MCPCP_MID].redprogress = 0;
	CONTROLPOINT[MCPCP_MID].blueprogress = 0;
	CONTROLPOINT[MCPCP_RED2].redprogress = 0;
	CONTROLPOINT[MCPCP_RED2].blueprogress = 0;
	CONTROLPOINT[MCPCP_RED1].redprogress = 0;
	CONTROLPOINT[MCPCP_RED1].blueprogress = 0;
	
	if(cp == MCPCP_BLUE2)
	{
		mcp_UnLockControlPoint(MCPCP_BLUE2);
		
		if(byteam == MCPTEAM_BLUE)
		{
			mcp_UnLockControlPoint(MCPCP_MID);
			
			bluedefcp = MCPCP_BLUE2;
			blueattcp = MCPCP_MID;
			reddefcp = MCPCP_MID;
			redattcp = MCPCP_BLUE2;
		}
			
		if(byteam == MCPTEAM_RED)
		{
			mcp_UnLockControlPoint(MCPCP_BLUE1);
			
			bluedefcp = MCPCP_BLUE1;
			blueattcp = MCPCP_BLUE2;
			reddefcp = MCPCP_BLUE2;
			redattcp = MCPCP_BLUE1;
		}
	}
	
	if(cp == MCPCP_MID)
	{
		mcp_UnLockControlPoint(MCPCP_MID);
		
		if(byteam == MCPTEAM_BLUE)
		{
			mcp_UnLockControlPoint(MCPCP_RED2);
			
			bluedefcp = MCPCP_MID;
			blueattcp = MCPCP_RED2;
			reddefcp = MCPCP_RED2;
			redattcp = MCPCP_MID;
		}
			
		if(byteam == MCPTEAM_RED)
		{
			mcp_UnLockControlPoint(MCPCP_BLUE2);
			
			bluedefcp = MCPCP_BLUE2;
			blueattcp = MCPCP_MID;
			reddefcp = MCPCP_MID;
			redattcp = MCPCP_BLUE2;
		}
	}
	
	if(cp == MCPCP_RED2)
	{
		mcp_UnLockControlPoint(MCPCP_RED2);
		
		if(byteam == MCPTEAM_BLUE)
		{
			mcp_UnLockControlPoint(MCPCP_RED1);
			
			bluedefcp = MCPCP_RED2;
			blueattcp = MCPCP_RED1;
			reddefcp = MCPCP_RED1;
			redattcp = MCPCP_RED2;
		}

		if(byteam == MCPTEAM_RED)
		{
			mcp_UnLockControlPoint(MCPCP_MID);
			
			bluedefcp = MCPCP_MID;
			blueattcp = MCPCP_RED2;
			reddefcp = MCPCP_RED2;
			redattcp = MCPCP_MID;
		}
	}
	
	mcp_MarkControlPoint(MCPCP_BLUE1);
	mcp_MarkControlPoint(MCPCP_BLUE2);
	mcp_MarkControlPoint(MCPCP_MID);
	mcp_MarkControlPoint(MCPCP_RED2);
	mcp_MarkControlPoint(MCPCP_RED1);
};

void think_midcontrol() =
{	
	self.nextthink = time + MCPCP_TICKRATE;
	if(matchstate != MATCHSTATE_LIVE)
		return;
	local float teaminfavour = MCPTEAM_NONE;
	local float reds = 0;
	local float blues = 0;
	local float diff = 0;
	local float progressmade = 0;
	local entity head = world;
	head = findradius(CONTROLPOINT[MCPCP_MID].origin, CONTROLPOINT[MCPCP_MID].radius);
	while (head)
	{
		if (head != world)
		{
			if (head.classname == CN_PLAYER && head.deadflag == DEAD_NO)
			{
				if(head.team_no == MCPTEAM_BLUE)
					blues++;
				if(head.team_no == MCPTEAM_RED)
					reds++;
			}
		}
		head = head.chain;
	}
	CONTROLPOINT[MCPCP_MID].bluesonpoint = blues;
	CONTROLPOINT[MCPCP_MID].redsonpoint = reds;
	if(reds > blues)
	{
		teaminfavour = MCPTEAM_RED;
		diff = reds - blues;
		progressmade = MCPCP_PROGRESSPERPLAYER * diff;
		if(CONTROLPOINT[MCPCP_MID].blueprogress > 0)
		{
			CONTROLPOINT[MCPCP_MID].blueprogress = CONTROLPOINT[MCPCP_MID].blueprogress - progressmade;
			
			if(CONTROLPOINT[MCPCP_MID].blueprogress <= 0)
			{
				CONTROLPOINT[MCPCP_MID].blueprogress = 0;
			}
		}
		else
		{
			CONTROLPOINT[MCPCP_MID].redprogress = CONTROLPOINT[MCPCP_MID].redprogress + progressmade;
			
			if(CONTROLPOINT[MCPCP_MID].redprogress >= CONTROLPOINT[MCPCP_MID].progressneeded)
			{
				CONTROLPOINT[MCPCP_MID].redprogress = CONTROLPOINT[MCPCP_MID].progressneeded;
				mcp_ControlPointCaptured(MCPCP_MID, MCPTEAM_RED);
				bluescore++; //doing this just to take away a point
			}
		}
	}
	else if (blues > reds)
	{
		teaminfavour = MCPTEAM_BLUE;
		diff = blues - reds;
		progressmade = MCPCP_PROGRESSPERPLAYER * diff;
		if(CONTROLPOINT[MCPCP_MID].redprogress > 0)
		{
			CONTROLPOINT[MCPCP_MID].redprogress = CONTROLPOINT[MCPCP_MID].redprogress - progressmade;
			
			if(CONTROLPOINT[MCPCP_MID].redprogress <= 0)
			{
				CONTROLPOINT[MCPCP_MID].redprogress = 0;
			}
		}
		else
		{
			CONTROLPOINT[MCPCP_MID].blueprogress = CONTROLPOINT[MCPCP_MID].blueprogress + progressmade;
			
			if(CONTROLPOINT[MCPCP_MID].blueprogress >= CONTROLPOINT[MCPCP_MID].progressneeded)
			{
				CONTROLPOINT[MCPCP_MID].blueprogress = CONTROLPOINT[MCPCP_MID].progressneeded;
				mcp_ControlPointCaptured(MCPCP_MID, MCPTEAM_BLUE);
				redscore++; //doing this just to take away a point
			}
		}
	}
	else
	{
		if(CONTROLPOINT[MCPCP_MID].blueprogress > 0)
		{
			CONTROLPOINT[MCPCP_MID].blueprogress = CONTROLPOINT[MCPCP_MID].blueprogress - MCPCP_PROGRESSPERPLAYER;
			
			if(CONTROLPOINT[MCPCP_MID].blueprogress <= 0)
				CONTROLPOINT[MCPCP_MID].blueprogress = 0;
		}
		
		if(CONTROLPOINT[MCPCP_MID].redprogress > 0)
		{
			CONTROLPOINT[MCPCP_MID].redprogress = CONTROLPOINT[MCPCP_MID].redprogress - MCPCP_PROGRESSPERPLAYER;
			
			if(CONTROLPOINT[MCPCP_MID].redprogress <= 0)
				CONTROLPOINT[MCPCP_MID].redprogress = 0;
		}
	}
	
	if(progressmade <= 0)
		return;
		
	head = findradius(CONTROLPOINT[MCPCP_MID].origin, CONTROLPOINT[MCPCP_MID].radius);
	while (head)
	{
		if (head != world)
		{
			if (head.classname == CN_PLAYER && head.deadflag == DEAD_NO)
			{
			
				if(head.team_no == teaminfavour)
					stuffsound(head, SND_SCORETICKTEAM);
				else
					stuffsound(head, SND_SCORETICKENEMY);
			}
		}
		head = head.chain;
	}
};

void mcp_SpawnMidControlPoint() =
{
	local entity te = spawn();
	te.nextthink = time + MCPCP_TICKRATE;
	te.classname = CN_CONTROLPOINTTRACKER;
	te.think = think_midcontrol;
	
};
void mcpgmthink_awards_5cp() =
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

void mcpgmthink_result_5cp() = 
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
			self.think = mcpgmthink_awards_5cp;
			self.bubble_count = 0;
			return;
	}	
	self.bubble_count++;
};

void mcpgmthink_live_5cp() =
{
	self.nextthink = time + 1;
	
	if(self.bubble_count == 0)
	{
		mcp_ChangeMatchState(MATCHSTATE_LIVE);
		redscore = 2;
		bluescore = 2;
	}
	if(CONTROLPOINT[MCPCP_RED1].ownedbyteam == MCPTEAM_BLUE || CONTROLPOINT[MCPCP_BLUE1].ownedbyteam == MCPTEAM_RED)
	{
		stuffsoundall(SND_BUZZER,world);
		bprint(2,"\sthe match has finished!\s\n");
		self.think = mcpgmthink_result_5cp;
		mcp_ChangeMatchState(MATCHSTATE_RESULT);
		cprintAll(CPRINT_RESULT);
		self.heat = time;
		self.bubble_count = 0;
		self.nextthink = time + 2;
		
	}
	self.bubble_count++;
};

void mcp_SetupControlPoints() =
{
	if(mcpmode != MCPMODE_5CP)
		return;
		
	local entity cp1 = find(world, classname, CN_CP1);
	local entity cp2 = find(world, classname, CN_CP2);
	local entity cp3 = find(world, classname, CN_CP3);
	local entity cp4 = find(world, classname, CN_CP4);
	local entity cp5 = find(world, classname, CN_CP5);
	
	

	
	if(cp1.count != 0)
		CONTROLPOINT[MCPCP_BLUE1].radius =cp1.count;
	else
		CONTROLPOINT[MCPCP_BLUE1].radius = MCPCP_CPDEFAULTRADIUS;
		
	if(cp2.count != 0)
		CONTROLPOINT[MCPCP_BLUE2].radius =cp2.count;
	else
		CONTROLPOINT[MCPCP_BLUE2].radius = MCPCP_CPDEFAULTRADIUS;
		
	if(cp3.count != 0)
		CONTROLPOINT[MCPCP_MID].radius =cp3.count;
	else
		CONTROLPOINT[MCPCP_MID].radius = MCPCP_CPDEFAULTRADIUS;
		
	if(cp4.count != 0)
		CONTROLPOINT[MCPCP_RED2].radius =cp4.count;
	else
		CONTROLPOINT[MCPCP_RED2].radius = MCPCP_CPDEFAULTRADIUS;
		
	if(cp5.count != 0)
		CONTROLPOINT[MCPCP_RED1].radius =cp5.count;
	else
		CONTROLPOINT[MCPCP_RED1].radius = MCPCP_CPDEFAULTRADIUS;
	
	CONTROLPOINT[MCPCP_BLUE1].namestring = "b\x85main";
	CONTROLPOINT[MCPCP_BLUE2].namestring = "b\x85cp2 ";
	CONTROLPOINT[MCPCP_MID].namestring   = "middle";
	CONTROLPOINT[MCPCP_RED2].namestring  = "r\x85cp2 ";
	CONTROLPOINT[MCPCP_RED1].namestring  = "r\x85main";

	
	CONTROLPOINT[MCPCP_BLUE1].ownedbyteam = MCPTEAM_BLUE;
	CONTROLPOINT[MCPCP_BLUE2].ownedbyteam = MCPTEAM_BLUE;
	CONTROLPOINT[MCPCP_MID].ownedbyteam = MCPTEAM_NONE;
	CONTROLPOINT[MCPCP_RED2].ownedbyteam = MCPTEAM_RED;
	CONTROLPOINT[MCPCP_RED1].ownedbyteam = MCPTEAM_RED;
	
	CONTROLPOINT[MCPCP_BLUE1].progressneeded = MCPCP_PROGRESSNEEDED_MAIN;
	CONTROLPOINT[MCPCP_BLUE2].progressneeded = MCPCP_PROGRESSNEEDED_NORMAL;
	CONTROLPOINT[MCPCP_MID].progressneeded = MCPCP_PROGRESSNEEDED_NORMAL;
	CONTROLPOINT[MCPCP_RED2].progressneeded = MCPCP_PROGRESSNEEDED_NORMAL;
	CONTROLPOINT[MCPCP_RED1].progressneeded = MCPCP_PROGRESSNEEDED_MAIN;
	
	CONTROLPOINT[MCPCP_BLUE1].origin = cp1.origin;
	CONTROLPOINT[MCPCP_BLUE2].origin = cp2.origin;
	CONTROLPOINT[MCPCP_MID].origin = cp3.origin;
	CONTROLPOINT[MCPCP_RED2].origin = cp4.origin;
	CONTROLPOINT[MCPCP_RED1].origin = cp5.origin;
	
	mcp_LockControlPoint(MCPCP_BLUE1);
	mcp_LockControlPoint(MCPCP_BLUE2);
	CONTROLPOINT[MCPCP_MID].isunlocked = 1;
	mcp_SpawnMidControlPoint();
	mcp_LockControlPoint(MCPCP_RED2);
	mcp_LockControlPoint(MCPCP_RED1);
	
	mcp_MarkControlPoint(MCPCP_BLUE1);
	mcp_MarkControlPoint(MCPCP_BLUE2);
	mcp_MarkControlPoint(MCPCP_MID);
	mcp_MarkControlPoint(MCPCP_RED2);
	mcp_MarkControlPoint(MCPCP_RED1);
	bluedefcp = MCPCP_MID;
	blueattcp = MCPCP_MID;
	reddefcp = MCPCP_MID;
	redattcp = MCPCP_MID;
};

float mcp_isMap5cpViable() =
{
	
	local entity cp1 = find(world, classname, CN_CP1);
	local entity cp2 = find(world, classname, CN_CP2);
	local entity cp3 = find(world, classname, CN_CP3);
	local entity cp4 = find(world, classname, CN_CP4);
	local entity cp5 = find(world, classname, CN_CP5);
	
	if(cp1 != world && cp2 != world && cp3 != world && cp4 != world  && cp5 != world )
		return 1;
	return 0;
};

void() info_mcp_cp1 =
{
	self.classname = CN_CP1;
};

void() info_mcp_cp2 =
{
	self.classname = CN_CP2;
	
};
void() info_mcp_cp3 =
{
	self.classname = CN_CP3;
};
void() info_mcp_cp4 =
{
	self.classname = CN_CP4;

};
void() info_mcp_cp5 =
{
	self.classname = CN_CP5;
};

void () info_player_redspawn_cp1 =
{
	self.classname = CN_RSPAWN_CP1;
};
void () info_player_redspawn_cp2 =
{
	self.classname = CN_RSPAWN_CP2;
};
void () info_player_bluespawn_cp4 =
{
	self.classname = CN_BSPAWN_CP4;
};
void () info_player_bluespawn_cp5 =
{
	self.classname = CN_BSPAWN_CP5;
};