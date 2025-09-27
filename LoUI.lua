local Library = {}

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- Theme (matching original exactly)
local Theme = {
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
}

-- Main Library Function
function Library:CreateWindow(title, size)
    local Window = {
        title = title or "HUB",
        tabs = {},
        currentTab = 1,
        dragging = false,
        minimized = false,
        connections = {}
    }
    
    -- Create ScreenGui
    Window.ScreenGui = Instance.new("ScreenGui")
    Window.ScreenGui.Name = title .. "UI"
    Window.ScreenGui.ResetOnSpawn = false
    Window.ScreenGui.Parent = CoreGui
    
    -- Main Frame (Larger)
    Window.MainFrame = Instance.new("Frame")
    Window.MainFrame.Name = "MainFrame"
    Window.MainFrame.Size = size or UDim2.new(0, 450, 0, 350)
    Window.MainFrame.Position = UDim2.new(0, 10, 0, 10)
    Window.MainFrame.BackgroundColor3 = Theme.Background
    Window.MainFrame.BackgroundTransparency = 0.1
    Window.MainFrame.BorderSizePixel = 0
    Window.MainFrame.ClipsDescendants = true
    Window.MainFrame.Parent = Window.ScreenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = Window.MainFrame
    
    -- Title Bar
    Window.TitleBar = Instance.new("Frame")
    Window.TitleBar.Name = "TitleBar"
    Window.TitleBar.Size = UDim2.new(1, 0, 0, 24)
    Window.TitleBar.BackgroundColor3 = Theme.Secondary
    Window.TitleBar.BorderSizePixel = 0
    Window.TitleBar.Parent = Window.MainFrame
    
    -- Title
    Window.Title = Instance.new("TextLabel")
    Window.Title.Size = UDim2.new(0.75, 0, 1, 0)
    Window.Title.Position = UDim2.new(0.1, 0, 0, 0)
    Window.Title.BackgroundTransparency = 1
    Window.Title.Text = title
    Window.Title.TextColor3 = Theme.Text
    Window.Title.Font = Enum.Font.GothamSemibold
    Window.Title.TextSize = 11
    Window.Title.Parent = Window.TitleBar
    
    -- Minimize Button
    Window.MinimizeBtn = Instance.new("TextButton")
    Window.MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
    Window.MinimizeBtn.Position = UDim2.new(1, -24, 0, 0)
    Window.MinimizeBtn.AnchorPoint = Vector2.new(1, 0)
    Window.MinimizeBtn.BackgroundColor3 = Theme.Button
    Window.MinimizeBtn.BorderSizePixel = 0
    Window.MinimizeBtn.Text = "▼"
    Window.MinimizeBtn.TextColor3 = Theme.Text
    Window.MinimizeBtn.Font = Enum.Font.GothamBold
    Window.MinimizeBtn.TextSize = 10
    Window.MinimizeBtn.Parent = Window.TitleBar
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 4)
    minimizeCorner.Parent = Window.MinimizeBtn

    -- Tab Container (Vertical)
    Window.TabContainer = Instance.new("ScrollingFrame")
    Window.TabContainer.Name = "TabContainer"
    Window.TabContainer.Size = UDim2.new(0, 100, 1, -24) -- 100px wide, full height minus titlebar
    Window.TabContainer.Position = UDim2.new(0, 0, 0, 24)
    Window.TabContainer.BackgroundColor3 = Theme.Secondary
    Window.TabContainer.BackgroundTransparency = 0.5
    Window.TabContainer.BorderSizePixel = 0
    Window.TabContainer.ScrollBarThickness = 2
    Window.TabContainer.ScrollBarImageColor3 = Theme.ScrollBar
    Window.TabContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Window.TabContainer.ScrollingDirection = Enum.ScrollingDirection.Y
    Window.TabContainer.Parent = Window.MainFrame
    
    local TabLayout = Instance.new("UIListLayout")
    TabLayout.FillDirection = Enum.FillDirection.Vertical
    TabLayout.Padding = UDim.new(0, 5)
    TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabLayout.Parent = Window.TabContainer

    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 5)
    TabPadding.Parent = Window.TabContainer
    
    -- Content Frame (Adjusted for vertical tabs)
    Window.ContentFrame = Instance.new("Frame")
    Window.ContentFrame.Name = "ContentFrame"
    Window.ContentFrame.Size = UDim2.new(1, -100, 1, -24)
    Window.ContentFrame.Position = UDim2.new(0, 100, 0, 24)
    Window.ContentFrame.BackgroundTransparency = 1
    Window.ContentFrame.Parent = Window.MainFrame
    
    -- Footer Bar (For dragging)
    Window.FooterBar = Instance.new("Frame")
    Window.FooterBar.Name = "FooterBar"
    Window.FooterBar.Size = UDim2.new(1, 0, 0, 10)
    Window.FooterBar.Position = UDim2.new(0,0,1,0)
    Window.FooterBar.AnchorPoint = Vector2.new(0,1)
    Window.FooterBar.BackgroundColor3 = Theme.Secondary
    Window.FooterBar.BorderSizePixel = 0
    Window.FooterBar.ZIndex = 2
    Window.FooterBar.Parent = Window.MainFrame
    
    -- Minimized Frame
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
    Window.RestoreBtn.Text = "▲ " .. title
    Window.RestoreBtn.TextColor3 = Theme.Text
    Window.RestoreBtn.Font = Enum.Font.GothamSemibold
    Window.RestoreBtn.TextSize = 10
    Window.RestoreBtn.Parent = Window.MinimizedFrame
    
    -- Minimize/Restore Functions
    local function toggleMinimize()
        Window.minimized = not Window.minimized
        Window.MainFrame.Visible = not Window.minimized
        Window.MinimizedFrame.Visible = Window.minimized
        Window.MinimizeBtn.Text = Window.minimized and "▲" or "▼"
    end
    
    Window.MinimizeBtn.MouseButton1Click:Connect(toggleMinimize)
    Window.RestoreBtn.MouseButton1Click:Connect(toggleMinimize)
    
    -- Dragging System (smooth like original, but only for top/bottom)
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
        
        local activeFrame = Window.minimized and Window.MinimizedFrame or Window.MainFrame
        activeFrame.Position = newPosition
        clampPosition(activeFrame)
    end
    
    local function startDrag(input, frame)
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
    
    local function setupGrabber(grabPart, movePart)
        table.insert(Window.connections, grabPart.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                startDrag(input, movePart)
            end
        end))
    end

    setupGrabber(Window.TitleBar, Window.MainFrame)
    setupGrabber(Window.FooterBar, Window.MainFrame)
    setupGrabber(Window.MinimizedFrame, Window.MinimizedFrame)
    
    -- Global input handling for smooth dragging
    table.insert(Window.connections, UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateDrag(input)
        end
    end))
    
    table.insert(Window.connections, UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end))
    
    -- Responsive Design with smooth clamping (updated for vertical layout)
    local function autoResize()
        local screenSize = workspace.CurrentCamera.ViewportSize
        
        if screenSize.X < 700 then
            local newWidth = math.min(screenSize.X - 20, 400)
            local newHeight = math.min(screenSize.Y - 20, 500)
            Window.MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
            Window.MainFrame.Position = UDim2.new(0.5, -newWidth/2, 0.5, -newHeight/2)

            Window.TabContainer.Size = UDim2.new(0, 80, 1, -24)
            Window.ContentFrame.Position = UDim2.new(0, 80, 0, 24)
            Window.ContentFrame.Size = UDim2.new(1, -80, 1, -24)
        else
            Window.MainFrame.Size = size or UDim2.new(0, 450, 0, 350)

            Window.TabContainer.Size = UDim2.new(0, 100, 1, -24)
            Window.ContentFrame.Position = UDim2.new(0, 100, 0, 24)
            Window.ContentFrame.Size = UDim2.new(1, -100, 1, -24)
        end
    end
    
    table.insert(Window.connections, workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        autoResize()
        clampPosition(Window.MainFrame)
        clampPosition(Window.MinimizedFrame)
    end))
    
    spawn(function()
        wait(0.1)
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
        
        -- Tab Button (Vertical)
        Tab.Button = Instance.new("TextButton")
        Tab.Button.Size = UDim2.new(1, -10, 0, 30)
        Tab.Button.BackgroundColor3 = tabIndex == 1 and Theme.Accent or Theme.Button
        Tab.Button.BorderSizePixel = 0
        Tab.Button.Text = name
        Tab.Button.TextColor3 = Theme.Text
        Tab.Button.Font = Enum.Font.GothamSemibold
        Tab.Button.TextSize = 12
        Tab.Button.Parent = Window.TabContainer
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 4)
        tabCorner.Parent = Tab.Button
        
        -- Tab Content
        Tab.Content = Instance.new("ScrollingFrame")
        Tab.Content.Size = UDim2.new(1, 0, 1, 0)
        Tab.Content.BackgroundTransparency = 1
        Tab.Content.BorderSizePixel = 0
        Tab.Content.ScrollBarThickness = 2
        Tab.Content.ScrollBarImageColor3 = Theme.ScrollBar
        Tab.Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Tab.Content.Visible = tabIndex == 1
        Tab.Content.Parent = Window.ContentFrame
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Padding = UDim.new(0, 5)
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Parent = Tab.Content

        local ContentPadding = Instance.new("UIPadding")
        ContentPadding.PaddingLeft = UDim.new(0, 10)
        ContentPadding.PaddingRight = UDim.new(0, 10)
        ContentPadding.Parent = Tab.Content
        
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
            Window.currentTab = tabIndex
        end)
        
        -- Tab Methods
        function Tab:CreateToggle(text, callback, defaultState)
            local Toggle = {
                enabled = defaultState or false,
                callback = callback or function() end
            }
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
            ToggleFrame.BackgroundColor3 = Theme.Button
            ToggleFrame.BackgroundTransparency = 0.5
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = Tab.Content
            
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 4)
            toggleCorner.Parent = ToggleFrame
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = text
            ToggleLabel.TextColor3 = Theme.TextSecondary
            ToggleLabel.Font = Enum.Font.GothamMedium
            ToggleLabel.TextSize = 12
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Parent = ToggleFrame
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Size = UDim2.new(0, 35, 0, 18)
            ToggleButton.Position = UDim2.new(1, -45, 0.5, -9)
            ToggleButton.BackgroundColor3 = Toggle.enabled and Color3.fromRGB(70, 90, 70) or Color3.fromRGB(60, 60, 70)
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = Toggle.enabled and "ON" or "OFF"
            ToggleButton.TextColor3 = Toggle.enabled and Theme.Success or Theme.Error
            ToggleButton.Font = Enum.Font.GothamBold
            ToggleButton.TextSize = 8
            ToggleButton.Parent = ToggleFrame
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 9)
            buttonCorner.Parent = ToggleButton
            
            ToggleButton.MouseButton1Click:Connect(function()
                Toggle.enabled = not Toggle.enabled
                if Toggle.enabled then
                    ToggleButton.Text = "ON"
                    ToggleButton.TextColor3 = Theme.Success
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 90, 70)
                else
                    ToggleButton.Text = "OFF"
                    ToggleButton.TextColor3 = Theme.Error
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                end
                Toggle.callback(Toggle.enabled)
            end)
            
            table.insert(Tab.elements, Toggle)
            return Toggle
        end
        
        function Tab:CreateButton(text, callback)
            local ButtonFrame = Instance.new("TextButton")
            ButtonFrame.Size = UDim2.new(1, 0, 0, 35)
            ButtonFrame.BackgroundColor3 = Theme.Button
            ButtonFrame.BackgroundTransparency = 0.5
            ButtonFrame.BorderSizePixel = 0
            ButtonFrame.Text = text
            ButtonFrame.TextColor3 = Theme.TextSecondary
            ButtonFrame.Font = Enum.Font.GothamMedium
            ButtonFrame.TextSize = 12
            ButtonFrame.Parent = Tab.Content
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 4)
            buttonCorner.Parent = ButtonFrame
            
            ButtonFrame.MouseEnter:Connect(function()
                ButtonFrame.BackgroundTransparency = 0.3
            end)
            
            ButtonFrame.MouseLeave:Connect(function()
                ButtonFrame.BackgroundTransparency = 0.5
            end)
            
            ButtonFrame.MouseButton1Click:Connect(function()
                if callback then callback() end
            end)
            
            return ButtonFrame
        end
        
        function Tab:CreateLabel(text, visible)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, 0, 0, 28)
            Label.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            Label.BackgroundTransparency = 0.5
            Label.BorderSizePixel = 0
            Label.Text = text
            Label.TextColor3 = Theme.TextSecondary
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 12
            Label.Visible = visible ~= false
            Label.Parent = Tab.Content
            
            local counterCorner = Instance.new("UICorner")
            counterCorner.CornerRadius = UDim.new(0, 4)
            counterCorner.Parent = Label
            
            return Label
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
