string mcp_GetSBString(entity e) =
{
	local string res ="";
	local float sb1count  ; 
	if(infokey(e,IK_SB) == "")
		sb1count = 20;
	else

		sb1count = floor(stof(infokey(e,IK_SB)));
		
	if (sb1count > 300)
		sb1count = 300;
        
	local string sb1space = "";
	while(sb1count > 17) // doing this instead of 0 to try and match up to fo
	{
		res = strcat(res,"\n");
		sb1count = sb1count - 1;
	}
	return res;
}

string mcp_GetIdentityString(entity e) = 
{
	local string res = "\n\n";
	
	if(e.FlashTime > 0)
		return res;
		
	local string ai;
	ai = infokey(e, IK_AI);
	
	if(ai == "0")
		return res;
		
	makevectors (e.v_angle);
	local vector source = e.origin + '0 0 16';
	traceline (source, source + v_forward*5000, FALSE, self);
	if (trace_fraction == 1.0)
		return res;

	if (trace_ent.classname != CN_PLAYER)
		return res;
		
	if (trace_ent.iscloaked == 1)
		return res;
	
	if(trace_ent.team_no == e.team_no)
	{
		res = strcat("(team) ", trace_ent.netname,"\n",ftos(trace_ent.health),"h ",ftos(trace_ent.armorvalue),"a\n");
	}
	else	
	{
		res = strcat("(enemy) ", trace_ent.netname,"\n\n");
	}
	return res;
};

string mcp_GetWaitingForPlayerString(entity e) =
{
	local string  res = "\n\n\n\n";
	if(matchstate == MATCHSTATE_WAITFORPLAYERS)
	{
		res = strcat("mode: ",strconv(1,2,2,mcp_ModeString(mcpmode,0)),"\n\nwaiting for following players to \s/ready\s\n\n", mcpgm.message,"\n");
	
	}
	return res;
};

string mcp_GetPlayersOnCPString(float cp) =
{
	local string res = "    ";
	local float diff;
	if(CONTROLPOINT[cp].bluesonpoint > CONTROLPOINT[cp].redsonpoint)
	{
		diff = CONTROLPOINT[cp].bluesonpoint - CONTROLPOINT[cp].redsonpoint;
		if(diff == 1)
			return "b   ";
		if(diff == 2)
			return "bb  ";
		if(diff == 3)
			return "bbb ";
		if(diff >= 4)
			return "bbb+";
	}
	if(CONTROLPOINT[cp].bluesonpoint < CONTROLPOINT[cp].redsonpoint)
	{
		diff = CONTROLPOINT[cp].redsonpoint - CONTROLPOINT[cp].bluesonpoint;
		if(diff == 1)
			return "r   ";
		if(diff == 2)
			return "rr  ";
		if(diff == 3)
			return "rrr ";
		if(diff >= 4)
			return "rrr+";
	}
	return res;
}

