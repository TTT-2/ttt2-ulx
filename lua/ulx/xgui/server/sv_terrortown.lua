-- painful file to create will all ttt cvars

ULX_DYNAMIC_RCVARS = {}

local function updateCVarsForTTT2ULXRoles()
	ULib.replicatedWritableCvar("ttt_newroles_enabled", "rep_ttt_newroles_enabled", GetConVar("ttt_newroles_enabled"):GetInt(), true, true, "xgui_gmsettings")

	for _, v in pairs(GetRoles()) do
		if v ~= INNOCENT and not v.notSelectable then
			ULib.replicatedWritableCvar("ttt_" .. v.name .. "_pct", "rep_ttt_" .. v.name .. "_pct", GetConVar("ttt_" .. v.name .. "_pct"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_" .. v.name .. "_max", "rep_ttt_" .. v.name .. "_max", GetConVar("ttt_" .. v.name .. "_max"):GetInt(), true, false, "xgui_gmsettings")

			if v ~= TRAITOR then
				ULib.replicatedWritableCvar("ttt_" .. v.name .. "_min_players", "rep_ttt_" .. v.name .. "_min_players", GetConVar("ttt_" .. v.name .. "_min_players"):GetInt(), true, false, "xgui_gmsettings")

				if ConVarExists("ttt_" .. v.name .. "_karma_min") then
					ULib.replicatedWritableCvar("ttt_" .. v.name .. "_karma_min", "rep_ttt_" .. v.name .. "_karma_min", GetConVar("ttt_" .. v.name .. "_karma_min"):GetInt(), true, false, "xgui_gmsettings")
				end

				-- roles credits
				if ConVarExists("ttt_" .. v.abbr .. "_credits_starting") then
					ULib.replicatedWritableCvar("ttt_" .. v.abbr .. "_credits_starting", "rep_ttt_" .. v.abbr .. "_credits_starting", GetConVar("ttt_" .. v.abbr .. "_credits_starting"):GetInt(), true, false, "xgui_gmsettings")
				end

				if ConVarExists("ttt_" .. v.abbr .. "_credits_traitorkill") then
					ULib.replicatedWritableCvar("ttt_" .. v.abbr .. "_credits_traitorkill", "rep_ttt_" .. v.abbr .. "_credits_traitorkill", GetConVar("ttt_" .. v.abbr .. "_credits_traitorkill"):GetInt(), true, false, "xgui_gmsettings")
				end

				if ConVarExists("ttt_" .. v.abbr .. "_credits_traitordead") then
					ULib.replicatedWritableCvar("ttt_" .. v.abbr .. "_credits_traitordead", "rep_ttt_" .. v.abbr .. "_credits_traitordead", GetConVar("ttt_" .. v.abbr .. "_credits_traitordead"):GetInt(), true, false, "xgui_gmsettings")
				end

				ULib.replicatedWritableCvar("ttt_" .. v.name .. "_enabled", "rep_ttt_" .. v.name .. "_enabled", GetConVar("ttt_" .. v.name .. "_enabled"):GetInt(), true, true, "xgui_gmsettings")

				-- randomness
				if ConVarExists("ttt_" .. v.name .. "_random") then
					ULib.replicatedWritableCvar("ttt_" .. v.name .. "_random", "rep_ttt_" .. v.name .. "_random", GetConVar("ttt_" .. v.name .. "_random"):GetInt(), true, false, "xgui_gmsettings")
				end
			else
				-- traitor credits
				ULib.replicatedWritableCvar("ttt_credits_starting", "rep_ttt_credits_starting", GetConVar("ttt_credits_starting"):GetInt(), true, false, "xgui_gmsettings")
				ULib.replicatedWritableCvar("ttt_credits_award_pct", "rep_ttt_credits_award_pct", GetConVar("ttt_credits_award_pct"):GetInt(), true, false, "xgui_gmsettings")
				ULib.replicatedWritableCvar("ttt_credits_award_size", "rep_ttt_credits_award_size", GetConVar("ttt_credits_award_size"):GetInt(), true, false, "xgui_gmsettings")
				ULib.replicatedWritableCvar("ttt_credits_award_repeat", "rep_ttt_credits_award_repeat", GetConVar("ttt_credits_award_repeat"):GetInt(), true, false, "xgui_gmsettings")
				ULib.replicatedWritableCvar("ttt_credits_detectivekill", "rep_ttt_credits_detectivekill", GetConVar("ttt_credits_detectivekill"):GetInt(), true, false, "xgui_gmsettings")
			end
		end
	end
end

local function updateCVarsForTTTCULXClasses()
	ULib.replicatedWritableCvar("ttt_customclasses_enabled", "rep_ttt_customclasses_enabled", GetConVar("ttt_customclasses_enabled"):GetInt(), true, true, "xgui_gmsettings")
	ULib.replicatedWritableCvar("ttt_customclasses_limited", "rep_ttt_customclasses_limited", GetConVar("ttt_customclasses_limited"):GetInt(), true, true, "xgui_gmsettings")

	for _, v in pairs(CLASSES) do
		if v ~= CLASSES.UNSET then
			ULib.replicatedWritableCvar("tttc_class_" .. v.name .. "_enabled", "rep_tttc_class_" .. v.name .. "_enabled", GetConVar("tttc_class_" .. v.name .. "_enabled"):GetInt(), true, true, "xgui_gmsettings")
			ULib.replicatedWritableCvar("tttc_class_" .. v.name .. "_random", "rep_tttc_class_" .. v.name .. "_random", GetConVar("tttc_class_" .. v.name .. "_random"):GetInt(), true, false, "xgui_gmsettings")
		end
	end
end

local function updateDynamicCVarsForTTT2ULXRoles()
	ULX_DYNAMIC_RCVARS = {}

	hook.Run("TTTUlxDynamicRCVars", ULX_DYNAMIC_RCVARS)

	for _, v in pairs(GetRoles()) do
		if v ~= INNOCENT and ULX_DYNAMIC_RCVARS[v.index] then
			for _, cvar in pairs(ULX_DYNAMIC_RCVARS[v.index]) do
				ULib.replicatedWritableCvar(cvar.cvar, "rep_" .. cvar.cvar, GetConVar(cvar.cvar):GetInt(), true, false, "xgui_gmsettings")
			end
		end
	end
end

local function updateWeaponCVarsForTTT2ULX()
	-- update weapons cvars too
	if TTTWEAPON_CVARS then
		for _, cvarTbl in pairs(TTTWEAPON_CVARS) do
			for _, cvar in pairs(cvarTbl) do
				ULib.replicatedWritableCvar(cvar.cvar, "rep_" .. cvar.cvar, GetConVar(cvar.cvar):GetInt(), true, false, "xgui_gmsettings")
			end
		end
	end
end

local function init()
	if GetConVar("gamemode"):GetString() == "terrortown" then -- Only execute the following code if it's a terrortown gamemode
		-- Preparation and post-round
		ULib.replicatedWritableCvar("ttt_preptime_seconds", "rep_ttt_preptime_seconds", GetConVar("ttt_preptime_seconds"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_firstpreptime", "rep_ttt_firstpreptime", GetConVar("ttt_firstpreptime"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_posttime_seconds", "rep_ttt_posttime_seconds", GetConVar("ttt_posttime_seconds"):GetInt(), true, false, "xgui_gmsettings")

		-- Round length
		ULib.replicatedWritableCvar("ttt_haste", "rep_ttt_haste", GetConVar("ttt_haste"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_haste_starting_minutes", "rep_ttt_haste_starting_minutes", GetConVar("ttt_haste_starting_minutes"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_haste_minutes_per_death", "rep_ttt_haste_minutes_per_death", GetConVar("ttt_haste_minutes_per_death"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_roundtime_minutes", "rep_ttt_roundtime_minutes", GetConVar("ttt_roundtime_minutes"):GetInt(), true, false, "xgui_gmsettings")

		-- map switching and voting
		ULib.replicatedWritableCvar("ttt_round_limit", "rep_ttt_round_limit", GetConVar("ttt_round_limit"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_time_limit_minutes", "rep_ttt_time_limit_minutes", GetConVar("ttt_time_limit_minutes"):GetInt(), true, false, "xgui_gmsettings")

		if ConVarExists("ttt_always_use_mapcycle") then
			ULib.replicatedWritableCvar("ttt_always_use_mapcycle", "rep_ttt_always_use_mapcycle", GetConVar("ttt_always_use_mapcycle"):GetInt(), true, false, "xgui_gmsettings")
		end

		if not TTT2 then
			-- traitor and detective counts
			ULib.replicatedWritableCvar("ttt_traitor_pct", "rep_ttt_traitor_pct", GetConVar("ttt_traitor_pct"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_traitor_max", "rep_ttt_traitor_max", GetConVar("ttt_traitor_max"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_detective_pct", "rep_ttt_detective_pct", GetConVar("ttt_detective_pct"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_detective_max", "rep_ttt_detective_max", GetConVar("ttt_detective_max"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_detective_min_players", "rep_ttt_detective_min_players", GetConVar("ttt_detective_min_players"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_detective_karma_min", "rep_ttt_detective_karma_min", GetConVar("ttt_detective_karma_min"):GetInt(), true, false, "xgui_gmsettings")

			-- traitor credits
			ULib.replicatedWritableCvar("ttt_credits_starting", "rep_ttt_credits_starting", GetConVar("ttt_credits_starting"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_credits_award_pct", "rep_ttt_credits_award_pct", GetConVar("ttt_credits_award_pct"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_credits_award_size", "rep_ttt_credits_award_size", GetConVar("ttt_credits_award_size"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_credits_award_repeat", "rep_ttt_credits_award_repeat", GetConVar("ttt_credits_award_repeat"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_credits_detectivekill", "rep_ttt_credits_detectivekill", GetConVar("ttt_credits_detectivekill"):GetInt(), true, false, "xgui_gmsettings")

			-- detective credits
			ULib.replicatedWritableCvar("ttt_det_credits_starting", "rep_ttt_det_credits_starting", GetConVar("ttt_det_credits_starting"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_det_credits_traitorkill", "rep_ttt_det_credits_traitorkill", GetConVar("ttt_det_credits_traitorkill"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_det_credits_traitordead", "rep_ttt_det_credits_traitordead", GetConVar("ttt_det_credits_traitordead"):GetInt(), true, false, "xgui_gmsettings")
		end

		-- dna
		ULib.replicatedWritableCvar("ttt_killer_dna_range", "rep_ttt_killer_dna_range", GetConVar("ttt_killer_dna_range"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_killer_dna_basetime", "rep_ttt_killer_dna_basetime", GetConVar("ttt_killer_dna_basetime"):GetInt(), true, false, "xgui_gmsettings")

		-- voicechat battery
		ULib.replicatedWritableCvar("ttt_voice_drain", "rep_ttt_voice_drain", GetConVar("ttt_voice_drain"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_voice_drain_normal", "rep_ttt_voice_drain_normal", GetConVar("ttt_voice_drain_normal"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_voice_drain_admin", "rep_ttt_voice_drain_admin", GetConVar("ttt_voice_drain_admin"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_voice_drain_recharge", "rep_ttt_voice_drain_recharge", GetConVar("ttt_voice_drain_recharge"):GetInt(), true, false, "xgui_gmsettings")

		-- other gameplay settings
		ULib.replicatedWritableCvar("ttt_minimum_players", "rep_ttt_minimum_players", GetConVar("ttt_minimum_players"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_postround_dm", "rep_ttt_postround_dm", GetConVar("ttt_postround_dm"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_dyingshot", "rep_ttt_dyingshot", GetConVar("ttt_dyingshot"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_no_nade_throw_during_prep", "rep_ttt_no_nade_throw_during_prep", GetConVar("ttt_no_nade_throw_during_prep"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_weapon_carrying", "rep_ttt_weapon_carrying", GetConVar("ttt_weapon_carrying"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_weapon_carrying_range", "rep_ttt_weapon_carrying_range", GetConVar("ttt_weapon_carrying_range"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_teleport_telefrags", "rep_ttt_teleport_telefrags", GetConVar("ttt_teleport_telefrags"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_ragdoll_pinning", "rep_ttt_ragdoll_pinning", GetConVar("ttt_ragdoll_pinning"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_ragdoll_pinning_innocents", "rep_ttt_ragdoll_pinning_innocents", GetConVar("ttt_ragdoll_pinning_innocents"):GetInt(), true, false, "xgui_gmsettings")

		-- karma
		ULib.replicatedWritableCvar("ttt_karma", "rep_ttt_karma", GetConVar("ttt_karma"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_karma_strict", "rep_ttt_karma_strict", GetConVar("ttt_karma_strict"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_karma_starting", "rep_ttt_karma_starting", GetConVar("ttt_karma_starting"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_karma_max", "rep_ttt_karma_max", GetConVar("ttt_karma_max"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_karma_ratio", "rep_ttt_karma_ratio", GetConVar("ttt_karma_ratio"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_karma_kill_penalty", "rep_ttt_karma_kill_penalty", GetConVar("ttt_karma_kill_penalty"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_karma_round_increment", "rep_ttt_karma_round_increment", GetConVar("ttt_karma_round_increment"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_karma_clean_bonus", "rep_ttt_karma_clean_bonus", GetConVar("ttt_karma_clean_bonus"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_karma_traitordmg_ratio", "rep_ttt_karma_traitordmg_ratio", GetConVar("ttt_karma_traitordmg_ratio"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_karma_traitorkill_bonus", "rep_ttt_karma_traitorkill_bonus", GetConVar("ttt_karma_traitorkill_bonus"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_karma_low_autokick", "rep_ttt_karma_low_autokick", GetConVar("ttt_karma_low_autokick"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_karma_low_amount", "rep_ttt_karma_low_amount", GetConVar("ttt_karma_low_amount"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_karma_low_ban", "rep_ttt_karma_low_ban", GetConVar("ttt_karma_low_ban"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_karma_low_ban_minutes", "rep_ttt_karma_low_ban_minutes", GetConVar("ttt_karma_low_ban_minutes"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_karma_persist", "rep_ttt_karma_persist", GetConVar("ttt_karma_persist"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_karma_debugspam", "rep_ttt_karma_debugspam", GetConVar("ttt_karma_debugspam"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_karma_clean_half", "rep_ttt_karma_clean_half", GetConVar("ttt_karma_clean_half"):GetInt(), true, false, "xgui_gmsettings")

		-- map related
		ULib.replicatedWritableCvar("ttt_use_weapon_spawn_scripts", "rep_ttt_use_weapon_spawn_scripts", GetConVar("ttt_use_weapon_spawn_scripts"):GetInt(), true, false, "xgui_gmsettings")

		-- prop possession
		ULib.replicatedWritableCvar("ttt_spec_prop_control", "rep_ttt_spec_prop_control", GetConVar("ttt_spec_prop_control"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_spec_prop_base", "rep_ttt_spec_prop_base", GetConVar("ttt_spec_prop_base"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_spec_prop_maxpenalty", "rep_ttt_spec_prop_maxpenalty", GetConVar("ttt_spec_prop_maxpenalty"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_spec_prop_maxbonus", "rep_ttt_spec_prop_maxbonus", GetConVar("ttt_spec_prop_maxbonus"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_spec_prop_force", "rep_ttt_spec_prop_force", GetConVar("ttt_spec_prop_force"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_spec_prop_rechargetime", "rep_ttt_spec_prop_rechargetime", GetConVar("ttt_spec_prop_rechargetime"):GetInt(), true, false, "xgui_gmsettings")

		-- admin related
		ULib.replicatedWritableCvar("ttt_idle_limit", "rep_ttt_idle_limit", GetConVar("ttt_idle_limit"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_namechange_kick", "rep_ttt_namechange_kick", GetConVar("ttt_namechange_kick"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_namechange_bantime", "rep_ttt_namechange_bantime", GetConVar("ttt_namechange_bantime"):GetInt(), true, false, "xgui_gmsettings")

		-- misc
		ULib.replicatedWritableCvar("ttt_detective_hats", "rep_ttt_detective_hats", GetConVar("ttt_detective_hats"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_playercolor_mode", "rep_ttt_playercolor_mode", GetConVar("ttt_playercolor_mode"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_ragdoll_collide", "rep_ttt_ragdoll_collide", GetConVar("ttt_ragdoll_collide"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_bots_are_spectators", "rep_ttt_bots_are_spectators", GetConVar("ttt_bots_are_spectators"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_debug_preventwin", "rep_ttt_debug_preventwin", GetConVar("ttt_debug_preventwin"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_locational_voice", "rep_ttt_locational_voice", GetConVar("ttt_locational_voice"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_allow_discomb_jump", "rep_ttt_allow_discomb_jump", GetConVar("ttt_allow_discomb_jump"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_spawn_wave_interval", "rep_ttt_spawn_wave_interval", GetConVar("ttt_spawn_wave_interval"):GetInt(), true, false, "xgui_gmsettings")

		if TTT2 then
			updateCVarsForTTT2ULXRoles()

			updateDynamicCVarsForTTT2ULXRoles()

			updateWeaponCVarsForTTT2ULX()
		end

		if CLASSES then
			updateCVarsForTTTCULXClasses()
		end
	end
end

xgui.addSVModule("terrortown", init)

hook.Add("Initialize", "TTT2UlxInitCVars", function()
	updateCVarsForTTT2ULXRoles()

	updateDynamicCVarsForTTT2ULXRoles()
end)

hook.Add("TTT2FinishedLoading", "TTT2UlxInitSWEPCVars", function()
	updateWeaponCVarsForTTT2ULX()
end)

hook.Add("TTTCPostClassesInit", "TTT2UlxInitClassesCVars", function()
	updateCVarsForTTTCULXClasses()
end)
