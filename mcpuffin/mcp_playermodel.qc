void() bubble_bob;
void mcp_PainSound(entity e) =
{
	local float		rs;

	if (e.health < 0)
		return;

	if (damage_attacker.classname == "teledeath")
	{
		mcp_Sound(e, CHAN_VOICE, SND_TELEDTH1, 1, ATTN_NONE);
		return;
	}

	// water pain sounds
	if (e.watertype == CONTENT_WATER && e.waterlevel == 3)
	{
		mcp_DeathBubbles(e,1);
		if (random() > 0.5)
			mcp_Sound(e, CHAN_VOICE, SND_DROWN1, 1, ATTN_NORM);
		else
			mcp_Sound(e, CHAN_VOICE, SND_DROWN2, 1, ATTN_NORM);
		return;
	}

	// slime pain sounds
	if (e.watertype == CONTENT_SLIME)
	{
	// FIX ME	put in some steam here
		if (random() > 0.5)
			mcp_Sound(e, CHAN_VOICE, SND_LBURN1, 1, ATTN_NORM);
		else
			mcp_Sound(e, CHAN_VOICE, SND_LBURN2, 1, ATTN_NORM);
		return;
	}

	if (e.watertype == CONTENT_LAVA)
	{
		if (random() > 0.5)
			mcp_Sound(e, CHAN_VOICE, SND_LBURN1, 1, ATTN_NORM);
		else
			mcp_Sound(e, CHAN_VOICE, SND_LBURN2, 1, ATTN_NORM);
		return;
	}

	if (e.pain_finished > time)
	{
		e.axhitme = 0;
		return;
	}
	e.pain_finished = time + 0.5;

// don't make multiple pain sounds right after each other

// ax pain sound
	if (e.axhitme == 1)
	{
		e.axhitme = 0;
		mcp_Sound(e, CHAN_VOICE, SND_AXHIT1, 1, ATTN_NORM);
		return;
	}
	

	rs = rint((random() * 5) + 1);

	e.noise = "";
	if (rs == 1)
		e.noise = SND_PAIN1;
	else if (rs == 2)
		e.noise = SND_PAIN2;
	else if (rs == 3)
		e.noise = SND_PAIN3;
	else if (rs == 4)
		e.noise = SND_PAIN4;
	else if (rs == 5)
		e.noise = SND_PAIN5;
	else
		e.noise = SND_PAIN6;

	mcp_Sound(e, CHAN_VOICE, e.noise, 1, ATTN_NORM);
	return;
};
void mcpplayer_pain() =
{
	if (self.weaponframe)
		return;

	if (mcp_VisibleWeapon (self) == MCPWEAP_AXE)
		mcpplayer_axpain1 ();
	else if (mcp_VisibleWeapon (self) == MCPWEAP_MINIGUN)
		mcp_PainSound(self);
	else
		mcpplayer_pain1();
};

//PLAYER
$cd id1/models/player_4
$origin 0 -6 24
$base base		
$skin skin

// running
$frame axrun1 axrun2 axrun3 axrun4 axrun5 axrun6

$frame rockrun1 rockrun2 rockrun3 rockrun4 rockrun5 rockrun6

// standing
$frame stand1 stand2 stand3 stand4 stand5

$frame axstnd1 axstnd2 axstnd3 axstnd4 axstnd5 axstnd6
$frame axstnd7 axstnd8 axstnd9 axstnd10 axstnd11 axstnd12

// pain
$frame axpain1 axpain2 axpain3 axpain4 axpain5 axpain6

$frame pain1 pain2 pain3 pain4 pain5 pain6

// death
$frame axdeth1 axdeth2 axdeth3 axdeth4 axdeth5 axdeth6
$frame axdeth7 axdeth8 axdeth9

$frame deatha1 deatha2 deatha3 deatha4 deatha5 deatha6 deatha7 deatha8
$frame deatha9 deatha10 deatha11

$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8
$frame deathb9

$frame deathc1 deathc2 deathc3 deathc4 deathc5 deathc6 deathc7 deathc8
$frame deathc9 deathc10 deathc11 deathc12 deathc13 deathc14 deathc15

