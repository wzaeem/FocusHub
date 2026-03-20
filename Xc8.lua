--[[
    ╔══════════════════════════════════════════╗
    ║         FOCUS HUB  |  by Zaeem          ║
    ║   Built on WindUI + TTJY Studio Logic   ║
    ║   Rivals  •  Red/Orange  •  Tablet+PC   ║
    ╚══════════════════════════════════════════╝
]]

-- ═══════════════════════════════════════════════
--  WAIT FOR GAME
-- ═══════════════════════════════════════════════
if not game:IsLoaded() then game.Loaded:Wait() end

-- ═══════════════════════════════════════════════
--  LOAD WIND UI  (official CDN)
-- ═══════════════════════════════════════════════
local WindUI = loadstring(game:HttpGet(
    "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
))()

-- ═══════════════════════════════════════════════
--  GLOBAL ENVIRONMENT  (mirrors TTJY GG pattern)
-- ═══════════════════════════════════════════════
local GG = (getgenv and getgenv()) or _G or shared or {}
GG.FocusHub_Loaded = true

-- ── Cloneref / Clonefunction safety ──
local function safeClone(fn)
    if not fn then return fn end
    local ok, r = pcall(function() return clonefunction and clonefunction(fn) or fn end)
    return ok and r or fn
end
local function safeRef(obj)
    if not obj then return obj end
    local ok, r = pcall(function() return cloneref and cloneref(obj) or obj end)
    return ok and r or obj
end

-- ── Core services (TTJY SecureEnvS pattern) ──
local function GS(s) return safeRef(game:GetService(s)) end

local Players          = GS("Players")
local RunService       = GS("RunService")
local UserInputService = GS("UserInputService")
local TweenService     = GS("TweenService")
local TeleportService  = GS("TeleportService")
local HttpService      = GS("HttpService")
local Lighting         = GS("Lighting")
local W                = workspace

-- ── Local player refs (TTJY selff pattern) ──
local selff  = Players.LocalPlayer
local Cam    = W.CurrentCamera
local selc   = selff.Character or selff.CharacterAdded:Wait()
local PSG    = selff:WaitForChild("PlayerGui", 30)

-- Update character on respawn
selff.CharacterAdded:Connect(function(c)
    selc = c
    GG.selc = c
    GG.HumRSelf = c:WaitForChild("HumanoidRootPart", 10)
    GG.HumSelf  = c:FindFirstChildOfClass("Humanoid")
end)

GG.selff    = selff
GG.selc     = selc
GG.Cam      = Cam
GG.HumRSelf = selc and selc:FindFirstChild("HumanoidRootPart")
GG.HumSelf  = selc and selc:FindFirstChildOfClass("Humanoid")

-- ── Math/string shortcuts (TTJY SecureEnv pattern) ──
local mmaths = math
local pir    = pairs
local twait  = task.wait
local tspawn = task.spawn
local tos    = tostring
local Vec3   = Vector3.new
local Vec2   = Vector2.new
local CF     = CFrame.new
local fromRGB = Color3.fromRGB

-- ── TTJY helper: distance from self ──
local function dist(pos)
    local hrp = GG.HumRSelf
    if not hrp then return mmaths.huge end
    return (hrp.Position - pos).Magnitude
end

-- ═══════════════════════════════════════════════
--  COMMONF  (full TTJY CommonF logic)
-- ═══════════════════════════════════════════════
GG.CommonF = {}
local CommonF = GG.CommonF

function CommonF:GetNearestPlayer()
    local nearest, dista = nil, mmaths.huge
    for _, p in pir(Players:GetPlayers()) do
        if p ~= selff and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local d = dist(hrp.Position)
                if d < dista then dista = d; nearest = p end
            end
        end
    end
    return nearest, dista
end

function CommonF:Tp(cf, t)
    local hrp = GG.HumRSelf
    if not hrp or not cf then return end
    hrp.CFrame = cf
    return true, twait(t or 0)
end

function CommonF:Anchored(bool)
    local hrp = GG.HumRSelf
    if hrp then hrp.Anchored = bool end
end

function CommonF:Rejoin()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, selff)
end

