-- Terrortown settings module for ULX GUI
ULX_DYNAMIC_RCVARS = {}

hook.Run("TTTUlxDynamicRCVars", ULX_DYNAMIC_RCVARS)

-- Defines ttt cvar limits and ttt specific settings for the ttt gamemode.

local terrortown_settings = xlib.makepanel{parent = xgui.null}

xlib.makelabel{
	x = 5,
	y = 5,
	w = 600,
	wordwrap = true,
	label = "Trouble in Terrorist Town 2 ULX Commands XGUI module Created by: Bender180 (modified by Alf21)",
	parent = terrortown_settings
}

xlib.makelabel{
	x = 2,
	y = 345,
	w = 600,
	wordwrap = true,
	label = "The settings above WILL SAVE. So pay attention while editing them!",
	parent = terrortown_settings
}

xlib.makelabel{
	x = 5,
	y = 190,
	w = 160,
	wordwrap = true,
	label = "Note to server owners: to restrict this panel allow or deny permission to xgui_gmsettings.",
	parent = terrortown_settings
}

xlib.makelabel{
	x = 5,
	y = 250,
	w = 160,
	wordwrap = true,
	label = "All settings listed are explained here: http://ttt.badking.net/config- and-commands/convars",
	parent = terrortown_settings
}

xlib.makelabel{
	x = 5,
	y = 325,
	w = 160,
	wordwrap = true,
	label = "Not all settings echo to chat.",
	parent = terrortown_settings
}

terrortown_settings.panel = xlib.makepanel{
	x = 160,
	y = 25,
	w = 420,
	h = 318,
	parent = terrortown_settings
}

terrortown_settings.catList = xlib.makelistview{
	x = 5,
	y = 25,
	w = 150,
	h = 157,
	parent = terrortown_settings
}

terrortown_settings.catList:AddColumn("Terrorist Town 2 Settings")

terrortown_settings.catList.Columns[1].DoClick = function()

end

terrortown_settings.catList.OnRowSelected = function(self, LineID, Line)
	local nPanel = xgui.modules.submodule[Line:GetValue(2)].panel

	if nPanel ~= terrortown_settings.curPanel then
		nPanel:SetZPos(0)

		xlib.addToAnimQueue("pnlSlide", {
			panel = nPanel,
			startx = -435,
			starty = 0,
			endx = 0,
			endy = 0,
			setvisible = true
		})

		if terrortown_settings.curPanel then
			terrortown_settings.curPanel:SetZPos(-1)
			xlib.addToAnimQueue(terrortown_settings.curPanel.SetVisible, terrortown_settings.curPanel, false)
		end

		xlib.animQueue_start()

		terrortown_settings.curPanel = nPanel
	else
		xlib.addToAnimQueue("pnlSlide", {
			panel = nPanel,
			startx = 0,
			starty = 0,
			endx = -435,
			endy = 0,
			setvisible = false
		})
		self:ClearSelection()

		terrortown_settings.curPanel = nil

		xlib.animQueue_start()
	end

	-- If the panel has it, call a function when it's opened
	if nPanel.onOpen then
		nPanel.onOpen()
	end
end

-- Process modular settings
function terrortown_settings.processModules()
	terrortown_settings.catList:Clear()

	for i, module in ipairs(xgui.modules.submodule) do
		if module.mtype == "terrortown_settings" and (not module.access or LocalPlayer():query(module.access)) then
			local w, h = module.panel:GetSize()

			if w == h and h == 0 then
				module.panel:SetSize(275, 322)
			end

			if module.panel.scroll then --For DListLayouts
				module.panel.scroll.panel = module.panel
				module.panel = module.panel.scroll
			end

			module.panel:SetParent(terrortown_settings.panel)

			local line = terrortown_settings.catList:AddLine(module.name, i)

			if module.panel == terrortown_settings.curPanel then
				terrortown_settings.curPanel = nil
				terrortown_settings.catList:SelectItem(line)
			else
				module.panel:SetVisible(false)
			end
		end
	end

	terrortown_settings.catList:SortByColumn(1, false)
end
terrortown_settings.processModules()

xgui.hookEvent("onProcessModules", nil, terrortown_settings.processModules)
xgui.addModule("TTT2", terrortown_settings, "icon16/ttt.png", "xgui_gmsettings")

-----------------------------------------------------------------
-------------------- MODULE: ROUND STRUCTURE --------------------
-----------------------------------------------------------------

local rspnl = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

-- SUBMODULE: Preparation and post-round
local rspapclp = vgui.Create("DCollapsibleCategory", rspnl)
rspapclp:SetSize(390, 95)
rspapclp:SetExpanded(1)
rspapclp:SetLabel("Preparation and Post-Round")

local rspaplst = vgui.Create("DPanelList", rspapclp)
rspaplst:SetPos(5, 25)
rspaplst:SetSize(390, 95)
rspaplst:SetSpacing(5)

rspaplst:AddItem(xlib.makeslider{
	label = "ttt_preptime_seconds (def. 30)",
	min = 1,
	max = 120,
	repconvar = "rep_ttt_preptime_seconds",
	parent = rspaplst
})

rspaplst:AddItem(xlib.makeslider{
	label = "ttt_firstpreptime (def. 60)",
	min = 1,
	max = 120,
	repconvar = "rep_ttt_firstpreptime",
	parent = rspaplst
})

rspaplst:AddItem(xlib.makeslider{
	label = "ttt_posttime_seconds (def. 30)",
	min = 1,
	max = 120,
	repconvar = "rep_ttt_posttime_seconds",
	parent = rspaplst
})

rspaplst:AddItem(xlib.makecheckbox{
	label = "ttt2_prep_respawn (def. 0)",
	repconvar = "rep_ttt2_prep_respawn",
	parent = rsrllst
})

-- SUBMODULE: Round length
local rsrlclp = vgui.Create("DCollapsibleCategory", rspnl)
rsrlclp:SetSize(390, 90)
rsrlclp:SetExpanded(0)
rsrlclp:SetLabel("Round Length")

local rsrl = vgui.Create("DPanelList", rsrlclp)
rsrl:SetPos(5, 25)
rsrl:SetSize(390, 90)
rsrl:SetSpacing(5)

