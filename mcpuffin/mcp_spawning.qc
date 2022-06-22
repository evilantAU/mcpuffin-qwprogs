void mcp_AssignFFATeam(entity e) =
{
	e.impulse = 0;
	e.team_no = e.mcpclientdim;
	mcp_SetTeam(e);
	if(e.playerclass == ROLE_NONE || e.nextpc == ROLE_NONE || e.mcpspecialtype == MCPSPECIAL_NONE)
	{
		cprint(e, CPRINT_SELECTROLE);
		
	}
	else
	{
		cprint(e,CPRINT_NONE);
	}
};

float mcp_GetSpeedTrackerSpeed(entity e) =
{
	local entity te = find(world, classname, CN_SPEEDTRACKER);
	while (te) 
	{
		if(te.owner == e && te != world)
		{
			if (te.classname == CN_SPEEDTRACKER)
			{
				return te.bubble_count;
			}
		}
		te = find(te, classname, CN_SPEEDTRACKER);
	}
	return 0;
}

void think_speedtracker() =
{
	self.bubble_count = vlen(self.owner.velocity);
	self.nextthink = time + 0.01;
};

void mcp_SpawnSpeedTracker(entity e) = 
{
		local entity te = find(world, classname, CN_SPEEDTRACKER);
		while (te) 
		{
			if (te.owner == e && te != world) 
			{
				return;
			}
			te = find(te, classname, CN_SPEEDTRACKER);
		}
		
	
		local entity st = spawn();
		st.classname = CN_SPEEDTRACKER;
		st.owner = e;
		st.think = think_speedtracker;
		st.nextthink = time + 0.05;
};

void mcp_ClearFlamerDots(entity e) =
{
	local entity te = find(world, classname, CN_FLAMERDOT);
	while (te) 
	{
		if(te != world)
		{
			if(te.owner == e)
			{
				te.think = SUB_Remove;
				te.nextthink = time;
			}
			if(te.mcpgren == e)
			{
				te.think = SUB_Remove;
				te.nextthink = time;	
			}
		}
		te = find(te, classname,CN_FLAMERDOT);
	}
	
};

void mcp_ClearMolotovDots(entity e) =
{
	local entity te = find(world, classname, CN_MOLOTOVDOT);
	while (te) 
	{
		if(te != world)
		{
			if(te.owner == e)
			{
				te.think = SUB_Remove;
				te.nextthink = time;
			}
			if(te.mcpgren == e)
			{
				te.think = SUB_Remove;
				te.nextthink = time;
			}
		}
		te = find(te, classname,CN_MOLOTOVDOT);
	}
	
};

void mcp_ClearCapacitorInfection(entity e) =
{
	local entity te = find(world, classname, CN_CAPACITORINFECTION);
	while (te) 
	{
		if(te != world && te.mcpgren == e)
		{
			te.think = SUB_Remove;
			te.nextthink = time;
		}
		te = find(te, classname,CN_CAPACITORINFECTION);
	}
};

void mcp_ExpireEnt(entity e, string cn)=
{
	local entity te = find(world, classname, cn);
	while (te) 
	{
		if(te.owner == e && te != world)
		{
			if (cn == CN_RELOAD)
			{
				remove(te);
			}
			if(cn == CN_MIDAIRCOUNTER)
			{
				remove(te);
			}
			if(cn == CN_HARPOONTIMER)
			{
				remove(te);
			}
			if(cn == CN_FLASHTIMER)
			{
				te.think = SUB_Remove;
				te.nextthink = time;
				stuffcmd(e, "v_cshift 0 0 0 0; wait; bf\n");
			}
			if(cn == CN_CLOAK)
			{
				remove(te);
				e.iscloaked = 0;
			}
			if(cn == CN_TELEBALL)
			{
				remove(te);
			}
			if(cn == CN_HARPOON)
			{
				te.voided = 1;
			}
			if(cn == CN_THROWNGRENADE)
			{
				te.cnt = 1;
			}
			if(cn == CN_PRIMEGREN)
			{
				remove(te);
			}
			if(cn == CN_SPEEDTRACKER)
			{
				remove(te);
			}
			if(cn == CN_DRONETIMER)
			{
				remove(te);
			}
			if(cn == CN_MOLOTOVFLAME)
			{
				te.voided = 1;
			}
		}
		te = find(te, classname, cn);
        }
};

