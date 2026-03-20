--[[
    ╔═══════════════════════════════════════╗
    ║      FOCUS HUB  |  by Zaeem          ║
    ║      Red / Orange  Futuristic        ║
    ║      Tablet + Mobile + PC            ║
    ╚═══════════════════════════════════════╝
    Toggle: RIGHT CTRL  or  FH button
--]]

-- ══════════════════════════════
--  SERVICES
-- ══════════════════════════════
local PL  = game:GetService("Players")
local RS  = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TS  = game:GetService("TweenService")
local LP  = PL.LocalPlayer
local Cam = workspace.CurrentCamera

local function GC() return LP.Character end
local function GH() local c=GC() return c and c:FindFirstChildOfClass("Humanoid") end
local function GR() local c=GC() return c and c:FindFirstChild("HumanoidRootPart") end

local function tw(o,p,t)
    if not o or not o.Parent then return end
    TS:Create(o,TweenInfo.new(t or .2,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),p):Play()
end

-- ══════════════════════════════
--  COLOURS
-- ══════════════════════════════
local RED    = Color3.fromRGB(255, 75,  35 )
local ORANGE = Color3.fromRGB(255, 150, 40 )
local DARK   = Color3.fromRGB(180, 40,  10 )
local BG     = Color3.fromRGB(9,   8,   13 )
local PANEL  = Color3.fromRGB(14,  12,  20 )
local CARD   = Color3.fromRGB(20,  17,  28 )
local CARDH  = Color3.fromRGB(28,  22,  38 )
local DIV    = Color3.fromRGB(35,  28,  45 )
local TP     = Color3.fromRGB(242, 238, 235)
local TS2    = Color3.fromRGB(125, 115, 125)
local GREEN  = Color3.fromRGB(80,  220, 110)
local WHITE  = Color3.fromRGB(255, 255, 255)
local BLACK  = Color3.fromRGB(0,   0,   0  )

-- ══════════════════════════════
--  ROOT GUI
-- ══════════════════════════════
pcall(function()
    local g = LP.PlayerGui:FindFirstChild("FOCUSHUB")
    if g then g:Destroy() end
end)

local GUI = Instance.new("ScreenGui")
GUI.Name           = "FOCUSHUB"
GUI.ResetOnSpawn   = false
GUI.IgnoreGuiInset = true
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GUI.DisplayOrder   = 9999

if syn and syn.protect_gui then
    syn.protect_gui(GUI)
    GUI.Parent = game:GetService("CoreGui")
elseif gethui then
    GUI.Parent = gethui()
else
    GUI.Parent = LP:WaitForChild("PlayerGui")
end

-- ══════════════════════════════
--  WINDOW
-- ══════════════════════════════
local WW, WH = 570, 420

-- Drop shadow
local Shdw = Instance.new("ImageLabel", GUI)
Shdw.Size              = UDim2.new(0, WW+40, 0, WH+40)
Shdw.Position          = UDim2.new(0.5, -(WW/2)-20, 0.5, -(WH/2)-20)
Shdw.BackgroundTransparency = 1
Shdw.Image             = "rbxassetid://6015897843"
Shdw.ImageColor3       = Color3.fromRGB(0,0,0)
Shdw.ImageTransparency = 0.5
Shdw.SliceCenter       = Rect.new(49,49,450,450)
Shdw.ScaleType         = Enum.ScaleType.Slice
Shdw.ZIndex            = 1

local WIN = Instance.new("Frame", GUI)
WIN.Name              = "WIN"
WIN.Size              = UDim2.new(0, WW, 0, WH)
WIN.Position          = UDim2.new(0.5, -WW/2, 0.5, -WH/2)
WIN.BackgroundColor3  = BG
WIN.BorderSizePixel   = 0
WIN.ZIndex            = 2
WIN.ClipsDescendants  = true
Instance.new("UICorner", WIN).CornerRadius = UDim.new(0, 12)

local WStroke = Instance.new("UIStroke", WIN)
WStroke.Color = RED; WStroke.Thickness = 1.5; WStroke.Transparency = 0.3

-- ══════════════════════════════
--  TITLE BAR
-- ══════════════════════════════
local TH_H = 44

local TBar = Instance.new("Frame", WIN)
TBar.Size             = UDim2.new(1, 0, 0, TH_H)
TBar.BackgroundColor3 = PANEL
TBar.BorderSizePixel  = 0
TBar.ZIndex           = 10
-- no UICorner on TBar — WIN clips it cleanly

-- Bottom accent line
local AccLine = Instance.new("Frame", WIN)
AccLine.Size             = UDim2.new(1, 0, 0, 2)
AccLine.Position         = UDim2.new(0, 0, 0, TH_H)
AccLine.BackgroundColor3 = RED
AccLine.BorderSizePixel  = 0
AccLine.ZIndex           = 10
local ALG = Instance.new("UIGradient", AccLine)
ALG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   DARK),
    ColorSequenceKeypoint.new(0.5, ORANGE),
    ColorSequenceKeypoint.new(1,   DARK),
})

-- Dot
local Dot = Instance.new("Frame", TBar)
Dot.Size             = UDim2.new(0, 9, 0, 9)
Dot.Position         = UDim2.new(0, 13, 0.5, -4)
Dot.BackgroundColor3 = RED
Dot.BorderSizePixel  = 0
Dot.ZIndex           = 11
Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

-- Pulse dot
task.spawn(function()
    while WIN.Parent do
        tw(Dot, {BackgroundColor3=ORANGE, Size=UDim2.new(0,11,0,11), Position=UDim2.new(0,12,0.5,-5)}, 0.5)
        task.wait(0.6)
        tw(Dot, {BackgroundColor3=RED, Size=UDim2.new(0,9,0,9), Position=UDim2.new(0,13,0.5,-4)}, 0.5)
        task.wait(0.6)
    end
end)

local TLbl = Instance.new("TextLabel", TBar)
TLbl.Size = UDim2.new(0, 110, 1, 0); TLbl.Position = UDim2.new(0, 28, 0, 0)
TLbl.BackgroundTransparency = 1; TLbl.Text = "Focus Hub"
TLbl.Font = Enum.Font.GothamBold; TLbl.TextSize = 15
TLbl.TextColor3 = TP; TLbl.TextXAlignment = Enum.TextXAlignment.Left
TLbl.ZIndex = 11

