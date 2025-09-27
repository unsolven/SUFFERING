local Library = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

local Animations = true

local Theme = {
    Background = Color3.fromRGB(25, 25, 30),
    Secondary = Color3.fromRGB(35, 35, 45),
    Accent = Color3.fromRGB(255, 193, 7),
    Button = Color3.fromRGB(255, 193, 7),
    ButtonActive = Color3.fromRGB(255, 180, 0),
    Text = Color3.fromRGB(220, 220, 220),
    TextSecondary = Color3.fromRGB(240, 240, 240),
    Success = Color3.fromRGB(100, 255, 100),
    Error = Color3.fromRGB(255, 100, 100),
    ScrollBar = Color3.fromRGB(255, 193, 7)
}

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
        title = title or "HUB",
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
    Window.MainFrame.Size = size or UDim2.new(0, 280, 0, 300)
    Window.MainFrame.Position = UDim2.new(0, 10, 0, 10)
    Window.MainFrame.BackgroundColor3 = Theme.Background
    Window.MainFrame.BackgroundTransparency = 0.1
    Window.MainFrame.BorderSizePixel = 0
    Window.MainFrame.ClipsDescendants = true
    Window.MainFrame.Parent = Window.ScreenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = Window.MainFrame

    Window.TitleBar = Instance.new("Frame")
    Window.TitleBar.Name = "TitleBar"
    Window.TitleBar.Size = UDim2.new(1, 0, 0, 24)
    Window.TitleBar.BackgroundColor3 = Theme.Secondary
    Window.TitleBar.BorderSizePixel = 0
    Window.TitleBar.Parent = Window.MainFrame

    Window.Title = Instance.new("TextLabel")
    Window.Title.Size = UDim2.new(0.75, 0, 1, 0)
    Window.Title.Position = UDim2.new(0.1, 0, 0, 0)
    Window.Title.BackgroundTransparency = 1
    Window.Title.Text = Window.title
    Window.Title.TextColor3 = Theme.Text
    Window.Title.Font = Enum.Font.GothamSemibold
    Window.Title.TextSize = 11
    Window.Title.Parent = Window.TitleBar

    Window.MinimizeBtn = Instance.new("TextButton")
    Window.MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
    Window.MinimizeBtn.Position = UDim2.new(1, -24, 0, 0)
    Window.MinimizeBtn.AnchorPoint = Vector2.new(1, 0)
    Window.MinimizeBtn.BackgroundColor3 = Theme.Button
    Window.MinimizeBtn.BorderSizePixel = 0
    Window.MinimizeBtn.Text = "▼"
    Window.MinimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    Window.MinimizeBtn.Font = Enum.Font.GothamBold
    Window.MinimizeBtn.TextSize = 10
    Window.MinimizeBtn.Parent = Window.TitleBar

    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 4)
    minimizeCorner.Parent = Window.MinimizeBtn

    Window.TabScrollFrame = Instance.new("ScrollingFrame")
    Window.TabScrollFrame.Size = UDim2.new(1, -6, 0, 28)
    Window.TabScrollFrame.Position = UDim2.new(0, 3, 0, 27)
    Window.TabScrollFrame.BackgroundTransparency = 1
    Window.TabScrollFrame.BorderSizePixel = 0
    Window.TabScrollFrame.ScrollBarThickness = 2
    Window.TabScrollFrame.ScrollBarImageColor3 = Theme.ScrollBar
    Window.TabScrollFrame.CanvasSize = UDim2.new(0, 280, 0, 0)
    Window.TabScrollFrame.ScrollingDirection = Enum.ScrollingDirection.X
    Window.TabScrollFrame.Parent = Window.MainFrame

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.Padding = UDim.new(0, 2)
    tabLayout.Parent = Window.TabScrollFrame

    Window.ContentFrame = Instance.new("Frame")
    Window.ContentFrame.Size = UDim2.new(1, -6, 1, -58)
    Window.ContentFrame.Position = UDim2.new(0, 3, 0, 55)
    Window.ContentFrame.BackgroundTransparency = 1
    Window.ContentFrame.Parent = Window.MainFrame

    Window.MinimizedFrame = Instance.new("Frame")
    Window.MinimizedFrame.Size = UDim2.new(0, 120, 0, 24)
    Window.MinimizedFrame.Position = UDim2.new(0, 10, 1, -34)
    Window.MinimizedFrame.BackgroundColor3 = Theme.Secondary
    Window.MinimizedFrame.BackgroundTransparency = 0.1
    Window.MinimizedFrame.BorderSizePixel = 0
    Window.MinimizedFrame.Visible = false
    Window.MinimizedFrame.Parent = Window.ScreenGui

    local minimizedCorner2 = Instance.new("UICorner")
    minimizedCorner2.CornerRadius = UDim.new(0, 8)
    minimizedCorner2.Parent = Window.MinimizedFrame

    Window.RestoreBtn = Instance.new("TextButton")
    Window.RestoreBtn.Size = UDim2.new(1, 0, 1, 0)
    Window.RestoreBtn.BackgroundTransparency = 1
    Window.RestoreBtn.Text = "▲ " .. Window.title
    Window.RestoreBtn.TextColor3 = Theme.Text
    Window.RestoreBtn.Font = Enum.Font.GothamSemibold
    Window.RestoreBtn.TextSize = 10
    Window.RestoreBtn.Parent = Window.MinimizedFrame

    local function toggleMinimize()
        Window.minimized = not Window.minimized
        Window.MainFrame.Visible = not Window.minimized
        Window.MinimizedFrame.Visible = Window.minimized
        Window.MinimizeBtn.Text = Window.minimized and "▲" or "▼"
    end

    Window.MinimizeBtn.MouseButton1Click:Connect(toggleMinimize)
    Window.RestoreBtn.MouseButton1Click:Connect(toggleMinimize)

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

    Window.MainFrame.InputBegan:Connect(function(input)
        startDrag(input, Window.MainFrame)
    end)

    Window.MainFrame.InputChanged:Connect(function(input)
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
        
        if screenSize.X < 600 then
            Window.MainFrame.Size = UDim2.new(0, 260, 0, 280)
            Window.Title.TextSize = 10
            Window.MinimizeBtn.TextSize = 9
        else
            Window.MainFrame.Size = UDim2.new(0, 280, 0, 300)
            Window.Title.TextSize = 11
            Window.MinimizeBtn.TextSize = 10
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
    end)

    function Window:CreateTab(name)
        local tabIndex = #Window.tabs + 1
        local Tab = {
            name = name,
            elements = {},
            active = tabIndex == 1
        }

        Tab.Button = Instance.new("TextButton")
        Tab.Button.Size = UDim2.new(0, 80, 1, 0)
        Tab.Button.BackgroundColor3 = tabIndex == 1 and Theme.Accent or Theme.Button
        Tab.Button.BorderSizePixel = 0
        Tab.Button.Text = name
        Tab.Button.TextColor3 = Color3.fromRGB(0, 0, 0)
        Tab.Button.Font = Enum.Font.GothamSemibold
        Tab.Button.TextSize = 9
        Tab.Button.Parent = Window.TabScrollFrame
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 4)
        tabCorner.Parent = Tab.Button

        Tab.Content = Instance.new("Frame")
        Tab.Content.Size = UDim2.new(1, 0, 1, 0)
        Tab.Content.BackgroundTransparency = 1
        Tab.Content.Visible = tabIndex == 1
        Tab.Content.Parent = Window.ContentFrame

        Tab.ScrollFrame = Instance.new("ScrollingFrame")
        Tab.ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollFrame.BackgroundTransparency = 1
        Tab.ScrollFrame.BorderSizePixel = 0
        Tab.ScrollFrame.ScrollBarThickness = 2
        Tab.ScrollFrame.ScrollBarImageColor3 = Theme.ScrollBar
        Tab.ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 150)
        Tab.ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Tab.ScrollFrame.Parent = Tab.Content

        local scrollLayout = Instance.new("UIListLayout")
        scrollLayout.Padding = UDim.new(0, 3)
        scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
        scrollLayout.Parent = Tab.ScrollFrame

        Tab.Button.MouseEnter:Connect(function()
            if not Tab.active and Animations then
                animateProperty(Tab.Button, {BackgroundColor3 = Color3.fromRGB(255, 205, 40)}, 0.2)
            end
        end)

        Tab.Button.MouseLeave:Connect(function()
            if not Tab.active and Animations then
                animateProperty(Tab.Button, {BackgroundColor3 = Theme.Button}, 0.2)
            end
        end)

        Tab.Button.MouseButton1Click:Connect(function()
            for i, t in pairs(Window.tabs) do
                t.Button.BackgroundColor3 = Theme.Button
                t.Content.Visible = false
                t.active = false
            end
            Tab.Button.BackgroundColor3 = Theme.Accent
            Tab.Content.Visible = true
            Tab.active = true
            Window.currentTab = tabIndex
        end)

        function Tab:CreateToggle(text, callback, defaultState)
            local Toggle = { enabled = defaultState or false, callback = callback or function() end }

            local toggleFrame = Instance.new("Frame")
            toggleFrame.Size = UDim2.new(1, -3, 0, 28)
            toggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            toggleFrame.BackgroundTransparency = 0.5
            toggleFrame.BorderSizePixel = 0
            toggleFrame.Parent = Tab.ScrollFrame
            
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 4)
            toggleCorner.Parent = toggleFrame
            
            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            toggleLabel.Position = UDim2.new(0, 5, 0, 0)
            toggleLabel.BackgroundTransparency = 1
            toggleLabel.Text = text
            toggleLabel.TextColor3 = Theme.TextSecondary
            toggleLabel.Font = Enum.Font.GothamMedium
            toggleLabel.TextSize = 10
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.Parent = toggleFrame
            
            local toggleButton = Instance.new("TextButton")
            toggleButton.Size = UDim2.new(0, 35, 0, 18)
            toggleButton.Position = UDim2.new(1, -40, 0.5, -9)
            toggleButton.BackgroundColor3 = Toggle.enabled and Color3.fromRGB(70, 90, 70) or Color3.fromRGB(60, 60, 70)
            toggleButton.BorderSizePixel = 0
            toggleButton.Text = Toggle.enabled and "ON" or "OFF"
            toggleButton.TextColor3 = Toggle.enabled and Theme.Success or Theme.Error
            toggleButton.Font = Enum.Font.GothamBold
            toggleButton.TextSize = 8
            toggleButton.Parent = toggleFrame
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 9)
            buttonCorner.Parent = toggleButton
            
            toggleButton.MouseButton1Click:Connect(function()
                Toggle.enabled = not Toggle.enabled
                if Toggle.enabled then
                    toggleButton.Text = "ON"
                    toggleButton.TextColor3 = Theme.Success
                    if Animations then
                        animateProperty(toggleButton, {BackgroundColor3 = Color3.fromRGB(70, 90, 70)}, 0.2)
                    else
                        toggleButton.BackgroundColor3 = Color3.fromRGB(70, 90, 70)
                    end
                else
                    toggleButton.Text = "OFF"
                    toggleButton.TextColor3 = Theme.Error
                    if Animations then
                        animateProperty(toggleButton, {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}, 0.2)
                    else
                        toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                    end
                end
                Toggle.callback(Toggle.enabled)
            end)

            table.insert(Tab.elements, Toggle)
            return Toggle
        end

        function Tab:CreateButton(text, callback)
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -3, 0, 28)
            button.BackgroundColor3 = Theme.Button
            button.BackgroundTransparency = 0.2
            button.BorderSizePixel = 0
            button.Text = text
            button.TextColor3 = Color3.fromRGB(0, 0, 0)
            button.Font = Enum.Font.GothamMedium
            button.TextSize = 10
            button.Parent = Tab.ScrollFrame
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 4)
            buttonCorner.Parent = button
            
            button.MouseEnter:Connect(function()
                if Animations then
                    animateProperty(button, {BackgroundTransparency = 0.1}, 0.2)
                else
                    button.BackgroundTransparency = 0.1
                end
            end)
            
            button.MouseLeave:Connect(function()
                if Animations then
                    animateProperty(button, {BackgroundTransparency = 0.2}, 0.2)
                else
                    button.BackgroundTransparency = 0.2
                end
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
            sliderFrame.Size = UDim2.new(1, -3, 0, 40)
            sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            sliderFrame.BackgroundTransparency = 0.5
            sliderFrame.BorderSizePixel = 0
            sliderFrame.Parent = Tab.ScrollFrame
            
            local sliderCorner = Instance.new("UICorner")
            sliderCorner.CornerRadius = UDim.new(0, 4)
            sliderCorner.Parent = sliderFrame
            
            local sliderLabel = Instance.new("TextLabel")
            sliderLabel.Size = UDim2.new(0.6, 0, 0, 20)
            sliderLabel.Position = UDim2.new(0, 5, 0, 2)
            sliderLabel.BackgroundTransparency = 1
            sliderLabel.Text = text
            sliderLabel.TextColor3 = Theme.TextSecondary
            sliderLabel.Font = Enum.Font.GothamMedium
            sliderLabel.TextSize = 10
            sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            sliderLabel.Parent = sliderFrame

            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0, 40, 0, 20)
            valueLabel.Position = UDim2.new(1, -45, 0, 2)
            valueLabel.BackgroundTransparency = 1
            valueLabel.Text = tostring(Slider.value)
            valueLabel.TextColor3 = Theme.Button
            valueLabel.Font = Enum.Font.GothamBold
            valueLabel.TextSize = 10
            valueLabel.Parent = sliderFrame
            
            local sliderTrack = Instance.new("Frame")
            sliderTrack.Size = UDim2.new(1, -10, 0, 4)
            sliderTrack.Position = UDim2.new(0, 5, 1, -12)
            sliderTrack.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            sliderTrack.BorderSizePixel = 0
            sliderTrack.Parent = sliderFrame
            
            local trackCorner = Instance.new("UICorner")
            trackCorner.CornerRadius = UDim.new(1, 0)
            trackCorner.Parent = sliderTrack
            
            local sliderFill = Instance.new("Frame")
            sliderFill.Size = UDim2.new((Slider.value - Slider.min) / (Slider.max - Slider.min), 0, 1, 0)
            sliderFill.BackgroundColor3 = Theme.Button
            sliderFill.BorderSizePixel = 0
            sliderFill.Parent = sliderTrack
            
            local fillCorner = Instance.new("UICorner")
            fillCorner.CornerRadius = UDim.new(1, 0)
            fillCorner.Parent = sliderFill
            
            local sliderKnob = Instance.new("Frame")
            sliderKnob.Size = UDim2.new(0, 12, 0, 12)
            sliderKnob.Position = UDim2.new((Slider.value - Slider.min) / (Slider.max - Slider.min), -6, 0.5, -6)
            sliderKnob.BackgroundColor3 = Theme.Button
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
                
                if Animations then
                    animateProperty(sliderFill, {Size = UDim2.new(percentage, 0, 1, 0)}, 0.1)
                    animateProperty(sliderKnob, {Position = UDim2.new(percentage, -6, 0.5, -6)}, 0.1)
                else
                    sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                    sliderKnob.Position = UDim2.new(percentage, -6, 0.5, -6)
                end
                
                Slider.callback(Slider.value)
            end

            sliderTrack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    updateSlider(input)
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
                    end
                end
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
            textFrame.Size = UDim2.new(1, -3, 0, 50)
            textFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            textFrame.BackgroundTransparency = 0.5
            textFrame.BorderSizePixel = 0
            textFrame.Parent = Tab.ScrollFrame
            
            local textCorner = Instance.new("UICorner")
            textCorner.CornerRadius = UDim.new(0, 4)
            textCorner.Parent = textFrame
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, -10, 0, 20)
            textLabel.Position = UDim2.new(0, 5, 0, 2)
            textLabel.BackgroundTransparency = 1
            textLabel.Text = text
            textLabel.TextColor3 = Theme.TextSecondary
            textLabel.Font = Enum.Font.GothamMedium
            textLabel.TextSize = 10
            textLabel.TextXAlignment = Enum.TextXAlignment.Left
            textLabel.Parent = textFrame
            
            local textBox = Instance.new("TextBox")
            textBox.Size = UDim2.new(0.65, 0, 0, 22)
            textBox.Position = UDim2.new(0, 5, 0, 22)
            textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            textBox.BorderSizePixel = 0
            textBox.Text = ""
            textBox.PlaceholderText = placeholder or "Digite..."
            textBox.TextColor3 = Theme.Text
            textBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            textBox.Font = Enum.Font.Gotham
            textBox.TextSize = 9
            textBox.Parent = textFrame
            
            local boxCorner = Instance.new("UICorner")
            boxCorner.CornerRadius = UDim.new(0, 4)
            boxCorner.Parent = textBox
            
            local submitButton = Instance.new("TextButton")
            submitButton.Size = UDim2.new(0, 50, 0, 22)
            submitButton.Position = UDim2.new(1, -55, 0, 22)
            submitButton.BackgroundColor3 = Theme.Button
            submitButton.BackgroundTransparency = 0.2
            submitButton.BorderSizePixel = 0
            submitButton.Text = "Send"
            submitButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            submitButton.Font = Enum.Font.GothamBold
            submitButton.TextSize = 9
            submitButton.Parent = textFrame
            
            local submitCorner = Instance.new("UICorner")
            submitCorner.CornerRadius = UDim.new(0, 4)
            submitCorner.Parent = submitButton

            submitButton.MouseEnter:Connect(function()
                if Animations then
                    animateProperty(submitButton, {BackgroundTransparency = 0.1}, 0.2)
                else
                    submitButton.BackgroundTransparency = 0.1
                end
            end)

            submitButton.MouseLeave:Connect(function()
                if Animations then
                    animateProperty(submitButton, {BackgroundTransparency = 0.2}, 0.2)
                else
                    submitButton.BackgroundTransparency = 0.2
                end
            end)

            local function submitText()
                TextButton.text = textBox.Text
                if TextButton.text ~= "" then
                    TextButton.callback(TextButton.text)
                    textBox.Text = ""
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
            Label.Size = UDim2.new(1, -3, 0, 28)
            Label.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        function Tab:CreateLabel(text, visible)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -3, 0, 28)
            Label.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            Label.BackgroundTransparency = 0.5
            Label.BorderSizePixel = 0
            Label.Text = text
            Label.TextColor3 = Theme.TextSecondary
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 10
            Label.Visible = visible ~= false
            Label.Parent = Tab.ScrollFrame

            local counterCorner = Instance.new("UICorner")
            counterCorner.CornerRadius = UDim.new(0, 4)
            counterCorner.Parent = Label

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
        return Tab
    end

    function Window:SwitchTab(tabIndex)
        for i, tab in ipairs(Window.tabs) do
            tab.Button.BackgroundColor3 = (i == tabIndex) and Theme.Accent or Theme.Button
            tab.Content.Visible = (i == tabIndex)
            tab.active = (i == tabIndex)
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
        pcall(function() Window.ScreenGui:Destroy() end)
    end

    return Window
end

return Library
