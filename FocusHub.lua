-- ///////////////////////////////////////////////
-- //          FOCUS HUB - Fluent UI            //
-- //         Script Hub by Focus              //
-- ///////////////////////////////////////////////

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.zip"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- ============================================================
--  WINDOW
-- ============================================================
local Window = Fluent:CreateWindow({
    Title = "Focus Hub",
    SubTitle = "Script Hub",
    TabWidth = 160,
    Size = UDim2.fromOffset(600, 480),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl,
})

-- ============================================================
--  TABS
-- ============================================================
local Tabs = {
    Home      = Window:AddTab({ Title = "Home",      Icon = "home"      }),
    Universal = Window:AddTab({ Title = "Universal", Icon = "globe"     }),
    FE        = Window:AddTab({ Title = "FE",        Icon = "zap"       }),
    Games     = Window:AddTab({ Title = "Games",     Icon = "gamepad-2" }),
    Settings  = Window:AddTab({ Title = "Settings",  Icon = "settings"  }),
}

-- ============================================================
--  HOME TAB
-- ============================================================
Tabs.Home:AddParagraph({
    Title = "Welcome to Focus Hub",
    Content = "A powerful all-in-one script hub built with Fluent UI.\nNavigate the tabs on the left to find scripts.\n\nPress LEFT CTRL to minimize / show the GUI.",
})

Tabs.Home:AddParagraph({
    Title = "How to Use",
    Content = "1. Go to the tab matching what you need.\n2. Click any button to instantly execute that script.\n3. Some scripts open their own GUI with more options.",
})

Tabs.Home:AddParagraph({
    Title = "⚠ Disclaimer",
    Content = "All scripts are for educational purposes only.\nUse at your own risk. We are not responsible for bans.",
})

-- ============================================================
--  UNIVERSAL TAB
-- ============================================================
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
    Description = "See all players through walls with boxes & names",
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
    Description = "Monitor all RemoteEvents & RemoteFunctions",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
    end,
})

Tabs.Universal:AddButton({
    Title = "Noclip Toggle",
    Description = "Walk through walls — click again to toggle off",
    Callback = function()
        _G.Noclip = not (_G.Noclip or false)
        if _G.Noclip then
            _G.NoclipConn = game:GetService("RunService").Stepped:Connect(function()
                if game.Players.LocalPlayer.Character then
                    for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if v:IsA("BasePart") then v.CanCollide = false end
                    end
                end
            end)
        else
            if _G.NoclipConn then _G.NoclipConn:Disconnect() end
        end
        Fluent:Notify({ Title = "Noclip", Content = _G.Noclip and "Noclip ENABLED" or "Noclip DISABLED", Duration = 3 })
    end,
})

