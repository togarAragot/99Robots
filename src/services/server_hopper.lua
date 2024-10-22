local lastTimeStamp = os.time(os.date('!*t'))
local teleportService = game:GetService('TeleportService')
local httpService = game:GetService('HttpService')

local function GetNextServer()

    print('pre servers')
    local api = 'http://192.168.178.81:8000/api/99robots/next?occupier=' .. game.Players.LocalPlayer.DisplayName
    local responseRaw = game:HttpGet(api)
	local response = httpService:JSONDecode(responseRaw)
	print(tostring(response))
    
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
    -- Uncomment this when nextServer data is available from GetServers
    -- teleportService:TeleportToPlaceInstance(placeId, nextServer.id, game.Players.LocalPlayer)
end

return module
