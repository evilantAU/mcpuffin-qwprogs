void() item_health              	= {remove(self);};
void() item_megahealth_rot      	= {remove(self);};
void() item_armor1              	= {remove(self);};
void() item_armor2              	= {remove(self);};
void() item_armorInv            	= {remove(self);};
void() item_shells              	= {remove(self);};
void() item_spikes              	= {remove(self);};
void() item_rockets             	= {remove(self);};
void() item_cells               	= {remove(self);};
void() item_key1               	 	= {remove(self);};
void() item_key2               		= {remove(self);};
void() item_artifact_invulnerability 	= {remove(self);};
void() item_artifact_envirosuit 	= {remove(self);};
void() item_artifact_invisibility 	= {remove(self);};
void() item_artifact_super_damage 	= {remove(self);};
void() item_weapon 			= {remove(self);};

void() weapon_supershotgun		= {remove(self);};
void() weapon_nailgun			= {remove(self);};
void() weapon_supernailgun		= {remove(self);};
void() weapon_grenadelauncher		= {remove(self);};
void() weapon_rocketlauncher		= {remove(self);};
void() weapon_lightning			= {remove(self);};

void() info_intermission =
{
	self.angles = self.mangle;      // so C can get at it
};

void() info_player_start =
{
};

void() info_player_start2 =
{
};

void() info_player_deathmatch =
{
};

void () info_player_teamspawn = 
{

};
void() info_player_coop =
{
};
void () i_p_t = {
    self.classname = "info_player_teamspawn";
    info_player_teamspawn();
};
void () SetChangeParms = 
{
};

void () SetNewParms = 
{
};

void () DecodeLevelParms =
{
};


void () ClientKill = 
{
	if(mcpenabled)
	{
		mcp_ClientKill(self);
		return;
	}

};

void () PutClientInServer = 
{

	if(mcpenabled)
	{
		mcp_PutClientInServer();
		return;
	}
};




.float dmgtime;





void () PlayerPreThink = {

	if(mcpenabled)
	{
		mcp_PlayerPreThink(self);
		return;
	}

};


void () PlayerPostThink = {

	if(mcpenabled)
	{
		mcp_PlayerPostThink(self);
		return;
	}
};



//do not rely on csqcactive - it may misbehave when using `join` from spectator
void (optional float csqcactive) ClientConnect = 
{

	if(mcpenabled)
	{
		mcp_ClientConnect();
		return;
	}

};


void () ClientDisconnect = 
{

	if(mcpenabled)
	{
		mcp_ClientDisconnect();
		return;
	}

};