function CommonF:Spin(bool, num)
    local hrp = GG.HumRSelf
    if not hrp or not hrp.Parent then return end
    -- Remove existing
    for _, v in pir(hrp:GetChildren()) do
        if v.Name == "FH_SPIN" then v:Destroy() end
    end
    if not bool then return end
    local Spin = Instance.new("BodyAngularVelocity")
    Spin.Name           = "FH_SPIN"
    Spin.Parent         = hrp
    Spin.MaxTorque      = Vec3(0, mmaths.huge, 0)
    Spin.AngularVelocity = Vec3(0, num or 20, 0)
end

-- ── UpdateClientState — TTJY logic ──
function CommonF:UpdateClientState(which)
    if which == "Noclip" then
        return function(enable)
            if enable then
                local c = selc or GG.selc
                if not c then return end
                for _, child in pir(c:GetDescendants()) do
                    if child:IsA("BasePart") then
                        child.CanCollide = false
                    end
                end
            end
        end
    end

    if which == "WalkSpeed" then
        return function(speed, enable)
            local c = selc or GG.selc
            if not enable or not c then return end
            local hum = c:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = speed end
        end
    end

    if which == "JumpPower" then
        return function(power, enable)
            local c = selc or GG.selc
            if not enable or not c then return end
            local hum = c:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.JumpPower = power
                hum.UseJumpPower = true
            end
        end
    end

    -- WalkSpeedC — with property change connector (TTJY pattern)
    if which == "WalkSpeedC" then
        return function(speed, enable)
            if enable then
                if not GG.WalkSpeedConnector then
                    local c = selc or GG.selc
                    local hum = c and c:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Parent then
                        GG.SecureSelcSaved = hum
                        GG.WalkSpeedConnector = hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                            if GG.SecureSelcSaved and GG.SecureSelcSaved.Parent then
                                GG.SecureSelcSaved.WalkSpeed = speed
                            end
                        end)
                        hum.WalkSpeed = speed
                    end
                else
                    if GG.SecureSelcSaved and GG.SecureSelcSaved.Parent then
                        GG.SecureSelcSaved.WalkSpeed = speed
                    end
                end
            else
                if GG.WalkSpeedConnector then
                    GG.WalkSpeedConnector:Disconnect()
                    GG.WalkSpeedConnector = false
                    if GG.SecureSelcSaved and GG.SecureSelcSaved.Parent then
                        GG.SecureSelcSaved.WalkSpeed = 16
                    end
                end
            end
        end
    end
end

-- ═══════════════════════════════════════════════
--  AIMCASTF  (full TTJY AimCast logic)
-- ═══════════════════════════════════════════════
GG.AimCastF = {}
local AimCastF = GG.AimCastF

AimCastF.hasClearPath = function(self, fromPos, targetPart, ignore)
    local dir = targetPart.Position - fromPos
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = ignore or {}
    params.IgnoreWater = true
    local result = W:Raycast(fromPos, dir, params)
    if not result then return true end
    if result.Instance == targetPart then return true end
    local model = targetPart:FindFirstAncestorOfClass("Model")
    if model and result.Instance:IsDescendantOf(model) then return true end
    return false
end

AimCastF.isInCameraSight = function(self, targetPart, LookDirectionCheck, isWall, ignores)
    if not Cam then return false end
    local pos, onScreen = Cam:WorldToViewportPoint(targetPart.Position)
    if not onScreen then return false end
    if LookDirectionCheck and pos.Z <= 0 then return false end
    if isWall then
        if not self:hasClearPath(Cam.CFrame.Position, targetPart, ignores) then
            return false
        end
    end
    return true
end

-- ═══════════════════════════════════════════════
--  ESPF  (TTJY ESPModl logic)
-- ═══════════════════════════════════════════════
GG.ESPT = {}
GG.ESPF = {}
local ESPF = GG.ESPF
local ESPT = GG.ESPT

function ESPF:Clear()
    for _, v in pir(ESPT) do
        if v and v.Parent then v:Destroy() end
    end
    GG.ESPT = {}
    ESPT = GG.ESPT
end

