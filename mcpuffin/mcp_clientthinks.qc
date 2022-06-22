
void mcp_SetNextRespawn (entity ent, float sui) =
{
	if(matchstate == MATCHSTATE_LIVE)
	{
		if(sui == 1)
		{
			ent.respawn_time = time + RESPAWNPENALTY_SUICIDE;
			sprint(ent, PRINT_HIGH, strcat("you can respawn in ", ftos(RESPAWNPENALTY_SUICIDE), " seconds.\n"));
			return;
		}
		
		//if(mcpflag.playerstate == MCPFLAGSTATE_CAPPED && mcpflag.team_no == ent.team_no)
		//{
		//	ent.nextrespawn = time + RESPAWNPENALTY_INCONTROL;
		//	sprint(ent, PRINT_HIGH, strcat("you can respawn in ", ftos(RESPAWNPENALTY_INCONTROL), " seconds.\n"));
		//	return;
		//}
	}
		
	ent.respawn_time = time + RESPAWNPENALTY_OUTOFCONTROL;
	
};


void mcp_PlayerJump (entity e) =
{
	
	if(e.deadflag > 0)
		return;

	if (e.flags & FL_WATERJUMP)
		return;
	
	if (e.waterlevel >= 2)
	{
		if (e.swim_flag < time)
		{
			e.swim_flag = time + 1;
			if (random() < 0.5)
				mcp_Sound(e, CHAN_BODY, SND_WATER1, 1, ATTN_NORM);
			else
				mcp_Sound(e, CHAN_BODY, SND_WATER2, 1, ATTN_NORM);
		}
		return;
	}

	if (!(e.flags & FL_ONGROUND))
		return;

	if ( !(e.flags & FL_JUMPRELEASED) )
		return;         // don't pogo stick

	e.flags = e.flags - (e.flags & FL_JUMPRELEASED);       
	e.button2 = 0;
	
	if(e.model == MDL_MCPPLAYER)
		mcp_Sound(e, CHAN_BODY, SND_PLYRJMP8, 1, ATTN_NORM);
	if(e.model == MDL_MCPFIEND)
		mcp_Sound(e, CHAN_BODY, SND_FIENDJUMP, 1, ATTN_NORM);
	
};

void mcp_ClientConnect(optional float csqcactive)= 
{
	
	bprint(PRINT_HIGH, self.netname, " entered the game\n");
	cprint(self,CPRINT_WELCOME);
	self.has_disconnected = 0;
	mcp_SpawnAliasMaker(self);
	self.team_no = MCPTEAM_NONE;
	mcp_SetTeam(self);
};

void mcp_ClientDisconnect() = 
{
	mcp_DiedWithMCPFlag(self);
	mcp_DropCoins(self, 1);
	bprint (PRINT_HIGH, self.netname);
	bprint (PRINT_HIGH, " left the game\n");
	mcp_Sound(self, CHAN_BODY, SND_TORNOFF2, 1, ATTN_NONE);
	cprint(self, CPRINT_REMOVE);
	self.has_disconnected = 1;
	mcp_UnassignPlayerDim(self);
	self.netname = string_null;
	self.team_no = MCPTEAM_NONE;
	self.solid = SOLID_NOT;
	self.deadflag = DEAD_DEAD;
	setmodel(self,"");
	setsize(self, '0 0 0', '0 0 0');
	self.netname = string_null;
};

void mcp_ClientKill(entity e) = 
{
	if(e.deadflag > DEAD_NO)
 	{
 		stufferror(e,"cant do that, already dead!");
		return;
 	}
 	if(e.team_no == MCPTEAM_NONE)
		return;
	if(matchstate > MATCHSTATE_LIVE)
		return;
	
	if(matchstate == MATCHSTATE_LIVE)
	{
		bprint (PRINT_MEDIUM, e.netname);
		bprint (PRINT_MEDIUM, " suicides\n");
		//AddStat(e, STAT_SUICIDE, 1);
	}
	
	e.health = -1;
	e.modelindex = modelindex_player;
	e.movetype = MOVETYPE_NONE;
	e.view_ofs = '0 0 -8';

	mcp_StartDeathSeq(e);
	mcp_ResetPlayer(e);
	mcp_SetNextRespawn(e, 1);
	
};

