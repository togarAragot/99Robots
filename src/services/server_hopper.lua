local allIds = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local deleted = false
local teleportService = game:GetService("TeleportService")
local httpService = game:GetService("HttpService")

local fileLoaded = pcall(function()
	allIds = httpService:JSONDecode(readfile("server-hop-temp.json"))
end)

if not fileLoaded then
	table.insert(allIds, actualHour)
	pcall(function()
		writefile("server-hop-temp.json", httpService:JSONEncode(allIds))
	end)

end

local function TPReturner(placeId)
	local site;
	
	if foundAnything == "" then
		site = httpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. placeId .. '/servers/0?sortOrder=2&excludeFullGames=true&limit=50'))
	else
		site = httpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. placeId .. '/servers/0?sortOrder=2&excludeFullGames=true&limit=50&cursor=' .. foundAnything))
	end

	local id = ""
	
	if site.nextPageCursor and site.nextPageCursor ~= "null" and site.nextPageCursor ~= nil then
		foundAnything = site.nextPageCursor
	end

	local num = 0;
	
	for i,v in pairs(site.data) do
		local possible = true
		id = tostring(v.id)
		for _,existingId in pairs(allIds) do
			if num ~= 0 then
				if id == tostring(existingId) then
						possible = false
				end
			else
				if tonumber(actualHour) ~= tonumber(existingId) then
					local delFile = pcall(function()
						delfile("server-hop-temp.json")
						allIds = {}
						table.insert(allIds, actualHour)
					end)
				end
			end
			num = num + 1
		end
		
		if possible == true then
			table.insert(allIds, id)
			task.wait()
			pcall(function()
				writefile("server-hop-temp.json", httpService:JSONEncode(allIds))
				task.wait()
				print("trying top teleport somewhere")
				teleportService:TeleportToPlaceInstance(placeId, id, game.Players.LocalPlayer)
			end)
			task.wait(4)
		end
	end
end

local module = {}
function module:Teleport(placeId)
	while task.wait() do
		pcall(function()
			TPReturner(placeId)
			if foundAnything ~= "" then
				TPReturner(placeId)
			end
		end)
	end
end
return module