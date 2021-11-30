--- @ignore
local tableCopy = table.Copy
local virtualSubmenus = {}

CLGAMEMODEMENU.base = "base_gamemodemenu"

CLGAMEMODEMENU.icon = Material("vgui/ttt/vskin/helpscreen/addons")
CLGAMEMODEMENU.title = "menu_ulx_ported_addons_title"
CLGAMEMODEMENU.description = "menu_ulx_ported_addons_description"
CLGAMEMODEMENU.priority = 45

CLGAMEMODEMENU.isInitialized = false

function CLGAMEMODEMENU:InitializeVirtualMenus()
	-- add "virtual" submenus that are treated as real one even without files
	virtualSubmenus = {}

	local addons = F1MenuUlxData
	local addonMenuBase = self:GetSubmenuByName("base_ulx_ported_addons")

	-- Assign all addons to a virtual menu
	local counter = 0
	for addonName, convars in SortedPairs(addons, true) do
		counter = counter + 1

		virtualSubmenus[counter] = tableCopy(addonMenuBase)
		virtualSubmenus[counter].title = addonName
		virtualSubmenus[counter].convars = convars
	end
end

-- overwrite the normal submenu function to return our custom virtual submenus
function CLGAMEMODEMENU:GetSubmenus()
	if not self.isInitialized then
		self.isInitialized = true

		self:InitializeVirtualMenus()
	end

	return virtualSubmenus
end

-- overwrite and return true to enable a searchbar
function CLGAMEMODEMENU:HasSearchbar()
	return true
end

function CLGAMEMODEMENU:IsAdminMenu()
	return true
end
