void mcp_ParticleTarExplosion(vector org) =
{
	WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte(MSG_MULTICAST, TE_TAREXPLOSION);
	WriteCoord(MSG_MULTICAST, self.origin_x);
	WriteCoord(MSG_MULTICAST, self.origin_y);
	WriteCoord(MSG_MULTICAST, self.origin_z);
	multicast(self.origin, MULTICAST_PHS);
};
void mcp_ParticleTeleport(vector org) =
{
	WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte (MSG_MULTICAST, TE_TELEPORT);
	WriteCoord (MSG_MULTICAST, org_x);
	WriteCoord (MSG_MULTICAST, org_y);
	WriteCoord (MSG_MULTICAST, org_z);
	multicast (org, MULTICAST_PHS);
};
void mcp_ParticleExplosion(vector org) =
{
	WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte (MSG_MULTICAST, TE_EXPLOSION);
	WriteCoord (MSG_MULTICAST, org_x);
	WriteCoord (MSG_MULTICAST, org_y);
	WriteCoord (MSG_MULTICAST, org_z);
	multicast (org, MULTICAST_PHS);
};

void mcp_ParticleShaft(entity e, vector orgstart, vector orgfinish) =
{
	WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
	
	if(e.team_no == MCPTEAM_BLUE)
		WriteByte(MSG_MULTICAST, TE_LIGHTNING1);
	else
		WriteByte(MSG_MULTICAST, TE_LIGHTNING2);
		
	WriteEntity(MSG_MULTICAST, e);
	WriteCoord(MSG_MULTICAST, orgstart_x);
	WriteCoord(MSG_MULTICAST, orgstart_y);
	WriteCoord(MSG_MULTICAST, orgstart_z);
	WriteCoord(MSG_MULTICAST, orgfinish_x);
	WriteCoord(MSG_MULTICAST, orgfinish_y);
	WriteCoord(MSG_MULTICAST, orgfinish_z);
	multicast(orgstart, MULTICAST_PHS);
};

void mcp_ParticleShaft3(entity e, vector orgstart, vector orgfinish) =
{
	WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte(MSG_MULTICAST, TE_LIGHTNING3);
	WriteEntity(MSG_MULTICAST, e);
	WriteCoord(MSG_MULTICAST, orgstart_x);
	WriteCoord(MSG_MULTICAST, orgstart_y);
	WriteCoord(MSG_MULTICAST, orgstart_z);
	WriteCoord(MSG_MULTICAST, orgfinish_x);
	WriteCoord(MSG_MULTICAST, orgfinish_y);
	WriteCoord(MSG_MULTICAST, orgfinish_z);
	multicast(orgstart, MULTICAST_PHS);
};

void mcp_ParticleGunshot(vector org) = 
{
	WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte (MSG_MULTICAST, TE_GUNSHOT);
	WriteByte (MSG_MULTICAST, 3);
	WriteCoord (MSG_MULTICAST, org_x);
	WriteCoord (MSG_MULTICAST, org_y);
	WriteCoord (MSG_MULTICAST, org_z);
	multicast (org, MULTICAST_PVS);
};

void mcp_ParticleBlood(vector org, float damage) = 
{
	WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte(MSG_MULTICAST, TE_BLOOD);
	WriteByte(MSG_MULTICAST, 1);
	WriteCoord(MSG_MULTICAST, org_x);
	WriteCoord(MSG_MULTICAST, org_y);
	WriteCoord(MSG_MULTICAST, org_z);
	multicast(org, MULTICAST_PVS);
};

void mcp_ParticleSparks(vector org,  float damage) =
{
	WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte(MSG_MULTICAST, TE_LIGHTNINGBLOOD);
	WriteCoord(MSG_MULTICAST, org_x);
	WriteCoord(MSG_MULTICAST, org_y);
	WriteCoord(MSG_MULTICAST, org_z);
	multicast(trace_endpos, MULTICAST_PVS);
};

