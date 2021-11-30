--- @ignore
local TryT = LANG.TryTranslation

CLGAMEMODESUBMENU.priority = 0
CLGAMEMODESUBMENU.title = ""

function CLGAMEMODESUBMENU:Populate(parent)
	local form = vgui.CreateTTT2Form(parent, TryT("menu_ulx_ported_addons_settings"))
	form:MakeHelp({
		label = "menu_ulx_ported_addons_settings_description"
	})

	for i = 1, #self.convars do
		local convar = self.convars[i]
		local type = convar.elementType

		if type == "checkbox" then
			option = form:MakeCheckBox(convar)
		elseif type == "slider" then
			option = form:MakeSlider(convar)
		elseif type == "category" then
			form = vgui.CreateTTT2Form(parent, convar.label)
		end
	end
end
