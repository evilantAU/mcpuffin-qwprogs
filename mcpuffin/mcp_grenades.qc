void (entity inflictor, entity attacker, float bounce, entity ignore) mcp_RadiusBounce = 
{
	local float points;
	local entity head;
	local vector org;

	head = findradius(inflictor.origin, bounce + 40);
	while (head) 
	{
		if (head != ignore) 
		{
			if (head.takedamage) 
			{
				org = head.origin + (head.mins + head.maxs) * 0.5;
				points = 0.5 * vlen(org - inflictor.origin);
				if (points < 0)
				{
					points = 0;	
				}
					points = bounce - points;
				if (points > 0) 
				{
					head.velocity = org - inflictor.origin;
					head.velocity = head.velocity * (points / 20);

				}
					//HitSound(head, inflictor, attacker, 0);
			}
		}
		head = head.chain;
	}
};

void explode_shattergren() =
{
	mcp_RadiusBounce(self, self.owner, 240, world);
	
	local float hitenemy = 0;
	local   float   points;
	local   entity  head;
	local   vector  org;
	head = findradius(self.origin, 240);
	local float SHATTER_MAXDAMAGE = 100;
	while (head)
	{
		if (head.classname == CN_PLAYER && head.team_no != self.owner.team_no && head.deadflag == DEAD_NO)
		{
			hitenemy = 1;
			if (head.takedamage)
			{
				
				org = head.origin + (head.mins + head.maxs)*0.5;
				points = 0.5*vlen (self.origin - org);
				if (points < 0)
					points = 0;
				points = SHATTER_MAXDAMAGE - points;

				deathmsg = MCPDEATH_GREN_SHATTER;
				mcp_Damage (head, self, self.owner, points);
				
			}
		}
		head = head.chain;
	}
	if(hitenemy)
	{
		//AddStat(self.owner, STAT_GRENHIT, ROLE_RECON);
	}
	
	mcp_ParticleExplosion(self.origin);
	remove(self);
};

float mcp_CalcFlash(entity te)
{
	float timeleft = te.FlashTime;
	float flashAmtMax = 240;
	float flashAmtMin = 100;
	float flashAmtMaxMult = stof(infokey(te, IK_MAXFLASH));
	float flashAmtMinMult = stof(infokey(te, IK_MINFLASH));
	float flashAmt;
    
    
	flashAmt = (flashAmtMaxMult > 0) ? flashAmtMax * flashAmtMaxMult : flashAmtMax;
	flashAmtMin = (flashAmtMinMult > 0) ? flashAmtMin * flashAmtMinMult : flashAmtMin;
    
	float perc = timeleft / MCPFLASHGREN_DURATION;

	flashAmt = flashAmt * perc;
	flashAmt = flashAmt < flashAmtMin ? flashAmtMin : flashAmt;
	return flashAmt;
};

void mcp_StuffFlash(entity te, float amt)
{
	string st = ftos(amt);
	string cmd = strcat("v_cshift ", st, " ", st);
	cmd = strcat(cmd, " ", st, " ", st, "\n");
	stuffcmd(te, cmd);
};

void think_mcpflashtimer() =
{
	self.owner.FlashTime = self.owner.FlashTime - .1;
	if (self.owner.FlashTime <= 0) 
	{
		sprint(self.owner, PRINT_HIGH, "flash has worn off\n");
		stuffcmd(self.owner, "v_cshift; wait; bf\n");
		mcp_ResetVisDimensions(self.owner);
		remove(self);
		return;
	}

	local float flashamount = mcp_CalcFlash(self.owner);
	mcp_StuffFlash(self.owner, flashamount);
	self.nextthink = time + .1;
};

