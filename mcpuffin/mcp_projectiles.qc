void mcp_MidAir(entity attacker, entity targ, float dist) =
{
	local entity te;
	local float rng = RNG(3);
	
	if(targ.hasbeenmidaired)
	{
			
		te = find(world, classname, CN_MIDAIRCOUNTER);
		while (te) 
		{
			if (te.owner == targ && te.mcpgren == attacker && te != world) 
			{
				te.cnt++;
				//AddStat(attacker, STAT_ROCKETMIDAIR, te.cnt);
				sprint(attacker,PRINT_HIGH,strcat("you midaired ",targ.netname, "x",ftos(te.cnt), " (",ftos(dist),")\n"));
				if(te.cnt == 2)
				{
					if(rng == 1)
						stuffsoundall(SND_MIDAIR1, world);
					else if (rng == 2)
						stuffsoundall(SND_MIDAIR2, world);
					else
						stuffsoundall(SND_MIDAIR3, world);
				}
				if(te.cnt >= 3)
					stuffsoundall(SND_MLG, world);
			}
			te = find(te, classname, CN_MIDAIRCOUNTER);
		}
	}
	else
	{
		if(dist < 96)		//trying to weed out initial baby middys
			return;
		te = spawn();
		te.classname = CN_MIDAIRCOUNTER;
		te.owner = targ;
		te.mcpgren = attacker;
		te.nextthink = time + 60;
		te.think = SUB_Remove;
		te.cnt = 1;
		//AddStat(attacker, STAT_ROCKETMIDAIR, 1);
		
		sprint(attacker,PRINT_HIGH,strcat("you midaired ",targ.netname, " x",ftos(1), " (",ftos(dist),"dist)\n"));

			if(rng == 1)
				stuffsoundall(SND_MIDAIR1, world);
			else if (rng == 2)
				stuffsoundall(SND_MIDAIR2, world);
			else
				stuffsoundall(SND_MIDAIR3, world);
			
	}
	targ.hasbeenmidaired = 1;
	//AddStat(attacker, STAT_ROCKETMIDAIRDIST, dist);
};

void explode_airblastmissile (entity inflictor, entity attacker, float damage, entity ignore) =
{

	
	local   float   points;
	local   entity  head;
	local   vector  org;
	
	head = findradius(inflictor.origin, damage+40);
	

	while (head)
	{
		//bprint (PRINT_HIGH, head.classname);
		//bprint (PRINT_HIGH, " | ");
		//bprint (PRINT_HIGH, head.netname);
		//bprint (PRINT_HIGH, "\n");
		

		if (head != ignore)
		{
			if (head.takedamage)
			{
				org = head.origin + (head.mins + head.maxs)*0.5;
				points = 0.5*vlen (inflictor.origin - org);
				if (points < 0)
					points = 0;
				points = damage - points;
				
				if (head == attacker)
					points = points * 0.75;
				if (points > 0)
				{
					if (CanDamage (head, inflictor))
					{
						if(head == attacker)
						{
							mcp_Knockback (head, inflictor, attacker, points);
						}
					}
				}
			}
		}
		head = head.chain;
	}	
};


void touch_airblastmissile() =
{
	if (other == self.owner)
		return;         // don't explode on owner
	if (other.classname == CN_PLAYER)
		return;
		
	if (self.voided) 
	{
		return;
	}
	self.voided = 1;

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	explode_airblastmissile (self, self.owner, 90, other);
	multicast (self.origin, MULTICAST_PHS);

	remove(self);	
};

void SpawnAirblastMissile(entity e) =
{
	//AddStat(e, STAT_WEAPONFIRED, WPN_RL);
	newmis = spawn ();
	newmis.owner = e;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
		
	// set newmis speed     
	makevectors (e.v_angle);
	newmis.velocity = v_forward;
	newmis.velocity = newmis.velocity * MCP_AIRBLASTROCKET_SPEED; //1000
	newmis.angles = vectoangles(newmis.velocity);
	
	newmis.touch = touch_airblastmissile;
	newmis.voided = 0;

	// set newmis duration
	newmis.nextthink = time + 0.5;
	newmis.think = SUB_Remove;
	newmis.classname = CN_AIRBLASTROCKET;    
	setsize (newmis, '0 0 0', '0 0 0');          
	setorigin (newmis, self.origin + v_forward*8 + '0 0 16');
};

void () touch_mcpclimbnail = {

	if (time < self.bubble_count)
		return;
		
	self.bubble_count = time + 0.1;

	if (other.classname != CN_PLAYER)
		return;
		
	if(other.team_no != self.owner.team_no)
		return;


	if (self.origin_z > other.origin_z)
	{
		other.velocity_z = MCP_CLIMBNAIL_BOOST;
		remove(self);
	}
};

