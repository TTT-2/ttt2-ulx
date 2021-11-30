F1MenuUlxData = F1MenuUlxData or {}

function InsertElementsIntoList(myList)
	local oldxlibmakecheckbox = xlib.makecheckbox

	xlib.makecheckbox = function(myTable)
		myList[#myList + 1] = {
			elementType = "checkbox",
			label = myTable.label,
			convar = myTable.repconvar
		}

		if isfunction(oldxlibmakecheckbox) then
			return oldxlibmakecheckbox(myTable)
		end
	end

	local oldxlibmakeslider = xlib.makeslider

	xlib.makeslider = function(myTable)
		myList[#myList + 1] = {
			elementType = "slider",
			label = myTable.label,
			convar = myTable.repconvar,
			decimal = myTable.decimal or 0,
			min = myTable.min or 0,
			max = myTable.max or 100
		}

		if isfunction(oldxlibmakeslider) then
			return oldxlibmakeslider(myTable)
		end
	end

	local oldVguiCreate = vgui.Create

	vgui.Create = function(uiElement, panel)
		if isfunction(oldVguiCreate) then
			newPanel = oldVguiCreate(uiElement, panel)
		end

		if not ispanel(newPanel) then
			return newPanel
		end

		if uiElement == "DCollapsibleCategory" then
			local oldSetLabel = newPanel.SetLabel

			newPanel.SetLabel = function(slf, label)
				myList[#myList + 1] = {
					elementType = "category",
					label = label
				}

				if isfunction(oldSetLabel) then
					newPanel.SetLabel = oldSetLabel
					return oldSetLabel(slf, label)
				end
			end
		end

		return newPanel
	end

	local function returnElementsToOldStates()
		xlib.makecheckbox = oldxlibmakecheckbox
		xlib.makeslider = oldxlibmakeslider
		vgui.Create = oldVguiCreate
	end

	return returnElementsToOldStates
end

function HookRunTTTUlxModifyAddonSettings(hookName, moduleType)

	local myConVarList = {}
	local oldxguiAddSubModule = xgui.addSubModule

	xgui.addSubModule = function(addonName, panel, access, type)
		if type == moduleType then
			F1MenuUlxData[addonName] = table.Copy(myConVarList)
		end

		-- Empty list for next addon
		table.Empty(myConVarList)

		if isfunction(oldxguiAddSubModule) then
			return oldxguiAddSubModule(addonName, panel, access, type)
		end
	end

	local returnElementsToOldStatesFunc = InsertElementsIntoList(myConVarList)

	-- Normally run the hook to get all addons and their ulx information
	hook.Run(hookName, moduleType)

	print("\nPrinting all gathered elements:")
	PrintTable(F1MenuUlxData)

	-- Revert all functions back to the default
	xgui.addSubModule = oldxguiAddSubModule
	returnElementsToOldStatesFunc()
end