void explode_mcpflashgren() =
{
	local vector org;
	local float frac;
	local float rad = 300;
	local entity te = findradius(self.origin, rad);
	while (te) 
	{
		if (te.classname == CN_PLAYER && te.playerclass != ROLE_NONE && te.deadflag == DEAD_NO) 
		{
			if(te.team_no != self.owner.team_no || te == self.owner)
			{
				traceline(self.origin, te.origin, 1, self);
				if (trace_fraction == 1) 
				{
					sprint(te, PRINT_HIGH, "you have been flashed!\n");
					org = te.origin + (te.mins + te.maxs) * 0.5;
					frac = (rad - vlen(self.origin - org)) / rad;

					deathmsg = MCPDEATH_GREN_FLASH;
					mcp_Damage(te, self, self.owner, 20);
					stuffsound(te, MCPGRENDICT[MCPGREN_FLASH].grensound);
                
					local entity ft = find(world, classname, CN_FLASHTIMER);
					local float found = 0;
                   
					while (ft)
					{
						if (ft.owner == te)
						{
							found = 1;
							ft.nextthink = time + .1;
						}
						ft = find(ft, classname, CN_FLASHTIMER);
					}

					if (found == 0)
					{			
						newmis = spawn();
						newmis.classname = CN_FLASHTIMER;
						newmis.team_no = self.owner.team_no;
						newmis.owner = te;
						newmis.think = think_mcpflashtimer;
						newmis.nextthink = time + .1;
					}
					local float ftime = MCPFLASHGREN_DURATION;
					ftime = ftime * (frac + frac * 0.5); // fall off is awful, let's half it
					te.FlashTime = ftime;

					local float flashamount = mcp_CalcFlash(te);

					mcp_StuffFlash(te, flashamount);
					te.dimension_see = 0;
			}
		}
        }
        te = te.chain;
	}
	mcp_ParticleTeleport(self.origin);
	mcp_Sound(self, CHAN_AUTO, MCPGRENDICT[MCPGREN_FLASH].grensound, 1, ATTN_NORM);
	remove(self);
};

void explode_mcpfraggren() =
{
	mcp_RadiusDamage(self, self.owner, MCPFRAG_DAMAGE, world,MCPDEATH_GREN_FRAG, 1);
	mcp_ParticleExplosion(self.origin);
	remove(self);
};

void explode_clustergrensmall() =
{
	mcp_RadiusDamage(self, self.owner, CLUSTERSMALL_DAMAGE, world,MCPDEATH_GREN_CLUSTERSMALL, 1);
	mcp_ParticleExplosion(self.origin);
	remove(self);
};

void touch_clustergrensmall() =
{
	if(other == self.owner)
		return;
		
	mcp_Sound(self, CHAN_WEAPON, SND_BOUNCE, 1, ATTN_NORM);
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};
void mcp_SpawnClusterGrenSmall(vector org, entity shooter) = 
{
	local float xdir;
	local float ydir;
	local float zdir;

	xdir = 150 * random() - 75;
	ydir = 150 * random() - 75;
	zdir = 40 * random();

	local entity newmis1 = spawn();
	newmis1.owner = shooter;
	newmis1.movetype = MOVETYPE_BOUNCE;
	newmis1.solid = SOLID_BBOX;
	newmis1.classname = CN_CLUSTERSMALL;

	newmis1.touch = touch_clustergrensmall;
	newmis1.think = explode_clustergrensmall;
	newmis1.nextthink = time + 2.5;

	newmis1.velocity_x = xdir * 2;
	newmis1.velocity_y = ydir * 2;
	newmis1.velocity_z = zdir * 15;
	newmis1.avelocity = '250 300 400';

	mcp_SetModel(newmis1, MDL_GREN_CLUSTERSMALL, DIM_WORLD);
	if(self.owner.team_no == MCPTEAM_BLUE)
		newmis1.skin = 1;
	if(self.owner.team_no == MCPTEAM_RED)
		newmis1.skin = 2;

	setsize(newmis1, VEC_ORIGIN, VEC_ORIGIN);
	setorigin(newmis1, org);	
};