void (entity e) mcp_ConvertToClimbingNail =
{
	e.origin = self.origin + ( normalize(self.velocity) * -5);
	e.movetype = MOVETYPE_NONE;
	e.velocity = '0 0 0';
	e.solid = SOLID_TRIGGER;
	e.touch = touch_mcpclimbnail;
	e.think = SUB_Remove;
	e.nextthink = time + MCP_CLIMBNAIL_DURATION;
	e.bubble_count = time;
};

void touch_mcpnail()=
{
	if (other == self.owner)
		return;

	if (self.voided) 
		return;
		
	self.voided = 1;

	if (other.solid == SOLID_TRIGGER)
		return; 

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	
	if (other.takedamage)
	{
		if(other.classname == CN_PLAYER && other.team_no != self.owner.team_no)
		{
			//AddStat(self.owner, STAT_WEAPONHIT, WPN_SNG);
		}
			
		spawn_touchblood (18);
		deathmsg = MCPDEATH_SNG;
		mcp_Damage (other, self, self.owner, 12);
	}
	else
	{
		WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte (MSG_MULTICAST, TE_SUPERSPIKE);
		WriteCoord (MSG_MULTICAST, self.origin_x);
		WriteCoord (MSG_MULTICAST, self.origin_y);
		WriteCoord (MSG_MULTICAST, self.origin_z);
		multicast (self.origin, MULTICAST_PHS);
	}

	
	if(other.classname == "worldspawn")
	{
		mcp_ConvertToClimbingNail(self);
		return;
	}
	remove(self);
};

void () touch_mcpclimbingnail = {

	if (time < self.bubble_count)
		return;
		
	self.bubble_count = time + 0.1;

	if (other.classname != CN_PLAYER)
		return;
		
	if(other.team_no != self.owner.team_no)
		return;


	if (self.origin_z > other.origin_z)
	{
		other.velocity_z = MCP_CLIMBNAIL_BOOST;
		remove(self);
	}
};

void mcp_SpawnNail(entity e) = 
{
	local vector dir = aim (e, 1000);

	newmis = spawn ();
	newmis.voided = 0;
	newmis.owner = e;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.angles = vectoangles(dir);
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 6;
	
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);               
	setorigin (newmis, e.origin + '0 0 16');

	newmis.velocity = dir * MCP_NAIL_SPEED;
	newmis.touch = touch_mcpnail;
	newmis.classname = CN_NAIL;
	
	mcp_SetModel(newmis, MDL_NAIL, DIM_WORLD);
	if(e.team_no == MCPTEAM_BLUE)
		newmis.skin = 1;
	if(e.team_no == MCPTEAM_RED)
		newmis.skin = 2;
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);               
	msg_entity = e;
	WriteByte (MSG_ONE, SVC_SMALLKICK);
};

void explode_detrocket() =
{
	mcp_RadiusDamage (self, self.owner, 120, other, MCPDEATH_ROCKET_DETONATE, 0);

	self.origin = self.origin - 8 * normalize(self.velocity);
	mcp_ParticleExplosion(self.origin);
	remove(self);	
};

void touch_mcprocket() =
{
	local float     damg;
	local float 	hitplayer = 0;
	
	if (other == self.owner)
		return;         // don't explode on owner

	if (self.voided)
		return;
		
	self.voided = 1;

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

	damg = 90 + random()*20;
	
	if (other.health)
	{
		local float isharp = 0 ;
			
		local entity te = find(world, classname, CN_HARPOONTIMER);
		while (te) 
		{
			if (te.owner == other && te != world) 
			{
				te.nextthink = time;
				isharp = 1;
			}
			te = find(te, classname, CN_HARPOONTIMER);
		}
		if(other.classname == CN_PLAYER && other.team_no != self.owner.team_no)
		{
			hitplayer = 1;
			//AddStat(self.owner, STAT_ROCKETDIRECT, 1);
			
			if (!(other.flags & FL_ONGROUND) && !(other.flags & FL_INWATER))
			{
				traceline(other.origin, other.origin + '0 0 -10000', 1, self);
				local float dist = ceil(vlen(other.origin - trace_endpos));
				mcp_MidAir(self.owner, other, dist);
				//sprint(self.owner,PRINT_HIGH,strcat("you midaired ",self.wpnstats[1].name, "(",ftos(dist),")height\n"));
			}

		}
		if(isharp)
		{	
			deathmsg = MCPDEATH_ROCKET_HARPOON;
			mcp_Damage (other, self, self.owner, damg * 4 );
		}
		else
		{	
			deathmsg = MCPDEATH_ROCKET_DIRECT;
			mcp_Damage (other, self, self.owner, damg );
	
		}
	}

	// don't do radius damage to the other, because all the damage
	// was done in the impact

	if(hitplayer == 0)
		mcp_RadiusDamage (self, self.owner, 90, other, MCPDEATH_ROCKET_SPLASH, 1);
	else
	{
		mcp_RadiusDamage (self, self.owner, 90, other, MCPDEATH_ROCKET_SPLASH, 0);
		//AddStat(self.owner, STAT_WEAPONHIT, WPN_RL);
	}

	self.origin = self.origin - 8 * normalize(self.velocity);
	mcp_ParticleExplosion(self.origin);
	remove(self);	
};