void mcp_PutClientInServer() = 
{
	self.classname = CN_PLAYER;          
	self.flags = FL_CLIENT;
	self.view_ofs = '0 0 22';
	self.velocity = '0 0 0';
	self.air_finished = time + 12;	//water shit
	self.dmg = 2;			//water shit
	self.effects = 0;
	self.items = 0;	
	self.health = 1;
	self.armorvalue = 0;	
	self.ammo_rockets = 0;
	self.ammo_nails = 0;
	self.ammo_shells = 0;
	self.ammo_cells = 0;
	self.takedamage = DAMAGE_NO;       
	self.solid = SOLID_NOT;         
	self.movetype = MOVETYPE_NOCLIP; 
	self.attack_finished = time+0.5;

	
	//if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_FIEND || mcpmode == MCPMODE_COINS || mcpmode == MCPMODE_BABYFIEND)
	//{
		mcp_SpawnPlayer(self);
		
	//}
	//else
	//{
	//	local entity spawn_spot;
	//	spawn_spot = find (world, classname, "info_player_start");     
	//	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX); // Set my size
	//	setmodel (self, MDL_MCPPLAYER); // Set my player to the player model
	//	self.origin = spawn_spot.origin + '0 0 1'; // Move to the spawnspot location
	//	self.angles = spawn_spot.angles;     // Face the angle the spawnspot indicates
	//	self.fixangle = TRUE;                // Turn this way immediately
	//}
	
};

void () mcp_WaterMove = 
{
	if (self.movetype == MOVETYPE_NOCLIP)
		return;
	if (self.health < 0)
		return;

	if (self.waterlevel != 3) 
	{
		if (self.air_finished < time) 
			FO_Sound(self, CHAN_VOICE, "player/gasp2.wav", 1, 1);
		else if (self.air_finished < (time + 9)) 
			FO_Sound(self, CHAN_VOICE, "player/gasp1.wav", 1, 1);
		
		self.air_finished = time + 12;
		self.dmg = 2;
	} 
	else if (self.air_finished < time) 
	{
		if (self.pain_finished < time) 
		{
			self.dmg = self.dmg + 2;
			
			if (self.dmg > 15)
				self.dmg = 10;
				
			TF_T_Damage(self, world, world, self.dmg, 1, 0);
			self.pain_finished = time + 1;
		
		}
	}
	if (!self.waterlevel) 
	{
		if (self.flags & FL_INWATER) 
		{
			FO_Sound(self, CHAN_BODY, "misc/outwater.wav", 1, 1);
			self.flags = self.flags - FL_INWATER;
		}
		return;
	}
	if (self.watertype == CONTENT_LAVA) 
	{
		if (self.dmgtime < time) 
		{
			if (self.radsuit_finished > time)
				self.dmgtime = time + 1;
			else
				self.dmgtime = time + 0.2;
				
			TF_T_Damage(self, world, world, (10 * self.waterlevel), 0, 16);
		}
	} 
	else if (self.watertype == CONTENT_SLIME) 
	{
		if ((self.dmgtime < time) && (self.radsuit_finished < time)) 
		{
			self.dmgtime = time + 1;
			T_Damage(self, world, world, (4 * self.waterlevel));
		}
        }
    
	if (!(self.flags & FL_INWATER)) 
	{
		if (self.watertype == CONTENT_LAVA) 
			FO_Sound(self, CHAN_BODY, "player/inlava.wav", 1, 1);
		if (self.watertype == CONTENT_WATER)
			FO_Sound(self, CHAN_BODY, "player/inh2o.wav", 1, 1);
		if (self.watertype == CONTENT_SLIME)
			FO_Sound(self, CHAN_BODY, "player/slimbrn2.wav", 1, 1);

        self.flags = self.flags + FL_INWATER;
        self.dmgtime = 0;
    }
};

void mcp_CheckWaterJump() = 
{
	local vector start;
	local vector end;

	makevectors(self.angles);
	start = self.origin;
	start_z = start_z + 8;
	v_forward_z = 0;
	normalize(v_forward);
	end = start + v_forward * 24;

	traceline(start, end, 1, self);
	if (trace_fraction < 1) 
	{
		start_z = start_z + self.maxs_z - 8;
		end = start + v_forward * 24;
		self.movedir = trace_plane_normal * -50;

		traceline(start, end, 1, self);
		
		if (trace_fraction == 1) 
		{
			self.flags = self.flags | FL_WATERJUMP;
			self.velocity_z = 225;
			self.flags = self.flags - (self.flags & FL_JUMPRELEASED);
			self.teleport_time = time + 2;
			return;
		}
	}
};

