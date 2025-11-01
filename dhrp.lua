-- [ RSO SPAM + AUTO SERVER HOP FOR MVS DUELS ]
-- Game: https://www.roblox.com/games/12355337193/
-- Vanity: /locx | by @5vqr | Hops every 10 mins

local TextChatService = game:GetService("TextChatService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("StarterGui")

-- Notify
pcall(function()
    CoreGui:SetCore("SendNotification", {
        Title = "RSO COM",
        Text = "Spamming 10 mins → Hop → Repeat",
        Duration = 6
    })
end)

-- ========== VANITY & MESSAGES ==========
local DISCORD_VANITY = "/dare"
local MESSAGES = {
    "vc’s wild rn 💀 everyone talking over each other like it’s a podcast, come vibe in "..DISCORD_VANITY,
    "someone dropped a nitro bomb mid-call 😭 whole vc went silent for a sec then screamed "..DISCORD_VANITY,
    "moving funds like a crypto bro 💸 man said he’s making trades between songs "..DISCORD_VANITY,
    "who using voice filters again 😭 half of vc sound like robots rn "..DISCORD_VANITY,
    "egirl started singing lo-fi covers mid convo 😭 vc turned into an open mic "..DISCORD_VANITY,
    "rich talk only 💅 nitro boosts, banner flexes, vanity tags flying around "..DISCORD_VANITY,
    "everyone flexing nitro gifts like they investors 💀 someone just gifted 3 for fun "..DISCORD_VANITY,
    "vc louder than my thoughts rn 💀 mics peaking left and right "..DISCORD_VANITY,
    "someone arguing over who has the better mic setup again 😭 engineers in the chat "..DISCORD_VANITY,
    "nitro wars started 😤 everyone spamming gifts like it’s a bidding war "..DISCORD_VANITY,
    "someone boosted the server just to say they did it first 💅 priorities fr "..DISCORD_VANITY,
    "bro said he’s moving funds like elon while sharing memes in vc 💀 "..DISCORD_VANITY,
    "egirl dropped a playlist link and half vc started vibing instantly 🔥 "..DISCORD_VANITY,
    "vibe check failed instantly 😭 someone joined and killed the energy "..DISCORD_VANITY,
    "why is every vc convo 80% laughter and 20% chaos 💀 "..DISCORD_VANITY,
    "someone just flexed a level 3 badge like it’s a Rolex 😭 "..DISCORD_VANITY,
    "nitro flex comp ongoing 💸 ppl actually counting boosts rn "..DISCORD_VANITY,
    "someone joined saying ‘who got rizz?’ 😭 instantly muted "..DISCORD_VANITY,
    "egirl vs eboy debate part 6 💀 no one winning, just noise "..DISCORD_VANITY,
    "mic cut mid punchline 😭 ruined the joke completely "..DISCORD_VANITY,
    "everyone acting like influencers rn 💅 camera angles and lighting check "..DISCORD_VANITY,
    "vc energy’s unmatched rn 😭 someone freestyling over elevator music "..DISCORD_VANITY,
    "fake nitro flexers exposed 😭 screenshots dropping soon "..DISCORD_VANITY,
    "crypto trader joined vc and started talking ROI mid convo 💀 "..DISCORD_VANITY,
    "someone literally bought nitro while on call 💸 dedication fr "..DISCORD_VANITY,
    "soundboards wild rn 😭 random explosions mid convo "..DISCORD_VANITY,
    "y’all fighting over profile banners again 💀 every day it’s something "..DISCORD_VANITY,
    "that vc laugh contagious 😭 no one even knows the joke anymore "..DISCORD_VANITY,
    "vc muted itself from chaos 💀 mods couldn’t take it "..DISCORD_VANITY,
    "someone changed their name mid call to ‘richest in vc’ 💅 "..DISCORD_VANITY,
    "camera on check 🎥 someone literally streaming their desk setup rn "..DISCORD_VANITY,
    "bro spending nitro like it’s pocket change 💀 calm down elon "..DISCORD_VANITY,
    "egirl playlist playing rn 😭 no skips allowed "..DISCORD_VANITY,
    "why’s vc this dramatic rn 💅 like a live reality show "..DISCORD_VANITY,
    "soundboard spam hitting max volume 😭 save my ears "..DISCORD_VANITY,
    "someone calling their mic studio grade while it’s crackling 💀 "..DISCORD_VANITY,
    "everyone flexing their discord badges like they matter 💎 "..DISCORD_VANITY,
    "vc mic checks every 3 minutes 😭 perfectionists fr "..DISCORD_VANITY,
    "spotify streamers taking over rn 🎶 whole call vibing lowkey "..DISCORD_VANITY,
    "bro turned on cam just to flex LED lights 💻 priorities "..DISCORD_VANITY,
    "vc loud, messy, chaotic — perfect energy rn 😭 "..DISCORD_VANITY,
    "rich talk & chaos combo unmatched 💸 this call feel like a movie "..DISCORD_VANITY,
    "someone comparing setups rn 😭 rgb wars started "..DISCORD_VANITY,
    "vc chill till someone mentioned nitro 😭 chaos unleashed "..DISCORD_VANITY,
    "everyone vibing like it’s 2am even tho it’s 4 in the afternoon 🌙 "..DISCORD_VANITY,
    "someone said ‘i’m him’ mid convo 💀 entire call stopped laughing "..DISCORD_VANITY,
    "nitro giveaways causing civil war rn 🎁 people fighting for codes "..DISCORD_VANITY,
    "vc so unserious rn 😭 someone playing elevator music on loop "..DISCORD_VANITY,
    "new people joining like ‘what’s going on here’ 😭 chaos explained badly "..DISCORD_VANITY,
    "mic echo bouncing like we in a concert hall 💀 "..DISCORD_VANITY,
    "no one talking sense rn just noise and laughter 💀 "..DISCORD_VANITY,
    "vc energy 100/10 rn 😭 no idea what’s happening but I’m here for it "..DISCORD_VANITY
}


local MIN_DELAY = 2.1
local MAX_DELAY = 5.3
local SPAM_DURATION = 60  -- 1 minute
local PLACE_ID = 12355337193  -- Murderers VS Sheriffs: DUELS

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

-- ========== SERVER HOP (ONLY MVS DUELS) ==========
local function serverHop()
    pcall(function()
        CoreGui:SetCore("SendNotification", {
            Title = "RSO Hop",
            Text = "1 mins up — Hopping to MVS DUELS...",
            Duration = 4
        })
    end)

    local url = "https://games.roblox.com/v1/games/"..PLACE_ID.."/servers/Public?sortOrder=Asc&limit=100"
    local success, servers = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)

    if not success or not servers or not servers.data then
        TeleportService:Teleport(PLACE_ID)
        return
    end

    local validServers = {}
    for _, v in pairs(servers.data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            table.insert(validServers, v.id)
        end
    end

    if #validServers > 0 then
        TeleportService:TeleportToPlaceInstance(PLACE_ID, validServers[math.random(#validServers)])
    else
        TeleportService:Teleport(PLACE_ID)
    end
end

-- ========== SPAM LOOP WITH HOP ==========
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

-- ========== START ON LOAD ==========
startSpam()