function ESPF:CreateBox(obj, dat)
    local Box = Instance.new("BoxHandleAdornment", dat.targetObj)
    Box.Color3      = dat.Color
    Box.AlwaysOnTop = true
    Box.Size        = dat.Size
    Box.Transparency = 0.5
    Box.Adornee     = dat.targetObj
    Box.ZIndex      = 1

    if not dat.BoxOnly then
        local Billboard = Instance.new("BillboardGui", dat.targetObj)
        Billboard.Adornee     = dat.targetObj
        Billboard.AlwaysOnTop = true
        Billboard.Size        = UDim2.new(0, 100, 0, 30)
        Billboard.StudsOffset = Vec3(0, dat.Size.Y / 2 + 1, 0)

        local Label = Instance.new("TextLabel", Billboard)
        Label.Size                 = UDim2.new(1, 0, 1, 0)
        Label.BackgroundTransparency = 1
        Label.Text                 = obj.Name
        Label.TextColor3           = dat.Color
        Label.TextStrokeTransparency = 0.2
        Label.Font                 = Enum.Font.SourceSansBold
        Label.TextScaled           = true

        table.insert(ESPT, Billboard)
    end
    table.insert(ESPT, Box)
    return Box
end

function ESPF:ESP(obj, Color, Size, isneed, BoxOnly)
    if not obj or typeof(obj) ~= "Instance" then return end
    local dat = {
        targetObj = nil,
        Color     = Color or fromRGB(255, 80, 40),
        Size      = Size  or Vec3(5, 5, 5),
        isneed    = isneed  or false,
        BoxOnly   = BoxOnly or false,
    }
    if dat.isneed and obj:IsA("Model") then
        dat.targetObj = obj:FindFirstChild("HumanoidRootPart")
                     or obj:FindFirstChildWhichIsA("BasePart", true)
    end
    dat.targetObj = dat.targetObj or obj
    if not dat.targetObj then return end
    return self:CreateBox(obj, dat)
end

-- ═══════════════════════════════════════════════
--  CAMLOCK — uses AimCastF for wall check
-- ═══════════════════════════════════════════════
local CLState = {
    On     = false,
    Smooth = 0.12,
    Pred   = 0.12,
    Bone   = "HumanoidRootPart",
    TC     = true,
    Wall   = false,
}
local CLConn = nil

local function CLFindTarget()
    local nearest, best = nil, 99999
    local cx = Cam.ViewportSize.X / 2
    local cy = Cam.ViewportSize.Y / 2
    for _, p in pir(Players:GetPlayers()) do
        local ok = (p ~= selff)
        if ok and CLState.TC and p.Team and selff.Team and p.Team == selff.Team then ok = false end
        if ok then
            local c = p.Character
            if not c then ok = false end
            if ok then
                local bone = c:FindFirstChild(CLState.Bone) or c:FindFirstChild("HumanoidRootPart")
                if not bone then ok = false end
                if ok then
                    local hum = c:FindFirstChildOfClass("Humanoid")
                    if not hum or hum.Health <= 0 then ok = false end
                    if ok then
                        -- Use TTJY AimCastF for wall + camera check
                        local inSight = AimCastF:isInCameraSight(bone, true, CLState.Wall, {selc})
                        if inSight then
                            local sp = Cam:WorldToViewportPoint(bone.Position)
                            local dx = sp.X - cx; local dy = sp.Y - cy
                            local d  = (dx*dx + dy*dy)^0.5
                            if d < best then best = d; nearest = bone end
                        else
                            -- Off screen — use world distance as fallback
                            local dv = Cam.CFrame.Position - bone.Position
                            local dw = (dv.X*dv.X+dv.Y*dv.Y+dv.Z*dv.Z)^0.5 + 3000
                            if dw < best then best = dw; nearest = bone end
                        end
                    end
                end
            end
        end
    end
    return nearest
end

local function CLStart()
    if CLConn then CLConn:Disconnect() end
    CLConn = RunService.RenderStepped:Connect(function()
        if not CLState.On then return end
        local bone = CLFindTarget()
        if not bone then return end
        local hrp = bone.Parent and bone.Parent:FindFirstChild("HumanoidRootPart")
        local vel = (hrp and hrp.Velocity) or Vec3(0,0,0)
        local pred = bone.Position + vel * CLState.Pred
        Cam.CFrame = Cam.CFrame:Lerp(CFrame.new(Cam.CFrame.Position, pred), CLState.Smooth)
    end)
end
local function CLStop()
    if CLConn then CLConn:Disconnect(); CLConn = nil end
end

-- ═══════════════════════════════════════════════
--  HITBOX  (TTJY ESPModl extended)
-- ═══════════════════════════════════════════════
local HB = {On=true, Sz=12}
local HBOrig = {}