void mcp_SpawnRocket(entity e) = 
{
	//ddStat(e, STAT_WEAPONFIRED, WPN_RL);
	newmis = spawn ();
	newmis.owner = e;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
		
	// set newmis speed     
	makevectors (e.v_angle);
	newmis.velocity = v_forward;
	newmis.velocity = newmis.velocity * MCP_ROCKET_SPEED; //1000
	newmis.angles = vectoangles(newmis.velocity);
	newmis.touch = touch_mcprocket;
	newmis.voided = 0;
	
	// set newmis duration
	newmis.nextthink = time + 5;
	newmis.think = SUB_Remove;
	newmis.classname = CN_ROCKET;

	mcp_SetModel(newmis, MDL_ROCKET,DIM_WORLD);
	if(self.team_no == MCPTEAM_BLUE)
		newmis.skin = 1;
	if(self.team_no == MCPTEAM_RED)
		newmis.skin = 2;
	setsize (newmis, '0 0 0', '0 0 0');             
	setorigin (newmis, self.origin + v_forward*8 + '0 0 16');
};

void mcp_CheckStickyLimit() = 
{
	local entity oldest = world;
	local float stickycount = 0;
	local float limit = 6;
    
	local entity te = find(world, classname, CN_STICKY_TRAP);
	while (te) 
	{
		if (te.owner == self.owner) 
		{
			stickycount = stickycount + 1;
			if (oldest == world)
				oldest = te;
			if(oldest.nextthink > te.nextthink)
				oldest = te;
		}
		te = find(te, classname, CN_STICKY_TRAP);
        }

	if (oldest == world)
		return;
		
	if (stickycount > limit)
	{
		oldest.nextthink = time + 0.2;
	}
};

void() explode_stickysurface =
{
	if (self.voided)
		return;
		
	self.voided = 1;

	mcp_RadiusDamage (self, self.owner, STICKYDAMAGE_SURFACEDET, world, MCPDEATH_STICKY_TRAP,1);

	mcp_ParticleExplosion(self.origin);
	remove (self);
};

void() explode_stickydirect =
{
	if (self.voided)
		return;
		
	self.voided = 1;

	mcp_RadiusDamage (self, self.owner, STICKYDAMAGE_DIRECT, world,MCPDEATH_STICKY_DIRECT, 1);

	mcp_ParticleExplosion(self.origin);
	remove (self);
};

void() explode_stickyair =
{
	if (self.voided) {
		return;
	}
	self.voided = 1;

	mcp_RadiusDamage (self, self.owner, STICKYDAMAGE_AIRDET, world, MCPDEATH_STICKY_AIR,1);
	mcp_ParticleExplosion(self.origin);

	remove (self);
};

void touch_sticky() = 
{
	if (other == self.owner)
		return;

	if (other.takedamage == DAMAGE_AIM) 
	{
		explode_stickydirect();
		return;
	}

	else
	{
		self.classname = CN_STICKY_TRAP;
		self.velocity = '0 0 0';
		self.avelocity = '0 0 0';
		self.movetype = MOVETYPE_NONE;
		self.think = explode_stickysurface;
		self.nextthink = time + 480;
		mcp_CheckStickyLimit();
		//if(self.owner.team_no == TEAM_BLUE)
			//self.skin = 3;
		//if(self.owner.team_no == TEAM_RED)
			//self.skin = 4;
		self.touch = SUB_Null;
		setsize (self, VEC_ORIGIN, VEC_ORIGIN);
		mcp_Sound(self, CHAN_WEAPON, SND_STICKY, 1, ATTN_NORM);
	}
};

