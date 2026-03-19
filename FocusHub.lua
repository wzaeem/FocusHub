local repo = 'https://raw.githubusercontent.com/dawid-scripts/Fluent/master/'
local Fluent = loadstring(game:HttpGet(repo .. 'Fluent.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'Addons/SaveManager.lua'))()
local InterfaceManager = loadstring(game:HttpGet(repo .. 'Addons/InterfaceManager.lua'))()

local Window = Fluent:CreateWindow({
    Title = "Focus Hub",
    SubTitle = "by Focus",
    TabWidth = 160,
    Size = UDim2.fromOffset(600, 480),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl,
})

local Tabs = {
    Home      = Window:AddTab({ Title = "Home",      Icon = "home"      }),
    Universal = Window:AddTab({ Title = "Universal", Icon = "globe"     }),
    FE        = Window:AddTab({ Title = "FE",        Icon = "zap"       }),
    Games     = Window:AddTab({ Title = "Games",     Icon = "gamepad-2" }),
    Settings  = Window:AddTab({ Title = "Settings",  Icon = "settings"  }),
}

-- HOME
Tabs.Home:AddParagraph({
    Title = "Welcome to Focus Hub",
    Content = "Navigate the tabs on the left to find scripts.\nPress LEFT CTRL to minimize the GUI.",
})
Tabs.Home:AddParagraph({
    Title = "Disclaimer",
    Content = "All scripts are for educational purposes only. Use at your own risk.",
})

-- UNIVERSAL
Tabs.Universal:AddButton({
    Title = "Infinite Yield",
    Description = "Admin commands for any game",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end,
})
Tabs.Universal:AddButton({
    Title = "Universal ESP",
    Description = "See players through walls",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))()
    end,
})
Tabs.Universal:AddButton({
    Title = "Dex Explorer",
    Description = "Explore the game instance tree",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'))()
    end,
})
Tabs.Universal:AddButton({
    Title = "SimpleSpy",
    Description = "Spy on RemoteEvents",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua'))()
    end,
})
Tabs.Universal:AddButton({
    Title = "Noclip Toggle",
    Description = "Walk through walls",
    Callback = function()
        _G.NC = not (_G.NC or false)
        if _G.NC then
            _G.NCConn = game:GetService("RunService").Stepped:Connect(function()
                local c = game.Players.LocalPlayer.Character
                if c then for _,v in pairs(c:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
            end)
        elseif _G.NCConn then
            _G.NCConn:Disconnect()
        end
        Fluent:Notify({ Title = "Noclip", Content = _G.NC and "ON" or "OFF", Duration = 3 })
    end,
})
Tabs.Universal:AddButton({
    Title = "Infinite Jump",
    Description = "Jump infinitely in the air",
    Callback = function()
        game:GetService("UserInputService").JumpRequest:Connect(function()
            local c = game.Players.LocalPlayer.Character
            if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end
        end)
        Fluent:Notify({ Title = "Infinite Jump", Content = "Enabled!", Duration = 3 })
    end,
})
Tabs.Universal:AddButton({
    Title = "Speed x50",
    Description = "Set WalkSpeed to 50",
    Callback = function()
        local c = game.Players.LocalPlayer.Character
        if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed = 50 end end
        Fluent:Notify({ Title = "Speed", Content = "WalkSpeed = 50", Duration = 3 })
    end,
})
Tabs.Universal:AddButton({
    Title = "Anti AFK",
    Description = "Prevent idle kick",
    Callback = function()
        local VU = game:GetService("VirtualUser")
        game.Players.LocalPlayer.Idled:Connect(function()
            VU:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VU:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
        Fluent:Notify({ Title = "Anti AFK", Content = "Enabled!", Duration = 3 })
    end,
})
Tabs.Universal:AddButton({
    Title = "Fullbright",
    Description = "Remove all darkness",
    Callback = function()
        local L = game:GetService("Lighting")
        L.Brightness = 2; L.ClockTime = 14; L.FogEnd = 100000
        L.GlobalShadows = false; L.Ambient = Color3.fromRGB(255,255,255)
        Fluent:Notify({ Title = "Fullbright", Content = "Enabled!", Duration = 3 })
    end,
})

-- FE
Tabs.FE:AddParagraph({
    Title = "FE Scripts",
    Content = "FilteringEnabled scripts — client-side effects on live servers.",
})
Tabs.FE:AddButton({
    Title = "FE Fly",
    Description = "Fly in any FE game",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/XvLBJfTz'))()
    end,
})
Tabs.FE:AddButton({
    Title = "FE Godmode",
    Description = "Become unkillable client-side",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/X6njBhMX'))()
    end,
})
Tabs.FE:AddButton({
    Title = "FE Btools",
    Description = "Delete and move parts",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/8TfWVWaQ'))()
    end,
})
Tabs.FE:AddButton({
    Title = "FE Fling",
    Description = "Fling players",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/U6YPBpxZ'))()
    end,
})
Tabs.FE:AddButton({
    Title = "FE Spin Players",
    Description = "Spin players around you",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/E8pLcZdY'))()
    end,
})
Tabs.FE:AddButton({
    Title = "FE Invisible",
    Description = "Go invisible to others",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/8JHkNBWi'))()
    end,
})
Tabs.FE:AddButton({
    Title = "FE Animation Spammer",
    Description = "Play any animation by ID",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/AJGf5QVm'))()
    end,
})
Tabs.FE:AddButton({
    Title = "FE Freeze Players",
    Description = "Freeze nearby players",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/VR7BXdF0'))()
    end,
})
Tabs.FE:AddButton({
    Title = "FE Kill Script",
    Description = "Kill players via FE method",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/LqmMdQDg'))()
    end,
})

-- GAMES
-- Bed Wars
local SecBW = Tabs.Games:AddSection("Bed Wars")
SecBW:AddButton({
    Title = "Bed Wars Hub",
    Description = "Auto buy, ESP, fly, kill aura",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/XAXA-hub/BedWarsScript/main/script.lua'))()
    end,
})
SecBW:AddButton({
    Title = "Bed Wars ESP",
    Description = "Track enemies through walls",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/VKuqjBpT'))()
    end,
})

-- Blox Fruits
local SecBF = Tabs.Games:AddSection("Blox Fruits")
SecBF:AddButton({
    Title = "Blox Fruits Script Hub",
    Description = "Auto farm, mastery, teleport",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/scriptblox/Blox-Fruits-Script/main/BloxFruitsScript.lua'))()
    end,
})
SecBF:AddButton({
    Title = "Blox Fruits Auto Farm",
    Description = "Level up automatically",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/yZm9gNrM'))()
    end,
})

-- Murder Mystery 2
local SecMM2 = Tabs.Games:AddSection("Murder Mystery 2")
SecMM2:AddButton({
    Title = "MM2 ESP + Role Reveal",
    Description = "See murderer and sheriff",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/XAXA-hub/MM2-Script/main/script.lua'))()
    end,
})
SecMM2:AddButton({
    Title = "MM2 Coin Farm",
    Description = "Auto collect coins",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/3BnTkcRp'))()
    end,
})

-- Arsenal
local SecArs = Tabs.Games:AddSection("Arsenal")
SecArs:AddButton({
    Title = "Arsenal Aimbot + ESP",
    Description = "Full Arsenal cheat pack",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/9VxNaJcP'))()
    end,
})
SecArs:AddButton({
    Title = "Arsenal Silent Aim",
    Description = "Looks legit aimbot",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/hQ4NfJzR'))()
    end,
})

-- Brookhaven
local SecBH = Tabs.Games:AddSection("Brookhaven RP")
SecBH:AddButton({
    Title = "Brookhaven Admin Script",
    Description = "Fly, speed, admin & troll tools",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/scriptblox/Brookhaven-RP-Script/main/script.lua'))()
    end,
})

-- Adopt Me
local SecAM = Tabs.Games:AddSection("Adopt Me")
SecAM:AddButton({
    Title = "Adopt Me Auto Farm",
    Description = "Auto tasks, money & pet care",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/qW5yZeBa'))()
    end,
})

-- Jailbreak
local SecJB = Tabs.Games:AddSection("Jailbreak")
SecJB:AddButton({
    Title = "Jailbreak Script Hub",
    Description = "Auto rob, ESP, vehicle speed",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/scriptblox/Jailbreak-Script/main/script.lua'))()
    end,
})
SecJB:AddButton({
    Title = "Jailbreak Auto Rob",
    Description = "Auto rob banks and stores",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/K9vNaRpT'))()
    end,
})

-- Pet Simulator X
local SecPSX = Tabs.Games:AddSection("Pet Simulator X")
SecPSX:AddButton({
    Title = "Pet Sim X Auto Farm",
    Description = "Auto collect, hatch & sell pets",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/scriptblox/PetSimulatorX-Script/main/script.lua'))()
    end,
})

-- Combat Warriors
local SecCW = Tabs.Games:AddSection("Combat Warriors")
SecCW:AddButton({
    Title = "Combat Warriors Hub",
    Description = "Aimbot, ESP, kill aura, speed",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/tBfMp3zX'))()
    end,
})

-- Natural Disaster Survival
local SecNDS = Tabs.Games:AddSection("Natural Disaster Survival")
SecNDS:AddButton({
    Title = "NDS Safe Spot Teleport",
    Description = "Auto survive every disaster",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/K2wZnU5L'))()
    end,
})

-- Tower of Hell
local SecToH = Tabs.Games:AddSection("Tower of Hell")
SecToH:AddButton({
    Title = "Tower of Hell Fly / Skip",
    Description = "Fly to the top instantly",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/P5bZcNkL'))()
    end,
})

-- SETTINGS
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:LoadAutoloadConfig()

Window:SelectTab(1)
Fluent:Notify({ Title = "Focus Hub", Content = "Loaded successfully!", Duration = 5 })
