local module = loadstring(game:HttpGet("https://raw.githubusercontent.com/togarAragot/99Robots/main/src/services/server_hopper.lua?token=GHSAT0AAAAAACTWI5MYN2Z3RDEV32J5SHOOZUC3UKQ"))() -- Load ServerHopper
local messages = loadstring(game:HttpGet("https://raw.githubusercontent.com/togarAragot/99Robots/main/src/template-messages.lua?token=GHSAT0AAAAAACTWI5MZMAFZJ24GR2ZXC44UZUC6GPA"))() -- Load messages
while true do
    local message = messages[math.random(#messages)]
    local TextChatService = game:GetService("TextChatService")
    local generalChannel: TextChannel = TextChatService:WaitForChild("TextChannels").RBXGeneral
    generalChannel:SendAsync(message)
    module:Teleport(game.placeId)
    wait()
end