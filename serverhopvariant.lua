-- [ RSO SPAM + JOIN FULLER SERVERS (80%+) + AUTO HOP ]
-- Game: MVS DUELS | Vanity: /locx | by @5vqr

local TextChatService = game:GetService("TextChatService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("StarterGui")

-- Notify
pcall(function()
    CoreGui:SetCore("SendNotification", {
        Title = "RSO Full Server",
        Text = "Hopping to 80%+ full servers every 10 mins",
        Duration = 6
    })
end)

-- ========== VANITY & MESSAGES ==========
local DISCORD_VANITY = "/locx"
local MESSAGES = {
    "finally hit R10 chillin w "..DISCORD_VANITY.." crew rn! | by @5vqr",
    "anyone trading legendaries? check "..DISCORD_VANITY.." hub | by @5vqr",
    "need a good trade? peek "..DISCORD_VANITY.." spot | by @5vqr",
    "R9 grind got me tired hanging w/ "..DISCORD_VANITY.." squad | by @5vqr",
    "who down for duels rn "..DISCORD_VANITY.." vibes | by @5vqr",
    "pro tips dropped in "..DISCORD_VANITY.." server | by @5vqr",
    "ranked mains all chill at "..DISCORD_VANITY.." | by @5vqr",
    "active trading zone "..DISCORD_VANITY.." | by @5vqr",
    "selling a legendary, hmu @ "..DISCORD_VANITY.." | by @5vqr",
    "almost R10 grinding w "..DISCORD_VANITY.." fam | by @5vqr",
    "rank reset soon, prepping w/ "..DISCORD_VANITY.." | by @5vqr",
    "crazy clutch earlier posted to "..DISCORD_VANITY.." | by @5vqr",
    "1v1 practice later? "..DISCORD_VANITY.." ppl online rn | by @5vqr",
    "any traders online rn? "..DISCORD_VANITY.." chat’s moving | by @5vqr",
    "yo come learn fast "..DISCORD_VANITY.." fam teaching strats | by @5vqr",
    "just hit R8 R10 soon, "..DISCORD_VANITY.." helping me grind | by @5vqr",
    "value list updated in "..DISCORD_VANITY.." hub | by @5vqr",
    "trade clean "..DISCORD_VANITY.." keeps it safe | by @5vqr",
    "ranked duels open rn "..DISCORD_VANITY.." queueing up | by @5vqr",
    "grind group live rn "..DISCORD_VANITY.." | by @5vqr",
    "best clips drop in "..DISCORD_VANITY.." daily | by @5vqr",
    "close to R10? "..DISCORD_VANITY.." got you covered | by @5vqr",
    "new duel strats out now "..DISCORD_VANITY.." | by @5vqr",
    "LF legendary swap "..DISCORD_VANITY.." market active | by @5vqr",
    "good vibes only "..DISCORD_VANITY.." always chill | by @5vqr",
    "met real ones in "..DISCORD_VANITY.." fr | by @5vqr",
    "rank tips posted up "..DISCORD_VANITY.." | by @5vqr",
    "grind buddies in "..DISCORD_VANITY.." rn | by @5vqr",
    "6 win streak posting in "..DISCORD_VANITY.." | by @5vqr",
    "crazy snipe clip in "..DISCORD_VANITY.." | by @5vqr",
    "you think you can beat me? prove it "..DISCORD_VANITY.." | by @5vqr",
    "best trade offers "..DISCORD_VANITY.." hub | by @5vqr",
    "R10s helping new players "..DISCORD_VANITY.." | by @5vqr",
    "hosting duels soon "..DISCORD_VANITY.." lineup ready | by @5vqr",
    "server popping rn "..DISCORD_VANITY.." | by @5vqr",
    "flex your loadout in "..DISCORD_VANITY.." showcase | by @5vqr",
    "aim drills posted "..DISCORD_VANITY.." | by @5vqr",
    "we duel, trade, chill "..DISCORD_VANITY.." | by @5vqr",
    "trying to learn fast? "..DISCORD_VANITY.." | by @5vqr",
    "legit trades only "..DISCORD_VANITY.." | by @5vqr",
    "R10s cracked fr "..DISCORD_VANITY.." | by @5vqr",
    "rank vc active rn "..DISCORD_VANITY.." | by @5vqr",
    "daily alerts + rewards "..DISCORD_VANITY.." | by @5vqr",
    "trades moving quick "..DISCORD_VANITY.." | by @5vqr",
    "duel training up rn "..DISCORD_VANITY.." | by @5vqr",
    "improving fast w "..DISCORD_VANITY.." fam | by @5vqr",
    "montages dropping "..DISCORD_VANITY.." | by @5vqr",
    "safe trading + chill ppl "..DISCORD_VANITY.." | by @5vqr",
    "R9 grind continues "..DISCORD_VANITY.." helpin out | by @5vqr",
    "aim clinic open "..DISCORD_VANITY.." | by @5vqr",
    "clips, trades & ranked talk → "..DISCORD_VANITY.." | by @5vqr"
}

local MIN_DELAY = 2.1
local MAX_DELAY = 5.3
local SPAM_DURATION = 60  -- 1 minutes
local PLACE_ID = 12355337193
local MIN_FILL_PERCENT = 0.8  -- 80%+ full

-- Auto find chat channel
local function getChannel()
    if TextChatService:FindFirstChild("TextChannels") then
        for _, ch in TextChatService.TextChannels:GetChildren() do
            if ch:IsA("TextChannel") and (ch.Name == "RBXGeneral" or ch.Name:find("All")) then
                return ch
            end
        end
        return TextChatService.TextChannels:GetChildren()[1]
    end
    return nil
end

local ChatChannel = getChannel()
local Spamming = true
local SpamTask = nil

-- ========== SERVER HOP TO FULLER SERVERS ==========
local function serverHop()
    pcall(function()
        CoreGui:SetCore("SendNotification", {
            Title = "RSO Hop",
            Text = "Finding 80%+ full server...",
            Duration = 4
        })
    end)

    local url = "https://games.roblox.com/v1/games/"..PLACE_ID.."/servers/Public?sortOrder=Desc&limit=100"
    local success, servers = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)

    if not success or not servers or not servers.data then
        TeleportService:Teleport(PLACE_ID)
        return
    end

    local candidates = {}
    for _, v in pairs(servers.data) do
        if v.id ~= game.JobId and v.playing < v.maxPlayers then
            local fillRatio = v.playing / v.maxPlayers
            if fillRatio >= MIN_FILL_PERCENT then
                table.insert(candidates, {id = v.id, fill = fillRatio, playing = v.playing})
            end
        end
    end

    if #candidates > 0 then
        -- Sort by most full
        table.sort(candidates, function(a, b) return a.fill > b.fill end)
        local target = candidates[1].id
        pcall(function()
            CoreGui:SetCore("SendNotification", {
                Title = "RSO Hop",
                Text = "Joining full server ("..candidates[1].playing.."/"..(candidates[1].playing / candidates[1].fill)..")",
                Duration = 3
            })
        end)
        TeleportService:TeleportToPlaceInstance(PLACE_ID, target)
    else
        -- Fallback: random non-empty
        local fallback = {}
        for _, v in pairs(servers.data) do
            if v.id ~= game.JobId and v.playing > 0 and v.playing < v.maxPlayers then
                table.insert(fallback, v.id)
            end
        end
        if #fallback > 0 then
            TeleportService:TeleportToPlaceInstance(PLACE_ID, fallback[math.random(#fallback)])
        else
            TeleportService:Teleport(PLACE_ID)
        end
    end
end

-- ========== SPAM LOOP ==========
local function startSpam()
    if SpamTask then return end
    SpamTask = task.spawn(function()
        local startTime = tick()
        while Spamming and (tick() - startTime) < SPAM_DURATION do
            if ChatChannel then
                local msg = MESSAGES[math.random(#MESSAGES)]
                pcall(function()
                    ChatChannel:SendAsync(msg)
                end)
            end
            task.wait(MIN_DELAY + math.random() * (MAX_DELAY - MIN_DELAY))
        end

        if Spamming then
            serverHop()
        end
        SpamTask = nil
    end)
end

local function stopSpam()
    Spamming = false
    if SpamTask then task.cancel(SpamTask); SpamTask = nil end
end

-- ========== STOP/START BUTTON ==========
local ScreenGui = Instance.new("ScreenGui")
local StopButton = Instance.new("TextButton")
local Corner = Instance.new("UICorner")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "RSO_SpamControl"

StopButton.Parent = ScreenGui
StopButton.Size = UDim2.new(0, 100, 0, 40)
StopButton.Position = UDim2.new(1, -110, 0, 10)
StopButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
StopButton.Text = "STOP"
StopButton.TextColor3 = Color3.new(1,1,1)
StopButton.Font = Enum.Font.GothamBold
StopButton.TextScaled = true
StopButton.Draggable = true
Corner.Parent = StopButton
Corner.CornerRadius = UDim.new(0,8)

StopButton.MouseButton1Click:Connect(function()
    if Spamming then
        stopSpam()
        StopButton.Text = "START"
        StopButton.BackgroundColor3 = Color3.fromRGB(50,220,50)
    else
        Spamming = true
        StopButton.Text = "STOP"
        StopButton.BackgroundColor3 = Color3.fromRGB(220,50,50)
        ChatChannel = getChannel()
        startSpam()
    end
end)

-- START
startSpam()
