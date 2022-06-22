typedef struct 
{
	float type;
	float clipcount;
	float quickshotstart;
} SlotInfoStruct;
.SlotInfoStruct mcpslot[4];

typedef struct
{
	float menuoption;
	float modevotes;
	float mapvotes;
	string modestring;	
	string mapstring;	
	float modetype;		
	float maprng;		
} VoteChoiceStruct;
VoteChoiceStruct VOTECHOICE[10]; 

typedef struct
{
	float ownedbyteam;
	float redprogress;
	float blueprogress;
	float progressneeded;
	float radius;
	string namestring;
	float bluesonpoint;
	float redsonpoint;
	vector origin;
	float isunlocked;
} ControlPointStruct;
ControlPointStruct CONTROLPOINT[5];

.entity cprinter;
.entity mcpgren;
.float team_loser;
float mcpmode;
float matchstate;
float redscore;
float bluescore;
entity mcpgoal;
entity mcpgm;
float mcpplayerdims;
float mapisviable;
float redattcp;
float reddefcp;
float blueattcp;
float bluedefcp;

.float mcpclientdim;
.float mcpweapstate;
.float mgun_spindownfinish;
.float mgun_spinupfinish;
.float mgun_queuereload;
.float reloadingweapon;
.float lastslot;
.float reconshotgunjumps;
.float iscloaked;
.float nextregen;
.float hasbeenmidaired;
.float mcpgrentype;
.float nextmcpgrentype;
.float mcpspecialtype;
.float mcpgrencount;
.float fiendmeleehit;


entity multi_ent;
float multi_damage;
vector blood_org;
float blood_count;
vector puff_org;
float puff_count;
float modelindex_player;

void think_mcpdelayedmcpgm() =
{
	mcp_SpawnMCPGM();
	self.nextthink = time;
	self.think = SUB_Remove;	
};
void mcp_SpawnDelayedMCPGM() =
{
	local entity te = spawn();
	te.nextthink = time + 2;
	te.think = think_mcpdelayedmcpgm;
};

void mcp_worldspawn() = 
{
	mcp_PreCache();
	mcp_SpawnDelayedMCPGM();
};