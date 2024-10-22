local serverHopperScript = game:HttpGet("https://raw.githubusercontent.com/togarAragot/99Robots/refs/heads/main/src/services/server_hopper.lua")
print(serverHopperScript)
local module = loadstring(serverHopperScript)() -- Load ServerHopper
local messages = loadstring(game:HttpGet("https://raw.githubusercontent.com/togarAragot/99Robots/refs/heads/main/src/template-messages.lua"))() -- Load messages
while true do
    local message = messages[math.random(#messages)]
    local TextChatService = game:GetService("TextChatService")
    local generalChannel: TextChannel = TextChatService:WaitForChild("TextChannels").RBXGeneral
    generalChannel:SendAsync(message)
    module:Teleport(game.PlaceId)
    wait(5)
end