$frame deathd1 deathd2 deathd3 deathd4 deathd5 deathd6 deathd7
$frame deathd8 deathd9

$frame deathe1 deathe2 deathe3 deathe4 deathe5 deathe6 deathe7
$frame deathe8 deathe9

// attacks
$frame nailatt1 nailatt2

$frame light1 light2

$frame rockatt1 rockatt2 rockatt3 rockatt4 rockatt5 rockatt6

$frame shotatt1 shotatt2 shotatt3 shotatt4 shotatt5 shotatt6

$frame axatt1 axatt2 axatt3 axatt4 axatt5 axatt6

$frame axattb1 axattb2 axattb3 axattb4 axattb5 axattb6

$frame axattc1 axattc2 axattc3 axattc4 axattc5 axattc6

$frame axattd1 axattd2 axattd3 axattd4 axattd5 axattd6



//PLAYER
void() mcpplayer_run;

void()	mcpplayer_stand1 =[	$axstnd1,	mcpplayer_stand1	]
{
	self.weaponframe=0;
	if (self.velocity_x || self.velocity_y)
	{
		self.walkframe=0;
		mcpplayer_run();
		return;
	}

	if (mcp_VisibleWeapon (self) == MCPWEAP_AXE)
	{
		if (self.walkframe >= 12)
			self.walkframe = 0;
		self.frame = $axstnd1 + self.walkframe;
	}
	else
	{
		if (self.walkframe >= 5)
			self.walkframe = 0;
		self.frame = $stand1 + self.walkframe;
	}
	self.walkframe = self.walkframe + 1;	
};

void()	mcpplayer_run =[	$rockrun1,	mcpplayer_run	]
{
	self.weaponframe=0;
	if (!self.velocity_x && !self.velocity_y)
	{
		self.walkframe=0;
		mcpplayer_stand1();
		return;
	}
	if(fabs(self.velocity_x) > 100 || fabs(self.velocity_y) > 100)
	{
		if(self.flags & FL_ONGROUND && self.waterlevel == 0 && self.iscloaked == 0)
		{
			if(time >= self.lastfootstep && self.deadflag == DEAD_NO)
			{
				local float rng = RNG(2);
				local string fstep = SND_FOOTSTEP1;
				if(rng == 1)
					fstep = SND_FOOTSTEP1;
				else
					fstep = SND_FOOTSTEP2;

				mcp_Sound(self, CHAN_VOICE, fstep, 1, ATTN_NORM);
				self.lastfootstep = time + FOOTSTEPSOUNDINTERVAL;
			}
		}
	}
	if (mcp_VisibleWeapon (self) == MCPWEAP_AXE)
	{
		if (self.walkframe == 6)
			self.walkframe = 0;
		self.frame = $axrun1 + self.walkframe;
	}
	else
	{
		if (self.walkframe == 6)
			self.walkframe = 0;
		self.frame = self.frame + self.walkframe;
	}
	self.walkframe = self.walkframe + 1;
};


void()	mcpplayer_shot1 =	[$shotatt1, mcpplayer_shot2	] {self.weaponframe=1;mcp_muzzleflash(self);}
void()	mcpplayer_shot2 =	[$shotatt2, mcpplayer_shot3	] {self.weaponframe=2;};
void()	mcpplayer_shot3 =	[$shotatt3, mcpplayer_shot4	] {self.weaponframe=3;};
void()	mcpplayer_shot4 =	[$shotatt4, mcpplayer_shot5	] {self.weaponframe=4;};
void()	mcpplayer_shot5 =	[$shotatt5, mcpplayer_shot6	] {self.weaponframe=5;};
void()	mcpplayer_shot6 =	[$shotatt6, mcpplayer_run	] {self.weaponframe=6;};