void mcp_AddMultiDamage(entity hit, float damage)=
{
	if (!hit)
		return;
	
	if (hit != multi_ent)
	{
		//ApplyMultiDamage () start
		if (multi_ent)
			mcp_Damage(multi_ent, self, self, multi_damage);
		//AppleMultiDamage () end
		
		multi_damage = damage;
		multi_ent = hit;
	}
	else
		multi_damage = multi_damage + damage;
};

void mcp_FireBullets(entity e, float shotcount, vector dir, vector spread) =
{
	local vector direction;
	local vector src;
	local float playershit;
	
	makevectors(e.v_angle);

	src = e.origin + v_forward*10;
	src_z = e.absmin_z + e.size_z * 0.7;

	//ClearMultiDamage() start
	multi_ent = world;
	multi_damage = 0;
	blood_count = 0;
	puff_count = 0;
	//ClearMultiDamage () end

	traceline (src, src + dir*3000, FALSE, e);	//2048
	
	puff_org = trace_endpos - dir*4;
	
	while (shotcount > 0)
	{
		
		direction = dir + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
		traceline (src, src + direction*2048, FALSE, self); //false

		if (trace_fraction != 1.0)
		{
			//TraceAttack (4, direction);
			local   vector  vel, org;
	
			vel = normalize(dir + v_up*crandom() + v_right*crandom());
			vel = vel + 2*trace_plane_normal;
			vel = vel * 200;

			org = trace_endpos - dir*4;
			if (trace_ent.takedamage)
			{
				blood_count = blood_count + 1;
				blood_org = org;
				mcp_AddMultiDamage (trace_ent, 4);
				
				if(trace_ent.classname == CN_PLAYER && trace_ent.team_no != self.team_no)
					playershit++;
			}
			else
			{
				puff_count = puff_count + 1;
			}
		}

		shotcount = shotcount - 1;
	}
	
	//ApplyMultiDamage () start
	if (multi_ent)
		mcp_Damage(multi_ent, self, self, multi_damage);
	//AppleMultiDamage () end
	
	//multi_finish() start
	if (puff_count) 
	{
		WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte(MSG_MULTICAST, TE_GUNSHOT);
		WriteByte(MSG_MULTICAST, puff_count);
		WriteCoord(MSG_MULTICAST, puff_org_x);
		WriteCoord(MSG_MULTICAST, puff_org_y);
		WriteCoord(MSG_MULTICAST, puff_org_z);
		multicast(puff_org, MULTICAST_PVS);
	}
	if (blood_count) 
	{
		WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte(MSG_MULTICAST, TE_BLOOD);
		WriteByte(MSG_MULTICAST, blood_count);
		WriteCoord(MSG_MULTICAST, blood_org_x);
		WriteCoord(MSG_MULTICAST, blood_org_y);
		WriteCoord(MSG_MULTICAST, blood_org_z);
		multicast(puff_org, MULTICAST_PVS);
	}
	//multi_finish() end
	
	if(playershit > 0)
	{
		//AddStat(self, STAT_WEAPONHIT, self.weapon);
	}
};

float mcp_GetSlotContaining(entity e, float w) =
{
	local float i = 0;
	local float m = mcpslot.length;
	for(i=0; i<m; i++)
	{
		if(e.mcpslot[i].type == w)
		{
			
			return i;
		}
	}
	bprint(2,"mcp_getslotcontaining() error\n");
	return 0;
};

void mcp_ChangeSlot(entity e, float slot) =
{
	e.impulse = 0;
	if (e.reloadingweapon != MCPWEAP_NONE)
		return;
	if (e.mcpslot[slot].type == MCPWEAP_NONE)
	{
		stufferror(e, "no weapon in this slot.");
		return;
	}
	e.lastslot = e.weapon;
	e.weapon = slot;

	mcp_ChangeWeaponModel(e,e.mcpslot[slot].type,0);
	mcp_UpdateHudAmmo(e,e.mcpslot[slot].type);

	if(e.playerclass == ROLE_MINIGUNNER)
		mcp_SetPlayerSpeed(e);
};