rsrl:AddItem(xlib.makecheckbox{
	label = "ttt_haste",
	repconvar = "rep_ttt_haste",
	parent = rsrl
})

rsrl:AddItem(xlib.makeslider{
	label = "ttt_haste_starting_minutes (def. 5)",
	min = 1,
	max = 60,
	repconvar = "rep_ttt_haste_starting_minutes",
	parent = rsrl
})

rsrl:AddItem(xlib.makeslider{
	label = "ttt_haste_minutes_per_death (def. 0.5)",
	min = 0.1,
	max = 9,
	decimal = 1,
	repconvar = "rep_ttt_haste_minutes_per_death",
	parent = rsrl
})

rsrl:AddItem(xlib.makeslider{
	label = "ttt_roundtime_minutes (def. 10)",
	min = 1,
	max = 60,
	repconvar = "rep_ttt_roundtime_minutes",
	parent = rsrl
})

-- SUBMODULE: Map switching and voting
local msavclp = vgui.Create("DCollapsibleCategory", rspnl)
msavclp:SetSize(390, 95)
msavclp:SetExpanded(0)
msavclp:SetLabel("Map Switching and Voting")

local msavlst = vgui.Create("DPanelList", msavclp)
msavlst:SetPos(5, 25)
msavlst:SetSize(390, 95)
msavlst:SetSpacing(5)

msavlst:AddItem(xlib.makeslider{
	label = "ttt_round_limit (def. 6)",
	min = 1,
	max = 100,
	repconvar = "rep_ttt_round_limit",
	parent = msavlst
})

msavlst:AddItem(xlib.makeslider{
	label = "ttt_time_limit_minutes (def. 75)",
	min = 1,
	max = 150,
	repconvar = "rep_ttt_time_limit_minutes",
	parent = msavlst
})

msavlst:AddItem(xlib.makecheckbox{
	label = "ttt_always_use_mapcycle (def. 0)",
	repconvar = "rep_ttt_always_use_mapcycle",
	parent = msavlst
})

msavlst:AddItem(xlib.makelabel{
	wordwrap = true,
	label = "This does nothing but since its included in TTT it's here.",
	parent = msavlst
})

xgui.hookEvent("onProcessModules", nil, rspnl.processModules)
xgui.addSubModule("Round Structure", rspnl, nil, "terrortown_settings")

-------------------------------------------------------
-------------------- MODULE: ROLES --------------------
-------------------------------------------------------

local rolepnl = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

local b = true

for _, v in pairs(GetSortedRoles()) do
	if v == INNOCENT then
		local size = 45

		local gptdcclp = vgui.Create("DCollapsibleCategory", rolepnl)
		gptdcclp:SetSize(390, size)
		gptdcclp:SetExpanded(b and 1 or 0)
		gptdcclp:SetLabel("" .. v.name)

		b = false

		local gptdlst = vgui.Create("DPanelList", gptdcclp)
		gptdlst:SetPos(5, 25)
		gptdlst:SetSize(390, size)
		gptdlst:SetSpacing(5)

		gptdlst:AddItem(xlib.makeslider{
			label = "ttt_min_inno_pct",
			min = 0.01,
			max = 1,
			decimal = 2,
			repconvar = "rep_ttt_min_inno_pct",
			parent = gptdlst
		})

		gptdlst:AddItem(xlib.makecheckbox{
			label = "ttt_" .. v.name .. "_traitor_button",
			repconvar = "rep_ttt_" .. v.name .. "_traitor_button",
			parent = gptdlst
		})
	else
		local tmp = 0

		if ULX_DYNAMIC_RCVARS[v.index] then
			for _, cvar in pairs(ULX_DYNAMIC_RCVARS[v.index]) do
				if cvar.slider then
					tmp = tmp + 25
				end
				if cvar.checkbox then
					tmp = tmp + 20
				end
			end
		end

		if not v.notSelectable or tmp > 0 then
			local size = not v.notSelectable and 70 or 0

			if not v.notSelectable and v ~= TRAITOR then
				size = size + 50

				if ConVarExists("ttt_" .. v.name .. "_random") then
					size = size + 25
				end
			end

			size = size + tmp

			local gptdcclp = vgui.Create("DCollapsibleCategory", rolepnl)
			gptdcclp:SetSize(390, size)
			gptdcclp:SetExpanded(b and 1 or 0)
			gptdcclp:SetLabel("" .. v.name)

			b = false

			local gptdlst = vgui.Create("DPanelList", gptdcclp)
			gptdlst:SetPos(5, 25)
			gptdlst:SetSize(390, size)
			gptdlst:SetSpacing(5)

			if not v.notSelectable then
				gptdlst:AddItem(xlib.makeslider{
					label = "ttt_" .. v.name .. "_pct",
					min = 0.01,
					max = 1,
					decimal = 2,
					repconvar = "rep_ttt_" .. v.name .. "_pct",
					parent = gptdlst
				})

				gptdlst:AddItem(xlib.makeslider{
					label = "ttt_" .. v.name .. "_max",
					min = 1,
					max = 64,
					repconvar = "rep_ttt_" .. v.name .. "_max",
					parent = gptdlst
				})

				if v ~= TRAITOR then
					if ConVarExists("ttt_" .. v.name .. "_random") then
						gptdlst:AddItem(xlib.makeslider{
							label = "ttt_" .. v.name .. "_random",
							min = 1,
							max = 100,
							repconvar = "rep_ttt_" .. v.name .. "_random",
							parent = gptdlst
						})
					end

					gptdlst:AddItem(xlib.makeslider{
						label = "ttt_" .. v.name .. "_min_players",
						min = 1,
						max = 64,
						repconvar = "rep_ttt_" .. v.name .. "_min_players",
						parent = gptdlst
					})

					if ConVarExists("rep_ttt_" .. v.name .. "_karma_min") then
						gptdlst:AddItem(xlib.makeslider{
							label = "ttt_" .. v.name .. "_karma_min",
							min = 1,
							max = 1000,
							repconvar = "rep_ttt_" .. v.name .. "_karma_min",
							parent = gptdlst
						})
					end

					gptdlst:AddItem(xlib.makecheckbox{
						label = v.name .. "? (ttt_" .. v.name .. "_enabled) (def. 1)",
						repconvar = "rep_ttt_" .. v.name .. "_enabled",
						parent = gptdlst
					})
				end

				gptdlst:AddItem(xlib.makecheckbox{
					label = "ttt_" .. v.name .. "_traitor_button",
					repconvar = "rep_ttt_" .. v.name .. "_traitor_button",
					parent = gptdlst
				})
			end

			if tmp > 0 then
				for _, cvar in pairs(ULX_DYNAMIC_RCVARS[v.index]) do
					if cvar.checkbox then
						gptdlst:AddItem(xlib.makecheckbox{
							label = v.name .. ": " .. cvar.desc,
							repconvar = "rep_" .. cvar.cvar,
							parent = gptdlst
						})
					elseif cvar.slider then
						gptdlst:AddItem(xlib.makeslider{
							label = v.name .. ": " .. (cvar.desc or cvar.cvar),
							min = cvar.min or 1,
							max = cvar.max or 1000,
							decimal = cvar.decimal or 0,
							repconvar = "rep_" .. cvar.cvar,
							parent = gptdlst
						})
					end
				end
			end
		end
	end
