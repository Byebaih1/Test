-- ╔══════════════════════════════════════════╗
-- ║        Fluent UI - Crimson Theme         ║
-- ║         Ready-to-use Example             ║
-- ╚══════════════════════════════════════════╝

local REPO = "https://raw.githubusercontent.com/Byebaih1/Test/main/"

local Fluent      = loadstring(game:HttpGet(REPO .. "main.lua"))()
local SaveManager = loadstring(game:HttpGet(REPO .. "SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet(REPO .. "InterfaceManager.lua"))()

-- ──────────────────────────────────────────────
-- Create Window
-- ──────────────────────────────────────────────
local Window = Fluent:CreateWindow({
    Title    = "My Script",
    SubTitle = "v1.0",
    TabWidth = 160,
    Size     = UDim2.fromOffset(580, 460),
    Acrylic  = false,          -- Set true if executor supports acrylic
    Theme    = "Crimson",      -- Dark black + rose-red
    MinimizeKey = Enum.KeyCode.RightControl,
})

-- ──────────────────────────────────────────────
-- Tabs
-- ──────────────────────────────────────────────
local Tabs = {
    Main     = Window:AddTab({ Title = "Main",     Icon = "home" }),
    Combat   = Window:AddTab({ Title = "Combat",   Icon = "sword" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}

-- ══════════════════════════════════════════════
-- MAIN TAB
-- ══════════════════════════════════════════════
do
    local Tab = Tabs.Main

    -- Section: Player
    local PlayerSection = Tab:AddSection("Player")

    PlayerSection:AddToggle("InfiniteJump", {
        Title       = "Infinite Jump",
        Description = "Press Space to jump infinitely",
        Default     = false,
        Callback    = function(Value)
            getgenv().InfiniteJump = Value
        end,
    })

    PlayerSection:AddToggle("Noclip", {
        Title       = "Noclip",
        Description = "Walk through walls",
        Default     = false,
        Callback    = function(Value)
            getgenv().Noclip = Value
        end,
    })

    PlayerSection:AddSlider("WalkSpeed", {
        Title    = "Walk Speed",
        Default  = 16,
        Min      = 0,
        Max      = 300,
        Rounding = 0,
        Callback = function(Value)
            if game.Players.LocalPlayer.Character then
                local Hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if Hum then Hum.WalkSpeed = Value end
            end
        end,
    })

    PlayerSection:AddSlider("JumpPower", {
        Title    = "Jump Power",
        Default  = 50,
        Min      = 0,
        Max      = 500,
        Rounding = 0,
        Callback = function(Value)
            if game.Players.LocalPlayer.Character then
                local Hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if Hum then Hum.JumpPower = Value end
            end
        end,
    })

    -- Section: Utilities
    local UtilSection = Tab:AddSection("Utilities")

    UtilSection:AddButton({
        Title       = "Rejoin Server",
        Description = "Reconnect to current server",
        Callback    = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
        end,
    })

    UtilSection:AddButton({
        Title       = "Copy Game ID",
        Description = "Copy PlaceId to clipboard",
        Callback    = function()
            setclipboard(tostring(game.PlaceId))
            Fluent:Notify({
                Title   = "Copied!",
                Content = "PlaceId: " .. game.PlaceId,
                Duration = 3,
            })
        end,
    })

    UtilSection:AddInput("CustomMessage", {
        Title       = "Custom Chat Message",
        Description = "Message to send in chat",
        Default     = "",
        Placeholder = "Type here...",
        Callback    = function(Value)
            getgenv().CustomMessage = Value
        end,
    })
end

-- ══════════════════════════════════════════════
-- COMBAT TAB
-- ══════════════════════════════════════════════
do
    local Tab = Tabs.Combat

    local AimSection = Tab:AddSection("Aimbot")

    AimSection:AddToggle("AimbotEnabled", {
        Title    = "Aimbot",
        Default  = false,
        Callback = function(Value)
            getgenv().AimbotEnabled = Value
        end,
    })

    AimSection:AddSlider("AimbotFOV", {
        Title    = "FOV Size",
        Default  = 100,
        Min      = 10,
        Max      = 600,
        Rounding = 0,
        Callback = function(Value)
            getgenv().AimbotFOV = Value
        end,
    })

    AimSection:AddSlider("AimbotSmooth", {
        Title    = "Smoothness",
        Default  = 5,
        Min      = 1,
        Max      = 30,
        Rounding = 1,
        Callback = function(Value)
            getgenv().AimbotSmooth = Value
        end,
    })

    AimSection:AddDropdown("AimbotPart", {
        Title   = "Target Hitbox",
        Values  = { "Head", "HumanoidRootPart", "Torso" },
        Default = "Head",
        Callback = function(Value)
            getgenv().AimbotPart = Value
        end,
    })

    local ESPSection = Tab:AddSection("ESP")

    ESPSection:AddToggle("ESPEnabled", {
        Title    = "ESP Boxes",
        Default  = false,
        Callback = function(Value)
            getgenv().ESPEnabled = Value
        end,
    })

    ESPSection:AddToggle("ESPNames", {
        Title    = "Show Names",
        Default  = true,
        Callback = function(Value)
            getgenv().ESPNames = Value
        end,
    })

    ESPSection:AddToggle("ESPHealth", {
        Title    = "Show Health",
        Default  = true,
        Callback = function(Value)
            getgenv().ESPHealth = Value
        end,
    })
end

-- ══════════════════════════════════════════════
-- SETTINGS TAB
-- ══════════════════════════════════════════════
do
    local Tab = Tabs.Settings

    -- Theme picker
    Tab:AddDropdown("Theme", {
        Title   = "UI Theme",
        Values  = Fluent.Themes,
        Default = "Crimson",
        Callback = function(Value)
            Fluent:SetTheme(Value)
        end,
    })

    -- Keybind to minimize
    Tab:AddKeybind("MinimizeKeybind", {
        Title   = "Minimize Key",
        Mode    = "Toggle",
        Default = "RightControl",
        Callback = function(Value)
            -- Fires when toggled
        end,
        ChangedCallback = function(Value)
            Fluent.MinimizeKeybind = Fluent.Options.MinimizeKeybind
        end,
    })

    -- Save/Load section via SaveManager
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)

    InterfaceManager:BuildInterfaceSection(Tab)
    SaveManager:BuildConfigSection(Tab)

    SaveManager:LoadAutoloadConfig()
end

-- ──────────────────────────────────────────────
-- Infinite Jump Logic (runs in background)
-- ──────────────────────────────────────────────
game:GetService("UserInputService").JumpRequest:Connect(function()
    if getgenv().InfiniteJump then
        local Char = game.Players.LocalPlayer.Character
        if Char then
            local Hum = Char:FindFirstChildOfClass("Humanoid")
            if Hum and Hum:GetState() ~= Enum.HumanoidStateType.Dead then
                Hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

-- ──────────────────────────────────────────────
-- Noclip Logic
-- ──────────────────────────────────────────────
game:GetService("RunService").Stepped:Connect(function()
    if getgenv().Noclip then
        local Char = game.Players.LocalPlayer.Character
        if Char then
            for _, Part in ipairs(Char:GetDescendants()) do
                if Part:IsA("BasePart") and Part.CanCollide then
                    Part.CanCollide = false
                end
            end
        end
    end
end)

-- Select first tab on load
Window:SelectTab(1)

Fluent:Notify({
    Title    = "Loaded!",
    Content  = "Script loaded successfully.",
    Duration = 4,
})
