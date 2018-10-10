--experiment to see what happens if i colour my name (will be removed if it causes issues)
if SERVER then
	AddCSLuaFile("ulxtttdevcolour.lua")
else
	function ulxtttdevcolour(ply)
		local sid = ply:SteamID64()

		if sid == "STEAM_0:1:31456488" or sid == "STEAM_1:1:44782680" then
			return Color(100, 240, 105, 255)
		end
	end

	hook.Add("TTTScoreboardColorForPlayer", "ulxtttdevcolour", ulxtttdevcolour)
end
