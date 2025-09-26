local Library = {}

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- ============== THEMES ==============
local Themes = {
    default = {
        Background = Color3.fromRGB(25, 25, 30),
        Secondary = Color3.fromRGB(35, 35, 45),
        Accent = Color3.fromRGB(70, 70, 85),
        Button = Color3.fromRGB(45, 45, 55),
        ButtonActive = Color3.fromRGB(50, 50, 60),
        Text = Color3.fromRGB(220, 220, 220),
        TextSecondary = Color3.fromRGB(240, 240, 240),
        Success = Color3.fromRGB(100, 255, 100),
        Error = Color3.fromRGB(255, 100, 100),
        ScrollBar = Color3.fromRGB(100, 100, 120)
    },
    solven = {
        Background = Color3.fromRGB(10, 10, 10),
        Secondary = Color3.fromRGB(218, 165, 32), -- Goldenish Yellow
        Accent = Color3.fromRGB(255, 215, 0), -- Gold
        Button = Color3.fromRGB(20, 20, 20),
        ButtonActive = Color3.fromRGB(30, 30, 30),
        Text = Color3.fromRGB(218, 165, 32),
        TextSecondary = Color3.fromRGB(255, 215, 0),
        Success = Color3.fromRGB(218, 165, 32),
        Error = Color3.fromRGB(255, 100, 100),
        ScrollBar = Color3.fromRGB(218, 165, 32)
    },
    ocean = {
        Background = Color3.fromRGB(15, 25, 35),
        Secondary = Color3.fromRGB(25, 45, 65),
        Accent = Color3.fromRGB(100, 200, 255),
        Button = Color3.fromRGB(35, 55, 75),
        ButtonActive = Color3.fromRGB(45, 65, 85),
        Text = Color3.fromRGB(200, 230, 255),
        TextSecondary = Color3.fromRGB(220, 240, 255),
        Success = Color3.fromRGB(100, 255, 200),
        Error = Color3.fromRGB(255, 120, 120),
        ScrollBar = Color3.fromRGB(100, 200, 255)
    },
    forest = {
        Background = Color3.fromRGB(20, 30, 20),
        Secondary = Color3.fromRGB(40, 60, 40),
        Accent = Color3.fromRGB(120, 200, 80),
        Button = Color3.fromRGB(30, 45, 30),
        ButtonActive = Color3.fromRGB(40, 55, 40),
        Text = Color3.fromRGB(200, 255, 200),
        TextSecondary = Color3.fromRGB(220, 255, 220),
        Success = Color3.fromRGB(120, 255, 120),
        Error = Color3.fromRGB(255, 120, 120),
        ScrollBar = Color3.fromRGB(120, 200, 80)
    },
    sunset = {
        Background = Color3.fromRGB(35, 20, 25),
        Secondary = Color3.fromRGB(65, 35, 45),
        Accent = Color3.fromRGB(255, 120, 80),
        Button = Color3.fromRGB(45, 30, 35),
        ButtonActive = Color3.fromRGB(55, 40, 45),
        Text = Color3.fromRGB(255, 200, 180),
        TextSecondary = Color3.fromRGB(255, 220, 200),
        Success = Color3.fromRGB(255, 180, 120),
        Error = Color3.fromRGB(255, 100, 100),
        ScrollBar = Color3.fromRGB(255, 120, 80)
    },
    purple = {
        Background = Color3.fromRGB(25, 15, 35),
        Secondary = Color3.fromRGB(45, 25, 65),
        Accent = Color3.fromRGB(150, 100, 255),
        Button = Color3.fromRGB(35, 25, 45),
        ButtonActive = Color3.fromRGB(45, 35, 55),
        Text = Color3.fromRGB(220, 200, 255),
        TextSecondary = Color3.fromRGB(240, 220, 255),
        Success = Color3.fromRGB(180, 150, 255),
        Error = Color3.fromRGB(255, 100, 150),
        ScrollBar = Color3.fromRGB(150, 100, 255)
    },
    neon = {
        Background = Color3.fromRGB(5, 5, 15),
        Secondary = Color3.fromRGB(15, 15, 30),
        Accent = Color3.fromRGB(0, 255, 255),
        Button = Color3.fromRGB(10, 10, 25),
        ButtonActive = Color3.fromRGB(20, 20, 35),
        Text = Color3.fromRGB(0, 255, 255),
        TextSecondary = Color3.fromRGB(100, 255, 255),
        Success = Color3.fromRGB(0, 255, 150),
        Error = Color3.fromRGB(255, 50, 150),
        ScrollBar = Color3.fromRGB(0, 255, 255)
    }
}