string mcp_GetGoalString(entity e) =
{
	local string res = "\n\n\n";
	local string line1 = "\n";
	local string line2 = "\n";
	local string line3 = "\n";
	local string line4 = "\n";
	
	if(e.team_no == MCPTEAM_NONE)
		return res;
	if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
	{
		if(mapisviable == 0)
		 return "\serror:\s victory condition impossible.\n\nmap is missing required ents.\n";
	}
	if(matchstate == MATCHSTATE_WAITFORPLAYERS)
	{
		if(e.is_ready == READYSTATE_NOT)
		{
			line1 = strcat("\x90mode: ",mcp_ModeString(mcpmode,0),"\x91 you are \sNOT READY\s\n");
			line3 = "\s/ready\s in console so the match can start\n";
		}
		else
		{
			line1 = strcat("\x90mode: ",mcp_ModeString(mcpmode,0),"\x91 you are \sready\s!!!\n");
			line3 = "you are an amazing person\n";
		}
	}
	if(matchstate == MATCHSTATE_LIVE && mcpmode == MCPMODE_5CP)
	{
		//local float battcp = CONTROLPOINT[blueattcp].blueprogress/CONTROLPOINT[blueattcp].progressneeded;
		//battcp = rint(battcp * 100);
		local float battcp = CONTROLPOINT[blueattcp].blueprogress;
		
		//local float rattcp = CONTROLPOINT[redattcp].redprogress/CONTROLPOINT[redattcp].progressneeded;
		//rattcp = rint(rattcp * 100);
		local float rattcp = CONTROLPOINT[redattcp].redprogress;
		
		//local float bdefcp = CONTROLPOINT[bluedefcp].redprogress/CONTROLPOINT[bluedefcp].progressneeded;
		//bdefcp = rint(bdefcp * 100);
		local float bdefcp = CONTROLPOINT[bluedefcp].blueprogress;
		
		//local float rdefcp = CONTROLPOINT[reddefcp].blueprogress/CONTROLPOINT[reddefcp].progressneeded;
		//rdefcp = rint(rdefcp * 100);
		local float rdefcp = CONTROLPOINT[reddefcp].redprogress;
		
		local string div = " / ";
		
		if(blueattcp == redattcp)
		{
			line1 = strcat("\sattack: \s",CONTROLPOINT[blueattcp].namestring," ");
				
			if(CONTROLPOINT[blueattcp].blueprogress > 0)
				line1 = strcat(line1,"(b) ",strpad(-2,ftos(battcp)), div, strpad(3,ftos(CONTROLPOINT[blueattcp].progressneeded)));
			else if(CONTROLPOINT[blueattcp].redprogress > 0)
				line1 = strcat(line1,"(r) ",strpad(-2,ftos(rattcp)), div, strpad(3,ftos(CONTROLPOINT[blueattcp].progressneeded)));
			else
				line1 = strcat(line1, strpad(-2,"0"),div, strpad(3,ftos(CONTROLPOINT[blueattcp].progressneeded)));
			
			line1 = strcat(line1," ",mcp_GetPlayersOnCPString(blueattcp),"\n");
			line3 = "\n";
		}
			
		else if(e.team_no == MCPTEAM_BLUE)
		{
			line1 = strcat("\sattack: \s",CONTROLPOINT[blueattcp].namestring," ");
			line1 = strcat(line1,strpad(-2,ftos(battcp)), div, strpad(3,ftos(CONTROLPOINT[blueattcp].progressneeded)));
			line1 = strcat(line1," ",mcp_GetPlayersOnCPString(blueattcp),"\n");
			
			line3 = strcat("\sdefend: \s",CONTROLPOINT[bluedefcp].namestring," ");
			line3 = strcat(line3,strpad(-2,ftos(bdefcp)), div, strpad(3,ftos(CONTROLPOINT[bluedefcp].progressneeded)));
			line3 = strcat(line3," ",mcp_GetPlayersOnCPString(bluedefcp),"\n");
				
		}
		
		else if(e.team_no == MCPTEAM_RED)
		{
			line1 = strcat("\sattack: \s",CONTROLPOINT[redattcp].namestring," ");
			line1 = strcat(line1, strpad(-2,ftos(rattcp)), div, strpad(3,ftos(CONTROLPOINT[redattcp].progressneeded)));
			line1 = strcat(line1," ",mcp_GetPlayersOnCPString(redattcp),"\n");
			
			line3 = strcat("\sdefend: \s",CONTROLPOINT[reddefcp].namestring," ");
			line3 = strcat(line3, strpad(-2,ftos(rdefcp)), div, strpad(3,ftos(CONTROLPOINT[reddefcp].progressneeded)));
			line3 = strcat(line3," ",mcp_GetPlayersOnCPString(reddefcp),"\n");
				
		}
	}
	if(matchstate == MATCHSTATE_LIVE && mcpmode == MCPMODE_SACRIFICE)
	{
		if (mcpgoal.mcpweapstate == MCPGOALSTATE_NONE)
		{
			line1 = "the flag has not spawned yet!\n";
			line3 = "wait for flag to spawn!\n";
		}
		else if (mcpgoal.mcpweapstate == MCPGOALSTATE_RESET)
		{
			line1 = "the flag has spawned!\n";
			line3 = "get the flag!\n";
		}
		else if (mcpgoal.mcpweapstate == MCPGOALSTATE_CARRIED)
		{
			if(mcpgoal.owner == e)
			{
				line1 = "you have the flag!\n";
				line3 = "capture flag in your base!\n";
			}
			else if(mcpgoal.owner.team_no == e.team_no)
			{
				line1 = "a teammate has the flag!\n";
				line3 = strcat("protect ", mcpgoal.owner.netname, "!\n");
			}
			else if(mcpgoal.owner.team_no != e.team_no)
			{
				line1 = "the enemy carries the flag!\n";
				line3 = strcat("kill ", mcpgoal.owner.netname, "!\n");
			}
			
		}
		else if (mcpgoal.mcpweapstate == MCPGOALSTATE_THROWN || mcpgoal.mcpweapstate == MCPGOALSTATE_DROPPED)
		{
			line1 = "the flag has been dropped somewhere!\n";
			line3 = "find the flag!\n";
			
		}
		else if (mcpgoal.mcpweapstate == MCPGOALSTATE_CAPPED)
		{
			if(mcpgoal.team_no == e.team_no)
			{
				line1 ="your team controls the flag!\n";
				line3 = "defend your base!\n";
			}
			else
			{
				line1 ="enemy controls the flag!\n";
				line3 = "attack enemy base!\n";
			}
		}
		
		if(e.FlashTime > 0 || infokey(e, "obj") == "0" || infokey(e, "obj") == "off" || e.team_no  == MCPTEAM_NONE)
		{
			line1 = "\n";
			line2 = "\n";
			line3 = "\n";
		}
	}
	if(matchstate == MATCHSTATE_LIVE && mcpmode == MCPMODE_FIEND)
	{
		local string p1 = strcat("humans : ", strpad(-2,ftos(bluescore)),"/",strpad(2,ftos(FIEND_WINTOTAL)));
		local string p2 = strcat("fiends : ", strpad(-2,ftos(redscore)),"/",strpad(2,ftos(FIEND_WINTOTAL)));
		if(e.team_no == MCPTEAM_BLUE)
		{
			line1 = "kill the \sfiends!\s\n";
			line3 = strcat(p1, "          ",p2,"\n");
		}
		if(e.team_no == MCPTEAM_RED)
		{
			line1 = "kill the \shumans!\s\n";
			line3 = strcat(p1, "          ",p2,"\n");
		}
	}
	if(matchstate == MATCHSTATE_LIVE && mcpmode == MCPMODE_BABYFIEND)
	{
		local string p3 = strcat("hunter : ", strpad(-2,ftos(bluescore)),"/",strpad(2,ftos(BABY_WINTOTAL)));
		local string p4 = strcat("fiends : ", strpad(-2,ftos(redscore)),"/",strpad(2,ftos(BABY_WINTOTAL)));
		if(e.team_no == MCPTEAM_BLUE)
		{
			line1 = "kill the \sbaby fiends!\s\n";
			line3 = strcat(p3, "          ",p4,"\n");
		}
		if(e.team_no == MCPTEAM_RED)
		{
			line1 = "damage the \shuman!\s\n";
			line3 = strcat(p3, "          ",p4,"\n");
		}
	}
	if(matchstate == MATCHSTATE_LIVE && mcpmode == MCPMODE_COINSTEAM)
	{
		local string p5 = strcat("blue : ", strpad(-2,ftos(bluescore)),"/",strpad(2,ftos(COINS_WINTOTAL)), " coins");
		local string p6 = strcat("red : ", strpad(-2,ftos(redscore)),"/",strpad(2,ftos(COINS_WINTOTAL)), " coins");

		line1 = "kill the enemy and collect their coins!\n";
		line3 = strcat(p5, "          ",p6,"\n");

	}
	if(matchstate == MATCHSTATE_LIVE && mcpmode == MCPMODE_COINSFFA)
	{
		line1 = "something should go here\n";
		line3 = "here too\n";
	}

	return res = strcat(line1, line2, line3, line4);

};
string mcp_GetGrenTimerString(entity e) = 
{
	if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
		return strcat("special: ",strconv(1,2,2,MCPSPECDICT[e.mcpspecialtype].namestr),"\n");
			
	if(e.mcpgrentype == MCPGREN_NONE)
		return "\n";
	if(infokey(e,IK_VISGRENTIMER) == "0")
		return "\n";
	
	local float t = floor(((e.mcpgren.bubble_count - time) / MCPGRENTIME) * 20);	//20 steps in timer
	local string res ="";
	if(e.mcpgren != world) //for some reason couldnt get a for or while loop working here so doing long way
	{     //"12345678901234567890
		if(t == 0)
			res = "\x80\x83\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x82\n";
		if(t == 1)
			res = "\x80\x81\x83\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x82\n";
		if(t == 2)
			res = "\x80\x81\x81\x83\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x82\n";
		if(t == 3)
			res = "\x80\x81\x81\x81\x83\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x82\n";
		if(t == 4)
			res = "\x80\x81\x81\x81\x81\x83\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x82\n";
		if(t == 5)
			res = "\x80\x81\x81\x81\x81\x81\x83\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x82\n";
		if(t == 6)
			res = "\x80\x81\x81\x81\x81\x81\x81\x83\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x82\n";
		if(t == 7)
			res = "\x80\x81\x81\x81\x81\x81\x81\x81\x83\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x82\n";
		if(t == 8)
			res = "\x80\x81\x81\x81\x81\x81\x81\x81\x81\x83\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x82\n";
		if(t == 9)
			res = "\x80\x81\x81\x81\x81\x81\x81\x81\x81\x81\x83\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x82\n";
		if(t == 10)
			res = "\x80\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x83\x81\x81\x81\x81\x81\x81\x81\x81\x81\x82\n";
		if(t == 11)
			res = "\x80\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x83\x81\x81\x81\x81\x81\x81\x81\x81\x82\n";
		if(t == 12)
			res = "\x80\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x83\x81\x81\x81\x81\x81\x81\x81\x82\n";
		if(t == 13)
			res = "\x80\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x83\x81\x81\x81\x81\x81\x81\x82\n";
		if(t == 14)
			res = "\x80\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x83\x81\x81\x81\x81\x81\x82\n";
		if(t == 15)
			res = "\x80\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x83\x81\x81\x81\x81\x82\n";
		if(t == 16)
			res = "\x80\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x83\x81\x81\x81\x82\n";
		if(t == 17)
			res = "\x80\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x83\x81\x81\x82\n";
		if(t == 18)
			res = "\x80\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x83\x81\x82\n";
		if(t == 19)
			res = "\x80\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x81\x83\x82\n";
		
		if(infokey(e,IK_VISGRENTIMER) == "1" || infokey(e,IK_VISGRENTIMER) == "")
			return res;
	}
	
	if(infokey(e,IK_VISGRENTIMER) == "1" || infokey(e,IK_VISGRENTIMER) == "2" || infokey(e,IK_VISGRENTIMER) == "")
	{
		local string post = "'s left\n";
		if(e.mcpgrencount == 1)
			post = " left \n";
		return strcat(strconv(1,2,2,ftos(e.mcpgrencount))," ",MCPGRENDICT[e.mcpgrentype].namestr, post);
	}
		
	return "\n";
};
string mcp_GetDefaultString(entity e) =
{
	local string id, obj, sb, wfp,gt;
	wfp = mcp_GetWaitingForPlayerString(e);	//4lines
	sb = mcp_GetSBString(e);
	id = mcp_GetIdentityString(e);		//2lines
	gt = mcp_GetGrenTimerString(e);		//1lines
	obj = mcp_GetGoalString(e);		//3lines	
		
	local string res = strcat(wfp,sb,id,"\n",gt,"\n\n\n\n",obj,"\n");
	
	return res;	
};

