void mcpgmthink_awards_coinsffa() =
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

void mcpgmthink_result_coinsffa() = 
{
	self.nextthink = time + 2;
	
	if(self.bubble_count == 1)
	{
		if(mcpgoal.classname == CN_PLAYER)
		{
			bprint(2, strcat(mcpgoal.netname,"\s is the winner! \s\n"));
			stuffsound(mcpgoal, SND_YOUWIN);
			stuffsoundall(SND_YOULOSE,mcpgoal);
		}
		else
		{
			bprint(2, strcat("\snoone wins?\s\n"));	
		}
		self.nextthink = time + 1.5; //just for better sound flow
	}
	if(self.bubble_count == 2)
	{
		if(mcpgoal.classname == CN_PLAYER)
		{
			stuffsound(mcpgoal, SND_CLAP);
			stuffsoundall(SND_BOO, mcpgoal);
		}	
	}
	if(self.bubble_count == 3)
	{
		
	}
	if(self.bubble_count >= 4)
	{
			self.nextthink = time + 1;
			self.think = mcpgmthink_awards_coinsffa;
			self.bubble_count = 0;
			return;
	}	
	self.bubble_count++;
};

void mcpgmthink_live_coinsffa() =
{
	self.nextthink = time + 1;
	
	if(self.bubble_count == 0)
	{
		
		mcp_ChangeMatchState(MATCHSTATE_LIVE);
		redscore = 0;
		bluescore = 0;
	}
	if(mcpgoal.classname == CN_PLAYER && mcpgoal.frags >= victorytotal)
	{
		stuffsoundall(SND_BUZZER,world);
		bprint(2,"\sthe match has finished!\s\n");
		self.think = mcpgmthink_result_coinsffa;
		mcp_ChangeMatchState(MATCHSTATE_RESULT);
		cprintAll(CPRINT_RESULT);
		self.heat = time;
		self.bubble_count = 0;
		self.nextthink = time + 2;
		
	}
	self.bubble_count++;
};





