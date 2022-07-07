void mcp_KillStreak(entity player) =
{
	player.fragstreak = player.fragstreak + 1;
	//AddStat(player, STAT_KILLSTREAK, player.killstreakcount);

		
	if(player.fragstreak < 3)
		return;
		
	local string text = "";
	local string file = "";
	
	if(player.fragstreak == 3)	//killingspree
	{
		text = strcat(player.netname, " is on a \skilling spree\s (3 kills).\n");
		file = SND_KSTREAK3;
	}
	if(player.fragstreak == 4)	//dominating
	{
		text = strcat(player.netname, " is \sdominating\s (4 kills).\n");
		file = SND_KSTREAK4;
	}
	if(player.fragstreak == 5)	//megakill
	{
		text = strcat(player.netname, " achieved a \smega kill\s (5 kills).\n");
		file = SND_KSTREAK5;
	}
	if(player.fragstreak == 6)	//unstoppable
	{
		text = strcat(player.netname, " is \sunstoppable\s (6 kills).\n");
		file = SND_KSTREAK6;
	}
	if(player.fragstreak == 7)	//wicked sick? ultrakill
	{
		text = strcat(player.netname, " achieved an \sultra kill\s (7 kills).\n");
		file = SND_KSTREAK7;
	}
	if(player.fragstreak == 8)	//monster kill
	{
		text = strcat(player.netname, " achieved a \sm-m-monster kill\s (8 kills).\n");
		file = SND_KSTREAK8;
	}
	if(player.fragstreak == 9)	//godlike
	{
		text = strcat(player.netname, " is \sgodlike\s (9 kills).\n");
		file = SND_KSTREAK9;
	}
	if(player.fragstreak >= 10) //holy shit beyond godlike
	{
		text = strcat(player.netname, " is \sbeyond godlike\s (",ftos(player.fragstreak)," kills).\n");
		file = SND_KSTREAK10;
	}
	
	local entity te = find(world, classname, CN_PLAYER);
	while (te) 
	{
		if (infokey(te, IK_KILLSTREAKS) != "0")
		{
			stuffcmd(te, strcat("play ", file, "\n"));
			sprint(te, PRINT_HIGH, text);
		}
		te = find(te, classname, CN_PLAYER);
	}
	
};