local SLbl = Instance.new("TextLabel", TBar)
SLbl.Size = UDim2.new(0, 80, 1, 0); SLbl.Position = UDim2.new(0, 138, 0, 0)
SLbl.BackgroundTransparency = 1; SLbl.Text = "by Zaeem"
SLbl.Font = Enum.Font.Gotham; SLbl.TextSize = 11
SLbl.TextColor3 = TS2; SLbl.TextXAlignment = Enum.TextXAlignment.Left
SLbl.ZIndex = 11

-- Close button
local XBtn = Instance.new("TextButton", TBar)
XBtn.Size = UDim2.new(0, 30, 0, 30)
XBtn.Position = UDim2.new(1, -38, 0.5, -15)
XBtn.BackgroundColor3 = Color3.fromRGB(200, 45, 45)
XBtn.Text = "x"; XBtn.Font = Enum.Font.GothamBold; XBtn.TextSize = 14
XBtn.TextColor3 = WHITE; XBtn.BorderSizePixel = 0; XBtn.ZIndex = 12
Instance.new("UICorner", XBtn).CornerRadius = UDim.new(0, 8)

-- Minimize button
local MinBtn = Instance.new("TextButton", TBar)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -74, 0.5, -15)
MinBtn.BackgroundColor3 = Color3.fromRGB(35, 28, 48)
MinBtn.Text = "-"; MinBtn.Font = Enum.Font.GothamBold; MinBtn.TextSize = 18
MinBtn.TextColor3 = TS2; MinBtn.BorderSizePixel = 0; MinBtn.ZIndex = 12
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 8)

local isMin = false
XBtn.MouseButton1Click:Connect(function()
    tw(WIN,  {Size=UDim2.new(0,0,0,0), Position=UDim2.new(0.5,0,0.5,0)}, 0.3)
    tw(Shdw, {ImageTransparency=1}, 0.3)
    task.wait(0.35); GUI.Enabled = false
    WIN.Size = UDim2.new(0,WW,0,WH)
    WIN.Position = UDim2.new(0.5,-WW/2,0.5,-WH/2)
end)
MinBtn.MouseButton1Click:Connect(function()
    isMin = not isMin
    if isMin then tw(WIN, {Size=UDim2.new(0,WW,0,TH_H)}, 0.25)
    else tw(WIN, {Size=UDim2.new(0,WW,0,WH)}, 0.3) end
end)

-- Drag
do
    local dg, ds, dp
    TBar.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dg=true; ds=i.Position; dp=WIN.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if dg and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local d = i.Position - ds
            WIN.Position  = UDim2.new(dp.X.Scale, dp.X.Offset+d.X, dp.Y.Scale, dp.Y.Offset+d.Y)
            Shdw.Position = UDim2.new(WIN.Position.X.Scale, WIN.Position.X.Offset-20, WIN.Position.Y.Scale, WIN.Position.Y.Offset-20)
        end
    end)
    TBar.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=false end
    end)
end

-- ══════════════════════════════
--  SIDEBAR  (left, fixed)
-- ══════════════════════════════
local SB_W = 135

local SB = Instance.new("Frame", WIN)
SB.Size             = UDim2.new(0, SB_W, 1, -TH_H-2)
SB.Position         = UDim2.new(0, 0, 0, TH_H+2)
SB.BackgroundColor3 = PANEL
SB.BorderSizePixel  = 0
SB.ZIndex           = 5

-- Right glow strip
local SBGlow = Instance.new("Frame", WIN)
SBGlow.Size             = UDim2.new(0, 1, 1, -TH_H-2)
SBGlow.Position         = UDim2.new(0, SB_W, 0, TH_H+2)
SBGlow.BackgroundColor3 = RED
SBGlow.BorderSizePixel  = 0; SBGlow.ZIndex = 5
local SBGG = Instance.new("UIGradient", SBGlow)
SBGG.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0,   0.8),
    NumberSequenceKeypoint.new(0.5, 0.2),
    NumberSequenceKeypoint.new(1,   0.8),
})
SBGG.Rotation = 90

local SBLayout = Instance.new("UIListLayout", SB)
SBLayout.Padding = UDim.new(0, 4)
SBLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
local SBPad = Instance.new("UIPadding", SB)
SBPad.PaddingTop   = UDim.new(0, 10)
SBPad.PaddingLeft  = UDim.new(0, 7)
SBPad.PaddingRight = UDim.new(0, 7)

-- ══════════════════════════════
--  CONTENT AREA
-- ══════════════════════════════
local CA = Instance.new("Frame", WIN)
CA.Size             = UDim2.new(1, -SB_W-3, 1, -TH_H-4)
CA.Position         = UDim2.new(0, SB_W+2, 0, TH_H+3)
CA.BackgroundTransparency = 1
CA.BorderSizePixel  = 0
CA.ZIndex           = 3
CA.ClipsDescendants = true

-- ══════════════════════════════
--  TAB BUILDER
-- ══════════════════════════════
local TABS   = {}
local ACTIVE = nil

