

void mcpgmthink_awards_baby() =
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

void mcpgmthink_result_baby() =
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

	}
	if(self.bubble_count >= 4)
	{
			self.nextthink = time + 1;
			self.think = mcpgmthink_awards_baby;
			self.bubble_count = 0;
			return;
	}	
	self.bubble_count++;
};

void mcpgmthink_live_baby() =
{
	self.nextthink = time + 1;

	if(self.bubble_count == 0)
	{
		mcp_ChangeMatchState(MATCHSTATE_LIVE);
		self.bubble_count++;
		bluescore = 0;
		redscore = 0;
		return;
	}
	if(redscore >= victorytotal || bluescore >= victorytotal)
	{
		stuffsoundall(SND_BUZZER,world);
		bprint(2,"\sthe match has finished!\s\n");
		self.think = mcpgmthink_result_baby;
		mcp_ChangeMatchState(MATCHSTATE_RESULT);
		cprintAll(CPRINT_RESULT);
		self.heat = time;
		self.bubble_count = 0;
		self.nextthink = time + 2;
		
	}
	
};