void mcp_Obituary(entity victim, entity attacker) =
{
	if(victim.classname == CN_PLAYER)
	{
		
		local float attackerteam = attacker.team_no;
		local float targteam = victim.team_no;
		
		local float teamkill = 0;
		local float selfkill = 0;
		local float enemykill = 0;
		
		if(attacker.classname == CN_PLAYER)
		{
			if(victim == attacker)
			{
				selfkill = 1;
				if(mcpmode == MCPMODE_FIEND || mcpmode == MCPMODE_BABYFIEND)
					mcp_ModifyTeamScore(attacker.team_no, -1);
			}
			else if(targteam == attackerteam)
			{
				teamkill = 1;
				if(mcpmode == MCPMODE_FIEND || mcpmode == MCPMODE_BABYFIEND)
					mcp_ModifyTeamScore(attacker.team_no, -1);
			}
			else if(targteam != attackerteam)
			{
				enemykill = 1;
				mcp_KillStreak(attacker);
				if(mcpmode == MCPMODE_FIEND || mcpmode == MCPMODE_BABYFIEND)
					mcp_ModifyTeamScore(attacker.team_no, 1);
			}
		}
		
		if(attacker.classname == CN_PLAYER)
		{
			//GRENADES
			
			if(deathmsg == MCPDEATH_GREN_FLASH)
			{
				if(selfkill)
					bprint (PRINT_MEDIUM,strcat(victim.netname, " was charred by their own flash grenade\n"));
				if(enemykill)
				{
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was charred by ", attacker.netname, "'s flash grenade\n"));
					stuffsoundall (SND_TOASTY,world);
				}
			}
			
			else if(deathmsg == MCPDEATH_GREN_FRAG)
			{
				if(selfkill)
					bprint (PRINT_MEDIUM,strcat(victim.netname, " regrets using a frag grenade\n"));
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " caught ", attacker.netname, "'s frag grenade\n"));	
			}
			
			else if(deathmsg == MCPDEATH_GREN_CLUSTERBIG || deathmsg == MCPDEATH_GREN_CLUSTERSMALL)
			{
				if(selfkill)
					bprint (PRINT_MEDIUM,strcat(victim.netname, " accidentally clustered themself\n"));
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was spammed by ", attacker.netname, "'s cluster grenade\n"));
			}
			
			else if (deathmsg == MCPDEATH_GREN_LEECH)
			{
				if(selfkill)
					bprint (PRINT_MEDIUM,strcat(victim.netname, " succumbed to their own leeches\n"));
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was sucked dry from ", attacker.netname, "'s leech grenade\n"));
				
			}
			
			else if (deathmsg == MCPDEATH_GREN_MOLOTOV)
			{
				if(selfkill)
					bprint (PRINT_MEDIUM,strcat(victim.netname, " couldnt handle their molotov\n"));
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was engulfed in flames by ", attacker.netname, "'s molotov\n"));
			}
			else if (deathmsg == MCPDEATH_MOLOTOVDOT)
			{
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " succumbed to the after effects of ", attacker.netname, "'s molotov\n"));
			}
			
			else if (deathmsg == MCPDEATH_GREN_CAPACITOR)
			{
				if(selfkill)
					bprint (PRINT_MEDIUM,strcat(victim.netname, " was electrocuted by their own capacitor grenade\n"));
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was fried by ", attacker.netname, "'s capcaitor grenade\n"));
			}
			
			
			//WEAPONS - HITSCAN - SHOULDNT BE ABLE TO KILL SELF?
			
			else if(deathmsg == MCPDEATH_FIENDCLAWS)
			{
				if(enemykill)
				{
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was eviscerated by ", attacker.netname, "'s claws\n"));
					if(attacker.playerclass == ROLE_FIEND)
					{
						stuffsoundall (SND_FRESHMEAT,world);
					}
					if(attacker.playerclass == ROLE_BABYFIEND)
						stuffsoundall (SND_BABYFIEND_FRESHMEAT,world);
				}
			}
			
			else if(deathmsg == MCPDEATH_AXE)
			{
				if(enemykill)
				{
					if(attacker.playerclass == ROLE_ASSASSIN)
					{
						bprint(PRINT_MEDIUM, strcat(victim.netname, " was assassinated by ", attacker.netname, "\n"));
					}
					else
					{
						bprint(PRINT_MEDIUM, strcat(victim.netname, " was chopped to bits by ", attacker.netname, "\n"));
					}
					stuffsoundall (SND_HUMILIATION,world);
				}
			}
			
			else if(deathmsg == MCPDEATH_SHOTGUN)
			{
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " had a chew on ", attacker.netname, "'s boomstick\n"));
			}
			
			else if(deathmsg == MCPDEATH_DBLBARREL)
			{
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was on the wrong end of ", attacker.netname, "'s double barrel shotgun\n"));
			}
			
			else if(deathmsg == MCPDEATH_RAILGUN)
			{
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was railed by ", attacker.netname, "\n"));
			}
			else if(deathmsg == MCPDEATH_SHAFT)
			{
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " got the shaft from ", attacker.netname, "\n"));
			}
			else if(deathmsg == MCPDEATH_MINIGUN)
			{
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was gunned down by ", attacker.netname, "'s minigun\n"));
			}
			
			//WEAPONS -- PROJECTILES
			else if(deathmsg == MCPDEATH_SNG)
			{
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " couldnt outrun ", attacker.netname, "'s nails\n"));
				if(selfkill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " somehow nailed themself\n"));
			}
			
			else if(deathmsg == MCPDEATH_ROCKET_DIRECT)
			{
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " ate a direct rocket from ", attacker.netname, "\n"));
				if(selfkill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " somehow rocketed themself\n"));
			}
			else if(deathmsg == MCPDEATH_ROCKET_DETONATE)
			{
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " died to a detonated rocket from ", attacker.netname, "\n"));
				if(selfkill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " detonated a rocket on themself\n"));
			}
			else if(deathmsg == MCPDEATH_ROCKET_SPLASH)
			{
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was smeared by ", attacker.netname, "'s rocket\n"));
				if(selfkill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " got too close to their rocket\n"));
			}
			
			else if(deathmsg == MCPDEATH_ROCKET_HARPOON)
			{
				if(enemykill)
				{
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was combo'd by ", attacker.netname, "\n"));
					stuffsoundall (SND_COMBOWHORE,world);
				}
				if(selfkill)
					bprint (PRINT_MEDIUM,strcat(victim.netname, " tried too hard for the combo\n"));
			}
			
			else if(deathmsg == MCPDEATH_STICKY_TRAP)
			{
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " got caught in ", attacker.netname, "'s sticky trap\n"));
				if(selfkill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " got caught in their own sticky trap\n"));
			}
			
			else if(deathmsg == MCPDEATH_STICKY_DIRECT)
			{
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " swallowed a beachball from ", attacker.netname, "\n"));
				if(selfkill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " got hit with their own beachball\n"));
			}
			
			else if(deathmsg == MCPDEATH_STICKY_AIR)
			{
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " fell victim to ", attacker.netname, "'s air detonation\n"));
				if(selfkill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " air detonated themself\n"));
			}
			else if(deathmsg == MCPDEATH_FLAMER)
			{
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was cremated by ", attacker.netname, "\n"));
				if(selfkill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " cremated themself\n"));
			}
			else if(deathmsg == MCPDEATH_FLAMERDOT)
			{
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " couldn't put out ", attacker.netname, "'s flames\n"));
			}
			else if(deathmsg == MCPDEATH_LASERBOLT)
			{
				if(enemykill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was melted by ", attacker.netname, "'s lasergun\n"));
				if(selfkill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " looked down the barrel of their own lasergun\n"));
			}		
	
			//specials
			else if(deathmsg == MCPDEATH_DRONEBULLET)
			{
				if(enemykill)
				{
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was terminated by ", attacker.netname, "\n"));
					stuffsoundall (SND_TRANSFORMER,world);
				}
				if(selfkill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " self terminated\n"));
			}
			else if(deathmsg == MCPDEATH_GOOMBASTOMP)
			{
				if(enemykill)
				{
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was goomba stomped by ", attacker.netname, "\n"));
					stuffsoundall (SND_GOOMBASTOMP,world);
				}
			}
			else if(deathmsg == MCPDEATH_SHOULDERCHARGE)
			{
				if(enemykill)
				{
					bprint(PRINT_MEDIUM, strcat(victim.netname, " got shoulder charged by ", attacker.netname, "\n"));
					stuffsoundall (SND_THOMAS,world);
				}
			}
			else if(deathmsg == MCPDEATH_LEAPFIEND)
			{
				if(enemykill)
				{
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was lept upon by ", attacker.netname, "\n"));
					if(attacker.playerclass == ROLE_FIEND)
					{
						stuffsoundall (SND_FRESHMEAT,world);
					}
					if(attacker.playerclass == ROLE_BABYFIEND)
						stuffsoundall (SND_BABYFIEND_FRESHMEAT,world);
				}
			}
			else if(deathmsg == MCPDEATH_HARPOON)
			{
				if(enemykill)
				{
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was harpooned by ", attacker.netname, "\n"));
					stuffsoundall (SND_HUMILIATION,world);
				}
				if(selfkill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " harpooned themself\n"));
			}
			else if(deathmsg == MCPDEATH_TELEBALL)
			{
				stuffsoundall (SND_INSIDEOUT,world);
				if(enemykill)
				{
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was turned inside out by ", attacker.netname, "'s teleball\n"));
					
				}
				if(teamkill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " tried to become one with teammate ", attacker.netname, "\n"));
			}
			else if(deathmsg == MCPDEATH_IGNITE)
			{
				if(enemykill)
				{
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was turned into a ball of fire by ", attacker.netname, "'s airblast\n"));
					stuffsoundall (SND_BURNBABYBURN,world);
				}
	
			}
			else
			{	
				if(enemykill)
					bprint (PRINT_MEDIUM,strcat(victim.netname, " was killed by ", attacker.netname, "\n"));
				if(selfkill)
					bprint (PRINT_MEDIUM,strcat(victim.netname, " decided to end it all\n"));
				if(teamkill)
					bprint(PRINT_MEDIUM, strcat(victim.netname, " was betrayed by ", attacker.netname, "\n"));
			}
		}
		else
		{
			//WORLD
			//AddStat(targ, STAT_WORLDDEATH, 1);


			bprint (PRINT_MEDIUM,victim.netname);
			if (victim.watertype == CONTENT_WATER)
			{
				bprint (PRINT_MEDIUM," drowned\n");
				return;
			}
			else if (victim.watertype == CONTENT_SLIME)
			{
				bprint (PRINT_MEDIUM," dissolved in the slime\n");
				return;
			}
			else if (victim.watertype == CONTENT_LAVA)
			{
				bprint (PRINT_MEDIUM," has gone to meet the volcano god\n");
				return;
			}

			if (attacker.classname == "explo_box")
			{
				bprint (PRINT_MEDIUM," blew up\n");
				return;
			}
			if (victim.deathtype == "falling" || deathmsg == MCPDEATH_FALL)
			{
				bprint (PRINT_MEDIUM," pancaked on the ground\n");
				stuffsoundall (SND_PANCAKE,world);
				return;
			}
			if (victim.deathtype == "nail" || victim.deathtype == "supernail")
			{
				bprint (PRINT_MEDIUM," was spiked\n");
				return;
			}
			if (victim.deathtype == "laser")
			{
				bprint (PRINT_MEDIUM," was zapped\n");
				return;
			}
			if (victim.classname == "fireball")
			{
				bprint (PRINT_MEDIUM," ate a lavaball\n");
				return;
			}
			if (victim.classname == "trigger_changelevel")
			{
				bprint (PRINT_MEDIUM," tried to leave\n");
				return;
			}

			bprint (PRINT_MEDIUM," died\n");
		}
	}
};