void()	mcpplayer_axe1 =	[$axatt1, mcpplayer_axe2	] {self.weaponframe=1;};
void()	mcpplayer_axe2 =	[$axatt2, mcpplayer_axe3	] {self.weaponframe=2;};
void()	mcpplayer_axe3 =	[$axatt3, mcpplayer_axe4	] {self.weaponframe=3;};
void()	mcpplayer_axe4 =	[$axatt4, mcpplayer_run		] {self.weaponframe=4;};

void()	mcpplayer_axeb1 =	[$axattb1, mcpplayer_axeb2	] {self.weaponframe=5;};
void()	mcpplayer_axeb2 =	[$axattb2, mcpplayer_axeb3	] {self.weaponframe=6;};
void()	mcpplayer_axeb3 =	[$axattb3, mcpplayer_axeb4	] {self.weaponframe=7;};
void()	mcpplayer_axeb4 =	[$axattb4, mcpplayer_run	] {self.weaponframe=8;};

void()	mcpplayer_axec1 =	[$axattc1, mcpplayer_axec2	] {self.weaponframe=1;};
void()	mcpplayer_axec2 =	[$axattc2, mcpplayer_axec3	] {self.weaponframe=2;};
void()	mcpplayer_axec3 =	[$axattc3, mcpplayer_axec4	] {self.weaponframe=3;};
void()	mcpplayer_axec4 =	[$axattc4, mcpplayer_run	] {self.weaponframe=4;};

void()	mcpplayer_axed1 =	[$axattd1, mcpplayer_axed2	] {self.weaponframe=5;};
void()	mcpplayer_axed2 =	[$axattd2, mcpplayer_axed3	] {self.weaponframe=6;};
void()	mcpplayer_axed3 =	[$axattd3, mcpplayer_axed4	] {self.weaponframe=7;};
void()	mcpplayer_axed4 =	[$axattd4, mcpplayer_run	] {self.weaponframe=8;};

void() mcpplayer_rocket1   =[$rockatt1, mcpplayer_rocket2  ] {self.weaponframe=1;mcp_muzzleflash(self);};
void() mcpplayer_rocket2   =[$rockatt2, mcpplayer_rocket3  ] {self.weaponframe=2;};
void() mcpplayer_rocket3   =[$rockatt3, mcpplayer_rocket4  ] {self.weaponframe=3;};
void() mcpplayer_rocket4   =[$rockatt4, mcpplayer_rocket5  ] {self.weaponframe=4;};
void() mcpplayer_rocket5   =[$rockatt5, mcpplayer_rocket6  ] {self.weaponframe=5;};
void() mcpplayer_rocket6   =[$rockatt6, mcpplayer_run  ] {self.weaponframe=6;};

void()	mcpplayer_pain1 =	[	$pain1,	mcpplayer_pain2	] {mcp_PainSound(self);self.weaponframe=0;};
void()	mcpplayer_pain2 =	[	$pain2,	mcpplayer_pain3	] {};
void()	mcpplayer_pain3 =	[	$pain3,	mcpplayer_pain4	] {};
void()	mcpplayer_pain4 =	[	$pain4,	mcpplayer_pain5	] {};
void()	mcpplayer_pain5 =	[	$pain5,	mcpplayer_pain6	] {};
void()	mcpplayer_pain6 =	[	$pain6,	mcpplayer_run	] {};

void()	mcpplayer_axpain1 =	[	$axpain1,	mcpplayer_axpain2] {mcp_PainSound(self);self.weaponframe=0;};
void()	mcpplayer_axpain2 =	[	$axpain2,	mcpplayer_axpain3] {};
void()	mcpplayer_axpain3 =	[	$axpain3,	mcpplayer_axpain4] {};
void()	mcpplayer_axpain4 =	[	$axpain4,	mcpplayer_axpain5] {};
void()	mcpplayer_axpain5 =	[	$axpain5,	mcpplayer_axpain6] {};
void()	mcpplayer_axpain6 =	[	$axpain6,	mcpplayer_run	] {};