void explode_clustergrenbig() =
{
	mcp_RadiusDamage(self, self.owner, CLUSTERBIG_DAMAGE, world, MCPDEATH_GREN_CLUSTERBIG, 1);
	mcp_ParticleExplosion(self.origin);
	
	local float i;	
	i = 0;
	while (i < 4) 
	{
		mcp_SpawnClusterGrenSmall(self.origin + '0 0 -1', self.owner);
		i = i + 1;
	}
	remove(self);
};

void explode_leechgren() =
{
	mcp_RadiusDamage(self, self.owner, 150, world,MCPDEATH_GREN_LEECH, 1);
	mcp_ParticleTarExplosion(self.origin);	
	remove(self);
};

void explode_pushupgren() =
{
	local entity head = findradius(self.origin, PUSHUPGREN_RADIUS + 40);
	local float points;
	local float enemyhit = 0;
	while (head)
	{
		if (head.takedamage && head.classname == CN_PLAYER)
		{
			if(head.team_no != self.owner.team_no)
			{
				enemyhit = 1;
				mcp_HitSound(head, self, self.owner, 0);
			}
			points = vlen (self.origin - head.origin);
			points = PUSHUPGREN_RADIUS - points;
			if (points > PUSHUPGREN_RADIUS)
				points = PUSHUPGREN_RADIUS;
			points = points / PUSHUPGREN_RADIUS;

			if (points > 0)
			{
				local float z = PUSHUPGREN_MAXPLAYERPUSH * points;
				
				
				if(z < PUSHUPGREN_MINPLAYERPUSH)
					z = PUSHUPGREN_MINPLAYERPUSH;
				head.velocity_z = z;
				
				local float xy = 1 - points;
				head.velocity_x = head.velocity_x * xy;
				head.velocity_y = head.velocity_y * xy;
			}
		}
		head = head.chain;
	}
	if(enemyhit)
	{
		//AddStat(self.owner, STAT_GRENHIT, ROLE_MGUNNER);

	}
	mcp_ParticleTarExplosion(self.origin);
	remove(self);
};

void think_molotovdot() =
{
	self.nextthink = time + 0.5;
	if(self.cnt <= 0)
	{
		remove(self);
		return;
	}
	deathmsg = MCPDEATH_MOLOTOVDOT;
	mcp_Damage (self.mcpgren, self, self.owner, MOLOTOV_DOTDAMAGE );
	self.cnt--;	
};

void mcp_ApplyMolotovDot(entity targ, entity attacker) =
{
	local entity te = world;
	local float fnd = 0;
	te = find(world, classname, CN_MOLOTOVDOT);
		
	while (te) 
	{
		if (te.owner == attacker && te.mcpgren == targ && te != world) 
		{
			te.cnt = te.cnt + MOLOTOV_DOTCOUNT;
			fnd++;
				
		}
		te = find(te,classname,CN_MOLOTOVDOT);
	}
		
	if(fnd == 0)
	{
		te = spawn();
		te.owner = attacker;
		te.mcpgren = targ;
		te.classname = CN_MOLOTOVDOT;
		te.nextthink = time + 0.5;
		te.think = think_molotovdot;
		te.cnt = MOLOTOV_DOTCOUNT;		
	}		
};