void  mcp_HitSound (entity targ, entity inflictor, entity attacker, float damage) = 
{
	if (attacker.classname == CN_PLAYER)
	{
		if ((targ.classname == CN_PLAYER) )
		{
			if (attacker == targ)
			{
				return;
			}

		local string hitsound;
		hitsound = infokey(attacker, IK_HITSOUND);
		
		if(hitsound == "0")
			return;
            

		local float crit;
		if(targ.armorvalue <= 0)
			crit = 1;

                
                if (targ.team_no != attacker.team_no) {
			if(attacker.weapon == MCPWEAP_RAILGUN)
			{
				if(attacker.heat == 1)
					
					stuffsound(attacker, SND_HITSOUNDRAIL1);
				if(attacker.heat == 2)
					stuffsound(attacker, SND_HITSOUNDRAIL2);
				if(attacker.heat == 3)
					stuffsound(attacker, SND_HITSOUNDRAIL3);
				return;
			}
			if (crit == 1)
			{
				stuffsound(attacker, SND_HITSOUNDCRIT);		
			}
			else 
			{ 
				stuffsound(attacker, SND_HITSOUND);
              
			}
                }
                else 
                {
                	stuffsound(attacker, SND_HITSOUNDTEAM);	
                    
                }	
            }

	}
};

