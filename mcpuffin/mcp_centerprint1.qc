string GetCprintString (entity e, float _menutype) = {
	
	local string line1,line2,line3,line4,line5,line6,line7,line8,line9,line10,line11,line12,line13,line14,line15,line16,line17,line18,line19,line20,line21,line22,line23,line24,line25,line26,line27,line28,line29,line30,line31,line32,line33,line34,line35 = "\n";
	local string spacer  = "\<\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\>";
	local string mapstr = mapname;
	local float myvote;
	local string optvotes1, optvotes2, optvotes3, optvotes4, optvotes5, optvotes6, optvotes7, optvotes8, optvotes9, optvotes10;
	mapstr = strconv(1,2,2,mapstr);
	mapstr = strcat(mapstr,"\s.bsp\s");
	
	local string votestr = strpad(10," votes");
	local string mode = strcat("current mode : ",strconv(1,2,2,mcp_ModeString(mcpmode, 0)));
	
	switch(_menutype)
	{
		case CPRINT_NONE:
		{
			if(matchstate == MATCHSTATE_COUNTDOWN)
			{
				_menutype = CPRINT_COUNTDOWN;
		
			}
			else
			{
				return mcp_GetDefaultString(e);
				break;
			}
		}
		case CPRINT_COUNTDOWN:
		{
			local float cd = ceil(mcpgm.cnt-time);
				
			line1 = strcat(strconv(1,2,2,mcp_ModeString(mcpmode,0)), " will begin in :\n");
			line2 = "\n";
			line3 = "\n";
			line4 = strcat(strconv(1,2,2,GetCountDownLetterString(cd, 1)),"\n");
			line5 = strcat(strconv(1,2,2,GetCountDownLetterString(cd, 2)),"\n");
			line6 = strcat(strconv(1,2,2,GetCountDownLetterString(cd, 3)),"\n");
			line7 = strcat(strconv(1,2,2,GetCountDownLetterString(cd, 4)),"\n");
			line8 = strcat(strconv(1,2,2,GetCountDownLetterString(cd, 5)),"\n");
			line9 = strcat(strconv(1,2,2,GetCountDownLetterString(cd, 6)),"\n");
			line10 = strcat(strconv(1,2,2,GetCountDownLetterString(cd, 7)),"\n");
			line11 = strcat(strconv(1,2,2,GetCountDownLetterString(cd, 8)),"\n");
			line12 = "\n";
			line13 = strcat(spacer,"\n");
			line14 = "\n";
			line15 = strcat(GetMCPObjectiveString(1,0,e),"\n");
			line16 = strcat(GetMCPObjectiveString(2,0,e),"\n");
			line17 = strcat(GetMCPObjectiveString(3,0,e),"\n");
			line18 = strcat(GetMCPObjectiveString(4,0,e),"\n");
			line19 = strcat(GetMCPObjectiveString(5,0,e),"\n");
			line20 = strcat(GetMCPObjectiveString(6,0,e),"\n");
			line21 = strcat(GetMCPObjectiveString(7,0,e),"\n");			
			line22 = strcat(GetMCPObjectiveString(8,0,e),"\n");
			line23 = strcat(GetMCPObjectiveString(9,0,e),"\n");
			line24 = strcat(GetMCPObjectiveString(10,0,e),"\n");
			line25 = strcat(GetMCPObjectiveString(11,0,e),"\n");
			line26 = strcat(GetMCPObjectiveString(12,0,e),"\n");
			line27 = strcat(GetMCPObjectiveString(13,0,e),"\n");
			line28 = strcat(GetMCPObjectiveString(14,0,e),"\n");
			line29 = strcat(GetMCPObjectiveString(15,0,e),"\n");
			line30 = strcat(GetMCPObjectiveString(16,0,e),"\n");
			line31 = strcat(GetMCPObjectiveString(17,0,e),"\n");
			line32 = strcat(GetMCPObjectiveString(18,0,e),"\n");
			line33 = "\n";
			line34 = "\n";
			line35 = "\n";
			break;
		}
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
			line11 = strcat(GetMCPObjectiveString(1,1,e),"\n");
			line12 = strcat(GetMCPObjectiveString(2,1,e),"\n");
			line13 = strcat(GetMCPObjectiveString(3,1,e),"\n");
			line14 = strcat(GetMCPObjectiveString(4,1,e),"\n");
			line15 = strcat(GetMCPObjectiveString(5,1,e),"\n");
			line16 = strcat(GetMCPObjectiveString(6,1,e),"\n");
			line17 = strcat(GetMCPObjectiveString(7,1,e),"\n");			
			line18 = strcat(GetMCPObjectiveString(8,1,e),"\n");
			line19 = strcat(GetMCPObjectiveString(9,1,e),"\n");
			line20 = strcat(GetMCPObjectiveString(10,1,e),"\n");
			line21 = strcat(GetMCPObjectiveString(11,1,e),"\n");
			line22 = strcat(GetMCPObjectiveString(12,1,e),"\n");
			line23 = strcat(GetMCPObjectiveString(13,1,e),"\n");
			line24 = strcat(GetMCPObjectiveString(14,1,e),"\n");
			line25 = strcat(GetMCPObjectiveString(15,1,e),"\n");
			line26 = strcat(GetMCPObjectiveString(16,1,e),"\n");
			line27 = strcat(GetMCPObjectiveString(17,1,e),"\n");
			line28 = strcat(GetMCPObjectiveString(18,1,e),"\n");
			line29 = "\n";
			line30 = "\n";
			line31 = "\n";
			line32 = "\n";
			line33 = "\n";
			line34 = "\n";
			line35 = "\n";
			break;
		}
		
		case CPRINT_VOTEMAPRESULT:
		{	
			line1  = "\n";
			line2  = "\n";
			line3 =  "\n";
			line4 =  "\n";
			line5 =  "\n";
			line6 =  "the votes are in! winning map is...\n";
			line7 =  "\n";
			if(mcpgm.bubble_count >= 2)
				line8 =  strcat(strconv(1,2,2,VOTECHOICE[mcpgm.reload_rocket_launcher].mapstring),"\n");
			else
				line8 = "\n";
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
			line21 = "\n";
			line22 = "\n";
			line23 = "\n";
			line24 = "\n";
			line25 = "\n";
			line26 = "\n";
			line27 = "\n";
			line28 = "\n";
			line29 = "\n";
			line30 = "\n";
			line31 = "\n";
			line32 = "\n";
			line33 = "\n";
			line34 = "\n";
			line35 = "\n";
			break;
		}
		
		case CPRINT_VOTEMAP:
		{	
			local float vmappad = 26;
			local string vmap1 = strpad(vmappad,strcat("\s[1]\s ",VOTECHOICE[1].mapstring));	
			local string vmap2 = strpad(vmappad,strcat("\s[2]\s ",VOTECHOICE[2].mapstring));
			local string vmap3 = strpad(vmappad,strcat("\s[3]\s ",VOTECHOICE[3].mapstring));
			local string vmap4 = strpad(vmappad,strcat("\s[4]\s ",VOTECHOICE[4].mapstring));
			local string vmap5 = strpad(vmappad,strcat("\s[5]\s ",VOTECHOICE[5].mapstring));
			local string vmap6 = strpad(vmappad,strcat("\s[6]\s ",VOTECHOICE[6].mapstring));
			local string vmap7 = strpad(vmappad,strcat("\s[7]\s ",VOTECHOICE[7].mapstring));
			local string vmap8 = strpad(vmappad,strcat("\s[8]\s ",VOTECHOICE[8].mapstring));
			local string vmap9 = strpad(vmappad,strcat("\s[9]\s ",VOTECHOICE[9].mapstring));
			
			
			local float votemap = 2;
			
			
			optvotes1 = strpad(votemap,ftos(VOTECHOICE[1].mapvotes));
			optvotes2 = strpad(votemap,ftos(VOTECHOICE[2].mapvotes));
			optvotes3 = strpad(votemap,ftos(VOTECHOICE[3].mapvotes));
			optvotes4 = strpad(votemap,ftos(VOTECHOICE[4].mapvotes));
			optvotes5 = strpad(votemap,ftos(VOTECHOICE[5].mapvotes));
			optvotes6 = strpad(votemap,ftos(VOTECHOICE[6].mapvotes));
			optvotes7 = strpad(votemap,ftos(VOTECHOICE[7].mapvotes));
			optvotes8 = strpad(votemap,ftos(VOTECHOICE[8].mapvotes));
			optvotes9 = strpad(votemap,ftos(VOTECHOICE[9].mapvotes));
				
			line1  = strcat("vote for next map (",ftos(ceil(mcpgm.cnt-time)),")\n");
			line2  = "\n";
			line3 =  strcat(vmap1,optvotes1,votestr,"\n");
			line4 =  strcat(vmap2,optvotes2,votestr,"\n");
			line5 =  strcat(vmap3,optvotes3,votestr,"\n");
			line6 =  strcat(vmap4,optvotes4,votestr,"\n");
			line7 =  strcat(vmap5,optvotes5,votestr,"\n");
			line8 =  strcat(vmap6,optvotes6,votestr,"\n");
			line9 =  strcat(vmap7,optvotes7,votestr,"\n");
			line10 = strcat(vmap8,optvotes8,votestr,"\n");
			line11 = strcat(vmap9,optvotes9,votestr,"\n");
			line12 = "\n";
			line13 = "\n";
			line14 = "\n";
			line15 = "\n";
			line16 = "\n";
			line17 = "\n";
			line18 = "\n";
			line19 = "\n";
			line20 = "\n";
			line21 = "\n";
			line22 = "\n";
			line23 = "\n";
			line24 = "\n";
			line25 = "\n";
			line26 = "\n";
			line27 = "\n";
			line28 = "\n";
			line29 = "\n";
			line30 = "\n";
			line31 = "\n";
			line32 = "\n";
			line33 = "\n";
			line34 = "\n";
			line35 = "\n";
			
			myvote = e.reload_rocket_launcher;
			if(myvote == 1)
				line3 =  strcat(strconv(1,2,2,vmap1),strconv(1,2,2,optvotes1),strconv(1,2,2,votestr),"\n");
			if(myvote == 2)
				line4 =  strcat(strconv(1,2,2,vmap2),strconv(1,2,2,optvotes2),strconv(1,2,2,votestr),"\n");
			if(myvote == 3)
				line5 =  strcat(strconv(1,2,2,vmap3),strconv(1,2,2,optvotes3),strconv(1,2,2,votestr),"\n");
			if(myvote == 4)
				line6 =  strcat(strconv(1,2,2,vmap4),strconv(1,2,2,optvotes4),strconv(1,2,2,votestr),"\n");
			if(myvote == 5)
				line7 =  strcat(strconv(1,2,2,vmap5),strconv(1,2,2,optvotes5),strconv(1,2,2,votestr),"\n");
			if(myvote == 6)
				line8 =  strcat(strconv(1,2,2,vmap6),strconv(1,2,2,optvotes6),strconv(1,2,2,votestr),"\n");
			if(myvote == 7)
				line9 =  strcat(strconv(1,2,2,vmap7),strconv(1,2,2,optvotes7),strconv(1,2,2,votestr),"\n");
			if(myvote == 8)
				line10 =  strcat(strconv(1,2,2,vmap8),strconv(1,2,2,optvotes8),strconv(1,2,2,votestr),"\n");
			if(myvote == 9)
				line11 =  strcat(strconv(1,2,2,vmap9),strconv(1,2,2,optvotes9),strconv(1,2,2,votestr),"\n");
			break;

		}
		
		case CPRINT_VOTEMODERESULT:
		{	
			line1  = "\n";
			line2  = "\n";
			line3 =  "\n";
			line4 =  "\n";
			line5 =  "\n";
			line6 =  "voting has closed! the winning mode is...\n";
			line7 =  "\n";
			if(mcpgm.bubble_count >= 2)
				line8 =  strcat(strconv(1,2,2,VOTECHOICE[mcpgm.reload_grenade_launcher].modestring),"\n");
			else
				line8 = "\n";
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
			line21 = "\n";
			line22 = "\n";
			line23 = "\n";
			line24 = "\n";
			line25 = "\n";
			line26 = "\n";
			line27 = "\n";
			line28 = "\n";
			line29 = "\n";
			line30 = "\n";
			line31 = "\n";
			line32 = "\n";
			line33 = "\n";
			line34 = "\n";
			line35 = "\n";
			break;
		}
		
		case CPRINT_VOTEMODE:
		{	
			local float vmodepad = 26;
			local string vmode1 = strpad(vmodepad,strcat("\s[1]\s ",VOTECHOICE[1].modestring));	
			local string vmode2 = strpad(vmodepad,strcat("\s[2]\s ",VOTECHOICE[2].modestring));
			local string vmode3 = strpad(vmodepad,strcat("\s[3]\s ",VOTECHOICE[3].modestring));
			local string vmode4 = strpad(vmodepad,strcat("\s[4]\s ",VOTECHOICE[4].modestring));
			local string vmode5 = strpad(vmodepad,strcat("\s[5]\s ",VOTECHOICE[5].modestring));
			local string vmode6 = strpad(vmodepad,strcat("\s[6]\s ",VOTECHOICE[6].modestring));
			
			local float votem = 2;
			optvotes1 = strpad(votem,ftos(VOTECHOICE[1].modevotes));
			optvotes2 = strpad(votem,ftos(VOTECHOICE[2].modevotes));
			optvotes3 = strpad(votem,ftos(VOTECHOICE[3].modevotes));
			optvotes4 = strpad(votem,ftos(VOTECHOICE[4].modevotes));
			optvotes5 = strpad(votem,ftos(VOTECHOICE[5].modevotes));
			optvotes6 = strpad(votem,ftos(VOTECHOICE[6].modevotes));
				
			line1  = strcat("vote for next mode (",ftos(ceil(mcpgm.cnt-time)),")\n");
			line2  = "\n";
			line3 =  strcat(vmode1,optvotes1,votestr,"\n");
			line4 =  strcat(vmode2,optvotes2,votestr,"\n");
			line5 =  strcat(vmode3,optvotes3,votestr,"\n");
			line6 =  strcat(vmode4,optvotes4,votestr,"\n");
			line7 =  strcat(vmode5,optvotes5,votestr,"\n");
			line8 =  strcat(vmode6,optvotes6,votestr,"\n");
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
			line21 = "\n";
			line22 = "\n";
			line23 = "\n";
			line24 = "\n";
			line25 = "\n";
			line26 = "\n";
			line27 = "\n";
			line28 = "\n";
			line29 = "\n";
			line30 = "\n";
			line31 = "\n";
			line32 = "\n";
			line33 = "\n";
			line34 = "\n";
			line35 = "\n";
			
			myvote = e.reload_grenade_launcher;
			if(myvote == 1)
				line3 =  strcat(strconv(1,2,2,vmode1),strconv(1,2,2,optvotes1),strconv(1,2,2,votestr),"\n");
			if(myvote == 2)
				line4 =  strcat(strconv(1,2,2,vmode2),strconv(1,2,2,optvotes2),strconv(1,2,2,votestr),"\n");
			if(myvote == 3)
				line5 =  strcat(strconv(1,2,2,vmode3),strconv(1,2,2,optvotes3),strconv(1,2,2,votestr),"\n");
			if(myvote == 4)
				line6 =  strcat(strconv(1,2,2,vmode4),strconv(1,2,2,optvotes4),strconv(1,2,2,votestr),"\n");
			if(myvote == 5)
				line7 =  strcat(strconv(1,2,2,vmode5),strconv(1,2,2,optvotes5),strconv(1,2,2,votestr),"\n");
			if(myvote == 6)
				line8 =  strcat(strconv(1,2,2,vmode6),strconv(1,2,2,optvotes6),strconv(1,2,2,votestr),"\n");
			break;
		}
		
		case CPRINT_SELECTTEAM:
		{
			local float teampad = 30; //was 20
			local float numpad = -2;
			local string blueteam  = strpad(teampad,"\s[1]\s blue");
			local string  redteam  = strpad(teampad,"\s[2]\s red");
			local string autoteam  = strpad(teampad,"\s[5]\s auto-assign");
			local string balteam = strpad(teampad,"\s[6]\s keep me on losing team \s[turn on]\s");
			if(e.team_loser)
				balteam  = strpad(teampad,"\s[6]\s keep me on losing team \s[turn off]\s");
			local string bluenum   = strpad(numpad,ftos(GetTeamCount(MCPTEAM_BLUE)));
			local string rednum    = strpad(numpad,ftos(GetTeamCount(MCPTEAM_RED)));
			local string autonum   = strpad(numpad," ");
			local string teamplayers = strpad(10," players");
			local string autoplayers = strpad(10," ");
				
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
			line21 = "\n";
			line22 = "\n";
			line23 = "\n";
			line24 = "\n";
			line25 = "\n";
			line26 = "\n";
			line27 = "\n";
			line28 = "\n";
			line29 = "\n";
			line30 = "\n";
			line31 = "\n";
			line32 = "\n";
			line33 = "\n";
			line34 = "\n";
			line35 = "\n";
			break;
		}
		
		case CPRINT_RESULT:
		{
			local float vic = 0;
			local float timr = time - mcpgm.heat;
			if(e.team_no ==  mcp_GetTeamPlacement(1))
				vic = 1;
		
			line1 =  "\n";
			line2 =  "\n";
			line3 =  "\n";
			line4 =  "\n";
			line5 =  "\n";
			line6 =  "the match has ended!\n";
			line7 =  "\n";
			line8 =  "\n";
			line9 =  "\n";
			if(timr >= 2)
			{
				line10 = strcat(GetResultWordString(vic, 1),"\n");
				line11 = strcat(GetResultWordString(vic, 2),"\n");
				line12 = strcat(GetResultWordString(vic, 3),"\n");
				line13 = strcat(GetResultWordString(vic, 4),"\n");
				line14 = strcat(GetResultWordString(vic, 5),"\n");
				line15 = strcat(GetResultWordString(vic, 6),"\n");
				line16 = strcat(GetResultWordString(vic, 7),"\n");
			}
			line17 = "\n";
			line18 = "\n";
			if(timr >= 2.5)
			{
				line19 = strcat(GetResultWordString(vic, 8),"\n");
				line20 = strcat(GetResultWordString(vic, 9),"\n");
				line21 = strcat(GetResultWordString(vic, 10),"\n");
				line22 = strcat(GetResultWordString(vic, 11),"\n");
				line23 = strcat(GetResultWordString(vic, 12),"\n");
				line24 = strcat(GetResultWordString(vic, 13),"\n");
				line25 = strcat(GetResultWordString(vic, 14),"\n");
			}
			line26 = "\n";
			line27 = "\n";
			line28 = "\n";
			line29 = "\n";
			line30 = "\n";
			line31 = "\n";
			line32 = "\n";
			line33 = "\n";
			line34 = "\n";
			line35 = "\n";
			break;
		}
		
		case CPRINT_SELECTROLE:
		{
			local float rolepad = 20;
			local float currpad = -2;
			local float maxpad = 2;
			local string header = " ";
			local string role1, role2, role3, role4, role5, role6, role7, role8, role9 = " ";
			local string curr1, curr2, curr3, curr4, curr5, curr6, curr7, curr8, curr9 = " ";
			local string max1, max2, max3,max4,max5,max6,max7,max8,max9 = " ";
			local string div = "/";
			if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
			{
				header = "select role";
				role1 = strpad(rolepad,strcat("\s[1]\s ",MCPROLEDICT[ROLE_RECON].namestr));
				role2 = strpad(rolepad,strcat("\s[2]\s ",MCPROLEDICT[ROLE_ASSASSIN].namestr));
				role3 = strpad(rolepad,strcat("\s[3]\s ",MCPROLEDICT[ROLE_FIGHTER].namestr));
				role4 = strpad(rolepad,strcat("\s[4]\s ",MCPROLEDICT[ROLE_BOMBER].namestr));
				role5 = strpad(rolepad,strcat("\s[5]\s ",MCPROLEDICT[ROLE_DOCTOR].namestr));
				role6 = strpad(rolepad,strcat("\s[6]\s ",MCPROLEDICT[ROLE_MINIGUNNER].namestr));
				role7 = strpad(rolepad,strcat("\s[7]\s ",MCPROLEDICT[ROLE_ARSONIST].namestr));
				role8 = strpad(rolepad,strcat("\s[8]\s ",MCPROLEDICT[ROLE_TECHNICIAN].namestr));
				role9 = strpad(rolepad,strcat("\s[9]\s ",MCPROLEDICT[ROLE_RANDOM].namestr));
				
				curr1 = strpad(currpad,ftos(GetRoleCount(ROLE_RECON, e.team_no)));
				curr2 = strpad(currpad,ftos(GetRoleCount(ROLE_ASSASSIN, e.team_no)));
				curr3 = strpad(currpad,ftos(GetRoleCount(ROLE_FIGHTER, e.team_no)));
				curr4 = strpad(currpad,ftos(GetRoleCount(ROLE_BOMBER, e.team_no)));
				curr5 = strpad(currpad,ftos(GetRoleCount(ROLE_DOCTOR, e.team_no)));
				curr6 = strpad(currpad,ftos(GetRoleCount(ROLE_MINIGUNNER, e.team_no)));
				curr7 = strpad(currpad,ftos(GetRoleCount(ROLE_ARSONIST, e.team_no)));
				curr8 = strpad(currpad,ftos(GetRoleCount(ROLE_TECHNICIAN, e.team_no)));
				curr9 = strpad(currpad," ");
				
				max1 = strpad(maxpad,ftos(GetRoleMax(ROLE_RECON, e.team_no)));
				max2 = strpad(maxpad,ftos(GetRoleMax(ROLE_ASSASSIN, e.team_no)));
				max3 = strpad(maxpad,ftos(GetRoleMax(ROLE_FIGHTER, e.team_no)));
				max4 = strpad(maxpad,ftos(GetRoleMax(ROLE_BOMBER, e.team_no)));
				max5 = strpad(maxpad,ftos(GetRoleMax(ROLE_DOCTOR, e.team_no)));
				max6 = strpad(maxpad,ftos(GetRoleMax(ROLE_MINIGUNNER, e.team_no)));
				max7 = strpad(maxpad,ftos(GetRoleMax(ROLE_ARSONIST, e.team_no)));
				max8 = strpad(maxpad,ftos(GetRoleMax(ROLE_TECHNICIAN, e.team_no)));
				max9 = strpad(maxpad," ");
				
				line1  = strcat(header,"\n");
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
				line21 = "\n";
				line22 = "\n";
				line23 = "\n";
				line24 = "\n";
				line25 = "\n";
				line26 = "\n";
				line27 = "\n";
				line28 = "\n";
				line29 = "\n";
				line30 = "\n";
				line31 = "\n";
				line32 = "\n";
				line33 = "\n";
				line34 = "\n";
				line35 = "\n";
			}
			if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
			{
				header = "choose \s'special'\s ability";
				
				role1 = strpad(rolepad,strcat("\s[1]\s ",MCPSPECDICT[MCPSPECIAL_DASH].namestr));
				role2 = strpad(rolepad,strcat("\s[2]\s ",MCPSPECDICT[MCPSPECIAL_CLOAK].namestr));
				role3 = strpad(rolepad,strcat("\s[3]\s ",MCPSPECDICT[MCPSPECIAL_HARPOON].namestr));
				role4 = strpad(rolepad,strcat("\s[4]\s ",MCPSPECDICT[MCPSPECIAL_DETROCKET].namestr));
				role5 = strpad(rolepad,strcat("\s[5]\s ",MCPSPECDICT[MCPSPECIAL_TELEBALL].namestr));
				role6 = strpad(rolepad,strcat("\s[6]\s ",MCPSPECDICT[MCPSPECIAL_LEAP].namestr));
				role7 = strpad(rolepad,strcat("\s[7]\s ",MCPSPECDICT[MCPSPECIAL_AIRBLAST].namestr));
			
				role9 = strpad(rolepad,strcat("\s[9]\s ",MCPSPECDICT[MCPSPECIAL_RANDOM].namestr));
				
				curr1 = strpad(currpad,ftos(GetSpecialCount(MCPSPECIAL_DASH, e.team_no)));
				curr2 = strpad(currpad,ftos(GetSpecialCount(MCPSPECIAL_CLOAK, e.team_no)));
				curr3 = strpad(currpad,ftos(GetSpecialCount(MCPSPECIAL_HARPOON, e.team_no)));
				curr4 = strpad(currpad,ftos(GetSpecialCount(MCPSPECIAL_DETROCKET, e.team_no)));
				curr5 = strpad(currpad,ftos(GetSpecialCount(MCPSPECIAL_TELEBALL, e.team_no)));
				curr6 = strpad(currpad,ftos(GetSpecialCount(MCPSPECIAL_LEAP, e.team_no)));
				curr7 = strpad(currpad,ftos(GetSpecialCount(MCPSPECIAL_AIRBLAST, e.team_no)));
				
				curr9 = strpad(currpad," ");
				
				max1 = strpad(maxpad,ftos(GetSpecialMax(MCPSPECIAL_DASH, e.team_no)));
				max2 = strpad(maxpad,ftos(GetSpecialMax(MCPSPECIAL_CLOAK, e.team_no)));
				max3 = strpad(maxpad,ftos(GetSpecialMax(MCPSPECIAL_HARPOON, e.team_no)));
				max4 = strpad(maxpad,ftos(GetSpecialMax(MCPSPECIAL_DETROCKET, e.team_no)));
				max5 = strpad(maxpad,ftos(GetSpecialMax(MCPSPECIAL_TELEBALL, e.team_no)));
				max6 = strpad(maxpad,ftos(GetSpecialMax(MCPSPECIAL_LEAP, e.team_no)));
				max7 = strpad(maxpad,ftos(GetSpecialMax(MCPSPECIAL_AIRBLAST, e.team_no)));
				
				max9 = strpad(currpad," ");
				
				line1  = strcat(header,"\n");
				line2 = "\n";
				line3 =  strcat(role1," ",curr1,div,max1,"\n");
				line4 =  strcat(role2," ",curr2,div,max2,"\n");
				line5 =  strcat(role3," ",curr3,div,max3,"\n");
				line6 =  strcat(role4," ",curr4,div,max4,"\n");
				line7 =  strcat(role5," ",curr5,div,max5,"\n");
				line8 =  strcat(role6," ",curr6,div,max6,"\n");
				line9 =  strcat(role7," ",curr7,div,max7,"\n");
				line10 = "\n";
				line11 = strcat(role9," ",curr9," ",max9,"\n");
				line12 = "\n";
				line13 = "\n";
				line14 = "\n";
				line15 = "\n";
				line16 = "\n";
				line17 = "\n";
				line18 = "\n";
				line19 = "\n";
				line20 = "\n";
				line21 = "\n";
				line22 = "\n";
				line23 = "\n";
				line24 = "\n";
				line25 = "\n";
				line26 = "\n";
				line27 = "\n";
				line28 = "\n";
				line29 = "\n";
				line30 = "\n";
				line31 = "\n";
				line32 = "\n";
				line33 = "\n";
				line34 = "\n";
				line35 = "\n";
			}
			if(mcpmode == MCPMODE_FIEND)
			{
				header = "select role";
				role1 = strpad(rolepad,strcat("\s[1]\s ",MCPROLEDICT[ROLE_FIENDHUMAN].namestr));
				role2 = strpad(rolepad,strcat("\s[2]\s ",MCPROLEDICT[ROLE_FIEND].namestr));
				
				curr1 = strpad(currpad,ftos(GetRoleCount(ROLE_FIENDHUMAN, e.team_no)));
				curr2 = strpad(currpad,ftos(GetRoleCount(ROLE_FIEND, e.team_no)));
				
				max1 = strpad(maxpad,ftos(GetRoleMax(ROLE_FIENDHUMAN, e.team_no)));
			        max2 = strpad(maxpad,ftos(GetRoleMax(ROLE_FIEND, e.team_no)));
			        
			        line1  = strcat(header,"\n");
				line2 = "\n";
				if(e.team_no == MCPTEAM_BLUE)
				{
					line3 =  strcat(strpad(rolepad,strcat("\s[1]\s ",MCPROLEDICT[ROLE_FIENDHUMAN].namestr))," ",curr1,div,max1,"\n");
					line4 =  strcat(strpad(rolepad,strcat("\s[2]\s ",MCPROLEDICT[ROLE_FIENDHUMAN].namestr))," ",curr1,div,max1,"\n");
					line5 =  strcat(strpad(rolepad,strcat("\s[3]\s ",MCPROLEDICT[ROLE_FIENDHUMAN].namestr))," ",curr1,div,max1,"\n");
					line6 =  strcat(strpad(rolepad,strcat("\s[4]\s ",MCPROLEDICT[ROLE_FIENDHUMAN].namestr))," ",curr1,div,max1,"\n");
					line7 =  strcat(strpad(rolepad,strcat("\s[5]\s ",MCPROLEDICT[ROLE_FIENDHUMAN].namestr))," ",curr1,div,max1,"\n");
					line8 =  strcat(strpad(rolepad,strcat("\s[6]\s ",MCPROLEDICT[ROLE_FIENDHUMAN].namestr))," ",curr1,div,max1,"\n");
					line9 =  strcat(strpad(rolepad,strcat("\s[7]\s ",MCPROLEDICT[ROLE_FIENDHUMAN].namestr))," ",curr1,div,max1,"\n");
					line10 =  strcat(strpad(rolepad,strcat("\s[8]\s ",MCPROLEDICT[ROLE_FIENDHUMAN].namestr))," ",curr1,div,max1,"\n");
					line11 =  strcat(strpad(rolepad,strcat("\s[9]\s ",MCPROLEDICT[ROLE_FIENDHUMAN].namestr))," ",curr1,div,max1,"\n");
					
				}
				else
				{
					line3 =  strcat(strpad(rolepad,strcat("\s[1]\s ",MCPROLEDICT[ROLE_FIEND].namestr))," ",curr2,div,max2,"\n");
					line4 =  strcat(strpad(rolepad,strcat("\s[2]\s ",MCPROLEDICT[ROLE_FIEND].namestr))," ",curr2,div,max2,"\n");
					line5 =  strcat(strpad(rolepad,strcat("\s[3]\s ",MCPROLEDICT[ROLE_FIEND].namestr))," ",curr2,div,max2,"\n");
					line6 =  strcat(strpad(rolepad,strcat("\s[4]\s ",MCPROLEDICT[ROLE_FIEND].namestr))," ",curr2,div,max2,"\n");
					line7 =  strcat(strpad(rolepad,strcat("\s[5]\s ",MCPROLEDICT[ROLE_FIEND].namestr))," ",curr2,div,max2,"\n");
					line8 =  strcat(strpad(rolepad,strcat("\s[6]\s ",MCPROLEDICT[ROLE_FIEND].namestr))," ",curr2,div,max2,"\n");
					line9 =  strcat(strpad(rolepad,strcat("\s[7]\s ",MCPROLEDICT[ROLE_FIEND].namestr))," ",curr2,div,max2,"\n");
					line10 =  strcat(strpad(rolepad,strcat("\s[8]\s ",MCPROLEDICT[ROLE_FIEND].namestr))," ",curr2,div,max2,"\n");
					line11 =  strcat(strpad(rolepad,strcat("\s[9]\s ",MCPROLEDICT[ROLE_FIEND].namestr))," ",curr2,div,max2,"\n");
				}

				line12 = "\n";
				line13 = "\n";
				line14 = "\n";
				line15 = "\n";
				line16 = "\n";
				line17 = "\n";
				line18 = "\n";
				line19 = "\n";
				line20 = "\n";
				line21 = "\n";
				line22 = "\n";
				line23 = "\n";
				line24 = "\n";
				line25 = "\n";
				line26 = "\n";
				line27 = "\n";
				line28 = "\n";
				line29 = "\n";
				line30 = "\n";
				line31 = "\n";
				line32 = "\n";
				line33 = "\n";
				line34 = "\n";
				line35 = "\n";

			}
			if(mcpmode == MCPMODE_BABYFIEND)
			{
				header = "select role";
				//role1 = strpad(rolepad,strcat("\s[1]\s ",MCPROLEDICT[ROLE_HUNTER].namestr));
				//role2 = strpad(rolepad,strcat("\s[2]\s ",MCPROLEDICT[ROLE_BABYFIEND].namestr));
				
				curr1 = strpad(currpad,ftos(GetRoleCount(ROLE_HUNTER, e.team_no)));
				curr2 = strpad(currpad,ftos(GetRoleCount(ROLE_BABYFIEND, e.team_no)));
				
				max1 = strpad(maxpad,ftos(GetRoleMax(ROLE_HUNTER, e.team_no)));
			        max2 = strpad(maxpad,ftos(GetRoleMax(ROLE_BABYFIEND, e.team_no)));
			        
			        line1  = strcat(header,"\n");
				line2 = "\n";
				if(e.team_no == MCPTEAM_BLUE)
				{
					line3 =  strcat(strpad(rolepad,strcat("\s[1]\s ",MCPROLEDICT[ROLE_HUNTER].namestr))," ",curr1,div,max1,"\n");
					line4 =  strcat(strpad(rolepad,strcat("\s[2]\s ",MCPROLEDICT[ROLE_HUNTER].namestr))," ",curr1,div,max1,"\n");
					line5 =  strcat(strpad(rolepad,strcat("\s[3]\s ",MCPROLEDICT[ROLE_HUNTER].namestr))," ",curr1,div,max1,"\n");
					line6 =  strcat(strpad(rolepad,strcat("\s[4]\s ",MCPROLEDICT[ROLE_HUNTER].namestr))," ",curr1,div,max1,"\n");
					line7 =  strcat(strpad(rolepad,strcat("\s[5]\s ",MCPROLEDICT[ROLE_HUNTER].namestr))," ",curr1,div,max1,"\n");
					line8 =  strcat(strpad(rolepad,strcat("\s[6]\s ",MCPROLEDICT[ROLE_HUNTER].namestr))," ",curr1,div,max1,"\n");
					line9 =  strcat(strpad(rolepad,strcat("\s[7]\s ",MCPROLEDICT[ROLE_HUNTER].namestr))," ",curr1,div,max1,"\n");
					line10 =  strcat(strpad(rolepad,strcat("\s[8]\s ",MCPROLEDICT[ROLE_HUNTER].namestr))," ",curr1,div,max1,"\n");
					line11 =  strcat(strpad(rolepad,strcat("\s[9]\s ",MCPROLEDICT[ROLE_HUNTER].namestr))," ",curr1,div,max1,"\n");
				}
				else
				{
					line3 =  strcat(strpad(rolepad,strcat("\s[1]\s ",MCPROLEDICT[ROLE_BABYFIEND].namestr))," ",curr2,div,max2,"\n");
					line4 =  strcat(strpad(rolepad,strcat("\s[2]\s ",MCPROLEDICT[ROLE_BABYFIEND].namestr))," ",curr2,div,max2,"\n");
					line5 =  strcat(strpad(rolepad,strcat("\s[3]\s ",MCPROLEDICT[ROLE_BABYFIEND].namestr))," ",curr2,div,max2,"\n");
					line6 =  strcat(strpad(rolepad,strcat("\s[4]\s ",MCPROLEDICT[ROLE_BABYFIEND].namestr))," ",curr2,div,max2,"\n");
					line7 =  strcat(strpad(rolepad,strcat("\s[5]\s ",MCPROLEDICT[ROLE_BABYFIEND].namestr))," ",curr2,div,max2,"\n");
					line8 =  strcat(strpad(rolepad,strcat("\s[6]\s ",MCPROLEDICT[ROLE_BABYFIEND].namestr))," ",curr2,div,max2,"\n");
					line9 =  strcat(strpad(rolepad,strcat("\s[7]\s ",MCPROLEDICT[ROLE_BABYFIEND].namestr))," ",curr2,div,max2,"\n");
					line10 =  strcat(strpad(rolepad,strcat("\s[8]\s ",MCPROLEDICT[ROLE_BABYFIEND].namestr))," ",curr2,div,max2,"\n");
					line11 =  strcat(strpad(rolepad,strcat("\s[9]\s ",MCPROLEDICT[ROLE_BABYFIEND].namestr))," ",curr2,div,max2,"\n");
				}

				line12 = "\n";
				line13 = "\n";
				line14 = "\n";
				line15 = "\n";
				line16 = "\n";
				line17 = "\n";
				line18 = "\n";
				line19 = "\n";
				line20 = "\n";
				line21 = "\n";
				line22 = "\n";
				line23 = "\n";
				line24 = "\n";
				line25 = "\n";
				line26 = "\n";
				line27 = "\n";
				line28 = "\n";
				line29 = "\n";
				line30 = "\n";
				line31 = "\n";
				line32 = "\n";
				line33 = "\n";
				line34 = "\n";
				line35 = "\n";
			}
			break;
		}
			
	}
	
	local string res = strcat(line1,line2,line3,line4,line5);
	res = strcat(res,line6,line7,line8,line9,line10);
	res = strcat(res,line11,line12,line13,line14,line15);
	res = strcat(res,line16,line17,line18,line19,line20);
	res = strcat(res,line21,line22,line23,line24,line25);
	res = strcat(res,line26,line27,line28,line29,line30);
	res = strcat(res,line31,line32,line33,line34,line35);
	return res;
};