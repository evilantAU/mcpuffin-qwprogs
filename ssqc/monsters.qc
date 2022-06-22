float (entity targ) visible = {
    local vector spot1, spot2;

    spot1 = self.origin + self.view_ofs;
    spot2 = targ.origin + targ.view_ofs;
    traceline(spot1, spot2, 1, self);
    if (trace_inopen && trace_inwater)
        return (FALSE);

    if (trace_fraction == 1)
        return (TRUE);

    return (FALSE);
};

void () monster_ogre = {
    remove(self);
};

void () monster_knight = {
    remove(self);
};

void () monster_shambler = {
    remove(self);
};

void () monster_demon1 = {
    remove(self);
};

void () monster_wizard = {
    remove(self);
};

void () monster_zombie = {
    remove(self);
};

void () monster_dog = {
    remove(self);
};

void () monster_hell_knight = {
    remove(self);
};

void () monster_tarbaby = {
    remove(self);
};

void () monster_vomit = {
    remove(self);
};

void () monster_enforcer = {
    remove(self);
};

void () monster_shalrath = {
    remove(self);
};

void () monster_dragon = {
    remove(self);
};

void () monster_army = {
    remove(self);
};

void () t_movetarget;




/*
float (float v) anglemod = {
    while (v >= 360)
        v = v - 360;
    while (v < 0)
        v = v + 360;
    return (v);
};
*/
float (entity targ) range = {
    local vector spot1;
    local vector spot2;
    local float r;

    spot1 = self.origin + self.view_ofs;
    spot2 = targ.origin + targ.view_ofs;

    r = vlen(spot1 - spot2);
    if (r < 120)
        return (RANGE_MELEE);

    if (r < 500)
        return (RANGE_NEAR);

    if (r < 1000)
        return (RANGE_MID);

    return (RANGE_FAR);
};

float (entity targ) infront = {
    local vector vec;
    local float dot;

    makevectors(self.angles);
    vec = normalize(targ.origin - self.origin);
    dot = vec * v_forward;
    if (dot > 0.3)
        return (1);
    return (0);
};

void () HuntTarget = {
    self.goalentity = self.enemy;
    self.think = self.th_run;
    self.ideal_yaw = vectoyaw(self.enemy.origin - self.origin);
    self.nextthink = time + 0.1;
    SUB_AttackFinished(1);
};

float () FindTarget = {
    local entity client;

    client = checkclient();
    if (!client)
        return (FALSE);

    if (client.flags & FL_NOTARGET)
        return (FALSE);

    if (client.items & IT_INVISIBILITY)
        return (FALSE);

    if (!visible(client))
        return (FALSE);

    if (client.classname != "player")
        return (FALSE);

    self.enemy = client;
    HuntTarget();
    return (TRUE);
};
