
$cd id1/models/demon3
$scale	0.8
$origin 0 0 24
$base base
$skin base

$frame fstand1 fstand2 fstand3 fstand4 fstand5 fstand6 fstand7 fstand8 fstand9
$frame fstand10 fstand11 fstand12 fstand13

$frame fwalk1 fwalk2 fwalk3 fwalk4 fwalk5 fwalk6 fwalk7 fwalk8

$frame frun1 frun2 frun3 frun4 frun5 frun6

$frame leap1 leap2 leap3 leap4 leap5 leap6 leap7 leap8 leap9 leap10
$frame leap11 leap12

$frame pain1 pain2 pain3 pain4 pain5 pain6

$frame fdeath1 fdeath2 fdeath3 fdeath4 fdeath5 fdeath6 fdeath7 fdeath8 fdeath9

$frame attacka1 attacka2 attacka3 attacka4 attacka5 attacka6 attacka7 attacka8
$frame attacka9 attacka10 attacka11 attacka12 attacka13 attacka14 attacka15


void () mcpfiend_run;

void()  mcpfiend_stand1 = [       $fstand1,       mcpfiend_stand1   ]
{
	self.weaponframe=0;
	if (self.velocity_x || self.velocity_y)
	{
		self.walkframe=0;
		mcpfiend_run();
		return;
	}


		if (self.walkframe >= 13)
			self.walkframe = 0;
		self.frame = $fstand1 + self.walkframe;
	
	self.walkframe = self.walkframe + 1;    
};


void()  mcpfiend_run =[   $frun1,      mcpfiend_run      ]
{
	self.weaponframe=0;
	if (!self.velocity_x && !self.velocity_y)
	{
		self.walkframe=0;
		mcpfiend_stand1();
		return;
	}

	
	
	if (self.walkframe >= 6)
		self.walkframe = 0;
	self.frame = $frun1 + self.walkframe;
	
	self.walkframe = self.walkframe + 1;
	
	if(fabs(self.velocity_x) > 100 || fabs(self.velocity_y) > 100)
	{
		if(self.flags & FL_ONGROUND && self.waterlevel == 0 && self.iscloaked == 0)
		{
			if(time >= self.lastfootstep && self.deadflag == DEAD_NO)
			{
				local float rng = RNG(2);
				local string fstep = SND_FIENDJUMP;
				if(rng == 1)
					fstep = SND_FIENDJUMP;
				else
					fstep = SND_FIENDJUMP;

				mcp_Sound(self, CHAN_VOICE, fstep, 1, ATTN_NORM);
				self.lastfootstep = time + FOOTSTEPSOUNDINTERVAL;
			}
		}
	}
};

void() mcpfiend_PainSound =
{

	if (self.health < 0)
		return;

	if (damage_attacker.classname == "teledeath")
	{
		mcp_Sound (self, CHAN_VOICE, "player/teledth1.wav", 1, ATTN_NONE);
		return;
	}

	// water pain sounds
	if (self.watertype == CONTENT_WATER && self.waterlevel == 3)
	{
		mcp_DeathBubbles(self,1);
		if(mcpmode == MCPMODE_BABYFIEND)
			mcp_Sound (self, CHAN_VOICE, SND_BABYFIEND_PAIN, 1, ATTN_NORM);
		else
			mcp_Sound (self, CHAN_VOICE, SND_DPAIN1, 1, ATTN_NORM);
		return;
	}

	// slime pain sounds
	if (self.watertype == CONTENT_SLIME)
	{
		if(mcpmode == MCPMODE_BABYFIEND)
			mcp_Sound (self, CHAN_VOICE, SND_BABYFIEND_PAIN, 1, ATTN_NORM);
		else
			mcp_Sound (self, CHAN_VOICE, SND_DPAIN1, 1, ATTN_NORM);
		return;
	}

	if (self.watertype == CONTENT_LAVA)
	{
		if(mcpmode == MCPMODE_BABYFIEND)
			mcp_Sound (self, CHAN_VOICE, SND_BABYFIEND_PAIN, 1, ATTN_NORM);
		else
			mcp_Sound (self, CHAN_VOICE, SND_DPAIN1, 1, ATTN_NORM);
		return;
	}

	if (self.pain_finished > time)
	{
		self.axhitme = 0;
		return;
	}
	self.pain_finished = time + 0.5;

	local float rng = RNG(3);
	if (rng == 1)
	{
		if(mcpmode == MCPMODE_BABYFIEND)
			mcp_Sound(self,CHAN_VOICE, SND_BABYFIEND_PAIN, 1, ATTN_NORM);
		else 
			mcp_Sound (self, CHAN_VOICE, SND_DPAIN1, 1, ATTN_NORM);
	}
	if (rng == 2)
	{
		if(mcpmode == MCPMODE_BABYFIEND)
			mcp_Sound(self,CHAN_VOICE, SND_BABYFIEND_SIGHT, 1, ATTN_NORM);
		else 
			mcp_Sound (self, CHAN_VOICE, SND_DSIGHT2, 1, ATTN_NORM);
	}
	if (rng == 3)
	{
		if(mcpmode == MCPMODE_BABYFIEND)
			mcp_Sound(self,CHAN_VOICE, SND_BABYFIEND_IDLE, 1, ATTN_NORM);
		else 
			mcp_Sound (self, CHAN_VOICE, SND_DIDLE1, 1, ATTN_NORM);
	}
	return;

};