local function HBApply(p)
    if p == selff then return end
    local c = p.Character; if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    if not HBOrig[p] then HBOrig[p] = hrp.Size end
    hrp.Size = Vec3(HB.Sz, HB.Sz, HB.Sz)
end
local function HBRemove(p)
    if p == selff then return end
    local c = p.Character; if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    hrp.Size = HBOrig[p] or Vec3(2,2,1); HBOrig[p] = nil
end
local function HBAll()
    for _,p in pir(Players:GetPlayers()) do
        if HB.On then HBApply(p) else HBRemove(p) end
    end
end

-- Keep alive + auto new players
tspawn(function()
    while true do
        twait(0.8)
        if HB.On then HBAll() end
        if not GG.FocusHub_Loaded then break end
    end
end)
Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function() twait(0.5); if HB.On then HBApply(p) end end)
end)
for _,p in pir(Players:GetPlayers()) do
    p.CharacterAdded:Connect(function() twait(0.5); if HB.On then HBApply(p) end end)
end

-- ═══════════════════════════════════════════════
--  STATE FUNCTIONS  (from UpdateClientState)
-- ═══════════════════════════════════════════════
local WalkSpeedFn   = CommonF:UpdateClientState("WalkSpeedC")
local WalkSpeedFnR  = CommonF:UpdateClientState("WalkSpeed")
local JumpPowerFn   = CommonF:UpdateClientState("JumpPower")
local NoclipFn      = CommonF:UpdateClientState("Noclip")

-- Noclip loop
local NoclipConn = nil
local function SetNoclip(state)
    if state then
        NoclipConn = RunService.Heartbeat:Connect(function()
            NoclipFn(true)
        end)
    else
        if NoclipConn then NoclipConn:Disconnect(); NoclipConn = nil end
        local c = selc or GG.selc
        if c then
            for _,v in pir(c:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = true end
            end
        end
    end
end

-- Inf jump
local InfJumpConn = nil
local function SetInfJump(state)
    if state then
        InfJumpConn = UserInputService.JumpRequest:Connect(function()
            local c = selc or GG.selc
            if not c then return end
            local hum = c:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    else
        if InfJumpConn then InfJumpConn:Disconnect(); InfJumpConn = nil end
    end
end

-- Godmode
local GodConn = nil
local function SetGod(state)
    if state then
        GodConn = RunService.Heartbeat:Connect(function()
            local c = selc or GG.selc; if not c then return end
            local hum = c:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
        end)
    else
        if GodConn then GodConn:Disconnect(); GodConn = nil end
    end
end

-- Fly  (LinearVelocity — tablet safe)
local FlySpd = 60
local FlyConn = nil
local function SetFly(state)
    local hrp = GG.HumRSelf
    local hum = selc and selc:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    if state then
        hum.PlatformStand = true
        local att = Instance.new("Attachment", hrp); att.Name="FH_A"
        local lv  = Instance.new("LinearVelocity", hrp)
        lv.Name="FH_LV"; lv.Attachment0=att; lv.MaxForce=1e6
        lv.VelocityConstraintMode=Enum.VelocityConstraintMode.Vector
        lv.VectorVelocity=Vec3(0,0,0)
        local ao = Instance.new("AlignOrientation", hrp)
        ao.Name="FH_AO"; ao.Attachment0=att
        ao.MaxTorque=1e6; ao.Responsiveness=50; ao.CFrame=Cam.CFrame
        FlyConn = RunService.Heartbeat:Connect(function()
            local l=hrp:FindFirstChild("FH_LV"); local a=hrp:FindFirstChild("FH_AO")
            if not l or not a then return end
            local d = Vec3(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W)         then d=d+Cam.CFrame.LookVector  end
            if UserInputService:IsKeyDown(Enum.KeyCode.S)         then d=d-Cam.CFrame.LookVector  end
            if UserInputService:IsKeyDown(Enum.KeyCode.A)         then d=d-Cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D)         then d=d+Cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space)     then d=d+Vec3(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then d=d-Vec3(0,1,0) end
            l.VectorVelocity=d*FlySpd; a.CFrame=Cam.CFrame
        end)
    else
        hum.PlatformStand = false
        if FlyConn then FlyConn:Disconnect(); FlyConn=nil end
        for _,n in pir({"FH_A","FH_LV","FH_AO"}) do
            local o=hrp:FindFirstChild(n); if o then o:Destroy() end
        end
    end
end

-- No recoil
local RecoilConn = nil
local function SetNoRecoil(state)
    if state then
        RecoilConn = RunService.RenderStepped:Connect(function()
            Cam.CFrame = Cam.CFrame * CFrame.Angles(math.rad(0.28),0,0)
        end)
    else
        if RecoilConn then RecoilConn:Disconnect(); RecoilConn = nil end
    end
end

-- ESP toggle
local ESPActive = false
local function SetESP(state)
    ESPActive = state
    if not state then
        ESPF:Clear()
    else
        for _,p in pir(Players:GetPlayers()) do
            if p ~= selff and p.Character then
                ESPF:ESP(p.Character, fromRGB(255,80,40), Vec3(4,5,4), true, false)
            end
        end
    end
end

-- Refresh ESP on new players
Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(c)
        twait(1)
        if ESPActive then
            ESPF:ESP(c, fromRGB(255,80,40), Vec3(4,5,4), true, false)
        end
    end)