void mcp_PlayerPreThink(entity e) = 
{

	if(matchstate > MATCHSTATE_LIVE)
	{
		e.movetype = MOVETYPE_NONE;
		e.solid = SOLID_NOT;
		e.takedamage = DAMAGE_NO;
		if(e.deadflag != DEAD_NO)
			mcp_SpawnPlayer(e);
	}
	if (e.view_ofs == '0 0 0')
		return;         // intermission or finale

	makevectors (e.v_angle);             // is this still used

        e.deathtype = "";
	mcp_WaterMove ();
/*
	if (e.waterlevel == 2)
		CheckWaterJump ();
*/

	if (e.deadflag >= DEAD_DEAD)
	{
		mcp_PlayerDeathThink (e);
		return;
	}
	
	if (e.deadflag == DEAD_DYING)
	{
		return; // dying, so do nothing
	}

	if (e.button2)
	{
		mcp_PlayerJump (e);
	}
	else
		e.flags = e.flags | FL_JUMPRELEASED;

// teleporters can force a non-moving pause time        
	if (time < e.pausetime)
		e.velocity = '0 0 0';
};

void mcp_PlayerPostThink(entity e) = 
{
	mcp_SetPlayerScore(e);
	if (e.view_ofs == '0 0 0')
		return;         // intermission or finale
	if (e.deadflag)
		return;
	if(e.flags & FL_ONGROUND && e.playerclass == ROLE_RECON)
	{
		e.reconshotgunjumps = RECONSHOTGUNJUMPS;
	}

	if ((e.jump_flag < -300) && (e.flags & FL_ONGROUND) )
	{
		if (e.watertype == CONTENT_WATER)
			mcp_Sound(e, CHAN_BODY, SND_H2OJUMP, 1, ATTN_NORM);
		else if (e.jump_flag < -650)
		{
			deathmsg = MCPDEATH_FALL;
			mcp_Damage (e, world, world, 5); 
			if(e.model == MDL_MCPPLAYER)
				mcp_Sound(e, CHAN_VOICE, SND_LAND2, 1, ATTN_NORM);
			if(e.model == MDL_MCPFIEND)
				mcp_Sound(e, CHAN_VOICE, SND_DLAND2, 1, ATTN_NORM);
			if(e.model == MDL_MCPBABYFIEND)
				mcp_Sound(e, CHAN_VOICE, SND_BABYFIEND_LAND, 1, ATTN_NORM);
		}
		else
		{
			if(e.model == MDL_MCPPLAYER)
				mcp_Sound(e, CHAN_VOICE, SND_LAND, 1, ATTN_NORM);
			if(e.model == MDL_MCPFIEND)
				mcp_Sound(e, CHAN_VOICE, SND_DLAND2, 1, ATTN_NORM);
			if(e.model == MDL_MCPBABYFIEND)
				mcp_Sound(e, CHAN_VOICE, SND_BABYFIEND_LAND, 1, ATTN_NORM);
		}
			
	}

	e.jump_flag = e.velocity_z;
	
	mcp_WeaponFrame(self);
	
};

void mcp_PlayerDeathThink(entity e) = 
{
	//bprint(2,"mcpdeaththink\n");
	if ((e.flags & FL_ONGROUND))
	{
		local float forward = vlen (e.velocity);
		forward = forward - 20;
		if (forward <= 0)
			e.velocity = '0 0 0';
		else    
			e.velocity = forward * normalize(e.velocity);
	}
	
	mcp_ImpulseCaptureMenuOption(e);
	mcp_ImpulseCaptureDeadOrAlive(e);


	// wait for all buttons released
	if (e.deadflag == DEAD_DEAD)
	{
		if (e.button2 || e.button1 || e.button0)
			return;
		e.deadflag = DEAD_RESPAWNABLE;
		return;
	}
	//if(e.role == ROLE_NONE || e.nextrole == ROLE_NONE)
	//	return;
	


	// wait for any button down
	if (!e.button2 && !e.button1 && !e.button0 && mcp_GetQuickSlot(e) == MCPSLOTNONE)
	{
		return;
	}

	e.button0 = 0;
	e.button1 = 0;
	e.button2 = 0;
	if(time > e.respawn_time)
	{
		if(e.playerclass != ROLE_NONE)
		{
			if(e.deadflag != DEAD_RESPAWNABLE)
			{	
				return;
			}
			mcp_Respawn(e);
		}
		else
		{
			stufferror(e,"you must pick a class to respawn!");
			return;
		}
	}
	else
	{
		if(time < e.cnt)
			return; 
			
		local float rtimeleft = ceil(e.respawn_time - time);
		e.cnt = time + 0.75;	//next avail check
		if(rtimeleft == 1)
			stufferror(e, strcat("you can respawn in: ",ftos(rtimeleft)," second."));
		else
			stufferror(e, strcat("you can respawn in: ",ftos(rtimeleft)," seconds."));

	}
};