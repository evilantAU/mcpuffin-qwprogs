void mcp_AdminTryChangeMode(entity e, float m) = 
{
	e.impulse = 0;

	if(mcpmode == m)
	{
		stufferror(e,"error: currently in that mode");
		return;
	}
	local string m2 = mcp_ModeString(m,1); //make sure to use abbrv
	if(m2 == "")
	{
		stufferror(e,"error: that mode doesn't exist");
		return;
	}

};

void mcp_NextSlot(entity e, float dir) =
{
	e.impulse = 0;
	if (e.reloadingweapon != MCPWEAP_NONE)
		return;
	local float newslot = e.weapon;
	local float failsafe = 0;
	while(failsafe<10)
	{
		failsafe++;
		newslot = newslot + dir;
		if (newslot < MCPSLOT1)
			newslot = MCPSLOT4;
		if (newslot > MCPSLOT4)
			newslot = MCPSLOT1;
		if (e.mcpslot[newslot].type != MCPWEAP_NONE)
		{
			if(newslot != e.weapon)
				mcp_ChangeSlot(e,newslot);
			break;
		}
	}	
};


float mcp_IsQuickSlottingThis(entity e, float weap) =
{
	local float qs = mcp_GetQuickSlot(e);
	if(qs == MCPSLOTNONE)
	{
		if(weap == MCPWEAP_NONE)
			return 1;
	
		return 0;
	}
	if(e.mcpslot[qs].type == weap)
		return 1;
	
	return 0;
};

float mcp_GetQuickSlot(entity e) =
{
	local float slot = MCPSLOTNONE;
	
	local float i = 0;
	for(i=0; i<mcpslot.length; i++)
	{
		if(e.mcpslot[i].quickshotstart > 0 && e.mcpslot[i].type != MCPWEAP_NONE)
			if(slot == MCPSLOTNONE)
				slot = i;
			else
			{
				if(e.mcpslot[i].quickshotstart > e.mcpslot[slot].quickshotstart)
					slot = i;
			}
	}
	
	return slot;
};

void mcp_StartQuickSlot(entity e, float slot) =
{
	e.impulse = 0;
	if(slot > mcpslot.length || slot < MCPSLOT1)
	{
		bprint(2,"mcp_startquickslot() error\n");
		return;
	}
	if(e.mcpslot[slot].type == MCPWEAP_NONE)
	{
		stuffnotice(e,"no weapon in slot.");
		return;
	}
	e.mcpslot[slot].quickshotstart = time;
};

void mcp_StopQuickSlot(entity e, float slot) =
{
	e.impulse = 0;
	
	if(slot > mcpslot.length || slot < 0)
	{
		bprint(2,"mcp_stopquickslot() error\n");
		return;
	}
	e.mcpslot[slot].quickshotstart = -1;
};