void()	mcpplayer_diea1	=	[	$deatha1,	mcpplayer_diea2	] {};
void()	mcpplayer_diea2	=	[	$deatha2,	mcpplayer_diea3	] {};
void()	mcpplayer_diea3	=	[	$deatha3,	mcpplayer_diea4	] {};
void()	mcpplayer_diea4	=	[	$deatha4,	mcpplayer_diea5	] {};
void()	mcpplayer_diea5	=	[	$deatha5,	mcpplayer_diea6	] {};
void()	mcpplayer_diea6	=	[	$deatha6,	mcpplayer_diea7	] {};
void()	mcpplayer_diea7	=	[	$deatha7,	mcpplayer_diea8	] {};
void()	mcpplayer_diea8	=	[	$deatha8,	mcpplayer_diea9	] {};
void()	mcpplayer_diea9	=	[	$deatha9,	mcpplayer_diea10] {};
void()	mcpplayer_diea10=	[	$deatha10,	mcpplayer_diea11] {};
void()	mcpplayer_diea11=	[	$deatha11,	mcpplayer_diea11 ] {mcp_EndDeathSeq();};

void()	mcpplayer_dieb1	=	[	$deathb1,	mcpplayer_dieb2	] {};
void()	mcpplayer_dieb2	=	[	$deathb2,	mcpplayer_dieb3	] {};
void()	mcpplayer_dieb3	=	[	$deathb3,	mcpplayer_dieb4	] {};
void()	mcpplayer_dieb4	=	[	$deathb4,	mcpplayer_dieb5	] {};
void()	mcpplayer_dieb5	=	[	$deathb5,	mcpplayer_dieb6	] {};
void()	mcpplayer_dieb6	=	[	$deathb6,	mcpplayer_dieb7	] {};
void()	mcpplayer_dieb7	=	[	$deathb7,	mcpplayer_dieb8	] {};
void()	mcpplayer_dieb8	=	[	$deathb8,	mcpplayer_dieb9	] {};
void()	mcpplayer_dieb9	=	[	$deathb9,	mcpplayer_dieb9	] {mcp_EndDeathSeq();};

void()	mcpplayer_diec1	=	[	$deathc1,	mcpplayer_diec2	] {};
void()	mcpplayer_diec2	=	[	$deathc2,	mcpplayer_diec3	] {};
void()	mcpplayer_diec3	=	[	$deathc3,	mcpplayer_diec4	] {};
void()	mcpplayer_diec4	=	[	$deathc4,	mcpplayer_diec5	] {};
void()	mcpplayer_diec5	=	[	$deathc5,	mcpplayer_diec6	] {};
void()	mcpplayer_diec6	=	[	$deathc6,	mcpplayer_diec7	] {};
void()	mcpplayer_diec7	=	[	$deathc7,	mcpplayer_diec8	] {};
void()	mcpplayer_diec8	=	[	$deathc8,	mcpplayer_diec9	] {};
void()	mcpplayer_diec9	=	[	$deathc9,	mcpplayer_diec10] {};
void()	mcpplayer_diec10=	[	$deathc10,	mcpplayer_diec11] {};
void()	mcpplayer_diec11=	[	$deathc11,	mcpplayer_diec12] {};
void()	mcpplayer_diec12=	[	$deathc12,	mcpplayer_diec13] {};
void()	mcpplayer_diec13=	[	$deathc13,	mcpplayer_diec14] {};
void()	mcpplayer_diec14=	[	$deathc14,	mcpplayer_diec15] {};
void()	mcpplayer_diec15=	[	$deathc15,	mcpplayer_diec15 ] {mcp_EndDeathSeq();};

void()	mcpplayer_died1	=	[	$deathd1,	mcpplayer_died2	] {};
void()	mcpplayer_died2	=	[	$deathd2,	mcpplayer_died3	] {};
void()	mcpplayer_died3	=	[	$deathd3,	mcpplayer_died4	] {};
void()	mcpplayer_died4	=	[	$deathd4,	mcpplayer_died5	] {};
void()	mcpplayer_died5	=	[	$deathd5,	mcpplayer_died6	] {};
void()	mcpplayer_died6	=	[	$deathd6,	mcpplayer_died7	] {};
void()	mcpplayer_died7	=	[	$deathd7,	mcpplayer_died8	] {};
void()	mcpplayer_died8	=	[	$deathd8,	mcpplayer_died9	] {};
void()	mcpplayer_died9	=	[	$deathd9,	mcpplayer_died9	] {mcp_EndDeathSeq();};

