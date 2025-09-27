local Library = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

local Animations = true

local Theme = {
    Background = Color3.fromRGB(25, 20, 15),
    Secondary = Color3.fromRGB(30, 25, 18),
    Accent = Color3.fromRGB(255, 193, 7),
    Button = Color3.fromRGB(255, 193, 7),
    ButtonHover = Color3.fromRGB(255, 205, 40),
    ButtonActive = Color3.fromRGB(255, 180, 0),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(240, 240, 240),
    Success = Color3.fromRGB(76, 175, 80),
    Error = Color3.fromRGB(244, 67, 54),
    ScrollBar = Color3.fromRGB(255, 193, 7),
    Gradient = {
        Top = Color3.fromRGB(255, 193, 7),
        Bottom = Color3.fromRGB(25, 20, 15)
    }
}

local function createGradient(parent, colors)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, colors.Top),
        ColorSequenceKeypoint.new(1, colors.Bottom)
    }
    gradient.Rotation = 90
    gradient.Parent = parent
    return gradient
end

local function animateProperty(object, properties, duration, easingStyle, easingDirection)
    if not Animations then
        for prop, value in pairs(properties) do
            object[prop] = value
        end
        return
    end
    
    local tweenInfo = TweenInfo.new(
        duration or 0.3,
        easingStyle or Enum.EasingStyle.Quad,
        easingDirection or Enum.EasingDirection.Out
    )
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