void mcp_TogglePlayerReady(entity e, float rs) =
{
	e.impulse = 0;
	if(e.team_no == MCPTEAM_NONE)
		return;
	if(e.team_no == ROLE_NONE)
		return;

	if(matchstate == MATCHSTATE_LIVE)
	{
		stufferror(e, "match is already live.");
		return;
	}
	
	if(rs == READYSTATE_NOT || rs == READYSTATE_READY)
	{
		if(e.is_ready == READYSTATE_NOT)
		{
			e.is_ready = READYSTATE_READY;
			bprint(2, strcat(e.netname," is \sready\s to play!\n"));
			stuffsound(e, SND_READY);
		}
		else
		{
			e.is_ready = READYSTATE_NOT;
			bprint(2, strcat(e.netname," is now \snot ready\s. boo! hiss!\n"));
			stuffsound(e, SND_NOTREADY);
		}
	}
	else if (rs == READYSTATE_FORCE)
	{
		if(e.is_ready == READYSTATE_FORCE)
		{
			e.is_ready = READYSTATE_NOT;
			bprint(2, strcat(e.netname," is now \snot ready\s. boo! hiss!\n"));
			stuffsound(e, SND_NOTREADY);
		}
		else
		{
			e.is_ready = READYSTATE_FORCE;
			//bprint(2, strcat(e.netname," is \sready\s and wants to \sforcestart\s!\n"));
			stuffsound(e, SND_READY);
			
			local float forcestarters = 0;
			local float totalplayers = 0;
			local entity te = find(world, classname, CN_PLAYER);
			while(te)
			{
				if(te != world && te.has_disconnected == 0 && te.team_no != MCPTEAM_NONE)
				{
					totalplayers = totalplayers + 1;
					if(te.is_ready == READYSTATE_FORCE)
					{

						forcestarters = forcestarters + 1;
					}

				}
				te = find(te,classname,CN_PLAYER);
			}
			local float needed = rint(totalplayers / 2);
			if(forcestarters >= needed)
			{
				bprint(2, strcat(self.netname," is \sready\s and wants to \sforcestart\s!\nforcestart successful, good luck!.\n"));
			}
			else
			{
				bprint(2, strcat(self.netname," is \sready\s and wants to \sforcestart\s! [", ftos(needed-forcestarters),"] more needed.\n"));
			}
			
		}
	}

};

void mcp_MenuInput(entity e, float imp) =
{
	e.impulse = 0;
	
	if(e.cprinter.cnt == CPRINT_WELCOME)
	{
		if(mcpmode == MCPMODE_COINSFFA)
		{
			mcp_AssignFFATeam(e);
			return;
		}
		else
		{
			cprint(e, CPRINT_SELECTTEAM);
			return;
		}
	}


	
	if(e.cprinter.cnt == CPRINT_SELECTTEAM)
	{
		if(imp == 1)
			mcp_TryJoinTeam(e,MCPTEAM_BLUE);
	
		if(imp == 2)
			mcp_TryJoinTeam(e,MCPTEAM_RED);
		if(imp == 5)
			mcp_TryJoinTeam(e,MCPTEAM_AUTO);
		if(imp == 6)
			mcp_ToggleTeamBalance(e);
		return;
	}
	if(e.cprinter.cnt == CPRINT_SELECTROLE)
	{
		if(mcpmode == MCPMODE_FIEND)
		{
			if(imp >= 1 && imp <= 9)
			{
				if(e.team_no == MCPTEAM_BLUE)
					mcp_TrySetRole(e,ROLE_FIENDHUMAN);
				if(e.team_no == MCPTEAM_RED)
					mcp_TrySetRole(e,ROLE_FIEND);
				
			}
		}
		if(mcpmode == MCPMODE_BABYFIEND)
		{	
			if(e.team_no == MCPTEAM_BLUE)
				mcp_TrySetRole(e,ROLE_HUNTER);
			if(e.team_no == MCPTEAM_RED)
				mcp_TrySetRole(e,ROLE_BABYFIEND);
		}
		
		if(imp == 1)
		{
			if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
				mcp_TrySetRole(e,ROLE_RECON);
			if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
				mcp_TrySetSpecial(e,MCPSPECIAL_DASH);
		}
		if(imp == 2)
		{
			if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
				mcp_TrySetRole(e,ROLE_ASSASSIN);
			if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
				mcp_TrySetSpecial(e,MCPSPECIAL_CLOAK);
		}
		if(imp == 3)
		{
			if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
				mcp_TrySetRole(e,ROLE_FIGHTER);
			if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
				mcp_TrySetSpecial(e,MCPSPECIAL_HARPOON);
		}
		if(imp == 4)
		{
			if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
				mcp_TrySetRole(e,ROLE_BOMBER);
			if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
				mcp_TrySetSpecial(e,MCPSPECIAL_DETROCKET);
		}
		if(imp == 5)
		{
			if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
				mcp_TrySetRole(e,ROLE_DOCTOR);
			if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
				mcp_TrySetSpecial(e,MCPSPECIAL_TELEBALL);
		}
		if(imp == 6)
		{
			if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
				mcp_TrySetRole(e,ROLE_MINIGUNNER);
			if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
				mcp_TrySetSpecial(e,MCPSPECIAL_LEAP);
		}
		if(imp == 7)
		{
			if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
				mcp_TrySetRole(e,ROLE_ARSONIST);
			if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
				mcp_TrySetSpecial(e,MCPSPECIAL_AIRBLAST);
		}
		if(imp == 8)
		{
			if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
				mcp_TrySetRole(e,ROLE_TECHNICIAN);
		}
		if(imp == 9)
		{
			if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
				mcp_TrySetRole(e,ROLE_RANDOM);
			if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
				mcp_TrySetSpecial(e,MCPSPECIAL_RANDOM);
		}
		return;
	}
	if(e.cprinter.cnt == CPRINT_VOTEMODE)
	{
		if(imp == 1)
		{
			mcp_CastModeVote(e,1);
		}
		if(imp == 2)
		{
			mcp_CastModeVote(e,2);
		}
		if(imp == 3)
		{
			mcp_CastModeVote(e,3);
		}
		if(imp == 4)
		{
			mcp_CastModeVote(e,4);
		}
		if(imp == 5)
		{
			mcp_CastModeVote(e,5);
		}
		if(imp == 6)
		{
			mcp_CastModeVote(e,6);
		}
		if(imp == 7)
		{
			
		}
		if(imp == 8)
		{
			
		}
		if(imp == 9)
		{
			
		}
		return;
	}
	if(e.cprinter.cnt == CPRINT_VOTEMAP)
	{
		if(imp == 1)
		{
			mcp_CastMapVote(e,1);
		}
		if(imp == 2)
		{
			mcp_CastMapVote(e,2);
		}
		if(imp == 3)
		{
			mcp_CastMapVote(e,3);
		}
		if(imp == 4)
		{
			mcp_CastMapVote(e,4);
		}
		if(imp == 5)
		{
			mcp_CastMapVote(e,5);
		}
		if(imp == 6)
		{
			mcp_CastMapVote(e,6);	
		}
		if(imp == 7)
		{
			mcp_CastMapVote(e,7);
		}
		if(imp == 8)
		{
			mcp_CastMapVote(e,8);
		}
		if(imp == 9)
		{
			mcp_CastMapVote(e,9);
		}
		return;
	}
};

