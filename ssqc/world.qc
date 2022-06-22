
void () main = {
    dprint("main function\n");
    precache_file("progs.dat");
    precache_file("gfx.wad");
    precache_file("quake.rc");
    precache_file("default.cfg");
    precache_file("gfx/palette.lmp");
    precache_file("gfx/colormap.lmp");
    precache_file2("gfx/pop.lmp");
    precache_file("gfx/complete.lmp");
    precache_file("gfx/inter.lmp");
    precache_file("gfx/ranking.lmp");
    precache_file("gfx/vidmodes.lmp");
    precache_file("gfx/finale.lmp");
    precache_file("gfx/conback.lmp");
    precache_file("gfx/qplaque.lmp");
    precache_file("gfx/menudot1.lmp");
    precache_file("gfx/menudot2.lmp");
    precache_file("gfx/menudot3.lmp");
    precache_file("gfx/menudot4.lmp");
    precache_file("gfx/menudot5.lmp");
    precache_file("gfx/menudot6.lmp");
    precache_file("gfx/menuplyr.lmp");
    precache_file("gfx/bigbox.lmp");
    precache_file("gfx/dim_modm.lmp");
    precache_file("gfx/dim_drct.lmp");
    precache_file("gfx/dim_ipx.lmp");
    precache_file("gfx/dim_tcp.lmp");
    precache_file("gfx/dim_mult.lmp");
    precache_file("gfx/mainmenu.lmp");
    precache_file("gfx/box_tl.lmp");
    precache_file("gfx/box_tm.lmp");
    precache_file("gfx/box_tr.lmp");
    precache_file("gfx/box_ml.lmp");
    precache_file("gfx/box_mm.lmp");
    precache_file("gfx/box_mm2.lmp");
    precache_file("gfx/box_mr.lmp");
    precache_file("gfx/box_bl.lmp");
    precache_file("gfx/box_bm.lmp");
    precache_file("gfx/box_br.lmp");
    precache_file("gfx/sp_menu.lmp");
    precache_file("gfx/ttl_sgl.lmp");
    precache_file("gfx/ttl_main.lmp");
    precache_file("gfx/ttl_cstm.lmp");
    precache_file("gfx/mp_menu.lmp");
    precache_file("gfx/netmen1.lmp");
    precache_file("gfx/netmen2.lmp");
    precache_file("gfx/netmen3.lmp");
    precache_file("gfx/netmen4.lmp");
    precache_file("gfx/netmen5.lmp");
    precache_file("gfx/sell.lmp");
    precache_file("gfx/help0.lmp");
    precache_file("gfx/help1.lmp");
    precache_file("gfx/help2.lmp");
    precache_file("gfx/help3.lmp");
    precache_file("gfx/help4.lmp");
    precache_file("gfx/help5.lmp");
    precache_file("gfx/pause.lmp");
    precache_file("gfx/loading.lmp");
    precache_file("gfx/p_option.lmp");
    precache_file("gfx/p_load.lmp");
    precache_file("gfx/p_save.lmp");
    precache_file("gfx/p_multi.lmp");

};

entity lastspawn;

// use this for post world being setup (and entities loaded)


void () worldspawn = 
{
	//if(infokey(world,"mcpuffin") == "1")
	//{
		mcpenabled = 1;
		mcp_worldspawn();
		return;
	//}
};

void () StartFrame = {
    teamplay = cvar("teamplay");
    timelimit = cvar("timelimit") * 60;
    fraglimit = cvar("fraglimit");
    deathmatch = cvar("deathmatch");
    framecount = framecount + 1;
    
	if(mcpenabled)
		return;
		
    if (framecount % 77 == 0)
    {
       // CheckTrackedSettings();
    }

    
//    if(!votemode) {
//        //TODO: make this optional
//        Vote_Check();
//    }
};

