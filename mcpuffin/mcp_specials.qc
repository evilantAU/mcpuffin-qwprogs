void mcp_SpecialSuccess(entity e) =
{
	e.ammo_cells = 0;
	e.nextregen = time + MCP_CELLREGENDELAY;
};

//RECON
void mcp_Dash() =
{
        if(self.ammo_cells < 100)
	{
		stufferror(self, "insufficient energy, 100 needed.");
		return;
	}
	mcp_SpecialSuccess(self);
        makevectors(self.angles);
        self.velocity = v_forward * 540;
        self.velocity_z = 181;
        mcp_Sound(self, CHAN_BODY, SND_DASH, 1, ATTN_NORM);
};


//ASSASSIN
void Cloak_Think()=
{
	self.bubble_count = self.bubble_count + 1;
	if(self.bubble_count == 3)
		stuffsound(self.owner, SND_INV3);
	if(self.bubble_count == 2)
		stuffsound(self.owner, SND_INV2);
	

	if(self.bubble_count >= CLOAK_DURATION)
	{
		self.owner.iscloaked = 0;
		mcp_ChangeWeaponModel(self.owner,self.owner.mcpslot[self.weapon].type,0);
		mcp_UpdateHudAmmo(self.owner,self.owner.mcpslot[self.weapon].type);
		mcp_SetModel(self.owner, MDL_MCPPLAYER, DIM_WORLD);
		setsize (self.owner, VEC_HULL_MIN, VEC_HULL_MAX);
		mcp_Sound(self.owner, CHAN_ITEM, SND_UNCLOAK, 1, ATTN_NORM);
		sprint(self.owner, PRINT_HIGH, "cloak removed.\n");
		mcp_ParticleTeleport(self.owner.origin);
		remove(self);
	}
	else
	{
		self.nextthink = time + 1;
	}	
	
};

void mcp_Cloak() =
{
	if(self.iscloaked == 1)
	{
		stufferror(self, "already cloaked!");
		return;
	}
	if(self.ammo_cells < 100)
	{
		stufferror(self, "insufficient energy, 100 needed.");
		return;
	}
	mcp_SpecialSuccess(self);	
	self.iscloaked = 1;
		
	local entity te = spawn();			
	te.classname = CN_CLOAK;
	te.owner = self;
	te.think = Cloak_Think;
	te.nextthink = time + 1;
	te.bubble_count = 0;
	setmodel(self, string_null);
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	sprint(self, PRINT_HIGH, "cloak enabled.\n");

	stuffsound(self, SND_INV3);
	mcp_Sound(self, CHAN_ITEM, SND_CLOAK, 1, ATTN_NORM);
	mcp_ParticleTeleport(self.origin);
	
	mcp_ChangeWeaponModel(self,self.mcpslot[self.weapon].type,1);
	mcp_UpdateHudAmmo(self,self.mcpslot[self.weapon].type);
};

//FIGHTER

void harpoonremove() =
{
	remove(self);
};

void think_harpoonmarker() =
{
	if(time > self.bubble_count || self.owner.deadflag != DEAD_NO)
	{
		remove(self);
		return;
	}
	setorigin(self, self.owner.origin + '0 0 64');
	self.nextthink = time + 0.05;
};

void mcp_HarpoonMarker(entity targ, entity attacker) =
{
	
	local entity mark = spawn();
	mark.classname = CN_HARPOONMARKER;
	mark.bubble_count = time + HARPOON_QUADWINDOW;
	mark.think = think_harpoonmarker;
	mark.nextthink = time;
	mark.owner = targ;
	mark.mcpgren = attacker;
	mcp_SetModel(mark,SPR_HARPOONMARKER, attacker.mcpclientdim);
};

void HarpoonToward(entity targ, entity inflictor, entity attacker) =
{
	
		if(targ.classname != CN_PLAYER)
			return;
		if ( (attacker != world) && (targ.movetype == MOVETYPE_WALK) )
		{

			local float mindistance = 100;
			local float maxdistance = 800;
			local vector difference = targ.origin - attacker.origin;
			local float distance = rint(sqrt(pow(difference.x, 2) + pow(difference.y, 2) + pow(difference.z, 2)));
			if(distance < mindistance)
				distance = mindistance;
			if (distance > maxdistance)
				distance = maxdistance;
			distance = distance - mindistance;
			
			local float kb;
			local float maxkb = 900;
			local float minkb = 500;
			local float kbrange = maxdistance-mindistance;
			kb = maxkb * (distance/kbrange);
			kb = rint(kb);
			if(kb < minkb)
				kb = minkb;
	
			//local vector offset = '0 0 0';
			//local float zoff =
			//offset_z = zoff;
			local vector midpoint = ((targ.origin + attacker.origin) / 2) + '0 0 128';

			
			local vector dir = targ.origin - midpoint;
			dir = normalize(dir) * -1;
			//bprint(2,strcat(ftos(kb),"kb ", ftos(distance/kbrange),"perc\n"));
			targ.velocity = dir * kb;
			targ.velocity_z = kb;
			
			local entity harpoontimer = spawn();
			harpoontimer.classname = CN_HARPOONTIMER;
			harpoontimer.owner = targ;
			harpoontimer.mcpgren = attacker; //using this to track attacker
			harpoontimer.think = SUB_Remove;
			harpoontimer.nextthink = time + HARPOON_QUADWINDOW;
			
			mcp_HarpoonMarker(targ, attacker);
			remove(self);
		}
	
};