void mcp_ResetPlayer(entity e) =
{
	mcp_ExpireEnt(e,CN_RELOAD);
	mcp_ExpireEnt(e,CN_MIDAIRCOUNTER);
	mcp_ExpireEnt(e,CN_HARPOONTIMER);
	mcp_ExpireEnt(e,CN_FLASHTIMER);
	mcp_ExpireEnt(e,CN_CLOAK);
	mcp_ExpireEnt(e,CN_TELEBALL);
	mcp_ExpireEnt(e,CN_HARPOON);
	mcp_ExpireEnt(e,CN_THROWNGRENADE);
	mcp_ExpireEnt(e,CN_PRIMEGREN);
	mcp_ExpireEnt(e,CN_SPEEDTRACKER);
	mcp_ExpireEnt(e,CN_DRONETIMER);
	
	mcp_ClearCapacitorInfection(e);
	mcp_ClearFlamerDots(e);
	mcp_ClearMolotovDots(e);
	mcp_DetStickys(e);
	
	e.reloadingweapon = MCPWEAP_NONE;
	e.FlashTime = 0;
	e.iscloaked = 0;
	e.mcpgren = world;
	e.heat = 0;
	e.fragstreak = 0;
	e.mcpweapstate = MCPWEAPSTATE_NONE;
	mcp_ResetVisDimensions(e);
};

entity mcp_GetNextDMSpawn() =
{
	local float i = 0;
	local float j = 0;
	local float rng = 0;
	local float attempts = 50;
	local float spawns = 0;
	
	local entity spot = find(world,classname,"info_player_deathmatch");
	
	while(spot)
	{
		if(spot !=world)
			spawns++;
			
		spot=find(spot,classname,"info_player_deathmatch");
		
	}
	if(spawns>0)
	{
		for(i = 0; i < attempts; i++)
		{
			rng = RNG(spawns);
			
			spot= find(world,classname,"info_player_deathmatch");
			
			while(spot)
			{
				if(spot != world)
				{
					j++;
					if(rng == j)
					{
						return spot;
					}
				}
				spot=find(spot,classname,"info_player_deathmatch");
			}
		}

	}

	if(spot == world)
		bprint(2,"cant find a dm spawnpoint\n");
		
	return spot;
};


entity mcp_GetNextTeamSpawn(float t) =
{
	local float i = 0;
	local float j = 0;
	local float rng = 0;
	local float attempts = 50;
	local float teamspawns = 0;
	
	local entity spot = find(world,classname,"info_player_teamspawn");
	
	while(spot != world)
	{
		if(spot.team_no == t)
			teamspawns++;
			
		spot=find(spot,classname,"info_player_teamspawn");
		
	}
	if(teamspawns>0)
	{
		for(i = 0; i < attempts; i++)
		{
			rng = RNG(teamspawns);
			spot = find(world,classname,"info_player_teamspawn");
			
			while(spot!=world)
			{
				if(spot.team_no == t)
				{
					j++;
					if(rng == j)
					{

						return spot;
					}
				}
				spot=find(spot,classname,"info_player_teamspawn");
			}
		}
	}
	if(spot == world)
		spot = mcp_GetNextDMSpawn();
	if(spot == world)
		bprint(2,"cant find a team spawnpoint\n");
		
	return spot;
};