void()  mcpfiend_pain1 =  [       $pain1, mcpfiend_pain2    ] {self.weaponframe=0;};
void()  mcpfiend_pain2 =  [       $pain2, mcpfiend_pain3    ] {};
void()  mcpfiend_pain3 =  [       $pain3, mcpfiend_pain4    ] {};
void()  mcpfiend_pain4 =  [       $pain4, mcpfiend_pain5    ] {};
void()  mcpfiend_pain5 =  [       $pain5, mcpfiend_pain6    ] {};
void()  mcpfiend_pain6 =  [       $pain6, mcpfiend_run      ] {};


void() mcpfiend_pain =
{
	if (self.weaponframe)
		return;

	if (random() > 0.5)
	{
		mcpfiend_pain1 ();
	}	
	mcpfiend_PainSound();
	
};

void()  mcpfiend_spit1 =   [$pain6,  mcpfiend_spit2 	 	] {self.weaponframe=1;};
void()  mcpfiend_spit2 =   [$pain5,  mcpfiend_spit3  		] {self.weaponframe=2;};
void()  mcpfiend_spit3 =   [$pain4,  mcpfiend_spit4  		] {self.weaponframe=3;};
void()  mcpfiend_spit4 =   [$pain5,  mcpfiend_spit5  		] {self.weaponframe=4;};
void()  mcpfiend_spit5 =   [$pain6,  mcpfiend_run		] {self.weaponframe=5;};


void() mcpfiend_leap1 = 	[$leap1, mcpfiend_leap2 	] {self.weaponframe=13;};
void() mcpfiend_leap2 = 	[$leap2, mcpfiend_leap3 	] {self.weaponframe=12;};
void() mcpfiend_leap3 = 	[$leap3, mcpfiend_leap10	] {self.weaponframe=11;};
//void() playerfiend_leap4 = 	[$leap4, playerfiend_leap4 ] {self.weaponframe=4;};
//void() playerfiend_leap5 = 	[$leap5, playerfiend_leap6 ] {self.weaponframe=5;};
//void() playerfiend_leap6 = 	[$leap6, playerfiend_leap7 ] {self.weaponframe=6;};
//void() playerfiend_leap7 = 	[$leap7, playerfiend_leap8 ] {self.weaponframe=6;};
//void() playerfiend_leap8 = 	[$leap8, playerfiend_leap9 ] {self.weaponframe=6;};
//void() playerfiend_leap9 = 	[$leap9, playerfiend_leap10 ] {self.weaponframe=4;};
void() mcpfiend_leap10 = 	[$leap10, mcpfiend_leap11 	] {self.weaponframe=14;};
void() mcpfiend_leap11 = 	[$leap11, mcpfiend_leap12 	] {self.weaponframe=15;};
void() mcpfiend_leap12 = 	[$leap12, mcpfiend_run 		] {self.weaponframe=15;};

void()  mcpfiend_attl1 =    [$attacka1,  mcpfiend_attl2   	] {self.weaponframe=1;mcp_ShootFiendClaws(self);};
void()  mcpfiend_attl2 =    [$attacka2,  mcpfiend_attl3   	] {self.weaponframe=2;mcp_ShootFiendClaws(self);};
void()  mcpfiend_attl3 =    [$attacka3,  mcpfiend_attl4   	] {self.weaponframe=3;mcp_ShootFiendClaws(self);};
void()  mcpfiend_attl4 =    [$attacka4,  mcpfiend_attl5   	] {self.weaponframe=4;mcp_ShootFiendClaws(self);};
void()  mcpfiend_attl5 =    [$attacka5,  mcpfiend_attl6   	] {self.weaponframe=4;mcp_ShootFiendClaws(self);};
void()  mcpfiend_attl6 =    [$attacka6,  mcpfiend_attl7   	] {self.weaponframe=4;mcp_ShootFiendClaws(self);};
void()  mcpfiend_attl7 =    [$attacka7,  mcpfiend_attl8   	] {self.weaponframe=4;mcp_ShootFiendClaws(self);};
void()  mcpfiend_attl8 =    [$attacka8,  mcpfiend_run		] {self.weaponframe=4;mcp_ShootFiendClaws(self);};