void mcp_KillSound(entity targ, entity attacker) = 
{

	if (attacker.classname == CN_PLAYER && targ.classname == CN_PLAYER)
	{
		if(mcpmode == MCPMODE_BABYFIEND)
		{
			if(targ.playerclass == ROLE_BABYFIEND)
				stuffsoundall(SND_KILLSOUNDHUNTER,world);
		}
		
		local string killsound = infokey(attacker, IK_KILLSOUND);
		
		if(killsound == "0")
			return;

		if (targ.team_no != attacker.team_no) 
		{
			stuffsound(attacker, SND_KILLSOUND);
		
		}
		else 
		{	if(killsound == "" || killsound == "2")
			{
				if(attacker == targ)
					stuffsound(attacker, SND_KILLSOUNDSELF);
				else
					stuffsound(attacker, SND_KILLSOUNDTEAM);
			}
		}
	}
		
};

vector(float dm) mcp_VelocityForDamage =
{
	local vector v;

	v_x = 100 * crandom();
	v_y = 100 * crandom();
	v_z = 200 + 100 * random();
	if (dm > -50)
		v = v * 0.7;
	else if (dm > -200)
		v = v * 2;
	else
		v = v * 10;
	return (v);
};

void (vector org, vector vel) mcp_SpawnMeatSpray = {
    local entity missile;

    missile = spawn();
    missile.owner = self;
    missile.movetype = MOVETYPE_BOUNCE;
    missile.solid = SOLID_NOT;
    makevectors(self.angles);
    missile.velocity = vel;
    missile.velocity_z = missile.velocity_z + 250 + 50 * random();
    missile.avelocity = '3000 1000 2000';
    missile.nextthink = time + 1;
    missile.think = SUB_Remove;
    mcp_SetModel(missile, MDL_MCPPLAYERMEATSPRAY, DIM_WORLD);
    setsize(missile, '0 0 0', '0 0 0');
    setorigin(missile, org);
};

void (string gibname, float dm) mcp_ThrowGib = {
	newmis = spawn();
	newmis.origin = self.origin;

	mcp_SetModel(newmis, gibname, DIM_WORLD);

	setsize(newmis, '0 0 0', '0 0 0');
	newmis.velocity = mcp_VelocityForDamage(dm);

	newmis.movetype = MOVETYPE_BOUNCE;
	newmis.solid = SOLID_NOT;

	newmis.avelocity_x = random() * 600;
	newmis.avelocity_y = random() * 600;
	newmis.avelocity_z = random() * 600;

	newmis.think = SUB_Remove;
	newmis.ltime = time;
	newmis.nextthink = time + 10 + random() * 10;
	newmis.frame = 0;
	newmis.flags = 0;
};

void (entity e, string gibname) mcp_ThrowHead = {
	mcp_SetModel(self, gibname, DIM_WORLD);
	
	self.frame = 0;
	self.nextthink = -1;

	self.movetype = MOVETYPE_BOUNCE;
	self.takedamage = DAMAGE_NO;
	self.solid = SOLID_NOT;

	self.view_ofs = '0 0 8';
	setsize(self, '-16 -16 0', '16 16 56');
	self.velocity = mcp_VelocityForDamage(e.health);
	self.origin_z = self.origin_z - 24;
	self.flags = self.flags - (self.flags & 512);
	self.avelocity = crandom() * '0 600 0';
};


