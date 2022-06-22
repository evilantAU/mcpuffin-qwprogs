void think_cprint () = 
{
	self.nextthink = time + CPRINT_TICKRATE;
	centerprint(self.owner, GetCprintString(self.owner, self.cnt));
};

void cprint(entity e, float type) =
{
	if(type == CPRINT_REMOVE)
	{
		if(e.cprinter != world)
		{
			e.cprinter.think = SUB_Remove;
			e.cprinter.nextthink = time;
		}
		return;
	}
	if(e.cprinter == world)
	{
		local entity te = spawn();
		te.classname = CN_CPRINTER;
		te.owner = e;
		te.cnt = type;
		te.think = think_cprint;
		te.nextthink = time + CPRINT_TICKRATE;
		e.cprinter = te;
	}
	else
	{
		e.cprinter.cnt = type;
	}
};

string GetMCPObjectiveString(float linenum) =
{
	if(mcpmode == MCPMODE_MCPUFFIN)
	{
		if(linenum == 1)
			return "two teams fight for control of a flag.";
		if(linenum == 2)
			return "capture and defend the flag in your base";
		if(linenum == 3)
			return "to generate points for your team.";
		if(linenum == 4)
			return "first team to reach 100 wins the match.";
	}
	if(mcpmode == MCPMODE_FIEND)
	{
		if(linenum == 1)
			return "obtain the soul to become human again.";
		if(linenum == 2)
			return "survive as long as you can as a human";
		if(linenum == 3)
			return "to generate points for yourself.";
		if(linenum == 4)
			return "first player to reach 100 wins the match.";
	}
	if(mcpmode == MCPMODE_COIN)
	{
		if(linenum == 1)
			return "two teams race to collect 100 coins.";
		if(linenum == 2)
			return "a coin is generated on player death.";
		if(linenum == 3)
			return "all coins carried are dropped on death.";
		if(linenum == 4)
			return "first team to hold 100 wins the match.";
	}	
	else
	{
		return "GetMCPObjectiveString error";
	}
};

string GetMCPModeString (float mode, float abbrv) =
{
	local string res;
	
	if(mode == MCPMODE_MCPUFFIN)
	{
		if(abbrv)
			res = "mcp";
		else
			res = "mcpuffin";
		
	}
	if(mode == MCPMODE_FIEND)
	{
		if(abbrv)
			res = "fnd";
		else
			res = "fiend";
	}
	if(mode == MCPMODE_COIN)
	{
		if(abbrv)
			res = "coin";
		else
			res = "coin";
	}

	return res;
};