local function MakeTab(name, icon)
    -- Sidebar button
    local Btn = Instance.new("TextButton", SB)
    Btn.Name             = name
    Btn.Size             = UDim2.new(1, 0, 0, 34)
    Btn.BackgroundColor3 = CARD
    Btn.BackgroundTransparency = 1
    Btn.Text             = ""
    Btn.BorderSizePixel  = 0
    Btn.ZIndex           = 6
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)

    -- Active left bar
    local ABar = Instance.new("Frame", Btn)
    ABar.Size             = UDim2.new(0, 3, 0, 20)
    ABar.Position         = UDim2.new(0, 0, 0.5, -10)
    ABar.BackgroundColor3 = RED
    ABar.BorderSizePixel  = 0
    ABar.BackgroundTransparency = 1
    ABar.ZIndex           = 7
    Instance.new("UICorner", ABar).CornerRadius = UDim.new(0, 2)

    -- Icon
    local IconLbl = Instance.new("TextLabel", Btn)
    IconLbl.Size = UDim2.new(0, 20, 1, 0); IconLbl.Position = UDim2.new(0, 8, 0, 0)
    IconLbl.BackgroundTransparency = 1; IconLbl.Text = icon or "#"
    IconLbl.Font = Enum.Font.GothamBold; IconLbl.TextSize = 13
    IconLbl.TextColor3 = TS2; IconLbl.ZIndex = 7

    -- Label
    local Lbl = Instance.new("TextLabel", Btn)
    Lbl.Size = UDim2.new(1, -30, 1, 0); Lbl.Position = UDim2.new(0, 28, 0, 0)
    Lbl.BackgroundTransparency = 1; Lbl.Text = name
    Lbl.Font = Enum.Font.Gotham; Lbl.TextSize = 12
    Lbl.TextColor3 = TS2; Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.ZIndex = 7

    -- Page (scrollable)
    local Page = Instance.new("ScrollingFrame", CA)
    Page.Name                = name.."_Page"
    Page.Size                = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel     = 0
    Page.ScrollBarThickness  = 3
    Page.ScrollBarImageColor3 = RED
    Page.CanvasSize          = UDim2.new(0, 0, 0, 0)
    -- AutomaticCanvasSize not used
    Page.Visible             = false
    Page.ZIndex              = 4

    local PL2 = Instance.new("UIListLayout", Page)
    PL2.Padding = UDim.new(0, 6)
    PL2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    local PP = Instance.new("UIPadding", Page)
    PP.PaddingTop    = UDim.new(0, 10)
    PP.PaddingBottom = UDim.new(0, 16)
    PP.PaddingLeft   = UDim.new(0, 8)
    PP.PaddingRight  = UDim.new(0, 12)

    local td = {Btn=Btn, Page=Page, Lbl=Lbl, Icon=IconLbl, ABar=ABar}
    TABS[name] = td

    Btn.MouseButton1Click:Connect(function()
        -- deactivate all
        for _, t in pairs(TABS) do
            t.Page.Visible = false
            tw(t.Btn,  {BackgroundTransparency=1}, 0.15)
            tw(t.Lbl,  {TextColor3=TS2}, 0.15)
            tw(t.Icon, {TextColor3=TS2}, 0.15)
            tw(t.ABar, {BackgroundTransparency=1}, 0.15)
        end
        -- activate this
        Page.Visible = true
        tw(Btn,   {BackgroundTransparency=0}, 0.15)
        tw(Lbl,   {TextColor3=TP}, 0.15)
        tw(IconLbl, {TextColor3=ORANGE}, 0.15)
        tw(ABar,  {BackgroundTransparency=0}, 0.15)
        ACTIVE = name
    end)

    return Page
end

-- ══════════════════════════════
--  COMPONENT HELPERS
-- ══════════════════════════════

-- Section header
local function Sec(pg, title)
    local F = Instance.new("Frame", pg)
    F.Size = UDim2.new(1, 0, 0, 22)
    F.BackgroundTransparency = 1; F.BorderSizePixel = 0; F.ZIndex = 5

    local L = Instance.new("TextLabel", F)
    L.Size = UDim2.new(0, 100, 1, 0)
    L.BackgroundTransparency = 1; L.Text = title
    L.Font = Enum.Font.GothamBold; L.TextSize = 10
    L.TextColor3 = RED; L.TextXAlignment = Enum.TextXAlignment.Left
    L.ZIndex = 6

    local LN = Instance.new("Frame", F)
    LN.Size = UDim2.new(1, -108, 0, 1); LN.Position = UDim2.new(0, 108, 0.5, 0)
    LN.BackgroundColor3 = DARK; LN.BorderSizePixel = 0; LN.ZIndex = 5
    local LNG = Instance.new("UIGradient", LN)
    LNG.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0), NumberSequenceKeypoint.new(1,1)})
end

