void () touch_lootgren = {

	if (other.classname != CN_PLAYER)
		return;
	if (other.health <= 0)
		return;
	if(other.playerclass == ROLE_NONE)
		return;
   // if (other.button0)
    //    return;
	local string str = "you find";

	if(other.mcpgrencount < MCPROLEDICT[other.playerclass].maxgrens)
        {
		other.mcpgrencount = other.mcpgrencount + LOOT_GRENAMOUNT;
		other.ammo_nails = other.ammo_nails + LOOT_GRENAMOUNT;
		//sprint(other, PRINT_HIGH, "you found an extra grenade in backpack.\n");
		str = strcat(str," an extra grenade.");
		self.bubble_count = 1;
	}
		
	if(self.bubble_count >= 1)
	{
		mcp_Sound(other, CHAN_ITEM, SND_LOOTGREN, 1, ATTN_NORM);
		stuffcmd(other, "bf\n");
		self.nextthink = time + 0.1;
		self.think = SUB_Remove;
		self.touch = SUB_Null;
		sprint(other, PRINT_HIGH, strcat(str,"\n"));
	}
};

void () touch_loothealth = {

	if (other.classname != CN_PLAYER)
		return;
	if (other.health <= 0)
		return;
	if(other.playerclass == ROLE_NONE)
		return;
	
	local string str = "you gain";
	
	if(other.health < MCPROLEDICT[other.playerclass].maxhealth)
	{
		if(other.health + LOOT_HEALTHAMOUNT > MCPROLEDICT[other.playerclass].maxhealth)
		{
			local float hpgain = 100 - other.health;
			str = strcat(str," ",ftos(hpgain)," health.");
			other.health = other.health + hpgain;
		}
		else
		{
			other.health = other.health + LOOT_HEALTHAMOUNT;
			str = strcat(str," ",ftos(LOOT_HEALTHAMOUNT)," health.");
		}
		self.bubble_count = 1;
	}
	
	if(self.bubble_count >= 1)
	{
		mcp_Sound(other, CHAN_ITEM, SND_LOOTHEALTH, 1, ATTN_NORM);
		stuffcmd(other, "bf\n");
		self.nextthink = time + 0.1;
		self.think = SUB_Remove;
		self.touch = SUB_Null;
		sprint(other, PRINT_HIGH, strcat(str,"\n"));
	}
};


void () touch_lootarmour = {

	if (other.classname != CN_PLAYER)
		return;
	if (other.health <= 0)
		return;
	if(other.playerclass == ROLE_NONE)
		return;
		
	local string str = "you repair";
		
	local float maxarm = MCPROLEDICT[other.playerclass].maxarmour;
		
	if(other.armorvalue < maxarm)
	{
		if(other.armorvalue + LOOT_ARMOURAMOUNT > maxarm)
		{
			local float armgain = maxarm - other.armorvalue;
			str = strcat(str," ",ftos(armgain)," armour.");
			other.armorvalue = other.armorvalue + armgain;
		}
		else
		{
			other.armorvalue = other.armorvalue + LOOT_ARMOURAMOUNT;
			str = strcat(str," ",ftos(LOOT_ARMOURAMOUNT)," armour.");
		}
		self.bubble_count = 1;
	}
	
	if(self.bubble_count >= 1)
	{
		mcp_Sound(other, CHAN_ITEM, SND_LOOTARMOUR, 1, ATTN_NORM);
		stuffcmd(other, "bf\n");
		self.nextthink = time + 0.1;
		self.think = SUB_Remove;
		self.touch = SUB_Null;
		sprint(other, PRINT_HIGH, strcat(str,"\n"));
	}
};