Tabs.Universal:AddButton({
    Title = "Infinite Jump",
    Description = "Press Space to jump infinitely in the air",
    Callback = function()
        local UIS = game:GetService("UserInputService")
        local char = game.Players.LocalPlayer.Character
        UIS.JumpRequest:Connect(function()
            if char and char:FindFirstChildOfClass("Humanoid") then
                char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
        Fluent:Notify({ Title = "Infinite Jump", Content = "Infinite Jump enabled!", Duration = 3 })
    end,
})

Tabs.Universal:AddButton({
    Title = "Speed Hack (Default 50)",
    Description = "Set your WalkSpeed to 50",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid").WalkSpeed = 50
        end
        Fluent:Notify({ Title = "Speed", Content = "WalkSpeed set to 50!", Duration = 3 })
    end,
})

Tabs.Universal:AddButton({
    Title = "Anti AFK",
    Description = "Prevent being kicked for being idle",
    Callback = function()
        local VirtualUser = game:GetService("VirtualUser")
        game.Players.LocalPlayer.Idled:Connect(function()
            VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
        Fluent:Notify({ Title = "Anti AFK", Content = "Anti AFK enabled!", Duration = 3 })
    end,
})

Tabs.Universal:AddButton({
    Title = "Fullbright",
    Description = "Remove darkness and see everywhere clearly",
    Callback = function()
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 14
        game:GetService("Lighting").FogEnd = 100000
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").Ambient = Color3.fromRGB(255, 255, 255)
        Fluent:Notify({ Title = "Fullbright", Content = "Fullbright enabled!", Duration = 3 })
    end,
})

-- ============================================================
--  FE TAB
-- ============================================================
Tabs.FE:AddParagraph({
    Title = "FE Scripts",
    Content = "FilteringEnabled scripts — client-side effects that still work on live servers.",
})

Tabs.FE:AddButton({
    Title = "FE Fly",
    Description = "Fly around the map in any FE game",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/XvLBJfTz"))()
    end,
})

Tabs.FE:AddButton({
    Title = "FE Godmode",
    Description = "Become unkillable client-side",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/X6njBhMX"))()
    end,
})

Tabs.FE:AddButton({
    Title = "FE Btools",
    Description = "Delete & move parts in any game",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/8TfWVWaQ"))()
    end,
})

Tabs.FE:AddButton({
    Title = "FE Fling",
    Description = "Fling players across the map",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/U6YPBpxZ"))()
    end,
})

Tabs.FE:AddButton({
    Title = "FE Spin Players",
    Description = "Spin other players around you",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/E8pLcZdY"))()
    end,
})

Tabs.FE:AddButton({
    Title = "FE Invisible",
    Description = "Make your character invisible to others",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/8JHkNBWi"))()
    end,
})

Tabs.FE:AddButton({
    Title = "FE Animation Spammer",
    Description = "Spam any animation by ID",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/AJGf5QVm"))()
    end,
})

Tabs.FE:AddButton({
    Title = "FE Freeze Players",
    Description = "Freeze nearby players",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/VR7BXdF0"))()
    end,
})

Tabs.FE:AddButton({
    Title = "FE Crash Server",
    Description = "Attempt to lag / crash the server",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/9Jtb3Nvf"))()
    end,
})

Tabs.FE:AddButton({
    Title = "FE Kill Script",
    Description = "Kill players via FE method",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/LqmMdQDg"))()
    end,
})

-- ============================================================
--  GAMES TAB
-- ============================================================
Tabs.Games:AddParagraph({
    Title = "Game-Specific Scripts",
    Content = "Pick a section for your game and click the script button.",
})

-- ─── BED WARS ─────────────────────────────────────────────
local SecBW = Tabs.Games:AddSection("🛏  Bed Wars")

SecBW:AddButton({
    Title = "Bed Wars Hub",
    Description = "Auto buy, ESP, fly, kill aura & more",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XAXA-hub/BedWarsScript/main/script.lua"))()
    end,
})

SecBW:AddButton({
    Title = "Bed Wars ESP + Aimbot",
    Description = "Track enemies & auto-aim",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/VKuqjBpT"))()
    end,
})

SecBW:AddButton({
    Title = "Bed Wars Auto Farm",
    Description = "Auto collect resources & buy upgrades",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/Zy8HkGdN"))()
    end,
})

-- ─── BLOX FRUITS ──────────────────────────────────────────
local SecBF = Tabs.Games:AddSection("🍎  Blox Fruits")

SecBF:AddButton({
    Title = "Blox Fruits Script Hub",
    Description = "Auto farm, mastery, teleport & more",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptblox/Blox-Fruits-Script/main/BloxFruitsScript.lua"))()
    end,
})

SecBF:AddButton({
    Title = "Blox Fruits Auto Raid",
    Description = "Automatically do raids for max rewards",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/yZm9gNrM"))()
    end,
})

-- ─── MURDER MYSTERY 2 ─────────────────────────────────────
local SecMM2 = Tabs.Games:AddSection("🔪  Murder Mystery 2")

SecMM2:AddButton({
    Title = "MM2 ESP + Role Reveal",
    Description = "See murderer, sheriff & innocents through walls",
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

-- ─── ARSENAL ──────────────────────────────────────────────
local SecArs = Tabs.Games:AddSection("🔫  Arsenal")

SecArs:AddButton({
    Title = "Arsenal Aimbot + ESP",
    Description = "Full cheat pack for Arsenal",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/9VxNaJcP"))()
    end,
})

SecArs:AddButton({
    Title = "Arsenal Silent Aim",
    Description = "Silent aimbot — looks legit",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/hQ4NfJzR"))()
    end,
})

-- ─── BROOKHAVEN ───────────────────────────────────────────
local SecBH = Tabs.Games:AddSection("🏘  Brookhaven RP")

SecBH:AddButton({
    Title = "Brookhaven Admin Script",
    Description = "Admin GUI, fly, speed & troll tools",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptblox/Brookhaven-RP-Script/main/script.lua"))()
    end,
})

-- ─── ADOPT ME ─────────────────────────────────────────────
local SecAM = Tabs.Games:AddSection("🐶  Adopt Me")

SecAM:AddButton({
    Title = "Adopt Me Auto Farm",
    Description = "Auto tasks, money & pet care automation",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/qW5yZeBa"))()
    end,
})

-- ─── JAILBREAK ────────────────────────────────────────────
local SecJB = Tabs.Games:AddSection("🚔  Jailbreak")

SecJB:AddButton({
    Title = "Jailbreak Script Hub",
    Description = "Auto rob, ESP, vehicle speed & more",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptblox/Jailbreak-Script/main/script.lua"))()
    end,
})

SecJB:AddButton({
    Title = "Jailbreak Auto Rob",
    Description = "Automatically rob banks & stores",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/K9vNaRpT"))()
    end,
})

-- ─── PET SIMULATOR X ──────────────────────────────────────
local SecPSX = Tabs.Games:AddSection("🐾  Pet Simulator X")

SecPSX:AddButton({
    Title = "Pet Sim X Auto Farm",
    Description = "Auto collect, hatch eggs & sell pets",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptblox/PetSimulatorX-Script/main/script.lua"))()
    end,
})

-- ─── COMBAT WARRIORS ──────────────────────────────────────
local SecCW = Tabs.Games:AddSection("⚔  Combat Warriors")

SecCW:AddButton({
    Title = "Combat Warriors Hub",
    Description = "Aimbot, ESP, kill aura & speed",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/tBfMp3zX"))()
    end,
})

-- ─── NATURAL DISASTER SURVIVAL ────────────────────────────
local SecNDS = Tabs.Games:AddSection("🌪  Natural Disaster Survival")

SecNDS:AddButton({
    Title = "NDS Safe Spot Teleport",
    Description = "Auto teleport to safe zone every disaster",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/K2wZnU5L"))()
    end,
})

-- ─── TOWER OF HELL ────────────────────────────────────────
local SecToH = Tabs.Games:AddSection("🗼  Tower of Hell")

SecToH:AddButton({
    Title = "Tower of Hell Skip / Fly",
    Description = "Fly to the top instantly",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/P5bZcNkL"))()
    end,
})

-- ============================================================
--  SETTINGS TAB
-- ============================================================
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

-- ============================================================
--  INIT
-- ============================================================
SaveManager:LoadAutoloadConfig()
Window:SelectTab(1)

Fluent:Notify({
    Title   = "Focus Hub Loaded!",
    Content = "Welcome! Navigate the tabs to execute scripts.",
    Duration = 6,
})