string GetResultWordString(float victor, float line) =
{
	local string line1, line2, line3, line4, line5, line6, line7,line8,line9,line10,line11,line12,line13,line14;
	line1  = "##    ##  #######  ##     ##";
	line2  = " ##  ##  ##     ## ##     ##";
	line3  = "  ####   ##     ## ##     ##";
	line4  = "   ##    ##     ## ##     ##";
	line5  = "   ##    ##     ## ##     ##";
	line6  = "   ##    ##     ## ##     ##";
	line7  = "   ##     #######   ####### ";
	
	if(victor)
	{	
		line8  = "##      ##  ####  ##    ##";
		line9  = "##  ##  ##   ##   ###   ##";
		line10 = "##  ##  ##   ##   ####  ##";
		line11 = "##  ##  ##   ##   ## ## ##";
		line12 = "##  ##  ##   ##   ##  ####";
		line13 = "##  ##  ##   ##   ##   ###";
		line14 = " ###  ###   ####  ##    ##";
	}
	else
	{
		line8  = "##        #######   ######   #######";
		line9  = "##       ##     ## ##    ## ##      ";
		line10 = "##       ##     ## ##       ##      ";
		line11 = "##       ##     ##  ######  ######  ";
		line12 = "##       ##     ##       ## ##      ";
		line13 = "##       ##     ## ##    ## ##      ";
		line14 = "########  #######   ######  ########";
	}
	if(line == 1)
		return line1;
	if(line == 2)
		return line2;
	if(line == 3)
		return line3;
	if(line == 4)
		return line4;
	if(line == 5)
		return line5;
	if(line == 6)
		return line6;
	if(line == 7)
		return line7;
	if(line == 8)
		return line8;
	if(line == 9)
		return line9;
	if(line == 10)
		return line10;
	if(line == 11)
		return line11;
	if(line == 12)
		return line12;
	if(line == 13)
		return line13;
	if(line == 14)
		return line14;

	
	
	return "";
};

