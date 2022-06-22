void mcp_muzzleflash (entity e) = 
{
	WriteByte(MSG_MULTICAST, SVC_MUZZLEFLASH);
	WriteEntity(MSG_MULTICAST, e);
	multicast(e.origin, MULTICAST_PVS);
};

void mcp_ChangeWeaponModel(entity e, float wpn, float preserveframe) =
{
	//mcpplayer_run ();          // get out of any weapon firing states

	if (e.team_no == MCPTEAM_BLUE)
	{
		e.weaponmodel = MCPWEAPDICT[wpn].modelblue;
	}
	else
	{
		e.weaponmodel = MCPWEAPDICT[wpn].modelred;
	}
	if(e.iscloaked == 1)
	{
		e.weaponmodel = MCPWEAPDICT[wpn].modelgrey;
	}
	if(!preserveframe)
		e.weaponframe = 0;		
};

float mcp_VisibleWeapon (entity e) =
{
	local string s = e.weaponmodel;
	local int i;
	
	for(i=0;i<MCPWEAPDICT.length;i++)
	{
		if(MCPWEAPDICT[i].modelblue == s || MCPWEAPDICT[i].modelred == s || MCPWEAPDICT[i].modelgrey == s)
			return MCPWEAPDICT[i].type;
	
	}
	bprint(2,strcat("visibleweapon error: ",s,"\n"));
	return 0;
};


void mcp_UpdateHudAmmo(entity e, float wpn) =
{
	e.items = e.items - ( e.items & ( IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS) );
	e.items = e.items | MCPWEAPDICT[wpn].ammotype;
	if(e.mcpweapstate == MCPWEAPSTATE_DRONE || e.mcpweapstate == MCPWEAPSTATE_DRONESHOOT)
	{
		e.currentammo = 999;
		return;
	}
	if(wpn == MCPWEAP_RLUNLIM || wpn == MCPWEAP_SHAFTUNLIM)
	{
		e.currentammo = 999;
		return;

	}
		
	e.currentammo = e.mcpslot[mcp_GetSlotContaining(e,wpn)].clipcount;
};

void mcp_WeaponFrame (entity e) =
{
	
	mcp_RegenCells(e);
	mcp_ImpulseCaptureMenuOption(e);
	mcp_ImpulseCaptureDeadOrAlive(e);
	mcp_ImpulseCaptureAlive(e);

	if (time < e.attack_finished)
		return;
		
	if (e.reloadingweapon != MCPWEAP_NONE)
	{
		if(e.weaponmodel != "")
		{
			e.weaponmodel = "";
			e.weaponframe = 0;
		}
		return;	
	}

	mcp_ImpulseCaptureAttackFinished(e);
	
	if(e.iscloaked == 1)
		return;
	local float qslot = mcp_GetQuickSlot(e);
	
	float wtype;
	if(e.mcpweapstate == MCPWEAPSTATE_DRONE || e.mcpweapstate == MCPWEAPSTATE_DRONESHOOT)
		wtype = MCPWEAP_DRONEGUN;
	else if(qslot != MCPSLOTNONE)
		wtype = e.mcpslot[qslot].type;
	else 
		wtype = e.mcpslot[e.weapon].type;
		

	if(mcp_VisibleWeapon(e) != wtype)
	{
		mcp_ChangeWeaponModel(e,wtype,0);
		mcp_UpdateHudAmmo(e,wtype);
	}
	
	if(qslot != MCPSLOTNONE)
	{	
		mcp_Attack(e,qslot);
		return;
	}
	
	if (e.button0)
	{
		mcp_Attack (e,e.weapon);
		return;
	}
};