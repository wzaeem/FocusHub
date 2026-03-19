-- Focus Hub | Built with Fluent UI
-- Press LEFT CTRL to minimize

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Focus Hub",
    SubTitle = "Best Script Hub",
    TabWidth = 160,
    Size = UDim2.fromOffset(620, 500),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Options = Fluent.Options

local Tabs = {
    Home      = Window:AddTab({ Title = "Home",      Icon = "home"      }),
    Universal = Window:AddTab({ Title = "Universal", Icon = "globe"     }),
    FE        = Window:AddTab({ Title = "FE",        Icon = "zap"       }),
    Games     = Window:AddTab({ Title = "Games",     Icon = "gamepad-2" }),
    Settings  = Window:AddTab({ Title = "Settings",  Icon = "settings"  }),
}

-- ══════════════════════════════════════════
--                   HOME
-- ══════════════════════════════════════════

Tabs.Home:AddParagraph({
    Title = "Welcome to Focus Hub",
    Content = "The best all-in-one Roblox script hub.\nUse the tabs on the left to navigate between categories.\nPress LEFT CTRL to minimize/show the GUI at any time.",
})

Tabs.Home:AddParagraph({
    Title = "How to Use",
    Content = "1. Pick a tab: Universal, FE, or Games.\n2. Click any button to instantly run the script.\n3. Scripts that open their own GUI will appear on screen.",
})

Tabs.Home:AddParagraph({
    Title = "Disclaimer",
    Content = "All scripts are provided for educational purposes only.\nWe are not responsible for any bans or account actions.\nUse at your own risk.",
})

-- ══════════════════════════════════════════
--                UNIVERSAL
-- ══════════════════════════════════════════

Tabs.Universal:AddParagraph({
    Title = "Universal Scripts",
    Content = "These scripts work across most Roblox games.",
})

Tabs.Universal:AddButton({
    Title = "Infinite Yield",
    Description = "Full admin command system for any game",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end,
})

Tabs.Universal:AddButton({
    Title = "Universal ESP",
    Description = "See all players through walls with boxes and names",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua"))()
    end,
})

Tabs.Universal:AddButton({
    Title = "Dex Explorer",
    Description = "Browse the full game instance tree",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
    end,
})

Tabs.Universal:AddButton({
    Title = "SimpleSpy (Remote Spy)",
    Description = "Monitor all RemoteEvents and RemoteFunctions",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
    end,
})