-- Toggle
local function Toggle(pg, title, desc, def, cb)
    local state = def or false
    local h = (desc ~= nil and desc ~= "") and 54 or 42

    local Card = Instance.new("TextButton", pg)
    Card.Size = UDim2.new(1, 0, 0, h)
    Card.BackgroundColor3 = CARD; Card.Text = ""
    Card.BorderSizePixel = 0; Card.ZIndex = 5
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 10)
    local CS = Instance.new("UIStroke", Card)
    CS.Color = DARK; CS.Thickness = 1; CS.Transparency = 0.4

    local TL = Instance.new("TextLabel", Card)
    TL.Size = UDim2.new(1, -58, 0, 18)
    TL.Position = UDim2.new(0, 12, 0, (desc ~= nil and desc ~= "") and 8 or 12)
    TL.BackgroundTransparency = 1; TL.Text = title
    TL.Font = Enum.Font.GothamSemibold; TL.TextSize = 13
    TL.TextColor3 = TP; TL.TextXAlignment = Enum.TextXAlignment.Left; TL.ZIndex = 6

    if desc ~= nil and desc ~= "" then
        local DL = Instance.new("TextLabel", Card)
        DL.Size = UDim2.new(1, -58, 0, 14); DL.Position = UDim2.new(0, 12, 0, 30)
        DL.BackgroundTransparency = 1; DL.Text = desc
        DL.Font = Enum.Font.Gotham; DL.TextSize = 10
        DL.TextColor3 = TS2; DL.TextXAlignment = Enum.TextXAlignment.Left; DL.ZIndex = 6
    end

    -- Pill
    local Pill = Instance.new("Frame", Card)
    Pill.Size = UDim2.new(0, 42, 0, 24); Pill.Position = UDim2.new(1, -54, 0.5, -12)
    Pill.BackgroundColor3 = state and RED or DIV
    Pill.BorderSizePixel = 0; Pill.ZIndex = 6
    Instance.new("UICorner", Pill).CornerRadius = UDim.new(0, 12)

    local Knob = Instance.new("Frame", Pill)
    Knob.Size = UDim2.new(0, 18, 0, 18)
    Knob.Position = state and UDim2.new(0, 21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    Knob.BackgroundColor3 = WHITE; Knob.BorderSizePixel = 0; Knob.ZIndex = 7
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(0, 9)

    local function Set(s)
        state = s
        tw(Pill,  {BackgroundColor3 = s and RED or DIV}, 0.2)
        tw(Knob,  {Position = s and UDim2.new(0,21,0.5,-9) or UDim2.new(0,3,0.5,-9)}, 0.2)
        tw(Card,  {BackgroundColor3 = s and CARDH or CARD}, 0.2)
        tw(CS,    {Color = s and DARK or DIV}, 0.2)
        if cb then cb(s) end
    end

    Card.MouseButton1Click:Connect(function() Set(not state) end)
    return {Set=Set, Get=function() return state end}
end

-- Slider
local function Slider(pg, title, desc, mn, mx, def, cb)
    local val = def or mn

    local Card = Instance.new("Frame", pg)
    Card.Size = UDim2.new(1, 0, 0, 62)
    Card.BackgroundColor3 = CARD; Card.BorderSizePixel = 0; Card.ZIndex = 5
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 10)

    local TL = Instance.new("TextLabel", Card)
    TL.Size = UDim2.new(1, -62, 0, 16); TL.Position = UDim2.new(0, 12, 0, 8)
    TL.BackgroundTransparency = 1; TL.Text = title
    TL.Font = Enum.Font.GothamSemibold; TL.TextSize = 13
    TL.TextColor3 = TP; TL.TextXAlignment = Enum.TextXAlignment.Left; TL.ZIndex = 6

    local VL = Instance.new("TextLabel", Card)
    VL.Size = UDim2.new(0, 44, 0, 16); VL.Position = UDim2.new(1, -56, 0, 8)
    VL.BackgroundTransparency = 1; VL.Text = tostring(val)
    VL.Font = Enum.Font.GothamBold; VL.TextSize = 13
    VL.TextColor3 = ORANGE; VL.TextXAlignment = Enum.TextXAlignment.Right; VL.ZIndex = 6

    if desc ~= nil and desc ~= "" then
        local DL = Instance.new("TextLabel", Card)
        DL.Size = UDim2.new(1, -24, 0, 12); DL.Position = UDim2.new(0, 12, 0, 24)
        DL.BackgroundTransparency = 1; DL.Text = desc
        DL.Font = Enum.Font.Gotham; DL.TextSize = 10
        DL.TextColor3 = TS2; DL.TextXAlignment = Enum.TextXAlignment.Left; DL.ZIndex = 6
    end

    -- Track
    local Track = Instance.new("Frame", Card)
    Track.Size = UDim2.new(1, -24, 0, 6); Track.Position = UDim2.new(0, 12, 0, 47)
    Track.BackgroundColor3 = DIV; Track.BorderSizePixel = 0; Track.ZIndex = 6
    Instance.new("UICorner", Track).CornerRadius = UDim.new(0, 3)

    local pct = (val - mn) / (mx - mn)

    local Fill = Instance.new("Frame", Track)
    Fill.Size = UDim2.new(pct, 0, 1, 0)
    Fill.BackgroundColor3 = RED; Fill.BorderSizePixel = 0; Fill.ZIndex = 7
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(0, 3)
    local FG = Instance.new("UIGradient", Fill)
    FG.Color = ColorSequence.new(DARK, ORANGE)

    local Knob = Instance.new("Frame", Track)
    Knob.Size = UDim2.new(0, 14, 0, 14); Knob.AnchorPoint = Vector2.new(0.5, 0.5)
    Knob.Position = UDim2.new(pct, 0, 0.5, 0)
    Knob.BackgroundColor3 = WHITE; Knob.BorderSizePixel = 0; Knob.ZIndex = 8
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(0, 7)
    local KS = Instance.new("UIStroke", Knob)
    KS.Color = RED; KS.Thickness = 1.5

    local sliding = false
    local function Upd(ix)
        local r = math.clamp((ix - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
        val = math.floor(mn + (mx - mn) * r)
        VL.Text = tostring(val)
        tw(Fill, {Size=UDim2.new(r,0,1,0)}, 0.05)
        tw(Knob, {Position=UDim2.new(r,0,0.5,0)}, 0.05)
        if cb then cb(val) end
    end

    Track.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            sliding=true; Upd(i.Position.X)
        end
    end)
    Knob.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            sliding=true
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if sliding and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            Upd(i.Position.X)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            sliding=false
        end
    end)
end

-- Button
local function Button(pg, title, desc, cb)
    local h = (desc ~= nil and desc ~= "") and 52 or 40

    local Card = Instance.new("TextButton", pg)
    Card.Size = UDim2.new(1, 0, 0, h)
    Card.BackgroundColor3 = CARD; Card.Text = ""
    Card.BorderSizePixel = 0; Card.ZIndex = 5
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 10)
    local CS = Instance.new("UIStroke", Card)
    CS.Color = DARK; CS.Thickness = 1; CS.Transparency = 0.5

    -- Left orange bar
    local LB = Instance.new("Frame", Card)
    LB.Size = UDim2.new(0, 3, 1, -14); LB.Position = UDim2.new(0, 0, 0, 7)
    LB.BackgroundColor3 = RED; LB.BorderSizePixel = 0; LB.ZIndex = 6
    Instance.new("UICorner", LB).CornerRadius = UDim.new(0, 2)

    local TL = Instance.new("TextLabel", Card)
    TL.Size = UDim2.new(1, -42, 0, 18)
    TL.Position = UDim2.new(0, 14, 0, (desc ~= nil and desc ~= "") and 8 or 11)
    TL.BackgroundTransparency = 1; TL.Text = title
    TL.Font = Enum.Font.GothamSemibold; TL.TextSize = 13
    TL.TextColor3 = TP; TL.TextXAlignment = Enum.TextXAlignment.Left; TL.ZIndex = 6

    if desc ~= nil and desc ~= "" then
        local DL = Instance.new("TextLabel", Card)
        DL.Size = UDim2.new(1, -24, 0, 14); DL.Position = UDim2.new(0, 14, 0, 28)
        DL.BackgroundTransparency = 1; DL.Text = desc
        DL.Font = Enum.Font.Gotham; DL.TextSize = 10
        DL.TextColor3 = TS2; DL.TextXAlignment = Enum.TextXAlignment.Left; DL.ZIndex = 6
    end

    local Arr = Instance.new("TextLabel", Card)
    Arr.Size = UDim2.new(0, 18, 1, 0); Arr.Position = UDim2.new(1, -24, 0, 0)
    Arr.BackgroundTransparency = 1; Arr.Text = ">"
    Arr.Font = Enum.Font.GothamBold; Arr.TextSize = 16
    Arr.TextColor3 = RED; Arr.ZIndex = 6

    Card.MouseEnter:Connect(function()
        tw(Card, {BackgroundColor3=CARDH}, 0.1)
        tw(LB,   {BackgroundColor3=ORANGE}, 0.1)
        tw(CS,   {Transparency=0.1}, 0.1)
    end)
    Card.MouseLeave:Connect(function()
        tw(Card, {BackgroundColor3=CARD}, 0.1)
        tw(LB,   {BackgroundColor3=RED}, 0.1)
        tw(CS,   {Transparency=0.5}, 0.1)
    end)
    Card.MouseButton1Click:Connect(function()
        tw(Card, {BackgroundColor3=Color3.fromRGB(60,20,10)}, 0.07)
        task.wait(0.1); tw(Card, {BackgroundColor3=CARDH}, 0.1)
        if cb then cb() end
    end)
