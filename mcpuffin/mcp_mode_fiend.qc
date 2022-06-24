

void mcp_HealFiend(entity e) =
{
	e.health = MCPROLEDICT[ROLE_FIEND].maxhealth;
	mcp_Sound(e, CHAN_AUTO, SND_R_ITEM2, 1, ATTN_NORM);	
};

void mcpgmthink_awards_fiend() =
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

void mcpgmthink_result_fiend() = 
{
	self.nextthink = time + 2;
	local float w;
	local float l;
	if(redscore > bluescore)
	{
		w = MCPTEAM_RED;
		l = MCPTEAM_BLUE;
	}
	else
	{
		w = MCPTEAM_BLUE;
		l = MCPTEAM_RED;
	}
	
	if(self.bubble_count == 1)
	{	
		local string winner = "";
		if(w == MCPTEAM_BLUE)
			winner = strconv(1,2,2,"blue");
		if (w == MCPTEAM_RED)
			winner = strconv(1,2,2,"red");
		bprint(2, strcat(winner,"\s is the winner! \s\n"));
		stuffsoundteam(w, SND_YOUWIN, world);
		stuffsoundteam(l, SND_YOULOSE,world);
		self.nextthink = time + 1.5; //just for better sound flow
	}
	if(self.bubble_count == 2)
	{
		stuffsoundteam(w, SND_CLAP,world);
		stuffsoundteam(l, SND_BOO,world);	
	}
	if(self.bubble_count == 3)
	{
		if(redscore == 0 || bluescore == 0)
		{
			stuffsoundteam(w,SND_FLAWLESS,world);
			stuffsoundteam(l,SND_YOUSUCK,world);
		}
	}
	if(self.bubble_count >= 4)
	{
			self.nextthink = time + 1;
			self.think = mcpgmthink_awards_fiend;
			self.bubble_count = 0;
			return;
	}	
	self.bubble_count++;
};

void mcpgmthink_live_fiend() =
{
	self.nextthink = time + 1;
	
	if(self.bubble_count == 0)
	{
		mcp_ChangeMatchState(MATCHSTATE_LIVE);
		redscore = 0;
		bluescore = 0;
	}
	if(redscore == victorytotal || bluescore == victorytotal)
	{
		stuffsoundall(SND_BUZZER,world);
		bprint(2,"\sthe match has finished!\s\n");
		self.think = mcpgmthink_result_fiend;
		mcp_ChangeMatchState(MATCHSTATE_RESULT);
		cprintAll(CPRINT_RESULT);
		self.heat = time;
		self.bubble_count = 0;
		self.nextthink = time + 2;
		
	}
	self.bubble_count++;
};

void mcp_SpawnMCPGM_MCP() =
{

};