end)

-- Anti AFK
local AFKConn = nil
local function SetAFK(state)
    if state and not AFKConn then
        local VU = game:GetService("VirtualUser")
        AFKConn = selff.Idled:Connect(function()
            VU:Button2Down(Vec2(0,0), Cam.CFrame)
            twait(1)
            VU:Button2Up(Vec2(0,0), Cam.CFrame)
        end)
    elseif not state and AFKConn then
        AFKConn:Disconnect(); AFKConn = nil
    end
end

-- ═══════════════════════════════════════════════
--  WIND UI WINDOW
-- ═══════════════════════════════════════════════
local Window = WindUI:CreateWindow({
    Title       = "Focus Hub",
    Icon        = "flame",
    Author      = "by Zaeem",
    Folder      = "FocusHub",
    Size        = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme       = "Dark",
    Background  = fromRGB(9, 8, 13),
    Acrylic     = false,
    MinimizeKey = Enum.KeyCode.RightControl,
})

GG.WindUI   = WindUI
GG.Window   = Window

-- ── Tabs ──
local Tabs = {
    Hitbox   = Window:Tab({ Title = "Hitbox",   Icon = "box"            }),
    CamLock  = Window:Tab({ Title = "CamLock",  Icon = "crosshair"      }),
    Player   = Window:Tab({ Title = "Player",   Icon = "user"           }),
    Movement = Window:Tab({ Title = "Movement", Icon = "wind"           }),
    Visual   = Window:Tab({ Title = "Visual",   Icon = "eye"            }),
    Misc     = Window:Tab({ Title = "Misc",     Icon = "wrench"         }),
}

-- ═══════════════════════════════════════════════
--  HITBOX TAB
-- ═══════════════════════════════════════════════
Tabs.Hitbox:Section({ Title = "Hitbox Expander" })

Tabs.Hitbox:Toggle({
    Title   = "Big Hitbox",
    Desc    = "Expand enemy HumanoidRootPart — makes every shot land",
    Default = true,
    Callback = function(v)
        HB.On = v; HBAll()
        Window:Notify({
            Title   = "Hitbox",
            Content = v and ("Enabled — size " .. HB.Sz) or "Disabled",
            Icon    = "box",
            Duration = 3,
        })
    end,
})

Tabs.Hitbox:Slider({
    Title   = "Hitbox Size",
    Desc    = "Sweet spot: 10–16",
    Value   = { Min=2, Max=30, Default=12, Decimals=0 },
    Callback = function(v)
        HB.Sz = v; if HB.On then HBAll() end
    end,
})

Tabs.Hitbox:Paragraph({
    Title = "Info",
    Desc  = "Reapplies every 0.8s — games cannot reset it.\nAuto-applies to all players including latecomers.",
})

-- ═══════════════════════════════════════════════
--  CAMLOCK TAB  (uses AimCastF logic)
-- ═══════════════════════════════════════════════
Tabs.CamLock:Section({ Title = "Camera Lock" })

Tabs.CamLock:Toggle({
    Title   = "Camera Lock",
    Desc    = "Snaps camera onto nearest visible enemy",
    Default = false,
    Callback = function(v)
        CLState.On = v
        if v then CLStart() else CLStop() end
        Window:Notify({
            Title   = "CamLock",
            Content = v and "Enabled" or "Disabled",
            Icon    = "crosshair",
            Duration = 3,
        })
    end,
})