void mcp_GibPlayer(entity e) =
{
	if(e.playerclass == ROLE_TECHNICIAN)
	{
		
		if(e.model == MDL_MCPDRONE)
		{
			
			mcp_ThrowHead(e,MDL_MCPDRONEGIB1);
			mcp_ThrowGib(MDL_MCPDRONEGIB1,e.health);
			mcp_ThrowGib(MDL_MCPDRONEGIB2,e.health);
			mcp_ThrowGib(MDL_MCPDRONEGIB3,e.health);
			mcp_ParticleExplosion(e.origin);
		}
	}
	else if (e.playerclass == ROLE_FIEND || e.playerclass == ROLE_BABYFIEND)
	{
		
		mcp_ThrowHead(e,MDL_MCPFIENDHEAD);
		mcp_ThrowGib(MDL_MCPPLAYERGIB1,e.health);
		mcp_ThrowGib(MDL_MCPPLAYERGIB2,e.health);
		mcp_ThrowGib(MDL_MCPPLAYERGIB3,e.health);
		if (random() < 0.5)
			mcp_Sound(e, CHAN_VOICE, SND_GIB, 1, ATTN_NONE);
		else
			mcp_Sound(e, CHAN_VOICE, SND_UDEATH, 1, ATTN_NONE);
	}
	else
	{
		mcp_SetModel(e,"", DIM_WORLD);
		mcp_ThrowHead(e,MDL_MCPPLAYERHEAD);
		mcp_ThrowGib(MDL_MCPPLAYERGIB1,e.health);
		mcp_ThrowGib(MDL_MCPPLAYERGIB2,e.health);
		mcp_ThrowGib(MDL_MCPPLAYERGIB3,e.health);
		if (random() < 0.5)
			mcp_Sound(e, CHAN_VOICE, SND_GIB, 1, ATTN_NONE);
		else
			mcp_Sound(e, CHAN_VOICE, SND_UDEATH, 1, ATTN_NONE);
	}
	
	mcp_EndDeathSeq();
};

void mcp_PlayerKilled(entity targ, entity attacker) = 
{
	if(targ.iscloaked == 1 && targ.classname == CN_PLAYER)
	{
		if(attacker.classname == CN_PLAYER)
		{
			//AddStat(attacker, STAT_GHOSTBUST, 1);
		}
		stuffsoundall (SND_GHOSTBUSTER,world);
	}
	
	if(mcpgoal.owner == targ && attacker.classname == CN_PLAYER)
	{
		//AddStat(attacker, STAT_FLAGCARRIERKILLED, 1);
	}
	
	mcp_KillSound(targ, attacker);
	mcp_Obituary(targ, attacker);
	mcp_SetNextRespawn(targ, 0);
	
	if (targ.health < -99)
		targ.health = -99;              // don't let sbar look bad if a player

	if (targ.movetype == MOVETYPE_PUSH || targ.movetype == MOVETYPE_NONE)
	{       // doors, triggers, etc
		mcp_StartDeathSeq(targ);
		return;
	}

	targ.enemy = attacker;
	mcp_StartDeathSeq(targ);

	
	//DropArmourShard(self);
	//DropHealthPack(self);
	mcp_ResetPlayer(self);

 
};

//AKA PLAYERDIE()
void mcp_StartDeathSeq(entity e) =
{
	//e.modelindex = modelindex_player;	// don't use eyes
	mcp_ResetPlayer(e);
	mcp_DropCoins(e,0);
	mcp_DropLootHealth(e);
	mcp_DropLootGrenade(e);
	mcp_DropLootArmour(e);
	mcp_DiedWithMCPFlag(e);
	e.view_ofs = '0 0 -8';
	e.deadflag = DEAD_DYING;
	e.solid = SOLID_NOT;
	e.takedamage = DAMAGE_NO;
	e.touch = SUB_Null;
	e.effects = 0;
	e.flags = self.flags - (self.flags & FL_ONGROUND);
	e.movetype = MOVETYPE_TOSS;
	
	if (e.velocity_z < 10)
		e.velocity_z = e.velocity_z + random()*300;
		
	if (e.model == MDL_MCPDRONE)
	{
		mcp_GibPlayer(e);
	}
	else if(e.health < -40)
	{
		mcp_GibPlayer(e);
	}
	else
	{
		mcp_DeathSound(e);
		self.angles_x = 0;
		self.angles_z = 0;
		
		if(e.model == MDL_MCPFIEND || e.model == MDL_MCPBABYFIEND)
		{
			mcpfiend_die1();
		}
		else
		{
			if (mcp_VisibleWeapon(e) == MCPWEAP_AXE || e.deathtype == "falling")
			{
				mcpplayer_die_ax1 ();
			}
			else
			{
				
				local float rng = RNG(5);
				switch(rng)
				{
					case 1:
					{
						mcpplayer_diea1();
						break;
					}
				
					
					case 2:
					{
						mcpplayer_dieb1();
						break;
					}
					
					case 3:
					{
						mcpplayer_diec1();
						break;
					}
					case 4:
					{
						mcpplayer_died1();
						break;
					}
					
					case 5:
					{
						mcpplayer_diee1();
						break;
					}
					
					
					default:
					{
						mcpplayer_diea1();
						break;
					}
				}		
			}
		}
		e.weaponmodel="";
	}
};

