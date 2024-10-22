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
	
	-- Check if decoding succeeded
	if success then
		print('Decoded response:'.. tostring(response))
		print('this is the id with string' .. tostring(response.id))
		print('this is the id without string' .. response.id)
	else
		print('Failed to decode JSON: ' .. tostring(responseRaw))
	end
    
    -- Uncomment the following block if you want to use PostAsync to get server data.
    -- Ensure that the URL is correct (added http:// as mentioned in earlier discussions).
    
    -- local response = httpService:PostAsync('http://127.0.0.1:8000/api/99robots/next', data, Enum.HttpContentType.ApplicationJson, false)
    -- print('raw list' .. tostring(response))
    -- local nextServerData = httpService:JSONDecode(response)

    -- print('serverData' .. tostring(nextServerData))
    -- if nextServerData == nil then
    --     game.StarterGui:SetCore('SendNotification', {
    --         Title = 'ERROR';
    --         Text = 'Something went wrong with grabbing servers (data doesn\'t exist)';
    --         Icon = 'rbxassetid://2541869220';
    --         Duration = 7;
    --     })
    --     return {}
    -- end

    -- Additional check for server having room
    -- for i = 1, #CurrentList.data do
    --     if CurrentList ~= nil then
    --         if CurrentList.data[i].maxPlayers - 1 > CurrentList.data[i].playing then
    --             table.insert(Servers, CurrentList.data[i])
    --         end
    --     end
    -- end

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
    -- teleportService:TeleportToPlaceInstance(placeId, nextServer.id, game.Players.LocalPlayer)
end

return module