end

hook.Run("TTTUlxModifyGameplaySettings", rolepnl)

xgui.hookEvent("onProcessModules", nil, rolepnl.processModules)
xgui.addSubModule("Roles", rolepnl, nil, "terrortown_settings")

----------------------------------------------------------
-------------------- MODULE: GAMEPLAY --------------------
----------------------------------------------------------

local gppnl = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

-- SUBMODULE: DNA
local gpdnaclp = vgui.Create("DCollapsibleCategory", gppnl)
gpdnaclp:SetSize(390, 45)
gpdnaclp:SetExpanded(1)
gpdnaclp:SetLabel("DNA")

local gpdnalst = vgui.Create("DPanelList", gpdnaclp)
gpdnalst:SetPos(5, 25)
gpdnalst:SetSize(390, 45)
gpdnalst:SetSpacing(5)

gpdnalst:AddItem(xlib.makeslider{
	label = "ttt_killer_dna_range (def. 550)",
	min = 100,
	max = 1000,
	repconvar = "rep_ttt_killer_dna_range",
	parent = gpdnalst
})

gpdnalst:AddItem(xlib.makeslider{
	label = "ttt_killer_dna_basetime (def. 100)",
	min = 10,
	max = 200,
	repconvar = "rep_ttt_killer_dna_basetime",
	parent = gpdnalst
})

-- SUBMODULE: Voicechat battery
local gpvcbclp = vgui.Create("DCollapsibleCategory", gppnl)
gpvcbclp:SetSize(390, 65)
gpvcbclp:SetExpanded(0)
gpvcbclp:SetLabel("Voicechat battery")

local gpvcblst = vgui.Create("DPanelList", gpvcbclp)
gpvcblst:SetPos(5, 25)
gpvcblst:SetSize(390, 65)
gpvcblst:SetSpacing(5)

gpvcblst:AddItem(xlib.makecheckbox{
	label = "ttt_voice_drain (def. 0)",
	repconvar = "rep_ttt_voice_drain",
	parent = gpvcblst
})

gpvcblst:AddItem(xlib.makeslider{
	label = "ttt_voice_drain_normal (def. 0.2)",
	min = 0.1,
	max = 1,
	decimal = 1,
	repconvar = "rep_ttt_voice_drain_normal",
	parent = gpvcblst
})

gpvcblst:AddItem(xlib.makeslider{
	label = "ttt_voice_drain_admin (def. 0.05)",
	min = 0.01,
	max = 1,
	decimal = 2,
	repconvar = "rep_ttt_voice_drain_admin",
	parent = gpvcblst
})

gpvcblst:AddItem(xlib.makeslider{
	label = "ttt_voice_drain_recharge (def. 0.05)",
	min = 0.01,
	max = 1,
	decimal = 2,
	repconvar = "rep_ttt_voice_drain_recharge",
	parent = gpvcblst
})


-- SUBMODULE: Dead Player Settings
local gpdpsclp = vgui.Create("DCollapsibleCategory", gppnl)
gpdpsclp:SetSize(390, 120)
gpdpsclp:SetExpanded(0)
gpdpsclp:SetLabel("Dead Player Settings")

local gpdpslst = vgui.Create("DPanelList", gpdpsclp)
gpdpslst:SetPos(5, 25)
gpdpslst:SetSize(390, 120)
gpdpslst:SetSpacing(5)

gpdpslst:AddItem(xlib.makecheckbox{
	label = "ttt_ragdoll_pinning (def. 1)",
	repconvar = "rep_ttt_ragdoll_pinning",
	parent = gpdpslst
})

gpdpslst:AddItem(xlib.makecheckbox{
	label = "ttt_ragdoll_pinning_innocents (def. 0)",
	repconvar = "rep_ttt_ragdoll_pinning_innocents",
	parent = gpdpslst
})

gpdpslst:AddItem(xlib.makecheckbox{
	label = "ttt_identify_body_woconfirm (def. 1)",
	repconvar = "rep_ttt_identify_body_woconfirm",
	parent = gpdpslst
})

gpdpslst:AddItem(xlib.makecheckbox{
	label = "ttt_announce_body_found (def. 1)",
	repconvar = "rep_ttt_announce_body_found",
	parent = gpdpslst
})

gpdpslst:AddItem(xlib.makecheckbox{
	label = "ttt_limit_spectator_chat (def. 1)",
	repconvar = "rep_ttt_limit_spectator_chat",
	parent = gpdpslst
})

gpdpslst:AddItem(xlib.makecheckbox{
	label = "ttt_lastwords_chatprint (def. 0)",
	repconvar = "rep_ttt_lastwords_chatprint",
	parent = gpdpslst
})

-- SUBMODULE: Other Gameplay Settings
local gpogsclp = vgui.Create("DCollapsibleCategory", gppnl)
gpogsclp:SetSize(390, 290)
gpogsclp:SetExpanded(0)
gpogsclp:SetLabel("Other Gameplay Settings")

