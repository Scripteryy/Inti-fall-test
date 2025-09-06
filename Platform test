-- Executable Roblox Lua script with Toggle, Color menu, and Size slider

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")

-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 120, 0, 50)
toggleButton.Position = UDim2.new(0, 20, 0, 200)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
toggleButton.TextColor3 = Color3.new(1,1,1)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 20
toggleButton.Text = "Platform: OFF"
toggleButton.Active = true
toggleButton.Draggable = true
toggleButton.Parent = ScreenGui

-- Color Menu Button
local colorMenuButton = Instance.new("TextButton")
colorMenuButton.Size = UDim2.new(0, 120, 0, 50)
colorMenuButton.Position = UDim2.new(0, 20, 0, 260)
colorMenuButton.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
colorMenuButton.TextColor3 = Color3.new(1,1,1)
colorMenuButton.Font = Enum.Font.SourceSansBold
colorMenuButton.TextSize = 20
colorMenuButton.Text = "Color"
colorMenuButton.Active = true
colorMenuButton.Draggable = true
colorMenuButton.Parent = ScreenGui

-- Size Frame
local sizeFrame = Instance.new("Frame")
sizeFrame.Size = UDim2.new(0, 200, 0, 70)
sizeFrame.Position = UDim2.new(0, 20, 0, 320)
sizeFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
sizeFrame.Active = true
sizeFrame.Draggable = true
sizeFrame.Parent = ScreenGui

local sizeLabel = Instance.new("TextLabel")
sizeLabel.Size = UDim2.new(1, 0, 0, 30)
sizeLabel.BackgroundTransparency = 1
sizeLabel.TextColor3 = Color3.new(1,1,1)
sizeLabel.Font = Enum.Font.SourceSansBold
sizeLabel.TextSize = 18
sizeLabel.Text = "Size: 6"
sizeLabel.Parent = sizeFrame

local sizeSlider = Instance.new("TextButton")
sizeSlider.Size = UDim2.new(0, 180, 0, 25)
sizeSlider.Position = UDim2.new(0, 10, 0, 35)
sizeSlider.BackgroundColor3 = Color3.fromRGB(100,100,100)
sizeSlider.Text = ""
sizeSlider.Active = true
sizeSlider.AutoButtonColor = false
sizeSlider.Parent = sizeFrame

local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(0.3, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(0,200,255)
sliderFill.Parent = sizeSlider

-- Color Frame (hidden at first)
local colorFrame = Instance.new("Frame")
colorFrame.Size = UDim2.new(0, 150, 0, 200)
colorFrame.Position = UDim2.new(0, 150, 0, 200)
colorFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
colorFrame.Visible = false
colorFrame.Parent = ScreenGui

-- Colors list
local colors = {
    {Name = "Red", Value = Color3.fromRGB(255,0,0)},
    {Name = "Green", Value = Color3.fromRGB(0,255,0)},
    {Name = "Blue", Value = Color3.fromRGB(0,0,255)},
    {Name = "Yellow", Value = Color3.fromRGB(255,255,0)},
    {Name = "White", Value = Color3.fromRGB(255,255,255)},
    {Name = "Rainbow", Value = "Rainbow"}
}

-- Create buttons inside colorFrame
for i, col in ipairs(colors) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, (i-1)*35 + 5)
    btn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Text = col.Name
    btn.Parent = colorFrame
    btn.MouseButton1Click:Connect(function()
        _G.PlatformColor = col.Value
        colorFrame.Visible = false
    end)
end

-- State
local enabled = false
local loop
local colorLoop
_G.PlatformColor = Color3.fromRGB(0,200,255)
_G.PlatformSize = 6

-- Function to start platform follow
local function startPlatforms(char)
    local root = char:WaitForChild("HumanoidRootPart")
    local platform = Instance.new("Part")
    platform.Size = Vector3.new(_G.PlatformSize,1,_G.PlatformSize)
    platform.Anchored = true
    platform.CanCollide = true
    platform.Color = Color3.fromRGB(0, 200, 255)
    platform.Name = game.Players.LocalPlayer.Name .. "_Platform"
    platform.Parent = workspace

    loop = game:GetService("RunService").Heartbeat:Connect(function()
        if enabled and root and root.Parent then
            platform.Position = root.Position - Vector3.new(0,3,0)
            platform.Size = Vector3.new(_G.PlatformSize,1,_G.PlatformSize)
            if _G.PlatformColor and _G.PlatformColor ~= "Rainbow" then
                platform.Color = _G.PlatformColor
            end
        end
    end)

    colorLoop = game:GetService("RunService").Heartbeat:Connect(function()
        if _G.PlatformColor == "Rainbow" then
            local t = tick() * 2
            local r = math.sin(t) * 127 + 128
            local g = math.sin(t + 2) * 127 + 128
            local b = math.sin(t + 4) * 127 + 128
            platform.Color = Color3.fromRGB(r, g, b)
        end
    end)

    char:WaitForChild("Humanoid").Died:Connect(function()
        platform:Destroy()
        if loop then loop:Disconnect() end
        if colorLoop then colorLoop:Disconnect() end
    end)
end

-- Toggle ON/OFF
toggleButton.MouseButton1Click:Connect(function()
    enabled = not enabled
    toggleButton.Text = enabled and "Platform: ON" or "Platform: OFF"
    if enabled then
        local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        startPlatforms(char)
    else
        if loop then loop:Disconnect() end
        if colorLoop then colorLoop:Disconnect() end
        local plat = workspace:FindFirstChild(game.Players.LocalPlayer.Name .. "_Platform")
        if plat then plat:Destroy() end
    end
end)

-- Toggle color menu
colorMenuButton.MouseButton1Click:Connect(function()
    colorFrame.Visible = not colorFrame.Visible
end)

-- Slider logic
local UserInputService = game:GetService("UserInputService")
local dragging = false

sizeSlider.MouseButton1Down:Connect(function(x,y)
    dragging = true
    local moveConn, releaseConn
    moveConn = UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local relativeX = math.clamp((input.Position.X - sizeSlider.AbsolutePosition.X) / sizeSlider.AbsoluteSize.X, 0, 1)
            sliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
            _G.PlatformSize = math.floor(3 + (relativeX * 20)) -- size 3 to 23
            sizeLabel.Text = "Size: " .. _G.PlatformSize
        end
    end)
    releaseConn = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            moveConn:Disconnect()
            releaseConn:Disconnect()
        end
    end)
end)
