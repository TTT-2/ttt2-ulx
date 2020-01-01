local ttt2_addon_settings = xlib.makepanel{
	parent = xgui.null
}

xlib.makelabel{
	x = 5,
	y = 5,
	w = 600,
	wordwrap = true,
	label = "Settings of Addons that support ULX.",
	parent = ttt2_addon_settings
}

ttt2_addon_settings.panel = xlib.makepanel{
	x = 160,
	y = 25,
	w = 420,
	h = 333,
	parent = ttt2_addon_settings
}

ttt2_addon_settings.catList = xlib.makelistview{
	x = 5,
	y = 25,
	w = 150,
	h = 333,
	parent = ttt2_addon_settings
}

ttt2_addon_settings.catList:AddColumn("Addon Settings")

ttt2_addon_settings.catList.Columns[1].DoClick = function()

end

ttt2_addon_settings.catList.OnRowSelected = function(self, LineID, Line)
	local nPanel = xgui.modules.submodule[Line:GetValue(2)].panel

	if nPanel ~= ttt2_addon_settings.curPanel then
		nPanel:SetZPos(0)

		xlib.addToAnimQueue("pnlSlide", {
			panel = nPanel,
			startx = -435,
			starty = 0,
			endx = 0,
			endy = 0,
			setvisible = true
		})

		if ttt2_addon_settings.curPanel then
			ttt2_addon_settings.curPanel:SetZPos(-1)
			xlib.addToAnimQueue(ttt2_addon_settings.curPanel.SetVisible, ttt2_addon_settings.curPanel, false)
		end

		xlib.animQueue_start()

		ttt2_addon_settings.curPanel = nPanel
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

		ttt2_addon_settings.curPanel = nil

		xlib.animQueue_start()
	end

	-- If the panel has it, call a function when it's opened
	if nPanel.onOpen then
		nPanel.onOpen()
	end
end

-- Process modular settings
function ttt2_addon_settings.processModules()
	ttt2_addon_settings.catList:Clear()

	for i, module in ipairs(xgui.modules.submodule) do
		if module.mtype == "ttt2_addon_settings" and (not module.access or LocalPlayer():query(module.access)) then
			local w, h = module.panel:GetSize()

			if w == h and h == 0 then
				module.panel:SetSize(275, 322)
			end

			if module.panel.scroll then --For DListLayouts
				module.panel.scroll.panel = module.panel
				module.panel = module.panel.scroll
			end

			module.panel:SetParent(ttt2_addon_settings.panel)

			local line = ttt2_addon_settings.catList:AddLine(module.name, i)

			if module.panel == ttt2_addon_settings.curPanel then
				ttt2_addon_settings.curPanel = nil
				ttt2_addon_settings.catList:SelectItem(line)
			else
				module.panel:SetVisible(false)
			end
		end
	end

	ttt2_addon_settings.catList:SortByColumn(1, false)
end

ttt2_addon_settings.processModules()

xgui.hookEvent("onProcessModules", nil, ttt2_addon_settings.processModules)
xgui.addModule("Addons", ttt2_addon_settings, "icon16/addons.png", "xgui_gmsettings")

hook.Run("TTTUlxModifyAddonSettings", "ttt2_addon_settings")

if TTTC then
	---------------------------------------------------------
	-------------------- MODULE: CLASSES --------------------
	---------------------------------------------------------

	local clspnl1 = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

	-- SUBMODULE: Basic Settings
	local clsclp = vgui.Create("DCollapsibleCategory", clspnl1)
	clsclp:SetSize(390, 125)
	clsclp:SetExpanded(1)
	clsclp:SetLabel("Basic Settings")

	local clslst1 = vgui.Create("DPanelList", clsclp)
	clslst1:SetPos(5, 25)
	clslst1:SetSize(390, 125)
	clslst1:SetSpacing(5)

	clslst1:AddItem(xlib.makecheckbox{
		label = "Enable Classes? (ttt2_classes) (def. 1)",
		repconvar = "rep_ttt2_classes",
		parent = clslst
	})

	clslst1:AddItem(xlib.makecheckbox{
		label = "Limited Classes? (ttt_classes_limited) (def. 1)",
		repconvar = "rep_ttt_classes_limited",
		parent = clslst
	})

	clslst1:AddItem(xlib.makecheckbox{
		label = "Option to choose between two classes? (ttt_classes_option) (def. 1)",
		repconvar = "rep_ttt_classes_option",
		parent = clslst
	})

	clslst1:AddItem(xlib.makecheckbox{
		label = "Passive Items on Class Slot? (ttt_classes_extraslot) (def. 1)",
		repconvar = "rep_ttt_classes_extraslot",
		parent = clslst
	})

	clslst1:AddItem(xlib.makecheckbox{
		label = "Keep Class on Respawn? (ttt_classes_keep_on_respawn) (def. 1)",
		repconvar = "rep_ttt_classes_keep_on_respawn",
		parent = clslst
	})

	xgui.hookEvent("onProcessModules", nil, clspnl1.processModules)
	xgui.addSubModule("TTT2 Classes", clspnl1, nil, "ttt2_addon_settings")


	----------------------------------------------------------------
	-------------------- MODULE: CLASS SETTINGS --------------------
	----------------------------------------------------------------

	local clspnl2 = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

	-- SUBMODULE: Individual classes
	for _, v in pairs(CLASS.GetSortedClasses()) do
		local pName = CLASS.GetClassTranslation(v)

		local clsclp2 = vgui.Create("DCollapsibleCategory", clspnl2)
		clsclp2:SetSize(390, 50)
		clsclp2:SetExpanded(0)
		clsclp2:SetLabel(pName)

		local clslst2 = vgui.Create("DPanelList", clsclp2)
		clslst2:SetPos(5, 25)
		clslst2:SetSize(390, 50)
		clslst2:SetSpacing(5)

		clslst2:AddItem(xlib.makecheckbox{
			label = pName .. "? (tttc_class_" .. v.name .. "_enabled) (def. 1)",
			repconvar = "rep_tttc_class_" .. v.name .. "_enabled",
			parent = clslst2
		})

		clslst2:AddItem(xlib.makeslider{
			label = "tttc_class_" .. v.name .. "_random",
			min = 1,
			max = 100,
			repconvar = "rep_tttc_class_" .. v.name .. "_random",
			parent = clslst2
		})
	end

	xgui.hookEvent("onProcessModules", nil, clspnl2.processModules)
	xgui.addSubModule("TTT2 Class Settings", clspnl2, nil, "ttt2_addon_settings")
end
