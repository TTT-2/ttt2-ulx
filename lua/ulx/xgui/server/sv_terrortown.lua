-- painful file to create will all ttt cvars

ULX_DYNAMIC_RCVARS = {}

local function updateCVarsForTTT2ULXRoles()
	ULib.replicatedWritableCvar("ttt_newroles_enabled", "rep_ttt_newroles_enabled", GetConVar("ttt_newroles_enabled"):GetInt(), true, true, "xgui_gmsettings")
	ULib.replicatedWritableCvar("ttt_min_inno_pct", "rep_ttt_min_inno_pct", GetConVar("ttt_min_inno_pct"):GetFloat(), true, true, "xgui_gmsettings")
	ULib.replicatedWritableCvar("ttt_max_roles", "rep_ttt_max_roles", GetConVar("ttt_max_roles"):GetInt(), true, true, "xgui_gmsettings")
	ULib.replicatedWritableCvar("ttt_max_roles_pct", "rep_ttt_max_roles_pct", GetConVar("ttt_max_roles_pct"):GetFloat(), true, true, "xgui_gmsettings")
	ULib.replicatedWritableCvar("ttt_max_baseroles", "rep_ttt_max_baseroles", GetConVar("ttt_max_baseroles"):GetInt(), true, true, "xgui_gmsettings")
	ULib.replicatedWritableCvar("ttt_max_baseroles_pct", "rep_ttt_max_baseroles_pct", GetConVar("ttt_max_baseroles_pct"):GetFloat(), true, true, "xgui_gmsettings")

	for _, v in pairs(roles.GetList()) do
		
		--adding special role credit convars
		if v ~= INNOCENT and v~= TRAITOR then
			if ConVarExists("ttt_" .. v.abbr .. "_credits_starting") then
				ULib.replicatedWritableCvar("ttt_" .. v.abbr .. "_credits_starting", "rep_ttt_" .. v.abbr .. "_credits_starting", GetConVar("ttt_" .. v.abbr .. "_credits_starting"):GetFloat(), true, false, "xgui_gmsettings")
			end

			if ConVarExists("ttt_" .. v.abbr .. "_credits_traitorkill") then
				ULib.replicatedWritableCvar("ttt_" .. v.abbr .. "_credits_traitorkill", "rep_ttt_" .. v.abbr .. "_credits_traitorkill", GetConVar("ttt_" .. v.abbr .. "_credits_traitorkill"):GetInt(), true, false, "xgui_gmsettings")
			end

			if ConVarExists("ttt_" .. v.abbr .. "_credits_traitordead") then
				ULib.replicatedWritableCvar("ttt_" .. v.abbr .. "_credits_traitordead", "rep_ttt_" .. v.abbr .. "_credits_traitordead", GetConVar("ttt_" .. v.abbr .. "_credits_traitordead"):GetInt(), true, false, "xgui_gmsettings")
			end
		end 

		if v ~= INNOCENT and not v.notSelectable then
			ULib.replicatedWritableCvar("ttt_" .. v.name .. "_pct", "rep_ttt_" .. v.name .. "_pct", GetConVar("ttt_" .. v.name .. "_pct"):GetFloat(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_" .. v.name .. "_max", "rep_ttt_" .. v.name .. "_max", GetConVar("ttt_" .. v.name .. "_max"):GetInt(), true, false, "xgui_gmsettings")

			if v ~= TRAITOR then
				ULib.replicatedWritableCvar("ttt_" .. v.name .. "_min_players", "rep_ttt_" .. v.name .. "_min_players", GetConVar("ttt_" .. v.name .. "_min_players"):GetInt(), true, false, "xgui_gmsettings")

				if ConVarExists("ttt_" .. v.name .. "_karma_min") then
					ULib.replicatedWritableCvar("ttt_" .. v.name .. "_karma_min", "rep_ttt_" .. v.name .. "_karma_min", GetConVar("ttt_" .. v.name .. "_karma_min"):GetInt(), true, false, "xgui_gmsettings")
				end

				ULib.replicatedWritableCvar("ttt_" .. v.name .. "_enabled", "rep_ttt_" .. v.name .. "_enabled", GetConVar("ttt_" .. v.name .. "_enabled"):GetInt(), true, true, "xgui_gmsettings")

				-- randomness
				if ConVarExists("ttt_" .. v.name .. "_random") then
					ULib.replicatedWritableCvar("ttt_" .. v.name .. "_random", "rep_ttt_" .. v.name .. "_random", GetConVar("ttt_" .. v.name .. "_random"):GetInt(), true, false, "xgui_gmsettings")
				end
			else
				-- traitor credits
				ULib.replicatedWritableCvar("ttt_credits_starting", "rep_ttt_credits_starting", GetConVar("ttt_credits_starting"):GetFloat(), true, false, "xgui_gmsettings")
				ULib.replicatedWritableCvar("ttt_credits_award_pct", "rep_ttt_credits_award_pct", GetConVar("ttt_credits_award_pct"):GetInt(), true, false, "xgui_gmsettings")
				ULib.replicatedWritableCvar("ttt_credits_award_size", "rep_ttt_credits_award_size", GetConVar("ttt_credits_award_size"):GetInt(), true, false, "xgui_gmsettings")
				ULib.replicatedWritableCvar("ttt_credits_award_repeat", "rep_ttt_credits_award_repeat", GetConVar("ttt_credits_award_repeat"):GetInt(), true, false, "xgui_gmsettings")
				ULib.replicatedWritableCvar("ttt_credits_detectivekill", "rep_ttt_credits_detectivekill", GetConVar("ttt_credits_detectivekill"):GetInt(), true, false, "xgui_gmsettings")
			end
		end
	end
end

local function updateCVarsForTTTCULXClasses()
	ULib.replicatedWritableCvar("ttt2_classes", "rep_ttt2_classes", GetConVar("ttt2_classes"):GetInt(), true, true, "xgui_gmsettings")
	ULib.replicatedWritableCvar("ttt_classes_limited", "rep_ttt_classes_limited", GetConVar("ttt_classes_limited"):GetInt(), true, true, "xgui_gmsettings")
	ULib.replicatedWritableCvar("ttt_classes_option", "rep_ttt_classes_option", GetConVar("ttt_classes_option"):GetInt(), true, true, "xgui_gmsettings")
	ULib.replicatedWritableCvar("ttt_classes_extraslot", "rep_ttt_classes_extraslot", GetConVar("ttt_classes_extraslot"):GetInt(), true, true, "xgui_gmsettings")

	for _, v in pairs(CLASS.CLASSES or {}) do
		ULib.replicatedWritableCvar("tttc_class_" .. v.name .. "_enabled", "rep_tttc_class_" .. v.name .. "_enabled", GetConVar("tttc_class_" .. v.name .. "_enabled"):GetInt(), true, true, "xgui_gmsettings")
		ULib.replicatedWritableCvar("tttc_class_" .. v.name .. "_random", "rep_tttc_class_" .. v.name .. "_random", GetConVar("tttc_class_" .. v.name .. "_random"):GetInt(), true, false, "xgui_gmsettings")
	end
end

local function updateDynamicCVarsForTTT2ULXRoles()
	ULX_DYNAMIC_RCVARS = {}

	hook.Run("TTTUlxDynamicRCVars", ULX_DYNAMIC_RCVARS)

	for _, v in pairs(roles.GetList()) do
		if ULX_DYNAMIC_RCVARS[v.index] then
			for k, cvar in pairs(ULX_DYNAMIC_RCVARS[v.index]) do
				if not cvar.cvar or not GetConVar(cvar.cvar) then
					print()
					print("[TTT2][ULX][ERROR] Can't add CVAR! MALFORM")
					PrintTable(cvar)
					print()

					table.remove(ULX_DYNAMIC_RCVARS[v.index], k)

					return
				end

				ULib.replicatedWritableCvar(cvar.cvar, "rep_" .. cvar.cvar, GetConVar(cvar.cvar):GetInt(), true, false, "xgui_gmsettings")
			end
		end
	end
end

local function updateHUDCVars()
	if hudelements then
		for _, elem in ipairs(hudelements.GetList()) do
			if elem.togglable then
				ULib.replicatedWritableCvar("ttt2_elem_toggled_" .. elem.id, "rep_ttt2_elem_toggled_" .. elem.id, GetConVar("ttt2_elem_toggled_" .. elem.id):GetInt(), true, false, "xgui_gmsettings")
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
			ULib.replicatedWritableCvar("ttt_traitor_pct", "rep_ttt_traitor_pct", GetConVar("ttt_traitor_pct"):GetFloat(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_traitor_max", "rep_ttt_traitor_max", GetConVar("ttt_traitor_max"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_detective_pct", "rep_ttt_detective_pct", GetConVar("ttt_detective_pct"):GetFloat(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_detective_max", "rep_ttt_detective_max", GetConVar("ttt_detective_max"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_detective_min_players", "rep_ttt_detective_min_players", GetConVar("ttt_detective_min_players"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_detective_karma_min", "rep_ttt_detective_karma_min", GetConVar("ttt_detective_karma_min"):GetInt(), true, false, "xgui_gmsettings")

			-- traitor credits
			ULib.replicatedWritableCvar("ttt_credits_starting", "rep_ttt_credits_starting", GetConVar("ttt_credits_starting"):GetFloat(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_credits_award_pct", "rep_ttt_credits_award_pct", GetConVar("ttt_credits_award_pct"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_credits_award_size", "rep_ttt_credits_award_size", GetConVar("ttt_credits_award_size"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_credits_award_repeat", "rep_ttt_credits_award_repeat", GetConVar("ttt_credits_award_repeat"):GetInt(), true, false, "xgui_gmsettings")
			ULib.replicatedWritableCvar("ttt_credits_detectivekill", "rep_ttt_credits_detectivekill", GetConVar("ttt_credits_detectivekill"):GetInt(), true, false, "xgui_gmsettings")

			-- detective credits
			ULib.replicatedWritableCvar("ttt_det_credits_starting", "rep_ttt_det_credits_starting", GetConVar("ttt_det_credits_starting"):GetFloat(), true, false, "xgui_gmsettings")
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

		if ConVarExists("ttt_weapon_carrying") then
			ULib.replicatedWritableCvar("ttt_weapon_carrying", "rep_ttt_weapon_carrying", GetConVar("ttt_weapon_carrying"):GetInt(), true, false, "xgui_gmsettings")
		end

		if ConVarExists("ttt_weapon_carrying_range") then
			ULib.replicatedWritableCvar("ttt_weapon_carrying_range", "rep_ttt_weapon_carrying_range", GetConVar("ttt_weapon_carrying_range"):GetInt(), true, false, "xgui_gmsettings")
		end

		ULib.replicatedWritableCvar("ttt_teleport_telefrags", "rep_ttt_teleport_telefrags", GetConVar("ttt_teleport_telefrags"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_ragdoll_pinning", "rep_ttt_ragdoll_pinning", GetConVar("ttt_ragdoll_pinning"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_ragdoll_pinning_innocents", "rep_ttt_ragdoll_pinning_innocents", GetConVar("ttt_ragdoll_pinning_innocents"):GetInt(), true, false, "xgui_gmsettings")

		if TTT2 then
			ULib.replicatedWritableCvar("ttt_identify_body_woconfirm", "rep_ttt_identify_body_woconfirm", GetConVar("ttt_identify_body_woconfirm"):GetInt(), true, false, "xgui_gmsettings")
		end

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
		ULib.replicatedWritableCvar("ttt2_crowbar_shove_delay", "rep_ttt2_crowbar_shove_delay", GetConVar("ttt2_crowbar_shove_delay"):GetFloat(), true, false, "xgui_gmsettings")

		-- scoreboard
		ULib.replicatedWritableCvar("ttt_highlight_admins", "rep_ttt_highlight_admins", GetConVar("ttt_highlight_admins"):GetBool(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_highlight_dev", "rep_ttt_highlight_dev", GetConVar("ttt_highlight_dev"):GetBool(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_highlight_vip", "rep_ttt_highlight_vip", GetConVar("ttt_highlight_vip"):GetBool(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_highlight_addondev", "rep_ttt_highlight_addondev", GetConVar("ttt_highlight_addondev"):GetBool(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_highlight_supporter", "rep_ttt_highlight_supporter", GetConVar("ttt_highlight_supporter"):GetBool(), true, false, "xgui_gmsettings")

		-- sprint
		ULib.replicatedWritableCvar("ttt2_sprint_enabled", "rep_ttt2_sprint_enabled", GetConVar("ttt2_sprint_enabled"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt2_sprint_max", "rep_ttt2_sprint_max", GetConVar("ttt2_sprint_max"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt2_sprint_stamina_consumption", "rep_ttt2_sprint_stamina_consumption", GetConVar("ttt2_sprint_stamina_consumption"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt2_sprint_stamina_regeneration", "rep_ttt2_sprint_stamina_regeneration", GetConVar("ttt2_sprint_stamina_regeneration"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt2_sprint_crosshair", "rep_ttt2_sprint_crosshair", GetConVar("ttt2_sprint_crosshair"):GetInt(), true, false, "xgui_gmsettings")

		-- wepaon system
		ULib.replicatedWritableCvar("ttt2_max_melee_slots", "rep_ttt2_max_melee_slots", GetConVar("ttt2_max_melee_slots"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt2_max_secondary_slots", "rep_ttt2_max_secondary_slots", GetConVar("ttt2_max_secondary_slots"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt2_max_primary_slots", "rep_ttt2_max_primary_slots", GetConVar("ttt2_max_primary_slots"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt2_max_nade_slots", "rep_ttt2_max_nade_slots", GetConVar("ttt2_max_nade_slots"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt2_max_carry_slots", "rep_ttt2_max_carry_slots", GetConVar("ttt2_max_carry_slots"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt2_max_unarmed_slots", "rep_ttt2_max_unarmed_slots", GetConVar("ttt2_max_unarmed_slots"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt2_max_special_slots", "rep_ttt2_max_special_slots", GetConVar("ttt2_max_special_slots"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt2_max_extra_slots", "rep_ttt2_max_extra_slots", GetConVar("ttt2_max_extra_slots"):GetInt(), true, false, "xgui_gmsettings")

		-- armor
		ULib.replicatedWritableCvar("ttt_armor_classic", "rep_ttt_armor_classic", GetConVar("ttt_armor_classic"):GetBool(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_armor_is_reinforced_enabled", "rep_ttt_armor_is_reinforced_enabled", GetConVar("ttt_armor_is_reinforced_enabled"):GetBool(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_item_armor_value", "rep_ttt_item_armor_value", GetConVar("ttt_item_armor_value"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_armor_on_spawn", "rep_ttt_armor_on_spawn", GetConVar("ttt_armor_on_spawn"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_armor_threshold_for_reinforced", "rep_ttt_armor_threshold_for_reinforced", GetConVar("ttt_armor_threshold_for_reinforced"):GetInt(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_armor_damage_block_pct", "rep_ttt_armor_damage_block_pct", GetConVar("ttt_armor_damage_block_pct"):GetFloat(), true, false, "xgui_gmsettings")
		ULib.replicatedWritableCvar("ttt_armor_damage_health_pct", "rep_ttt_armor_damage_health_pct", GetConVar("ttt_armor_damage_health_pct"):GetFloat(), true, false, "xgui_gmsettings")


		if TTTC then
			updateCVarsForTTTCULXClasses()
		end

		hook.Run("TTTUlxInitCustomCVar", "xgui_gmsettings")
	end
end

xgui.addSVModule("terrortown", init)

hook.Add("TTT2RolesLoaded", "TTT2UlxInitCVars", function()
	if TTT2 then
		updateCVarsForTTT2ULXRoles()
	end
end)

hook.Add("PostInitPostEntity", "TTT2UlxInitCVars", function()
	updateHUDCVars()
end)

hook.Add("TTT2FinishedLoading", "TTT2UlxInitSWEPCVars", function()
	updateDynamicCVarsForTTT2ULXRoles()

	if TTTC then
		updateCVarsForTTTCULXClasses()
	end
end)

hook.Add("TTTCPostClassesInit", "TTT2UlxInitClassesCVars", function()
	updateCVarsForTTTCULXClasses()
end)
