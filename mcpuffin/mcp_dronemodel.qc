void () mcpdrone_stand =[6, mcpdrone_stand] 
{
	self.weaponframe=0;
	self.mcpweapstate = MCPWEAPSTATE_DRONE;
	mcp_SetPlayerSpeed(self);
};

void () mcpdrone_attack1 =[7, mcpdrone_attack2] 
{
	if(self.mcpweapstate == MCPWEAPSTATE_NONE)
		return;
	mcp_muzzleflash(self);
	self.mcpweapstate = MCPWEAPSTATE_DRONESHOOT;
	mcp_SetPlayerSpeed(self);
	
	if(mcp_GetQuickSlot(self) == MCPSLOTNONE)
	{	
		if(!self.button0)
		{
			mcpdrone_stand();
			return;
		}
	}

	self.weaponframe = self.weaponframe + 1;
	
	if (self.weaponframe == 9) 
	{
		self.weaponframe = 1;
	}
	mcp_ShootDroneGun(self,4);
	self.attack_finished = time + 0.2;
};

void () mcpdrone_attack2 =[8, mcpdrone_attack1] 
{
	if(self.mcpweapstate == MCPWEAPSTATE_NONE)
		return;
	mcp_muzzleflash(self);
	self.mcpweapstate = MCPWEAPSTATE_DRONESHOOT;
	mcp_SetPlayerSpeed(self);
	
	if(mcp_GetQuickSlot(self) == MCPSLOTNONE)
	{	
		if(!self.button0)
		{
			mcpdrone_stand();
			return;
		}
	}
	
	self.weaponframe = self.weaponframe + 1;
	
	if (self.weaponframe == 9) 
	{
		self.weaponframe = 1;
	}
	mcp_ShootDroneGun(self,-4);
	self.attack_finished = time + 0.2;
};