/*
void()  playerfiend_att9 =    [$attacka9,  playerfiend_att10  ] {self.weaponframe=9;};
void()  playerfiend_att10 =   [$attacka10, playerfiend_att11  ] {self.weaponframe=10;};
void()  playerfiend_att11 =   [$attacka11, playerfiend_att12  ] {self.weaponframe=11;};
void()  playerfiend_att12 =   [$attacka12, playerfiend_att13  ] {self.weaponframe=12;};
void()  playerfiend_att13 =   [$attacka13, playerfiend_att14  ] {self.weaponframe=13;};
void()  playerfiend_att14 =   [$attacka14, playerfiend_att15  ] {self.weaponframe=14;};
void()  playerfiend_att15 =   [$attacka15, playerfiend_run  ] {self.weaponframe=4;};
*/

void()  mcpfiend_attr1 =   [$attacka8,  mcpfiend_attr2		] {self.weaponframe=1;mcp_ShootFiendClaws(self);};
void()  mcpfiend_attr2 =   [$attacka9,  mcpfiend_attr3  	] {self.weaponframe=6;mcp_ShootFiendClaws(self);};
void()  mcpfiend_attr3 =   [$attacka10, mcpfiend_attr4  	] {self.weaponframe=7;mcp_ShootFiendClaws(self);};
void()  mcpfiend_attr4 =   [$attacka11, mcpfiend_attr5  	] {self.weaponframe=8;mcp_ShootFiendClaws(self);};
void()  mcpfiend_attr5 =   [$attacka12, mcpfiend_attr6  	] {self.weaponframe=8;mcp_ShootFiendClaws(self);};
void()  mcpfiend_attr6 =   [$attacka13, mcpfiend_attr7  	] {self.weaponframe=8;mcp_ShootFiendClaws(self);};
void()  mcpfiend_attr7 =   [$attacka14, mcpfiend_attr8  	] {self.weaponframe=8;mcp_ShootFiendClaws(self);};
void()  mcpfiend_attr8 =   [$attacka15, mcpfiend_run    	] {self.weaponframe=8;mcp_ShootFiendClaws(self);};



void()  mcpfiend_spitl1 =    [$attacka1,  mcpfiend_spitl2	] {self.weaponframe=1;};
void()  mcpfiend_spitl2 =    [$attacka2,  mcpfiend_spitl3   	] {self.weaponframe=2;};
void()  mcpfiend_spitl3 =    [$attacka3,  mcpfiend_spitl4   	] {self.weaponframe=3;};
void()  mcpfiend_spitl4 =    [$attacka4,  mcpfiend_spitl5   	] {self.weaponframe=4;};
void()  mcpfiend_spitl5 =    [$attacka5,  mcpfiend_spitl6   	] {self.weaponframe=5;};
void()  mcpfiend_spitl6 =    [$attacka6,  mcpfiend_spitl7   	] {self.weaponframe=6;};
void()  mcpfiend_spitl7 =    [$attacka7,  mcpfiend_spitl8   	] {self.weaponframe=7;};
void()  mcpfiend_spitl8 =    [$attacka8,  mcpfiend_run     	] {self.weaponframe=7;};

void()  mcpfiend_spitr1 =   [$attacka8,  mcpfiend_spitr2  	] {self.weaponframe=1;};
void()  mcpfiend_spitr2 =   [$attacka9,  mcpfiend_spitr3  	] {self.weaponframe=2;};
void()  mcpfiend_spitr3 =   [$attacka10, mcpfiend_spitr4  	] {self.weaponframe=3;};
void()  mcpfiend_spitr4 =   [$attacka11, mcpfiend_spitr5  	] {self.weaponframe=4;};
void()  mcpfiend_spitr5 =   [$attacka12, mcpfiend_spitr6  	] {self.weaponframe=5;};
void()  mcpfiend_spitr6 =   [$attacka13, mcpfiend_spitr7  	] {self.weaponframe=6;};
void()  mcpfiend_spitr7 =   [$attacka14, mcpfiend_spitr8  	] {self.weaponframe=7;};
void()  mcpfiend_spitr8 =   [$attacka15, mcpfiend_run    	] {self.weaponframe=8;};


void()  mcpfiend_die1  =       [       $fdeath1,       mcpfiend_die2  ] {};
void()  mcpfiend_die2  =       [       $fdeath2,       mcpfiend_die3  ] {};
void()  mcpfiend_die3  =       [       $fdeath3,       mcpfiend_die4  ] {};
void()  mcpfiend_die4  =       [       $fdeath4,       mcpfiend_die5  ] {};
void()  mcpfiend_die5   =      [       $fdeath5,      mcpfiend_die6  ] {};
void()  mcpfiend_die6  =       [       $fdeath6,       mcpfiend_die7  ] {};
void()  mcpfiend_die7  =       [       $fdeath7,       mcpfiend_die8  ] {};
void()  mcpfiend_die8  =       [       $fdeath8,       mcpfiend_die9  ] {};
void()  mcpfiend_die9  =       [       $fdeath9,       mcpfiend_die9  ] {mcp_EndDeathSeq();};