void mcp_LastSlot(entity e) =
{
	e.impulse = 0;
	if (e.reloadingweapon != MCPWEAP_NONE)
		return;
	if(e.weapon == e.lastslot)
		return;

	mcp_ChangeSlot (e,e.lastslot);
};

void think_mcpreload() =
{
	stuffsound(self.owner, MCPWEAPDICT[self.weapon].reloadsound);
	self.owner.mcpslot[mcp_GetSlotContaining(self.owner, self.weapon)].clipcount = self.owner.mcpslot[mcp_GetSlotContaining(self.owner, self.weapon)].clipcount + 1;
	self.nextthink = time + (MCPWEAPDICT[self.weapon].fullreloadtime/MCPWEAPDICT[self.weapon].clipsize);
	mcp_UpdateHudAmmo(self.owner,self.weapon);
	
	if (self.owner.mcpslot[mcp_GetSlotContaining(self.owner, self.weapon)].clipcount >=  MCPWEAPDICT[self.weapon].clipsize)
	{
		sprint(self.owner, PRINT_HIGH, strcat(MCPWEAPDICT[self.weapon].namestr," reloaded.\n"));
		self.think = SUB_Remove;
		self.nextthink = time + 0.1;
		self.owner.reloadingweapon = MCPWEAP_NONE;
		self.owner.attack_finished = time + 0.3;	//slight buffer for hud cosmetic reasons
		
		if(self.owner.mcpweapstate == MCPWEAPSTATE_DRONE || self.owner.mcpweapstate == MCPWEAPSTATE_DRONESHOOT)
			return;
			
		mcp_ChangeSlot(self.owner,mcp_GetSlotContaining(self.owner, self.weapon));
	}
	
	
};

void mcp_ReloadWeapon(entity e, float wpn) =
{
	e.impulse = 0;
	
	if (e.reloadingweapon != MCPWEAP_NONE)
		return;

	if(e.playerclass == ROLE_NONE || e.playerclass == ROLE_FIEND || e.playerclass == ROLE_BABYFIEND)
		return;
		
	if(e.playerclass == ROLE_FIENDHUMAN || e.playerclass == ROLE_MUGGER)
	{
		if(wpn != MCPWEAP_RAILGUN)
			return;
	}
	if(e.mcpweapstate == MCPWEAPSTATE_DRONE || e.mcpweapstate == MCPWEAPSTATE_DRONESHOOT)
		return;
	
	if(e.mcpslot[mcp_GetSlotContaining(e, wpn)].clipcount >= MCPWEAPDICT[wpn].clipsize)
	{
		stufferror(e,strcat(MCPWEAPDICT[wpn].namestr," is already loaded."));
		return;
	}
	
	local entity te;
	te = spawn();
	te.classname = CN_RELOAD;
	te.owner = e;
	te.weapon = wpn;
	te.think = think_mcpreload;
	te.nextthink = time + (MCPWEAPDICT[wpn].fullreloadtime/MCPWEAPDICT[wpn].clipsize);
	sprint(e, PRINT_HIGH, strcat("reloading ",MCPWEAPDICT[wpn].namestr,".\n"));
	e.reloadingweapon = wpn;
	if(wpn != MCPWEAP_RAILGUN)
		e.weaponmodel = "";
};