Tabs.CamLock:Toggle({
    Title   = "Team Check",
    Desc    = "Skip players on your team",
    Default = true,
    Callback = function(v) CLState.TC = v end,
})

Tabs.CamLock:Toggle({
    Title   = "Wall Check",
    Desc    = "Only lock onto players you can actually see (uses AimCast)",
    Default = false,
    Callback = function(v) CLState.Wall = v end,
})

Tabs.CamLock:Slider({
    Title   = "Smoothness",
    Desc    = "1 = instant snap  |  10 = smooth tracking",
    Value   = { Min=1, Max=10, Default=4, Decimals=0 },
    Callback = function(v) CLState.Smooth = v / 80 end,
})

Tabs.CamLock:Slider({
    Title   = "Prediction",
    Desc    = "Lead moving targets — raise for high ping",
    Value   = { Min=0, Max=20, Default=4, Decimals=0 },
    Callback = function(v) CLState.Pred = v / 30 end,
})

Tabs.CamLock:Section({ Title = "Target Bone" })

Tabs.CamLock:Button({
    Title = "Body (HRP)",
    Desc  = "Recommended — best combo with big hitbox",
    Callback = function()
        CLState.Bone = "HumanoidRootPart"
        Window:Notify({ Title="CamLock", Content="Bone → HumanoidRootPart", Icon="crosshair", Duration=3 })
    end,
})

Tabs.CamLock:Button({
    Title = "Head",
    Desc  = "Precise — harder to hold on mobile/tablet",
    Callback = function()
        CLState.Bone = "Head"
        Window:Notify({ Title="CamLock", Content="Bone → Head", Icon="crosshair", Duration=3 })
    end,
})

Tabs.CamLock:Button({
    Title = "Upper Torso",
    Desc  = "Good middle ground",
    Callback = function()
        CLState.Bone = "UpperTorso"
        Window:Notify({ Title="CamLock", Content="Bone → UpperTorso", Icon="crosshair", Duration=3 })
    end,
})

-- ═══════════════════════════════════════════════
--  PLAYER TAB  (uses UpdateClientState)
-- ═══════════════════════════════════════════════
Tabs.Player:Section({ Title = "Character Stats" })

Tabs.Player:Slider({
    Title   = "Walk Speed",
    Desc    = "Uses WalkSpeedC — property change protected",
    Value   = { Min=1, Max=150, Default=16, Decimals=0 },
    Callback = function(v)
        WalkSpeedFn(v, true)
    end,
})

Tabs.Player:Slider({
    Title   = "Jump Power",
    Desc    = "UseJumpPower = true applied",
    Value   = { Min=1, Max=300, Default=50, Decimals=0 },
    Callback = function(v)
        JumpPowerFn(v, true)
    end,
})

Tabs.Player:Section({ Title = "Toggles" })

Tabs.Player:Toggle({
    Title   = "Infinite Jump",
    Desc    = "Jump again while airborne",
    Default = false,
    Callback = SetInfJump,
})

Tabs.Player:Toggle({
    Title   = "Noclip",
    Desc    = "Walk through walls — Heartbeat safe",
    Default = false,
    Callback = SetNoclip,
})

Tabs.Player:Toggle({
    Title   = "Godmode",
    Desc    = "Keeps health at max every Heartbeat",
    Default = false,
    Callback = SetGod,
})

Tabs.Player:Toggle({
    Title   = "Anti AFK",
    Desc    = "VirtualUser — never get idle kicked",
    Default = false,
    Callback = SetAFK,
})

Tabs.Player:Toggle({
    Title   = "Spin",
    Desc    = "BodyAngularVelocity spin (FE)",
    Default = false,
    Callback = function(v)
        CommonF:Spin(v, 20)
    end,
})

Tabs.Player:Section({ Title = "Actions" })

Tabs.Player:Button({
    Title = "Reset Stats",
    Desc  = "WalkSpeed 16 + JumpPower 50",
    Callback = function()
        WalkSpeedFn(16, false)
        WalkSpeedFnR(16, true)
        JumpPowerFn(50, true)
        Window:Notify({ Title="Player", Content="Stats reset to default", Icon="user", Duration=3 })
    end,
})