end

-- Info label
local function Info(pg, text)
    local F = Instance.new("Frame", pg)
    F.Size = UDim2.new(1, 0, 0, 30)
    F.BackgroundColor3 = Color3.fromRGB(18, 14, 24)
    F.BorderSizePixel = 0; F.ZIndex = 5
    Instance.new("UICorner", F).CornerRadius = UDim.new(0, 8)
    local FS = Instance.new("UIStroke", F)
    FS.Color = DARK; FS.Thickness = 1; FS.Transparency = 0.5
    local L = Instance.new("TextLabel", F)
    L.Size = UDim2.new(1, -16, 1, 0); L.Position = UDim2.new(0, 8, 0, 0)
    L.BackgroundTransparency = 1; L.Text = text
    L.Font = Enum.Font.Gotham; L.TextSize = 10
    L.TextColor3 = TS2; L.TextWrapped = true
    L.TextXAlignment = Enum.TextXAlignment.Left; L.ZIndex = 6
end

-- ══════════════════════════════
--  NOTIFICATIONS
-- ══════════════════════════════
local notY = 14
local function Notify(title, msg, col)
    local NF = Instance.new("Frame", GUI)
    NF.Size = UDim2.new(0, 262, 0, 60)
    NF.Position = UDim2.new(1, 280, 0, notY)
    NF.BackgroundColor3 = PANEL; NF.BorderSizePixel = 0; NF.ZIndex = 50
    Instance.new("UICorner", NF).CornerRadius = UDim.new(0, 10)

    -- Outer glow stroke
    local NS = Instance.new("UIStroke", NF)
    NS.Color = col or RED; NS.Thickness = 1.5; NS.Transparency = 0.25

    -- Top accent bar
    local NTop = Instance.new("Frame", NF)
    NTop.Size = UDim2.new(1, 0, 0, 2); NTop.BackgroundColor3 = col or RED
    NTop.BorderSizePixel = 0; NTop.ZIndex = 51
    Instance.new("UICorner", NTop).CornerRadius = UDim.new(0, 2)
    local NTG = Instance.new("UIGradient", NTop)
    NTG.Color = ColorSequence.new(DARK, col or ORANGE)

    -- Left bar
    local NBar = Instance.new("Frame", NF)
    NBar.Size = UDim2.new(0, 3, 1, -12); NBar.Position = UDim2.new(0, 0, 0, 6)
    NBar.BackgroundColor3 = col or RED; NBar.BorderSizePixel = 0; NBar.ZIndex = 51
    Instance.new("UICorner", NBar).CornerRadius = UDim.new(0, 2)

    local NT = Instance.new("TextLabel", NF)
    NT.Size = UDim2.new(1, -18, 0, 18); NT.Position = UDim2.new(0, 10, 0, 6)
    NT.BackgroundTransparency = 1; NT.Text = title
    NT.Font = Enum.Font.GothamBold; NT.TextSize = 12
    NT.TextColor3 = TP; NT.TextXAlignment = Enum.TextXAlignment.Left; NT.ZIndex = 51

    local NM = Instance.new("TextLabel", NF)
    NM.Size = UDim2.new(1, -18, 0, 14); NM.Position = UDim2.new(0, 10, 0, 28)
    NM.BackgroundTransparency = 1; NM.Text = msg
    NM.Font = Enum.Font.Gotham; NM.TextSize = 10
    NM.TextColor3 = TS2; NM.TextXAlignment = Enum.TextXAlignment.Left; NM.ZIndex = 51

    -- Slide in
    local ny = notY; notY = notY + 68
    tw(NF, {Position=UDim2.new(1,-278,0,ny)}, 0.4)

    task.delay(3.5, function()
        tw(NF, {Position=UDim2.new(1,280,0,ny)}, 0.25)
        task.wait(0.3); NF:Destroy()
        notY = math.max(14, notY-68)
    end)
end

-- ══════════════════════════════
--  MOBILE / TABLET BUTTON
-- ══════════════════════════════
local MB = Instance.new("TextButton", GUI)
MB.Size = UDim2.new(0, 54, 0, 54); MB.Position = UDim2.new(0, 10, 0.5, -27)
MB.BackgroundColor3 = PANEL; MB.Text = "FH"
MB.Font = Enum.Font.GothamBold; MB.TextSize = 14
MB.TextColor3 = RED; MB.BorderSizePixel = 0; MB.ZIndex = 100
Instance.new("UICorner", MB).CornerRadius = UDim.new(0, 12)
local MBS = Instance.new("UIStroke", MB)
MBS.Color = RED; MBS.Thickness = 2

-- Pulse glow
task.spawn(function()
    while MB.Parent do
        tw(MBS, {Thickness=3, Transparency=0.2}, 0.5)
        task.wait(0.55)
        tw(MBS, {Thickness=2, Transparency=0}, 0.5)
        task.wait(0.55)
    end
end)

-- Drag + tap
local _d, _ds, _dp, _dm
MB.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
        _d=true; _dm=false; _ds=i.Position; _dp=MB.Position
        tw(MB, {BackgroundColor3=Color3.fromRGB(40,15,10)}, 0.1)
    end
end)
UIS.InputChanged:Connect(function(i)
    if _d and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
        local dv = i.Position - _ds
        if dv.Magnitude > 6 then _dm=true end
        MB.Position = UDim2.new(_dp.X.Scale, _dp.X.Offset+dv.X, _dp.Y.Scale, _dp.Y.Offset+dv.Y)
    end
end)
MB.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
        tw(MB, {BackgroundColor3=PANEL}, 0.12)
        if not _dm then
            local v = not WIN.Visible
            WIN.Visible  = v; Shdw.Visible = v
            MB.Text      = v and "FH" or ">"
            MBS.Color    = v and RED or TS2
        end
        _d=false; _dm=false
    end