void mcp_ReloadNext(entity e) =
{
	e.impulse = 0;
	if(e.mcpslot[e.weapon].clipcount < MCPWEAPDICT[e.mcpslot[e.weapon].type].clipsize)
	{
		mcp_ReloadWeapon(e, e.mcpslot[e.weapon].type);
		return;
	}
	local float s = -1;
	local float i;
	for(i = 0; i < mcpslot.length; i++)
	{
		if(e.mcpslot[i].type != MCPWEAP_NONE)
		{
			if(e.mcpslot[i].clipcount < MCPWEAPDICT[e.mcpslot[i].type].clipsize)
				s = i;
		}
	}
	
	if(s != -1)
		mcp_ReloadWeapon(e, e.mcpslot[s].type);
	else
		stufferror(e,"all weapons are loaded");
};

void mcp_ShootDroneGun (entity e, float offset) =
{
	e.attack_finished = time + 0.2;
	//AddStat(e, STAT_WEAPONFIRED, WPN_SNG);
	mcp_Sound(e, CHAN_WEAPON, SND_SHOOTLASERGUN, 1, ATTN_NORM);
	//e.clip_primary = e.clip_primary - 1;
	mcp_SpawnDroneBullet(e, offset);
};
void mcp_ShootShaft (entity e) = 
{
	if (e.t_width < time)
	{
		mcp_Sound(e, CHAN_WEAPON, SND_SHAFTLOOP, 1, ATTN_NORM);
		e.t_width = time + 0.6;
	}
	
	local vector org = e.origin + '0 0 16';
	traceline(org, org + v_forward * 600, 0, e);

	//AddStat(self, STAT_WEAPONFIRED, WPN_SHAFT);
	if (trace_ent.takedamage)
	{
		mcp_ParticleBlood(trace_endpos,20);
		local float healselffor = 0;
		local float healteamfor = 0;
		if (trace_ent.classname == CN_PLAYER && trace_ent.team_no != e.team_no)
		{
			//trace_ent.velocity_z = trace_ent.velocity_z + 400;
			//AddStat(e, STAT_WEAPONHIT, WPN_SHAFT);
			deathmsg = MCPDEATH_SHAFT;
			mcp_Damage (trace_ent, e, e, SHAFT_DAMAGE);
			
			if(e.health < MCPROLEDICT[e.playerclass].maxhealth)
			{
				if(e.health + SHAFT_SELFHEAL > MCPROLEDICT[e.playerclass].maxhealth)
					healselffor = MCPROLEDICT[e.playerclass].maxhealth - e.health;
				else
					healselffor = SHAFT_SELFHEAL;
			}
		}
		
		if(trace_ent.team_no == self.team_no && trace_ent.classname == CN_PLAYER)
		{
			if(trace_ent.health < (MCPROLEDICT[trace_ent.playerclass].maxhealth + SHAFT_OVERHEAL))
			{
				
				if(trace_ent.health + SHAFT_HEAL > MCPROLEDICT[trace_ent.playerclass].maxhealth + SHAFT_OVERHEAL)
				{
					healteamfor = (trace_ent.health + SHAFT_HEAL) - trace_ent.health;
				}
				else
				{
					healteamfor = SHAFT_HEAL;
				}
				

			
				if(e.health + SHAFT_OVERHEAL >  MCPROLEDICT[e.playerclass].maxhealth + SHAFT_OVERHEAL)
					healselffor = (MCPROLEDICT[e.playerclass].maxhealth + SHAFT_OVERHEAL) - e.health;
				else
					healselffor = SHAFT_SELFHEAL;
			}

		}

	}

	//if(e.playerclass == ROLE_DOCTOR && (healteamfor > 0 || healselffor > 0))
	if(healteamfor > 0 || healselffor > 0)
	{
		if(healteamfor > 0)
		{
			mcp_Sound(trace_ent, CHAN_ITEM, SND_R_ITEM1, 1, ATTN_NORM);
			mcp_CreateHealNumber(healteamfor, trace_ent, self);
		}
				
		mcp_Sound(e, CHAN_AUTO, SND_R_ITEM1, 1, ATTN_NORM);
		trace_ent.health = trace_ent.health + healteamfor;
		e.health = e.health + healselffor;
		mcp_ParticleShaft3(e,org,trace_endpos);
	}
	else
	{
		mcp_ParticleShaft(e,org,trace_endpos);
	}
};