void()	mcpplayer_diee1	=	[	$deathe1,	mcpplayer_diee2	] {};
void()	mcpplayer_diee2	=	[	$deathe2,	mcpplayer_diee3	] {};
void()	mcpplayer_diee3	=	[	$deathe3,	mcpplayer_diee4	] {};
void()	mcpplayer_diee4	=	[	$deathe4,	mcpplayer_diee5	] {};
void()	mcpplayer_diee5	=	[	$deathe5,	mcpplayer_diee6	] {};
void()	mcpplayer_diee6	=	[	$deathe6,	mcpplayer_diee7	] {};
void()	mcpplayer_diee7	=	[	$deathe7,	mcpplayer_diee8	] {};
void()	mcpplayer_diee8	=	[	$deathe8,	mcpplayer_diee9	] {};
void()	mcpplayer_diee9	=	[	$deathe9,	mcpplayer_diee9	] {mcp_EndDeathSeq();};

void()	mcpplayer_die_ax1	=	[$axdeth1,	mcpplayer_die_ax2] {};
void()	mcpplayer_die_ax2	=	[$axdeth2,	mcpplayer_die_ax3] {};
void()	mcpplayer_die_ax3	=	[$axdeth3,	mcpplayer_die_ax4] {};
void()	mcpplayer_die_ax4	=	[$axdeth4,	mcpplayer_die_ax5] {};
void()	mcpplayer_die_ax5	=	[$axdeth5,	mcpplayer_die_ax6] {};
void()	mcpplayer_die_ax6	=	[$axdeth6,	mcpplayer_die_ax7] {};
void()	mcpplayer_die_ax7	=	[$axdeth7,	mcpplayer_die_ax8] {};
void()	mcpplayer_die_ax8	=	[$axdeth8,	mcpplayer_die_ax9] {};
void()	mcpplayer_die_ax9	=	[$axdeth9,	mcpplayer_die_ax9] {mcp_EndDeathSeq();};


//============================================================================


void() mcpplayer_minigun1;


void mcpplayer_shootminigun(entity e) =
{
		local vector dirm;
		dirm = aim (e,100000.000);
		//AddStat(self, STAT_WEAPONFIRED, WPN_MINIGUN);
		deathmsg = MCPDEATH_MINIGUN;
		mcp_FireBullets (self,5,dirm,'0.04 0.04 0');
		mcp_Sound(e, CHAN_WEAPON, SND_SHOOTMINIGUN, 1, ATTN_NORM);
		e.mcpslot[mcp_GetSlotContaining(e,MCPWEAP_MINIGUN)].clipcount--;
		mcp_UpdateHudAmmo(e,MCPWEAP_MINIGUN);
		mcp_muzzleflash(e);
};

void() mcpplayer_minigundown = [$nailatt1, mcpplayer_minigundown]
{
	self.attack_finished = time + 0.1;

	if(time > self.mgun_spindownfinish)
	{
		self.mcpweapstate =  MCPWEAPSTATE_NONE;	
		if(self.mgun_queuereload == 1)
		{
			self.mgun_queuereload = 0;
			mcp_ReloadWeapon(self,MCPWEAP_MINIGUN);
		}
		mcpplayer_run();
		mcp_SetPlayerSpeed(self);
	}
	
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe >= 4)
		self.weaponframe = 1;
};

void mcpplayer_spindown(entity e) =
{
	mcp_Sound(e, CHAN_WEAPON, SND_MINIGUNSPINDOWN, 1, ATTN_NORM);
	e.mgun_spindownfinish = time + MINIGUN_SPINDOWNTIME;
	e.mcpweapstate =  MCPWEAPSTATE_SPINDOWN;		
	mcpplayer_minigundown();
};

