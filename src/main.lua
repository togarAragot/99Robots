local serverHopperUrl = "https://raw.githubusercontent.com/togarAragot/99Robots/refs/heads/main/src/services/server_hopper.lua"
local serverHopperScript = game:HttpGet(serverHopperUrl)

print("Fetched server_hopper.lua: " .. tostring(serverHopperScript))

local chunk, err = loadstring(serverHopperScript)

if not chunk then
    error("Failed to load the server_hopper script: " .. tostring(err))
end

local module = chunk()

if module == nil then
    error("Module loaded from server_hopper.lua is nil")
end
 -- Load ServerHopper
local messages = loadstring(game:HttpGet("https://raw.githubusercontent.com/togarAragot/99Robots/refs/heads/main/src/template-messages.lua"))() -- Load messages
while true do
    local message = messages[math.random(#messages)]
    local TextChatService = game:GetService("TextChatService")
    local generalChannel: TextChannel = TextChatService:WaitForChild("TextChannels").RBXGeneral
    generalChannel:SendAsync(message)
    module:Teleport(game.PlaceId)
    wait(5)
end