local gpogslst = vgui.Create("DPanelList", gpogsclp)
gpogslst:SetPos(5, 25)
gpogslst:SetSize(390, 290)
gpogslst:SetSpacing(5)

gpogslst:AddItem(xlib.makecheckbox{
	label = "ttt_newroles_enabled (def. 1)",
	repconvar = "rep_ttt_newroles_enabled",
	parent = gpogslst
})

gpogslst:AddItem(xlib.makeslider{
	label = "ttt_max_roles (def. 0)",
	min = 0,
	max = 64,
	repconvar = "rep_ttt_max_roles",
	parent = gpogslst
})

gpogslst:AddItem(xlib.makeslider{
	label = "ttt_max_roles_pct (def. 0)",
	min = 0,
	max = 1,
	decimal = 2,
	repconvar = "rep_ttt_max_roles_pct",
	parent = gpogslst
})

gpogslst:AddItem(xlib.makeslider{
	label = "ttt_max_baseroles (def. 0)",
	min = 0,
	max = 64,
	repconvar = "rep_ttt_max_baseroles",
	parent = gpogslst
})

gpogslst:AddItem(xlib.makeslider{
	label = "ttt_max_baseroles_pct (def. 0)",
	min = 0,
	max = 1,
	decimal = 2,
	repconvar = "rep_ttt_max_baseroles_pct",
	parent = gpogslst
})

gpogslst:AddItem(xlib.makeslider{
	label = "ttt_minimum_players (def. 2)",
	min = 1,
	max = 64,
	repconvar = "rep_ttt_minimum_players",
	parent = gpogslst
})

gpogslst:AddItem(xlib.makecheckbox{
	label = "ttt_postround_dm (def. 0)",
	repconvar = "rep_ttt_postround_dm",
	parent = gpogslst
})

gpogslst:AddItem(xlib.makecheckbox{
	label = "ttt_dyingshot (def. 0)",
	repconvar = "rep_ttt_dyingshot",
	parent = gpogslst
})

gpogslst:AddItem(xlib.makecheckbox{
	label = "ttt_no_nade_throw_during_prep (def. 0)",
	repconvar = "rep_ttt_no_nade_throw_during_prep",
	parent = gpogslst
})

gpogslst:AddItem(xlib.makecheckbox{
	label = "ttt_weapon_carrying (def. 1)",
	repconvar = "rep_ttt_weapon_carrying",
	parent = gpogslst
})

gpogslst:AddItem(xlib.makeslider{
	label = "ttt_weapon_carrying_range (def. 50)",
	min = 10,
	max = 100,
	repconvar = "rep_ttt_weapon_carrying_range",
	parent = gpogslst
})

gpogslst:AddItem(xlib.makecheckbox{
	label = "ttt_teleport_telefrags (def. 0)",
	repconvar = "rep_ttt_teleport_telefrags",
	parent = gpogslst
})

gpogslst:AddItem(xlib.makecheckbox{
	label = "ttt_idle (def. 1)",
	repconvar = "rep_ttt_idle",
	parent = gpogslst
})

xgui.hookEvent("onProcessModules", nil, gppnl.processModules)
xgui.addSubModule("Gameplay", gppnl, nil, "terrortown_settings")


-------------------------------------------------------------------
-------------------- MODULE: TTT2 HUD SETTINGS --------------------
-------------------------------------------------------------------

if hudelements then
	local clspnl = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

	for _, elem in ipairs(hudelements.GetList()) do
		if elem.togglable then
			local clsclp2 = vgui.Create("DCollapsibleCategory", clspnl)
			clsclp2:SetSize(390, 25)
			clsclp2:SetExpanded(0)
			clsclp2:SetLabel(elem.id)

			local clslst2 = vgui.Create("DPanelList", clsclp2)
			clslst2:SetPos(5, 25)
			clslst2:SetSize(390, 25)
			clslst2:SetSpacing(5)

			clslst2:AddItem(xlib.makecheckbox{
				label = "toggle '" .. elem.id .. "'?",
				repconvar = "rep_ttt2_elem_toggled_" .. elem.id,
				parent = clslst2
			})
		end
	end

	xgui.hookEvent("onProcessModules", nil, clspnl.processModules)
	xgui.addSubModule("TTT2 HUD Settings", clspnl, nil, "terrortown_settings")
end

-------------------------------------------------------
-------------------- MODULE: KARMA --------------------
-------------------------------------------------------

local krmpnl = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

local krmclp = vgui.Create("DCollapsibleCategory", krmpnl)
krmclp:SetSize(390, 400)
krmclp:SetExpanded(1)
krmclp:SetLabel("Karma")

local krmlst = vgui.Create("DPanelList", krmclp)
krmlst:SetPos(5, 25)
krmlst:SetSize(390, 400)
krmlst:SetSpacing(5)

krmlst:AddItem(xlib.makecheckbox{
	label = "ttt_karma",
	repconvar = "rep_ttt_karma",
	parent = krmlst
})

krmlst:AddItem(xlib.makecheckbox{
	label = "ttt_karma_strict",
	repconvar = "rep_ttt_karma_strict",
	parent = krmlst
})

krmlst:AddItem(xlib.makeslider{
	label = "ttt_karma_starting (def. 1000)",
	min = 500,
	max = 2000,
	repconvar = "rep_ttt_karma_starting",
	parent = krmlst
})

krmlst:AddItem(xlib.makeslider{
	label = "ttt_karma_max (def. 1000)",
	min = 500,
	max = 2000,
	repconvar = "rep_ttt_karma_max",
	parent = krmlst
})

krmlst:AddItem(xlib.makeslider{
	label = "ttt_karma_ratio (def. 0.001)",
	min = 0.001,
	max = 0.009,
	decimal = 3,
	repconvar = "rep_ttt_karma_ratio",
	parent = krmlst
})

krmlst:AddItem(xlib.makeslider{
	label = "ttt_karma_kill_penalty (def. 15)",
	min = 1,
	max = 30,
	repconvar = "rep_ttt_karma_kill_penalty",
	parent = krmlst
})

krmlst:AddItem(xlib.makeslider{
	label = "ttt_karma_round_increment (def. 5)",
	min = 1,
	max = 30,
	repconvar = "rep_ttt_karma_round_increment",
	parent = krmlst
})