entity mcp_GetNext5CPTeamSpawn2(string cn, float t) =
{
	local float i = 0;
	local float j = 0;
	local float rng = 0;
	local float attempts = 50;
	local float spawnsfound = 0;
	
	local entity spot = find(world,classname,cn);
	
	while(spot != world)
	{
		spawnsfound++;
		spot=find(spot,classname,cn);
		
	}
	if(spawnsfound>0)
	{
		for(i = 0; i < attempts; i++)
		{
			rng = RNG(spawnsfound);
			spot = find(world,classname,cn);
			
			while(spot!=world)
			{

				j++;
				if(rng == j)
					return spot;

				spot=find(spot,classname,cn);
			}
		}
	}
	if(spot == world)
		spot = mcp_GetNextTeamSpawn(t);
		
	return spot;
};

entity mcp_GetNext5CPTeamSpawn(float t) =
{
	local entity res = world;
	
	if(t == MCPTEAM_RED)
	{
		if(redattcp == MCPCP_BLUE1)
			res = mcp_GetNext5CPTeamSpawn2(CN_RSPAWN_CP1, MCPTEAM_RED);
		else if(redattcp == MCPCP_BLUE2)
			res = mcp_GetNext5CPTeamSpawn2(CN_RSPAWN_CP2, MCPTEAM_RED);
		else
			res = mcp_GetNextTeamSpawn(MCPTEAM_RED);
	}
	if(t == MCPTEAM_BLUE)
	{
		if(blueattcp == MCPCP_RED1)
			res = mcp_GetNext5CPTeamSpawn2(CN_BSPAWN_CP5, MCPTEAM_BLUE);
		else if(blueattcp == MCPCP_RED2)
			res = mcp_GetNext5CPTeamSpawn2(CN_BSPAWN_CP4, MCPTEAM_BLUE);
		else
			res = mcp_GetNextTeamSpawn(MCPTEAM_BLUE);
	}
	return res;
};

entity mcp_GetPlayerSpawnPoint(float t) =
{
	local entity spot = world;
	
	if(mcp_HasTeamSpawns())
	{
		if(mcpmode == MCPMODE_5CP)
			spot = mcp_GetNext5CPTeamSpawn(t);
		else
			spot = mcp_GetNextTeamSpawn(t);
	}
	else
		spot = mcp_GetNextDMSpawn();
		
	return spot;
};


void mcp_SpawnAtSpawnpoint(entity e) =
{
		local entity spawn_spot;
		if(e.playerclass == ROLE_NONE || e.nextpc == ROLE_NONE)
		{
			spawn_spot = find (world, classname, "info_player_start");
		}
		else
		{
			spawn_spot = mcp_GetPlayerSpawnPoint(e.team_no);


		}

		e.origin = spawn_spot.origin + '0 0 1'; // Move to the spawnspot location
		e.angles = spawn_spot.angles;     // Face the angle the spawnspot indicates
		e.fixangle = TRUE;                // Turn this way immediately	
		e.view_ofs = '0 0 22';
		if(e.playerclass == ROLE_BABYFIEND)
		{
			e.origin = spawn_spot.origin + '0 8 1';
			self.view_ofs = '0 0 8';
			self.origin_z = self.origin_z - 8;	
		}
}

void mcp_SetPlayerSkin(entity e) =
{

	if (e.team_no == MCPTEAM_BLUE)
		e.skin = MCPROLEDICT[e.playerclass].skinblue;
	if (e.team_no == MCPTEAM_RED || mcpmode == MCPMODE_COINSFFA)
		e.skin = MCPROLEDICT[e.playerclass].skinred;

};

void mcp_SetPlayerSpeed(entity e) =
{
	local float spd = 999;
	spd = MCPROLEDICT[e.playerclass].speed;
	if(e.playerclass == ROLE_MINIGUNNER)
	{	
		if(e.mcpweapstate == MCPWEAPSTATE_SPINNING || e.mcpweapstate == MCPWEAPSTATE_SPINDOWN || e.mcpweapstate == MCPWEAPSTATE_SPINUP)
			spd = MINIGUN_SPINWALKSPEED;
	}
	
		
	if(e.playerclass == ROLE_TECHNICIAN)
	{
		if(e.mcpweapstate == MCPWEAPSTATE_DRONESHOOT)
			spd = DRONE_SPINWALKSPEED;
		else
			spd = DRONE_FLYSPEED;

	}
		
	if(e.deadflag > 0)
		spd = 0;
	
	e.maxspeed = spd;
};