end)

UIS.InputBegan:Connect(function(i, g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.RightControl then
        local v = not WIN.Visible
        WIN.Visible  = v; Shdw.Visible = v
        MB.Text      = v and "FH" or ">"
        MBS.Color    = v and RED or TS2
    end
end)

-- ══════════════════════════════
--  CREATE ALL TABS
-- ══════════════════════════════
local PgHB = MakeTab("Hitbox",   "HB")
local PgCL = MakeTab("CamLock",  "CL")
local PgPL = MakeTab("Player",   "PL")
local PgMV = MakeTab("Movement", "MV")
local PgVS = MakeTab("Visual",   "VS")
local PgMS = MakeTab("Misc",     "MS")

-- Activate Hitbox by default
TABS["Hitbox"].Page.Visible = true
TABS["Hitbox"].Btn.BackgroundTransparency  = 0
TABS["Hitbox"].Lbl.TextColor3  = TP
TABS["Hitbox"].Icon.TextColor3 = ORANGE
TABS["Hitbox"].ABar.BackgroundTransparency = 0
ACTIVE = "Hitbox"

-- ══════════════════════════════
--  HITBOX SYSTEM
-- ══════════════════════════════
local HB = {On=true, Sz=12}
local OrigSz = {}

local function HBSet(p)
    if p == LP then return end
    local c = p.Character; if not c then return end
    local r = c:FindFirstChild("HumanoidRootPart"); if not r then return end
    if not OrigSz[p] then OrigSz[p] = r.Size end
    r.Size = Vector3.new(HB.Sz, HB.Sz, HB.Sz)
end
local function HBRem(p)
    if p == LP then return end
    local c = p.Character; if not c then return end
    local r = c:FindFirstChild("HumanoidRootPart"); if not r then return end
    r.Size = OrigSz[p] or Vector3.new(2,2,1); OrigSz[p]=nil
end
local function HBAll()
    for _,p in pairs(PL:GetPlayers()) do
        if HB.On then HBSet(p) else HBRem(p) end
    end
end

-- Keep alive
task.spawn(function()
    while true do
        task.wait(0.8)
        if HB.On then HBAll() end
        if not GUI.Parent then break end
    end
end)
PL.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function() task.wait(0.5); if HB.On then HBSet(p) end end)
end)
for _,p in pairs(PL:GetPlayers()) do
    p.CharacterAdded:Connect(function() task.wait(0.5); if HB.On then HBSet(p) end end)
end

-- ══════════════════════════════
--  HITBOX TAB
-- ══════════════════════════════
Sec(PgHB, "HITBOX EXPANDER")
Toggle(PgHB, "Big Hitbox", "Expand enemy hitboxes — ON by default", true, function(v)
    HB.On = v; HBAll()
    Notify("Hitbox", v and ("ON — size "..HB.Sz) or "OFF", v and GREEN or Color3.fromRGB(255,60,60))
end)
Slider(PgHB, "Hitbox Size", "Sweet spot: 10 to 16", 2, 30, 12, function(v)
    HB.Sz = v; if HB.On then HBAll() end
end)
Info(PgHB, "Reapplies every 0.8s so games cannot reset it. Auto-applies to all players.")

-- ══════════════════════════════
--  CAMLOCK SYSTEM
-- ══════════════════════════════
local CL = {On=false, Sm=0.12, Pr=0.12, Bone="HumanoidRootPart", TC=true}
local CLConn = nil

local function CLFind()
    local nearest, best = nil, 99999
    local cx = Cam.ViewportSize.X / 2
    local cy = Cam.ViewportSize.Y / 2
    for _, p in pairs(PL:GetPlayers()) do
        local ok = (p ~= LP)
        if ok and CL.TC and p.Team and LP.Team and p.Team == LP.Team then ok=false end
        if ok then
            local c = p.Character
            if not c then ok=false end
            if ok then
                local bone = c:FindFirstChild(CL.Bone) or c:FindFirstChild("HumanoidRootPart")
                if not bone then ok=false end
                if ok then
                    local hum = c:FindFirstChildOfClass("Humanoid")
                    if not hum or hum.Health <= 0 then ok=false end
                    if ok then
                        local sp, vis = Cam:WorldToViewportPoint(bone.Position)
                        local d
                        if vis then
                            local dx = sp.X - cx
                            local dy = sp.Y - cy
                            d = (dx*dx + dy*dy)^0.5
                        else
                            local dv = Cam.CFrame.Position - bone.Position
                            d = (dv.X*dv.X + dv.Y*dv.Y + dv.Z*dv.Z)^0.5 + 2000
                        end
                        if d < best then best=d; nearest=bone end
                    end
                end
            end
        end
    end
    return nearest
end

local function CLStart()
    if CLConn then CLConn:Disconnect() end
    CLConn = RS.RenderStepped:Connect(function()
        if not CL.On then return end
        local bone = CLFind(); if not bone then return end
        local hrp = bone.Parent and bone.Parent:FindFirstChild("HumanoidRootPart")
        local vel = (hrp and hrp.Velocity) or Vector3.new(0,0,0)
        local pred = bone.Position + vel * CL.Pr
        local tf = CFrame.new(Cam.CFrame.Position, pred)
        Cam.CFrame = Cam.CFrame:Lerp(tf, CL.Sm)
    end)
end
local function CLStop()
    if CLConn then CLConn:Disconnect(); CLConn=nil end
end