void() mcpplayer_minigunup = [$nailatt1, mcpplayer_minigunup]
{	
	self.attack_finished = time + 0.1;
	
	if(time > self.mgun_spinupfinish)
	{
		self.mcpweapstate =  MCPWEAPSTATE_SPINNING;
		mcpplayer_minigun1();
	}
	
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe >= 4)
		self.weaponframe = 1;
};

void() mcpplayer_minigun1 = [$nailatt1, mcpplayer_minigun2]
{
	mcp_Sound(self, CHAN_WEAPON, SND_MINIGUNSPIN, 1, ATTN_NORM);
	self.attack_finished = time + 0.1;
	
	if(self.mcpslot[mcp_GetSlotContaining(self,MCPWEAP_MINIGUN)].clipcount <= 0)
		self.mgun_queuereload = 1;
	
	/*if((!self.button0 || self.mgun_queuereload == 1) && (self.mcpslot[self.qckslot].type != MCPWEAP_MINIGUN || self.qckslot == MCPSLOTNONE))
	{
		mcp_Sound(self, CHAN_WEAPON, SND_MINIGUNSPINDOWN, 1, ATTN_NORM);
		self.mgun_spindownfinish = time + MINIGUN_SPINDOWNTIME;
		self.mcpweapstate =  MCPWEAPSTATE_SPINDOWN;	
		mcpplayer_minigundown();
		return;
	}
	*/
	if(self.mgun_queuereload == 1)
	{
		mcpplayer_spindown(self);
		return;
	}
	if(mcp_GetQuickSlot(self) == MCPSLOTNONE)
	{
		if(self.mcpslot[self.weapon].type != MCPWEAP_MINIGUN || !self.button0)
		{
			mcpplayer_spindown(self);
			return;
		}
	}
	else
	{
		if(self.mcpslot[mcp_GetQuickSlot(self)].type != MCPWEAP_MINIGUN)
		{
			mcpplayer_spindown(self);
			return;
		}
	}
	
	
	//if(self.flags & FL_ONGROUND && vlen(self.velocity) <= 20)
	if(vlen(self.velocity) <= 20)
	{

		mcpplayer_shootminigun(self);
		self.weaponframe = 3;
		return;
	}
	
		self.weaponframe = self.weaponframe + 1;
		
	if (self.weaponframe >= 4)
		self.weaponframe = 1;
		
};

void() mcpplayer_minigun2 = [$nailatt2, mcpplayer_minigun1]
{
	mcp_Sound(self, CHAN_WEAPON, SND_MINIGUNSPIN, 1, ATTN_NORM);
	self.attack_finished = time + 0.1;
	
	if(self.mcpslot[mcp_GetSlotContaining(self,MCPWEAP_MINIGUN)].clipcount <= 0)
		self.mgun_queuereload = 1;
	
	/*if((!self.button0 || self.mgun_queuereload == 1) && (self.mcpslot[self.qckslot].type != MCPWEAP_MINIGUN || self.qckslot == MCPSLOTNONE))
	{
		mcp_Sound(self, CHAN_WEAPON, SND_MINIGUNSPINDOWN, 1, ATTN_NORM);
		self.mgun_spindownfinish = time + MINIGUN_SPINDOWNTIME;
		self.mcpweapstate =  MCPWEAPSTATE_SPINDOWN;	
		mcpplayer_minigundown();
		return;
	}
	*/
	if(self.mgun_queuereload == 1)
	{
		mcpplayer_spindown(self);
		return;
	}
	if(mcp_GetQuickSlot(self) == MCPSLOTNONE)
	{
		if(self.mcpslot[self.weapon].type != MCPWEAP_MINIGUN || !self.button0)
		{
			mcpplayer_spindown(self);
			return;
		}
	}
	else
	{
		if(self.mcpslot[mcp_GetQuickSlot(self)].type != MCPWEAP_MINIGUN)
		{
			mcpplayer_spindown(self);
			return;
		}
	}
	
	//if(self.flags & FL_ONGROUND && vlen(self.velocity) <= 20)
	if(vlen(self.velocity) <= 20)
	{
		mcpplayer_shootminigun(self);
		self.weaponframe = 4;
		return;
	}

	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe >= 4)
		self.weaponframe = 1;
		

};

