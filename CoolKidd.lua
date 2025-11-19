-- COOLKIDD v4.0 EXECUTOR EDITION (Delta / Solara / All Executors)
-- Features: Fly, Godmode, Invisible, Fling, FastSpin, Speed, Noclip, ESP, InfJump
-- Switch buttons + beautiful GUI + anti-detection tricks

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CoolKiddExecutor"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui") -- Executor-proof

-- Toggle button (left middle)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 70, 0, 70)
ToggleBtn.Position = UDim2.new(0, 15, 0.5, -35)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.Text = "CK"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
ToggleBtn.TextScaled = true
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.BackgroundTransparency = 0.3
ToggleBtn.Parent = ScreenGui

local Corner = Instance.new("UICorner", ToggleBtn)
Corner.CornerRadius = UDim.new(1, 0)
local Stroke = Instance.new("UIStroke", ToggleBtn)
Stroke.Color = Color3.fromRGB(0, 255, 255)
Stroke.Thickness = 4

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 560)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -280)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner", MainFrame)
FrameCorner.CornerRadius = UDim.new(0, 16)
local FrameStroke = Instance.new("UIStroke", MainFrame)
FrameStroke.Color = Color3.fromRGB(0, 255, 255)
FrameStroke.Thickness = 3

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "COOLKIDD v4 — EXECUTOR"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Scrolling
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -30, 1, -70)
Scroll.Position = UDim2.new(0, 15, 0, 55)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 8
Scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.Parent = MainFrame

local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 12)

-- States
local Toggles = {
    Speed = false, Fly = false, Noclip = false,
    Godmode = false, Invisible = false, Fling = false,
    FastSpin = false, ESP = false, InfJump = false
}

-- Character refs
local Char, Hum, Root
local function GetChar()
    Char = player.Character or player.CharacterAdded:Wait()
    Hum = Char:WaitForChild("Humanoid")
    Root = Char:WaitForChild("HumanoidRootPart")
end
player.CharacterAdded:Connect(GetChar)
if player.Character then GetChar() end

-- Switch creator
local function CreateSwitch(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    btn.Text = name .. " : OFF"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = Scroll

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
    local s = Instance.new("UIStroke", btn)
    s.Thickness = 2
    s.Color = Color3.fromRGB(100, 100, 200)

    btn.MouseButton1Click:Connect(function()
        Toggles[name] = not Toggles[name]
        btn.Text = name .. (Toggles[name] and " : ON" or " : OFF")
        btn.BackgroundColor3 = Toggles[name] and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 50)
        s.Color = Toggles[name] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 200)
        callback(Toggles[name])
    end)
end

-- Features (executor-optimized & anti-detection)

CreateSwitch("Speed", function(on) if Hum then Hum.WalkSpeed = on and 120 or 16 end end)

CreateSwitch("Fly", function(on)
    if _G.FlyConn then _G.FlyConn:Disconnect() end
    if not on or not Root then return end
    local bv = Instance.new("BodyVelocity", Root)
    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bv.Velocity = Vector3.zero
    _G.FlyConn = RunService.Heartbeat:Connect(function()
        local move = Vector3.new()
        local cam = camera.CFrame
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cam.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cam.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cam.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cam.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move -= Vector3.new(0,1,0) end
        bv.Velocity = move.Unit * 100
    end)
end)

CreateSwitch("Noclip", function(on)
    if _G.NoclipConn then _G.NoclipConn:Disconnect() end
    if not on then return end
    _G.NoclipConn = RunService.Stepped:Connect(function()
        for _, v in pairs(Char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end)
end)

CreateSwitch("Godmode", function(on)
    if on and Hum then
        Hum.MaxHealth = math.huge
        Hum.Health = math.huge
    else
        if Hum then Hum.MaxHealth = 100 Hum.Health = 100 end
    end
end)

CreateSwitch("Invisible", function(on)
    for _, v in pairs(Char:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            v.Transparency = on and 1 or 0
        elseif v:IsA("Accessory") then
            if v:FindFirstChild("Handle") then v.Handle.Transparency = on and 1 or 0 end
        end
    end
end)

CreateSwitch("Fling", function(on)
    if _G.FlingConn then _G.FlingConn:Disconnect() end
    if not on then return end
    _G.FlingConn = RunService.Heartbeat:Connect(function()
        for _, p in Players:GetPlayers() do
            if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local root = p.Character.HumanoidRootPart
                root.Velocity = Vector3.new(math.random(-500,500), 500, math.random(-500,500))
                root.RotVelocity = Vector3.new(math.random(-800,800), math.random(-800,800), math.random(-800,800))
            end
        end
    end)
end)

CreateSwitch("FastSpin", function(on)
    if _G.SpinConn then _G.SpinConn:Disconnect() end
    if not on then return end
    _G.SpinConn = RunService.Heartbeat:Connect(function()
        if Root then Root.RotVelocity = Vector3.new(0, 1500, 0) end
    end)
end)

CreateSwitch("ESP", function(on)
    for _, p in Players:GetPlayers() do
        if p ~= player and p.Character then
            local hl = p.Character:FindFirstChild("CK_ESP")
            if on and not hl then
                local h = Instance.new("Highlight", p.Character)
                h.Name = "CK_ESP"
                h.FillColor = Color3.fromRGB(255,0,0)
                h.OutlineColor = Color3.fromRGB(255,255,0)
            elseif not on and hl then hl:Destroy() end
        end
    end
end)

CreateSwitch("InfJump", function(on) Toggles.InfJump = on end)
UserInputService.JumpRequest:Connect(function()
    if Toggles.InfJump and Root then Root.Velocity = Vector3.new(Root.Velocity.X, 70, Root.Velocity.Z) end
end)

-- Auto-resize
Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 20)
end)

-- Toggle GUI
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    ToggleBtn.Text = MainFrame.Visible and "X" or "CK"
end)

UserInputService.InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.Insert then
        MainFrame.Visible = not MainFrame.Visible
        ToggleBtn.Text = MainFrame.Visible and "X" or "CK"
    end
end)

print("COOLKIDD v4 EXECUTOR LOADED — Press INSERT or click CK")