void think_harpoonlink() =
{
	self.nextthink = time + 0.01;
	if(self.mcpgren.classname != CN_HARPOON || self.mcpgren.movetype == MOVETYPE_TOSS)
	{
		self.movetype = MOVETYPE_BOUNCE;
		self.nextthink = time + 1;
		self.think = SUB_Remove;
		return;
	}
	local vector temp;
	temp = self.mcpgren.origin - self.mcpgren.owner.origin;
	setorigin (self,(self.mcpgren.owner.origin + (temp * self.bubble_count)));
	self.angles = vectoangles(normalize(temp));
};

void touch_harpoon() =
{
	if (other == self.owner)
		return;

	if (other.solid == SOLID_TRIGGER)
		return; // trigger field, do nothing

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

	// hit something that bleeds
	if (other.takedamage)
	{
		spawn_touchblood (18);
		mcp_Sound(self,CHAN_WEAPON, SND_HARPOONHITMEAT, 1, ATTN_NORM);
		mcp_SpawnMeatSpray(self.origin, '30 -30 10');
		mcp_SpawnMeatSpray(self.origin, '-30 30 10');
		mcp_SpawnMeatSpray(self.origin, '30 30 10');
		deathmsg = MCPDEATH_HARPOON;
		mcp_Damage (other, self, self.owner, HARPOON_DAMAGE);
		self.velocity = '0 0 0';
		self.touch = SUB_Null;
		self.think = SUB_Remove;
		
		if(other.classname == CN_PLAYER && other.team_no != self.owner.team_no)
		{
			self.nextthink = time + 0.6;
			self.movetype = MOVETYPE_FOLLOW;
			self.aiment = other;
			
		}
		else
		{
			self.nextthink = time + 1;
			self.movetype = MOVETYPE_TOSS;
		}
	}
	else
	{
		
		WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte (MSG_MULTICAST, TE_SUPERSPIKE);
		WriteCoord (MSG_MULTICAST, self.origin_x);
		WriteCoord (MSG_MULTICAST, self.origin_y);
		WriteCoord (MSG_MULTICAST, self.origin_z);
		multicast (self.origin, MULTICAST_PHS);
		self.touch = SUB_Null;
		self.nextthink = time + 1;
		self.velocity = '0 0 0';
		self.think = SUB_Remove;
		self.movetype = MOVETYPE_TOSS;
	}
	
};

void mcp_ThrowHarpoon() = 
{	
	if(self.ammo_cells < 100)
	{
		stufferror(self, "insufficient energy, 100 needed.");
		return;
	}
	mcp_SpecialSuccess(self);
	
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.team_no = self.team_no;	
	// set newmis speed     
	makevectors (self.v_angle);
	newmis.velocity = v_forward;
	newmis.velocity = newmis.velocity * HARPOON_SPEED; //1000
	newmis.angles = vectoangles(newmis.velocity);
	newmis.touch = touch_harpoon;
	newmis.voided = 0;
	
	// set newmis duration
	newmis.nextthink = time + 5;
	newmis.think = SUB_Remove;
	newmis.classname = CN_HARPOON;
	mcp_Sound(self, CHAN_ITEM, SND_HARPOONTHROW, 1, ATTN_NORM);
	mcp_SetModel(newmis, MDL_HARPOON, DIM_WORLD);
	if(self.team_no == MCPTEAM_BLUE)
		newmis.skin = 1;
	if(self.team_no == MCPTEAM_RED)
		newmis.skin = 2;
	setsize (newmis, '0 0 0', '0 0 0');             
	setorigin (newmis, self.origin + '0 0 16');
		//setorigin (newmis, self.origin + v_forward*8 + '0 0 16');
		
	local float links = 5;
	local float distincrement = 1 / links; 
	local float dist = 0;
	while (links >= 0)
	{
		local entity newlink = spawn ();
		newlink.solid = SOLID_NOT;
		newlink.mcpgren = newmis;		//using .gren to keep track of harpoon 'head'
		newlink.bubble_count = dist;	//using bubble_count to keep track of distance modifier
		newlink.owner = self;
		newlink.think = think_harpoonlink;
		newlink.nextthink = time + 0.01;
		mcp_SetModel(newlink, MDL_HARPOONLINK, DIM_WORLD);
		if(self.team_no == MCPTEAM_BLUE)
			newmis.skin = 1;
		if(self.team_no == MCPTEAM_RED)
			newmis.skin = 2;
		setsize (newlink, '0 0 0', '0 0 0');  
		links = links - 1;
		dist = dist + distincrement;
			
		local vector temp;
		temp = newmis.origin - self.origin;
		setorigin (newlink,(self.origin + (temp * self.bubble_count)));
		newlink.angles = vectoangles(normalize(temp));
	}
};