void touch_mcpplayer()=
{
	if(self.deadflag != DEAD_NO)
		return;

	if(other.classname == CN_PLAYER && other.team_no != self.team_no && other.deadflag == DEAD_NO)
	{
		if(other.takedamage)
		{
			local float zdist = (other.origin_z + 32)  - (self.origin_z - 24);
			local float xdist = fabs((other.origin_x)  - (self.origin_x));
			local float ydist = fabs((other.origin_y)  - (self.origin_y));
			//bprint(2,strcat("z:",ftos(zdist)," x:",ftos(xdist), " y:",ftos(ydist),"\n"));
			
			//if(zdist <= 0 && ydist <= 20 && xdist <=20 && self.playerclass != ROLE_BABYFIEND)
			if(self.jump_flag < 0 && zdist <= 0 && ydist <= 20 && xdist <=20 && self.playerclass != ROLE_BABYFIEND)
			{
				deathmsg = MCPDEATH_GOOMBASTOMP;
				mcp_Damage (other, self, self, GSTOMP_DAMAGE);
				return;
			}
		}
		if(self.playerclass == ROLE_FIEND || self.playerclass == ROLE_BABYFIEND)
		{
			local entity flt = mcp_GetEntByClassnameAndOwner(CN_FIENDLEAPTRACKER,self);
			if(flt != world)
			{
				sprint(self, PRINT_HIGH, strcat("your leap hits ", other.netname, " for ", ftos(LEAPFIEND_DAMAGE), " damage.\n"));	
				deathmsg = MCPDEATH_LEAPFIEND;
				if(self.playerclass == ROLE_FIEND)
					mcp_Damage (other, self, self, LEAPFIEND_DAMAGE );
				if(self.playerclass == ROLE_BABYFIEND)
				{
					mcp_Damage (other, self, self, MELEEDAMAGE_BABYFIEND );
				}
				remove(flt);
			}

		}
		if(self.playerclass == ROLE_MINIGUNNER)
		{	
			local float mgunnerspeed = mcp_GetSpeedTrackerSpeed(self);
			if(mgunnerspeed < MGUNNERTOUCH_MINSPEED)
				return;
			local float impactdamage = (mgunnerspeed - MGUNNERTOUCH_MINSPEED) / MGUNNERTOUCH_MAXSPEED;
			impactdamage = rint(impactdamage * MGUNNERTOUCH_MAXDAMAGE);
			if(impactdamage < MGUNNERTOUCH_MINDAMAGE)
				impactdamage = MGUNNERTOUCH_MINDAMAGE;
			
			sprint(self, PRINT_HIGH, strcat("you shoulder charge ", other.netname, " at a speed of ", ftos(rint(mgunnerspeed)), " causing ", ftos(impactdamage), " damage.\n"));	
			deathmsg = MCPDEATH_SHOULDERCHARGE;
			mcp_Damage (other, self, self, impactdamage );
		}
	}
};

void mcp_AssignPlayerDim(entity e) =
{
	if(e.mcpclientdim != 0)
		return;
	//if(e.role == ROLE_NONE || e.nextrole == ROLE_NONE)
	//	return;
		
	local float res = 0;
	local float i;
	for (i = DIM_PLAYER1; i < DIM_PLAYER20; i = i * 2)
	{
		if(!(mcpplayerdims & i))
		{
			e.mcpclientdim = i;
			mcpplayerdims = mcpplayerdims | i;
			dprint(strcat(e.netname, " assigned dimension ", ftos(i), "\n"));
			res = 1;
			break;
		}
		
	}
	if(res == 0)
	{
		bprint(2,strcat("warning: couldnt find empty dimension for ", e.netname, "\n"));
		return;
	}
};

