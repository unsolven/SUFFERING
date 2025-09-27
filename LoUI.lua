--// LoUI V7 - The True Restoration
--// This is the original V1 code, carefully upgraded with all requested features.
--// It preserves the stability, structure, and methodology of the original script.

local Library = {}

--// Services
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

--// V7: Theming System
Library.Themes = {
    Default = {
        Background = Color3.fromRGB(25, 25, 30),
        Secondary = Color3.fromRGB(35, 35, 45),
        Accent = Color3.fromRGB(70, 70, 85),
        Button = Color3.fromRGB(45, 45, 55),
        ButtonActive = Color3.fromRGB(55, 55, 65),
        Text = Color3.fromRGB(220, 220, 220),
        TextSecondary = Color3.fromRGB(180, 180, 180),
        Success = Color3.fromRGB(70, 200, 120),
        Error = Color3.fromRGB(250, 80, 100),
        Divider = Color3.fromRGB(60, 60, 75),
    },
    Modern = {
        Background = Color3.fromRGB(24, 24, 27),
        Secondary = Color3.fromRGB(39, 39, 42),
        Accent = Color3.fromRGB(9, 126, 234),
        Button = Color3.fromRGB(55, 55, 60),
        ButtonActive = Color3.fromRGB(65, 65, 70),
        Text = Color3.fromRGB(240, 240, 245),
        TextSecondary = Color3.fromRGB(160, 160, 170),
        Success = Color3.fromRGB(70, 200, 120),
        Error = Color3.fromRGB(250, 80, 100),
        Divider = Color3.fromRGB(55, 55, 60),
    }
}