void mcp_ShootFlamer(entity e) =
{
	e.attack_finished = time + 0.1;
	mcp_Sound(e ,CHAN_WEAPON, MCPWEAPDICT[MCPWEAP_FLAMER].shootsound, 1, ATTN_NORM); 
	e.mcpslot[mcp_GetSlotContaining(e,MCPWEAP_FLAMER)].clipcount--;
	mcp_UpdateHudAmmo(e,MCPWEAP_FLAMER);
	mcp_SpawnFlame(e);
}

void mcp_ShootNail(entity e) =
{
	e.attack_finished = time + 0.2;
	//AddStat(e, STAT_WEAPONFIRED, MCPWEAP_SNG);
	mcp_Sound(e, CHAN_WEAPON, MCPWEAPDICT[MCPWEAP_SNG].shootsound, 1, ATTN_NORM);
	e.mcpslot[mcp_GetSlotContaining(e,MCPWEAP_SNG)].clipcount--;
	mcp_UpdateHudAmmo(e,MCPWEAP_SNG);
	mcp_SpawnNail(e);
};

void mcp_ShootFiendClaws(entity e) =
{
	if(e.fiendmeleehit >= 2)
		return;
	local vector sauce;
	local vector oregano;
	makevectors (e.v_angle);
	sauce = e.origin + '0 0 16';
	traceline (sauce, sauce + v_forward*64, FALSE, e); // false
	//AddStat(e, STAT_WEAPONFIRED, WPN_AXE);
	if (trace_fraction == 1.0)
		return;
			
	oregano = trace_endpos - v_forward*8;
	
	if (trace_ent.takedamage)
	{
		e.fiendmeleehit = 2;
		if(trace_ent.classname == CN_PLAYER && trace_ent.team_no != e.team_no)
		{
				//AddStat(e, STAT_WEAPONHIT, WPN_AXE);
		}
		trace_ent.axhitme = 1;
		mcp_ParticleBlood(oregano, 20);
		deathmsg = MCPDEATH_FIENDCLAWS;
		if(e.playerclass == ROLE_FIEND)
		{
			mcp_Damage (trace_ent, e, e, MELEEDAMAGE_FIEND);
			mcp_Sound(e, CHAN_WEAPON, SND_DHIT2, 1, ATTN_NORM);
		}
		else
		{
			mcp_Damage (trace_ent, e, e, MELEEDAMAGE_BABYFIEND);
			mcp_Sound(e, CHAN_WEAPON, SND_BABYFIEND_HIT2, 1, ATTN_NORM);
		}
			
		if(e.weaponmode == 0)
			mcp_SpawnMeatSpray(e.origin + v_forward*16, -200 * v_right);
		else
			mcp_SpawnMeatSpray(e.origin + v_forward*16, 200 * v_right);
	}
	else
	{     
		if(e.fiendmeleehit >= 1)
			return;
			
		if(mcpmode == MCPMODE_BABYFIEND)
			mcp_Sound(e, CHAN_WEAPON, SND_BABYFIEND_HIT1, 1, ATTN_NORM);
		else
			mcp_Sound(e, CHAN_WEAPON, SND_Z_HIT, 1, ATTN_NORM);
				
		mcp_ParticleGunshot(oregano);
		e.fiendmeleehit = 1;
	}	
};