void mcp_SpawnSticky(entity e) = 
{
	newmis = spawn ();
	newmis.voided=0;
	newmis.owner = e;
	newmis.movetype = MOVETYPE_BOUNCE;
	newmis.solid = SOLID_BBOX;
	newmis.classname = CN_STICKY_DIRECT;

		
	makevectors (e.v_angle);

	if (e.v_angle_x)
		newmis.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
	else
	{
		newmis.velocity = aim(e, 10000);
		newmis.velocity = newmis.velocity * 600;
		newmis.velocity_z = 200;
	}

	newmis.avelocity = '300 300 300';
	newmis.angles = vectoangles(newmis.velocity);
	newmis.touch = touch_sticky;
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 5;

	mcp_SetModel(newmis, MDL_STICKY, DIM_WORLD);
	if(e.team_no == MCPTEAM_BLUE)
		newmis.skin = 1;
	if(e.team_no == MCPTEAM_RED)
		newmis.skin = 2;
	setsize (newmis, '0 0 0', '0 0 0');             
	setorigin (newmis, e.origin);
};

void touch_dronebullet() =
{
	if (other == self.owner)
		return;

	if (self.voided) 
		return;
		
	self.voided = 1;

	if (other.solid == SOLID_TRIGGER)
		return; 

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	
	if (other.takedamage)
	{
		//if(other.classname == "player" && other.team_no != self.owner.team_no)
		//	AddStat(self.owner, STAT_WEAPONHIT, WPN_LASERGUN);
			
		spawn_touchblood (18);
		deathmsg = MCPDEATH_DRONEBULLET;
		mcp_Damage (other, self, self.owner, MCP_DRONEBULLET_DAMAGE);
	}
	else
	{
		WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte (MSG_MULTICAST, TE_SUPERSPIKE);
		WriteCoord (MSG_MULTICAST, self.origin_x);
		WriteCoord (MSG_MULTICAST, self.origin_y);
		WriteCoord (MSG_MULTICAST, self.origin_z);
		multicast (self.origin, MULTICAST_PHS);
	}
	mcp_Sound (self, CHAN_WEAPON, SND_ENFSTOP, 1, ATTN_NORM);
	remove(self);
};

void mcp_SpawnDroneBullet(entity e, float offset) = 
{
	local vector dir;
	makevectors(e.v_angle);
	dir = aim(e, 1000);
	
	newmis = spawn ();
	newmis.voided = 0;
	newmis.owner = e;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.angles = vectoangles(dir);
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 6;
	
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);               
	setorigin (newmis, e.origin + '0 0 16' + v_right * offset);

	newmis.velocity = dir * MCP_DRONEBULLET_SPEED;
	newmis.touch = touch_dronebullet;
	newmis.classname = CN_DRONEBULLET;
	
	mcp_SetModel(newmis, MDL_LASERBOLT, DIM_WORLD);
	if(e.team_no == MCPTEAM_BLUE)
		newmis.skin = 1;
	if(e.team_no == MCPTEAM_RED)
		newmis.skin = 2;
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);               
	msg_entity = e;
	WriteByte (MSG_ONE, SVC_SMALLKICK);
};

void touch_laserbolt() =
{
	if (other == self.owner)
		return;

	if (self.voided) 
		return;
		
	self.voided = 1;

	if (other.solid == SOLID_TRIGGER)
		return; 

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	
	if (other.takedamage)
	{
		//if(other.classname == "player" && other.team_no != self.owner.team_no)
		//	AddStat(self.owner, STAT_WEAPONHIT, WPN_LASERGUN);
			
		spawn_touchblood (18);
		deathmsg = MCPDEATH_LASERBOLT;
		mcp_Damage (other, self, self.owner, MCP_LASERBOLT_DAMAGE);
	}
	else
	{
		WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte (MSG_MULTICAST, TE_SUPERSPIKE);
		WriteCoord (MSG_MULTICAST, self.origin_x);
		WriteCoord (MSG_MULTICAST, self.origin_y);
		WriteCoord (MSG_MULTICAST, self.origin_z);
		multicast (self.origin, MULTICAST_PHS);
	}
	mcp_Sound (self, CHAN_WEAPON, SND_ENFSTOP, 1, ATTN_NORM);
	remove(self);
};

void mcp_SpawnLaserBolt(entity e) = 
{
	local vector dir = aim (e, 1000);

	newmis = spawn ();
	newmis.voided = 0;
	newmis.owner = e;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.angles = vectoangles(dir);
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 6;
	
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);               
	setorigin (newmis, e.origin + '0 0 16');

	newmis.velocity = dir * MCP_LASERBOLT_SPEED;
	newmis.touch = touch_laserbolt;
	newmis.classname = CN_LASERBOLT;
	
	mcp_SetModel(newmis, MDL_LASERBOLT, DIM_WORLD);
	if(e.team_no == MCPTEAM_BLUE)
		newmis.skin = 1;
	if(e.team_no == MCPTEAM_RED)
		newmis.skin = 2;
	setsize (newmis, '0 0 0', '0 0 0');              
	msg_entity = e;
	WriteByte (MSG_ONE, SVC_SMALLKICK);
};



