--[[--------------------------------------------------------------------------------------------
║                             Trouble in Terrorist Town 2 Commands                             ║
║                                          By: Alf21                                           ║
║                              ╔═════════╗╔═════════╗╔═════════╗                               ║
║                              ║ ╔═╗ ╔═╗ ║║ ╔═╗ ╔═╗ ║║ ╔═╗ ╔═╗ ║                               ║
║                              ╚═╝ ║ ║ ╚═╝╚═╝ ║ ║ ╚═╝╚═╝ ║ ║ ╚═╝                               ║
║──────────────────────────────────║ ║────────║ ║────────║ ║───────────────────────────────────║
║──────────────────────────────────║ ║────────║ ║────────║ ║───────────────────────────────────║
║──────────────────────────────────╚═╝────────╚═╝────────╚═╝───────────────────────────────────║
║                                                                                              ║
----------------------------------------------------------------------------------------------]]
local CATEGORY_NAME = "TTT ShopEditor"
local gamemode_error = "The current gamemode is not trouble in terrorest town"

function GamemodeCheck(calling_ply)
	if GetConVar("gamemode"):GetString() ~= "terrortown" then
		ULib.tsayError(calling_ply, gamemode_error, true)

		return true
	else
		return false
	end
end

--[Helper Functions]---------------------------------------------------------------------------
--[End]----------------------------------------------------------------------------------------

--[Toggle spectator]---------------------------------------------------------------------------
--[[ulx.spec][Forces < target(s) > to and from spectator.]
@param  {[PlayerObject]} calling_ply   [The player who used the command.]
@param  {[PlayerObject]} target_plys   [The player(s) who will have the effects of the command applied to them.]
--]]
function ulx.shopeditor(calling_ply)
	if GetConVar("gamemode"):GetString() ~= "terrortown" then
		ULib.tsayError(calling_ply, gamemode_error, true)
	else
		calling_ply:ConCommand("ttt_helpscreen")
	end
end

local shopeditor = ulx.command(CATEGORY_NAME, "ulx shopeditor", ulx.shopeditor, "!shopeditor")
shopeditor:defaultAccess(ULib.ACCESS_SUPERADMIN)
shopeditor:help("Opens F1 Menu, because shopeditor is now available via \"Edit Equipment\" and \"Edit Shops\".")

--[End]----------------------------------------------------------------------------------------