void mcp_EndDeathSeq() =
{
	self.deadflag = DEAD_DEAD;
	self.nextthink = -1;
};

void() mcp_DeathBubblesSpawn =
{
	local entity	bubble;
	if (self.owner.waterlevel != 3)
		return;
	bubble = spawn();
	setmodel (bubble, SPR_BUBBLE);
	setorigin (bubble, self.owner.origin + '0 0 24');
	bubble.movetype = MOVETYPE_NOCLIP;
	bubble.solid = SOLID_NOT;
	bubble.velocity = '0 0 15';
	bubble.nextthink = time + 0.5;
	bubble.think = bubble_bob;
	bubble.classname = CN_BUBBLE;
	bubble.frame = 0;
	bubble.cnt = 0;
	setsize (bubble, '-8 -8 -8', '8 8 8');
	self.nextthink = time + 0.1;
	self.think = mcp_DeathBubblesSpawn;
	self.air_finished = self.air_finished + 1;
	if (self.air_finished >= self.bubble_count)
		remove(self);
};

void mcp_DeathBubbles(entity e, float num_bubbles)  =
{
	local entity	bubble_spawner;
	
	bubble_spawner = spawn();
	setorigin (bubble_spawner, e.origin);
	bubble_spawner.movetype = MOVETYPE_NONE;
	bubble_spawner.solid = SOLID_NOT;
	bubble_spawner.nextthink = time + 0.1;
	bubble_spawner.think = mcp_DeathBubblesSpawn;
	bubble_spawner.air_finished = 0;
	bubble_spawner.owner = e;
	bubble_spawner.bubble_count = num_bubbles;
	return;
};

void mcp_DeathSound (entity e) =
{
	local float		rs;
	
	if (e.playerclass == ROLE_FIEND)
	{
		mcp_Sound(e, CHAN_VOICE, SND_DDEATH, 1, ATTN_NONE);
		return;
	}
	if (e.playerclass == ROLE_BABYFIEND)
	{
		mcp_Sound(e, CHAN_VOICE, SND_BABYFIEND_DEATH,1,ATTN_NONE);
		return;
	}
	// water death sounds
	if (e.waterlevel == 3)
	{
		mcp_DeathBubbles(e,20);
		mcp_Sound(e, CHAN_VOICE, SND_H2ODEATH, 1, ATTN_NONE);
		return;
	}
	
	rs = rint ((random() * 4) + 1);
	if (rs == 1)
		e.noise = SND_DEATH1;
	if (rs == 2)
		e.noise = SND_DEATH2;
	if (rs == 3)
		e.noise = SND_DEATH3;
	if (rs == 4)
		e.noise = SND_DEATH4;
	if (rs == 5)
		e.noise = SND_DEATH5;
		
	

	mcp_Sound(e, CHAN_VOICE, e.noise, 1, ATTN_NONE);
	return;
};

void mcp_CreateHealNumber(float heal, entity targ, entity attacker) =
{
	if(attacker.classname != CN_PLAYER)
		return;
	if(attacker.mcpclientdim == 0)
		return;
	if(infokey(attacker, IK_NOHITNUMBERS) == "1")
		return;
		
	heal = floor(heal);
	
	if(heal <= 0)
		return;
		
	local entity sp = spawn();
	sp.classname = CN_HEALNUMBER;
	mcp_SetModel(sp,SPR_HEALNUM, attacker.mcpclientdim);
	sp.frame = heal-1;
	setsize (sp, '-16 -16 -32', '16 16 32');
	setorigin(sp, targ.origin + '0 0 64');
	sp.think = SUB_Remove;
	sp.nextthink = time + 2;
	sp.movetype = MOVETYPE_FLY;
	sp.solid = SOLID_NOT;
	sp.velocity = '0 0 1' * 150;
	
};

void CreateDamageNumber(float damage, entity targ, entity attacker) =
{
	if(attacker.classname != CN_PLAYER)
		return;
	if(attacker.team_no == targ.team_no)
		return;
	if(attacker.mcpclientdim == 0)
		return;
		
	if(infokey(attacker, IK_NOHITNUMBERS) == "1")
		return;
	damage = floor(damage);
	if(damage <= 0)
		return;

	if(damage > 999)
	{
		damage = 999;
	}
	
	local entity sp = spawn();
	sp.classname = CN_DAMAGENUMBER;
	
	if(damage <= 512)
	{

		mcp_SetModel(sp,SPR_DMG512, attacker.mcpclientdim);
		sp.frame = damage-1;
	}
	else
	{
		mcp_SetModel(sp,SPR_DMG999, attacker.mcpclientdim);
		sp.frame = damage-512-1;
	}
	
		setsize (sp, '-16 -16 -32', '16 16 32');
		setorigin(sp, targ.origin + '0 0 64');
		sp.think = SUB_Remove;
		sp.nextthink = time + 2;
		sp.movetype = MOVETYPE_FLY;
		sp.solid = SOLID_NOT;
		sp.velocity = '0 0 1' * 150;
};