void mcp_Attack(entity e, float slot) =
{
	if(e.reloadingweapon != MCPWEAP_NONE)
		return;
	if(matchstate > MATCHSTATE_LIVE)
		return; 
	local float wpn; 
	
	if(e.mcpweapstate == MCPWEAPSTATE_DRONE || e.mcpweapstate == MCPWEAPSTATE_DRONESHOOT)
		wpn = MCPWEAP_DRONEGUN;
	else
		wpn = e.mcpslot[slot].type;
		
	if(wpn == MCPWEAP_FIENDCLAWS)
	{
		e.attack_finished = time + 1;
		e.fiendmeleehit = 0;
		local float rng = random();
		if (rng > 0.5)
		{
			if(mcpmode == MCPMODE_BABYFIEND)
				mcp_Sound(e,CHAN_VOICE, SND_BABYFIEND_SIGHT, 1, ATTN_NORM);
			else
				mcp_Sound (e, CHAN_VOICE, SND_DSIGHT2, 1, ATTN_NORM);
		}
		else
		{
			if(mcpmode == MCPMODE_BABYFIEND)
				mcp_Sound(e,CHAN_VOICE, SND_BABYFIEND_IDLE, 1, ATTN_NORM);
			else
				mcp_Sound (e, CHAN_VOICE, SND_DIDLE1, 1, ATTN_NORM);
		}
		
		if(e.weaponmode == 0)
		{
			mcpfiend_attl1();
			e.weaponmode = 1;
		}
		else
		{
			mcpfiend_attr1();
			e.weaponmode = 0;
		}
		
	}
	if(wpn == MCPWEAP_AXE)
	{
		e.attack_finished = time + 0.5;
		mcp_Sound(e, CHAN_WEAPON, MCPWEAPDICT[wpn].shootsound, 1, ATTN_NORM);
		local float r = random();
		if (r < 0.25)
			mcpplayer_axe1();
		else if (r < 0.5)
			mcpplayer_axeb1();
		else if (r < 0.75)
			mcpplayer_axec1();
		else
			mcpplayer_axed1();
		
		local vector source;
		local vector org;

		makevectors (e.v_angle);
		source = e.origin + '0 0 16';
		traceline (source, source + v_forward*64, FALSE, e); // false
		//AddStat(e, STAT_WEAPONFIRED, WPN_AXE);

		if (trace_fraction == 1.0)
			return;
			
		org = trace_endpos - v_forward*8;

		if (trace_ent.takedamage)
		{
			if(trace_ent.classname == CN_PLAYER && trace_ent.team_no != e.team_no)
			{
				//AddStat(e, STAT_WEAPONHIT, WPN_AXE);
			}
			trace_ent.axhitme = 1;
			mcp_ParticleBlood(org, 20);
			deathmsg = MCPDEATH_AXE;
			if(e.playerclass == ROLE_ASSASSIN)
				mcp_Damage (trace_ent, e, e, MELEEDAMAGE_ASSASSIN);
			else
				mcp_Damage (trace_ent, e, e, MELEEDAMAGE_GENERAL);
		}
		else
		{     
			mcp_Sound(e, CHAN_WEAPON, SND_AXHIT2, 1, ATTN_NORM);
			mcp_ParticleGunshot(org);
		}
		
	}
	else if (wpn == MCPWEAP_SHOTGUN)
	{
		e.attack_finished = time + 0.5;
		mcpplayer_shot1();
		
		e.mcpslot[slot].clipcount--;
		mcp_UpdateHudAmmo(e,MCPWEAP_SHOTGUN);
		mcp_Sound(e, CHAN_WEAPON, MCPWEAPDICT[wpn].shootsound, 1, ATTN_NORM); 

		local vector dir = aim (e, 100000);
		//AddStat(e, STAT_WEAPONFIRED, WPN_SHOTGUN);
		deathmsg = MCPDEATH_SHOTGUN;
		mcp_FireBullets (e, 6, dir, '0.04 0.04 0');
		
		if(e.mcpslot[slot].clipcount <= 0)
		{
			mcp_ReloadWeapon(e, wpn);
		}
	
	}
	else if (wpn == MCPWEAP_DBLBARREL)
	{
		e.attack_finished = time + 0.6;
		mcpplayer_shot1();
		
		e.mcpslot[slot].clipcount--;
		mcp_UpdateHudAmmo(e,wpn);
		mcp_Sound(e ,CHAN_WEAPON, MCPWEAPDICT[wpn].shootsound, 1, ATTN_NORM); 
	
		local vector dir2 = aim (e, 100000);
		//AddStat(e, STAT_WEAPONFIRED, WPN_DBLBARREL);
		deathmsg = MCPDEATH_DBLBARREL;
		mcp_FireBullets (e,14, dir2, '0.14 0.08 0');
		
		if(e.playerclass == ROLE_RECON)
		{
			if(e.v_angle_x > 25 && e.reconshotgunjumps > 0)
			{
				local float lookdown = e.v_angle_x/60 * 350;
				e.velocity.z = lookdown;
				e.reconshotgunjumps--;
			}
		}
		
		if(e.mcpslot[slot].clipcount <= 0)
		{
			mcp_ReloadWeapon(e, wpn);
		}
	}
	else if (wpn == MCPWEAP_SNG)
	{
		mcpplayer_nail1();
	}
	else if(wpn == MCPWEAP_FLAMER)
	{
		mcpplayer_flamer1();

	}
	else if (wpn == MCPWEAP_DRONEGUN)
	{
		mcpdrone_attack1();
	}
	else if( wpn == MCPWEAP_SHAFT) 
	{
		mcpplayer_light1();
		mcp_Sound(self, CHAN_AUTO,MCPWEAPDICT[wpn].shootsound, 1, ATTN_NORM);	
	}
	else if( wpn == MCPWEAP_SHAFTUNLIM) 
	{
		mcpplayer_unlimlight1();
		mcp_Sound(self, CHAN_AUTO,MCPWEAPDICT[wpn].shootsound, 1, ATTN_NORM);
	}
	else if (wpn == MCPWEAP_MINIGUN)
	{
		if(self.mcpweapstate == MCPWEAPSTATE_NONE)
		{
			mcp_Sound(self, CHAN_WEAPON, SND_MINIGUNSPINUP, 1, ATTN_NORM);
			e.mgun_spinupfinish = time + MINIGUN_SPINUPTIME;
			e.mcpweapstate = MCPWEAPSTATE_SPINUP;
			mcpplayer_minigunup();
			mcp_SetPlayerSpeed(e);
		}

	}
	else if(wpn == MCPWEAP_RAILGUN)
	{
		mcpplayer_rocket1();
		e.attack_finished = time + 0.5;
		
		e.mcpslot[slot].clipcount--;
		mcp_UpdateHudAmmo(e,wpn);
		mcp_Sound(e ,CHAN_WEAPON, MCPWEAPDICT[wpn].shootsound, 1, ATTN_NORM); 
		
		makevectors (e.v_angle);
		source = e.origin + '0 0 16';
		//AddStat(e, STAT_WEAPONFIRED, WPN_RAILGUN);
		traceline (source, source + v_forward*5000, FALSE, e);
		if (trace_fraction == 1.0)
			return;
	
		org = trace_endpos - v_forward*4;
		if (trace_ent.takedamage)
		{
			local float maxdamage = 60;
			local float mindamage = 20;
			local float mindistance = 300;
			local float maxdistance = 1200;
			local float dmg;
			local vector difference = e.origin - trace_ent.origin;
			local float distance = rint(sqrt(pow(difference.x, 2) + pow(difference.y, 2) + pow(difference.z, 2)));
			if(distance < mindistance)
				distance = mindistance;
			if (distance > maxdistance)
				distance = maxdistance;
			distance = distance - mindistance;
			local float dmgrange = maxdistance-mindistance;
			dmg = maxdamage * (1-(distance/dmgrange));
			dmg = rint(dmg);
			if(dmg < mindamage)
				dmg = mindamage;
				
			//sprint(self, PRINT_HIGH, strcat("distance:",ftos(distance), " dmgrange:", ftos(dmgrange), " damage:", ftos(dmg), ".\n"));
			if(trace_ent.classname == CN_PLAYER && trace_ent.team_no != e.team_no)
			{
				e.heat = e.heat + 1;
				//AddStat(e, STAT_WEAPONHIT, e.heat);
				if(e.heat > 3)
					e.heat = 3;
				dmg = dmg * e.heat;
				local string multiplier = "";
				if(e.heat == 1)
					multiplier = " damage.\n";
				if(e.heat == 2)
				{	
					stuffsound(e, SND_IMPRESSIVE);
					multiplier = " damage (doubled).\n";
				}
				if(e.heat == 3)
				{
					stuffsoundteam (MCPTEAM_BLUE,  SND_ACCURACY, world);
					stuffsoundteam (MCPTEAM_RED, SND_ACCURACY, world);
					multiplier = " damage (tripled).\n";
				}
				
				sprint(e, PRINT_HIGH, strcat("you rail ",trace_ent.netname, " for ", ftos(dmg), multiplier));
				
			}
			else
			{	
				if(e.heat > 0)
				{	
					e.heat = 0;
					stuffsound(e, SND_HITSOUNDRAIL0);
					sprint(e, PRINT_HIGH, strcat("consecutive hit multiplier lost.\n"));
				}
			}
			trace_ent.axhitme = 1;
			mcp_ParticleBlood(org, 20);
			deathmsg = MCPDEATH_RAILGUN;
			mcp_Damage (trace_ent, e, e, dmg);
		}
		else
		{       // hit wall
			mcp_ParticleGunshot(org);
			if(e.heat > 0)
			{	
				e.heat = 0;
				stuffsound(e, SND_HITSOUNDRAIL0);
				sprint(e, PRINT_HIGH, strcat("consecutive hit multiplier lost.\n"));
			}
		}

		org = e.origin + '0 0 16';

		traceline (org, org + v_forward*5000, TRUE, e);
		mcp_ParticleShaft(e,org,trace_endpos);
		
		if(e.mcpslot[slot].clipcount <= 0)
		{
			mcp_ReloadWeapon(e, wpn);
		}
	}
	else if (wpn == MCPWEAP_RL || wpn == MCPWEAP_RLUNLIM)
	{
		mcpplayer_rocket1();
		e.attack_finished = time + 0.8;
		if(wpn == MCPWEAP_RL)
			e.mcpslot[slot].clipcount--;
		mcp_UpdateHudAmmo(e,wpn);
		mcp_Sound(e ,CHAN_WEAPON, MCPWEAPDICT[wpn].shootsound, 1, ATTN_NORM); 

		mcp_SpawnRocket(e);
		
		if(e.mcpslot[slot].clipcount <= 0)
			mcp_ReloadWeapon(e, wpn);
	}
	else if(wpn == MCPWEAP_GL)
	{
		mcpplayer_rocket1();
		e.attack_finished = time + 0.6; //0.6
		
		e.mcpslot[slot].clipcount--;
		mcp_UpdateHudAmmo(e,wpn);
		mcp_Sound(e ,CHAN_WEAPON, MCPWEAPDICT[wpn].shootsound, 1, ATTN_NORM); 

		mcp_SpawnSticky(e);

		if(e.mcpslot[slot].clipcount <= 0)
			mcp_ReloadWeapon(e, wpn);
	}

	else if (wpn == MCPWEAP_LASERGUN)
	{
		mcpplayer_rocket1();
		e.attack_finished = time + 0.4;

		e.mcpslot[slot].clipcount--;
		mcp_UpdateHudAmmo(e,wpn);
		mcp_Sound(e ,CHAN_WEAPON, MCPWEAPDICT[wpn].shootsound, 1, ATTN_NORM); 

		mcp_SpawnLaserBolt(e);
		
		if(e.mcpslot[slot].clipcount <= 0)
			mcp_ReloadWeapon(e, wpn);
	}
};