//BOMBER




void mcp_DetStickys(entity e)=
{
	if(e.attack_finished - 0.35 > time && e.deadflag > 0)
		return;
		
	local float playsound = 0;
	local entity te = find(world, classname, CN_STICKY_TRAP);
	while (te) 
	{
		if (te.owner == e && te != world) 
		{
			te.think = explode_stickysurface;
			te.nextthink = time;
			playsound = 1;
		}
		te = find(te, classname, CN_STICKY_TRAP);
        }
        
        local entity te2 = find(world, classname, CN_STICKY_DIRECT);
	while (te2) 
	{
		if (te2.owner == e && te2 != world) 
		{
			te2.think = explode_stickyair;
			te2.nextthink = time;
			playsound = 1;
		}
		te2 = find(te2, classname, CN_STICKY_DIRECT);
		
        }
        
        if(playsound == 1)
		stuffsound(e, SND_DETSTICKY);
};

//SUPPORT
float IsTeleBlocked(entity tb) =
{

	
	//points looking down 
	// t1  t2  t3
	// t4  t5  t6
	// t7  t8  t9
	
	
	
	//VEC_HULL_MAX = '16 16 32';
	//VEC_HULL_MIN = '-16 -16 -24';

	
	local vector t1 = tb.origin + '16 16 32';
	local vector t2 = tb.origin + '0 16 32';
	local vector t3 = tb.origin + '16 16 32';
	
	local vector t4 = tb.origin + '-16 0 32';
	local vector t5 = tb.origin + '0 0 32';
	local vector t6 = tb.origin + '16 0 32';
	
	local vector t7 = tb.origin + '-16 -16 32';
	local vector t8 = tb.origin + '0 -16 32';
	local vector t9 = tb.origin + '16 -16 32';
	
	local vector b1 = tb.origin + '16 16 -24';
	local vector b2 = tb.origin + '0 16 -24';
	local vector b3 = tb.origin + '16 16 -24';
	
	local vector b4 = tb.origin + '-16 0 -24';
	local vector b5 = tb.origin + '0 0 -24';
	local vector b6 = tb.origin + '16 0 -24';
	
	local vector b7 = tb.origin + '-16 -16 -24';
	local vector b8 = tb.origin + '0 -16 -24';
	local vector b9 = tb.origin + '16 -16 -24';
	
	local float pct1 = pointcontents(t1);
	local float pct2 = pointcontents(t2);
	local float pct3 = pointcontents(t3);
	
	local float pct4 = pointcontents(t4);
	local float pct5 = pointcontents(t5);
	local float pct6 = pointcontents(t6);
	
	local float pct7 = pointcontents(t7);
	local float pct8 = pointcontents(t8);
	local float pct9 = pointcontents(t9);
	
	local float pcb1 = pointcontents(b1);
	local float pcb2 = pointcontents(b2);
	local float pcb3 = pointcontents(b3);
	
	local float pcb4 = pointcontents(b4);
	local float pcb5 = pointcontents(b5);
	local float pcb6 = pointcontents(b6);
	
	local float pcb7 = pointcontents(b7);
	local float pcb8 = pointcontents(b8);
	local float pcb9 = pointcontents(b9);
	
	/*
	bprint(2,strcat(ftos(pointcontents(t1)),"t1\n"));
	bprint(2,strcat(ftos(pointcontents(t2)),"t2\n"));
	bprint(2,strcat(ftos(pointcontents(t3)),"t3\n"));
	bprint(2,strcat(ftos(pointcontents(t4)),"t4\n"));
	bprint(2,strcat(ftos(pointcontents(t5)),"t5\n"));
	bprint(2,strcat(ftos(pointcontents(t6)),"t6\n"));
	
	bprint(2,strcat(ftos(pointcontents(b1)),"b1\n"));
	bprint(2,strcat(ftos(pointcontents(b2)),"b2\n"));
	bprint(2,strcat(ftos(pointcontents(b3)),"b3\n"));
	bprint(2,strcat(ftos(pointcontents(b4)),"b4\n"));
	bprint(2,strcat(ftos(pointcontents(b5)),"b5\n"));
	bprint(2,strcat(ftos(pointcontents(b6)),"b6\n"));
	*/
	
	if(pct1 == CONTENT_SOLID || pct1 == CONTENT_SKY)
		return 1;
	if(pct2 == CONTENT_SOLID || pct2 == CONTENT_SKY)
		return 1;
	if(pct3 == CONTENT_SOLID || pct3 == CONTENT_SKY)
		return 1;
		
	if(pct4 == CONTENT_SOLID || pct4 == CONTENT_SKY)
		return 1;
	if(pct5 == CONTENT_SOLID || pct5 == CONTENT_SKY)
		return 1;
	if(pct6 == CONTENT_SOLID || pct6 == CONTENT_SKY)
		return 1;
		
	if(pct7 == CONTENT_SOLID || pct7 == CONTENT_SKY)
		return 1;
	if(pct8 == CONTENT_SOLID || pct8 == CONTENT_SKY)
		return 1;
	if(pct9 == CONTENT_SOLID || pct9 == CONTENT_SKY)
		return 1;
		
	if(pcb1 == CONTENT_SOLID || pcb1 == CONTENT_SKY)
		return 1;
	if(pcb2 == CONTENT_SOLID || pcb2 == CONTENT_SKY)
		return 1;
	if(pcb3 == CONTENT_SOLID || pcb3 == CONTENT_SKY)
		return 1;
		
	if(pcb4 == CONTENT_SOLID || pcb4 == CONTENT_SKY)
		return 1;
	if(pcb5 == CONTENT_SOLID || pcb5 == CONTENT_SKY)
		return 1;
	if(pcb6 == CONTENT_SOLID || pcb6 == CONTENT_SKY)
		return 1;
		
	if(pcb7 == CONTENT_SOLID || pcb7 == CONTENT_SKY)
		return 1;
	if(pcb8 == CONTENT_SOLID || pcb8 == CONTENT_SKY)
		return 1;
	if(pcb9 == CONTENT_SOLID || pcb9 == CONTENT_SKY)
		return 1;

	
	traceline(t1,b1,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;
		
	traceline(t2,b2,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;
		
	traceline(t3,b3,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;
	
	traceline(t4,b4,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;
		
	traceline(t5,b5,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;
		
	traceline(t6,b6,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;
		
	traceline(t7,b7,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;
		
	traceline(t8,b8,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;
		
	traceline(t9,b9,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;

	return 0;

	
};

void touch_teleballdeath() =
{
	if (other == self.owner)
		return;

	if (other.classname == CN_PLAYER) 
	{
		if(other.deadflag == DEAD_NO)
		{
			deathmsg = MCPDEATH_TELEBALL;
			mcp_Damage(other, self, self.owner, 5000);
		}
	}
};

void mcp_SpawnTeleballDeath(vector org, entity e) = 
{
	local entity death;
	death = spawn();
	death.classname = CN_TELEBALLDEATH;
	death.movetype = MOVETYPE_NONE;
	death.solid = SOLID_TRIGGER;
	death.angles = '0 0 0';
	setsize(death, e.mins - '4 4 4', e.maxs + '4 4 4');
	setorigin(death, org);
	death.touch = touch_teleballdeath;
	death.nextthink = time + 0.2;
	death.think = SUB_Remove;
	death.owner = e;
	force_retouch = 2;
};

void Teleport2Ball () =
{
	local entity tb = world;
	local entity te = find(world, classname, CN_TELEBALL);
	while (te) 
	{
		if (te.owner == self && te != world) 
		{
			tb = te;
		}
		te = find(te, classname, CN_TELEBALL);
	}
	if(tb == world)
		return;

	

	//tracebox(tb.origin, VEC_HULL_MIN, VEC_HULL_MAX, tb.origin, FALSE, tb);

	//if (trace_fraction != 1)
	if(IsTeleBlocked(tb) == 1)
	{
		if (trace_ent.classname == "worldspawn")
		{
			stufferror(self,"teleport obstructed.");
			return;
		}
	}

	local float r = RNG(5);
	if (r == 1)
	{
		mcp_Sound(self, CHAN_ITEM, SND_R_TELE1, 1, ATTN_NORM);
		mcp_Sound(tb, CHAN_ITEM, SND_R_TELE1, 1, ATTN_NORM);
	}
	else if (r == 2)
	{
		mcp_Sound(self, CHAN_ITEM, SND_R_TELE2, 1, ATTN_NORM);
		mcp_Sound(tb, CHAN_ITEM, SND_R_TELE2, 1, ATTN_NORM);
	}
	else if (r == 3)
	{
		mcp_Sound(self, CHAN_ITEM, SND_R_TELE3, 1, ATTN_NORM);
		mcp_Sound(tb, CHAN_ITEM, SND_R_TELE3, 1, ATTN_NORM);
	}
	else if (r == 4)
	{
		mcp_Sound(self, CHAN_ITEM, SND_R_TELE4, 1, ATTN_NORM);
		mcp_Sound(tb, CHAN_ITEM, SND_R_TELE4, 1, ATTN_NORM);
	}
	else
	{
		mcp_Sound(self, CHAN_ITEM, SND_R_TELE5, 1, ATTN_NORM);
		mcp_Sound(tb, CHAN_ITEM, SND_R_TELE5, 1, ATTN_NORM);
	}
	mcp_ParticleTeleport(self.origin);
	mcp_ParticleTeleport(tb.origin + 32 * v_forward);
	mcp_SpawnTeleballDeath (tb.origin, self);
	setorigin(self, tb.origin);
	remove(tb);
};
void touch_teleball() =
{
	if(other.classname != "worldspawn")
		return;
	if(time < self.cnt)
		return;
	self.cnt = time + 0.2;
	local float rng = RNG(2);
		
	if (rng == 1)
	{
		mcp_Sound(self, CHAN_ITEM, SND_TELEBALLIDLE, 1, ATTN_NORM);
	}
	else
	{
		mcp_Sound(self, CHAN_ITEM, SND_TELEBALLIDLE2, 1, ATTN_NORM);
	}
		
};

void think_teleball() =
{
	self.bubble_count = self.bubble_count + 1;
	self.nextthink = time + 1;
	
	if(self.bubble_count == 1 || self.bubble_count == 3 || self.bubble_count == 6 || self.bubble_count == 9)
	{
		local float rng = RNG(2);
		if (rng == 1)
		{
			mcp_Sound(self, CHAN_ITEM, SND_TELEBALLIDLE, 1, ATTN_NORM);
		}
		else
		{
			mcp_Sound(self, CHAN_ITEM, SND_TELEBALLIDLE2, 1, ATTN_NORM);
		}
	}

	if(self.bubble_count >= TELEBALL_DURATION)
	{
		self.owner.ammo_cells = self.owner.ammo_cells + 50;
		sprint(self.owner, PRINT_HIGH, "teleport fizzled.\n");
		mcp_Sound(self, CHAN_ITEM, SND_TELEBALLEND, 1, ATTN_NORM);
		if(self.owner.ammo_cells >= 100)
		{
			self.owner.ammo_cells = 100;
			stuffsound(self, SND_SPECIALREADY);
		}
		remove(self);
	}
};

void SpawnTeleBall() =
{
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_BOUNCEMISSILE;
	newmis.solid = SOLID_TRIGGER;
		
	// set newmis speed     
	makevectors (self.v_angle);
	newmis.velocity = aim(self, 1000);
	newmis.velocity = newmis.velocity * TELEBALL_SPEED; 
	newmis.angles = vectoangles(newmis.velocity);
	
	newmis.voided = 0;
	
	// set newmis duration
	newmis.nextthink = time + 0.1;
	newmis.think = think_teleball;
	newmis.classname = CN_TELEBALL;
	newmis.touch = touch_teleball;

	mcp_SetModel (newmis, MDL_TELEBALL, DIM_WORLD);
	if(self.team_no == MCPTEAM_BLUE)
		newmis.skin = 1;
	else if (self.team_no == MCPTEAM_RED)
		newmis.skin = 2;
	else
		newmis.skin = 0;

	//setsize (newmis, '-8 -8 -8', '8 8 8');
	//setsize(newmis,'0 0 0', '0 0 0');
	setsize (newmis, VEC_HULL_MIN, VEC_HULL_MAX);
	setorigin (newmis, self.origin + '0 0 16');
	mcp_Sound(newmis, CHAN_ITEM, SND_TELEBALLSTART, 1, ATTN_NORM);
};

void mcp_TeleSkill() =
{
	local entity tb = world;
	local entity te = find(world, classname, CN_TELEBALL);
	while (te) 
	{
		if (te.owner == self && te != world) 
		{
			tb = te;
		}
		te = find(te, classname, CN_TELEBALL);
	}
	if (tb == world)
	{
		if (self.ammo_cells < 100)
		{
			stufferror(self, "insufficient energy, 100 needed.");
		return;
		}
		mcp_SpecialSuccess(self);
		SpawnTeleBall();
		return;
	}
	Teleport2Ball();
	
};


//mgunner
void mcp_Leap() =
{
	if(self.ammo_cells < 100)
	{
		stufferror(self, "insufficient energy, 100 needed.");
		return;
	}
	mcp_SpecialSuccess(self);
	
	makevectors (self.v_angle);
        local vector org = self.origin;
	local vector targ = (org + '0 0 96') + (v_forward * 600);
	local vector midpoint = ((targ + org) / 2) + '0 0 64';
	local vector dir = normalize(midpoint - org);

	mcp_Sound(self, CHAN_AUTO, SND_LEAP, 1, ATTN_NORM);
	self.velocity = dir * LEAP_VELOCITY;
};

void think_fiendleaptracker() =
{	
	self.nextthink = time + 0.05;
	
	if(time > self.bubble_count)
		remove(self);
	
	if(self.owner.deadflag != DEAD_NO)
		remove(self);
	
	if(self.owner.flags & FL_ONGROUND)
		remove(self);
	
	
};

void mcp_LeapFiend() =
{
	if(self.ammo_cells < 100)
	{
		stufferror(self, "insufficient energy, 100 needed.");
		return;
	}
	mcp_SpecialSuccess(self);
	
	makevectors (self.v_angle);
        local vector org = self.origin;
	local vector targ = (org + '0 0 96') + (v_forward * 600);
	local vector midpoint = ((targ + org) / 2) + '0 0 64';
	local vector dir = normalize(midpoint - org);
	
	if(self.playerclass == ROLE_FIEND)
	{
		mcp_Sound(self, CHAN_AUTO, SND_DJUMP, 1, ATTN_NORM);
		mcpfiend_leap1();
		self.velocity = dir * LEAPFIEND_VELOCITY;
	}
	if(self.playerclass == ROLE_BABYFIEND)
	{
		mcp_Sound(self, CHAN_AUTO, SND_BABYFIEND_JUMP, 1, ATTN_NORM);
		mcpfiend_leap1();
		self.velocity = dir * LEAPBABYFIEND_VELOCITY;
	}
	local entity fleaptrack = spawn();
	fleaptrack.classname = CN_FIENDLEAPTRACKER;
	fleaptrack.nextthink = time + LEAPFIEND_MINWINDOW;
	fleaptrack.owner = self;
	fleaptrack.think = think_fiendleaptracker;
	fleaptrack.cnt = time + LEAPFIEND_MAXWINDOW;	
};

//arsonist
void ExplodeDots(entity e, entity attacker) =
{
	local float dots = 0;
	local float dots2 = 0;
	local entity te = find(world, classname, CN_FLAMERDOT);
	while (te) 
	{
		if (te.mcpgren == e)
		{
			dots = dots + te.cnt;
			remove(te);
		}
		te = find(te,classname,CN_FLAMERDOT);
	}
	local entity te2 = find(world, classname, CN_MOLOTOVDOT);
	while (te2) 
	{
		if (te2.mcpgren == e)
		{
			dots2 = dots2 + te2.cnt;
			remove(te2);
		}
		te2 = find(te2,classname,CN_MOLOTOVDOT);
	}
	
	
	if(dots > 0 || dots2 > 0)
	{
		mcp_Sound(e, CHAN_AUTO, SND_IGNITE,1, ATTN_NORM);
		stuffsound(attacker,SND_IGNITE);
		stuffsound(e,SND_IGNITE);
		deathmsg = MCPDEATH_IGNITE;
		mcp_Damage(e,attacker,attacker,dots*FLAMER_DOTEXPLODE+dots2*MOLOTOV_DOTEXPLODE);
	}
	
};

void touch_airblastsprite() =
{
	remove(self);
};

void think_airblastsprite() =
{
	self.nextthink = time + 0.01;
	self.frame--;

	if(time > self.cnt)
		remove(self);
};

void mcp_SpawnAirblastSprite(entity e) =
{
	newmis = spawn ();
	newmis.owner = e;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
		
	// set newmis speed     
	makevectors (e.v_angle);
	newmis.velocity = v_forward;
	newmis.velocity = newmis.velocity * MCP_AIRBLASTROCKET_SPEED; //1000
	newmis.angles = vectoangles(newmis.velocity);
	
	newmis.touch = touch_airblastsprite;
	newmis.voided = 0;

	// set newmis duration
	newmis.nextthink = time;
	newmis.think = think_airblastsprite;
	newmis.classname = CN_AIRBLASTSPRITE;    
	mcp_SetModel(newmis, SPR_AIRBLAST, DIM_WORLD);
	newmis.frame = 6;
	newmis.cnt = time + 0.5;
	setsize (newmis, '0 0 0', '0 0 0');          
	setorigin (newmis, self.origin + v_forward*8 + '0 0 16');
};

void mcp_Airblast(entity e) =
{
	if(e.ammo_cells < 100)
	{
		stufferror(e,"insufficient cells, 100 needed.");
		return;
	}
	mcp_SpecialSuccess(e);
	
	mcp_Sound(e,CHAN_ITEM, SND_AIRBLAST, 1, ATTN_NORM);
	mcp_SpawnAirblastSprite(e);
	SpawnAirblastMissile(e);
	makevectors(e.v_angle);
	traceline (e.origin + '0 0 16', e.origin + + '0 0 16' + v_forward * 2048, 0, e);		//using trace_endpos for projectiles
	local vector targpos = e.origin + '0 0 16' + v_forward * 1000;					//using this for players
	local vector targdir;
	
	//targvec = normalize(targvec - self.origin);
	
        local entity head = findradius(e.origin + (v_forward * (AIRBLAST_RADIUS/2)), AIRBLAST_RADIUS);
      
        while (head)
	{

		targdir = normalize(trace_endpos - head.origin);
		 
		if (head.classname == CN_PLAYER && head != e)
		{
			local float push = vlen (e.origin + v_forward*32 - head.origin);
			if(push > 170)
				push = 170;

			push = push/170;
			push = 1 - push;
			push = AIRBLAST_MAXPLAYERPUSH * push;
			if(push < AIRBLAST_MINPLAYERPUSH)
				push = AIRBLAST_MINPLAYERPUSH;
			
			//if(distance < mindistance)
			//	distance = mindistance;
			//if (distance > maxdistance)
			//	distance = maxdistance;
			//distance = distance - mindistance;
			//bprint(2,strcat(ftos(dist),"dust\n"));
			
			head.velocity = normalize(targpos - head.origin) * push;
			//head.velocity = head.velocity + '0 0 32';
			
			ExplodeDots(head,e);
		}
		
		else if (head.classname == CN_TELEBALL)
		{
			head.velocity = targdir * vlen(head.velocity);
			head.angles = vectoangles(head.velocity);
		}
		else if (head.classname == CN_ROCKET || head.classname == CN_THROWNGRENADE || head.classname == CN_NAIL || head.classname == CN_HARPOON)
		{
			//local entity targent = spawn();
			//mcp_SetModel(targent, "progs/beta1/mcp_teleball.mdl");
			//setorigin(targent, trace_endpos);
			//targent.nextthink = time + 2;
			//targent.think = SUB_Remove;
			
			/////head.gren = head.owner;
			
			if(head.owner.team_no != e.team_no)
			{
				//head.owner = e;
				if(e.team_no == MCPTEAM_BLUE)
				{
					head.skin = 1;
				}
				else
				{
					head.skin = 2;
				}
				
			}
			head.velocity = targdir * vlen(head.velocity);
			head.angles = vectoangles(head.velocity);
		}
		head = head.chain;
	}

};

//TECHNICIAN
void think_drone() =
{	
	local entity os = self;
	self = self.owner;
	mcp_UnBecomeDrone(self);
	self = os;
	self.think = SUB_Remove;
	self.nextthink = time;
};

void mcp_BecomeDrone(entity e) =
{
	if(e.ammo_cells < 100)
	{
		stufferror(e,"insufficient cells, 100 needed.");
		return;
	}
	if(e.mcpweapstate == MCPWEAPSTATE_DRONE || e.mcpweapstate == MCPWEAPSTATE_DRONESHOOT)
	{
		stufferror(e,"you are already a drone!");
		return;
	}
	mcp_SpecialSuccess(e);
	
	local entity te = spawn();			
	te.classname = CN_DRONETIMER;
	te.owner = e;
	te.think = think_drone;
	te.nextthink = time+DRONE_DURATION;
	
	mcp_SetModel(e, MDL_MCPDRONE, DIM_WORLD);
	if(e.team_no == MCPTEAM_BLUE)
		e.skin = 1;
	else
		e.skin = 2;
	e.movetype = MOVETYPE_FLY;
	e.mcpweapstate = MCPWEAPSTATE_DRONE;
	mcp_ChangeWeaponModel(e, MCPWEAP_DRONEGUN,0);
	mcp_UpdateHudAmmo(e, MCPWEAP_DRONEGUN);
	mcpdrone_stand();
	mcp_SetPlayerSpeed(e);
	
	local string ec = infokey(e, IK_EXECCLASSCFG);
		
	if(ec == "1" || ec == "on" || ec == "2")
		stuffcmd(e, "exec drone.cfg\n");
	mcp_Sound(e, CHAN_ITEM, SND_DRONESTART, 1, ATTN_NORM);
	e.attack_finished = time + 1;

};

void mcp_UnBecomeDrone(entity e) =
{	

	e.mcpweapstate = MCPWEAPSTATE_NONE;
	mcp_SetModel(e, MDL_MCPPLAYER, DIM_WORLD);
	modelindex_player = e.modelindex;
	mcpplayer_stand1();
	e.movetype = MOVETYPE_WALK;
	mcp_SetPlayerSkin(e);
	mcp_ChangeWeaponModel(e, e.mcpslot[e.weapon].type,0);
	mcp_UpdateHudAmmo(e, e.mcpslot[e.weapon].type);
	mcp_SetPlayerSpeed(e);
	
	local string ec = infokey(e, IK_EXECCLASSCFG);
	if(ec == "1" || ec == "on")
		stuffcmd(e, "exec technician.cfg\n");
	if(ec == "2")
		stuffcmd(e, "exec engineer.cfg\n");
	mcp_Sound(e, CHAN_ITEM, SND_DRONEEND, 1, ATTN_NORM);
	e.attack_finished = time + 1;
};


//detrocket
void mcp_DetRockets(entity e) =
{
	local entity te = find(world, classname, CN_ROCKET);
	while (te) 
	{
		if (te.owner == e && te != world) 
		{
			te.think = explode_detrocket;
			te.nextthink = time;
		}
		te = find(te, classname, CN_ROCKET);
        }
};
void think_babymarker() =
{
	if(time > self.bubble_count)
		remove(self);
	if(self.mcpgren.deadflag != DEAD_NO)
		remove(self);
	self.nextthink = time + 0.001;
	local float dist = vlen((self.mcpgren.origin + '0 0 -48') - self.owner.origin);
	local vector dir = normalize((self.mcpgren.origin + '0 0 -48') - self.owner.origin);
	self.angles = vectoangles(dir);
	setorigin(self,self.owner.origin + dir*32 + '0 0 24');
	local float maxdist = 1000;
	if(dist > maxdist)
		dist = maxdist;
	local float f = rint(dist/maxdist * 100);
	if(f >= 100)
	 f=99;
	self.frame = f;
	
	
};
void mcp_CreateBabyMarker(entity o, entity targ) =
{
	local entity te = spawn();
	te.owner = o;
	te.mcpgren = targ;
	te.nextthink = time;
	te.think = think_babymarker;
	te.bubble_count = time + THROWMEAT_DURATION;
	mcp_SetModel(te, MDL_PINGMARKER, o.mcpclientdim);
	te.movetype = MOVETYPE_NONE;
	te.solid = SOLID_NOT;
};

void think_throwmeatattract() =
{
	local entity te = find(world, classname, CN_PLAYER);
	while(te)
	{
		if(te != world && te.playerclass == ROLE_BABYFIEND)
		{
			if(te.deadflag == DEAD_NO)
			{
				mcp_Sound(te, CHAN_AUTO, SND_BABYFIEND_FRESHMEAT, 1, ATTN_NORM);
				mcp_CreateBabyMarker(self.owner, te);
			}
		}
		te = find(te, classname, CN_PLAYER);
	}
	remove(self);
}

void explode_throwmeat() =
{
	mcp_ThrowGib(MDL_MCPPLAYERGIB1,10);
	mcp_ThrowGib(MDL_MCPPLAYERGIB1,20);
	mcp_ThrowGib(MDL_MCPPLAYERGIB3,60);
	mcp_ThrowGib(MDL_MCPPLAYERGIB3,80);
	mcp_Sound(self, CHAN_ITEM, SND_Z_MISS, 1, ATTN_NORM);
	self.think = think_throwmeatattract;
	self.nextthink = time + 1;
	self.touch = SUB_Null;
	mcp_SetModel(self,"",DIM_WORLD);
}	

void touch_throwmeat() =
{
	if (other == self.owner)
		return;

	self.think = explode_throwmeat;
	self.nextthink = time;
	self.touch = SUB_Null;
	
};

void mcp_ThrowMeat(entity e) =
{
	if(e.ammo_cells < 100)
	{
		stufferror(e,"insufficient cells, 100 needed.");
		return;
	}
	
	mcp_SpecialSuccess(e);
	
	local float rng = RNG(4);
	if(rng == 1)
		stuffsoundall(SND_KITTY1, world);
	if(rng == 2)
		stuffsoundall(SND_KITTY2, world);
	if(rng == 3)
		stuffsoundall(SND_KITTY3, world);
	if(rng == 4)
		stuffsoundall(SND_KITTY4,world);
	
	
	stuffsound(e,SND_GRENTHROW_GENERIC);
	newmis = spawn();
	mcp_SetModel(newmis, MDL_THROWMEAT, DIM_WORLD);
	newmis.movetype = MOVETYPE_BOUNCE;
	newmis.owner = e;
	newmis.classname = CN_THROWMEAT;
	newmis.solid = SOLID_BBOX;
	newmis.nextthink = time + 3;
	newmis.think = explode_throwmeat;
	newmis.touch = touch_throwmeat;
	setorigin(newmis, e.origin);
	setsize(newmis,'0 0 0', '0 0 0');
	local float grenspeed = 600;
	if (self.v_angle_x) 
	{
		newmis.velocity = v_forward * grenspeed + v_up * 200 + crandom() * v_right * 10 + crandom() * v_up * 10;
	}
	else 
	{
		newmis.velocity = aim(e, 10000);
		newmis.velocity = newmis.velocity * grenspeed;
		newmis.velocity_z = 200;
	}
	newmis.angles = vectoangles(newmis.velocity);

};



void mcp_SpecialSkill (entity e) =
{
	e.impulse = 0;
	if(e.deadflag != DEAD_NO || e.team_no == MCPTEAM_NONE)
		return;
	
	if(e.mcpspecialtype == MCPSPECIAL_RANDOM)
	{
		bprint(2,strcat(e.netname, " error: mcp_specialskill(mcpspecial_random)\n"));
	}
		
	if(e.mcpspecialtype == MCPSPECIAL_DASH)
	{
		mcp_Dash();
	}
	if(e.mcpspecialtype == MCPSPECIAL_CLOAK)
	{
		mcp_Cloak();
	}
	if(e.mcpspecialtype == MCPSPECIAL_HARPOON)
	{
		mcp_ThrowHarpoon();
	}
	if(e.mcpspecialtype == MCPSPECIAL_DETSTICKY)
	{
		mcp_DetStickys(e);
	}
	if(e.mcpspecialtype == MCPSPECIAL_DETROCKET)
	{
		mcp_DetRockets(e);
	}
	if(e.mcpspecialtype == MCPSPECIAL_TELEBALL)
	{
		mcp_TeleSkill();
	}
	if(e.mcpspecialtype == MCPSPECIAL_LEAP)
	{
		mcp_Leap();
	}
	if(e.mcpspecialtype == MCPSPECIAL_LEAPFIEND)
	{
		mcp_LeapFiend();
	}
	if(e.mcpspecialtype == MCPSPECIAL_AIRBLAST)
	{
		mcp_Airblast(e);
	}
	if(e.mcpspecialtype == MCPSPECIAL_DRONE)
	{
		mcp_BecomeDrone(e);
	}
	if(e.mcpspecialtype == MCPSPECIAL_THROWMEAT)
	{
		mcp_ThrowMeat(e);
	}
	return;
};
