local lastTimeStamp = os.time(os.date("!*t"))
local teleportService = game:GetService("TeleportService")
local httpService = game:GetService("HttpService")
local lastServers = {}

local function GetServers(placeId)
    local Servers = {}
	
	if placeId == nil then
		placeId = game.PlaceId
	end

	local ListRaw = game:HttpGet("https://games.roblox.com/v1/games/" .. tostring(placeId) .. "/servers/0?sortOrder=2&excludeFullGames=true&limit=100")
	print("raw list" .. tostring(ListRaw))
	local CurrentList = httpService:JSONDecode(ListRaw)

	if CurrentList.data == nil then
		game.StarterGui:SetCore("SendNotification", {
			Title = "ERROR";
			Text = "Something went wrong with grabbing servers (data doesn't exist)";
			Icon = "rbxassetid://2541869220";
			Duration = 7;
		})
		return {}
	end

	-- Additional check for server having room
	for i = 1,#CurrentList.data do
		if CurrentList ~= nil then
			if CurrentList.data[i].maxPlayers - 1 > CurrentList.data[i].playing then
				table.insert(Servers, CurrentList.data[i])
			end
		end
	end

	wait()

    return Servers
end

local module = {}
function module:Teleport(placeId)
	while wait(5) do

		if next(lastServers) == nil or os.time(os.date("!*t")) > lastTimeStamp + 3600  then
			lastServers = GetServers(placeId)
		end

		local nextServer = Servers[math.random(1, #Servers)]	
		teleportService:TeleportToPlaceInstance(placeId, nextServer.id, Players.LocalPlayer)

		table.remove(lastServers, nextServer)
	end
end
return module