string GetCountDownLetterString(float num, float line) =
{
	local string line1, line2, line3, line4, line5, line6, line7,line8;
	if(num == 10)
	{
		line1 = " XXXX      XXXXXXXX ";  
		line2 = "XXXXX     XXXX  XXXX"; 
		line3 =	"  XXX     XXX    XXX"; 
		line4 = "  XXX     XXX    XXX"; 
		line5 = "  XXX     XXX    XXX"; 
		line6 = "  XXX     XXX    XXX"; 
		line7 = "  XXX     XXXX  XXXX"; 
		line8 = "XXXXXXX    XXXXXXXX ";
	}
	if(num == 9)
	{
		line1 = "      99999999      ";    
		line2 = "     9999  9999     "; 
		line3 =	"     999    999     "; 
		line4 = "     9999  9999     "; 
		line5 = "      999999999     "; 
		line6 = "            999     "; 
		line7 = "     9999  9999     "; 
		line8 = "       999999       ";
	}
	if(num == 8)
	{
		line1 = "      88888888      ";    
		line2 = "     8888  8888     "; 
		line3 =	"     888    888     "; 
		line4 = "      88888888      "; 
		line5 = "      88888888      "; 
		line6 = "     888    888     "; 
		line7 = "     8888  8888     "; 
		line8 = "      88888888      ";
	}
	if(num == 7)
	{
		line1 = "     7777777777     ";    
		line2 = "     7777777777     "; 
		line3 =	"          7777      "; 
		line4 = "         7777       "; 
		line5 = "        7777        "; 
		line6 = "       7777         "; 
		line7 = "      7777          "; 
		line8 = "     7777           ";
	}
	if(num == 6)
	{
		line1 = "      66666666      ";  
		line2 = "     6666  6666     ";
		line3 = "     666            ";
		line4 = "     666666666      ";
		line5 = "     6666  6666     ";
		line6 = "     666    666     ";
		line7 = "     6666  6666     ";
		line8 = "      66666666      ";
	}
	if(num == 5)
	{
		line1 = "     555555555     ";
		line2 = "     555           ";
		line3 = "     555           ";
		line4 = "     555555555     ";
		line5 = "          55555    ";
		line6 = "            555    ";
		line7 = "     5555  5555    ";
		line8 = "      55555555     ";

	}
	if(num == 4)
	{
		line1 = "         44444     ";
		line2 = "        444444     ";
		line3 = "       444 444     ";
		line4 = "      444  444     ";
		line5 = "     444   444     ";
		line6 = "     4444444444    ";
		line7 = "           444     ";
		line8 = "           444     ";	
	}
	if(num == 3)
	{
		line1 = "      33333333     "; 
		line2 = "     3333  3333    ";
		line3 = "            333    ";
		line4 = "         33333     ";
		line5 = "         33333     ";
		line6 = "     333    333    ";
		line7 = "     3333  3333    ";
		line8 = "      33333333     ";
	}
	if(num == 2)
	{
		line1 = "      22222222     ";  
		line2 = "     2222  2222    ";
		line3 = "            222    ";
		line4 = "           2222    ";
		line5 = "       2222222     ";
		line6 = "     22222         ";
		line7 = "     2222          ";
		line8 = "     2222222222    ";		
	}
	if(num == 1)
	{
		line1 = "        1111       ";  
		line2 = "       11111       "; 
		line3 =	"         111       "; 
		line4 = "         111       "; 
		line5 = "         111       "; 
		line6 = "         111       "; 
		line7 = "         111       "; 
		line8 = "       1111111     ";		
		
	}
	if(num == 0)
	{
		line1 = "      00000000     ";  
		line2 = "     0000  0000    "; 
		line3 =	"     000    000    "; 
		line4 = "     000    000    "; 
		line5 = "     000    000    "; 
		line6 = "     000    000    "; 
		line7 = "     0000  0000    "; 
		line8 = "      00000000     ";
	}
	if(num == 0)
	{
		line1 = "                                       ";
		line2 = "####### ###  #####  #     # ####### ###"; 
		line3 = "#        #  #     # #     #    #    ###"; 
		line4 = "#        #  #       #     #    #    ###"; 
		line5 = "#####    #  #  #### #######    #     # "; 
		line6 = "#        #  #     # #     #    #       "; 
		line7 = "#        #  #     # #     #    #    ###"; 
		line8 = "#       ###  #####  #     #    #    ###";
	}
	if(line == 1)
		return line1;
	if(line == 2)
		return line2;
	if(line == 3)
		return line3;
	if(line == 4)
		return line4;
	if(line == 5)
		return line5;
	if(line == 6)
		return line6;
	if(line == 7)
		return line7;
	if(line == 8)
		return line8;
	
	return "";
	
	
};
string GetMCPObjectiveString(float linenum, float welc, entity e) =
{
	local string pressnum;
	if(welc)
		pressnum = "press \s[0-9]\s to continue.";
	else
		pressnum = " ";
	local string spacer  = "\<\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\>";
	if(mcpmode == MCPMODE_SACRIFICE)
	{		     //"<===== ghetto strlen ruler(40chars) =====>";
		if(linenum == 1)
			return "two teams fight for control of a flag.";
		if(linenum == 3)
			return "1 flag will spawn in the middle.";
		if(linenum == 5)
			return "grab the flag and secure it at your";
		if(linenum == 6)
			return "teams capture point in your base.";
		if(linenum == 8)
			return "whilst the flag is captured it will";
		if(linenum == 9)
			return "generate points for the owners team.";
		if(linenum == 11)
			return strcat("first team to reach ",ftos(SACRIFICE_WINTOTAL)," wins.");
		if(linenum == 12)
			return " ";
		if(linenum == 13)
			return spacer;
		if(linenum == 14)
			return " ";
		if(linenum == 15)
			return pressnum;
		
		             //"<===== ghetto strlen ruler(40chars) =====>";
	}
		if(mcpmode == MCPMODE_5CP)
	{		     //"<===== ghetto strlen ruler(40chars) =====>";
		if(linenum == 1)
			return "two teams fight over 5 control points.";
		if(linenum == 3)
			return "blahhh blahhh.";
		if(linenum == 5)
			return " blahhh blahhhblahhhblahhh ";
		if(linenum == 6)
			return "blahhhblahhhblahhh.";
		if(linenum == 8)
			return "blahhh blahhh blahhh blahhh";
		if(linenum == 9)
			return "blahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh.";
		if(linenum == 11)
			return strcat("first team to blahhh wins.");
		if(linenum == 12)
			return " ";
		if(linenum == 13)
			return spacer;
		if(linenum == 14)
			return " ";
		if(linenum == 15)
			return pressnum;
		
		             //"<===== ghetto strlen ruler(40chars) =====>";
	}
	if(mcpmode == MCPMODE_FIEND)
	{		     //"<===== ghetto strlen ruler(40chars) =====>";
		if(linenum == 1)
			return "humans vs fiends";
		if(linenum == 2)
			return " ";
		if(linenum == 3)
			return "humans have shaft/rl/rail and airblast.";
		if(linenum == 4)
			return "no reloads, no grenades.";
		if(linenum == 5)
			return " ";
		if(linenum == 6)
			return "the fiends only have claws and leap.";
		if(linenum == 7)
			return "but will full heal on a claw kill.";
		if(linenum == 8)
			return " ";
		if(linenum == 9)
			return "first team to reach a combined total";
		if(linenum == 10)
			return strcat("of ",ftos(FIEND_WINTOTAL)," kills wins.");
		if(linenum == 11)
			return " ";
		if(linenum == 12)
			return spacer;
		if(linenum == 13)
			return " ";
		if(linenum == 14)
			return pressnum;
		if(linenum == 15)
			return " ";
		             //"<===== ghetto strlen ruler(40chars) =====>";
	}
	if(mcpmode == MCPMODE_COINSTEAM)
	{
		             //"<===== ghetto strlen ruler(40chars) =====>";
		if(linenum == 1)
			return strcat("two teams race to collect ",ftos(COINS_WINTOTAL)," coins.");
		if(linenum == 2)
			return " ";
		if(linenum == 3)
			return "a coin is dropped on each player death";
		if(linenum == 4)
			return "collect the coin to add to your total.";
		if(linenum == 5)
			return "but be careful, half of your coins";
		if(linenum == 6)
			return "will be dropped every time you die.";
		if(linenum == 7)
			return " ";
		if(linenum == 8)
			return "first team to reach a combined total";
		if(linenum == 9)
			return strcat("of ",ftos(COINS_WINTOTAL)," coins wins the match.");
		if(linenum == 10)
			return " ";
		if(linenum == 11)
			return spacer;
		if(linenum == 12)
			return " ";
		if(linenum == 13)
			return pressnum;
		if(linenum == 14)
			return " ";
		if(linenum == 15)
			return " ";
		             //"<===== ghetto strlen ruler(40chars) =====>";
			
	}
	if(mcpmode == MCPMODE_COINSFFA)
	{
		             //"<===== ghetto strlen ruler(40chars) =====>";
		if(linenum == 1)
			return strcat("players race to collect ",ftos(COINS_WINTOTAL)," coins.");
		if(linenum == 2)
			return " ";
		if(linenum == 3)
			return "a coin is dropped on each player death";
		if(linenum == 4)
			return "collect the coin to add to your total.";
		if(linenum == 5)
			return "but be careful, half of your coins";
		if(linenum == 6)
			return "will be dropped every time you die.";
		if(linenum == 7)
			return " ";
		if(linenum == 8)
			return "first player to reach a total";
		if(linenum == 9)
			return strcat("of ",ftos(COINS_WINTOTAL)," coins wins the match.");
		if(linenum == 10)
			return " ";
		if(linenum == 11)
			return spacer;
		if(linenum == 12)
			return " ";
		if(linenum == 13)
			return pressnum;
		if(linenum == 14)
			return " ";
		if(linenum == 15)
			return " ";
		             //"<===== ghetto strlen ruler(40chars) =====>";
			
	}
	if(mcpmode == MCPMODE_BABYFIEND)
	{
		             //"<===== ghetto strlen ruler(40chars) =====>";
		if(linenum == 1)
			return "one human hunter vs many baby-fiends";
		if(linenum == 2)
			return " ";
		if(linenum == 3)
			return "the hunter only has a shotgun and the";
		if(linenum == 4)
			return "throwmeat \s'special'\s to detect enemies.";
		if(linenum == 5)
			return "hunter kills fiends to gain 1 point.";
		if(linenum == 6)
			return " ";
		if(linenum == 7)
			return "baby fiends gain 1 point for each hit";
		if(linenum == 8)
			return "landed on the hunter.";
		if(linenum == 9)
			return " ";
		if(linenum == 10)
			return "first team to reach a combined score";
		if(linenum == 11)
			return strcat("of ",ftos(BABY_WINTOTAL)," wins the match.");
		if(linenum == 12)
			return " ";
		if(linenum == 13)
			return spacer;
		if(linenum == 14)
			return " ";
		if(linenum == 15)
			return pressnum;
		             //"<===== ghetto strlen ruler(40chars) =====>";
	}	
	else
	{
		return "";
	}
};



