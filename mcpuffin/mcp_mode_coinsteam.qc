float mcp_CoinLeader() =
{
	if(bluescore > redscore)
		return MCPTEAM_BLUE;
	if(redscore > bluescore)
		return MCPTEAM_RED;
	
	return MCPTEAM_NONE;	
};

void mcp_ModifyTeamCoinCount(float t, float amnt) =
{
	local float oldleader = mcp_CoinLeader();
	
	if(t == MCPTEAM_BLUE)
		bluescore = bluescore + amnt;
	if(t == MCPTEAM_RED)
		redscore = redscore + amnt;
		
	local float newleader = mcp_CoinLeader();
	if(oldleader != newleader)
	{
		if(newleader == MCPTEAM_RED)
			stuffsoundall(SND_REDLEADS, world);
		if(newleader == MCPTEAM_BLUE)
			stuffsoundall(SND_BLUELEADS, world);
		if(newleader == MCPTEAM_NONE)
			stuffsoundall(SND_TEAMSTIED, world);
	} 		
	
};
void remove_mcpcoin() =
{
	mcp_Sound(self, CHAN_AUTO, SND_COINPOP, 1, ATTN_NORM);
	remove(self);
};
void touch_mcpcoin() =
{
	if(time < self.bubble_count) //initial drop grace period
		return;

	if(other.deadflag != DEAD_NO)
		return;
		
	if(other.classname == CN_PLAYER)
	{
		local float oldleader = mcp_CoinLeader();
			
		other.frags = other.frags + self.cnt;
		mcp_Sound(self, CHAN_AUTO, SND_COINPICKUP, 1, ATTN_NORM);
		if(self.cnt == 1)
			stuffnotice(other,strcat("you have picked up ",ftos(self.cnt)," coin!"));
		else
			stuffnotice(other,strcat("you have picked up ",ftos(self.cnt)," coins!"));
		if(mcpmode == MCPMODE_COINSFFA)
		{
			if(mcpgoal.classname == CN_PLAYER)
			{
				if(mcpgoal != other)
				{
					if(other.frags > mcpgoal.frags)
					{
						bprint(2, strcat(other.netname, " has taken the lead (", ftos(other.frags),")\n"));
						stuffsound(other, SND_TAKENLEAD);
						stuffsound(mcpgoal, SND_LOSTLEAD);
						mcpgoal = other;
					}
				}
			}
			else
			{
				bprint(2, strcat(other.netname, " has taken the lead (", ftos(other.frags),")\n"));
				stuffsound(other, SND_TAKENLEAD);
				mcpgoal = other;
			}
		}
		if(other.team_no == MCPTEAM_RED)
			mcp_ModifyTeamCoinCount(MCPTEAM_RED, self.cnt);
			
		if(other.team_no == MCPTEAM_BLUE)
			mcp_ModifyTeamCoinCount(MCPTEAM_BLUE, self.cnt);
			
		remove(self);
	}	
	
};