-- ══════════════════════════════
--  CAMLOCK TAB
-- ══════════════════════════════
Sec(PgCL, "CAMERA LOCK")
Toggle(PgCL, "Camera Lock", "Locks camera onto nearest enemy", false, function(v)
    CL.On = v
    if v then CLStart() else CLStop() end
    Notify("CamLock", v and "ENABLED" or "DISABLED", v and GREEN or Color3.fromRGB(255,60,60))
end)
Toggle(PgCL, "Team Check", "Skip players on your team", true, function(v) CL.TC=v end)
Slider(PgCL, "Smoothness", "1 = instant snap   10 = very smooth", 1, 10, 4, function(v)
    CL.Sm = v / 80
end)
Slider(PgCL, "Prediction", "Lead moving targets — raise for lag", 0, 20, 4, function(v)
    CL.Pr = v / 30
end)
Sec(PgCL, "TARGET BONE")
Button(PgCL, "Body (HRP)", "Best with big hitbox — recommended", function()
    CL.Bone="HumanoidRootPart"; Notify("CamLock","Bone: HumanoidRootPart",RED)
end)
Button(PgCL, "Head", "Precise but harder on mobile", function()
    CL.Bone="Head"; Notify("CamLock","Bone: Head",RED)
end)
Button(PgCL, "Upper Torso", "Good middle ground", function()
    CL.Bone="UpperTorso"; Notify("CamLock","Bone: UpperTorso",RED)
end)
Info(PgCL, "Best setup: Hitbox 12 + CamLock HRP + Smooth 4 + Predict 4")

-- ══════════════════════════════
--  PLAYER TAB
-- ══════════════════════════════
Sec(PgPL, "CHARACTER STATS")
Slider(PgPL, "Walk Speed", "Default: 16", 1, 150, 16, function(v)
    local h=GH(); if h then h.WalkSpeed=v end
end)
Slider(PgPL, "Jump Power", "Default: 50", 1, 300, 50, function(v)
    local h=GH(); if h then h.JumpPower=v end
end)