void think_cprint () = 
{
	self.nextthink = time + CPRINT_TICKRATE;
	centerprint(self.owner, GetCprintString(self.owner, self.cnt));
	if(self.cnt == CPRINT_COUNTDOWN && matchstate != MATCHSTATE_COUNTDOWN)
		self.cnt = CPRINT_NONE;

};

string mcp_ModeString (float m, float abbrv) =
{
	local string res = "";
	
	if(m == MCPMODE_SACRIFICE)
	{
		if(abbrv)
			return "sacrifice";
		else
			return "sacrifice";
	}
	if(m == MCPMODE_COINSTEAM)
	{
		if(abbrv)
			return "coinsteam";
		else
			return "coinsteam";
	}
	if(m == MCPMODE_COINSFFA)
	{
		if(abbrv)
			return "coinsffa";
		else
			return "coinsffa";
	}
	if(m == MCPMODE_FIEND)
	{
		if(abbrv)
			return "fiend";
		else
			return "fiend";
	}
	if(m == MCPMODE_BABYFIEND)
	{
		if(abbrv)
			return "babyfiend";
		else
			return "babyfiend";
	}
	if(m == MCPMODE_5CP)
	{
		if(abbrv)
			return "5cp";
		else
			return "5cp";
	}
	
	return res;
};
void cprintAll(float type) =
{
	local entity p = find(world, classname, CN_PLAYER);
	while (p != world) 
	{	
		if (p.has_disconnected != 1) 
		{
			cprint(p, type);
		}
		p = find(p, classname, CN_PLAYER);
	}

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