Tabs.Player:Button({
    Title = "Teleport to Spawn",
    Desc  = "CommonF:Tp to 0,10,0",
    Callback = function()
        CommonF:Tp(CFrame.new(0, 10, 0))
        Window:Notify({ Title="Player", Content="Teleported to spawn", Icon="user", Duration=3 })
    end,
})

Tabs.Player:Button({
    Title = "Reset Character",
    Desc  = "Kill and respawn",
    Callback = function()
        local c = selc or GG.selc
        local hum = c and c:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = 0 end
    end,
})

Tabs.Player:Button({
    Title = "Get Nearest Player",
    Desc  = "CommonF:GetNearestPlayer — prints to console",
    Callback = function()
        local p, d = CommonF:GetNearestPlayer()
        if p then
            Window:Notify({ Title="Nearest", Content=p.Name.." ("..math.floor(d).."m)", Icon="user", Duration=4 })
        end
    end,
})

-- ═══════════════════════════════════════════════
--  MOVEMENT TAB
-- ═══════════════════════════════════════════════
Tabs.Movement:Section({ Title = "Fly" })

Tabs.Movement:Slider({
    Title   = "Fly Speed",
    Desc    = "WASD + Space(up) + Shift(down)",
    Value   = { Min=10, Max=250, Default=60, Decimals=0 },
    Callback = function(v) FlySpd = v end,
})

Tabs.Movement:Toggle({
    Title   = "Fly",
    Desc    = "LinearVelocity — stable on tablet/mobile",
    Default = false,
    Callback = SetFly,
})

Tabs.Movement:Section({ Title = "Speed Presets" })

local speedPresets = {
    {"Speed x2",  32},
    {"Speed x3",  48},
    {"Speed x5",  80},
    {"Speed x10", 160},
}
for _, sp in ipairs(speedPresets) do
    local label, val = sp[1], sp[2]
    Tabs.Movement:Button({
        Title = label,
        Desc  = "WalkSpeed = " .. val,
        Callback = function()
            WalkSpeedFnR(val, true)
            Window:Notify({ Title="Movement", Content=label, Icon="wind", Duration=2 })
        end,
    })
end

Tabs.Movement:Button({
    Title = "High Jump",
    Desc  = "JumpPower = 100",
    Callback = function()
        JumpPowerFn(100, true)
        Window:Notify({ Title="Movement", Content="High Jump ON", Icon="wind", Duration=2 })
    end,
})

Tabs.Movement:Button({
    Title = "Super Jump",
    Desc  = "JumpPower = 200",
    Callback = function()
        JumpPowerFn(200, true)
        Window:Notify({ Title="Movement", Content="Super Jump ON", Icon="wind", Duration=2 })
    end,
})

Tabs.Movement:Button({
    Title = "Reset Speed + Jump",
    Desc  = "Back to defaults",
    Callback = function()
        WalkSpeedFn(16, false)
        WalkSpeedFnR(16, true)
        JumpPowerFn(50, true)
        Window:Notify({ Title="Movement", Content="Reset to default", Icon="wind", Duration=2 })
    end,
})

-- ═══════════════════════════════════════════════
--  VISUAL TAB  (uses ESPF logic)
-- ═══════════════════════════════════════════════
Tabs.Visual:Section({ Title = "ESP — uses TTJY ESPModl" })

Tabs.Visual:Toggle({
    Title   = "BoxHandleAdornment ESP",
    Desc    = "3D boxes around players with name labels",
    Default = false,
    Callback = SetESP,
})

Tabs.Visual:Section({ Title = "Environment" })

Tabs.Visual:Toggle({
    Title   = "Fullbright",
    Desc    = "Remove all darkness",
    Default = false,
    Callback = function(v)
        local L = Lighting
        if v then
            L.Brightness = 2; L.ClockTime = 14; L.FogEnd = 100000
            L.GlobalShadows = false
            L.Ambient = fromRGB(255,255,255); L.OutdoorAmbient = fromRGB(255,255,255)
        else
            L.Brightness = 1; L.ClockTime = 14; L.FogEnd = 1000
            L.GlobalShadows = true
            L.Ambient = fromRGB(70,70,70); L.OutdoorAmbient = fromRGB(127,127,127)
        end
        Window:Notify({ Title="Visual", Content=v and "Fullbright ON" or "Fullbright OFF", Icon="eye", Duration=3 })
    end,
})