void mcp_AddDamageStat(entity targ, entity inflictor, entity attacker, float damage) =
{

		if (damage >= targ.health + targ.armorvalue)
			damage = targ.health + targ.armorvalue;
			
		if(deathmsg == MCPDEATH_GREN_SHATTER && damage >= targ.armorvalue && targ.classname == CN_PLAYER && attacker.team_no != targ.team_no)
		{
			CreateDamageNumber(targ.armorvalue, targ, attacker);
		
			//AddStat(attacker, STAT_DMGGIVEN, targ.armorvalue);
			//AddStat(targ, STAT_DMGTAKEN, targ.armorvalue);
		}
		
		else if(attacker.classname == CN_PLAYER && targ.classname == CN_PLAYER && targ != attacker && attacker.team_no != targ.team_no)	//pvp damage
		{
			CreateDamageNumber(damage, targ, attacker);

			//AddStat(attacker, STAT_DMGGIVEN, damage);
			//AddStat(targ, STAT_DMGTAKEN, damage);
		}	
		else if(attacker == targ && attacker.classname == CN_PLAYER)						//self damage
		{
			//AddStat(targ, STAT_DMGSELF, damage);
		}
		else if (targ.classname == CN_PLAYER && attacker.classname != CN_PLAYER)				//world damage
		{	
			//AddStat(targ, STAT_DMGWORLD, damage);
		}
		
}; 

void mcp_Knockback(entity targ, entity inflictor, entity attacker, float damage) =
{
	if(targ.classname != CN_PLAYER)
		return;
// figure momentum add
	if ( (inflictor != world) && (targ.movetype == MOVETYPE_WALK) )
	{
		if(targ.playerclass == ROLE_MINIGUNNER && targ.mcpweapstate != MCPWEAPSTATE_NONE)
		{
			damage = damage * MGUNNER_BOUNCEREDUCTION;
			if (damage < MGUNNER_BOUNCETHRESHOLD)
				damage = 0;
		}

		local vector dir = targ.origin - (inflictor.absmin + inflictor.absmax) * 0.5;
		dir = normalize(dir);

		// Set kickback for smaller weapons
//Zoid -- use normal NQ kickback
//		// Read: only if it's not yourself doing the damage
//		if ( (damage < 60) & ((attacker.classname == "CN_PLAYER) & (targ.classname == CN_PLAYER)) & ( attacker.netname != targ.netname)) 
//			targ.velocity = targ.velocity + dir * damage * 11;
//		else                        
		// Otherwise, these rules apply to rockets and grenades                        
		// for blast velocity
			targ.velocity = targ.velocity + dir * damage * 8;
		
		// Rocket Jump modifiers
		if ( (rj > 1) & ((attacker.classname == CN_PLAYER) & (targ.classname == CN_PLAYER)) & ( attacker.netname == targ.netname)) 
			targ.velocity = targ.velocity + dir * damage * rj;

	}
};