void think_molotovflame() =
{
	self.nextthink = time + 0.05;
	self.frame++;
	if(self.frame >= 6)
		self.frame = 0;
	if(time > self.cnt)
		remove(self);
};
void explode_molotovgren() =
{
	self.owner.ammo_rockets = 0; //reset visual timer
	mcp_RadiusDamage(self, self.owner, 50, world,MCPDEATH_GREN_MOLOTOV, 1);
	mcp_ParticleExplosion(self.origin);
	
	local float i;
	local float current_yaw;
	current_yaw = 0;
	i = 0;
	mcp_Sound(self, CHAN_WEAPON, SND_SHOOTFLAMER, 1, ATTN_NORM);
	
	local entity f = spawn();
	f.movetype = MOVETYPE_BOUNCE; //MOVETYPE_FLYMISSILE
	f.classname = CN_MOLOTOVFLAME;
	f.solid = SOLID_BBOX;
	f.think = think_molotovflame;
	//f.touch = SUB_Remove;
	f.nextthink = time + 0.05;
	f.cnt = time + 2;
	f.owner = self.owner;
	mcp_SetModel(f, MDL_FLAMEV_BIG, DIM_WORLD);
	if(self.team_no == MCPTEAM_BLUE)
		f.skin = 1;
	if(self.team_no == MCPTEAM_RED)
		f.skin = 2;
	setsize(f,VEC_ORIGIN,VEC_ORIGIN);
	setorigin(f,self.origin);
		
	
	local entity head = findradius(self.origin, 180);
	local float foundone = 0;
	
	while (head)
	{
		if (head != world)
		{
			if (head.takedamage && CanDamage(head,self))
			{
				
				if(head.classname == CN_PLAYER && head.team_no != self.owner.team_no && self.voided == 0)
				{
					mcp_ApplyMolotovDot(head, self.owner);
				}
			}
		}
		head = head.chain;
	}
	
	
	remove(self);
};


void think_capacitorinfection() =
{
	if(self.owner.deadflag != DEAD_NO)
	{
		remove(self);
		return;
	}
	self.nextthink = time + 0.5;

	mcp_ParticleShaft(self, self.mcpgren.origin + '0 0 -32', self.mcpgren.origin + '0 0 32');
	explode_capacitorgren();
	if(time >= self.bubble_count)
	{
		self.think = SUB_Remove;
		stuffnotice(self.mcpgren,"the electric charge fades away...");  
	}

};
void think_capacitorzapeffect() =
{
	mcp_ParticleShaft(self,self.origin,self.mcpgren.origin);
	remove(self);
};

void mcp_SpawnCapacitorZapEffect(entity creator, entity targ) =
{
	local entity te = spawn();
	te.nextthink = time;
	te.think = think_capacitorzapeffect;
	setorigin(te, creator.origin );
	te.mcpgren = targ;
	te.team_no = creator.team_no;
};
void explode_capacitorgren() =
{
	
	if(self.classname == CN_CAPACITORINFECTION)
	{
		self.origin = self.mcpgren.origin;
	}
	else
	{
		mcp_ParticleTarExplosion(self.origin);
		mcp_Sound(self, CHAN_WEAPON, SND_LSTART, 1, ATTN_NORM);
	}
		
	local float hasinf = 0;
	
	local entity targ = findradius(self.origin, CAPACITOR_RADIUS);
	while (targ) 
	{
		if (targ.classname == CN_PLAYER && targ.deadflag == DEAD_NO) 
		{
			local entity inf = find(world, classname, CN_CAPACITORINFECTION);
			while (inf) 
			{
				if (inf.mcpgren == targ && inf != world && inf.owner == self.owner)
				{ 
					hasinf++;
				}
				inf = find(inf, classname, CN_CAPACITORINFECTION);				
			}
			if(hasinf == 0)
			{
				if(targ.team_no != self.team_no || targ == self.owner)
				{
					if(self.classname == CN_CAPACITORINFECTION && targ == self.owner)
					{
						//skip
					}
					else
					{
						deathmsg = MCPDEATH_GREN_CAPACITOR;
						mcp_Damage (targ, self, self.owner, CAPACITOR_DAMAGE);
						mcp_SpawnCapacitorZapEffect(self,targ); //doing this because cant seem to get multiple lightning effects in this loop
						mcp_Sound(targ, CHAN_WEAPON, SND_LHIT, 1, ATTN_NORM);
					}
				}
				if(targ.team_no != self.team_no && targ != self.owner)
				{
					local entity te = spawn();
					te.nextthink = time + 0.2;
					te.bubble_count = time + CAPACITOR_INFECTIONDURATION;
					te.classname = CN_CAPACITORINFECTION;
					te.think = think_capacitorinfection;
					te.owner = self.owner;
					te.mcpgren = targ;
					te.team_no = self.owner.team_no;
				}
			}
		}
		
		targ = targ.chain;
	}
	if(self.classname == CN_CAPACITORINFECTION)
		return;
		
	remove(self);
};


