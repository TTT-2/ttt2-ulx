CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"

CLGAMEMODESUBMENU.priority = 0
CLGAMEMODESUBMENU.title = "TTT2-ULX"

function CLGAMEMODESUBMENU:Populate(parent)
	local form = vgui.CreateTTT2Form(parent, "header_addons_ttt2_ulx")

	form:MakeHelp({
		label = "help_server_addons_ttt2_ulx_ulib_debug"
	})

	form:MakeCheckBox({
		label = "label_ulib_debug_enable",
		serverConvar = "TTT2DebugUlibReplicatedWritableCvarStackTrace"
	})
end