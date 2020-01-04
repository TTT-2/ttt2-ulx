-- painful file to create will all ttt cvars

ULX_DYNAMIC_RCVARS = {}

local function AutoReplicateConVar(name, type)
	local cv = GetConVar(name)

	if not cv then return end

	local cv_value
	if type == "int" then
		cv_value = cv:GetInt()
	elseif type == "float" then
		cv_value = cv:GetFloat()
	elseif type == "bool" then
		cv_value = cv:GetBool()
	elseif type == "string" then
		cv_value = cv:GetString()
	end

	ULib.replicatedWritableCvar(
		name,
		"rep_" .. name,
		cv_value,
		true,
		true,
		"xgui_gmsettings"
	)
end

local function updateCVarsForTTT2ULXRoles()
	AutoReplicateConVar("ttt_newroles_enabled", "int")
	AutoReplicateConVar("ttt_min_inno_pct", "float")
	AutoReplicateConVar("ttt_max_roles", "int")
	AutoReplicateConVar("ttt_max_roles_pct", "float")
	AutoReplicateConVar("ttt_max_baseroles", "int")
	AutoReplicateConVar("ttt_max_baseroles_pct", "float")

	for _, v in pairs(roles.GetList()) do
		--adding special role credit convars
		if v ~= INNOCENT and v ~= TRAITOR then
			AutoReplicateConVar("ttt_" .. v.abbr .. "_credits_starting", "int")
			AutoReplicateConVar("ttt_" .. v.abbr .. "_credits_traitorkill", "int")
			AutoReplicateConVar("ttt_" .. v.abbr .. "_credits_traitordead", "int")
		end

		if v ~= INNOCENT and not v.notSelectable then
			AutoReplicateConVar("ttt_" .. v.name .. "_pct", "float")
			AutoReplicateConVar("ttt_" .. v.name .. "_max", "int")

			if v ~= TRAITOR then
				AutoReplicateConVar("ttt_" .. v.name .. "_min_players", "int")
				AutoReplicateConVar("ttt_" .. v.name .. "_karma_min", "int")
				AutoReplicateConVar("ttt_" .. v.name .. "_enabled", "int")
				AutoReplicateConVar("ttt_" .. v.name .. "_random", "int")
			else
				-- traitor credits
				AutoReplicateConVar("ttt_credits_starting", "int")
				AutoReplicateConVar("ttt_credits_award_pct", "int")
				AutoReplicateConVar("ttt_credits_award_size", "int")
				AutoReplicateConVar("ttt_credits_award_repeat", "int")
				AutoReplicateConVar("ttt_credits_detectivekill", "int")
			end
		end
	end
end

local function updateCVarsForTTTCULXClasses()
	if not TTTC then return end

	AutoReplicateConVar("ttt2_classes", "int")
	AutoReplicateConVar("ttt_classes_limited", "int")
	AutoReplicateConVar("ttt_classes_option", "int")
	AutoReplicateConVar("ttt_classes_different", "int")
	AutoReplicateConVar("ttt_classes_extraslot", "int")
	AutoReplicateConVar("ttt_classes_keep_on_respawn", "int")

	for _, v in pairs(CLASS.CLASSES or {}) do
		AutoReplicateConVar("tttc_class_" .. v.name .. "_enabled", "int")
		AutoReplicateConVar("tttc_class_" .. v.name .. "_random", "int")
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

				AutoReplicateConVar(cvar.cvar, "int")
			end
		end
	end
end

local function updateHUDCVars()
	if hudelements then
		for _, elem in ipairs(hudelements.GetList()) do
			if elem.togglable then
				AutoReplicateConVar("ttt2_elem_toggled_" .. elem.id, "int")
			end
		end
	end
end