void mcp_StickyGren() =
{
	local entity sticky;
	sticky = spawn();
	sticky.movetype = MOVETYPE_BOUNCE;
	sticky.solid = SOLID_BBOX;
	sticky.owner = self.owner;
	sticky.velocity = '0 0 0';
	sticky.angles = vectoangles(sticky.velocity);
	sticky.think = SUB_Null;
	sticky.nextthink = time + HANDHELDGRENEXPLODEDELAY;		

	if(self.mcpgrentype == MCPGREN_SHATTER)
		sticky.think = explode_shattergren;
		
	if(self.mcpgrentype == MCPGREN_FLASH)
		sticky.think = explode_mcpflashgren;
	
	if(self.mcpgrentype == MCPGREN_FRAG)
		sticky.think = explode_mcpfraggren;

	if(self.mcpgrentype == MCPGREN_CLUSTER)
		sticky.think = explode_clustergrenbig;
	
	if(self.mcpgrentype == MCPGREN_LEECH)
		sticky.think = explode_leechgren;
		
	if(self.mcpgrentype == MCPGREN_PUSHUP)
		sticky.think = explode_pushupgren;

	if(self.mcpgrentype == MCPGREN_CAPACITOR)
		sticky.think = explode_capacitorgren;

	if(self.mcpgrentype == MCPGREN_MOLOTOV)
		sticky.think = explode_molotovgren;
		
	bprint(2, strcat(MCPGRENDICT[self.mcpgrentype].stickyprefix," ", self.owner.netname, " ", MCPGRENDICT[self.mcpgrentype].stickypostfix,"\n"));
	setsize(sticky, '0 0 0', '0 0 0');
	setorigin(sticky, self.owner.origin);
	remove(self);
};



void touch_molotov() =
{
	if (other == self.owner)
		return;

	mcp_Sound(self, CHAN_ITEM, MCPGRENDICT[self.mcpgrentype].grensound, 1, ATTN_NORM);
	self.owner.mcpgren = world;
	self.think = explode_molotovgren;
	self.nextthink = time;
};

void touch_mcpthrowngren() =
{
	mcp_Sound(self, CHAN_WEAPON, SND_BOUNCE, 1, ATTN_NORM);
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};

void think_mcpthrowngren() =
{
	self.nextthink = time;
	self.owner.ammo_rockets = floor(time - self.bubble_count);
	if(time >= self.bubble_count)
	{
		self.owner.mcpgren = world;

		if(self.mcpgrentype == MCPGREN_FLASH)
			self.think = explode_mcpflashgren;
			
		else if(self.mcpgrentype == MCPGREN_FRAG)
			self.think = explode_mcpfraggren;
			
		else if(self.mcpgrentype == MCPGREN_LEECH)
			self.think = explode_leechgren;
			
		else if(self.mcpgrentype == MCPGREN_CLUSTER)
			self.think = explode_clustergrenbig;
		
		else if(self.mcpgrentype == MCPGREN_SHATTER)
			self.think = explode_shattergren;

		else if(self.mcpgrentype == MCPGREN_PUSHUP)
		
			self.think = explode_pushupgren;
		
		else if(self.mcpgrentype == MCPGREN_CAPACITOR)
			self.think = explode_capacitorgren;
			
		else if(self.mcpgrentype == MCPGREN_MOLOTOV)
			self.think = explode_molotovgren;
		else
			bprint(2,"think_mcpthrowngren() error\n");
	}
};

