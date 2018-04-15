--painful file to create will all ttt cvars

local function updateCVarsForTTT2ULX()
    for _, v in pairs(ROLES) do
        if v ~= ROLES.INNOCENT then
            ULib.replicatedWritableCvar("ttt_" .. v.name .. "_pct", "rep_ttt_" .. v.name .. "_pct", GetConVar("ttt_" .. v.name .. "_pct"):GetInt(), false, false, "xgui_gmsettings")
            ULib.replicatedWritableCvar("ttt_" .. v.name .. "_max", "rep_ttt_" .. v.name .. "_max", GetConVar("ttt_" .. v.name .. "_max"):GetInt(), false, false, "xgui_gmsettings")
            
            if v ~= ROLES.TRAITOR then
                ULib.replicatedWritableCvar("ttt_" .. v.name .. "_min_players", "rep_ttt_" .. v.name .. "_min_players", GetConVar("ttt_" .. v.name .. "_min_players"):GetInt(), false, false, "xgui_gmsettings")
                
                if ConVarExists("ttt_" .. v.name .. "_karma_min") then
                    ULib.replicatedWritableCvar("ttt_" .. v.name .. "_karma_min", "rep_ttt_" .. v.name .. "_karma_min", GetConVar("ttt_" .. v.name .. "_karma_min"):GetInt(), false, false, "xgui_gmsettings")
                end
            
                --roles credits
                if ConVarExists("ttt_" .. v.abbr .. "_credits_starting") then
                    ULib.replicatedWritableCvar("ttt_" .. v.abbr .. "_credits_starting", "rep_ttt_" .. v.abbr .. "_credits_starting", GetConVar("ttt_" .. v.abbr .. "_credits_starting"):GetInt(), false, false, "xgui_gmsettings")
                end
                
                if ConVarExists("ttt_" .. v.abbr .. "_credits_traitorkill") then
                    ULib.replicatedWritableCvar("ttt_" .. v.abbr .. "_credits_traitorkill", "rep_ttt_" .. v.abbr .. "_credits_traitorkill", GetConVar("ttt_" .. v.abbr .. "_credits_traitorkill"):GetInt(), false, false, "xgui_gmsettings")
                end
                
                if ConVarExists("ttt_" .. v.abbr .. "_credits_traitordead") then
                    ULib.replicatedWritableCvar("ttt_" .. v.abbr .. "_credits_traitordead", "rep_ttt_" .. v.abbr .. "_credits_traitordead", GetConVar("ttt_" .. v.abbr .. "_credits_traitordead"):GetInt(), false, false, "xgui_gmsettings")
                end
                
                ULib.replicatedWritableCvar("ttt_" .. v.name .. "_enabled", "rep_ttt_" .. v.name .. "_enabled", GetConVar("ttt_" .. v.name .. "_enabled"):GetInt(), false, false, "xgui_gmsettings")
            else
                --traitor credits
                ULib.replicatedWritableCvar("ttt_credits_starting", "rep_ttt_credits_starting", GetConVar("ttt_credits_starting"):GetInt(), false, false, "xgui_gmsettings")
                ULib.replicatedWritableCvar("ttt_credits_award_pct", "rep_ttt_credits_award_pct", GetConVar("ttt_credits_award_pct"):GetInt(), false, false, "xgui_gmsettings")
                ULib.replicatedWritableCvar("ttt_credits_award_size", "rep_ttt_credits_award_size", GetConVar("ttt_credits_award_size"):GetInt(), false, false, "xgui_gmsettings")
                ULib.replicatedWritableCvar("ttt_credits_award_repeat", "rep_ttt_credits_award_repeat", GetConVar("ttt_credits_award_repeat"):GetInt(), false, false, "xgui_gmsettings")
                ULib.replicatedWritableCvar("ttt_credits_detectivekill", "rep_ttt_credits_detectivekill", GetConVar("ttt_credits_detectivekill"):GetInt(), false, false, "xgui_gmsettings")
            end
        end
    end
end