Sec(PgPL, "ABILITY TOGGLES")
Toggle(PgPL, "Infinite Jump", "Jump again while in the air", false, function(s)
    if s then
        _G.FH_IJ = UIS.JumpRequest:Connect(function()
            local h=GH(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    else
        if _G.FH_IJ then _G.FH_IJ:Disconnect(); _G.FH_IJ=nil end
    end
end)
Toggle(PgPL, "Noclip", "Walk through walls", false, function(s)
    if s then
        _G.FH_NC = RS.Heartbeat:Connect(function()
            local c=GC(); if not c then return end
            for _,v in pairs(c:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide then v.CanCollide=false end
            end
        end)
    else
        if _G.FH_NC then _G.FH_NC:Disconnect(); _G.FH_NC=nil end
        local c=GC(); if c then
            for _,v in pairs(c:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide=true end
            end
        end
    end
end)
Toggle(PgPL, "Godmode", "Keeps health at max every frame", false, function(s)
    if s then
        _G.FH_God = RS.Heartbeat:Connect(function()
            local h=GH(); if h and h.Health<h.MaxHealth then h.Health=h.MaxHealth end
        end)
    else
        if _G.FH_God then _G.FH_God:Disconnect(); _G.FH_God=nil end
    end
end)
Toggle(PgPL, "Anti AFK", "Prevents idle kick", false, function(s)
    if s and not _G.FH_AFK then
        local VU=game:GetService("VirtualUser")
        _G.FH_AFK = LP.Idled:Connect(function()
            VU:Button2Down(Vector2.new(0,0),Cam.CFrame)
            task.wait(1)
            VU:Button2Up(Vector2.new(0,0),Cam.CFrame)
        end)
        Notify("Player","Anti AFK active!",GREEN)
    elseif not s and _G.FH_AFK then
        _G.FH_AFK:Disconnect(); _G.FH_AFK=nil
    end
end)

Sec(PgPL, "QUICK ACTIONS")
Button(PgPL, "Reset Stats", "WalkSpeed 16 + JumpPower 50", function()
    local h=GH(); if h then h.WalkSpeed=16; h.JumpPower=50 end
    Notify("Player","Stats reset",RED)
end)
Button(PgPL, "Reset Character", "Respawn your character", function()
    local h=GH(); if h then h.Health=0 end
end)
Button(PgPL, "Teleport to Spawn", "Go to map spawn point", function()
    local c=GC(); if not c then return end
    local r=c:FindFirstChild("HumanoidRootPart")
    if r then r.CFrame=CFrame.new(0,10,0) end
    Notify("Player","Teleported to spawn",RED)
end)

-- ══════════════════════════════
--  MOVEMENT TAB
-- ══════════════════════════════
local FlySpd = 60

Sec(PgMV, "FLY")
Slider(PgMV, "Fly Speed", "WASD + Space(up) + Shift(down)", 10, 250, 60, function(v) FlySpd=v end)
Toggle(PgMV, "Fly", "LinearVelocity — stable on tablet", false, function(s)
    local hrp=GR(); local hum=GH()
    if not hrp or not hum then return end
    if s then
        hum.PlatformStand = true
        local att=Instance.new("Attachment",hrp); att.Name="FH_A"
        local lv=Instance.new("LinearVelocity",hrp)
        lv.Name="FH_LV"; lv.Attachment0=att; lv.MaxForce=1e6
        lv.VelocityConstraintMode=Enum.VelocityConstraintMode.Vector
        lv.VectorVelocity=Vector3.new(0,0,0)
        local ao=Instance.new("AlignOrientation",hrp)
        ao.Name="FH_AO"; ao.Attachment0=att
        ao.MaxTorque=1e6; ao.Responsiveness=50; ao.CFrame=Cam.CFrame
        _G.FH_Fly=RS.Heartbeat:Connect(function()
            local l=hrp:FindFirstChild("FH_LV"); local a=hrp:FindFirstChild("FH_AO")
            if not l or not a then return end
            local d=Vector3.new(0,0,0)
            if UIS:IsKeyDown(Enum.KeyCode.W)         then d=d+Cam.CFrame.LookVector  end
            if UIS:IsKeyDown(Enum.KeyCode.S)         then d=d-Cam.CFrame.LookVector  end
            if UIS:IsKeyDown(Enum.KeyCode.A)         then d=d-Cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D)         then d=d+Cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space)     then d=d+Vector3.new(0,1,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then d=d-Vector3.new(0,1,0) end
            l.VectorVelocity=d*FlySpd; a.CFrame=Cam.CFrame
        end)
    else
        hum.PlatformStand=false
        if _G.FH_Fly then _G.FH_Fly:Disconnect(); _G.FH_Fly=nil end
        for _,n in pairs({"FH_A","FH_LV","FH_AO"}) do
            local o=hrp:FindFirstChild(n); if o then o:Destroy() end
        end
    end
end)

Sec(PgMV, "SPEED PRESETS")
Button(PgMV, "Speed x2", "WalkSpeed = 32", function()
    local h=GH(); if h then h.WalkSpeed=32 end; Notify("Movement","Speed x2",ORANGE)
end)
Button(PgMV, "Speed x3", "WalkSpeed = 48", function()
    local h=GH(); if h then h.WalkSpeed=48 end; Notify("Movement","Speed x3",ORANGE)
end)
Button(PgMV, "Speed x5", "WalkSpeed = 80", function()
    local h=GH(); if h then h.WalkSpeed=80 end; Notify("Movement","Speed x5",ORANGE)
end)
Button(PgMV, "High Jump", "JumpPower = 100", function()
    local h=GH(); if h then h.JumpPower=100 end; Notify("Movement","High Jump",ORANGE)
end)
Button(PgMV, "Super Jump", "JumpPower = 200", function()
    local h=GH(); if h then h.JumpPower=200 end; Notify("Movement","Super Jump",ORANGE)
end)
Button(PgMV, "Reset Speed+Jump", "Back to defaults", function()
    local h=GH(); if h then h.WalkSpeed=16; h.JumpPower=50 end; Notify("Movement","Reset",RED)
end)

-- ══════════════════════════════
--  VISUAL TAB
-- ══════════════════════════════
Sec(PgVS, "ENVIRONMENT")
Toggle(PgVS, "Fullbright", "Remove all darkness", false, function(s)
    local L=game:GetService("Lighting")
    if s then
        L.Brightness=2; L.ClockTime=14; L.FogEnd=100000
        L.GlobalShadows=false
        L.Ambient=Color3.fromRGB(255,255,255)
        L.OutdoorAmbient=Color3.fromRGB(255,255,255)
        Notify("Visual","Fullbright ON",GREEN)
    else
        L.Brightness=1; L.ClockTime=14; L.FogEnd=1000
        L.GlobalShadows=true
        L.Ambient=Color3.fromRGB(70,70,70)
        L.OutdoorAmbient=Color3.fromRGB(127,127,127)
        Notify("Visual","Fullbright OFF",TS2)
    end
end)
Toggle(PgVS, "No Fog", "Remove all map fog", false, function(s)
    local L=game:GetService("Lighting")
    L.FogEnd=s and 100000 or 1000
    L.FogStart=s and 99999 or 0
    Notify("Visual",s and "No Fog ON" or "Fog restored",RED)
end)
Toggle(PgVS, "FPS Boost", "Remove particles and blur effects", false, function(s)
    if s then
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                v.Enabled=false
            end
        end
        for _,v in pairs(game:GetService("Lighting"):GetChildren()) do
            if v:IsA("BlurEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("SunRaysEffect") then
                v.Enabled=false
            end
        end
        Notify("Visual","FPS Boost ON",GREEN)
    end
end)
Toggle(PgVS, "Wide FOV", "Camera field of view 100", false, function(s)
    Cam.FieldOfView = s and 100 or 70
    Notify("Visual",s and "FOV 100" or "FOV 70",ORANGE)
end)

Sec(PgVS, "COMBAT")
Toggle(PgVS, "No Recoil", "Counter upward camera kick after shooting", false, function(s)
    if s then
        _G.FH_RC=RS.RenderStepped:Connect(function()
            Cam.CFrame = Cam.CFrame * CFrame.Angles(math.rad(0.28),0,0)
        end)
    else
        if _G.FH_RC then _G.FH_RC:Disconnect(); _G.FH_RC=nil end
    end
end)

-- ══════════════════════════════
--  MISC TAB
-- ══════════════════════════════
Sec(PgMS, "SERVER")
Button(PgMS, "Rejoin", "Reconnect to this server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
end)
Button(PgMS, "Server Hop", "Jump to a different server", function()
    local ok,r=pcall(function()
        return game:GetService("HttpService"):JSONDecode(
            game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
        )
    end)
    if ok and r and r.data then
        for _,sv in pairs(r.data) do
            if sv.id~=game.JobId and sv.playing<sv.maxPlayers then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,sv.id,LP)
                return
            end
        end
    end
    Notify("Server Hop","No other servers found",Color3.fromRGB(255,60,60))
end)
Button(PgMS, "Copy Place ID", "Copy this game's Place ID", function()
    local id=tostring(game.PlaceId)
    pcall(function() setclipboard(id) end)
    Notify("Misc","Place ID: "..id,RED)
end)

Sec(PgMS, "UTILITY")
Toggle(PgMS, "Anti AFK (here too)", "Never get kicked", false, function(s)
    if s and not _G.FH_AFK then
        local VU=game:GetService("VirtualUser")
        _G.FH_AFK=LP.Idled:Connect(function()
            VU:Button2Down(Vector2.new(0,0),Cam.CFrame)
            task.wait(1); VU:Button2Up(Vector2.new(0,0),Cam.CFrame)
        end)
        Notify("Misc","Anti AFK ON",GREEN)
    elseif not s and _G.FH_AFK then
        _G.FH_AFK:Disconnect(); _G.FH_AFK=nil
    end
end)
Button(PgMS, "Unload Hub", "Remove Focus Hub completely", function()
    Notify("Focus Hub","Unloading...",RED)
    task.wait(1)
    if CLConn then CLConn:Disconnect() end
    if _G.FH_Fly then _G.FH_Fly:Disconnect() end
    if _G.FH_NC  then _G.FH_NC:Disconnect()  end
    if _G.FH_God then _G.FH_God:Disconnect() end
    if _G.FH_IJ  then _G.FH_IJ:Disconnect()  end
    if _G.FH_RC  then _G.FH_RC:Disconnect()  end
    if _G.FH_AFK then _G.FH_AFK:Disconnect() end
    HB.On=false; HBAll()
    GUI:Destroy()
end)

-- ══════════════════════════════
--  OPEN ANIMATION
-- ══════════════════════════════
WIN.Size     = UDim2.new(0, 0, 0, 0)
WIN.Position = UDim2.new(0.5, 0, 0.5, 0)
Shdw.ImageTransparency = 1

TS:Create(WIN, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size     = UDim2.new(0, WW, 0, WH),
    Position = UDim2.new(0.5, -WW/2, 0.5, -WH/2),
}):Play()
TS:Create(Shdw, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    ImageTransparency = 0.5,
}):Play()

task.wait(0.6)
HBAll()
Notify("Focus Hub","Loaded! Hitbox active.",RED)0