void mcp_ChangeTeamMenu(entity e) =
{		
	e.impulse = 0;
		
	cprint(e,CPRINT_SELECTTEAM);
};

void mcp_ToggleTeamBalance(entity e) =
{
	e.impulse = 0;
	if(e.cprinter.cnt == CPRINT_SELECTTEAM)
		cprint(e, CPRINT_NONE);
	if(e.team_loser == 1)
	{
		bprint(2, strcat(e.netname, " no longer wants to be autobalanced every respawn.\n"));
		e.team_loser = 0;
	}
	else
	{
		bprint(2, strcat(e.netname, " wants to be autobalanced every respawn.\n"));
		e.team_loser = 1;
		
	}
	if(e.team_no == MCPTEAM_NONE)
		mcp_TryJoinTeam(e,MCPTEAM_LOSER);
	
			
};

void mcp_SwapTeam(entity e) =
{		
	e.impulse = 0;
	
	if(e.team_no == MCPTEAM_RED)
		mcp_TryJoinTeam(e, MCPTEAM_BLUE);
		
	if(e.team_no == MCPTEAM_BLUE)
		mcp_TryJoinTeam(e, MCPTEAM_RED);

};

void mcp_ChangeRoleMenu(entity e) =
{
	e.impulse = 0;
	if(mcpmode == MCPMODE_BABYFIEND || mcpmode == MCPMODE_FIEND)
	{
		cprint(e,CPRINT_SELECTTEAM);
	}
	if(e.team_no == MCPTEAM_NONE )
	{
		stufferror(e,"you must join a team first.zzzz");
		return;
	}
	cprint(e,CPRINT_SELECTROLE);
};