void() mcpplayer_flamer1   =[$nailatt1, mcpplayer_flamer2  ] 
{
	
	if(mcp_GetQuickSlot(self) == MCPSLOTNONE)
	{	
		if(self.mcpslot[self.weapon].type != MCPWEAP_FLAMER || !self.button0)
		{
			mcpplayer_run();
			return;
		}
	}
	else
	{
		if(self.mcpslot[mcp_GetQuickSlot(self)].type != MCPWEAP_FLAMER)
		{
			mcpplayer_run();
			return;
		}
	}

		self.weaponframe = self.weaponframe + 1;
		if (self.weaponframe == 3)
			self.weaponframe = 1;

		mcp_muzzleflash(self);
		mcp_ShootFlamer (self);

		if(self.mcpslot[mcp_GetSlotContaining(self, MCPWEAP_FLAMER)].clipcount <= 0)
		{
			mcpplayer_run ();
			mcp_ReloadWeapon(self,MCPWEAP_FLAMER);
		}

};
void() mcpplayer_flamer2   =[$nailatt2, mcpplayer_flamer1  ]
{
	if(mcp_GetQuickSlot(self) == MCPSLOTNONE)
	{	
		if(self.mcpslot[self.weapon].type != MCPWEAP_FLAMER || !self.button0)
		{
			mcpplayer_run();
			return;
		}
	}
	else
	{
		if(self.mcpslot[mcp_GetQuickSlot(self)].type != MCPWEAP_FLAMER)
		{
			mcpplayer_run();
			return;
		}
	}
	
		self.weaponframe = self.weaponframe + 1;
		if (self.weaponframe == 3)
			self.weaponframe = 1;
			
		mcp_muzzleflash(self);
		mcp_ShootFlamer(self);

		if(self.mcpslot[mcp_GetSlotContaining(self, MCPWEAP_FLAMER)].clipcount <= 0)
		{
			mcpplayer_run ();
			mcp_ReloadWeapon(self,MCPWEAP_FLAMER);
		}
};

void() mcpplayer_nail1   =[$nailatt1, mcpplayer_nail2  ] 
{
	
	if(mcp_GetQuickSlot(self) == MCPSLOTNONE)
	{	
		if(self.mcpslot[self.weapon].type != MCPWEAP_SNG || !self.button0)
		{
			mcpplayer_run();
			return;
		}
	}
	else
	{
		if(self.mcpslot[mcp_GetQuickSlot(self)].type != MCPWEAP_SNG)
		{
			mcpplayer_run();
			return;
		}
	}

		self.weaponframe = self.weaponframe + 1;
		if (self.weaponframe == 9)
			self.weaponframe = 1;

		mcp_muzzleflash(self);
		mcp_ShootNail (self);

		if(self.mcpslot[mcp_GetSlotContaining(self, MCPWEAP_SNG)].clipcount <= 0)
		{
			mcpplayer_run ();
			mcp_ReloadWeapon(self,MCPWEAP_SNG);
		}

};
void() mcpplayer_nail2   =[$nailatt2, mcpplayer_nail1  ]
{
	if(mcp_GetQuickSlot(self) == MCPSLOTNONE)
	{	
		if(self.mcpslot[self.weapon].type != MCPWEAP_SNG || !self.button0)
		{
			mcpplayer_run();
			return;
		}
	}
	else
	{
		if(self.mcpslot[mcp_GetQuickSlot(self)].type != MCPWEAP_SNG)
		{
			mcpplayer_run();
			return;
		}
	}
	
		self.weaponframe = self.weaponframe + 1;
		if (self.weaponframe == 9)
			self.weaponframe = 1;
			
		mcp_muzzleflash(self);
		mcp_ShootNail(self);

		if(self.mcpslot[mcp_GetSlotContaining(self, MCPWEAP_SNG)].clipcount <= 0)
		{
			mcpplayer_run ();
			mcp_ReloadWeapon(self,MCPWEAP_SNG);
		}
};