krmlst:AddItem(xlib.makeslider{
	label = "ttt_karma_clean_bonus (def. 30)",
	min = 10,
	max = 100,
	repconvar = "rep_ttt_karma_clean_bonus",
	parent = krmlst
})

krmlst:AddItem(xlib.makeslider{
	label = "ttt_karma_traitordmg_ratio (def. 0.0003)",
	min = 0.0001,
	max = 0.001,
	decimal = 4,
	repconvar = "rep_ttt_karma_traitordmg_ratio",
	parent = krmlst
})

krmlst:AddItem(xlib.makeslider{
	label = "ttt_karma_traitorkill_bonus (def. 40)",
	min = 10,
	max = 100,
	repconvar = "rep_ttt_karma_traitorkill_bonus",
	parent = krmlst
})

krmlst:AddItem(xlib.makecheckbox{
	label = "ttt_karma_low_autokick (def. 1)",
	repconvar = "rep_ttt_karma_low_autokick",
	parent = krmlst
})

krmlst:AddItem(xlib.makeslider{
	label = "ttt_karma_low_amount (def. 450)",
	min = 100,
	max = 1000,
	repconvar = "rep_ttt_karma_low_amount",
	parent = krmlst
})

krmlst:AddItem(xlib.makecheckbox{
	label = "ttt_karma_low_ban (def. 1)",
	repconvar = "rep_ttt_karma_low_ban",
	parent = krmlst
})

krmlst:AddItem(xlib.makeslider{
	label = "ttt_karma_low_ban_minutes (def. 60)",
	min = 10,
	max = 100,
	repconvar = "rep_ttt_karma_low_ban_minutes",
	parent = krmlst
})

krmlst:AddItem(xlib.makecheckbox{
	label = "ttt_karma_persist (def. 0)",
	repconvar = "rep_ttt_karma_persist",
	parent = krmlst
})

krmlst:AddItem(xlib.makecheckbox{
	label = "ttt_karma_debugspam (def. 0)",
	repconvar = "rep_ttt_karma_debugspam",
	parent = krmlst
})

krmlst:AddItem(xlib.makeslider{
	label = "ttt_karma_clean_half (def. 0.25)",
	min = 0.01,
	max = 0.9,
	decimal = 2,
	repconvar = "rep_ttt_karma_clean_half",
	parent = krmlst
})

xgui.hookEvent("onProcessModules", nil, krmpnl.processModules)
xgui.addSubModule("Karma", krmpnl, nil, "terrortown_settings")

-------------------------------------------------------------
-------------------- MODULE: MAP RELATED --------------------
-------------------------------------------------------------

local mprpnl = xlib.makepanel{w = 415, h = 318, parent = xgui.null}

local mapclp = vgui.Create("DCollapsibleCategory", mprpnl)
mapclp:SetSize(390, 400)
mapclp:SetExpanded(1)
mapclp:SetLabel("Map Related")

local maplst = vgui.Create("DPanelList", mapclp)
maplst:SetPos(5, 25)
maplst:SetSize(390, 400)
maplst:SetSpacing(5)

maplst:AddItem(xlib.makecheckbox{
	label = "ttt_use_weapon_spawn_scripts (def. 1)",
	repconvar = "rep_ttt_use_weapon_spawn_scripts",
	parent = maplst
})

maplst:AddItem(xlib.makeslider{
	label = "ttt_weapon_spawn_count (def. 0)",
	min = 0,
	max = 100,
	decimal = 0,
	repconvar = "rep_ttt_weapon_spawn_count",
	parent = maplst
})

xgui.hookEvent("onProcessModules", nil, mprpnl.processModules)
xgui.addSubModule("Map Related", mprpnl, nil, "terrortown_settings")

--------------------Equipment credits Module--------------------
local ecpnl = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

local b2 = true

for _, v in pairs(GetSortedRoles()) do
	if v ~= INNOCENT and IsShoppingRole(v.index) then
		-- ROLES credits
		if v == TRAITOR then
			local ectcclp = vgui.Create("DCollapsibleCategory", ecpnl)
			ectcclp:SetSize(390, 125)
			ectcclp:SetExpanded(b2 and 1 or 0)
			ectcclp:SetLabel(v.name .. " credits")

			b2 = false

			local ectclst = vgui.Create("DPanelList", ectcclp)
			ectclst:SetPos(5, 25)
			ectclst:SetSize(390, 125)
			ectclst:SetSpacing(5)

			ectclst:AddItem(xlib.makeslider{
				label = "ttt_credits_starting (def. 2)",
				min = 0,
				max = 10,
				repconvar = "rep_ttt_credits_starting",
				parent = ectclst
			})

			ectclst:AddItem(xlib.makeslider{
				label = "ttt_credits_award_pct (def. 0.35)",
				min = 0.01,
				max = 0.9,
				decimal = 2,
				repconvar = "rep_ttt_credits_award_pct",
				parent = krmlst
			})

			ectclst:AddItem(xlib.makeslider{
				label = "ttt_credits_award_size (def. 1)",
				min = 0,
				max = 5,
				repconvar = "rep_ttt_credits_award_size",
				parent = ectclst
			})

			ectclst:AddItem(xlib.makeslider{
				label = "ttt_credits_award_repeat (def. 1)",
				min = 0,
				max = 5,
				repconvar = "rep_ttt_credits_award_repeat",
				parent = ectclst
			})

			ectclst:AddItem(xlib.makeslider{
				label = "ttt_credits_detectivekill (def. 1)",
				min = 0,
				max = 5,
				repconvar = "rep_ttt_credits_detectivekill",
				parent = ectclst
			})
		elseif ConVarExists("ttt_" .. v.abbr .. "_credits_starting") then
			local i = 1

			local bTk = ConVarExists("ttt_" .. v.abbr .. "_credits_traitorkill")
			local bTd = ConVarExists("ttt_" .. v.abbr .. "_credits_traitordead")

			if bTk then
				i = i + 1
			end

			if bTd then
				i = i + 1
			end

			local ectcclp = vgui.Create("DCollapsibleCategory", ecpnl)
			ectcclp:SetSize(390, 25 * i)
			ectcclp:SetExpanded(b2 and 1 or 0)
			ectcclp:SetLabel(v.name .. " credits")

			b2 = false

			local ectclst = vgui.Create("DPanelList", ectcclp)
			ectclst:SetPos(5, 25)
			ectclst:SetSize(390, 25 * i)
			ectclst:SetSpacing(5)

			ectclst:AddItem(xlib.makeslider{
				label = "ttt_" .. v.abbr .. "_credits_starting",
				min = 0,
				max = 10,
				repconvar = "rep_ttt_" .. v.abbr .. "_credits_starting",
				parent = ectclst
			})

			if bTk then
				ectclst:AddItem(xlib.makeslider{
					label = "ttt_" .. v.abbr .. "_credits_traitorkill",
					min = 0,
					max = 10,
					repconvar = "rep_ttt_" .. v.abbr .. "_credits_traitorkill",
					parent = ectclst
				})
			end

			if bTd then
				ectclst:AddItem(xlib.makeslider{
					label = "ttt_" .. v.abbr .. "_credits_traitordead",
					min = 0,
					max = 10,
					repconvar = "rep_ttt_" .. v.abbr .. "_credits_traitordead",
					parent = ectclst
				})
			end
		end
	end
