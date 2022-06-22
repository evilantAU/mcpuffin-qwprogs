float (entity targ, entity inflictor) CanDamage = {
    if (targ.movetype == MOVETYPE_PUSH) {

        traceline(inflictor.origin, 0.5 * (targ.absmin + targ.absmax),
                  TRUE, self);
        if (trace_fraction == 1)
            return (TRUE);
        if (trace_ent == targ)
            return (TRUE);
        return (FALSE);
    }

    traceline(inflictor.origin, targ.origin, TRUE, self);
    if (trace_fraction == 1)
        return (TRUE);
    traceline(inflictor.origin, targ.origin + '15 15 0', TRUE, self);
    if (trace_fraction == 1)
        return (TRUE);
    traceline(inflictor.origin, targ.origin + '-15 -15 0', TRUE, self);
    if (trace_fraction == 1)
        return (TRUE);
    traceline(inflictor.origin, targ.origin + '-15 15 0', TRUE, self);
    if (trace_fraction == 1)
        return (TRUE);
    traceline(inflictor.origin, targ.origin + '15 -15 0', 1, self);
    if (trace_fraction == 1)
        return (TRUE);
    return (FALSE);
};


void (entity targ, entity inflictor, entity attacker,
      float damage) T_Damage = {
    local vector dir;
    local entity oldself, te;
    local float save;
    local float take;
    
	if(mcpenabled)
	{
		mcp_Damage(targ, inflictor, attacker, damage);
		return;
	}

};

void (entity targ, entity inflictor, entity attacker, float damage,
      float T_flags, float T_AttackType) TF_T_Damage = {
    local vector dir;
    local entity oldself;
    local entity te;
    local float save;
    local float take;
    local float olddmsg;
    local float no_damage;
    local float moment;

	if(mcpenabled)
	{
		mcp_Damage(targ, inflictor, attacker, damage);
		return;
	}
};

