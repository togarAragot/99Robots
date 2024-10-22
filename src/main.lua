local serverHopperUrl = 'https://raw.githubusercontent.com/togarAragot/99Robots/refs/heads/main/src/services/server_hopper.lua'
local serverHopperScript = game:HttpGet(serverHopperUrl)

local messagesUrl = 'https://raw.githubusercontent.com/togarAragot/99Robots/refs/heads/main/src/template-messages.lua'
local messagesRaw = game:HttpGet(messagesUrl)

local module = loadstring(serverHopperScript)()
local messages = loadstring(messagesRaw)() -- Load messages

while true do
    local message = messages[math.random(#messages)]
    local TextChatService = game:GetService('TextChatService')
    local generalChannel: TextChannel = TextChatService:WaitForChild('TextChannels').RBXGeneral
    --generalChannel:SendAsync(message)
    module:Teleport(game.PlaceId)
    wait(2)
    
    -- Break after the first iteration
    break
end

print('done executing')
