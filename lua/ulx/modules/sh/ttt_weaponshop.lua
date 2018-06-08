--[=[-------------------------------------------------------------------------------------------
║                             Trouble in Terrorist Town 2 Commands                             ║
║                                          By: Alf21                                           ║
║                              ╔═════════╗╔═════════╗╔═════════╗                               ║
║                              ║ ╔═╗ ╔═╗ ║║ ╔═╗ ╔═╗ ║║ ╔═╗ ╔═╗ ║                               ║
║                              ╚═╝ ║ ║ ╚═╝╚═╝ ║ ║ ╚═╝╚═╝ ║ ║ ╚═╝                               ║
║──────────────────────────────────║ ║────────║ ║────────║ ║───────────────────────────────────║
║──────────────────────────────────║ ║────────║ ║────────║ ║───────────────────────────────────║
║──────────────────────────────────╚═╝────────╚═╝────────╚═╝───────────────────────────────────║
║                                                                                              ║
---------------------------------------------------------------------------------------------]=]
local CATEGORY_NAME  = "TTT Weaponshop"
local gamemode_error = "The current gamemode is not trouble in terrorest town"

function GamemodeCheck(calling_ply)
	if not GetConVar("gamemode"):GetString() == "terrortown" then
		ULib.tsayError(calling_ply, gamemode_error, true)
        
		return true
	else
		return false
	end
end

--[Helper Functions]---------------------------------------------------------------------------
--[End]----------------------------------------------------------------------------------------

--[Toggle spectator]---------------------------------------------------------------------------
--[[ulx.spec][Forces <target(s)> to and from spectator.]
@param  {[PlayerObject]} calling_ply   [The player who used the command.]
@param  {[PlayerObject]} target_plys   [The player(s) who will have the effects of the command applied to them.]
--]]
function ulx.weaponshop(calling_ply)
	if not GetConVar("gamemode"):GetString() == "terrortown" then 
        ULib.tsayError(calling_ply, gamemode_error, true) 
    else
    	calling_ply:ConCommand("weaponshop")
	end
end

local weaponshop = ulx.command(CATEGORY_NAME, "ulx weaponshop", ulx.weaponshop, "!weaponshop")
weaponshop:defaultAccess(ULib.ACCESS_SUPERADMIN)
weaponshop:setOpposite("ulx silent weaponshop", {_, _, _, true}, "!sweaponshop", true)
weaponshop:help("Opens the weaponshop.")
--[End]----------------------------------------------------------------------------------------