void mcp_ImpulseCaptureMenuOption(entity e) =
{	
	if(e.cprinter.cnt == CPRINT_NONE)
		return;
		
	if (e.impulse >= 1 && e.impulse <= 10)
		mcp_MenuInput(e, e.impulse);
};

void mcp_ImpulseCaptureAttackFinished(entity e) = 
{
	if(infokey(e, IK_FLIPSLOTS) == "1")
	{
		if (e.impulse == MCPIMPULSE_KEYBOARD1)
			mcp_ChangeSlot (e,MCPSLOT1);
		if (e.impulse == MCPIMPULSE_KEYBOARD2)
			mcp_ChangeSlot (e,MCPSLOT2);
		if (e.impulse == MCPIMPULSE_KEYBOARD3)
			mcp_ChangeSlot (e,MCPSLOT3);
		if (e.impulse == MCPIMPULSE_KEYBOARD4)
			mcp_ChangeSlot (e,MCPSLOT4);
	}
	else
	{
		if (e.impulse == MCPIMPULSE_KEYBOARD1)
			mcp_ChangeSlot (e,MCPSLOT4);
		if (e.impulse == MCPIMPULSE_KEYBOARD2)
			mcp_ChangeSlot (e,MCPSLOT3);
		if (e.impulse == MCPIMPULSE_KEYBOARD3)
			mcp_ChangeSlot (e,MCPSLOT2);
		if (e.impulse == MCPIMPULSE_KEYBOARD4)
			mcp_ChangeSlot (e,MCPSLOT1);		
	}


	if (e.impulse == MCPIMPULSE_RELOAD)
	{	
		if(mcp_VisibleWeapon(e) == MCPWEAP_MINIGUN || e.reloadingweapon != 0)
		{
			e.impulse = 0;
			return;
		}
			
		mcp_ReloadWeapon(e,mcp_VisibleWeapon(e));
	}
	if(e.impulse == MCPIMPULSE_RELOADNEXT)
	{
		mcp_ReloadNext(e);
	}
	if(e.impulse == MCPIMPULSE_NEXTSLOT)
		mcp_NextSlot(e, 1);
	if(e.impulse == MCPIMPULSE_PREVSLOT)
		mcp_NextSlot(e, -1);
	if(e.impulse == MCPIMPULSE_LASTSLOT)
		mcp_LastSlot(e);
		
};