-- Animation helper functions
local function animateProperty(object, property, targetValue, duration, style, direction)
    if not animations then
        object[property] = targetValue
        return
    end
    
    local tween = TweenService:Create(object, TweenInfo.new(
        duration or 0.3,
        style or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out
    ), {[property] = targetValue})
    
    tween:Play()
    return tween
end

local function animateMultipleProperties(object, properties, duration, style, direction)
    if not animations then
        for prop, value in pairs(properties) do
            object[prop] = value
        end
        return
    end
    
    local tween = TweenService:Create(object, TweenInfo.new(
        duration or 0.3,
        style or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out
    ), properties)
    
    tween:Play()
    return tween
end

-- Main Library Function
function Library:CreateWindow(title, size, theme, enableAnimations)
    animations = enableAnimations ~= false -- Default to true
    local currentTheme = Themes[theme] or Themes.default
    
    local Window = {
        title = title or "HUB",
        tabs = {},
        currentTab = 1,
        dragging = false,
        minimized = false,
        connections = {},
        theme = currentTheme,
        animations = animations
    }
    
    -- Mobile detection and optimization
    local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    local mobileScale = isMobile and 1.3 or 1.0
    local touchInputInProgress = false
    
    -- Create ScreenGui
    Window.ScreenGui = Instance.new("ScreenGui")
    Window.ScreenGui.Name = title .. "UI"
    Window.ScreenGui.ResetOnSpawn = false
    Window.ScreenGui.IgnoreGuiInset = true
    Window.ScreenGui.Parent = CoreGui
    
    -- Main Frame with mobile scaling
    Window.MainFrame = Instance.new("Frame")
    Window.MainFrame.Name = "MainFrame"
    Window.MainFrame.Size = UDim2.new(0, (size and size.X.Offset or 280) * mobileScale, 0, (size and size.Y.Offset or 300) * mobileScale)
    Window.MainFrame.Position = UDim2.new(0, 10, 0, 10)
    Window.MainFrame.BackgroundColor3 = currentTheme.Background
    Window.MainFrame.BackgroundTransparency = 0.1
    Window.MainFrame.BorderSizePixel = 0
    Window.MainFrame.ClipsDescendants = true
    Window.MainFrame.Active = true
    Window.MainFrame.Selectable = true
    Window.MainFrame.Parent = Window.ScreenGui
    
    -- Enhanced drop shadow effect
    if animations then
        local shadow = Instance.new("ImageLabel")
        shadow.Name = "Shadow"
        shadow.Size = UDim2.new(1, 20, 1, 20)
        shadow.Position = UDim2.new(0, -10, 0, -10)
        shadow.BackgroundTransparency = 1
        shadow.Image = "rbxasset://textures/ui/Controls/DropShadow.png"
        shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        shadow.ImageTransparency = 0.5
        shadow.ScaleType = Enum.ScaleType.Slice
        shadow.SliceCenter = Rect.new(12, 12, 116, 116)
        shadow.ZIndex = -1
        shadow.Parent = Window.MainFrame
    end
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = Window.MainFrame
    
    -- Title Bar
    Window.TitleBar = Instance.new("Frame")
    Window.TitleBar.Name = "TitleBar"
    Window.TitleBar.Size = UDim2.new(1, 0, 0, 28 * mobileScale)
    Window.TitleBar.BackgroundColor3 = currentTheme.Secondary
    Window.TitleBar.BorderSizePixel = 0
    Window.TitleBar.Parent = Window.MainFrame
    
    -- Title with better mobile sizing
    Window.Title = Instance.new("TextLabel")
    Window.Title.Size = UDim2.new(0.75, 0, 1, 0)
    Window.Title.Position = UDim2.new(0.1, 0, 0, 0)
    Window.Title.BackgroundTransparency = 1
    Window.Title.Text = title
    Window.Title.TextColor3 = currentTheme.Text
    Window.Title.Font = Enum.Font.GothamSemibold
    Window.Title.TextSize = 12 * mobileScale
    Window.Title.TextScaled = isMobile
    Window.Title.Parent = Window.TitleBar
    
    -- Minimize Button with enhanced hover animation
    Window.MinimizeBtn = Instance.new("TextButton")
    Window.MinimizeBtn.Size = UDim2.new(0, 28 * mobileScale, 0, 28 * mobileScale)
    Window.MinimizeBtn.Position = UDim2.new(1, -28 * mobileScale, 0, 0)
    Window.MinimizeBtn.AnchorPoint = Vector2.new(1, 0)
    Window.MinimizeBtn.BackgroundColor3 = currentTheme.Button
    Window.MinimizeBtn.BorderSizePixel = 0
    Window.MinimizeBtn.Text = "▼"
    Window.MinimizeBtn.TextColor3 = currentTheme.Text
    Window.MinimizeBtn.Font = Enum.Font.GothamBold
    Window.MinimizeBtn.TextSize = 12 * mobileScale
    Window.MinimizeBtn.TextScaled = isMobile
    Window.MinimizeBtn.AutoButtonColor = false
    Window.MinimizeBtn.Parent = Window.TitleBar
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 4)
    minimizeCorner.Parent = Window.MinimizeBtn
    
    -- Enhanced hover effects for minimize button
    Window.MinimizeBtn.MouseEnter:Connect(function()
        if animations then
            animateProperty(Window.MinimizeBtn, "BackgroundColor3", currentTheme.ButtonActive, 0.2)
            animateProperty(Window.MinimizeBtn, "TextColor3", currentTheme.TextSecondary, 0.2)
        end
    end)
    
    Window.MinimizeBtn.MouseLeave:Connect(function()
        if animations then
            animateProperty(Window.MinimizeBtn, "BackgroundColor3", currentTheme.Button, 0.2)
            animateProperty(Window.MinimizeBtn, "TextColor3", currentTheme.Text, 0.2)
        end
    end)
    
    -- Tab Container with enhanced mobile support
    Window.TabContainer = Instance.new("ScrollingFrame")
    Window.TabContainer.Size = UDim2.new(1, -6, 0, 32 * mobileScale)
    Window.TabContainer.Position = UDim2.new(0, 3, 0, 30 * mobileScale)
    Window.TabContainer.BackgroundTransparency = 1
    Window.TabContainer.BorderSizePixel = 0
    Window.TabContainer.ScrollBarThickness = isMobile and 8 or 3
    Window.TabContainer.ScrollBarImageColor3 = currentTheme.ScrollBar
    Window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    Window.TabContainer.AutomaticCanvasSize = Enum.AutomaticSize.X
    Window.TabContainer.ScrollingDirection = Enum.ScrollingDirection.X
    Window.TabContainer.VerticalScrollBarInset = Enum.ScrollBarInset.Always
    Window.TabContainer.Parent = Window.MainFrame
    
    local TabLayout = Instance.new("UIListLayout")
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.Padding = UDim.new(0, 3)
    TabLayout.Parent = Window.TabContainer
    
    -- Content Frame with improved scrolling
    Window.ContentFrame = Instance.new("Frame")
    Window.ContentFrame.Size = UDim2.new(1, -6, 1, -65 * mobileScale)
    Window.ContentFrame.Position = UDim2.new(0, 3, 0, 62 * mobileScale)
    Window.ContentFrame.BackgroundTransparency = 1
    Window.ContentFrame.ClipsDescendants = true
    Window.ContentFrame.Parent = Window.MainFrame
    
    -- Minimized Frame
    Window.MinimizedFrame = Instance.new("Frame")
    Window.MinimizedFrame.Size = UDim2.new(0, 140 * mobileScale, 0, 28 * mobileScale)
    Window.MinimizedFrame.Position = UDim2.new(0, 10, 1, -38 * mobileScale)
    Window.MinimizedFrame.BackgroundColor3 = currentTheme.Secondary
    Window.MinimizedFrame.BackgroundTransparency = 0.1
    Window.MinimizedFrame.BorderSizePixel = 0
    Window.MinimizedFrame.Visible = false
    Window.MinimizedFrame.Active = true
    Window.MinimizedFrame.Selectable = true
    Window.MinimizedFrame.Parent = Window.ScreenGui
    
    local minimizedCorner2 = Instance.new("UICorner")
    minimizedCorner2.CornerRadius = UDim.new(0, 8)
    minimizedCorner2.Parent = Window.MinimizedFrame
    
    Window.RestoreBtn = Instance.new("TextButton")
    Window.RestoreBtn.Size = UDim2.new(1, 0, 1, 0)
    Window.RestoreBtn.BackgroundTransparency = 1
    Window.RestoreBtn.Text = "▲ " .. title
    Window.RestoreBtn.TextColor3 = currentTheme.Text
    Window.RestoreBtn.Font = Enum.Font.GothamSemibold
    Window.RestoreBtn.TextSize = 12 * mobileScale
    Window.RestoreBtn.TextScaled = isMobile
    Window.RestoreBtn.AutoButtonColor = false
    Window.RestoreBtn.Parent = Window.MinimizedFrame
    
    -- Enhanced Minimize/Restore Functions with smooth animations
    local function toggleMinimize()
        Window.minimized = not Window.minimized
        
        if animations then
            if Window.minimized then
                -- Animate minimize with bounce effect
                animateMultipleProperties(Window.MainFrame, {
                    Size = UDim2.new(0, 0, 0, 0),
                    BackgroundTransparency = 1
                }, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                
                task.wait(0.4)
                Window.MainFrame.Visible = false
                Window.MinimizedFrame.Visible = true
                Window.MinimizedFrame.Size = UDim2.new(0, 0, 0, 0)
                
                animateMultipleProperties(Window.MinimizedFrame, {
                    Size = UDim2.new(0, 140 * mobileScale, 0, 28 * mobileScale),
                    BackgroundTransparency = 0.1
                }, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            else
                -- Animate restore with bounce effect
                animateMultipleProperties(Window.MinimizedFrame, {
                    Size = UDim2.new(0, 0, 0, 0),
                    BackgroundTransparency = 1
                }, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                
                task.wait(0.4)
                Window.MinimizedFrame.Visible = false
                Window.MainFrame.Visible = true
                Window.MainFrame.Size = UDim2.new(0, 0, 0, 0)
                
                animateMultipleProperties(Window.MainFrame, {
                    Size = UDim2.new(0, (size and size.X.Offset or 280) * mobileScale, 0, (size and size.Y.Offset or 300) * mobileScale),
                    BackgroundTransparency = 0.1
                }, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            end
        else
            Window.MainFrame.Visible = not Window.minimized
            Window.MinimizedFrame.Visible = Window.minimized
        end
        
        Window.MinimizeBtn.Text = Window.minimized and "▲" or "▼"
    end
    
    Window.MinimizeBtn.MouseButton1Click:Connect(toggleMinimize)
    Window.RestoreBtn.MouseButton1Click:Connect(toggleMinimize)
    
    -- Enhanced Dragging System with momentum and mobile optimization
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
    local dragVelocity = Vector2.new(0, 0)
    local lastDragPos = Vector2.new(0, 0)
    local dragMomentum = nil
    
    local function updateDrag(input)
        if not dragging then return end
        
        local delta = input.Position - dragStart
        dragVelocity = input.Position - lastDragPos
        lastDragPos = input.Position
        
        local newPosition = UDim2.new(0, frameStart.X.Offset + delta.X, 0, frameStart.Y.Offset + delta.Y)
        
        if Window.minimized then
            Window.MinimizedFrame.Position = newPosition
        else
            Window.MainFrame.Position = newPosition
        end
    end
    
    local function startDrag(input, frame)
        dragging = true
        dragStart = input.Position
        frameStart = frame.Position
        lastDragPos = input.Position
        dragVelocity = Vector2.new(0, 0)
        touchInputInProgress = true
        
        if dragMomentum then
            dragMomentum:Disconnect()
            dragMomentum = nil
        end
        
        local connection
        connection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                touchInputInProgress = false
                
                -- Enhanced momentum effect for mobile
                if isMobile and animations and dragVelocity.Magnitude > 20 then
                    local currentFrame = Window.minimized and Window.MinimizedFrame or Window.MainFrame
                    local startPos = currentFrame.Position
                    local momentum = dragVelocity * 0.5
                    local targetPos = UDim2.new(0, startPos.X.Offset + momentum.X, 0, startPos.Y.Offset + momentum.Y)
                    
                    animateProperty(currentFrame, "Position", targetPos, 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    
                    task.wait(0.15)
                    clampPosition(currentFrame)
                else
                    clampPosition(Window.minimized and Window.MinimizedFrame or Window.MainFrame)
                end
                
                if connection then connection:Disconnect() end
            end
        end)
    end
    
    -- Enhanced input handling for better mobile performance
    local function setupDragging(frame)
        table.insert(Window.connections, frame.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not touchInputInProgress then
                startDrag(input, frame)
            end
        end))
        
        table.insert(Window.connections, frame.InputChanged:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
                updateDrag(input)
            end
        end))
    end
    
    setupDragging(Window.MainFrame)
    setupDragging(Window.MinimizedFrame)
    
    -- Global input handling with mobile optimization
    table.insert(Window.connections, UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateDrag(input)
        end
    end))
    
    table.insert(Window.connections, UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            touchInputInProgress = false
        end
    end))
    
    -- Enhanced Responsive Design with smooth transitions
    local function autoResize()
        local screenSize = workspace.CurrentCamera.ViewportSize
        
        if screenSize.X < 600 then
            local newSize = UDim2.new(0, 260 * mobileScale, 0, 320 * mobileScale)
            if animations then
                animateProperty(Window.MainFrame, "Size", newSize, 0.3)
            else
                Window.MainFrame.Size = newSize
            end
            Window.Title.TextSize = 11 * mobileScale
            Window.MinimizeBtn.TextSize = 10 * mobileScale
        else
            local newSize = UDim2.new(0, (size and size.X.Offset or 280) * mobileScale, 0, (size and size.Y.Offset or 300) * mobileScale)
            if animations then
                animateProperty(Window.MainFrame, "Size", newSize, 0.3)
            else
                Window.MainFrame.Size = newSize
            end
            Window.Title.TextSize = 12 * mobileScale
            Window.MinimizeBtn.TextSize = 12 * mobileScale
        end
        
        for _, tab in ipairs(Window.tabs) do
            if tab.Button then
                tab.Button.TextSize = screenSize.X < 600 and 9 * mobileScale or 10 * mobileScale
            end
        end
    end
    
    table.insert(Window.connections, workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        autoResize()
        clampPosition(Window.MainFrame)
        clampPosition(Window.MinimizedFrame)
    end))
    
    spawn(function()
        task.wait(0.1)
        autoResize()
        clampPosition(Window.MainFrame)
    end)
    
    -- Window Methods
    function Window:CreateTab(name)
        local tabIndex = #Window.tabs + 1
        local Tab = {
            name = name,
            elements = {},
            active = tabIndex == 1
        }
        
        -- Tab Button with enhanced mobile sizing
        Tab.Button = Instance.new("TextButton")
        Tab.Button.Size = UDim2.new(0, 85 * mobileScale, 1, 0)
        Tab.Button.BackgroundColor3 = tabIndex == 1 and currentTheme.Accent or currentTheme.Button
        Tab.Button.BorderSizePixel = 0
        Tab.Button.Text = name
        Tab.Button.TextColor3 = currentTheme.Text
        Tab.Button.Font = Enum.Font.GothamSemibold
        Tab.Button.TextSize = 10 * mobileScale
        Tab.Button.TextScaled = isMobile
        Tab.Button.AutoButtonColor = false
        Tab.Button.Parent = Window.TabContainer
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 4)
        tabCorner.Parent = Tab.Button
        
        -- Enhanced Tab Button hover effects
        Tab.Button.MouseEnter:Connect(function()
            if not Tab.active and animations then
                animateProperty(Tab.Button, "BackgroundColor3", currentTheme.ButtonActive, 0.2)
                animateProperty(Tab.Button, "TextColor3", currentTheme.TextSecondary, 0.2)
            end
        end)
        
        Tab.Button.MouseLeave:Connect(function()
            if not Tab.active and animations then
                animateProperty(Tab.Button, "BackgroundColor3", currentTheme.Button, 0.2)
                animateProperty(Tab.Button, "TextColor3", currentTheme.Text, 0.2)
            end
        end)
        
        -- Tab Content with enhanced scrolling and mobile optimization
        Tab.Content = Instance.new("ScrollingFrame")
        Tab.Content.Size = UDim2.new(1, 0, 1, 0)
        Tab.Content.BackgroundTransparency = 1
        Tab.Content.BorderSizePixel = 0
        Tab.Content.ScrollBarThickness = isMobile and 10 or 3
        Tab.Content.ScrollBarImageColor3 = currentTheme.ScrollBar
        Tab.Content.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Tab.Content.Visible = tabIndex == 1
        Tab.Content.Parent = Window.ContentFrame
        
        -- Enhanced mobile scrolling
        if isMobile then
            Tab.Content.ScrollingEnabled = true
            Tab.Content.ElasticBehavior = Enum.ElasticBehavior.Always
            Tab.Content.ScrollBarImageTransparency = 0.3
        end
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Padding = UDim.new(0, 4 * mobileScale)
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Parent = Tab.Content
        
        -- Enhanced Tab Selection with smooth animations
        Tab.Button.MouseButton1Click:Connect(function()
            for i, tab in pairs(Window.tabs) do
                tab.active = false
                if animations then
                    animateProperty(tab.Button, "BackgroundColor3", currentTheme.Button, 0.3)
                    animateProperty(tab.Button, "TextColor3", currentTheme.Text, 0.3)
                else
                    tab.Button.BackgroundColor3 = currentTheme.Button
                end
                tab.Content.Visible = false
            end
            
            Tab.active = true
            if animations then
                animateProperty(Tab.Button, "BackgroundColor3", currentTheme.Accent, 0.3)
                animateProperty(Tab.Button, "TextColor3", currentTheme.TextSecondary, 0.3)
                task.wait(0.15)
            else
                Tab.Button.BackgroundColor3 = currentTheme.Accent
            end
            Tab.Content.Visible = true
            Window.currentTab = tabIndex
        end)
        
        -- Enhanced Tab Methods with mobile optimization
        function Tab:CreateToggle(text, callback, defaultState)
            local Toggle = {
                enabled = defaultState or false,
                callback = callback or function() end
            }
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, -3, 0, 32 * mobileScale)
            ToggleFrame.BackgroundColor3 = currentTheme.Button
            ToggleFrame.BackgroundTransparency = 0.5
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = Tab.Content
            
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 4)
            toggleCorner.Parent = ToggleFrame
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 8, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = text
            ToggleLabel.TextColor3 = currentTheme.TextSecondary
            ToggleLabel.Font = Enum.Font.GothamMedium
            ToggleLabel.TextSize = 11 * mobileScale
            ToggleLabel.TextScaled = isMobile
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Parent = ToggleFrame
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Size = UDim2.new(0, 40 * mobileScale, 0, 20 * mobileScale)
            ToggleButton.Position = UDim2.new(1, -45 * mobileScale, 0.5, -10 * mobileScale)
            ToggleButton.BackgroundColor3 = Toggle.enabled and currentTheme.Accent or Color3.fromRGB(60, 60, 70)
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = Toggle.enabled and "ON" or "OFF"
            ToggleButton.TextColor3 = Toggle.enabled and currentTheme.Success or currentTheme.Error
            ToggleButton.Font = Enum.Font.GothamBold
            ToggleButton.TextSize = 9 * mobileScale
            ToggleButton.TextScaled = isMobile
            ToggleButton.AutoButtonColor = false
            ToggleButton.Parent = ToggleFrame
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 10)
            buttonCorner.Parent = ToggleButton
            
            -- Enhanced toggle animation
            local function updateToggle()
                if animations then
                    animateProperty(ToggleButton, "BackgroundColor3", Toggle.enabled and currentTheme.Accent or Color3.fromRGB(60, 60, 70), 0.2)
                    animateProperty(ToggleButton, "TextColor3", Toggle.enabled and currentTheme.Success or currentTheme.Error, 0.2)
                else
                    ToggleButton.BackgroundColor3 = Toggle.enabled and currentTheme.Accent or Color3.fromRGB(60, 60, 70)
                    ToggleButton.TextColor3 = Toggle.enabled and currentTheme.Success or currentTheme.Error
                end
                ToggleButton.Text = Toggle.enabled and "ON" or "OFF"
            end
            
            ToggleButton.MouseButton1Click:Connect(function()
                if touchInputInProgress then return end
                Toggle.enabled = not Toggle.enabled
                updateToggle()
                Toggle.callback(Toggle.enabled)
            end)
            
            -- Hover effects for toggle
            ToggleButton.MouseEnter:Connect(function()
                if animations then
                    animateProperty(ToggleButton, "BackgroundColor3", Toggle.enabled and currentTheme.ButtonActive or Color3.fromRGB(70, 70, 80), 0.2)
                end
            end)
            
            ToggleButton.MouseLeave:Connect(function()
                if animations then
                    animateProperty(ToggleButton, "BackgroundColor3", Toggle.enabled and currentTheme.Accent or Color3.fromRGB(60, 60, 70), 0.2)
                end
            end)
            
            table.insert(Tab.elements, Toggle)
            return Toggle
        end
        
        function Tab:CreateButton(text, callback)
            local ButtonFrame = Instance.new("TextButton")
            ButtonFrame.Size = UDim2.new(1, -3, 0, 32 * mobileScale)
            ButtonFrame.BackgroundColor3 = currentTheme.Button
            ButtonFrame.BackgroundTransparency = 0.5
            ButtonFrame.BorderSizePixel = 0
            ButtonFrame.Text = text
            ButtonFrame.TextColor3 = currentTheme.TextSecondary
            ButtonFrame.Font = Enum.Font.GothamMedium
            ButtonFrame.TextSize = 11 * mobileScale
            ButtonFrame.TextScaled = isMobile
            ButtonFrame.AutoButtonColor = false
            ButtonFrame.Parent = Tab.Content
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 4)
            buttonCorner.Parent = ButtonFrame
            
            -- Enhanced button animations
            ButtonFrame.MouseEnter:Connect(function()
                if animations then
                    animateProperty(ButtonFrame, "BackgroundTransparency", 0.2, 0.2)
                    animateProperty(ButtonFrame, "TextColor3", currentTheme.Text, 0.2)
                end
            end)
            
            ButtonFrame.MouseLeave:Connect(function()
                if animations then
                    animateProperty(ButtonFrame, "BackgroundTransparency", 0.5, 0.2)
                    animateProperty(ButtonFrame, "TextColor3", currentTheme.TextSecondary, 0.2)
                end
            end)
            
            ButtonFrame.MouseButton1Down:Connect(function()
                if touchInputInProgress then return end
                if animations then
                    animateProperty(ButtonFrame, "BackgroundColor3", currentTheme.ButtonActive, 0.1)
                end
            end)
            
            ButtonFrame.MouseButton1Up:Connect(function()
                if animations then
                    animateProperty(ButtonFrame, "BackgroundColor3", currentTheme.Button, 0.1)
                end
            end)
            
            ButtonFrame.MouseButton1Click:Connect(function()
                if touchInputInProgress then return end
                if callback then 
                    if animations then
                        animateProperty(ButtonFrame, "BackgroundColor3", currentTheme.Accent, 0.1)
                        task.wait(0.1)
                        animateProperty(ButtonFrame, "BackgroundColor3", currentTheme.Button, 0.1)
                    end
                    callback() 
                end
            end)
            
            return ButtonFrame
        end
        
        function Tab:CreateLabel(text, visible)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -3, 0, 32 * mobileScale)
            Label.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            Label.BackgroundTransparency = 0.5
            Label.BorderSizePixel = 0
            Label.Text = text
            Label.TextColor3 = currentTheme.TextSecondary
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 11 * mobileScale
            Label.TextScaled = isMobile
            Label.Visible = visible ~= false
            Label.Parent = Tab.Content
            
            local counterCorner = Instance.new("UICorner")
            counterCorner.CornerRadius = UDim.new(0, 4)
            counterCorner.Parent = Label
            
            return Label
        end
        
        -- Enhanced Slider with mobile optimization (fixing the slider bug)
        function Tab:CreateSlider(text, min, max, defaultValue, callback)
            local Slider = {
                value = defaultValue or min,
                min = min,
                max = max,
                callback = callback or function() end,
                dragging = false
            }
            
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, -3, 0, 45 * mobileScale)
            SliderFrame.BackgroundColor3 = currentTheme.Button
            SliderFrame.BackgroundTransparency = 0.5
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Parent = Tab.Content
            
            local sliderCorner = Instance.new("UICorner")
            sliderCorner.CornerRadius = UDim.new(0, 4)
            sliderCorner.Parent = SliderFrame
            
            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Size = UDim2.new(1, -10, 0, 18 * mobileScale)
            SliderLabel.Position = UDim2.new(0, 5, 0, 2)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = text .. ": " .. Slider.value
            SliderLabel.TextColor3 = currentTheme.TextSecondary
            SliderLabel.Font = Enum.Font.GothamMedium
            SliderLabel.TextSize = 10 * mobileScale
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Parent = SliderFrame
            
            local Track = Instance.new("Frame")
            Track.Size = UDim2.new(1, -20, 0, 6 * mobileScale)
            Track.Position = UDim2.new(0, 10, 1, -20 * mobileScale)
            Track.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
            Track.BorderSizePixel = 0
            Track.Parent = SliderFrame
            
            local trackCorner = Instance.new("UICorner")
            trackCorner.CornerRadius = UDim.new(0, 3)
            trackCorner.Parent = Track
            
            local Fill = Instance.new("Frame")
            Fill.Size = UDim2.new(0, 0, 1, 0)
            Fill.BackgroundColor3 = currentTheme.Accent
            Fill.BorderSizePixel = 0
            Fill.Parent = Track
            
            local fillCorner = Instance.new("UICorner")
            fillCorner.CornerRadius = UDim.new(0, 3)
            fillCorner.Parent = Fill
            
            local Thumb = Instance.new("TextButton")
            Thumb.Size = UDim2.new(0, 16 * mobileScale, 0, 16 * mobileScale)
            Thumb.Position = UDim2.new(0, -8 * mobileScale, 0.5, -8 * mobileScale)
            Thumb.BackgroundColor3 = currentTheme.TextSecondary
            Thumb.BorderSizePixel = 0
            Thumb.Text = ""
            Thumb.AutoButtonColor = false
            Thumb.Parent = Track
            
            local thumbCorner = Instance.new("UICorner")
            thumbCorner.CornerRadius = UDim.new(0, 8)
            thumbCorner.Parent = Thumb
            
            local function updateSlider(value)
                Slider.value = math.clamp(value, min, max)
                local percentage = (Slider.value - min) / (max - min)
                
                if animations then
                    animateProperty(Fill, "Size", UDim2.new(percentage, 0, 1, 0), 0.1)
                    animateProperty(Thumb, "Position", UDim2.new(percentage, -8 * mobileScale, 0.5, -8 * mobileScale), 0.1)
                else
                    Fill.Size = UDim2.new(percentage, 0, 1, 0)
                    Thumb.Position = UDim2.new(percentage, -8 * mobileScale, 0.5, -8 * mobileScale)
                end
                
                SliderLabel.Text = text .. ": " .. math.floor(Slider.value * 100) / 100
                Slider.callback(Slider.value)
            end
            
            -- Enhanced slider input handling (fixing the bug)
            local function onSliderInput(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    Slider.dragging = true
                    touchInputInProgress = true
                    
                    local connection
                    connection = input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            Slider.dragging = false
                            touchInputInProgress = false
                            if connection then connection:Disconnect() end
                        end
                    end)
                end
            end
            
            Track.InputBegan:Connect(onSliderInput)
            Thumb.InputBegan:Connect(onSliderInput)
            
            local function onInputChanged(input)
                if Slider.dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local relativeX = (input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X
                    local value = min + (relativeX * (max - min))
                    updateSlider(value)
                end
            end
            
            UserInputService.InputChanged:Connect(onInputChanged)
            
            -- Initialize slider
            updateSlider(Slider.value)
            
            -- Hover effects
            Thumb.MouseEnter:Connect(function()
                if animations then
                    animateProperty(Thumb, "Size", UDim2.new(0, 18 * mobileScale, 0, 18 * mobileScale), 0.2)
                end
            end)
            
            Thumb.MouseLeave:Connect(function()
                if not Slider.dragging and animations then
                    animateProperty(Thumb, "Size", UDim2.new(0, 16 * mobileScale, 0, 16 * mobileScale), 0.2)
                end
            end)
            
            table.insert(Tab.elements, Slider)
            return Slider
        end
        
        table.insert(Window.tabs, Tab)
        return Tab
    end
    
    function Window:ChangeTheme(newTheme)
        local theme = Themes[newTheme] or Themes.default
        Window.theme = theme
        
        -- Update all window elements
        Window.MainFrame.BackgroundColor3 = theme.Background
        Window.TitleBar.BackgroundColor3 = theme.Secondary
        Window.Title.TextColor3 = theme.Text
        Window.MinimizeBtn.BackgroundColor3 = theme.Button
        Window.MinimizeBtn.TextColor3 = theme.Text
        Window.MinimizedFrame.BackgroundColor3 = theme.Secondary
        Window.RestoreBtn.TextColor3 = theme.Text
        Window.TabContainer.ScrollBarImageColor3 = theme.ScrollBar
        
        -- Update tabs and their elements
        for _, tab in ipairs(Window.tabs) do
            tab.Button.BackgroundColor3 = tab.active and theme.Accent or theme.Button
            tab.Button.TextColor3 = theme.Text
            tab.Content.ScrollBarImageColor3 = theme.ScrollBar
            
            -- You would need to update all tab elements here as well
            -- This is a simplified version - you might want to store references to update them
        end
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