end

xgui.hookEvent("onProcessModules", nil, ecpnl.processModules)
xgui.addSubModule("Equipment credits", ecpnl, nil, "terrortown_settings")

--------------------Prop possession Module--------------------
local pppnl = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

local ppclp = vgui.Create("DCollapsibleCategory", pppnl)
ppclp:SetSize(390, 120)
ppclp:SetExpanded(1)
ppclp:SetLabel("Prop possession")

local pplst = vgui.Create("DPanelList", ppclp)
pplst:SetPos(5, 25)
pplst:SetSize(390, 120)
pplst:SetSpacing(5)

local ppspc = xlib.makecheckbox{label = "ttt_spec_prop_control  (def. 1)", repconvar = "rep_ttt_spec_prop_control", parent = pplst}
pplst:AddItem(ppspc)

local ppspb = xlib.makeslider{label = "ttt_spec_prop_base (def. 8)", min = 0, max = 50, repconvar = "rep_ttt_spec_prop_base", parent = pplst}
pplst:AddItem(ppspb)

local ppspmp = xlib.makeslider{label = "ttt_spec_prop_maxpenalty (def. -6)", min = -50, max = 0, repconvar = "rep_ttt_spec_prop_maxpenalty", parent = pplst}
pplst:AddItem(ppspmp)

local ppspmb = xlib.makeslider{label = "ttt_spec_prop_maxbonus (def. 16)", min = 0, max = 50, repconvar = "rep_ttt_spec_prop_maxbonus", parent = pplst}
pplst:AddItem(ppspmb)

local ppspf = xlib.makeslider{label = "ttt_spec_prop_force (def. 110)", min = 50, max = 300, repconvar = "rep_ttt_spec_prop_force", parent = pplst}
pplst:AddItem(ppspf)

local ppprt = xlib.makeslider{label = "ttt_spec_prop_rechargetime (def. 1)", min = 0, max = 10, repconvar = "rep_ttt_spec_prop_rechargetime", parent = pplst}
pplst:AddItem(ppprt)

xgui.hookEvent("onProcessModules", nil, pppnl.processModules)
xgui.addSubModule("Prop possession", pppnl, nil, "terrortown_settings")

-------------------------------------------------------------
-------------------- MODULE: MAP RELATED --------------------
-------------------------------------------------------------

local arpnl = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

local arclp = vgui.Create("DCollapsibleCategory", arpnl)
arclp:SetSize(390, 150)
arclp:SetExpanded(1)
arclp:SetLabel("Admin Related")

local arlst = vgui.Create("DPanelList", arclp)
arlst:SetPos(5, 25)
arlst:SetSize(390, 150)
arlst:SetSpacing(5)

arlst:AddItem(xlib.makeslider{
	label = "ttt_idle_limit (def. 180)",
	min = 50,
	max = 300,
	repconvar = "rep_ttt_idle_limit",
	parent = arlst
})

arlst:AddItem(xlib.makeslider{
	label = "ttt_namechange_bantime (def. 10)",
	min = 0,
	max = 60,
	repconvar = "rep_ttt_namechange_bantime",
	parent = arlst
})

arlst:AddItem(xlib.makecheckbox{
	label = "ttt_namechange_kick (def. 1)",
	repconvar = "rep_ttt_namechange_kick",
	parent = arlst
})

arlst:AddItem(xlib.makecheckbox{
	label = "ttt_log_damage_for_console (def. 1)",
	repconvar = "rep_ttt_log_damage_for_console",
	parent = arlst
})

arlst:AddItem(xlib.makecheckbox{
	label = "ttt_damagelog_save (def. 0)",
	repconvar = "rep_ttt_damagelog_save",
	parent = arlst
})

arlst:AddItem(xlib.makecheckbox{
	label = "ttt_ragdoll_collide (def. 0)",
	repconvar = "rep_ttt_ragdoll_collide",
	parent = arlst
})

arlst:AddItem(xlib.makecheckbox{
	label = "ttt2_tbutton_admin_show (def. 0)",
	repconvar = "ttt2_tbutton_admin_show",
	parent = arlst
})

xgui.hookEvent("onProcessModules", nil, arpnl.processModules)
xgui.addSubModule("Admin Related", arpnl, nil, "terrortown_settings")

--------------------------------------------------------
-------------------- MODULE: Sprint --------------------
--------------------------------------------------------

local spnl = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

local sclp = vgui.Create("DCollapsibleCategory", spnl)
sclp:SetSize(390, 125)
sclp:SetExpanded(1)
sclp:SetLabel("TTT2 Sprint")

local slst = vgui.Create("DPanelList", sclp)
slst:SetPos(5, 25)
slst:SetSize(390, 125)
slst:SetSpacing(5)

slst:AddItem(xlib.makecheckbox{
	label = "ttt2_sprint_enabled (def. 1)",
	repconvar = "rep_ttt2_sprint_enabled",
	parent = slst
})