void mcp_DropLootArmour(entity e) = 
{
	if(mcpmode == MCPMODE_BABYFIEND)
		return;
		
	newmis = spawn();
	newmis.origin = self.origin - '0 0 24';

	newmis.velocity_z = 300;
	newmis.velocity_x = -100 + random() * 200;
	newmis.velocity_y = -100 + random() * 200;

	newmis.flags = FL_ITEM;
	newmis.solid = SOLID_TRIGGER;
	newmis.movetype = MOVETYPE_TOSS;
	mcp_SetModel(newmis,MDL_LOOTARMOUR	, DIM_WORLD);
	setsize(newmis, '-16 -16 0', '16 16 56');
	newmis.touch = touch_lootarmour;
	newmis.classname = CN_LOOTARMOUR;

	newmis.nextthink = time + LOOT_DURATION;
	newmis.think = SUB_Remove;
};

void mcp_DropLootHealth(entity e) = 
{
	if(mcpmode == MCPMODE_BABYFIEND)
		return;
		
	newmis = spawn();
	newmis.origin = self.origin - '0 0 24';

	newmis.velocity_z = 300;
	newmis.velocity_x = -100 + random() * 200;
	newmis.velocity_y = -100 + random() * 200;

	newmis.flags = FL_ITEM;
	newmis.solid = SOLID_TRIGGER;
	newmis.movetype = MOVETYPE_TOSS;
	mcp_SetModel(newmis, MDL_LOOTHEALTH	, DIM_WORLD);
	setsize(newmis, '-16 -16 0', '16 16 56');
	newmis.touch = touch_loothealth;
	newmis.classname = CN_LOOTHEALTH;

	newmis.nextthink = time + LOOT_DURATION;
	newmis.think = SUB_Remove;
};



void mcp_DropLootGrenade(entity e) = 
{
	if(mcpmode == MCPMODE_BABYFIEND)
		return;
	if(mcpmode != MCPMODE_5CP && mcpmode != MCPMODE_SACRIFICE)
		return;
		
	newmis = spawn();
	newmis.origin = self.origin - '0 0 24';

	newmis.velocity_z = 300;
	newmis.velocity_x = -100 + random() * 200;
	newmis.velocity_y = -100 + random() * 200;

	newmis.flags = FL_ITEM;
	newmis.solid = SOLID_TRIGGER;
	newmis.movetype = MOVETYPE_TOSS;
	mcp_SetModel(newmis, MDL_LOOTGREN, DIM_WORLD);
	setsize(newmis, '-16 -16 0', '16 16 56');
	newmis.touch = touch_lootgren;
	newmis.classname = CN_LOOTGREN;

	newmis.nextthink = time + LOOT_DURATION;
	newmis.think = SUB_Remove;
};



float mcp_HasTeamSpawns() =
{
	local float b = 0;
	local float r = 0;
	
	local entity spot = find(world,classname,"info_player_teamspawn");
			
	while(spot)
	{
		if(spot != world)
		{
			if(spot.team_no == MCPTEAM_BLUE)
				b++;
			if(spot.team_no == MCPTEAM_RED)
				r++;
		}
							
		spot=find(spot,classname,"info_player_teamspawn");
	}
	
	if(b > 0 && r > 0)
		return 1;
		
	return 0;
};

void mcp_KillAllPlayers() =
{
	local entity te = find(world, classname, CN_PLAYER);
	while (te) 
	{
		if (te != world && te.team_no != MCPTEAM_NONE) 
		{
			stuffcmd(te, "kill\n");
		}
		te = find(te, classname, CN_PLAYER);
	}
};



void mcp_RegenCells (entity e) =
{
	if(e.ammo_cells == 100)
		return;
	
	if(time < e.nextregen)
		return;
	if(e.mcpweapstate == MCPWEAPSTATE_DRONE || e.mcpweapstate == MCPWEAPSTATE_DRONESHOOT)
		return;
		
	if(e.iscloaked == 1)
		return;
		
	local float maxcells = 100;
	
	e.nextregen = time + (MCPSPECDICT[e.mcpspecialtype].cellregentotaltime / MCPSPECDICT[e.mcpspecialtype].cellregentotalticks);
	e.ammo_cells = e.ammo_cells + (maxcells / MCPSPECDICT[e.mcpspecialtype].cellregentotalticks);
	
	if(e.ammo_cells >= maxcells)
	{
		e.ammo_cells = maxcells;
		stuffsound(e, MCPSPECDICT[e.mcpspecialtype].sreadysound);
	}

};