string GetCprintString (entity e, float _menutype) = {
	
	local string line1,line2,line3,line4,line5,line6,line7,line8,line9,line10,line11,line12,line13,line14,line15,line16,line17,line18,line19,line20;
	local string spacer  = "\s****************************************\s";
	local string spacer1 = "\s========================================\s";
	local string spacer2 = "\s----------------------------------------\s";
	local string mapstr = mapname;
	mapstr = strconv(1,2,2,mapstr);
	mapstr = strcat(mapstr,"\s.bsp\s");
	

	local string mode = strcat("current mode : ",strconv(1,2,2,GetMCPModeString(mcpmode, 0)));
	
	switch(_menutype)
	{
		case CPRINT_WELCOME:
		{
			line1  = "welcome to mcpuffin mod!\n";
			line2  = "discord.fortressone.org\n";
			line3  = "\n";
			line4  = "\n";
			line5  = strcat(mapstr,"\n");
			line6  = "\n";
			line7  = strcat(spacer,"\n");
			line8  = "\n";
			line9  = strcat(mode,"\n");
			line10 = "\n";
			line11 = strcat(GetMCPObjectiveString(1),"\n");
			line12 = strcat(GetMCPObjectiveString(2),"\n");
			line13 = strcat(GetMCPObjectiveString(3),"\n");
			line14 = strcat(GetMCPObjectiveString(4),"\n");
			line15 = "\n";
			line16 =  strcat(spacer,"\n");
			line17 = "\n";
			line18 = "press \s[0-9]\s to continue\n";
			line19 = "\n";
			line20 = "\n";
			break;
		}
		
		case CPRINT_NONE:
		{
			break;
		}
		
		case CPRINT_SELECTTEAM:
		{
			local float teampad = 26; //was 20
			local float numpad = -2;
			local string blueteam  = strpad(teampad,"\s[1]\s blue");
			local string  redteam  = strpad(teampad,"\s[2]\s red");
			local string autoteam  = strpad(teampad,"\s[5]\s auto-assign");
			local string  balteam  = strpad(teampad,"\s[6]\s keep me on losing team");
			local string bluenum   = strpad(numpad,ftos(GetTeamCount(MCPTEAM_BLUE)));
			local string rednum    = strpad(numpad,ftos(GetTeamCount(MCPTEAM_RED)));
			local string autonum   = strpad(numpad," ");
			local string teamplayers = strpad(10," players");
			local string autoplayers = strpad(10," ");
				
			if(mcpmode == MCPMODE_MCPUFFIN || mcpmode == MCPMODE_COIN)
			{
				line1 = "select team\n";
				line2 = "\n";
				line3 = strcat(blueteam,bluenum,teamplayers,"\n");
				line4 = strcat(redteam,rednum,teamplayers,"\n");
				line5 = "\n";
				line6 = strcat(autoteam,autonum,autoplayers,"\n");
				line7 = strcat(balteam,autonum,autoplayers,"\n");
				line8 = "\n";
				line9 = "\n";
				line10 = "\n";
				line11 = "\n";
				line12 = "\n";
				line13 = "\n";
				line14 = "\n";
				line15 = "\n";
				line16 = "\n";
				line17 = "\n";
				line18 = "\n";
				line19 = "\n";
				line20 = "\n";
				break;
			}
			if(mcpmode == MCPMODE_FIEND)
			{
				line1 = "select team\n";
				line2 = "\n";
				line3 = "\n";
				line4 = "shouldnt be seeing this\n";
				line5 = "\n";
				line6 = "\n";
				line7 = "\n";
				line8 = "\n";
				line9 = "\n";
				line10 = "\n";
				line11 = "\n";
				line12 = "\n";
				line13 = "\n";
				line14 = "\n";
				line15 = "\n";
				line16 = "\n";
				line17 = "\n";
				line18 = "\n";
				line19 = "\n";
				line20 = "\n";
				break;
			}
		}
		case CPRINT_SELECTROLE:
		{
			local float rolepad = 20;
			local float currpad = -2;
			local float maxpad = 2;
			
			local string div = "/";
			
			local string role1 = strpad(rolepad,strcat("\s[1]\s ",MCPROLEDICT[ROLE_RECON].namestr));
			local string role2 = strpad(rolepad,strcat("\s[2]\s ",MCPROLEDICT[ROLE_ASSASSIN].namestr));
			local string role3 = strpad(rolepad,strcat("\s[3]\s ",MCPROLEDICT[ROLE_FIGHTER].namestr));
			local string role4 = strpad(rolepad,strcat("\s[4]\s ",MCPROLEDICT[ROLE_BOMBER].namestr));
			local string role5 = strpad(rolepad,strcat("\s[5]\s ",MCPROLEDICT[ROLE_DOCTOR].namestr));
			local string role6 = strpad(rolepad,strcat("\s[6]\s ",MCPROLEDICT[ROLE_MINIGUNNER].namestr));
			local string role7 = strpad(rolepad,strcat("\s[7]\s ",MCPROLEDICT[ROLE_ARSONIST].namestr));
			local string role8 = strpad(rolepad,strcat("\s[8]\s ",MCPROLEDICT[ROLE_TECHNICIAN].namestr));
			local string role9 = strpad(rolepad,strcat("\s[9]\s ",MCPROLEDICT[ROLE_RANDOM].namestr));
			
			local string curr1 = strpad(currpad,ftos(GetRoleCount(ROLE_RECON, e.team_no)));
			local string curr2 = strpad(currpad,ftos(GetRoleCount(ROLE_ASSASSIN, e.team_no)));
			local string curr3 = strpad(currpad,ftos(GetRoleCount(ROLE_FIGHTER, e.team_no)));
			local string curr4 = strpad(currpad,ftos(GetRoleCount(ROLE_BOMBER, e.team_no)));
			local string curr5 = strpad(currpad,ftos(GetRoleCount(ROLE_DOCTOR, e.team_no)));
			local string curr6 = strpad(currpad,ftos(GetRoleCount(ROLE_MINIGUNNER, e.team_no)));
			local string curr7 = strpad(currpad,ftos(GetRoleCount(ROLE_ARSONIST, e.team_no)));
			local string curr8 = strpad(currpad,ftos(GetRoleCount(ROLE_TECHNICIAN, e.team_no)));
			local string curr9 = strpad(currpad," ");
			
			local string max1 = strpad(maxpad,ftos(GetRoleMax(ROLE_RECON, e.team_no)));
			local string max2 = strpad(maxpad,ftos(GetRoleMax(ROLE_ASSASSIN, e.team_no)));
			local string max3 = strpad(maxpad,ftos(GetRoleMax(ROLE_FIGHTER, e.team_no)));
			local string max4 = strpad(maxpad,ftos(GetRoleMax(ROLE_BOMBER, e.team_no)));
			local string max5 = strpad(maxpad,ftos(GetRoleMax(ROLE_DOCTOR, e.team_no)));
			local string max6 = strpad(maxpad,ftos(GetRoleMax(ROLE_MINIGUNNER, e.team_no)));
			local string max7 = strpad(maxpad,ftos(GetRoleMax(ROLE_ARSONIST, e.team_no)));
			local string max8 = strpad(maxpad,ftos(GetRoleMax(ROLE_TECHNICIAN, e.team_no)));
			local string max9 = strpad(maxpad," ");
			
			if(mcpmode == MCPMODE_MCPUFFIN)
			{
				line1  = "select role\n";
				line2 = "\n";
				line3 =  strcat(role1," ",curr1,div,max1,"\n");
				line4 =  strcat(role2," ",curr2,div,max2,"\n");
				line5 =  strcat(role3," ",curr3,div,max3,"\n");
				line6 =  strcat(role4," ",curr4,div,max4,"\n");
				line7 =  strcat(role5," ",curr5,div,max5,"\n");
				line8 =  strcat(role6," ",curr6,div,max6,"\n");
				line9 =  strcat(role7," ",curr7,div,max7,"\n");
				line10 = strcat(role8," ",curr8,div,max8,"\n");
				line11 = "\n";
				line12 = strcat(role9," ",curr9," ",max9,"\n");
				line13 = "\n";
				line14 = "\n";
				line15 = "\n";
				line16 = "\n";
				line17 = "\n";
				line18 = "\n";
				line19 = "\n";
				line20 = "\n";
				break;
			}
			if(mcpmode == MCPMODE_FIEND)
			{
				line1  = "select role\n";
				line2 =  "\n";
				line3 =  "\n";
				line4 =  "\s[2]\s spawn as a fiend. rawr! :3\n";
				line5 =  "\n";
				line6 =  "\n";
				line7 =  "\n";
				line8 =  "\n";
				line9 =  "\n";
				line10 = "\n";
				line11 = "\n";
				line12 = "\n";
				line13 = "\n";
				line14 = "\n";
				line15 = "\n";
				line16 = "\n";
				line17 = "\n";
				line18 = "\n";
				line19 = "\n";
				line20 = "\n";
				break;
			}
			if(mcpmode == MCPMODE_COIN)
			{
				line1  = "select role\n";
				line2 =  "\n";
				line3 =  "\s[1]\s spawn as a tax man $$$\n";
				line4 =  "\n";
				line5 =  "\n";
				line6 =  "\n";
				line7 =  "\n";
				line8 =  "\n";
				line9 =  "\n";
				line10 = "\n";
				line11 = "\n";
				line12 = "\n";
				line13 = "\n";
				line14 = "\n";
				line15 = "\n";
				line16 = "\n";
				line17 = "\n";
				line18 = "\n";
				line19 = "\n";
				line20 = "\n";
				break;
			}
		}
	}
	
	local string res = strcat(line1,line2,line3,line4,line5);
	res = strcat(res,line6,line7,line8,line9,line10);
	res = strcat(res,line11,line12,line13,line14,line15,line16);
	res = strcat(res,line17,line18,line19,line20);
	return res;
};