void think_mcpgrentimersound() =
{
	local string grentimer = infokey(self.owner, IK_GRENTIMER);
	if(grentimer == "0")
		return;
	if(grentimer == "off")
		return;
	if(grentimer == "")
		grentimer = "1";
	stuffcmd(self.owner, strcat("play mcpuffin_b1/grentimers/mcp_grentimer",grentimer,"\n"));
	remove(self);
}

void think_mcpprimegren() =
{
	self.nextthink = time;
	self.owner.ammo_rockets = floor(time - self.bubble_count);
	if(time >= self.bubble_count)
	{
		mcp_StickyGren();
		self.owner.mcpgren = world;
		remove(self);
	}
};

void mcp_PrimeGrenade(entity e) = 
{
	e.impulse = 0;
	if(mcpmode == MCPMODE_COINSTEAM || mcpmode == MCPMODE_COINSFFA)
	{
		stuffnotice(e,"there are no grenades in this mode.");
		return;
	}
	if(e.mcpgren != world)
		return;
	if(e.team_no == MCPTEAM_NONE)
		return;
	if(e.playerclass == ROLE_NONE)
		return;
		
	if(e.mcpgrencount <= 0)
	{
		stufferror(e,strcat("no ",MCPGRENDICT[e.mcpgrentype].namestr ,"s left"));
		return;
	}
	
	//local entity grentimer = spawn();
	//AddStat(e, STAT_GRENPRIMED, e.role);
	e.mcpgren = spawn();
        e.mcpgren.nextthink = time;
        e.mcpgren.think = think_mcpprimegren;
	e.mcpgren.owner = e;
	e.mcpgren.playerclass = e.playerclass;
	e.mcpgren.mcpgrentype = e.mcpgrentype;
	e.mcpgren.classname = CN_PRIMEGREN;
	e.mcpgren.bubble_count = time + MCPGRENTIME;

	e.mcpgrencount--;
	e.ammo_nails = e.ammo_nails - 1;
	
	local float offset = stof(infokey(e,IK_GRENTIMERDELAY));
	local entity grentimersound = spawn();
	grentimersound.owner = e;
	grentimersound.think = think_mcpgrentimersound;
	grentimersound.nextthink = time + offset;
	
	sprint(e, PRINT_HIGH, strcat("priming ",MCPGRENDICT[e.mcpgrentype].namestr ,"...\n"));	
};

void mcp_ThrowGrenade(entity e) = {
	e.impulse = 0;
	local float grenspeed = 600;
	if(e.mcpgren.classname == CN_THROWNGREN)
		return;
	if(e.mcpgren == world)
		return;

	newmis = spawn();
	newmis.movetype = MOVETYPE_BOUNCE;
	newmis.classname = CN_THROWNGREN;
	newmis.solid = SOLID_BBOX;
	newmis.owner = e;
	newmis.playerclass = e.playerclass;
	newmis.mcpgrentype = e.mcpgren.mcpgrentype;
	newmis.team_no = e.team_no;
	newmis.bubble_count = e.mcpgren.bubble_count;
	newmis.nextthink = time;
	newmis.think = think_mcpthrowngren;
	newmis.touch = touch_mcpthrowngren;
	setorigin(newmis, e.origin);
	setsize(newmis,'0 0 0', '0 0 0');
	
	e.mcpgren.think = SUB_Null;
	e.mcpgren.nextthink = time;
	e.mcpgren = newmis;
    
	
	if(self.team_no == MCPTEAM_BLUE)
		newmis.skin = 1;
	else
		newmis.skin = 2;
	
	newmis.avelocity = MCPGRENDICT[self.mcpgren.mcpgrentype].avel;
	mcp_SetModel(newmis, MCPGRENDICT[self.mcpgren.mcpgrentype].modelstr, DIM_WORLD);
	mcp_Sound(newmis, CHAN_WEAPON, MCPGRENDICT[self.mcpgren.mcpgrentype].throwsound, 1, ATTN_NORM);
	
	if(self.mcpgren.mcpgrentype == MCPGREN_MOLOTOV)
		newmis.touch = touch_molotov;
	
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