void think_mcpflamerdot() =
{
	local vector dir;
	local vector vtemp = self.mcpgren.absmin;
	local vector boundsize = self.mcpgren.size;
	dir_x = random() * boundsize_x / 2 + boundsize_x / 4;
        dir_y = random() * boundsize_y / 2 + boundsize_y / 4;
        dir_z = random() * boundsize_z / 3 + boundsize_z / 2;
        vtemp = vtemp + dir;
        setorigin(self, vtemp);
        
	self.nextthink = time + 0.1;
	if(self.cnt <= 0)
	{
		remove(self);
		return;
	}
	if(time >= self.heat)
	{
		deathmsg = MCPDEATH_FLAMERDOT;
		mcp_Damage (self.mcpgren, self, self.owner, MCP_FLAMERDOT_DAMAGE );
		self.heat = time + 0.5;
		self.cnt--;
	}	
	
	
};

void touch_mcpflamer() =
{
	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	if(other == world)
	{
		remove(self);
		return;
	}
	if(other.classname == CN_PLAYER && other.team_no != self.owner.team_no)
	{
		if(other.deadflag != DEAD_NO)
		{
			return;
		}
		remove(self);
		deathmsg = MCPDEATH_FLAMER;
		T_Damage (other, self, self.owner, MCP_FLAMER_DAMAGE );
		
		local entity te = world;
		local float fnd = 0;
		te = find(world, classname, CN_FLAMERDOT);
		
		while (te) 
		{
			if (te.owner == self.owner && te.mcpgren == other && te != world) 
			{
				te.cnt = te.cnt + MCP_FLAMERDOT_STACKS;
				fnd++;
			}
			te = find(te,classname,CN_FLAMERDOT);
		}
		
		if(fnd == 0)
		{
			te = spawn();
			te.owner = self.owner;
			te.mcpgren = other;
			te.classname = CN_FLAMERDOT;
			te.nextthink = time + 0.5;
			te.think = think_mcpflamerdot;
			te.cnt = MCP_FLAMERDOT_STACKS;
			te.heat = time + 0.5;
			mcp_SetModel(te, MDL_FLAMEV, DIM_WORLD);
			setorigin(te,other.origin);
		}
		return;
		
		
	}
};


void think_mcpflamer() =
{
	self.nextthink = time + 0.1;
	if(time > self.heat)
		remove(self);
		
	//find a target
	local entity head = findradius(self.origin, MCP_FLAMER_TARGFINDRADIUS);
	local entity closest = world;
	while(head)
	{
		if(head.classname == CN_PLAYER && head.deadflag == DEAD_NO && head != self.owner && head.team_no != self.owner.team_no)
		{
			if(head != world)
			{
				if(closest == world)
					closest = head;
				else
				{
					if(vlen(head.origin - self.origin) < vlen(closest.origin - self.origin))
						closest = head;
				}
			}
		}
		head = head.chain;	
		
	}
	if(closest != world)
	{
		local vector dir = normalize(closest.origin - self.origin);
		self.velocity = dir *  MCP_FLAMER_SPEED;
		self.angles = vectoangles(self.velocity);
	}
		
};
void mcp_SpawnFlame(entity e) = 
{
	local vector dir = aim (e, 1000);

	newmis = spawn ();
	newmis.voided = 0;
	newmis.owner = e;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.angles = vectoangles(dir);
	newmis.think = think_mcpflamer;
	newmis.nextthink = time + 0.1;
	newmis.heat = time + MCP_FLAMER_DURATION;
	
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);               
	setorigin (newmis, e.origin + '0 0 16');

	newmis.velocity = dir * MCP_FLAMER_SPEED;
	newmis.touch = touch_mcpflamer;
	newmis.classname = CN_FLAMERBULLET;
	
	mcp_SetModel(newmis, MDL_FLAMEH, DIM_WORLD);
	if(e.team_no == MCPTEAM_BLUE)
		newmis.skin = 1;
	if(e.team_no == MCPTEAM_RED)
		newmis.skin = 2;
	setsize (newmis, '0 0 0', '0 0 0');              
	msg_entity = e;
	WriteByte (MSG_ONE, SVC_SMALLKICK);
}