void mcp_UnassignPlayerDim(entity e) =
{
	if(e.mcpclientdim == 0)
		return;
	mcpplayerdims = mcpplayerdims - (mcpplayerdims & e.mcpclientdim);
};

void mcp_ResetVisDimensions(entity e) =
{
	e.dimension_see = DIM_WORLD;
	
	if(mcpgoal.owner != e)
		e.dimension_see = e.dimension_see | DIM_FLAG;
	
	if(e.team_no == MCPTEAM_BLUE)
		e.dimension_see = e.dimension_see | DIM_BLUETEAM;
	if(e.team_no == MCPTEAM_RED)
		e.dimension_see = e.dimension_see | DIM_REDTEAM;
	if(e.mcpclientdim != 0)
		e.dimension_see = e.dimension_see | e.mcpclientdim;
};

void mcp_AddVisDimension (entity e, float dim) =
{
	e.dimension_see = e.dimension_see | dim;
};

void mcp_RemoveVisDimension (entity e, float dim) =
{
	e.dimension_see = e.dimension_see - (e.dimension_see & dim);
};

float mcp_ContainsVisDimension (entity e, float dim) =
{
	local float res = 0;
	
	if (e.dimension_see & dim)
		res = 1;
	
	return res;
};

void touch_corpsehead() = 
{
	if(other.classname == CN_PLAYER && other.deadflag == DEAD_NO)
	{
		if(vlen(self.velocity) == 0)
		{
			self.solid = SOLID_TRIGGER;
			self.movetype = MOVETYPE_BOUNCE;
			//self.velocity = normalize(other.velocity) * vlen(other.velocity);
			self.velocity = other.velocity * 2;
			self.velocity_z = self.velocity_z + 128;
			self.avelocity_x = random()*600;
			self.avelocity_y = random()*600;
			self.avelocity_z = random()*600;
			mcp_Sound(self, CHAN_AUTO, SND_Z_MISS, 1, ATTN_NORM);
		}
	}
};
void think_mcpcorpse() = 
{
	self.nextthink = time + 0.5;
	if(time >self.bubble_count)
		self.think = SUB_Remove;
}
void mcp_CreateCorpse (entity oldent) =
{
	if(oldent.team_no == MCPTEAM_NONE)
	{
		bprint(2,"mcp_CreateCorpse() error\n");
		return;
	}
	if(oldent.playerclass == ROLE_NONE)
		return;
	if(oldent.health > 0)
		return;
		
	local entity new = spawn();	
	new.angles = oldent.angles;
	new.skin = oldent.skin;
	//new.modelindex = oldent.modelindex;
	new.frame = oldent.frame;
	new.flags = 0;
	new.colormap = oldent.colormap;
	new.movetype = oldent.movetype;
	new.velocity = oldent.velocity;
	new.team_no = oldent.team_no;
	setorigin(new, oldent.origin);
	setsize(new, oldent.mins, oldent.maxs);
	new.classname = CN_CORPSE;
	
	new.think = think_mcpcorpse;
	//new.nextthink = time + 45;
	new.nextthink = time + 0.1;
	new.bubble_count = time + 45;
	if(oldent.model == MDL_MCPPLAYERHEAD || oldent.model == MDL_MCPFIENDHEAD || oldent.model == MDL_MCPDRONEGIB1 )
	{
		mcp_SetModel(new, oldent.model, DIM_WORLD);
		new.solid = SOLID_TRIGGER;
		new.touch = touch_corpsehead;
	}
	else
	{
		mcp_SetModel(new, oldent.model, DIM_WORLD);
	}	
};

void mcp_Respawn(entity e) =
{
	mcp_CreateCorpse(e);
	//mcp_SetNewParms();
	mcp_PutClientInServer();
	
};

void mcp_ExecAutoexec(entity e) =
{
	local string ae = infokey(e, IK_AUTOEXEC);
	if(ae == "0" || ae == "off")
		return;
		
	stuffcmd(e, "exec mcpuffin.cfg\n");
};