function Library:CreateWindow(title, size)
    local Window = {
        title = title or "Solven Hub",
        tabs = {},
        currentTab = 1,
        minimized = false,
        connections = {}
    }

    Window.ScreenGui = Instance.new("ScreenGui")
    Window.ScreenGui.Name = (title or "UI") .. "UI"
    Window.ScreenGui.ResetOnSpawn = false
    Window.ScreenGui.Parent = CoreGui

    Window.MainFrame = Instance.new("Frame")
    Window.MainFrame.Name = "MainFrame"
    Window.MainFrame.Size = size or UDim2.new(0, 320, 0, 400)
    Window.MainFrame.Position = UDim2.new(0, 20, 0, 20)
    Window.MainFrame.BackgroundColor3 = Theme.Background
    Window.MainFrame.BackgroundTransparency = 0.05
    Window.MainFrame.BorderSizePixel = 0
    Window.MainFrame.ClipsDescendants = true
    Window.MainFrame.Parent = Window.ScreenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = Window.MainFrame

    local mainGradient = createGradient(Window.MainFrame, Theme.Gradient)
    mainGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(1, 0.05)
    }

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Theme.Accent
    mainStroke.Thickness = 2
    mainStroke.Transparency = 0.7
    mainStroke.Parent = Window.MainFrame

    Window.TitleBar = Instance.new("Frame")
    Window.TitleBar.Name = "TitleBar"
    Window.TitleBar.Size = UDim2.new(1, 0, 0, 35)
    Window.TitleBar.BackgroundColor3 = Theme.Accent
    Window.TitleBar.BorderSizePixel = 0
    Window.TitleBar.Parent = Window.MainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 10)
    titleCorner.Parent = Window.TitleBar

    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Theme.Accent),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 180, 0))
    }
    titleGradient.Rotation = 45
    titleGradient.Parent = Window.TitleBar

    Window.Title = Instance.new("TextLabel")
    Window.Title.Size = UDim2.new(0.75, 0, 1, 0)
    Window.Title.Position = UDim2.new(0.08, 0, 0, 0)
    Window.Title.BackgroundTransparency = 1
    Window.Title.Text = Window.title
    Window.Title.TextColor3 = Color3.fromRGB(0, 0, 0)
    Window.Title.Font = Enum.Font.GothamBold
    Window.Title.TextSize = 14
    Window.Title.Parent = Window.TitleBar

    Window.MinimizeBtn = Instance.new("TextButton")
    Window.MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    Window.MinimizeBtn.Position = UDim2.new(1, -35, 0, 2.5)
    Window.MinimizeBtn.AnchorPoint = Vector2.new(1, 0)
    Window.MinimizeBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Window.MinimizeBtn.BackgroundTransparency = 0.3
    Window.MinimizeBtn.BorderSizePixel = 0
    Window.MinimizeBtn.Text = "−"
    Window.MinimizeBtn.TextColor3 = Theme.Accent
    Window.MinimizeBtn.Font = Enum.Font.GothamBold
    Window.MinimizeBtn.TextSize = 16
    Window.MinimizeBtn.Parent = Window.TitleBar

    local minimizeBtnCorner = Instance.new("UICorner")
    minimizeBtnCorner.CornerRadius = UDim.new(1, 0)
    minimizeBtnCorner.Parent = Window.MinimizeBtn

    Window.TabScrollFrame = Instance.new("ScrollingFrame")
    Window.TabScrollFrame.Size = UDim2.new(1, -10, 0, 38)
    Window.TabScrollFrame.Position = UDim2.new(0, 5, 0, 38)
    Window.TabScrollFrame.BackgroundTransparency = 1
    Window.TabScrollFrame.BorderSizePixel = 0
    Window.TabScrollFrame.ScrollBarThickness = 4
    Window.TabScrollFrame.ScrollBarImageColor3 = Theme.ScrollBar
    Window.TabScrollFrame.CanvasSize = UDim2.new(0, 320, 0, 0)
    Window.TabScrollFrame.ScrollingDirection = Enum.ScrollingDirection.X
    Window.TabScrollFrame.Parent = Window.MainFrame

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.Parent = Window.TabScrollFrame

    Window.ContentFrame = Instance.new("Frame")
    Window.ContentFrame.Size = UDim2.new(1, -10, 1, -84)
    Window.ContentFrame.Position = UDim2.new(0, 5, 0, 76)
    Window.ContentFrame.BackgroundTransparency = 1
    Window.ContentFrame.Parent = Window.MainFrame

    Window.MinimizedFrame = Instance.new("Frame")
    Window.MinimizedFrame.Size = UDim2.new(0, 150, 0, 35)
    Window.MinimizedFrame.Position = UDim2.new(0, 20, 1, -55)
    Window.MinimizedFrame.BackgroundColor3 = Theme.Secondary
    Window.MinimizedFrame.BackgroundTransparency = 0.1
    Window.MinimizedFrame.BorderSizePixel = 0
    Window.MinimizedFrame.Visible = false
    Window.MinimizedFrame.Parent = Window.ScreenGui

    local minimizedCorner = Instance.new("UICorner")
    minimizedCorner.CornerRadius = UDim.new(0, 10)
    minimizedCorner.Parent = Window.MinimizedFrame

    local minimizedStroke = Instance.new("UIStroke")
    minimizedStroke.Color = Theme.Accent
    minimizedStroke.Thickness = 2
    minimizedStroke.Parent = Window.MinimizedFrame

    Window.RestoreBtn = Instance.new("TextButton")
    Window.RestoreBtn.Size = UDim2.new(1, 0, 1, 0)
    Window.RestoreBtn.BackgroundTransparency = 1
    Window.RestoreBtn.Text = "▲ " .. Window.title
    Window.RestoreBtn.TextColor3 = Theme.Text
    Window.RestoreBtn.Font = Enum.Font.GothamSemibold
    Window.RestoreBtn.TextSize = 12
    Window.RestoreBtn.Parent = Window.MinimizedFrame

    local function toggleMinimize()
        Window.minimized = not Window.minimized
        
        if Window.minimized then
            animateProperty(Window.MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.4)
            task.wait(0.4)
            Window.MainFrame.Visible = false
            Window.MinimizedFrame.Visible = true
            animateProperty(Window.MinimizedFrame, {Size = UDim2.new(0, 150, 0, 35)}, 0.3)
        else
            animateProperty(Window.MinimizedFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
            task.wait(0.3)
            Window.MinimizedFrame.Visible = false
            Window.MainFrame.Visible = true
            animateProperty(Window.MainFrame, {Size = size or UDim2.new(0, 320, 0, 400)}, 0.4)
        end
        
        Window.MinimizeBtn.Text = Window.minimized and "+" or "−"
    end

    Window.MinimizeBtn.MouseButton1Click:Connect(toggleMinimize)
    Window.RestoreBtn.MouseButton1Click:Connect(toggleMinimize)

    Window.MinimizeBtn.MouseEnter:Connect(function()
        animateProperty(Window.MinimizeBtn, {BackgroundTransparency = 0.1}, 0.2)
    end)

    Window.MinimizeBtn.MouseLeave:Connect(function()
        animateProperty(Window.MinimizeBtn, {BackgroundTransparency = 0.3}, 0.2)
    end)

    local function clampPosition(frame)
        local screenSize = workspace.CurrentCamera.ViewportSize
        local frameSize = frame.AbsoluteSize
        local currentPos = frame.Position
        local newX = math.max(0, math.min(currentPos.X.Offset, screenSize.X - frameSize.X))
        local newY = math.max(0, math.min(currentPos.Y.Offset, screenSize.Y - frameSize.Y))
        frame.Position = UDim2.new(0, newX, 0, newY)
    end

    local dragging = false
    local dragStart, frameStart

    local function updateDrag(input)
        if not dragging then return end
        local delta = input.Position - dragStart
        local newPosition = UDim2.new(0, frameStart.X.Offset + delta.X, 0, frameStart.Y.Offset + delta.Y)
        
        if Window.minimized then
            Window.MinimizedFrame.Position = newPosition
            clampPosition(Window.MinimizedFrame)
        else
            Window.MainFrame.Position = newPosition
            clampPosition(Window.MainFrame)
        end
    end

    local function startDrag(input, frame)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            frameStart = frame.Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    if connection then connection:Disconnect() end
                end
            end)
        end
    end

    Window.TitleBar.InputBegan:Connect(function(input)
        startDrag(input, Window.MainFrame)
    end)

    Window.TitleBar.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            updateDrag(input)
        end
    end)

    Window.MinimizedFrame.InputBegan:Connect(function(input)
        startDrag(input, Window.MinimizedFrame)
    end)

    Window.MinimizedFrame.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            updateDrag(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateDrag(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    local function autoResize()
        local screenSize = workspace.CurrentCamera.ViewportSize
        
        if screenSize.X < 800 then
            Window.MainFrame.Size = UDim2.new(0, math.min(300, screenSize.X - 40), 0, math.min(350, screenSize.Y - 40))
            Window.Title.TextSize = 12
        else
            Window.MainFrame.Size = UDim2.new(0, 320, 0, 400)
            Window.Title.TextSize = 14
        end
    end

    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        autoResize()
        clampPosition(Window.MainFrame)
        clampPosition(Window.MinimizedFrame)
    end)

    task.spawn(function()
        task.wait(0.1)
        autoResize()
        clampPosition(Window.MainFrame)
        
        if Animations then
            Window.MainFrame.Size = UDim2.new(0, 0, 0, 0)
            animateProperty(Window.MainFrame, {Size = size or UDim2.new(0, 320, 0, 400)}, 0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        end
    end)

    function Window:CreateTab(name)
        local tabIndex = #Window.tabs + 1
        local Tab = {
            name = name,
            elements = {},
            active = tabIndex == 1
        }

        Tab.Button = Instance.new("TextButton")
        Tab.Button.Size = UDim2.new(0, 100, 1, -4)
        Tab.Button.BackgroundColor3 = tabIndex == 1 and Theme.Button or Theme.Secondary
        Tab.Button.BorderSizePixel = 0
        Tab.Button.Text = name
        Tab.Button.TextColor3 = tabIndex == 1 and Color3.fromRGB(0, 0, 0) or Theme.Text
        Tab.Button.Font = Enum.Font.GothamSemibold
        Tab.Button.TextSize = 11
        Tab.Button.Parent = Window.TabScrollFrame
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 8)
        tabCorner.Parent = Tab.Button

        if tabIndex == 1 then
            local tabGradient = Instance.new("UIGradient")
            tabGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Theme.Button),
                ColorSequenceKeypoint.new(1, Theme.ButtonActive)
            }
            tabGradient.Rotation = 45
            tabGradient.Parent = Tab.Button
        end

        Tab.Content = Instance.new("Frame")
        Tab.Content.Size = UDim2.new(1, 0, 1, 0)
        Tab.Content.BackgroundTransparency = 1
        Tab.Content.Visible = tabIndex == 1
        Tab.Content.Parent = Window.ContentFrame

        Tab.ScrollFrame = Instance.new("ScrollingFrame")
        Tab.ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollFrame.BackgroundTransparency = 1
        Tab.ScrollFrame.BorderSizePixel = 0
        Tab.ScrollFrame.ScrollBarThickness = 4
        Tab.ScrollFrame.ScrollBarImageColor3 = Theme.ScrollBar
        Tab.ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 200)
        Tab.ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Tab.ScrollFrame.Parent = Tab.Content

        local scrollLayout = Instance.new("UIListLayout")
        scrollLayout.Padding = UDim.new(0, 8)
        scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
        scrollLayout.Parent = Tab.ScrollFrame

        local scrollPadding = Instance.new("UIPadding")
        scrollPadding.PaddingLeft = UDim.new(0, 5)
        scrollPadding.PaddingRight = UDim.new(0, 5)
        scrollPadding.PaddingTop = UDim.new(0, 5)
        scrollPadding.Parent = Tab.ScrollFrame

        Tab.Button.MouseEnter:Connect(function()
            if not Tab.active then
                animateProperty(Tab.Button, {BackgroundColor3 = Color3.fromRGB(60, 55, 40)}, 0.2)
            end
        end)

        Tab.Button.MouseLeave:Connect(function()
            if not Tab.active then
                animateProperty(Tab.Button, {BackgroundColor3 = Theme.Secondary}, 0.2)
            end
        end)

        Tab.Button.MouseButton1Click:Connect(function()
            if Tab.active then return end
            
            for i, t in pairs(Window.tabs) do
                if t.active then
                    animateProperty(t.Button, {BackgroundColor3 = Theme.Secondary}, 0.2)
                    t.Button.TextColor3 = Theme.Text
                    if t.Button:FindFirstChild("UIGradient") then
                        t.Button.UIGradient:Destroy()
                    end
                    animateProperty(t.Content, {Position = UDim2.new(-1, 0, 0, 0)}, 0.3)
                    task.wait(0.3)
                    t.Content.Visible = false
                    t.Content.Position = UDim2.new(1, 0, 0, 0)
                end
                t.active = false
            end
            
            animateProperty(Tab.Button, {BackgroundColor3 = Theme.Button}, 0.2)
            Tab.Button.TextColor3 = Color3.fromRGB(0, 0, 0)
            
            local tabGradient = Instance.new("UIGradient")
            tabGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Theme.Button),
                ColorSequenceKeypoint.new(1, Theme.ButtonActive)
            }
            tabGradient.Rotation = 45
            tabGradient.Parent = Tab.Button
            
            Tab.Content.Visible = true
            animateProperty(Tab.Content, {Position = UDim2.new(0, 0, 0, 0)}, 0.3)
            Tab.active = true
            Window.currentTab = tabIndex
        end)

        function Tab:CreateToggle(text, callback, defaultState)
            local Toggle = { enabled = defaultState or false, callback = callback or function() end }

            local toggleFrame = Instance.new("Frame")
            toggleFrame.Size = UDim2.new(1, -10, 0, 40)
            toggleFrame.BackgroundColor3 = Theme.Secondary
            toggleFrame.BackgroundTransparency = 0.2
            toggleFrame.BorderSizePixel = 0
            toggleFrame.Parent = Tab.ScrollFrame
            
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 8)
            toggleCorner.Parent = toggleFrame

            local toggleStroke = Instance.new("UIStroke")
            toggleStroke.Color = Theme.Accent
            toggleStroke.Thickness = 1
            toggleStroke.Transparency = 0.8
            toggleStroke.Parent = toggleFrame
            
            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Size = UDim2.new(0.65, 0, 1, 0)
            toggleLabel.Position = UDim2.new(0, 15, 0, 0)
            toggleLabel.BackgroundTransparency = 1
            toggleLabel.Text = text
            toggleLabel.TextColor3 = Theme.TextSecondary
            toggleLabel.Font = Enum.Font.GothamMedium
            toggleLabel.TextSize = 12
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.Parent = toggleFrame
            
            local toggleButton = Instance.new("TextButton")
            toggleButton.Size = UDim2.new(0, 50, 0, 25)
            toggleButton.Position = UDim2.new(1, -60, 0.5, -12.5)
            toggleButton.BackgroundColor3 = Toggle.enabled and Theme.Success or Color3.fromRGB(60, 60, 70)
            toggleButton.BorderSizePixel = 0
            toggleButton.Text = Toggle.enabled and "ON" or "OFF"
            toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggleButton.Font = Enum.Font.GothamBold
            toggleButton.TextSize = 10
            toggleButton.Parent = toggleFrame
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 12)
            buttonCorner.Parent = toggleButton

            toggleFrame.MouseEnter:Connect(function()
                animateProperty(toggleStroke, {Transparency = 0.5}, 0.2)
            end)

            toggleFrame.MouseLeave:Connect(function()
                animateProperty(toggleStroke, {Transparency = 0.8}, 0.2)
            end)
            
            toggleButton.MouseButton1Click:Connect(function()
                Toggle.enabled = not Toggle.enabled
                
                local targetColor = Toggle.enabled and Theme.Success or Color3.fromRGB(60, 60, 70)
                animateProperty(toggleButton, {BackgroundColor3 = targetColor}, 0.2)
                
                toggleButton.Text = Toggle.enabled and "ON" or "OFF"
                Toggle.callback(Toggle.enabled)
            end)

            table.insert(Tab.elements, Toggle)
            return Toggle
        end

        function Tab:CreateButton(text, callback)
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -10, 0, 40)
            button.BackgroundColor3 = Theme.Button
            button.BackgroundTransparency = 0.1
            button.BorderSizePixel = 0
            button.Text = text
            button.TextColor3 = Color3.fromRGB(0, 0, 0)
            button.Font = Enum.Font.GothamSemibold
            button.TextSize = 12
            button.Parent = Tab.ScrollFrame
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 8)
            buttonCorner.Parent = button

            local buttonGradient = Instance.new("UIGradient")
            buttonGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Theme.Button),
                ColorSequenceKeypoint.new(1, Theme.ButtonActive)
            }
            buttonGradient.Rotation = 45
            buttonGradient.Parent = button
            
            button.MouseEnter:Connect(function()
                animateProperty(button, {Size = UDim2.new(1, -8, 0, 42)}, 0.2)
                animateProperty(button, {BackgroundTransparency = 0}, 0.2)
            end)
            
            button.MouseLeave:Connect(function()
                animateProperty(button, {Size = UDim2.new(1, -10, 0, 40)}, 0.2)
                animateProperty(button, {BackgroundTransparency = 0.1}, 0.2)
            end)

            button.MouseButton1Down:Connect(function()
                animateProperty(button, {Size = UDim2.new(1, -12, 0, 38)}, 0.1)
            end)

            button.MouseButton1Up:Connect(function()
                animateProperty(button, {Size = UDim2.new(1, -8, 0, 42)}, 0.1)
            end)
            
            button.MouseButton1Click:Connect(callback)
            
            return button
        end

        function Tab:CreateSlider(text, min, max, defaultValue, callback)
            local Slider = { 
                value = defaultValue or min, 
                min = min, 
                max = max, 
                callback = callback or function() end 
            }

            local sliderFrame = Instance.new("Frame")
            sliderFrame.Size = UDim2.new(1, -10, 0, 50)
            sliderFrame.BackgroundColor3 = Theme.Secondary
            sliderFrame.BackgroundTransparency = 0.2
            sliderFrame.BorderSizePixel = 0
            sliderFrame.Parent = Tab.ScrollFrame
            
            local sliderCorner = Instance.new("UICorner")
            sliderCorner.CornerRadius = UDim.new(0, 8)
            sliderCorner.Parent = sliderFrame

            local sliderStroke = Instance.new("UIStroke")
            sliderStroke.Color = Theme.Accent
            sliderStroke.Thickness = 1
            sliderStroke.Transparency = 0.8
            sliderStroke.Parent = sliderFrame
            
            local sliderLabel = Instance.new("TextLabel")
            sliderLabel.Size = UDim2.new(0.6, 0, 0, 20)
            sliderLabel.Position = UDim2.new(0, 15, 0, 5)
            sliderLabel.BackgroundTransparency = 1
            sliderLabel.Text = text
            sliderLabel.TextColor3 = Theme.TextSecondary
            sliderLabel.Font = Enum.Font.GothamMedium
            sliderLabel.TextSize = 12
            sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            sliderLabel.Parent = sliderFrame

            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0, 50, 0, 20)
            valueLabel.Position = UDim2.new(1, -60, 0, 5)
            valueLabel.BackgroundTransparency = 1
            valueLabel.Text = tostring(Slider.value)
            valueLabel.TextColor3 = Theme.Accent
            valueLabel.Font = Enum.Font.GothamBold
            valueLabel.TextSize = 11
            valueLabel.Parent = sliderFrame
            
            local sliderTrack = Instance.new("Frame")
            sliderTrack.Size = UDim2.new(1, -30, 0, 6)
            sliderTrack.Position = UDim2.new(0, 15, 1, -18)
            sliderTrack.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            sliderTrack.BorderSizePixel = 0
            sliderTrack.Parent = sliderFrame
            
            local trackCorner = Instance.new("UICorner")
            trackCorner.CornerRadius = UDim.new(1, 0)
            trackCorner.Parent = sliderTrack
            
            local sliderFill = Instance.new("Frame")
            sliderFill.Size = UDim2.new((Slider.value - Slider.min) / (Slider.max - Slider.min), 0, 1, 0)
            sliderFill.BackgroundColor3 = Theme.Accent
            sliderFill.BorderSizePixel = 0
            sliderFill.Parent = sliderTrack
            
            local fillCorner = Instance.new("UICorner")
            fillCorner.CornerRadius = UDim.new(1, 0)
            fillCorner.Parent = sliderFill
            
            local sliderKnob = Instance.new("Frame")
            sliderKnob.Size = UDim2.new(0, 16, 0, 16)
            sliderKnob.Position = UDim2.new((Slider.value - Slider.min) / (Slider.max - Slider.min), -8, 0.5, -8)
            sliderKnob.BackgroundColor3 = Theme.Accent
            sliderKnob.BorderSizePixel = 0
            sliderKnob.Parent = sliderTrack
            
            local knobCorner = Instance.new("UICorner")
            knobCorner.CornerRadius = UDim.new(1, 0)
            knobCorner.Parent = sliderKnob

            local dragging = false

            local function updateSlider(input)
                local trackSize = sliderTrack.AbsoluteSize.X
                local trackPos = sliderTrack.AbsolutePosition.X
                local mouseX = input.Position.X
                local relativeX = mouseX - trackPos
                local percentage = math.clamp(relativeX / trackSize, 0, 1)
                
                Slider.value = math.floor(Slider.min + (Slider.max - Slider.min) * percentage)
                valueLabel.Text = tostring(Slider.value)
                
                animateProperty(sliderFill, {Size = UDim2.new(percentage, 0, 1, 0)}, 0.1)
                animateProperty(sliderKnob, {Position = UDim2.new(percentage, -8, 0.5, -8)}, 0.1)
                
                Slider.callback(Slider.value)
            end

            sliderTrack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    updateSlider(input)
                    animateProperty(sliderKnob, {Size = UDim2.new(0, 20, 0, 20)}, 0.1)
                end
            end)

            sliderTrack.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateSlider(input)
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    if dragging then
                        dragging = false
                        animateProperty(sliderKnob, {Size = UDim2.new(0, 16, 0, 16)}, 0.2)
                    end
                end
            end)

            sliderFrame.MouseEnter:Connect(function()
                animateProperty(sliderStroke, {Transparency = 0.5}, 0.2)
            end)

            sliderFrame.MouseLeave:Connect(function()
                animateProperty(sliderStroke, {Transparency = 0.8}, 0.2)
            end)

            table.insert(Tab.elements, Slider)
            return Slider
        end

        function Tab:CreateTextButton(text, placeholder, callback)
            local TextButton = { 
                text = "", 
                callback = callback or function() end 
            }

            local textFrame = Instance.new("Frame")
            textFrame.Size = UDim2.new(1, -10, 0, 70)
            textFrame.BackgroundColor3 = Theme.Secondary
            textFrame.BackgroundTransparency = 0.2
            textFrame.BorderSizePixel = 0
            textFrame.Parent = Tab.ScrollFrame
            
            local textCorner = Instance.new("UICorner")
            textCorner.CornerRadius = UDim.new(0, 8)
            textCorner.Parent = textFrame

            local textStroke = Instance.new("UIStroke")
            textStroke.Color = Theme.Accent
            textStroke.Thickness = 1
            textStroke.Transparency = 0.8
            textStroke.Parent = textFrame
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, -20, 0, 25)
            textLabel.Position = UDim2.new(0, 10, 0, 5)
            textLabel.BackgroundTransparency = 1
            textLabel.Text = text
            textLabel.TextColor3 = Theme.TextSecondary
            textLabel.Font = Enum.Font.GothamMedium
            textLabel.TextSize = 12
            textLabel.TextXAlignment = Enum.TextXAlignment.Left
            textLabel.Parent = textFrame
            
            local textBox = Instance.new("TextBox")
            textBox.Size = UDim2.new(0.7, 0, 0, 25)
            textBox.Position = UDim2.new(0, 10, 0, 30)
            textBox.BackgroundColor3 = Color3.fromRGB(40, 35, 25)
            textBox.BackgroundTransparency = 0.3
            textBox.BorderSizePixel = 0
            textBox.Text = ""
            textBox.PlaceholderText = placeholder or "Digite aqui..."
            textBox.TextColor3 = Theme.Text
            textBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            textBox.Font = Enum.Font.Gotham
            textBox.TextSize = 11
            textBox.Parent = textFrame
            
            local boxCorner = Instance.new("UICorner")
            boxCorner.CornerRadius = UDim.new(0, 6)
            boxCorner.Parent = textBox

            local boxStroke = Instance.new("UIStroke")
            boxStroke.Color = Theme.Accent
            boxStroke.Thickness = 1
            boxStroke.Transparency = 0.9
            boxStroke.Parent = textBox
            
            local submitButton = Instance.new("TextButton")
            submitButton.Size = UDim2.new(0, 60, 0, 25)
            submitButton.Position = UDim2.new(1, -70, 0, 30)
            submitButton.BackgroundColor3 = Theme.Button
            submitButton.BorderSizePixel = 0
            submitButton.Text = "Enviar"
            submitButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            submitButton.Font = Enum.Font.GothamBold
            submitButton.TextSize = 10
            submitButton.Parent = textFrame
            
            local submitCorner = Instance.new("UICorner")
            submitCorner.CornerRadius = UDim.new(0, 6)
            submitCorner.Parent = submitButton

            textBox.Focused:Connect(function()
                animateProperty(boxStroke, {Transparency = 0.5}, 0.2)
                animateProperty(textBox, {BackgroundTransparency = 0.1}, 0.2)
            end)

            textBox.FocusLost:Connect(function()
                animateProperty(boxStroke, {Transparency = 0.9}, 0.2)
                animateProperty(textBox, {BackgroundTransparency = 0.3}, 0.2)
            end)

            textFrame.MouseEnter:Connect(function()
                animateProperty(textStroke, {Transparency = 0.5}, 0.2)
            end)

            textFrame.MouseLeave:Connect(function()
                animateProperty(textStroke, {Transparency = 0.8}, 0.2)
            end)

            submitButton.MouseEnter:Connect(function()
                animateProperty(submitButton, {BackgroundColor3 = Theme.ButtonHover}, 0.2)
            end)

            submitButton.MouseLeave:Connect(function()
                animateProperty(submitButton, {BackgroundColor3 = Theme.Button}, 0.2)
            end)

            local function submitText()
                TextButton.text = textBox.Text
                if TextButton.text ~= "" then
                    TextButton.callback(TextButton.text)
                    textBox.Text = ""
                    
                    animateProperty(submitButton, {Size = UDim2.new(0, 65, 0, 27)}, 0.1)
                    task.wait(0.1)
                    animateProperty(submitButton, {Size = UDim2.new(0, 60, 0, 25)}, 0.1)
                end
            end

            submitButton.MouseButton1Click:Connect(submitText)
            
            textBox.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    submitText()
                end
            end)

            table.insert(Tab.elements, TextButton)
            return TextButton
        end

        function Tab:CreateLabel(text, visible)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -10, 0, 35)
            Label.BackgroundColor3 = Color3.fromRGB(40, 35, 25)
            Label.BackgroundTransparency = 0.4
            Label.BorderSizePixel = 0
            Label.Text = text
            Label.TextColor3 = Theme.TextSecondary
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 12
            Label.Visible = visible ~= false
            Label.Parent = Tab.ScrollFrame

            local labelCorner = Instance.new("UICorner")
            labelCorner.CornerRadius = UDim.new(0, 8)
            labelCorner.Parent = Label

            local labelStroke = Instance.new("UIStroke")
            labelStroke.Color = Theme.Accent
            labelStroke.Thickness = 1
            labelStroke.Transparency = 0.9
            labelStroke.Parent = Label

            function Label:UpdateText(newText)
                if Animations then
                    animateProperty(Label, {TextTransparency = 1}, 0.1)
                    task.wait(0.1)
                    Label.Text = newText
                    animateProperty(Label, {TextTransparency = 0}, 0.2)
                else
                    Label.Text = newText
                end
            end

            return Label
        end

        table.insert(Window.tabs, Tab)
        
        local tabWidth = math.max(100, string.len(name) * 8 + 20)
        Tab.Button.Size = UDim2.new(0, tabWidth, 1, -4)
        
        local totalWidth = 0
        for _, tab in ipairs(Window.tabs) do
            totalWidth = totalWidth + tab.Button.AbsoluteSize.X + 5
        end
        Window.TabScrollFrame.CanvasSize = UDim2.new(0, totalWidth, 0, 0)
        
        if Animations and tabIndex > 1 then
            Tab.Button.Size = UDim2.new(0, 0, 1, -4)
            animateProperty(Tab.Button, {Size = UDim2.new(0, tabWidth, 1, -4)}, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        end
        
        return Tab
    end

    function Window:SwitchTab(tabIndex)
        for i, tab in ipairs(Window.tabs) do
            if i == tabIndex then
                animateProperty(tab.Button, {BackgroundColor3 = Theme.Button}, 0.2)
                tab.Button.TextColor3 = Color3.fromRGB(0, 0, 0)
                tab.Content.Visible = true
                animateProperty(tab.Content, {Position = UDim2.new(0, 0, 0, 0)}, 0.3)
                tab.active = true
            else
                animateProperty(tab.Button, {BackgroundColor3 = Theme.Secondary}, 0.2)
                tab.Button.TextColor3 = Theme.Text
                if tab.Content.Visible then
                    animateProperty(tab.Content, {Position = UDim2.new(-1, 0, 0, 0)}, 0.3)
                    task.wait(0.3)
                    tab.Content.Visible = false
                    tab.Content.Position = UDim2.new(1, 0, 0, 0)
                end
                tab.active = false
            end
        end
        Window.currentTab = tabIndex
    end

    function Window:SetAnimations(enabled)
        Animations = enabled
    end

    function Window:Destroy()
        for _, connection in pairs(Window.connections) do
            if connection and connection.Disconnect then
                pcall(function() connection:Disconnect() end)
            end
        end
        
        if Animations then
            animateProperty(Window.MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.4)
            task.wait(0.4)
        end
        
        pcall(function() Window.ScreenGui:Destroy() end)
    end

    return Window
end

return Library