void mcp_Damage (entity targ, entity inflictor, entity attacker, float damage) = 
{
	local   entity  oldself;
	local   float   save;
	local   float   take;

	local float knock;
	
	if (!targ.takedamage)
		return;
	if(matchstate > MATCHSTATE_LIVE)
		return;
	
	if(deathmsg == MCPDEATH_LASERBOLT || deathmsg == MCPDEATH_DRONEBULLET)
		damage = 0;

	mcp_HitSound(targ, inflictor, attacker, damage);
	knock = damage;
	if(targ.classname == CN_PLAYER)
	{
		//targ.healthnextregen = time + 3;
		
		if(targ.playerclass == ROLE_MINIGUNNER && targ.mcpweapstate != MCPWEAPSTATE_NONE)
			damage = damage * MGUNNER_DAMAGEREDUCTION;
			

		
	}
	if(mcpmode == MCPMODE_FIEND && attacker.playerclass == ROLE_FIEND)
	{
		mcp_HealFiend(attacker);
	}
	if(mcpmode == MCPMODE_BABYFIEND)
	{
		if(targ.classname == CN_PLAYER && targ.playerclass == ROLE_HUNTER)
		{
			if(attacker.classname == CN_PLAYER && attacker.playerclass == ROLE_BABYFIEND)
				mcp_ModifyTeamScore(MCPTEAM_RED, 1);
		}
	}
	// used by buttons and triggers to set activator for target firing
	damage_attacker = attacker;

	// save damage based on the target's armor level
	damage = ceil(damage);
	if(deathmsg == MCPDEATH_LASERBOLT)
		mcp_AddDamageStat(targ, inflictor, attacker, MCP_LASERBOLT_DAMAGE);
	else if (deathmsg == MCPDEATH_DRONEBULLET)
		mcp_AddDamageStat(targ, inflictor, attacker, DRONE_BULLETDMG);
	else
		mcp_AddDamageStat(targ, inflictor, attacker, damage);
	
	if(damage >= targ.armorvalue)
	{
		save = targ.armorvalue;
		
	}
	else
	{
		save = damage;
	}
	take = (damage - save);

	// add to the damage total for clients, which will be sent as a single
	// message at the end of the frame
	// FIXME: remove after combining shotgun blasts?
	if (targ.flags & FL_CLIENT)
	{
		targ.dmg_take = targ.dmg_take + take;
		targ.dmg_save = targ.dmg_save + save;
		targ.dmg_inflictor = inflictor;
	}

	//damage_inflictor = inflictor;        


	// figure momentum add
		if(inflictor.classname == CN_HARPOON && targ.team_no != attacker.team_no && inflictor.voided == 0)
		{
			HarpoonToward(targ, inflictor, attacker);
			local float rng = RNG(2);
			if(rng == 1)
				mcp_Sound(attacker, CHAN_AUTO, SND_HARPOONPULL1, 1, ATTN_NORM);
			if(rng == 2)
				mcp_Sound(attacker, CHAN_AUTO, SND_HARPOONPULL2, 1, ATTN_NORM);
		}
		else
		{
			if(deathmsg != MCPDEATH_GREN_SHATTER)
				mcp_Knockback(targ, inflictor, attacker, knock);
		}


	// check for godmode or invincibility
	if (targ.flags & FL_GODMODE)
		return;
	if (targ.invincible_finished >= time)
	{
		if (self.invincible_sound < time)
		{
			mcp_Sound(targ, CHAN_ITEM, SND_PROTECT3, 1, ATTN_NORM);
			self.invincible_sound = time + 2;
		}
		return;
	}

	// team play damage avoidance
	if (targ.team_no == attacker.team_no && inflictor.classname != "door" && attacker != targ)
	{

		return;
	}

		
	// do the damage
	if (save >= targ.armorvalue)
	{
		save = targ.armorvalue;
		if(targ.armorvalue > 0)
			{
				//break armour sound?
			}
	}
	
	
	targ.armorvalue = targ.armorvalue - save;
	
	if(deathmsg != MCPDEATH_GREN_SHATTER)
		targ.health = targ.health - take;
	if(deathmsg == MCPDEATH_LASERBOLT)
		targ.health = targ.health - MCP_LASERBOLT_DAMAGE;
	if(deathmsg == MCPDEATH_DRONEBULLET)
		targ.health = targ.health - DRONE_BULLETDMG;
	
	oldself=self; //<-- this stuff is for when missiles etc call damage and are considered 'self' and mess up animations etc
	self=targ;	
	if (targ.health <= 0)
	{	
		if(self.classname == CN_PLAYER)
			mcp_PlayerKilled (targ, attacker);
		else
			self.th_die();
		self=oldself;
		return;
	}

// react to the damage

	if (targ.th_pain)
	{
		targ.th_pain (attacker, take);
		self=oldself;
	}

	
};

void mcp_RadiusDamage (entity inflictor, entity attacker, float damage, entity ignore, float mcpdeath, float addstat) =
{
	local   float   points;
	local   entity  head;
	local   vector  org;
	
	head = findradius(inflictor.origin, damage+40);
	local float leech;
	local float enemyplayershit = 0;
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
						deathmsg = mcpdeath;
						mcp_Damage (head, inflictor, attacker, points);
						
						if(head.classname == CN_PLAYER && attacker.classname == CN_PLAYER && attacker.team_no != head.team_no)
							enemyplayershit++;
						
						if(attacker.team_no != head.team_no && head.classname == CN_PLAYER && deathmsg == MCPDEATH_GREN_LEECH && inflictor.cnt != 1)
						{

							leech = points / 2;
							//mcp_Sound(attacker, CHAN_ITEM, SND_LEECHGREN, 1, ATTN_NORM);
							attacker.health = attacker.health + leech;
							if(attacker.health >= 150 && attacker.deadflag == DEAD_NO)
								attacker.health = 150;

						}
					}
				}
			}
		}
		head = head.chain;
	}
	if(enemyplayershit > 0 && addstat == 1)
	{
		return;
		/*
		if(inflictor.classname == "throwngrenade")
		{
			AddStat(attacker,STAT_GRENHIT, inflictor.role);
		}
		else if(dtype == "clustermini_aoe" ||  dtype == "clustermini_direct")
		{
			
			if(inflictor.mcpgren.cnt == 0)
				{
					inflictor.mcpgren.cnt++;
					remove(inflictor.mcpgren);
					//AddStat(attacker, STAT_WEAPONHIT, WPN_GL);
				}
			
		}
		else
		{
			if(dtype == "rocket")
				AddStat(attacker, STAT_WEAPONHIT, WPN_RL);
		}
		*/
	}
	
};