void mcp_ImpulseCaptureDeadOrAlive(entity e) =
{
	if (e.impulse == MCPIMPULSE_CHANGETEAM)
	{

		mcp_ChangeTeamMenu(e);
	}
			
	if (e.impulse == MCPIMPULSE_SWAPTEAM)
	{
		mcp_SwapTeam(e);
	}	
	if(e.impulse == MCPIMPULSE_JOINRED)
	{	

		mcp_TryJoinTeam(e,MCPTEAM_RED);

	}	
	if(e.impulse == MCPIMPULSE_JOINBLUE)
	{

		mcp_TryJoinTeam(e,MCPTEAM_BLUE);
	}
		
	if(e.impulse == MCPIMPULSE_JOINLOSER)
	{
		mcp_ToggleTeamBalance(e);
	}
		
	if (e.impulse == MCPIMPULSE_CHANGEROLE)
		mcp_ChangeRoleMenu(e);
		
	if(infokey(e, IK_FLIPSLOTS) == "1")
	{
		if(e.impulse == MCPIMPULSE_QCKSLOT1_STOP)
			mcp_StopQuickSlot(e,MCPSLOT1);
		if(e.impulse == MCPIMPULSE_QCKSLOT2_STOP)
			mcp_StopQuickSlot(e,MCPSLOT2);
		if(e.impulse == MCPIMPULSE_QCKSLOT3_STOP)
			mcp_StopQuickSlot(e,MCPSLOT3);
		if(e.impulse == MCPIMPULSE_QCKSLOT4_STOP)
			mcp_StopQuickSlot(e,MCPSLOT4);	
			
		if(e.impulse == MCPIMPULSE_QCKSLOT1_START)
			mcp_StartQuickSlot(e,MCPSLOT1);
		if(e.impulse == MCPIMPULSE_QCKSLOT2_START)
			mcp_StartQuickSlot(e,MCPSLOT2);
		if(e.impulse == MCPIMPULSE_QCKSLOT3_START)
			mcp_StartQuickSlot(e,MCPSLOT3);
		if(e.impulse == MCPIMPULSE_QCKSLOT4_START)
			mcp_StartQuickSlot(e,MCPSLOT4);
		
	
	}
	else
	{
		if(e.impulse == MCPIMPULSE_QCKSLOT1_STOP)
			mcp_StopQuickSlot(e,MCPSLOT4);
		if(e.impulse == MCPIMPULSE_QCKSLOT2_STOP)
			mcp_StopQuickSlot(e,MCPSLOT3);
		if(e.impulse == MCPIMPULSE_QCKSLOT3_STOP)
			mcp_StopQuickSlot(e,MCPSLOT2);
		if(e.impulse == MCPIMPULSE_QCKSLOT4_STOP)
			mcp_StopQuickSlot(e,MCPSLOT1);	
		if(e.impulse == MCPIMPULSE_QCKSLOT1_START)
			mcp_StartQuickSlot(e,MCPSLOT4);
		if(e.impulse == MCPIMPULSE_QCKSLOT2_START)
			mcp_StartQuickSlot(e,MCPSLOT3);
		if(e.impulse == MCPIMPULSE_QCKSLOT3_START)
			mcp_StartQuickSlot(e,MCPSLOT2);
		if(e.impulse == MCPIMPULSE_QCKSLOT4_START)
			mcp_StartQuickSlot(e,MCPSLOT1);
			
	
	}

	
	if (e.impulse == MCPIMPULSE_GORECON)
	{
		if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
			mcp_TrySetRole(e,ROLE_RECON);
		if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
			mcp_TrySetSpecial(e,MCPSPECIAL_DASH);
	}
		
	if (e.impulse == MCPIMPULSE_GOASSASSIN)
	{
		if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
			mcp_TrySetRole(e,ROLE_ASSASSIN);
		if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
			mcp_TrySetSpecial(e,MCPSPECIAL_CLOAK);
	}
	
	if (e.impulse == MCPIMPULSE_GOFIGHTER)
	{
		if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
			mcp_TrySetRole(e,ROLE_FIGHTER);
		if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
			mcp_TrySetSpecial(e,MCPSPECIAL_HARPOON);
	}
		
	if (e.impulse == MCPIMPULSE_GOBOMBER)
	{
		if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
			mcp_TrySetRole(e,ROLE_BOMBER);
		if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
			mcp_TrySetSpecial(e,MCPSPECIAL_DETROCKET);
	}
	
	if (e.impulse == MCPIMPULSE_GODOCTOR)
	{
		if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
			mcp_TrySetRole(e,ROLE_DOCTOR);
		if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
			mcp_TrySetSpecial(e,MCPSPECIAL_TELEBALL);
	}
		
	if (e.impulse == MCPIMPULSE_GOMINIGUNNER)
	{
		if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
			mcp_TrySetRole(e,ROLE_MINIGUNNER);
		if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
			mcp_TrySetSpecial(e,MCPSPECIAL_LEAP);
	}
		
	if (e.impulse == MCPIMPULSE_GOARSONIST )
	{
		if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
			mcp_TrySetRole(e,ROLE_ARSONIST);
		if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
			mcp_TrySetSpecial(e,MCPSPECIAL_AIRBLAST);
	}
		
	if (e.impulse == MCPIMPULSE_GOTECHNICIAN)
	{
		if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
			mcp_TrySetRole(e,ROLE_TECHNICIAN);
	}
		
	if (e.impulse == MCPIMPULSE_GORANDOM)
	{
		if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
			mcp_TrySetRole(e,ROLE_RANDOM);
		if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
			mcp_TrySetSpecial(e,MCPSPECIAL_RANDOM);
	}
		
	if(e.impulse == MCPIMPULSE_FORCESTART)
		mcp_TogglePlayerReady(e,READYSTATE_FORCE);
	if(e.impulse == MCPIMPULSE_READY)
		mcp_TogglePlayerReady(e,READYSTATE_READY);
	if(e.impulse == MCPIMPULSE_CHANGEMODESACRIFICE)
	{
		e.impulse = 0;
		mcp_ChangeMode(e,MCPMODE_SACRIFICE);
		
	}
	if(e.impulse == MCPIMPULSE_CHANGEMODEFIEND)
	{
		e.impulse = 0;
		mcp_ChangeMode(e,MCPMODE_FIEND);
	}
	if(e.impulse == MCPIMPULSE_CHANGEMODECOINSTEAM)
	{
		e.impulse = 0;
		mcp_ChangeMode(e,MCPMODE_COINSTEAM);
	}
	if(e.impulse == MCPIMPULSE_CHANGEMODECOINSFFA)
	{
		e.impulse = 0;
		mcp_ChangeMode(e,MCPMODE_COINSFFA);
	}
	if(e.impulse == MCPIMPULSE_CHANGEMODEBABYFIEND)
	{
		e.impulse = 0;
		mcp_ChangeMode(e,MCPMODE_BABYFIEND);
	}
	if(e.impulse == MCPIMPULSE_CHANGEMODE5CP)
	{
		e.impulse = 0;
		mcp_ChangeMode(e,MCPMODE_5CP);
	}
	if(e.impulse == MCPIMPULSE_FORCESTARTALL)
	{
		e.impulse = 0;
		stuffcmd(e,strcat("rcon localinfo ", IK_FORCESTART," 1\n"));
	}
	if(e.impulse == MCPIMPULSE_FORCEVOTE)
	{
		e.impulse = 0;
		bprint(2,strcat(e.netname, " is forcing a vote\n"));
		mcp_ForceVote();
	}
	
	if(e.impulse == MCPIMPULSE_1HP)
	{
		
		e.impulse = 0;
		RandomRoleTester(e);
		//bluescore = 100;
	}
};