local function init()
	if GetConVarString("gamemode") == "terrortown" then --Only execute the following code if it's a terrortown gamemode
        --Preparation and post-round
        ULib.replicatedWritableCvar("ttt_preptime_seconds", "rep_ttt_preptime_seconds", GetConVar("ttt_preptime_seconds"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_firstpreptime", "rep_ttt_firstpreptime", GetConVar("ttt_firstpreptime"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_posttime_seconds", "rep_ttt_posttime_seconds", GetConVar("ttt_posttime_seconds"):GetInt(), false, false, "xgui_gmsettings")           
    
        --Round length
        ULib.replicatedWritableCvar("ttt_haste", "rep_ttt_haste", GetConVar("ttt_haste"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_haste_starting_minutes", "rep_ttt_haste_starting_minutes", GetConVar("ttt_haste_starting_minutes"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_haste_minutes_per_death", "rep_ttt_haste_minutes_per_death", GetConVar("ttt_haste_minutes_per_death"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_roundtime_minutes", "rep_ttt_roundtime_minutes", GetConVar("ttt_roundtime_minutes"):GetInt(), false, false, "xgui_gmsettings")
        
        --map switching and voting
        ULib.replicatedWritableCvar("ttt_round_limit", "rep_ttt_round_limit", GetConVar("ttt_round_limit"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_time_limit_minutes", "rep_ttt_time_limit_minutes", GetConVar("ttt_time_limit_minutes"):GetInt(), false, false, "xgui_gmsettings")
        
        if ConVarExists("ttt_always_use_mapcycle") then
            ULib.replicatedWritableCvar("ttt_always_use_mapcycle", "rep_ttt_always_use_mapcycle", GetConVar("ttt_always_use_mapcycle"):GetInt(), false, false, "xgui_gmsettings")
        end
        
        if not ROLES then
            --traitor and detective counts
            ULib.replicatedWritableCvar("ttt_traitor_pct", "rep_ttt_traitor_pct", GetConVar("ttt_traitor_pct"):GetInt(), false, false, "xgui_gmsettings")
            ULib.replicatedWritableCvar("ttt_traitor_max", "rep_ttt_traitor_max", GetConVar("ttt_traitor_max"):GetInt(), false, false, "xgui_gmsettings")
            ULib.replicatedWritableCvar("ttt_detective_pct", "rep_ttt_detective_pct", GetConVar("ttt_detective_pct"):GetInt(), false, false, "xgui_gmsettings")
            ULib.replicatedWritableCvar("ttt_detective_max", "rep_ttt_detective_max", GetConVar("ttt_detective_max"):GetInt(), false, false, "xgui_gmsettings")
            ULib.replicatedWritableCvar("ttt_detective_min_players", "rep_ttt_detective_min_players", GetConVar("ttt_detective_min_players"):GetInt(), false, false, "xgui_gmsettings")
            ULib.replicatedWritableCvar("ttt_detective_karma_min", "rep_ttt_detective_karma_min", GetConVar("ttt_detective_karma_min"):GetInt(), false, false, "xgui_gmsettings")
        
            --traitor credits
            ULib.replicatedWritableCvar("ttt_credits_starting", "rep_ttt_credits_starting", GetConVar("ttt_credits_starting"):GetInt(), false, false, "xgui_gmsettings")
            ULib.replicatedWritableCvar("ttt_credits_award_pct", "rep_ttt_credits_award_pct", GetConVar("ttt_credits_award_pct"):GetInt(), false, false, "xgui_gmsettings")
            ULib.replicatedWritableCvar("ttt_credits_award_size", "rep_ttt_credits_award_size", GetConVar("ttt_credits_award_size"):GetInt(), false, false, "xgui_gmsettings")
            ULib.replicatedWritableCvar("ttt_credits_award_repeat", "rep_ttt_credits_award_repeat", GetConVar("ttt_credits_award_repeat"):GetInt(), false, false, "xgui_gmsettings")
            ULib.replicatedWritableCvar("ttt_credits_detectivekill", "rep_ttt_credits_detectivekill", GetConVar("ttt_credits_detectivekill"):GetInt(), false, false, "xgui_gmsettings")
            
            --detective credits
            ULib.replicatedWritableCvar("ttt_det_credits_starting", "rep_ttt_det_credits_starting", GetConVar("ttt_det_credits_starting"):GetInt(), false, false, "xgui_gmsettings")
            ULib.replicatedWritableCvar("ttt_det_credits_traitorkill", "rep_ttt_det_credits_traitorkill", GetConVar("ttt_det_credits_traitorkill"):GetInt(), false, false, "xgui_gmsettings")
            ULib.replicatedWritableCvar("ttt_det_credits_traitordead", "rep_ttt_det_credits_traitordead", GetConVar("ttt_det_credits_traitordead"):GetInt(), false, false, "xgui_gmsettings")  
        else
            updateCVarsForTTT2ULX()
        end
        
        --dna
        ULib.replicatedWritableCvar("ttt_killer_dna_range", "rep_ttt_killer_dna_range", GetConVar("ttt_killer_dna_range"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_killer_dna_basetime", "rep_ttt_killer_dna_basetime", GetConVar("ttt_killer_dna_basetime"):GetInt(), false, false, "xgui_gmsettings")
        
        --voicechat battery
        ULib.replicatedWritableCvar("ttt_voice_drain", "rep_ttt_voice_drain", GetConVar("ttt_voice_drain"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_voice_drain_normal", "rep_ttt_voice_drain_normal", GetConVar("ttt_voice_drain_normal"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_voice_drain_admin", "rep_ttt_voice_drain_admin", GetConVar("ttt_voice_drain_admin"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_voice_drain_recharge", "rep_ttt_voice_drain_recharge", GetConVar("ttt_voice_drain_recharge"):GetInt(), false, false, "xgui_gmsettings")
        
        --other gameplay settings
        ULib.replicatedWritableCvar("ttt_newroles_enabled", "rep_ttt_newroles_enabled", GetConVar("ttt_newroles_enabled"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_minimum_players", "rep_ttt_minimum_players", GetConVar("ttt_minimum_players"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_postround_dm", "rep_ttt_postround_dm", GetConVar("ttt_postround_dm"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_dyingshot", "rep_ttt_dyingshot", GetConVar("ttt_dyingshot"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_no_nade_throw_during_prep", "rep_ttt_no_nade_throw_during_prep", GetConVar("ttt_no_nade_throw_during_prep"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_weapon_carrying", "rep_ttt_weapon_carrying", GetConVar("ttt_weapon_carrying"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_weapon_carrying_range", "rep_ttt_weapon_carrying_range", GetConVar("ttt_weapon_carrying_range"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_teleport_telefrags", "rep_ttt_teleport_telefrags", GetConVar("ttt_teleport_telefrags"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_ragdoll_pinning", "rep_ttt_ragdoll_pinning", GetConVar("ttt_ragdoll_pinning"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_ragdoll_pinning_innocents", "rep_ttt_ragdoll_pinning_innocents", GetConVar("ttt_ragdoll_pinning_innocents"):GetInt(), false, false, "xgui_gmsettings")
        
        --karma
        ULib.replicatedWritableCvar("ttt_karma", "rep_ttt_karma", GetConVar("ttt_karma"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_karma_strict", "rep_ttt_karma_strict", GetConVar("ttt_karma_strict"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_karma_starting", "rep_ttt_karma_starting", GetConVar("ttt_karma_starting"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_karma_max", "rep_ttt_karma_max", GetConVar("ttt_karma_max"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_karma_ratio", "rep_ttt_karma_ratio", GetConVar("ttt_karma_ratio"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_karma_kill_penalty", "rep_ttt_karma_kill_penalty", GetConVar("ttt_karma_kill_penalty"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_karma_round_increment", "rep_ttt_karma_round_increment", GetConVar("ttt_karma_round_increment"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_karma_clean_bonus", "rep_ttt_karma_clean_bonus", GetConVar("ttt_karma_clean_bonus"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_karma_traitordmg_ratio", "rep_ttt_karma_traitordmg_ratio", GetConVar("ttt_karma_traitordmg_ratio"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_karma_traitorkill_bonus", "rep_ttt_karma_traitorkill_bonus", GetConVar("ttt_karma_traitorkill_bonus"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_karma_low_autokick", "rep_ttt_karma_low_autokick", GetConVar("ttt_karma_low_autokick"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_karma_low_amount", "rep_ttt_karma_low_amount", GetConVar("ttt_karma_low_amount"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_karma_low_ban", "rep_ttt_karma_low_ban", GetConVar("ttt_karma_low_ban"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_karma_low_ban_minutes", "rep_ttt_karma_low_ban_minutes", GetConVar("ttt_karma_low_ban_minutes"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_karma_persist", "rep_ttt_karma_persist", GetConVar("ttt_karma_persist"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_karma_debugspam", "rep_ttt_karma_debugspam", GetConVar("ttt_karma_debugspam"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_karma_clean_half", "rep_ttt_karma_clean_half", GetConVar("ttt_karma_clean_half"):GetInt(), false, false, "xgui_gmsettings")
        
        --map related
        ULib.replicatedWritableCvar("ttt_use_weapon_spawn_scripts", "rep_ttt_use_weapon_spawn_scripts", GetConVar("ttt_use_weapon_spawn_scripts"):GetInt(), false, false, "xgui_gmsettings")
        
        --prop possession
        ULib.replicatedWritableCvar("ttt_spec_prop_control", "rep_ttt_spec_prop_control", GetConVar("ttt_spec_prop_control"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_spec_prop_base", "rep_ttt_spec_prop_base", GetConVar("ttt_spec_prop_base"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_spec_prop_maxpenalty", "rep_ttt_spec_prop_maxpenalty", GetConVar("ttt_spec_prop_maxpenalty"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_spec_prop_maxbonus", "rep_ttt_spec_prop_maxbonus", GetConVar("ttt_spec_prop_maxbonus"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_spec_prop_force", "rep_ttt_spec_prop_force", GetConVar("ttt_spec_prop_force"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_spec_prop_rechargetime", "rep_ttt_spec_prop_rechargetime", GetConVar("ttt_spec_prop_rechargetime"):GetInt(), false, false, "xgui_gmsettings")
        
        --admin related
        ULib.replicatedWritableCvar("ttt_idle_limit", "rep_ttt_idle_limit", GetConVar("ttt_idle_limit"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_namechange_kick", "rep_ttt_namechange_kick", GetConVar("ttt_namechange_kick"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_namechange_bantime", "rep_ttt_namechange_bantime", GetConVar("ttt_namechange_bantime"):GetInt(), false, false, "xgui_gmsettings")
        
        --misc
        ULib.replicatedWritableCvar("ttt_detective_hats", "rep_ttt_detective_hats", GetConVar("ttt_detective_hats"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_playercolor_mode", "rep_ttt_playercolor_mode", GetConVar("ttt_playercolor_mode"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_ragdoll_collide", "rep_ttt_ragdoll_collide", GetConVar("ttt_ragdoll_collide"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_bots_are_spectators", "rep_ttt_bots_are_spectators", GetConVar("ttt_bots_are_spectators"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_debug_preventwin", "rep_ttt_debug_preventwin", GetConVar("ttt_debug_preventwin"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_locational_voice", "rep_ttt_locational_voice", GetConVar("ttt_locational_voice"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_allow_discomb_jump", "rep_ttt_allow_discomb_jump", GetConVar("ttt_allow_discomb_jump"):GetInt(), false, false, "xgui_gmsettings")
        ULib.replicatedWritableCvar("ttt_spawn_wave_interval", "rep_ttt_spawn_wave_interval", GetConVar("ttt_spawn_wave_interval"):GetInt(), false, false, "xgui_gmsettings")
    end
end

hook.Add("Initialize", "TTT2XGuiInit", function()
    if not ROLES then
        xgui.addSVModule("terrortown", init)
    else
        hook.Add("TTT2_PostRoleInit", "TTT2UlxInitCVars", function()
            if first then
                xgui.addSVModule("terrortown", init)
            else
                updateCVarsForTTT2ULX() -- todo needed? how does xgui.addSVModule work?
            end
        end)
    end
end)