local function init()
	if not TTT2 then return end

	-- Preparation and post-round
	AutoReplicateConVar("ttt_preptime_seconds", "int")
	AutoReplicateConVar("ttt_firstpreptime", "int")
	AutoReplicateConVar("ttt_posttime_seconds", "int")
	AutoReplicateConVar("ttt2_prep_respawn", "int")

	-- Round length
	AutoReplicateConVar("ttt_haste", "int")
	AutoReplicateConVar("ttt_haste_starting_minutes", "int")
	AutoReplicateConVar("ttt_haste_minutes_per_death", "int")
	AutoReplicateConVar("ttt_roundtime_minutes", "int")

	-- map switching and voting
	AutoReplicateConVar("ttt_round_limit", "int")
	AutoReplicateConVar("ttt_time_limit_minutes", "int")
	AutoReplicateConVar("ttt_always_use_mapcycle", "int")

	-- dna
	AutoReplicateConVar("ttt_killer_dna_range", "int")
	AutoReplicateConVar("ttt_killer_dna_basetime", "int")

	-- voicechat battery
	AutoReplicateConVar("ttt_voice_drain", "int")
	AutoReplicateConVar("ttt_voice_drain_normal", "int")
	AutoReplicateConVar("ttt_voice_drain_admin", "int")
	AutoReplicateConVar("ttt_voice_drain_recharge", "int")

	-- other gameplay settings
	AutoReplicateConVar("ttt_minimum_players", "int")
	AutoReplicateConVar("ttt_postround_dm", "int")
	AutoReplicateConVar("ttt_dyingshot", "int")
	AutoReplicateConVar("ttt_no_nade_throw_during_prep", "int")
	AutoReplicateConVar("ttt_weapon_carrying", "int")
	AutoReplicateConVar("ttt_weapon_carrying_range", "int")
	AutoReplicateConVar("ttt_teleport_telefrags", "int")
	AutoReplicateConVar("ttt_idle", "bool")

	-- dead player settings
	AutoReplicateConVar("ttt_ragdoll_pinning", "int")
	AutoReplicateConVar("ttt_ragdoll_pinning_innocents", "int")
	AutoReplicateConVar("ttt_identify_body_woconfirm", "int")
	AutoReplicateConVar("ttt_announce_body_found", "int")
	AutoReplicateConVar("ttt_limit_spectator_chat", "int")
	AutoReplicateConVar("ttt_lastwords_chatprint", "int")

	-- karma
	AutoReplicateConVar("ttt_karma", "int")
	AutoReplicateConVar("ttt_karma_strict", "int")
	AutoReplicateConVar("ttt_karma_starting", "int")
	AutoReplicateConVar("ttt_karma_max", "int")
	AutoReplicateConVar("ttt_karma_ratio", "int")
	AutoReplicateConVar("ttt_karma_kill_penalty", "int")
	AutoReplicateConVar("ttt_karma_round_increment", "int")
	AutoReplicateConVar("ttt_karma_clean_bonus", "int")
	AutoReplicateConVar("ttt_karma_traitordmg_ratio", "int")
	AutoReplicateConVar("ttt_karma_traitorkill_bonus", "int")
	AutoReplicateConVar("ttt_karma_low_autokick", "int")
	AutoReplicateConVar("ttt_karma_low_amount", "int")
	AutoReplicateConVar("ttt_karma_low_ban", "int")
	AutoReplicateConVar("ttt_karma_low_ban_minutes", "int")
	AutoReplicateConVar("ttt_karma_persist", "int")
	AutoReplicateConVar("ttt_karma_debugspam", "int")
	AutoReplicateConVar("ttt_karma_clean_half", "int")

	-- map related
	AutoReplicateConVar("ttt_use_weapon_spawn_scripts", "int")
	AutoReplicateConVar("ttt_weapon_spawn_count", "int")

	-- prop possession
	AutoReplicateConVar("ttt_spec_prop_control", "int")
	AutoReplicateConVar("ttt_spec_prop_base", "int")
	AutoReplicateConVar("ttt_spec_prop_maxpenalty", "int")
	AutoReplicateConVar("ttt_spec_prop_maxbonus", "int")
	AutoReplicateConVar("ttt_spec_prop_force", "int")
	AutoReplicateConVar("ttt_spec_prop_rechargetime", "int")

	-- admin related
	AutoReplicateConVar("ttt_idle_limit", "int")
	AutoReplicateConVar("ttt_namechange_kick", "int")
	AutoReplicateConVar("ttt_namechange_bantime", "int")
	AutoReplicateConVar("ttt_log_damage_for_console", "bool")
	AutoReplicateConVar("ttt_damagelog_save", "bool")

	-- misc
	AutoReplicateConVar("ttt_detective_hats", "int")
	AutoReplicateConVar("ttt_playercolor_mode", "int")
	AutoReplicateConVar("ttt_ragdoll_collide", "int")
	AutoReplicateConVar("ttt_bots_are_spectators", "int")
	AutoReplicateConVar("ttt_debug_preventwin", "int")
	AutoReplicateConVar("ttt_locational_voice", "int")
	AutoReplicateConVar("ttt_allow_discomb_jump", "int")
	AutoReplicateConVar("ttt_spawn_wave_interval", "int")
	AutoReplicateConVar("ttt2_crowbar_shove_delay", "float")

	-- scoreboard
	AutoReplicateConVar("ttt_highlight_admins", "bool")
	AutoReplicateConVar("ttt_highlight_dev", "bool")
	AutoReplicateConVar("ttt_highlight_vip", "bool")
	AutoReplicateConVar("ttt_highlight_addondev", "bool")
	AutoReplicateConVar("ttt_highlight_supporter", "bool")

	-- sprint
	AutoReplicateConVar("ttt2_sprint_enabled", "int")
	AutoReplicateConVar("ttt2_sprint_max", "int")
	AutoReplicateConVar("ttt2_sprint_stamina_consumption", "int")
	AutoReplicateConVar("ttt2_sprint_stamina_regeneration", "int")
	AutoReplicateConVar("ttt2_sprint_crosshair", "int")

	-- wepaon system
	AutoReplicateConVar("ttt2_max_melee_slots", "int")
	AutoReplicateConVar("ttt2_max_secondary_slots", "int")
	AutoReplicateConVar("ttt2_max_primary_slots", "int")
	AutoReplicateConVar("ttt2_max_nade_slots", "int")
	AutoReplicateConVar("ttt2_max_carry_slots", "int")
	AutoReplicateConVar("ttt2_max_unarmed_slots", "int")
	AutoReplicateConVar("ttt2_max_special_slots", "int")
	AutoReplicateConVar("ttt2_max_extra_slots", "int")
	AutoReplicateConVar("ttt_weapon_autopickup", "bool")

	-- armor
	AutoReplicateConVar("ttt_armor_classic", "bool")
	AutoReplicateConVar("ttt_armor_enable_reinforced", "bool")
	AutoReplicateConVar("ttt_item_armor_value", "int")
	AutoReplicateConVar("ttt_armor_on_spawn", "int")
	AutoReplicateConVar("ttt_armor_threshold_for_reinforced", "int")
	AutoReplicateConVar("ttt_armor_damage_block_pct", "float")
	AutoReplicateConVar("ttt_armor_damage_health_pct", "float")

	updateCVarsForTTTCULXClasses()

	hook.Run("TTTUlxInitCustomCVar", "xgui_gmsettings")
end

xgui.addSVModule("terrortown", init)

hook.Add("TTT2RolesLoaded", "TTT2UlxInitCVars", function()
	updateCVarsForTTT2ULXRoles()
end)

hook.Add("PostInitPostEntity", "TTT2UlxInitCVars", function()
	updateHUDCVars()
end)

hook.Add("TTT2FinishedLoading", "TTT2UlxInitSWEPCVars", function()
	updateDynamicCVarsForTTT2ULXRoles()
	updateCVarsForTTTCULXClasses()
end)

hook.Add("TTTCPostClassesInit", "TTT2UlxInitClassesCVars", function()
	updateCVarsForTTTCULXClasses()
end)