--// Utility
local function Tween(obj, props)
    local tween = TweenService:Create(obj, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    tween:Play()
    return tween
end

--// Main Library Function
function Library:CreateWindow(options)
    options = options or {}
    local title = options.Title or "Hub"
    local size = options.Size or UDim2.new(0, 320, 0, 400)
    local theme = Library.Themes[options.Theme] or Library.Themes.Modern

    local Window = {
        title = title,
        tabs = {},
        dragging = false,
        minimized = false,
        connections = {}
    }
    
    Window.ScreenGui = Instance.new("ScreenGui")
    Window.ScreenGui.Name = title .. "UI"
    Window.ScreenGui.ResetOnSpawn = false
    Window.ScreenGui.Parent = CoreGui
    
    -- Main Frame
    Window.MainFrame = Instance.new("Frame")
    Window.MainFrame.Name = "MainFrame"
    Window.MainFrame.Size = size
    Window.MainFrame.Position = UDim2.new(0, 10, 0, 10)
    Window.MainFrame.BackgroundColor3 = theme.Background
    Window.MainFrame.BackgroundTransparency = 0.05
    Window.MainFrame.BorderSizePixel = 0
    Window.MainFrame.ClipsDescendants = true
    Window.MainFrame.Parent = Window.ScreenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = Window.MainFrame

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = theme.Divider
    mainStroke.Thickness = 1.5
    mainStroke.Parent = Window.MainFrame
    
    -- Title Bar
    Window.TitleBar = Instance.new("Frame")
    Window.TitleBar.Name = "TitleBar"
    Window.TitleBar.Size = UDim2.new(1, 0, 0, 30)
    Window.TitleBar.BackgroundColor3 = theme.Secondary
    Window.TitleBar.BorderSizePixel = 0
    Window.TitleBar.Parent = Window.MainFrame
    
    Window.Title = Instance.new("TextLabel")
    Window.Title.Size = UDim2.new(1, -40, 1, 0)
    Window.Title.Position = UDim2.new(0, 15, 0, 0)
    Window.Title.BackgroundTransparency = 1
    Window.Title.Text = title
    Window.Title.TextColor3 = theme.Text
    Window.Title.Font = Enum.Font.GothamSemibold
    Window.Title.TextSize = 14
    Window.Title.TextXAlignment = Enum.TextXAlignment.Left
    Window.Title.Parent = Window.TitleBar
    
    Window.MinimizeBtn = Instance.new("TextButton")
    Window.MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    Window.MinimizeBtn.Position = UDim2.new(1, 0, 0.5, 0)
    Window.MinimizeBtn.AnchorPoint = Vector2.new(1, 0.5)
    Window.MinimizeBtn.BackgroundColor3 = theme.Secondary
    Window.MinimizeBtn.BorderSizePixel = 0
    Window.MinimizeBtn.Text = "—"
    Window.MinimizeBtn.TextColor3 = theme.Text
    Window.MinimizeBtn.Font = Enum.Font.GothamBold
    Window.MinimizeBtn.TextSize = 16
    Window.MinimizeBtn.Parent = Window.TitleBar
    
    -- Tab Container
    Window.TabContainer = Instance.new("ScrollingFrame")
    Window.TabContainer.Size = UDim2.new(1, -10, 0, 32)
    Window.TabContainer.Position = UDim2.new(0, 5, 0, 30)
    Window.TabContainer.BackgroundTransparency = 1
    Window.TabContainer.BorderSizePixel = 0
    Window.TabContainer.ScrollBarThickness = 0 -- Hide scrollbar
    Window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    Window.TabContainer.AutomaticCanvasSize = Enum.AutomaticSize.X
    Window.TabContainer.ScrollingDirection = Enum.ScrollingDirection.X
    Window.TabContainer.Parent = Window.MainFrame
    
    local TabLayout = Instance.new("UIListLayout")
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.Padding = UDim.new(0, 5)
    TabLayout.Parent = Window.TabContainer
    
    -- Content Frame
    Window.ContentFrame = Instance.new("Frame")
    Window.ContentFrame.Size = UDim2.new(1, -10, 1, -72) -- 30(title) + 32(tabs) + 10(footer)
    Window.ContentFrame.Position = UDim2.new(0, 5, 0, 62)
    Window.ContentFrame.BackgroundTransparency = 1
    Window.ContentFrame.Parent = Window.MainFrame
    
    -- V7: Footer Bar for Grabbing
    Window.FooterBar = Instance.new("Frame")
    Window.FooterBar.Name = "FooterBar"
    Window.FooterBar.Size = UDim2.new(1, 0, 0, 10)
    Window.FooterBar.Position = UDim2.new(0, 0, 1, 0)
    Window.FooterBar.AnchorPoint = Vector2.new(0, 1)
    Window.FooterBar.BackgroundColor3 = theme.Secondary
    Window.FooterBar.BorderSizePixel = 0
    Window.FooterBar.Parent = Window.MainFrame

    -- Minimized Frame
    Window.MinimizedFrame = Instance.new("Frame")
    Window.MinimizedFrame.Size = UDim2.new(0, 150, 0, 30)
    Window.MinimizedFrame.Position = UDim2.new(0, 10, 1, -40)
    Window.MinimizedFrame.BackgroundColor3 = theme.Secondary
    Window.MinimizedFrame.BackgroundTransparency = 0.05
    Window.MinimizedFrame.BorderSizePixel = 0
    Window.MinimizedFrame.Visible = false
    Window.MinimizedFrame.Parent = Window.ScreenGui
    
    local minimizedCorner = Instance.new("UICorner")
    minimizedCorner.CornerRadius = UDim.new(0, 8)
    minimizedCorner.Parent = Window.MinimizedFrame
    
    Window.RestoreBtn = Instance.new("TextButton")
    Window.RestoreBtn.Size = UDim2.new(1, 0, 1, 0)
    Window.RestoreBtn.BackgroundTransparency = 1
    Window.RestoreBtn.Text = "▲ " .. title
    Window.RestoreBtn.TextColor3 = theme.Text
    Window.RestoreBtn.Font = Enum.Font.GothamSemibold
    Window.RestoreBtn.TextSize = 12
    Window.RestoreBtn.Parent = Window.MinimizedFrame
    
    local function toggleMinimize()
        Window.minimized = not Window.minimized
        if Window.minimized then
            Window.MinimizedFrame.Position = Window.MainFrame.Position
        end
        Window.MainFrame.Visible = not Window.minimized
        Window.MinimizedFrame.Visible = Window.minimized
    end
    
    Window.MinimizeBtn.MouseButton1Click:Connect(toggleMinimize)
    Window.RestoreBtn.MouseButton1Click:Connect(toggleMinimize)
    
    -- V7: The Original Dragging System, Perfected for Top/Bottom Grabbing
    local function clampPosition(frame)
        local screenSize = workspace.CurrentCamera.ViewportSize
        local frameSize = frame.AbsoluteSize
        local currentPos = frame.Position
        local newX = math.clamp(currentPos.X.Offset, 0, screenSize.X - frameSize.X)
        local newY = math.clamp(currentPos.Y.Offset, 0, screenSize.Y - frameSize.Y)
        frame.Position = UDim2.fromOffset(newX, newY)
    end
    
    local dragInput, dragStart, frameStart
    local function startDrag(input, movePart)
        if Window.dragging then return end
        Window.dragging = true
        dragStart = input.Position
        frameStart = movePart.Position
        
        local moveConn, endConn
        moveConn = UserInputService.InputChanged:Connect(function(inp)
            if inp.UserInputType == input.UserInputType then
                local delta = inp.Position - dragStart
                movePart.Position = UDim2.fromOffset(frameStart.X.Offset + delta.X, frameStart.Y.Offset + delta.Y)
            end
        end)
        endConn = UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == input.UserInputType then
                Window.dragging = false
                clampPosition(movePart)
                moveConn:Disconnect()
                endConn:Disconnect()
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
    
    -- V7: True Adaptive Mobile Layout
    local function autoResize()
        local screenSize = workspace.CurrentCamera.ViewportSize
        
        if screenSize.X < 700 then -- Mobile breakpoint
            local newWidth = math.min(screenSize.X - 20, 400)
            local newHeight = math.min(screenSize.Y - 20, 500)
            Window.MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
            Window.MainFrame.Position = UDim2.new(0.5, -newWidth / 2, 0.5, -newHeight / 2)
        else
            Window.MainFrame.Size = size
        end
        clampPosition(Window.MainFrame)
    end
    
    table.insert(Window.connections, workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(autoResize))
    spawn(function() wait(0.1); autoResize() end)
    
    -- Window Methods
    function Window:CreateTab(name)
        local tabIndex = #Window.tabs + 1
        local Tab = {}
        
        Tab.Button = Instance.new("TextButton")
        Tab.Button.Size = UDim2.new(0, 80, 0, 24)
        Tab.Button.BackgroundColor3 = tabIndex == 1 and theme.Accent or theme.Button
        Tab.Button.BorderSizePixel = 0
        Tab.Button.Text = name
        Tab.Button.TextColor3 = theme.Text
        Tab.Button.Font = Enum.Font.GothamSemibold
        Tab.Button.TextSize = 12
        Tab.Button.Parent = Window.TabContainer
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 4)
        tabCorner.Parent = Tab.Button
        
        Tab.Content = Instance.new("ScrollingFrame")
        Tab.Content.Size = UDim2.new(1, 0, 1, 0)
        Tab.Content.BackgroundTransparency = 1
        Tab.Content.BorderSizePixel = 0
        Tab.Content.ScrollBarThickness = 3
        Tab.Content.ScrollBarImageColor3 = theme.Divider
        Tab.Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Tab.Content.Visible = tabIndex == 1
        Tab.Content.Parent = Window.ContentFrame
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Padding = UDim.new(0, 5)
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Parent = Tab.Content
        
        local ContentPadding = Instance.new("UIPadding")
        ContentPadding.PaddingTop = UDim.new(0, 5)
        ContentPadding.Parent = Tab.Content

        Tab.Button.MouseButton1Click:Connect(function()
            for i, otherTab in pairs(Window.tabs) do
                Tween(otherTab.Button, {BackgroundColor3 = theme.Button})
                otherTab.Content.Visible = false
            end
            Tween(Tab.Button, {BackgroundColor3 = theme.Accent})
            Tab.Content.Visible = true
        end)
        
        -- V7: Components built the V1 way
        function Tab:CreateToggle(text, callback, defaultState)
            local Toggle = { enabled = defaultState or false }
            
            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1, 0, 0, 35)
            Frame.BackgroundColor3 = theme.Button
            Frame.Parent = Tab.Content
            local frameCorner = Instance.new("UICorner"); frameCorner.CornerRadius = UDim.new(0, 4); frameCorner.Parent = Frame

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -60, 1, 0)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.TextColor3 = theme.TextSecondary
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Frame
            
            local SwitchButton = Instance.new("TextButton")
            SwitchButton.Size = UDim2.new(0, 40, 0, 20)
            SwitchButton.Position = UDim2.new(1, -10, 0.5, 0)
            SwitchButton.AnchorPoint = Vector2.new(1, 0.5)
            SwitchButton.BackgroundColor3 = Toggle.enabled and theme.Success or theme.Divider
            SwitchButton.Text = ""
            SwitchButton.Parent = Frame
            local switchCorner = Instance.new("UICorner"); switchCorner.CornerRadius = UDim.new(1, 0); switchCorner.Parent = SwitchButton
            
            local Nub = Instance.new("Frame")
            Nub.Size = UDim2.fromOffset(16, 16)
            Nub.Position = Toggle.enabled and UDim2.new(1, -2, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
            Nub.AnchorPoint = Toggle.enabled and Vector2.new(1, 0.5) or Vector2.new(0, 0.5)
            Nub.BackgroundColor3 = Color3.new(1, 1, 1)
            Nub.Parent = SwitchButton
            local nubCorner = Instance.new("UICorner"); nubCorner.CornerRadius = UDim.new(1, 0); nubCorner.Parent = Nub
            
            SwitchButton.MouseButton1Click:Connect(function()
                Toggle.enabled = not Toggle.enabled
                Tween(SwitchButton, {BackgroundColor3 = Toggle.enabled and theme.Success or theme.Divider})
                Tween(Nub, {Position = Toggle.enabled and UDim2.new(1, -2, 0.5, 0) or UDim2.new(0, 2, 0.5, 0), AnchorPoint = Toggle.enabled and Vector2.new(1, 0.5) or Vector2.new(0, 0.5)})
                if callback then task.spawn(callback, Toggle.enabled) end
            end)
        end
        
        function Tab:CreateButton(text, callback)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, 0, 0, 35)
            Button.BackgroundColor3 = theme.Button
            Button.Text = text
            Button.TextColor3 = theme.Text
            Button.Font = Enum.Font.GothamSemibold
            Button.TextSize = 14
            Button.Parent = Tab.Content
            local buttonCorner = Instance.new("UICorner"); buttonCorner.CornerRadius = UDim.new(0, 4); buttonCorner.Parent = Button
            
            Button.MouseEnter:Connect(function() Tween(Button, {BackgroundColor3 = theme.ButtonActive}) end)
            Button.MouseLeave:Connect(function() Tween(Button, {BackgroundColor3 = theme.Button}) end)
            if callback then Button.MouseButton1Click:Connect(callback) end
        end

        function Tab:CreateSlider(text, min, max, start, callback)
            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1, 0, 0, 55)
            Frame.BackgroundColor3 = theme.Button
            Frame.Parent = Tab.Content
            local frameCorner = Instance.new("UICorner"); frameCorner.CornerRadius = UDim.new(0, 4); frameCorner.Parent = Frame
            
            local value = start or min

            local Header = Instance.new("Frame")
            Header.Size = UDim2.new(1, -20, 0, 25)
            Header.Position = UDim2.new(0, 10, 0, 5)
            Header.BackgroundTransparency = 1
            Header.Parent = Frame
            
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.fromScale(0.7, 1)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.TextColor3 = theme.TextSecondary
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Header
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Size = UDim2.fromScale(0.3, 1)
            ValueLabel.Position = UDim2.fromScale(1, 0)
            ValueLabel.AnchorPoint = Vector2.new(1, 0)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Text = tostring(math.floor(value))
            ValueLabel.TextColor3 = theme.Text
            ValueLabel.Font = Enum.Font.GothamSemibold
            ValueLabel.TextSize = 13
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValueLabel.Parent = Header
            
            local Track = Instance.new("TextButton")
            Track.Size = UDim2.new(1, -20, 0, 6)
            Track.Position = UDim2.new(0.5, 0, 1, -15)
            Track.AnchorPoint = Vector2.new(0.5, 0.5)
            Track.BackgroundColor3 = theme.Background
            Track.Text = ""
            Track.Parent = Frame
            local trackCorner = Instance.new("UICorner"); trackCorner.CornerRadius = UDim.new(1, 0); trackCorner.Parent = Track
            
            local Fill = Instance.new("Frame")
            Fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
            Fill.BackgroundColor3 = theme.Accent
            Fill.ZIndex = 2
            Fill.Parent = Track
            local fillCorner = Instance.new("UICorner"); fillCorner.CornerRadius = UDim.new(1, 0); fillCorner.Parent = Fill
            
            local dragging = false
            local function updateSlider(inputX)
                local percentage = math.clamp((inputX - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                value = min + (max - min) * percentage
                Fill.Size = UDim2.new(percentage, 0, 1, 0)
                ValueLabel.Text = tostring(math.floor(value))
                if callback then task.spawn(callback, value) end
            end
            
            Track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    updateSlider(input.Position.X)
                end
            end)
            Track.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateSlider(input.Position.X)
                end
            end)
        end
        
        function Tab:CreateTextInput(placeholder, callback)
            local TextBox = Instance.new("TextBox")
            TextBox.Size = UDim2.new(1,0,0,35)
            TextBox.BackgroundColor3 = theme.Button
            TextBox.PlaceholderText = placeholder or ""
            TextBox.Text = ""
            TextBox.TextColor3 = theme.Text
            TextBox.PlaceholderColor3 = theme.TextSecondary
            TextBox.Font = Enum.Font.Gotham
            TextBox.TextSize = 13
            TextBox.ClearTextOnFocus = false
            TextBox.Parent = Tab.Content
            local boxCorner = Instance.new("UICorner"); boxCorner.CornerRadius = UDim.new(0, 4); boxCorner.Parent = TextBox
            
            local padding = Instance.new("UIPadding")
            padding.PaddingLeft = UDim.new(0, 10)
            padding.Parent = TextBox
            
            if callback then
                TextBox.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        callback(TextBox.Text)
                    end
                end)
            end
        end

        function Tab:CreateSeparator()
            local Sep = Instance.new("Frame")
            Sep.Size = UDim2.new(1,0,0,1)
            Sep.BackgroundColor3 = theme.Divider
            Sep.BorderSizePixel = 0
            Sep.Parent = Tab.Content
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