float RNG (float x) =
{
	//x is n of choices, doesnt return 0
	local float rnd;
	rnd = rint((random() * x) + 0.5);
	return rnd;	
};
float GetSpecialCount(float s, float t) =
{
	local float res = 0;
	
	local entity te = find(world, classname, CN_PLAYER);
	while(te)
	{
		if(te != world && te.mcpspecialtype == s &&te.team_no == t)
		{
			res++;
		}
		te = find(te,classname,CN_PLAYER);
	}
	return res;
	
};
float GetRoleCount(float r, float t) = 
{
	local float res = 0;
	
	local entity te = find(world, classname, CN_PLAYER);
	while(te)
	{
		if(te != world && te.nextpc == r &&te.team_no == t)
		{
			res++;
		}
		te = find(te,classname,CN_PLAYER);
	}
	return res;
};

float GetSpecialMax(float r, float t) =
{
	local float res = 20;
	
	return res;
};

float GetRoleMax(float r, float t) =
{
	local float res = 0;
	if(r == ROLE_HUNTER)
		return 1;
	res = 20;
	
	return res;
};

void stufferror(entity e, string s) =
{
	sprint(e,PRINT_HIGH,strcat(s,"\n"));
	stuffsound(e,SND_ERROR);
};

void stuffnotice(entity e, string s) =
{
	sprint(e,PRINT_HIGH,strcat(s,"\n"));
	stuffsound(e,SND_NOTICE);
};

void stuffsound(entity e, string path) =
{
	stuffcmd(e, strcat("play ",path,"\n"));
};

void stuffsoundteam(float team, string path,  entity exclude) =
{
	local entity te = find(world, classname, CN_PLAYER);
	while (te) 
	{
		if (te.team_no == team && te != exclude) 
		{
			stuffcmd(te, strcat("play ", path, "\n"));
		}
		te = find(te, classname, CN_PLAYER);
	}
};

void stuffsoundall(string path, entity exclude) =
{
	local entity te = find(world, classname, CN_PLAYER);
	while (te) 
	{
		if (te != exclude) 
		{
			stuffcmd(te, strcat("play ", path, "\n"));
		}
		te = find(te, classname, CN_PLAYER);
	}
};

float GetTeamCount(float team) =
{
	local float res = 0;
	local entity te = find (world, classname, CN_PLAYER);
	while (te) 
	{
		if (te.team_no == team) 
		{
			res++;
		}
		te = find (te, classname, CN_PLAYER);
	}
	return res;
};

float GetAutoTeam(entity e) =
{
	local float rng;
	local float reds = GetTeamCount(MCPTEAM_RED);
	local float blues = GetTeamCount(MCPTEAM_BLUE);
	
	if(mcpmode == MCPMODE_FIEND)
	{
		if(reds == 0)
			return MCPTEAM_RED;
		return MCPTEAM_BLUE;
	}
	if(mcpmode == MCPMODE_BABYFIEND)
	{
		if(blues == 0)
			return MCPTEAM_BLUE;
		return MCPTEAM_RED;
	}
	
	if(reds == blues)
	{
		rng = RNG(2);
		if(rng == 1)
			return MCPTEAM_BLUE;
		else
			return MCPTEAM_RED;
	}
	else if (reds>blues)
	{
		return MCPTEAM_BLUE;
	}
	else
	{
		return MCPTEAM_RED;
	}
		
		dprint("GetAutoTeam() error\n");
		return MCPTEAM_BLUE;
};