void mcp_SpawnCoin(entity e, float amnt) =
{
	//0 def, 1 drak silv, 2 drak gold, 3 lordy silv, 4 lordy gold, 5 zel silv, 6 zel gold, 7 zut silv, 8 zut gold
	local entity coin = spawn();
	coin.origin = e.origin - '0 0 24';
	coin.velocity_z = 300;
	coin.velocity_x = -100 + random() * 200;
	coin.velocity_y = -100 + random() * 200;
	coin.solid = SOLID_TRIGGER;
	coin.movetype = MOVETYPE_TOSS;
	mcp_SetModel(coin, MDL_MCPCOIN, DIM_WORLD);
	local float rng = RNG(4);
	if(rng == 1)
	{
		if(amnt == 10)
			coin.skin = 2;
		else
			coin.skin = 1;
			
	}
	if(rng == 2)
	{
		if(amnt == 10)
			coin.skin = 4;
		else
			coin.skin = 3;
			
	}
	if(rng == 3)
	{
		if(amnt == 10)
			coin.skin = 6;
		else
			coin.skin = 5;
			
	}
	if(rng == 4)
	{
		if(amnt == 10)
			coin.skin = 8;
		else
			coin.skin = 7;
			
	}

	setsize(coin, '-16 -16 0', '16 16 56');
	coin.touch = touch_mcpcoin;
	coin.classname = CN_MCPCOIN;
	coin.cnt = amnt;
	coin.bubble_count = time + COINS_GRACEPERIOD;
	coin.nextthink = time + COINS_DURATION + random();
	coin.think = remove_mcpcoin;
};
entity mcp_FFACoinLeader() =
{
	local entity leadr = world;
	local entity te = find(world, classname, CN_PLAYER);
	while (te) 
	{
		if (leadr == world) 
		{
			leadr = te;
		}
		else
		{
			if(te.frags > leadr.frags)
				leadr = te;
		}
		te = find(te, classname, CN_PLAYER);
	}
	return leadr;
}
void mcp_DropCoins(entity e, float entirety) =
{
	if(mcpmode != MCPMODE_COINSTEAM && mcpmode != MCPMODE_COINSFFA)
		return;
	if(matchstate != MATCHSTATE_LIVE)
		return;
	local float coinloss;
	
	if(entirety)
		coinloss = e.frags;
	else
		coinloss = rint(e.frags / 2);
		
	e.frags = e.frags - coinloss;
	
	if(e.team_no == MCPTEAM_RED)
		mcp_ModifyTeamCoinCount(MCPTEAM_RED, (coinloss*-1));
	if(e.team_no == MCPTEAM_BLUE)
		mcp_ModifyTeamCoinCount(MCPTEAM_BLUE, (coinloss*-1));
	
	coinloss++;	//add a coin for death
	local string postfix = " coins!";
	if(coinloss == 1)
		postfix = " coin!";
	bprint(2, strcat(e.netname, " dropped ",ftos(coinloss),postfix,"\n"));
	while(coinloss > 9)
	{
		mcp_SpawnCoin(e, 10);
		coinloss = coinloss - 10;
	}
	while(coinloss > 0)
	{
		mcp_SpawnCoin(e,1);
		coinloss--;
	}
	mcp_Sound(e, CHAN_AUTO, SND_COINDROP, 1, ATTN_NORM);
	
	if(mcpmode == MCPMODE_COINSFFA && mcpgoal == e)
	{
		local entity leadr = mcp_FFACoinLeader();
		if(leadr != e)
		{
			bprint(2,strcat(e.netname, " has lost the lead to ",leadr.netname,"\n"));
			stuffsound(e, SND_LOSTLEAD);
			stuffsound(leadr, SND_TAKENLEAD);
			mcpgoal = leadr;
		}
	}
	
};


void mcpgmthink_awards_coinsteam() =
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

void mcpgmthink_result_coinsteam() = 
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
			self.think = mcpgmthink_awards_coinsteam;
			self.bubble_count = 0;
			return;
	}	
	self.bubble_count++;
};

void mcpgmthink_live_coinsteam() =
{
	self.nextthink = time + 1;
	
	if(self.bubble_count == 0)
	{
		
		mcp_ChangeMatchState(MATCHSTATE_LIVE);
		redscore = 0;
		bluescore = 0;
	}
	if(redscore >= victorytotal || bluescore >= victorytotal)
	{
		stuffsoundall(SND_BUZZER,world);
		bprint(2,"\sthe match has finished!\s\n");
		self.think = mcpgmthink_result_coinsteam;
		mcp_ChangeMatchState(MATCHSTATE_RESULT);
		cprintAll(CPRINT_RESULT);
		self.heat = time;
		self.bubble_count = 0;
		self.nextthink = time + 2;
		
	}
	self.bubble_count++;
};





