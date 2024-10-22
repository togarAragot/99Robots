local lastTimeStamp = os.time(os.date('!*t'))
local teleportService = game:GetService('TeleportService')
local httpService = game:GetService('HttpService')

local function dumpTable(t, indent)
    -- Initialize indent level
    indent = indent or 0
    local indentString = string.rep("  ", indent)  -- Two spaces for each indent level

    for key, value in pairs(t) do
        -- Print the key
        if type(value) == "table" then
            print(indentString .. tostring(key) .. ":")
            dumpTable(value, indent + 1)  -- Recursively print the nested table
        else
            print(indentString .. tostring(key) .. ": " .. tostring(value))
        end
    end
end

local function GetNextServer()

    print('pre servers')
    local api = 'http://192.168.178.81:8000/api/99robots/next?occupier=' .. game.Players.LocalPlayer.DisplayName
    local responseRaw = game:HttpGet(api)
	local success, response = pcall(function()
		return httpService:JSONDecode(responseRaw)
	end)

    wait()

    return response.id
end

local module = {}
function module:Teleport(placeId)
    print('method called')

    local serverId = GetNextServer()  -- Corrected capitalization
    print(serverId)
	print('post servers')
    -- Uncomment this when nextServer data is available from GetServers
    teleportService:TeleportToPlaceInstance(placeId, serverId, game.Players.LocalPlayer)
end

return module