Tabs.Universal:AddButton({
    Title = "Infinite Jump",
    Description = "Press Space to jump infinitely while in the air",
    Callback = function()
        local UIS = game:GetService("UserInputService")
        UIS.JumpRequest:Connect(function()
            local c = game.Players.LocalPlayer.Character
            if c then
                local h = c:FindFirstChildOfClass("Humanoid")
                if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
        Fluent:Notify({ Title = "Focus Hub", Content = "Infinite Jump Enabled!", Duration = 4 })
    end,
})

local SpeedToggle = Tabs.Universal:AddToggle("SpeedToggle", {
    Title = "Speed Hack",
    Description = "Set WalkSpeed to 60",
    Default = false,
    Callback = function(state)
        local c = game.Players.LocalPlayer.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed = state and 60 or 16 end
        end
    end,
})

local JumpToggle = Tabs.Universal:AddToggle("JumpToggle", {
    Title = "High Jump",
    Description = "Set JumpPower to 100",
    Default = false,
    Callback = function(state)
        local c = game.Players.LocalPlayer.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h.JumpPower = state and 100 or 50 end
        end
    end,
})

Tabs.Universal:AddSlider("WalkspeedSlider", {
    Title = "Walk Speed",
    Description = "Adjust your WalkSpeed",
    Default = 16,
    Min = 1,
    Max = 200,
    Rounding = 0,
    Callback = function(Value)
        local c = game.Players.LocalPlayer.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed = Value end
        end
    end,
})

Tabs.Universal:AddSlider("JumpSlider", {
    Title = "Jump Power",
    Description = "Adjust your JumpPower",
    Default = 50,
    Min = 1,
    Max = 300,
    Rounding = 0,
    Callback = function(Value)
        local c = game.Players.LocalPlayer.Character
        if c then
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h.JumpPower = Value end
        end
    end,
})

local NoclipToggle = Tabs.Universal:AddToggle("NoclipToggle", {
    Title = "Noclip",
    Description = "Walk through walls",
    Default = false,
    Callback = function(state)
        _G.FocusNoclip = state
        if state then
            _G.FocusNoclipConn = game:GetService("RunService").Stepped:Connect(function()
                local c = game.Players.LocalPlayer.Character
                if c then
                    for _, v in pairs(c:GetDescendants()) do
                        if v:IsA("BasePart") then v.CanCollide = false end
                    end
                end
            end)
        else
            if _G.FocusNoclipConn then
                _G.FocusNoclipConn:Disconnect()
                _G.FocusNoclipConn = nil
            end
        end
    end,
})

Tabs.Universal:AddButton({
    Title = "Anti AFK",
    Description = "Prevent being kicked for being idle",
    Callback = function()
        local VU = game:GetService("VirtualUser")
        game.Players.LocalPlayer.Idled:Connect(function()
            VU:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VU:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
        Fluent:Notify({ Title = "Focus Hub", Content = "Anti AFK Enabled!", Duration = 4 })
    end,
})

Tabs.Universal:AddButton({
    Title = "Fullbright",
    Description = "Remove all darkness and shadows",
    Callback = function()
        local L = game:GetService("Lighting")
        L.Brightness = 2
        L.ClockTime = 14
        L.FogEnd = 100000
        L.GlobalShadows = false
        L.Ambient = Color3.fromRGB(255, 255, 255)
        Fluent:Notify({ Title = "Focus Hub", Content = "Fullbright Enabled!", Duration = 4 })
    end,
})

Tabs.Universal:AddButton({
    Title = "Reset Lighting",
    Description = "Restore default game lighting",
    Callback = function()
        local L = game:GetService("Lighting")
        L.Brightness = 1
        L.ClockTime = 14
        L.FogEnd = 100000
        L.GlobalShadows = true
        L.Ambient = Color3.fromRGB(70, 70, 70)
        Fluent:Notify({ Title = "Focus Hub", Content = "Lighting Reset!", Duration = 4 })
    end,
})

Tabs.Universal:AddButton({
    Title = "Rejoin Server",
    Description = "Quickly rejoin the current game",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        TeleportService:Teleport(game.PlaceId, game.Players.LocalPlayer)
    end,
})

-- ══════════════════════════════════════════
--                   FE
-- ══════════════════════════════════════════

Tabs.FE:AddParagraph({
    Title = "FE Scripts",
    Content = "FilteringEnabled scripts — client-side effects that work on live servers.",
})

local FlySection = Tabs.FE:AddSection("Movement")

FlySection:AddToggle("FEFlyToggle", {
    Title = "FE Fly",
    Description = "Fly around the map",
    Default = false,
    Callback = function(state)
        local Players = game:GetService("Players")
        local lp = Players.LocalPlayer
        local char = lp.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end

        if state then
            hum.PlatformStand = true
            _G.FlyBV = Instance.new("BodyVelocity", hrp)
            _G.FlyBV.Velocity = Vector3.new(0, 0, 0)
            _G.FlyBV.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            _G.FlyGyro = Instance.new("BodyGyro", hrp)
            _G.FlyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
            _G.FlyGyro.P = 1e4

            _G.FlyConn = game:GetService("RunService").Heartbeat:Connect(function()
                local cam = workspace.CurrentCamera
                local UIS = game:GetService("UserInputService")
                local speed = 50
                local dir = Vector3.new(0, 0, 0)
                if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
                if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0, 1, 0) end
                if _G.FlyBV then _G.FlyBV.Velocity = dir * speed end
                if _G.FlyGyro then _G.FlyGyro.CFrame = cam.CFrame end
            end)
        else
            hum.PlatformStand = false
            if _G.FlyConn then _G.FlyConn:Disconnect() _G.FlyConn = nil end
            if _G.FlyBV then _G.FlyBV:Destroy() _G.FlyBV = nil end
            if _G.FlyGyro then _G.FlyGyro:Destroy() _G.FlyGyro = nil end
        end
    end,
})

local FEToolsSection = Tabs.FE:AddSection("Tools")

FEToolsSection:AddButton({
    Title = "FE Btools",
    Description = "Delete and move parts in any game",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/8TfWVWaQ"))()
    end,
})

FEToolsSection:AddButton({
    Title = "FE Animation Spammer",
    Description = "Play any animation by ID",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/AJGf5QVm"))()
    end,
})

FEToolsSection:AddButton({
    Title = "FE Invisible",
    Description = "Make your character invisible to others",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local cf = hrp.CFrame
        char:MoveTo(workspace.FallenPartsDestroyHeight and Vector3.new(0, workspace.FallenPartsDestroyHeight - 100, 0) or Vector3.new(0, -1e4, 0))
        task.wait(0.5)
        char:MoveTo(cf.Position)
        Fluent:Notify({ Title = "Focus Hub", Content = "FE Invisible Applied!", Duration = 4 })
    end,
})

FEToolsSection:AddButton({
    Title = "FE Fling",
    Description = "Fling players using FE",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/U6YPBpxZ"))()
    end,
})

FEToolsSection:AddButton({
    Title = "FE Spin",
    Description = "Spin players around you",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/E8pLcZdY"))()
    end,
})

FEToolsSection:AddButton({
    Title = "FE Kill Script",
    Description = "Kill players via FE method",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/LqmMdQDg"))()
    end,
})

FEToolsSection:AddButton({
    Title = "FE Freeze Players",
    Description = "Freeze nearby players",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/VR7BXdF0"))()
    end,
})

-- ══════════════════════════════════════════
--                  GAMES
-- ══════════════════════════════════════════

-- ─── BED WARS ───────────────────────────
local SecBW = Tabs.Games:AddSection("Bed Wars")

SecBW:AddButton({
    Title = "Bed Wars Hub",
    Description = "Auto buy, ESP, fly, kill aura and more",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XAXA-hub/BedWarsScript/main/script.lua"))()
    end,
})

SecBW:AddButton({
    Title = "Bed Wars ESP",
    Description = "Track enemies through walls",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/VKuqjBpT"))()
    end,
})

SecBW:AddButton({
    Title = "Bed Wars Auto Buy",
    Description = "Automatically buy resources and upgrades",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/Zy8HkGdN"))()
    end,
})

-- ─── BLOX FRUITS ────────────────────────
local SecBF = Tabs.Games:AddSection("Blox Fruits")

SecBF:AddButton({
    Title = "Blox Fruits Hub",
    Description = "Auto farm, mastery, teleport, fruits and more",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptblox/Blox-Fruits-Script/main/BloxFruitsScript.lua"))()
    end,
})

SecBF:AddButton({
    Title = "Blox Fruits Auto Raid",
    Description = "Automatically complete raids",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/yZm9gNrM"))()
    end,
})

-- ─── MURDER MYSTERY 2 ───────────────────
local SecMM2 = Tabs.Games:AddSection("Murder Mystery 2")

SecMM2:AddButton({
    Title = "MM2 ESP + Role Reveal",
    Description = "See murderer, sheriff and innocents",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XAXA-hub/MM2-Script/main/script.lua"))()
    end,
})

SecMM2:AddButton({
    Title = "MM2 Coin Farm",
    Description = "Auto collect coins every round",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/3BnTkcRp"))()
    end,
})

-- ─── ARSENAL ────────────────────────────
local SecArs = Tabs.Games:AddSection("Arsenal")

SecArs:AddButton({
    Title = "Arsenal Aimbot + ESP",
    Description = "Full Arsenal cheat pack",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/9VxNaJcP"))()
    end,
})

SecArs:AddButton({
    Title = "Arsenal Silent Aim",
    Description = "Legit-looking silent aimbot",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/hQ4NfJzR"))()
    end,
})

-- ─── BROOKHAVEN ─────────────────────────
local SecBH = Tabs.Games:AddSection("Brookhaven RP")

SecBH:AddButton({
    Title = "Brookhaven Admin Script",
    Description = "Fly, speed, admin and troll tools",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptblox/Brookhaven-RP-Script/main/script.lua"))()
    end,
})

-- ─── ADOPT ME ───────────────────────────
local SecAM = Tabs.Games:AddSection("Adopt Me")

SecAM:AddButton({
    Title = "Adopt Me Auto Farm",
    Description = "Auto tasks, money and pet care",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/qW5yZeBa"))()
    end,
})

-- ─── JAILBREAK ──────────────────────────
local SecJB = Tabs.Games:AddSection("Jailbreak")

SecJB:AddButton({
    Title = "Jailbreak Script Hub",
    Description = "Auto rob, ESP, vehicle mods and more",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptblox/Jailbreak-Script/main/script.lua"))()
    end,
})

SecJB:AddButton({
    Title = "Jailbreak Auto Rob",
    Description = "Automatically rob banks and stores",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/K9vNaRpT"))()
    end,
})

-- ─── PET SIMULATOR X ────────────────────
local SecPSX = Tabs.Games:AddSection("Pet Simulator X")

SecPSX:AddButton({
    Title = "Pet Sim X Auto Farm",
    Description = "Auto collect coins, hatch eggs and sell pets",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptblox/PetSimulatorX-Script/main/script.lua"))()
    end,
})

-- ─── COMBAT WARRIORS ────────────────────
local SecCW = Tabs.Games:AddSection("Combat Warriors")

SecCW:AddButton({
    Title = "Combat Warriors Hub",
    Description = "Aimbot, ESP, kill aura and speed",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/tBfMp3zX"))()
    end,
})

-- ─── NATURAL DISASTER ───────────────────
local SecNDS = Tabs.Games:AddSection("Natural Disaster Survival")

SecNDS:AddButton({
    Title = "NDS Safe Spot Teleport",
    Description = "Auto survive every disaster",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/K2wZnU5L"))()
    end,
})

-- ─── TOWER OF HELL ──────────────────────
local SecToH = Tabs.Games:AddSection("Tower of Hell")

SecToH:AddButton({
    Title = "Tower of Hell Fly / Skip",
    Description = "Fly straight to the top",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/P5bZcNkL"))()
    end,
})

-- ─── DA HOOD ────────────────────────────
local SecDH = Tabs.Games:AddSection("Da Hood")

SecDH:AddButton({
    Title = "Da Hood Script Hub",
    Description = "Aimbot, ESP, silent aim and more",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/rBfHnJkM"))()
    end,
})

SecDH:AddButton({
    Title = "Da Hood Aimbot",
    Description = "Lock onto players automatically",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/wYcNpTzQ"))()
    end,
})

-- ─── FLEE THE FACILITY ──────────────────
local SecFTF = Tabs.Games:AddSection("Flee the Facility")

SecFTF:AddButton({
    Title = "Flee The Facility ESP",
    Description = "See beast, survivors and computers",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/GnZxcVdP"))()
    end,
})

-- ─── DOORS ──────────────────────────────
local SecDoors = Tabs.Games:AddSection("DOORS")

SecDoors:AddButton({
    Title = "DOORS ESP + Reach",
    Description = "See all entities and items",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/Tc5bNkXp"))()
    end,
})

-- ─── BREAKING POINT ─────────────────────
local SecBP = Tabs.Games:AddSection("Breaking Point")

SecBP:AddButton({
    Title = "Breaking Point Aimbot",
    Description = "Auto shoot the correct player",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/HvXnQjZk"))()
    end,
})

-- ─── ANIME DEFENDERS ────────────────────
local SecAD = Tabs.Games:AddSection("Anime Defenders")

SecAD:AddButton({
    Title = "Anime Defenders Auto Farm",
    Description = "Auto wave clear and gem farm",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/WqNzRpYm"))()
    end,
})

-- ══════════════════════════════════════════
--                 SETTINGS
-- ══════════════════════════════════════════

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

-- ══════════════════════════════════════════
--                   INIT
-- ══════════════════════════════════════════

SaveManager:LoadAutoloadConfig()
Window:SelectTab(1)

Fluent:Notify({
    Title = "Focus Hub",
    Content = "Successfully loaded! Enjoy your scripts.",
    SubContent = "Press LEFT CTRL to minimize",
    Duration = 6,
})