slst:AddItem(xlib.makeslider{
	label = "ttt2_sprint_max (def. 0.5)",
	min = 0,
	max = 2,
	decimal = 2,
	repconvar = "rep_ttt2_sprint_max",
	parent = slst
})

slst:AddItem(xlib.makeslider{
	label = "ttt2_sprint_stamina_consumption (def. 0.6)",
	min = 0,
	max = 2,
	decimal = 2,
	repconvar = "rep_ttt2_sprint_stamina_consumption",
	parent = slst
})

slst:AddItem(xlib.makeslider{
	label = "ttt2_sprint_stamina_regeneration (def. 0.3)",
	min = 0,
	max = 2,
	decimal = 2,
	repconvar = "rep_ttt2_sprint_stamina_regeneration",
	parent = slst
})

slst:AddItem(xlib.makecheckbox{
	label = "ttt2_sprint_crosshair (def. 1)",
	repconvar = "rep_ttt2_sprint_crosshair",
	parent = slst
})

xgui.hookEvent("onProcessModules", nil, spnl.processModules)
xgui.addSubModule("TTT2 Sprint", spnl, nil, "terrortown_settings")

-----------------------------------------------------------
-------------------- MODULE: Inventory --------------------
-----------------------------------------------------------

local ipnl = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

-- SUBMODULE: Inventory
local iclp1 = vgui.Create("DCollapsibleCategory", ipnl)
iclp1:SetSize(390, 240)
iclp1:SetExpanded(1)
iclp1:SetLabel("Inventory")

local ilst1 = vgui.Create("DPanelList", iclp1)
ilst1:SetPos(5, 25)
ilst1:SetSize(390, 240)
ilst1:SetSpacing(5)

ilst1:AddItem(xlib.makelabel{
	x = 0,
	y = 0,
	w = 390,
	h = 30,
	wordwrap = true,
	label = "Maximum possible weapon count on each slot. Set -1 for infinite",
	parent = ilst
})

ilst1:AddItem(xlib.makeslider{
	label = "ttt2_max_melee_slots (def. 1)",
	min = -1,
	max = 10,
	decimal = 0,
	repconvar = "rep_ttt2_max_melee_slots",
	parent = ilst
})

ilst1:AddItem(xlib.makeslider{
	label = "ttt2_max_secondary_slots (def. 1)",
	min = -1,
	max = 10,
	decimal = 0,
	repconvar = "rep_ttt2_max_secondary_slots",
	parent = ilst
})

ilst1:AddItem(xlib.makeslider{
	label = "ttt2_max_primary_slots (def. 1)",
	min = -1,
	max = 10,
	decimal = 0,
	repconvar = "rep_ttt2_max_primary_slots",
	parent = ilst
})

ilst1:AddItem(xlib.makeslider{
	label = "ttt2_max_nade_slots (def. 1)",
	min = -1,
	max = 10,
	decimal = 0,
	repconvar = "rep_ttt2_max_nade_slots",
	parent = ilst
})

ilst1:AddItem(xlib.makeslider{
	label = "ttt2_max_carry_slots (def. 1)",
	min = -1,
	max = 10,
	decimal = 0,
	repconvar = "rep_ttt2_max_carry_slots",
	parent = ilst
})

ilst1:AddItem(xlib.makeslider{
	label = "ttt2_max_unarmed_slots (def. 1)",
	min = -1,
	max = 10,
	decimal = 0,
	repconvar = "rep_ttt2_max_unarmed_slots",
	parent = ilst
})

ilst1:AddItem(xlib.makeslider{
	label = "ttt2_max_special_slots (def. 2)",
	min = -1,
	max = 10,
	decimal = 0,
	repconvar = "rep_ttt2_max_special_slots",
	parent = ilst
})

ilst1:AddItem(xlib.makeslider{
	label = "ttt2_max_extra_slots (def. -1)",
	min = -1,
	max = 10,
	decimal = 0,
	repconvar = "rep_ttt2_max_extra_slots",
	parent = ilst
})

-- SUBMODULE: Inventory
local iclp2 = vgui.Create("DCollapsibleCategory", ipnl)
iclp2:SetSize(390, 240)
iclp2:SetExpanded(1)
iclp2:SetLabel("Weapon Switch")

local ilst2 = vgui.Create("DPanelList", iclp2)
ilst2:SetPos(5, 25)
ilst2:SetSize(390, 240)
ilst2:SetSpacing(5)

ilst2:AddItem(xlib.makecheckbox{
	label = "ttt_weapon_autopickup (def. 1)",
	repconvar = "rep_ttt_weapon_autopickup",
	parent = slst
})

xgui.hookEvent("onProcessModules", nil, ipnl.processModules)
xgui.addSubModule("TTT2 Inventory", ipnl, nil, "terrortown_settings")

------------------------------------------------------------
-------------------- MODULE: SCOREBOARD --------------------
------------------------------------------------------------

local sbpnl = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

local sbclp = vgui.Create("DCollapsibleCategory", sbpnl)
sbclp:SetSize(390, 100)
sbclp:SetExpanded(1)
sbclp:SetLabel("Highlight Groups")

local sblst = vgui.Create("DPanelList", sbclp)
sblst:SetPos(5, 25)
sblst:SetSize(390, 100)
sblst:SetSpacing(5)

sblst:AddItem(xlib.makecheckbox{
	label = "ttt_highlight_admins (def. 1)",
	repconvar = "rep_ttt_highlight_admins",
	parent = sblst
})

sblst:AddItem(xlib.makecheckbox{
	label = "ttt_highlight_dev (def. 1)",
	repconvar = "rep_ttt_highlight_dev",
	parent = sblst
})

sblst:AddItem(xlib.makecheckbox{
	label = "ttt_highlight_vip (def. 1)",
	repconvar = "rep_ttt_highlight_vip",
	parent = sblst
})

sblst:AddItem(xlib.makecheckbox{
	label = "ttt_highlight_addondev (def. 1)",
	repconvar = "rep_ttt_highlight_addondev",
	parent = sblst
})

sblst:AddItem(xlib.makecheckbox{
	label = "ttt_highlight_supporter (def. 1)",
	repconvar = "rep_ttt_highlight_supporter",
	parent = sblst
})