void mcp_ExecTeamConfig(entity e) =
{
	local string et = infokey(self, IK_ET);
	
	if(et == "1" || et == "on")
	{
		if(e.team_no == MCPTEAM_BLUE)
			stuffcmd(e, "exec teamblue.cfg\n");
		if(e.team_no == MCPTEAM_RED || mcpmode == MCPMODE_COINSFFA)
			stuffcmd(e, "exec teamred.cfg\n");
		if(e.team_no == MCPTEAM_NONE)
			stuffcmd(e, "exec teamnone.cfg\n");
	}
};

void mcp_ExecClassConfig(entity e) =
{
	local string ec = infokey(e, IK_EC);
		
	if(ec == "1" || ec == "on")
	{
		stuffcmd(e,strcat("exec ",MCPROLEDICT[e.playerclass].namestr,".cfg\n"));
	}
};

void mcp_SetPlayerScore(entity e)  =
{
	if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
	{
		if(e.team_no == MCPTEAM_BLUE)
			e.frags = bluescore;
		else if(e.team_no == MCPTEAM_RED)
			e.frags = redscore;
		else
			e.frags = 0;
	}
	if(mcpmode == MCPMODE_FIEND)
	{
		if(e.team_no == MCPTEAM_BLUE)
			e.frags = bluescore;
		else if(e.team_no == MCPTEAM_RED)
			e.frags = redscore;
		else
			e.frags = 0;		
	}
	if(mcpmode == MCPMODE_BABYFIEND)
	{
		if(e.team_no == MCPTEAM_BLUE)
			e.frags = bluescore;
		else if(e.team_no == MCPTEAM_RED)
			e.frags = redscore;
		else
			e.frags = 0;		
	}
	if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
	{
		e.frags = e.frags;
	}
};

void mcp_SetTeam(entity e) =
{
	if(mcpmode == MCPMODE_COINSFFA)
	{
		stuffcmd(e,"team ffa\n");
		stuffcmd(e, "color 4 4\n");
		return;
	}
	if(e.team_no == MCPTEAM_BLUE)
	{
		stuffcmd(e, "team blue\n");
		stuffcmd(e, "color 13 13\n");
		return;
	}	
	if(e.team_no == MCPTEAM_RED)
	{
		stuffcmd(e, "team red\n");
		stuffcmd(e, "color 4 4\n");
		return;
	}
	else
	{
		stuffcmd(e, "team none\n");
		stuffcmd(e, "color 0 0 \n");
		return;
	}
};