float GetBalanceTeam(entity e) =
{
	local float reds = GetTeamCount(MCPTEAM_RED);
	local float blues = GetTeamCount(MCPTEAM_BLUE);
	
	if(reds == blues)
		return MCPTEAM_NONE;
		
	if(redscore>bluescore && reds>blues)
		return MCPTEAM_BLUE;
	
	if(bluescore>redscore && blues>reds)
		return MCPTEAM_RED;
	
	return MCPTEAM_NONE;
};

void mcp_JoinTeam(entity e, float t, float isrand) =
{
	e.impulse = 0;
	mcp_DiedWithMCPFlag(e);
	if(e.deadflag == DEAD_NO)
		mcp_ClientKill(e);
	if(mcpmode == MCPMODE_BABYFIEND || mcpmode  == MCPMODE_FIEND)
	{
		e.nextpc = ROLE_NONE;
		e.playerclass = ROLE_NONE;
	}
	if(t == MCPTEAM_BLUE)
	{
		if((mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA) && e.frags > 0 )
			mcp_DropCoins(e,1);
			
		e.team_no = MCPTEAM_BLUE;
		if(isrand == 1)
			bprint(2, strcat(e.netname, " was automagically put on the \sblue\s team.\n"));
		else if(isrand == 2)
			bprint(2, strcat(e.netname, " was balanced to the \sblue\s team.\n"));
		else
			bprint(2, strcat(e.netname, " has joined the \sblue\s team.\n"));

	}
	if (t == MCPTEAM_RED)
	{
		if((mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA) && e.frags > 0)
			mcp_DropCoins(e,1);
			
		e.team_no = MCPTEAM_RED;
		if(isrand == 1)
			bprint(2, strcat(e.netname, " was automagically put on the \sred\s team.\n"));
		else if(isrand == 2)
			bprint(2, strcat(e.netname, " was balanced to the \sred\s team.\n"));
		else
			bprint(2, strcat(e.netname, " has joined the \sred\s team.\n"));

	}
		
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

void mcp_TryJoinTeam(entity e, float t) =
{	
	e.impulse = 0;
	if(e.cprinter.cnt == CPRINT_SELECTTEAM)
		cprint(e, CPRINT_NONE);
	if(mcpmode == MCPMODE_BABYFIEND)
	{
		if(t == MCPTEAM_BLUE)
		{
			if(GetRoleCount(ROLE_HUNTER, MCPTEAM_BLUE) >= GetRoleMax(ROLE_HUNTER, MCPTEAM_BLUE))
			{
				stufferror(e,"too many on that team.");
				return;
			}
		}
	}

	if(e.team_no == t)
	{
		stufferror(e,"already on that team.");
		return;
	}
		
	if(t == MCPTEAM_AUTO)
	{	
		if(GetAutoTeam(e) == e.team_no)
		{
			stufferror(e,"already on that team.");
			return;
		}
			
		mcp_JoinTeam(e, GetAutoTeam(e), 1);
		return;
	}
	if(t == MCPTEAM_LOSER)
	{		
		local float balteam = GetBalanceTeam(e);
		if(balteam == MCPTEAM_NONE)
		{
			if(e.team_no == MCPTEAM_NONE)
			{	
				mcp_JoinTeam(e, GetAutoTeam(e), 2);
			}
			return;
		}
			
		mcp_JoinTeam(e, balteam, 2);
		return;
	}
	if(t == MCPTEAM_RED)
	{	
		mcp_JoinTeam(e, MCPTEAM_RED, 0);
		return;
	}
	if(t == MCPTEAM_BLUE)
	{
		mcp_JoinTeam(e, MCPTEAM_BLUE, 0);
		return;
	}
};
float mcp_GetRandomSpecial(entity e) =
{
	//holy shit this is convoluted
	local float rng;
	local float s = MCPSPECIAL_RANDOM;
	local float x;
	local float maxi = 10;
	local float opt1 = MCPSPECIAL_DASH;
	local float opt2 = MCPSPECIAL_CLOAK;
	local float opt3 = MCPSPECIAL_HARPOON;
	local float opt4 = MCPSPECIAL_DETROCKET;
	local float opt5 = MCPSPECIAL_TELEBALL;
	local float opt6 = MCPSPECIAL_LEAP;
	local float opt7 = MCPSPECIAL_AIRBLAST;
	
	for (float i = 0; i < maxi; i++)	//try to get a random special
	{
		rng = RNG(7);
		if(rng == 1)
			rng = opt1;
		if(rng == 2)
			rng = opt2;
		if(rng == 3)
			rng = opt3;
		if(rng == 4)
			rng = opt4;
		if(rng == 5)
			rng = opt5;
		if(rng == 6)
			rng = opt6;
		if(rng == 7)
			rng = opt7;
		
		
		
		if(GetSpecialCount(rng, e.team_no) < GetSpecialMax(rng,e.team_no))
		{
			s = rng;
			break;
		}	
	}
	bprint(2,strcat(ftos(s),"s\n"));
	if(s == MCPSPECIAL_RANDOM)	//no luck with rng, iterate over specials
	{
		local float specs = 7;
		for (float i = 1; i < specs+1; i++)	//try to get a random class
		{
			if(i == 1)
				x = opt1;
			if(i == 2)
				x = opt2;
			if(i == 3)
				x = opt3;
			if(i == 4)
				x = opt4;
			if(i == 5)
				x = opt5;
			if(i == 6)
				x = opt6;
			if(i == 7)
				x = opt7;
				
			if(GetSpecialCount(x, e.team_no) < GetSpecialMax(x,e.team_no))
			{
				s = x;
				break;
			}
		}	
	}
	
	if(s != MCPSPECIAL_RANDOM)
		return s;
		
	bprint(2,"GetRandomSpecial() error\n");
	return 1;
	
};


void RandomRoleTester(entity e) =
{
	local float rec,ass,fig,trap,doc,mini,ars,tech,othero = 0;
	local float x = 200;
	local float i = 0;
	for(i = 0; i < x; i++)
	{
		local float test = 0//GetRandomRoleTest(e);
		if( test== ROLE_RECON)
			rec++;
		else if(test == ROLE_ASSASSIN)
			ass++;
		else if(test == ROLE_FIGHTER)
			fig++;
		else if(test == ROLE_BOMBER)
			trap++;
		else if(test == ROLE_DOCTOR)
			doc++;
		else if(test == ROLE_MINIGUNNER)
			mini++;
		else if(test == ROLE_ARSONIST)
			ars++;
		else if(test == ROLE_TECHNICIAN)
			tech++;
		else
		{
			othero++;
		}
	}
	
	local string res = strcat("recons:",ftos(rec)," assassins:",ftos(ass)," fighters:",ftos(fig)," trappers:",ftos(trap));
	res = strcat(res, " doctors:",ftos(doc)," minigunners:", ftos(mini)," arsonists:",ftos(ars));
	res = strcat(res, " technicians:",ftos(tech), "other?:",ftos(othero),"\n");
	bprint(2,res);

};

float GetRandomRole(entity e) =
{
	local float r = ROLE_RANDOM;
	local float rng;
	local float maxi = 20;
	if(mcpmode == MCPMODE_SACRIFICE || mcpmode == MCPMODE_5CP)
	{
		for (float i = 0; i < maxi; i++)	//try to get a random class
		{
			rng = RNG(8);
			
			if(GetRoleCount(rng, e.team_no) < GetRoleMax(rng,e.team_no))
			{
				r = rng;
				return r;
			}	
		}
		if(r == ROLE_RANDOM)	//no luck with rng, iterate over classes
		{
			local float roles = 8;
			for (float i = 1; i <= roles; i++)	//try to get a random class
			{
				if(GetRoleCount(i, e.team_no) < GetRoleMax(i,e.team_no))
				{
					r = i;
					return r;
				}
			}	
		}
	}
	
	bprint(2,"GetRandomRole() error\n");
		
	return ROLE_FIGHTER;			
};

void mcp_TrySetSpecial(entity e, float s) =
{	
	e.impulse = 0;
	if(e.cprinter.cnt == CPRINT_SELECTROLE)
		cprint(e, CPRINT_NONE);
		
	local float allowed = 0;
	local float curr, maxr;
	curr = GetSpecialCount(s,e.team_no);
	maxr = GetSpecialMax(s,e.team_no);

	if(s == MCPSPECIAL_RANDOM)
	{
		if(curr >= maxr)
		{
			stufferror(e,"random class is \sdisabled\s");
			return;
		}
		else
		{
			allowed = 1;
		}

	}
	else
	{
		if(curr < maxr)
			allowed = 1;
		
	}	
	
	if(allowed == 0)
	{
		stufferror(e,strcat("there are too many ",MCPSPECDICT[s].namestr,"'s already"));
		return;
	}
		
	sprint(e,PRINT_HIGH,strcat("you will respawn with ", MCPSPECDICT[s].namestr," ability\n"));
	e.nextpc = s;
	cprint(e,CPRINT_NONE);
	
	if(e.playerclass == ROLE_NONE && e.team_no != MCPTEAM_NONE)
		mcp_Respawn(e);
	
};

void mcp_TrySetRole(entity e, float r) =
{	
	e.impulse = 0;
	if(e.cprinter.cnt == CPRINT_SELECTROLE)
		cprint(e, CPRINT_NONE);
	
	if(e.team_no == MCPTEAM_NONE)
	{
		stufferror(e,"you must join a team first.");
		return;
	}

		
	local float allowed = 0;
	local float curr, maxr;
	curr = GetRoleCount(r,e.team_no);
	maxr = GetRoleMax(r,e.team_no);

	if(r == ROLE_RANDOM)
	{
		if(curr >= maxr)
		{
			stufferror(e,"random class is \sdisabled\s");
			return;
		}
		else
		{
			allowed = 1;
		}

	}
	else
	{
		if(curr < maxr)
			allowed = 1;
		
	}	
	
	if(allowed == 0)
	{
		stufferror(e,strcat("there are too many ",MCPROLEDICT[r].namestr,"'s already"));
		return;
	}
		
	sprint(e,PRINT_HIGH,strcat("you will respawn as ", MCPROLEDICT[r].namestr,"\n"));
	e.nextpc = r;
	cprint(e,CPRINT_NONE);
	if(e.playerclass == ROLE_NONE && e.team_no != MCPTEAM_NONE)
	{
		mcp_Respawn(e);
		return;
	}
};

void mcp_SetModel(entity e, string fomdl, float dimension) =
{
	//e.dimension_seen = e.dimension_seen - (e.dimension_seen & DMN_FLASH);
	e.dimension_seen = dimension;
	setmodel(e, fomdl);
};

void mcp_Sound(entity e, float chan, string samp, float vol, float atten) =
{
	float olddimens = e.dimension_seen;
	// make the sound go to no flash, so it isn't heard by those that are flashed
	//e.dimension_seen = DMN_NOFLASH;
	e.dimension_seen = DIM_WORLD;
	sound(e, chan, samp, vol, atten);
	e.dimension_seen = olddimens;
};
entity mcp_GetEntByClassname(string c) =
{
	
	local entity te = find(world, classname, c);
	while(te)
	{
		if(te != world)
		{
			return te;
		}
		te = find(te,classname,c);
	}
	//bprint(2, "mcp_GetMCPObjectivePoint() error\n");
	return world;
};

entity mcp_GetEntByClassnameAndOwner(string c, entity o) =
{
	local entity te = find(world, classname, c);
	while(te)
	{
		if(te != world && te.owner == o)
		{
			return te;
		}
		te = find(te,classname,c);
	}
	//bprint(2, "mcp_GetMCPObjectivePoint() error\n");
	return world;
};










//fo stuff
void (vector org, float damage) SpawnBlood = {
    WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
    WriteByte(MSG_MULTICAST, TE_BLOOD);
    WriteByte(MSG_MULTICAST, 1);
    WriteCoord(MSG_MULTICAST, org_x);
    WriteCoord(MSG_MULTICAST, org_y);
    WriteCoord(MSG_MULTICAST, org_z);
    multicast(org, MULTICAST_PVS);
};

vector () wall_velocity =
{
    local vector vel;

    vel = normalize(self.velocity);
    vel =
        normalize(vel + v_up * (random() - 0.5) +
                  v_right * (random() - 0.5));
    vel = vel + 2 * trace_plane_normal;
    vel = vel * 200;
    return (vel);
};

void (float damage) spawn_touchblood = {
    local vector vel;

    vel = wall_velocity() * 0.2;
    SpawnBlood(self.origin + vel * 0.01, damage);

};

float () crandom = {
    return (2 * (random() - 0.5));
};

void () spike_touch = {
    if (self.voided)
        return;
    self.voided = 1;

    if (other.solid == SOLID_TRIGGER)
        return;

    if (pointcontents(self.origin) == CONTENT_SKY) {
        remove(self);
        return;
    }
    if (other.takedamage) {
        spawn_touchblood(9);
        deathmsg = self.weapon;

           TF_T_Damage(other, self, self.owner, 10, TF_TD_NOTTEAM,
                    TF_TD_NAIL);

        
        remove(self);
        
    } else {
        WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
        if (self.classname == "wizspike")
            WriteByte(MSG_MULTICAST, TE_WIZSPIKE);
        else if (self.classname == "knightspike")
            WriteByte(MSG_MULTICAST, TE_KNIGHTSPIKE);
        else
            WriteByte(MSG_MULTICAST, TE_SPIKE);
        WriteCoord(MSG_MULTICAST, self.origin_x);
        WriteCoord(MSG_MULTICAST, self.origin_y);
        WriteCoord(MSG_MULTICAST, self.origin_z);
        multicast(self.origin, MULTICAST_PHS);
    

		
    remove(self);
   }
};

void (vector org, vector dir) launch_spike = {
    newmis = spawn();
    newmis.voided = 0;
    newmis.owner = self;
    newmis.movetype = MOVETYPE_FLYMISSILE;
    newmis.solid = SOLID_BBOX;

    newmis.angles = vectoangles(dir);
    newmis.touch = spike_touch;
    newmis.weapon = DMSG_NAILGUN;
    newmis.classname = "spike";
    newmis.think = SUB_Remove;
    newmis.nextthink = time + 6;
    FO_SetModel(newmis, "progs/spike.mdl");
    setsize(newmis, VEC_ORIGIN, VEC_ORIGIN);
    setorigin(newmis, org);

    newmis.velocity = dir * 1500;


};

void () superspike_touch = {
    local float ndmg;

    if (self.voided)
        return;
    self.voided = 1;

    if (other == self.owner)
        return;

    if (other.solid == SOLID_TRIGGER)
        return;

    if (pointcontents(self.origin) == CONTENT_SKY) {
        remove(self);
        return;
    }
    if (other.takedamage) {
        spawn_touchblood(18);
        deathmsg = self.weapon;
        if (deathmsg == DMSG_GREN_NAIL || deathmsg == DMSG_GREN_BURST) {
            ndmg = 40;
        }
        else {
            ndmg = 20;
        }

        if (self.owner.classname == "grenade")
            TF_T_Damage(other, self, self.owner.owner, ndmg, TF_TD_NOTTEAM,
                        TF_TD_NAIL);
        else
            TF_T_Damage(other, self, self.owner, ndmg, TF_TD_NOTTEAM,
                        TF_TD_NAIL);
    } else {
        WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
        WriteByte(MSG_MULTICAST, TE_SUPERSPIKE);
        WriteCoord(MSG_MULTICAST, self.origin_x);
        WriteCoord(MSG_MULTICAST, self.origin_y);
        WriteCoord(MSG_MULTICAST, self.origin_z);
        multicast(self.origin, MULTICAST_PHS);
    }
    remove(self);
};