void() mcpplayer_light1   =[$light1, mcpplayer_light2  ] 
{
	if(mcp_GetQuickSlot(self) == MCPSLOTNONE)
	{	
		if(self.mcpslot[self.weapon].type != MCPWEAP_SHAFT || !self.button0)
		{
			mcpplayer_run();
			return;
		}
	}
	else
	{
		if(self.mcpslot[mcp_GetQuickSlot(self)].type != MCPWEAP_SHAFT)
		{
			mcpplayer_run();
			return;
		}
	}

	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 5)
		self.weaponframe = 1;
	mcp_muzzleflash(self);
	mcp_ShootShaft(self);
	self.attack_finished = time + 0.2;
	
	self.mcpslot[mcp_GetSlotContaining(self, MCPWEAP_SHAFT)].clipcount--;
	mcp_UpdateHudAmmo(self,MCPWEAP_SHAFT);
	if(self.mcpslot[mcp_GetSlotContaining(self, MCPWEAP_SHAFT)].clipcount <= 0)
	{
		mcpplayer_run ();
		mcp_ReloadWeapon(self,MCPWEAP_SHAFT);
	}
};
void() mcpplayer_light2   =[$light2, mcpplayer_light1  ]
{
	if(mcp_GetQuickSlot(self) == MCPSLOTNONE)
	{	
		if(self.mcpslot[self.weapon].type != MCPWEAP_SHAFT || !self.button0)
		{
			mcpplayer_run();
			return;
		}
	}
	else
	{
		if(self.mcpslot[mcp_GetQuickSlot(self)].type != MCPWEAP_SHAFT)
		{
			mcpplayer_run();
			return;
		}
	}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 5)
		self.weaponframe = 1;
		mcp_muzzleflash(self);
	mcp_ShootShaft(self);
	self.attack_finished = time + 0.2;

	self.mcpslot[mcp_GetSlotContaining(self, MCPWEAP_SHAFT)].clipcount--;
	mcp_UpdateHudAmmo(self,MCPWEAP_SHAFT);
	if(self.mcpslot[mcp_GetSlotContaining(self, MCPWEAP_SHAFT)].clipcount <= 0)
	{
		mcpplayer_run ();
		mcp_ReloadWeapon(self,MCPWEAP_SHAFT);
	}
};
void() mcpplayer_unlimlight1   =[$light1, mcpplayer_unlimlight2  ] 
{
	if(mcp_GetQuickSlot(self) == MCPSLOTNONE)
	{	
		if(!self.button0 || self.mcpslot[self.weapon].type != MCPWEAP_SHAFTUNLIM)
		{
			mcpplayer_run();
			return;
		}
	}
	else
	{
		if(self.mcpslot[mcp_GetQuickSlot(self)].type != MCPWEAP_SHAFTUNLIM)
		{
			mcpplayer_run();
			return;
		}
	}

	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 5)
		self.weaponframe = 1;
	mcp_muzzleflash(self);
	mcp_ShootShaft(self);
	self.attack_finished = time + 0.2;

	mcp_UpdateHudAmmo(self,MCPWEAP_SHAFTUNLIM);

};
void() mcpplayer_unlimlight2   =[$light2, mcpplayer_unlimlight1  ]
{
	if(mcp_GetQuickSlot(self) == MCPSLOTNONE)
	{	
		if(!self.button0 || self.mcpslot[self.weapon].type != MCPWEAP_SHAFTUNLIM)
		{
			mcpplayer_run();
			return;
		}
	}
	else
	{
		if(self.mcpslot[mcp_GetQuickSlot(self)].type != MCPWEAP_SHAFTUNLIM)
		{
			mcpplayer_run();
			return;
		}
	}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 5)
		self.weaponframe = 1;
	mcp_muzzleflash(self);
	mcp_ShootShaft(self);
	self.attack_finished = time + 0.2;

	mcp_UpdateHudAmmo(self,MCPWEAP_SHAFTUNLIM);

};