void mcp_SetupRole(entity e) =
{
	local float r;
	r = e.nextpc;
	if(r == ROLE_RANDOM && (mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP))
	{
		r = GetRandomRole(e);
	}
	e.playerclass = r;
	if(r == ROLE_NONE)
	{

	}
	else
	{
		if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
		{
			r = ROLE_MUGGER;
			e.playerclass = r;
		}
			
		e.deadflag = DEAD_NO;
		
		e.takedamage = DAMAGE_AIM;       
		e.solid = SOLID_SLIDEBOX;         
		e.movetype = MOVETYPE_WALK;
		
		if(r == ROLE_FIEND)
		{
			mcp_SetModel(e, MDL_MCPFIEND, DIM_WORLD);
			e.touch = touch_mcpplayer;
			mcpfiend_stand1();
			e.th_pain = mcpfiend_pain;
			e.th_die = SUB_Null;
			setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
			
		}
		else if(r == ROLE_BABYFIEND)
		{
			mcp_SetModel(e, MDL_MCPBABYFIEND, DIM_WORLD);
			e.touch = touch_mcpplayer;
			mcpfiend_stand1();
			e.th_pain = mcpfiend_pain;
			e.th_die = SUB_Null;
			setsize (self, '-16 -16 -24','16 16 8');

		}
		else
		{
			mcp_SetModel(e, MDL_MCPPLAYER, DIM_WORLD);
			e.touch = touch_mcpplayer;
			mcpplayer_stand1();
			e.th_pain = mcpplayer_pain;
			e.th_die = SUB_Null;
			setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
			
		}
		modelindex_player = e.modelindex;
		e.items = e.items | IT_ARMOR2;
		e.ammo_shells = 0;
		e.ammo_nails = MCPROLEDICT[r].maxgrens;
		e.ammo_rockets = 0;
		e.ammo_cells = 75;
		
		
		e.health = MCPROLEDICT[r].maxhealth;
		e.armorvalue = MCPROLEDICT[r].maxarmour;
		e.mcpgrentype = MCPROLEDICT[r].grentype;
		e.mcpgrencount = MCPROLEDICT[r].maxgrens;
		if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
		{
			if(e.nextpc == MCPSPECIAL_RANDOM || e.nextpc == MCPSPECIAL_NONE)
			{
				e.mcpspecialtype = mcp_GetRandomSpecial(e);
			}
			else
				e.mcpspecialtype = e.nextpc;
				
			sprint(e,PRINT_HIGH,strcat("playing as a mugger with ",MCPSPECDICT[e.mcpspecialtype].namestr," ability.\n"));
		}
		else
		{
			sprint(e,PRINT_HIGH,strcat("playing as ",MCPROLEDICT[r].namestr,".\n"));
			e.mcpspecialtype = MCPROLEDICT[r].specialtype;
		}

		e.mcpslot[MCPSLOT1].type = MCPWEAPDICT[MCPROLEDICT[r].weapon1].type;
		e.mcpslot[MCPSLOT1].clipcount = MCPWEAPDICT[MCPROLEDICT[r].weapon1].clipsize;
		e.mcpslot[MCPSLOT2].type = MCPWEAPDICT[MCPROLEDICT[r].weapon2].type;
		e.mcpslot[MCPSLOT2].clipcount = MCPWEAPDICT[MCPROLEDICT[r].weapon2].clipsize;
		e.mcpslot[MCPSLOT3].type = MCPWEAPDICT[MCPROLEDICT[r].weapon3].type;
		e.mcpslot[MCPSLOT3].clipcount = MCPWEAPDICT[MCPROLEDICT[r].weapon3].clipsize;
		e.mcpslot[MCPSLOT4].type = MCPWEAPDICT[MCPROLEDICT[r].weapon4].type;
		e.mcpslot[MCPSLOT4].clipcount = MCPWEAPDICT[MCPROLEDICT[r].weapon4].clipsize;
		local float i;
		for(i = mcpslot.length - 1; i >= 0; i--)
		{
			if(e.mcpslot[i].type != MCPWEAP_NONE)
			{
				mcp_ChangeSlot(e,i);
				break;
			}	
		}
		bprint(2,strcat(ftos(e.nextpc),":isthisnextpc\n"));
		bprint(2,strcat(ftos(e.playerclass),":isthiscurrent\n"));		
	}
};

void mcp_SpawnPlayer(entity e) =
{
	if(e.team_loser == 1)
	{
		mcp_TryJoinTeam(e, MCPTEAM_LOSER);
	}
	mcp_AssignPlayerDim(e);
	mcp_SetTeam(e);
	mcp_SetupRole(e);
	mcp_SetPlayerSpeed(e);
	mcp_SetPlayerSkin(e);
	mcp_ResetVisDimensions(e);
	mcp_ExecTeamConfig(e);
	mcp_ExecClassConfig(e);
	mcp_SpawnAtSpawnpoint(e);
	if(e.playerclass == ROLE_FIEND || e.playerclass == ROLE_BABYFIEND)
		e.colormap = 0;
	if(e.playerclass == ROLE_MINIGUNNER)
			mcp_SpawnSpeedTracker(e);
	if(e.playerclass != ROLE_NONE && e.team_no != MCPTEAM_NONE)
	{
		spawn_tfog(e.origin);
		spawn_tdeath(e.origin,e);
	}
};