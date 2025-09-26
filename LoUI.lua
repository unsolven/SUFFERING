-- UI Library for Roblox
-- Usage: local Library = loadstring(game:HttpGet("your-raw-github-url"))()

local Library = {}

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- Theme
local Theme = {
    Background = Color3.fromRGB(25, 25, 30),
    Secondary = Color3.fromRGB(35, 35, 45),
    Accent = Color3.fromRGB(70, 70, 85),
    Button = Color3.fromRGB(45, 45, 55),
    ButtonHover = Color3.fromRGB(50, 50, 60),
    Text = Color3.fromRGB(220, 220, 220),
    Success = Color3.fromRGB(100, 255, 100),
    Error = Color3.fromRGB(255, 100, 100)
}

-- Main Library Function
function Library:CreateWindow(title, size)
    local Window = {
        title = title or "Library",
        tabs = {},
        currentTab = 1,
        dragging = false,
        minimized = false,
        connections = {}
    }
    
    -- Create ScreenGui
    Window.ScreenGui = Instance.new("ScreenGui")
    Window.ScreenGui.Name = title .. "Library"
    Window.ScreenGui.ResetOnSpawn = false
    Window.ScreenGui.Parent = CoreGui
    
    -- Main Frame
    Window.MainFrame = Instance.new("Frame")
    Window.MainFrame.Name = "MainFrame"
    Window.MainFrame.Size = size or UDim2.new(0, 300, 0, 350)
    Window.MainFrame.Position = UDim2.new(0, 50, 0, 50)
    Window.MainFrame.BackgroundColor3 = Theme.Background
    Window.MainFrame.BorderSizePixel = 0
    Window.MainFrame.ClipsDescendants = true
    Window.MainFrame.Parent = Window.ScreenGui
    
    Instance.new("UICorner", Window.MainFrame).CornerRadius = UDim.new(0, 8)
    
    -- Title Bar
    Window.TitleBar = Instance.new("Frame")
    Window.TitleBar.Name = "TitleBar"
    Window.TitleBar.Size = UDim2.new(1, 0, 0, 30)
    Window.TitleBar.BackgroundColor3 = Theme.Secondary
    Window.TitleBar.BorderSizePixel = 0
    Window.TitleBar.Parent = Window.MainFrame
    
    -- Title
    Window.Title = Instance.new("TextLabel")
    Window.Title.Size = UDim2.new(0.8, 0, 1, 0)
    Window.Title.Position = UDim2.new(0.05, 0, 0, 0)
    Window.Title.BackgroundTransparency = 1
    Window.Title.Text = title
    Window.Title.TextColor3 = Theme.Text
    Window.Title.Font = Enum.Font.GothamSemibold
    Window.Title.TextSize = 12
    Window.Title.TextXAlignment = Enum.TextXAlignment.Left
    Window.Title.Parent = Window.TitleBar
    
    -- Minimize Button
    Window.MinimizeBtn = Instance.new("TextButton")
    Window.MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
    Window.MinimizeBtn.Position = UDim2.new(1, -30, 0, 2.5)
    Window.MinimizeBtn.BackgroundColor3 = Theme.Button
    Window.MinimizeBtn.BorderSizePixel = 0
    Window.MinimizeBtn.Text = "−"
    Window.MinimizeBtn.TextColor3 = Theme.Text
    Window.MinimizeBtn.Font = Enum.Font.GothamBold
    Window.MinimizeBtn.TextSize = 14
    Window.MinimizeBtn.Parent = Window.TitleBar
    
    Instance.new("UICorner", Window.MinimizeBtn).CornerRadius = UDim.new(0, 4)
    
    -- Tab Container
    Window.TabContainer = Instance.new("ScrollingFrame")
    Window.TabContainer.Size = UDim2.new(1, -10, 0, 30)
    Window.TabContainer.Position = UDim2.new(0, 5, 0, 35)
    Window.TabContainer.BackgroundTransparency = 1
    Window.TabContainer.BorderSizePixel = 0
    Window.TabContainer.ScrollBarThickness = 0
    Window.TabContainer.ScrollingDirection = Enum.ScrollingDirection.X
    Window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    Window.TabContainer.AutomaticCanvasSize = Enum.AutomaticSize.X
    Window.TabContainer.Parent = Window.MainFrame
    
    local TabLayout = Instance.new("UIListLayout")
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.Padding = UDim.new(0, 3)
    TabLayout.Parent = Window.TabContainer
    
    -- Content Frame
    Window.ContentFrame = Instance.new("Frame")
    Window.ContentFrame.Size = UDim2.new(1, -10, 1, -75)
    Window.ContentFrame.Position = UDim2.new(0, 5, 0, 70)
    Window.ContentFrame.BackgroundTransparency = 1
    Window.ContentFrame.Parent = Window.MainFrame
    
    -- Minimized Frame
    Window.MinimizedFrame = Instance.new("Frame")
    Window.MinimizedFrame.Size = UDim2.new(0, 150, 0, 25)
    Window.MinimizedFrame.Position = UDim2.new(0, 50, 1, -75)
    Window.MinimizedFrame.BackgroundColor3 = Theme.Secondary
    Window.MinimizedFrame.BorderSizePixel = 0
    Window.MinimizedFrame.Visible = false
    Window.MinimizedFrame.Parent = Window.ScreenGui
    
    Instance.new("UICorner", Window.MinimizedFrame).CornerRadius = UDim.new(0, 8)
    
    Window.RestoreBtn = Instance.new("TextButton")
    Window.RestoreBtn.Size = UDim2.new(1, 0, 1, 0)
    Window.RestoreBtn.BackgroundTransparency = 1
    Window.RestoreBtn.Text = "▲ " .. title
    Window.RestoreBtn.TextColor3 = Theme.Text
    Window.RestoreBtn.Font = Enum.Font.GothamSemibold
    Window.RestoreBtn.TextSize = 11
    Window.RestoreBtn.Parent = Window.MinimizedFrame
    
    -- Minimize/Restore Functions
    local function toggleMinimize()
        Window.minimized = not Window.minimized
        Window.MainFrame.Visible = not Window.minimized
        Window.MinimizedFrame.Visible = Window.minimized
        Window.MinimizeBtn.Text = Window.minimized and "+" or "−"
    end
    
    Window.MinimizeBtn.MouseButton1Click:Connect(toggleMinimize)
    Window.RestoreBtn.MouseButton1Click:Connect(toggleMinimize)
    
    -- Dragging System
    local function makeDraggable(frame)
        local dragging, dragInput, dragStart, startPos
        
        local function update(input)
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
        
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        
        frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    end
    
    makeDraggable(Window.MainFrame)
    makeDraggable(Window.MinimizedFrame)
    
    -- Window Methods
    function Window:CreateTab(name)
        local Tab = {
            name = name,
            elements = {},
            active = false
        }
        
        -- Tab Button
        Tab.Button = Instance.new("TextButton")
        Tab.Button.Size = UDim2.new(0, 80, 1, 0)
        Tab.Button.BackgroundColor3 = #Window.tabs == 0 and Theme.Accent or Theme.Button
        Tab.Button.BorderSizePixel = 0
        Tab.Button.Text = name
        Tab.Button.TextColor3 = Theme.Text
        Tab.Button.Font = Enum.Font.GothamMedium
        Tab.Button.TextSize = 10
        Tab.Button.Parent = Window.TabContainer
        
        Instance.new("UICorner", Tab.Button).CornerRadius = UDim.new(0, 4)
        
        -- Tab Content
        Tab.Content = Instance.new("ScrollingFrame")
        Tab.Content.Size = UDim2.new(1, 0, 1, 0)
        Tab.Content.BackgroundTransparency = 1
        Tab.Content.BorderSizePixel = 0
        Tab.Content.ScrollBarThickness = 2
        Tab.Content.ScrollBarImageColor3 = Theme.Accent
        Tab.Content.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Tab.Content.Visible = #Window.tabs == 0
        Tab.Content.Parent = Window.ContentFrame
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Padding = UDim.new(0, 5)
        ContentLayout.Parent = Tab.Content
        
        -- Tab Selection
        Tab.Button.MouseButton1Click:Connect(function()
            for i, tab in pairs(Window.tabs) do
                tab.Button.BackgroundColor3 = Theme.Button
                tab.Content.Visible = false
                tab.active = false
            end
            Tab.Button.BackgroundColor3 = Theme.Accent
            Tab.Content.Visible = true
            Tab.active = true
            Window.currentTab = #Window.tabs + 1
        end)
        
        -- Tab Methods
        function Tab:CreateToggle(text, default, callback)
            local Toggle = {
                enabled = default or false,
                callback = callback or function() end
            }
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, -5, 0, 35)
            ToggleFrame.BackgroundColor3 = Theme.Button
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = Tab.Content
            
            Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 4)
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = text
            ToggleLabel.TextColor3 = Theme.Text
            ToggleLabel.Font = Enum.Font.GothamMedium
            ToggleLabel.TextSize = 11
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Parent = ToggleFrame
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Size = UDim2.new(0, 40, 0, 20)
            ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
            ToggleButton.BackgroundColor3 = Toggle.enabled and Theme.Success or Theme.Error
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = Toggle.enabled and "ON" or "OFF"
            ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleButton.Font = Enum.Font.GothamBold
            ToggleButton.TextSize = 9
            ToggleButton.Parent = ToggleFrame
            
            Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 10)
            
            ToggleButton.MouseButton1Click:Connect(function()
                Toggle.enabled = not Toggle.enabled
                ToggleButton.Text = Toggle.enabled and "ON" or "OFF"
                ToggleButton.BackgroundColor3 = Toggle.enabled and Theme.Success or Theme.Error
                Toggle.callback(Toggle.enabled)
            end)
            
            table.insert(Tab.elements, Toggle)
            return Toggle
        end
        
        function Tab:CreateButton(text, callback)
            local ButtonFrame = Instance.new("TextButton")
            ButtonFrame.Size = UDim2.new(1, -5, 0, 35)
            ButtonFrame.BackgroundColor3 = Theme.Button
            ButtonFrame.BorderSizePixel = 0
            ButtonFrame.Text = text
            ButtonFrame.TextColor3 = Theme.Text
            ButtonFrame.Font = Enum.Font.GothamMedium
            ButtonFrame.TextSize = 11
            ButtonFrame.Parent = Tab.Content
            
            Instance.new("UICorner", ButtonFrame).CornerRadius = UDim.new(0, 4)
            
            ButtonFrame.MouseEnter:Connect(function()
                ButtonFrame.BackgroundColor3 = Theme.ButtonHover
            end)
            
            ButtonFrame.MouseLeave:Connect(function()
                ButtonFrame.BackgroundColor3 = Theme.Button
            end)
            
            ButtonFrame.MouseButton1Click:Connect(function()
                if callback then callback() end
            end)
            
            return ButtonFrame
        end
        
        function Tab:CreateLabel(text, visible)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -5, 0, 25)
            Label.BackgroundColor3 = Theme.Secondary
            Label.BorderSizePixel = 0
            Label.Text = text
            Label.TextColor3 = Theme.Text
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 11
            Label.Visible = visible ~= false
            Label.Parent = Tab.Content
            
            Instance.new("UICorner", Label).CornerRadius = UDim.new(0, 4)
            
            return Label
        end
        
        function Tab:CreateSlider(text, min, max, default, callback)
            local Slider = {
                value = default or min,
                callback = callback or function() end
            }
            
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, -5, 0, 45)
            SliderFrame.BackgroundColor3 = Theme.Button
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Parent = Tab.Content
            
            Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 4)
            
            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Size = UDim2.new(1, -10, 0, 20)
            SliderLabel.Position = UDim2.new(0, 5, 0, 0)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = text .. ": " .. Slider.value
            SliderLabel.TextColor3 = Theme.Text
            SliderLabel.Font = Enum.Font.GothamMedium
            SliderLabel.TextSize = 10
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Parent = SliderFrame
            
            local SliderBar = Instance.new("Frame")
            SliderBar.Size = UDim2.new(1, -20, 0, 4)
            SliderBar.Position = UDim2.new(0, 10, 1, -15)
            SliderBar.BackgroundColor3 = Theme.Secondary
            SliderBar.BorderSizePixel = 0
            SliderBar.Parent = SliderFrame
            
            Instance.new("UICorner", SliderBar).CornerRadius = UDim.new(0, 2)
            
            local SliderButton = Instance.new("TextButton")
            SliderButton.Size = UDim2.new(0, 16, 0, 16)
            SliderButton.Position = UDim2.new((Slider.value - min) / (max - min), -8, 0.5, -8)
            SliderButton.BackgroundColor3 = Theme.Accent
            SliderButton.BorderSizePixel = 0
            SliderButton.Text = ""
            SliderButton.Parent = SliderBar
            
            Instance.new("UICorner", SliderButton).CornerRadius = UDim.new(0, 8)
            
            local dragging = false
            SliderButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local percentage = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                    Slider.value = math.floor(min + (max - min) * percentage)
                    SliderButton.Position = UDim2.new(percentage, -8, 0.5, -8)
                    SliderLabel.Text = text .. ": " .. Slider.value
                    Slider.callback(Slider.value)
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            return Slider
        end
        
        table.insert(Window.tabs, Tab)
        return Tab
    end
    
    function Window:Destroy()
        for _, connection in pairs(Window.connections) do
            connection:Disconnect()
        end
        Window.ScreenGui:Destroy()
    end
    
    return Window
end

return Library