Tabs.Visual:Toggle({
    Title   = "No Fog",
    Desc    = "Remove all fog",
    Default = false,
    Callback = function(v)
        Lighting.FogEnd   = v and 100000 or 1000
        Lighting.FogStart = v and 99999  or 0
    end,
})

Tabs.Visual:Toggle({
    Title   = "FPS Boost",
    Desc    = "Disable particles, blur, sun rays",
    Default = false,
    Callback = function(v)
        if v then
            for _,o in ipairs(W:GetDescendants()) do
                if o:IsA("ParticleEmitter") or o:IsA("Smoke") or o:IsA("Fire") or o:IsA("Sparkles") then
                    o.Enabled = false
                end
            end
            for _,o in ipairs(Lighting:GetChildren()) do
                if o:IsA("BlurEffect") or o:IsA("DepthOfFieldEffect") or o:IsA("SunRaysEffect") then
                    o.Enabled = false
                end
            end
            Window:Notify({ Title="Visual", Content="FPS Boost applied!", Icon="eye", Duration=3 })
        end
    end,
})

Tabs.Visual:Toggle({
    Title   = "Wide FOV",
    Desc    = "Camera FOV 100",
    Default = false,
    Callback = function(v)
        Cam.FieldOfView = v and 100 or 70
    end,
})

Tabs.Visual:Section({ Title = "Combat" })

Tabs.Visual:Toggle({
    Title   = "No Recoil",
    Desc    = "Counter upward camera kick",
    Default = false,
    Callback = SetNoRecoil,
})

-- ═══════════════════════════════════════════════
--  MISC TAB
-- ═══════════════════════════════════════════════
Tabs.Misc:Section({ Title = "Server" })

Tabs.Misc:Button({
    Title = "Rejoin",
    Desc  = "CommonF:Rejoin — reconnect same server",
    Callback = function()
        CommonF:Rejoin()
    end,
})

Tabs.Misc:Button({
    Title = "Server Hop",
    Desc  = "Jump to a different server",
    Callback = function()
        local ok, r = pcall(function()
            return HttpService:JSONDecode(
                game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
            )
        end)
        if ok and r and r.data then
            for _, sv in ipairs(r.data) do
                if sv.id ~= game.JobId and sv.playing < sv.maxPlayers then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, sv.id, selff)
                    return
                end
            end
        end
        Window:Notify({ Title="Server Hop", Content="No other servers found", Icon="wrench", Duration=3 })
    end,
})

Tabs.Misc:Button({
    Title = "Copy Place ID",
    Desc  = "Copies game PlaceId to clipboard",
    Callback = function()
        local id = tos(game.PlaceId)
        pcall(function() setclipboard(id) end)
        Window:Notify({ Title="Misc", Content="Place ID: "..id, Icon="wrench", Duration=4 })
    end,
})

Tabs.Misc:Section({ Title = "Utility" })

Tabs.Misc:Button({
    Title = "Unload Focus Hub",
    Desc  = "Cleanly removes all connections and ESP",
    Callback = function()
        Window:Notify({ Title="Focus Hub", Content="Unloading...", Icon="flame", Duration=2 })
        twait(1)
        GG.FocusHub_Loaded = false
        if CLConn    then CLConn:Disconnect()    end
        if FlyConn   then FlyConn:Disconnect()   end
        if NoclipConn then NoclipConn:Disconnect() end
        if GodConn   then GodConn:Disconnect()   end
        if InfJumpConn then InfJumpConn:Disconnect() end
        if RecoilConn then RecoilConn:Disconnect() end
        if AFKConn   then AFKConn:Disconnect()   end
        if GG.WalkSpeedConnector then GG.WalkSpeedConnector:Disconnect() end
        CommonF:Spin(false)
        HB.On = false; HBAll()
        ESPF:Clear()
        WindUI:Destroy()
    end,
})

-- ═══════════════════════════════════════════════
--  INIT
-- ═══════════════════════════════════════════════
HBAll()

Window:Notify({
    Title    = "Focus Hub",
    Content  = "Loaded! Hitbox active. All TTJY logic running.",
    Icon     = "flame",
    Duration = 6,
})