xgui.hookEvent("onProcessModules", nil, sbpnl.processModules)
xgui.addSubModule("TTT2 Scoreboard", sbpnl, nil, "terrortown_settings")

-------------------------------------------------------
-------------------- MODULE: ARMOR --------------------
-------------------------------------------------------

local apnl = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

-- SUBMODULE: Armor Features
local aclp1 = vgui.Create("DCollapsibleCategory", apnl)
aclp1:SetSize(390, 50)
aclp1:SetExpanded(1)
aclp1:SetLabel("Armor Features")

local alst1 = vgui.Create("DPanelList", aclp1)
alst1:SetPos(5, 25)
alst1:SetSize(390, 50)
alst1:SetSpacing(5)

alst1:AddItem(xlib.makecheckbox{
	label = "ttt_armor_classic (def. 0)",
	repconvar = "rep_ttt_armor_classic",
	parent = alst1
})

alst1:AddItem(xlib.makecheckbox{
	label = "ttt_armor_enable_reinforced (def. 1)",
	repconvar = "rep_ttt_armor_enable_reinforced",
	parent = alst1
})

-- SUBMODULE: Armor Item Settings
local aclp2 = vgui.Create("DCollapsibleCategory", apnl)
aclp2:SetSize(390, 25)
aclp2:SetExpanded(1)
aclp2:SetLabel("Armor Item Settings")

local alst2 = vgui.Create("DPanelList", aclp2)
alst2:SetPos(5, 25)
alst2:SetSize(390, 25)
alst2:SetSpacing(5)

alst2:AddItem(xlib.makeslider{
	label = "ttt_item_armor_value (def. 30)",
	repconvar = "rep_ttt_item_armor_value",
	min = 0,
	max = 100,
	decimal = 0,
	parent = alst2
})

-- SUBMODULE: Armor Balancing
local aclp3 = vgui.Create("DCollapsibleCategory", apnl)
aclp3:SetSize(390, 100)
aclp3:SetExpanded(1)
aclp3:SetLabel("Armor Balancing")

local alst3 = vgui.Create("DPanelList", aclp3)
alst3:SetPos(5, 25)
alst3:SetSize(390, 100)
alst3:SetSpacing(5)

alst3:AddItem(xlib.makeslider{
	label = "ttt_armor_on_spawn (def. 0)",
	min = 0,
	max = 100,
	decimal = 0,
	repconvar = "rep_ttt_armor_on_spawn",
	parent = alst3
})

alst3:AddItem(xlib.makeslider{
	label = "ttt_armor_threshold_for_reinforced (def. 50)",
	min = 0,
	max = 100,
	decimal = 0,
	repconvar = "rep_ttt_armor_threshold_for_reinforced",
	parent = alst3
})

alst3:AddItem(xlib.makeslider{
	label = "ttt_armor_damage_block_pct (def. 0.2)",
	min = 0,
	max = 1,
	decimal = 2,
	repconvar = "rep_ttt_armor_damage_block_pct",
	parent = alst3
})

alst3:AddItem(xlib.makeslider{
	label = "ttt_armor_damage_health_pct (def. 0.7)",
	repconvar = "rep_ttt_armor_damage_health_pct",
	min = 0,
	max = 1,
	decimal = 2,
	parent = alst3
})

xgui.hookEvent("onProcessModules", nil, apnl.processModules)
xgui.addSubModule("TTT2 Armor", apnl, nil, "terrortown_settings")

---------------------------------------------------------------
-------------------- MODULE: MISCELLANEOUS --------------------
---------------------------------------------------------------

local miscpnl = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

local miscclp = vgui.Create("DCollapsibleCategory", miscpnl)
miscclp:SetSize(390, 215)
miscclp:SetExpanded(1)
miscclp:SetLabel("Miscellaneous")

local misclst = vgui.Create("DPanelList", miscclp)
misclst:SetPos(5, 25)
misclst:SetSize(390, 215)
misclst:SetSpacing(5)

misclst:AddItem(xlib.makeslider{
	label = "ttt2_crowbar_shove_delay (def. 1.0)",
	min = 0,
	max = 10,
	decimal = 1,
	repconvar = "rep_ttt2_crowbar_shove_delay",
	parent = misclst
})

misclst:AddItem(xlib.makecheckbox{
	label = "ttt_detective_hats (def. 0)",
	repconvar = "rep_ttt_detective_hats",
	parent = misclst
})

misclst:AddItem(xlib.makeslider{
	label = "ttt_playercolor_mode (def. 1)",
	min = 0,
	max = 3,
	repconvar = "rep_ttt_playercolor_mode",
	parent = misclst
})

misclst:AddItem(xlib.makecheckbox{
	label = "ttt_ragdoll_collide (def. 0)",
	repconvar = "rep_ttt_ragdoll_collide",
	parent = misclst
})

misclst:AddItem(xlib.makecheckbox{
	label = "ttt_bots_are_spectators (def. 0)",
	repconvar = "rep_ttt_bots_are_spectators",
	parent = misclst
})

misclst:AddItem(xlib.makecheckbox{
	label = "ttt_debug_preventwin (def. 0)",
	repconvar = "rep_ttt_debug_preventwin",
	parent = misclst
})

misclst:AddItem(xlib.makecheckbox{
	label = "ttt_locational_voice (def. 0)",
	repconvar = "rep_ttt_locational_voice",
	parent = misclst
})

misclst:AddItem(xlib.makecheckbox{
	label = "ttt_allow_discomb_jump (def. 0)",
	repconvar = "rep_ttt_allow_discomb_jump",
	parent = misclst
})

misclst:AddItem(xlib.makecheckbox{
	label = "ttt_enforce_playermodel (def. 1)",
	repconvar = "rep_ttt_enforce_playermodel",
	parent = misclst
})

misclst:AddItem(xlib.makeslider{
	label = "ttt_spawn_wave_interval (def. 0)",
	min = 0,
	max = 30,
	repconvar = "rep_ttt_spawn_wave_interval",
	parent = misclst
})

xgui.hookEvent("onProcessModules", nil, miscpnl.processModules)
xgui.addSubModule("Miscellaneous", miscpnl, nil, "terrortown_settings")

hook.Run("TTTUlxModifySettings", "terrortown_settings")
