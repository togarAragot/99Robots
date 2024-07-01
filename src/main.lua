local module = loadstring(game:HttpGet(""))() -- Load ServerHopper
local messages = loadstring(game:HttpGet(""))() -- Load messages
while true do
    local message = messages[math.random(#messages)]
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message)
    module:Teleport(game.placeId)
    wait()
end