void mcp_ImpulseCaptureAlive(entity e) =
{

	if (e.impulse == MCPIMPULSE_THROWGOAL)
	{
		mcp_ThrowMCPFlag(e);
	}	
	if (e.impulse == MCPIMPULSE_SPECIAL)
	{
		mcp_SpecialSkill(e);
	}
		
	if(e.impulse == MCPIMPULSE_2TAPGREN)
	{
		if(self.mcpgren != world)
			mcp_ThrowGrenade(e);
		else
			mcp_PrimeGrenade(e);
	}
	if(e.impulse == MCPIMPULSE_THROWGREN)
	{
		mcp_ThrowGrenade(e);
	}
	if(e.impulse == MCPIMPULSE_PRIMEGREN)
	{
		mcp_PrimeGrenade(e);
	}
		
	if (e.impulse == MCPIMPULSE_RELOAD && mcp_VisibleWeapon(e) == MCPWEAP_MINIGUN)
	{
		e.impulse = 0;
		
		if(e.mcpslot[mcp_GetSlotContaining(e, MCPWEAP_MINIGUN)].clipcount >= MCPWEAPDICT[MCPWEAP_MINIGUN].clipsize)
			return;
		
		if(e.mcpweapstate != MCPWEAPSTATE_NONE)
		{
			e.mgun_queuereload = 1;
			return;
		}
		
		mcp_ReloadWeapon(e,MCPWEAP_MINIGUN);
	}
};