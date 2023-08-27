CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"

CLGAMEMODESUBMENU.priority = 0
CLGAMEMODESUBMENU.title = "title_addons_ttt2_ulx"

-- Hide this instead of deletion in case we wanna reuse it at some point
function CLGAMEMODESUBMENU:ShouldShow()
	return false
end

function CLGAMEMODESUBMENU:Populate(parent)
	local form = vgui.CreateTTT2Form(parent, "header_addons_ttt2_ulx")
end
