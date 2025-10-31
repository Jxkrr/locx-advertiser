-- [ RSO SPAM + WORKING STOP/START BUTTON ]
-- Click STOP = stop | Click START = restart | 100% works
local TextChatService = game:GetService("TextChatService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("StarterGui")

-- Notify
pcall(function()
    CoreGui:SetCore("SendNotification", {
        Title = "RSO Spam",
        Text = "Loaded! @5vqr on blu app",
        Duration = 5
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

-- ========== TINY BUTTON GUI ==========
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
StopButton.TextColor3 = Color3.new(1, 1, 1)
StopButton.Font = Enum.Font.GothamBold
StopButton.TextScaled = true
StopButton.Active = true
StopButton.Draggable = true

Corner.Parent = StopButton
Corner.CornerRadius = UDim.new(0, 8)

-- ========== SPAM LOOP (RESTARTABLE) ==========
local function startSpam()
    if SpamTask then return end
    SpamTask = task.spawn(function()
        while Spamming do
            if ChatChannel then
                local msg = MESSAGES[math.random(#MESSAGES)]
                pcall(function()
                    ChatChannel:SendAsync(msg)
                end)
            end
            task.wait(MIN_DELAY + math.random() * (MAX_DELAY - MIN_DELAY))
        end
        SpamTask = nil -- Clear when done
    end)
end

local function stopSpam()
    Spamming = false
    if SpamTask then
        task.cancel(SpamTask)
        SpamTask = nil
    end
end

-- ========== BUTTON CLICK ==========
StopButton.MouseButton1Click:Connect(function()
    if Spamming then
        -- STOP
        stopSpam()
        StopButton.Text = "START"
        StopButton.BackgroundColor3 = Color3.fromRGB(50, 220, 50)
    else
        -- START
        Spamming = true
        StopButton.Text = "STOP"
        StopButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        startSpam()
    end
end)

-- ========== START ON LOAD ==========
startSpam()
