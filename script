-- [ RSO SPAM + WORKING STOP/START BUTTON ]
-- Click STOP = stop | Click START = restart | 100% works
local TextChatService = game:GetService("TextChatService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("StarterGui")

-- Notify
pcall(function()
    CoreGui:SetCore("SendNotification", {
        Title = "RSO Spam",
        Text = "Loaded! /locx on blu app",
        Duration = 5
    })
end)

-- ========== VANITY & MESSAGES ==========
local DISCORD_VANITY = "locx"
local MESSAGES = {
    "finally hit R10 join /"..DISCORD_VANITY.." on blu app if you grinding too!",
    "anyone trading legendaries? /"..DISCORD_VANITY.." on blu app",
    "need a good trade? check /"..DISCORD_VANITY.." on blu app",
    "R9 grind is real come chill in /"..DISCORD_VANITY.." on blu app",
    "yo who tryna duel rn? /"..DISCORD_VANITY.." on blu app",
    "pro tips posted daily → /"..DISCORD_VANITY.." on blu app",
    "best ranked players hang in /"..DISCORD_VANITY.." on blu app",
    "lowkey active trading server /"..DISCORD_VANITY.." on blu app",
    "selling a legendary, offers in /"..DISCORD_VANITY.." on blu app",
    "almost R10 grinding in /"..DISCORD_VANITY.." on blu app",
    "rank reset soon? join /"..DISCORD_VANITY.." on blu app to prep",
    "crazy clutch earlier posted in /"..DISCORD_VANITY.." on blu app",
    "1v1 me for warmup /"..DISCORD_VANITY.." on blu app",
    "any active traders rn? /"..DISCORD_VANITY.." on blu app",
    "yo join /"..DISCORD_VANITY.." on blu app if you want to get better fast",
    "just hit R8 trying for R10, /"..DISCORD_VANITY.." on blu app",
    "value list updated → /"..DISCORD_VANITY.." on blu app",
    "trade legit, no scams /"..DISCORD_VANITY.." on blu app",
    "ranked duels starting soon → /"..DISCORD_VANITY.." on blu app",
    "grind squad online rn /"..DISCORD_VANITY.." on blu app",
    "best clips go in /"..DISCORD_VANITY.." on blu app",
    "join /"..DISCORD_VANITY.." on blu app if you’re close to R10!",
    "new duel strategies posted in /"..DISCORD_VANITY.." on blu app",
    "LF trades for my legendary /"..DISCORD_VANITY.." on blu app",
    "good vibes only /"..DISCORD_VANITY.." on blu app",
    "met some chill players in /"..DISCORD_VANITY.." on blu app",
    "rank climb tips in /"..DISCORD_VANITY.." on blu app",
    "anyone wanna grind together? /"..DISCORD_VANITY.." on blu app",
    "just won 6 in a row /"..DISCORD_VANITY.." on blu app",
    "LMAO that shot was insane /"..DISCORD_VANITY.." on blu app",
    "you won’t win that duel prove it in /"..DISCORD_VANITY.." on blu app",
    "best trade offers always in /"..DISCORD_VANITY.." on blu app",
    "yo R10s help new players in /"..DISCORD_VANITY.." on blu app",
    "hosting duels tourney soon /"..DISCORD_VANITY.." on blu app",
    "server's active rn /"..DISCORD_VANITY.." on blu app",
    "come flex your loadout /"..DISCORD_VANITY.." on blu app",
    "crazy aim tips dropped → /"..DISCORD_VANITY.." on blu app",
    "we chill, we trade, we duel → /"..DISCORD_VANITY.." on blu app",
    "join up if you’re trying to learn fast /"..DISCORD_VANITY.." on blu app",
    "legit traders only /"..DISCORD_VANITY.." on blu app",
    "R10 players are insane fr /"..DISCORD_VANITY.." on blu app",
    "rank grinding vc open rn /"..DISCORD_VANITY.." on blu app",
    "daily giveaways + trade alerts → /"..DISCORD_VANITY.." on blu app",
    "trades moving fast rn /"..DISCORD_VANITY.." on blu app",
    "training duels happening rn /"..DISCORD_VANITY.." on blu app",
    "this server helps you improve fast /"..DISCORD_VANITY.." on blu app",
    "duel montages shared in /"..DISCORD_VANITY.." on blu app",
    "safe trading and chill people /"..DISCORD_VANITY.." on blu app",
    "on my R9 grind rn, come join /"..DISCORD_VANITY.." on blu app",
    "aim clinic open rn /"..DISCORD_VANITY.." on blu app",
    "join for clips, trades & ranked talk → /"..DISCORD_VANITY.." on blu app"
}

local MIN_DELAY = 1.3
local MAX_DELAY = 2.9

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
