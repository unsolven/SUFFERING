--// UI Library for Roblox - Revamped
--// Features: Theming, New Components (Slider, Dropdown, Keybind, TextInput),
--//           Top/Bottom Grabbing, Smooth Animations, Enhanced Mobile Support.
--// Usage: local Library = loadstring(game:HttpGet("your-raw-github-url"))()

local Library = {
    _version = "2.0.0",
    _author = "GPT-4 & Community",
}

--// Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

--// Themes
Library.Themes = {
    Default = {
        Background = Color3.fromRGB(25, 25, 30),
        Secondary = Color3.fromRGB(35, 35, 45),
        Accent = Color3.fromRGB(70, 70, 85),
        Button = Color3.fromRGB(45, 45, 55),
        ButtonActive = Color3.fromRGB(55, 55, 65),
        Text = Color3.fromRGB(220, 220, 220),
        TextSecondary = Color3.fromRGB(180, 180, 180),
        Success = Color3.fromRGB(100, 255, 100),
        Error = Color3.fromRGB(255, 100, 100),
        ScrollBar = Color3.fromRGB(100, 100, 120),
        Divider = Color3.fromRGB(60, 60, 75)
    },
    Light = {
        Background = Color3.fromRGB(240, 240, 240),
        Secondary = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(0, 120, 255),
        Button = Color3.fromRGB(225, 225, 225),
        ButtonActive = Color3.fromRGB(210, 210, 210),
        Text = Color3.fromRGB(20, 20, 20),
        TextSecondary = Color3.fromRGB(80, 80, 80),
        Success = Color3.fromRGB(0, 180, 0),
        Error = Color3.fromRGB(220, 50, 50),
        ScrollBar = Color3.fromRGB(180, 180, 180),
        Divider = Color3.fromRGB(200, 200, 200)
    },
    Midnight = {
        Background = Color3.fromRGB(18, 18, 22),
        Secondary = Color3.fromRGB(28, 28, 34),
        Accent = Color3.fromRGB(90, 80, 220),
        Button = Color3.fromRGB(40, 40, 50),
        ButtonActive = Color3.fromRGB(50, 50, 60),
        Text = Color3.fromRGB(235, 235, 235),
        TextSecondary = Color3.fromRGB(190, 190, 190),
        Success = Color3.fromRGB(80, 220, 80),
        Error = Color3.fromRGB(255, 80, 80),
        ScrollBar = Color3.fromRGB(110, 110, 130),
        Divider = Color3.fromRGB(70, 70, 85)
    }
}

--// Utility Functions
local function Create(instanceType)
    return function(props)
        local obj = Instance.new(instanceType)
        for k, v in pairs(props) do
            obj[k] = v
        end
        return obj
    end
end

local function Tween(object, properties, duration)
    duration = duration or 0.2
    local info = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, info, properties)
    tween:Play()
    return tween
end

--// Main Library Function
function Library:CreateWindow(options)
    options = options or {}
    local title = options.Title or "Hub"
    local size = options.Size or UDim2.new(0, 320, 0, 400)
    local theme = Library.Themes[options.Theme] or Library.Themes.Default

    local Window = {
        tabs = {},
        currentTab = 1,
        dragging = false,
        minimized = false,
        connections = {},
        Theme = theme
    }
    
    -- Create ScreenGui
    Window.ScreenGui = Create("ScreenGui"){
        Name = title .. "UI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = CoreGui
    }
    
    -- Add UIScale for better mobile responsiveness
    Create("UIScale"){ Parent = Window.ScreenGui }

    -- Main Frame
    Window.MainFrame = Create("Frame"){
        Name = "MainFrame",
        Size = size,
        Position = UDim2.new(0.5, -size.X.Offset / 2, 0.5, -size.Y.Offset / 2),
        BackgroundColor3 = Window.Theme.Background,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = Window.ScreenGui
    }
    Create("UICorner"){ CornerRadius = UDim.new(0, 8), Parent = Window.MainFrame }
    Create("UIStroke"){ Color = Window.Theme.Accent, Thickness = 1.5, Transparency = 0.5, Parent = Window.MainFrame }

    -- Title Bar (Grab Area)
    Window.TitleBar = Create("Frame"){
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundColor3 = Window.Theme.Secondary,
        BorderSizePixel = 0,
        Parent = Window.MainFrame
    }

    Window.Title = Create("TextLabel"){
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Window.Theme.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Window.TitleBar
    }

    Window.MinimizeBtn = Create("TextButton"){
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, 0, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = Window.Theme.Secondary,
        BorderSizePixel = 0,
        Text = "—",
        TextColor3 = Window.Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        Parent = Window.TitleBar
    }
    
    -- Tab Container
    Window.TabContainer = Create("ScrollingFrame"){
        Size = UDim2.new(1, 0, 0, 32),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Window.Theme.ScrollBar,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.X,
        ScrollingDirection = Enum.ScrollingDirection.X,
        Parent = Window.MainFrame
    }
    Create("UIListLayout"){
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 5),
        Parent = Window.TabContainer
    }
    Create("UIPadding"){
        PaddingLeft = UDim.new(0, 5),
        Parent = Window.TabContainer
    }

    -- Content Frame
    Window.ContentFrame = Create("Frame"){
        Size = UDim2.new(1, 0, 1, -74), -- 30(title) + 32(tabs) + 12(footer)
        Position = UDim2.new(0, 0, 0, 62),
        BackgroundTransparency = 1,
        Parent = Window.MainFrame
    }
    
    -- Footer Bar (Grab Area)
    Window.FooterBar = Create("Frame"){
        Name = "FooterBar",
        Size = UDim2.new(1, 0, 0, 12),
        Position = UDim2.new(0, 0, 1, 0),
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = Window.Theme.Secondary,
        BorderSizePixel = 0,
        Parent = Window.MainFrame
    }

    -- Minimized Frame
    Window.MinimizedFrame = Create("Frame"){
        Size = UDim2.new(0, 150, 0, 30),
        Position = Window.MainFrame.Position,
        BackgroundColor3 = Window.Theme.Secondary,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        Visible = false,
        Parent = Window.ScreenGui
    }
    Create("UICorner"){ CornerRadius = UDim.new(0, 8), Parent = Window.MinimizedFrame }
    Create("UIStroke"){ Color = Window.Theme.Accent, Thickness = 1.5, Transparency = 0.5, Parent = Window.MinimizedFrame }

    Window.RestoreBtn = Create("TextButton"){
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "▲  " .. title,
        TextColor3 = Window.Theme.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 12,
        Parent = Window.MinimizedFrame
    }

    --// Core Logic: Minimize/Restore
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

    --// Core Logic: Dragging System
    local function clampPosition(frame)
        local screenSize = workspace.CurrentCamera.ViewportSize
        local frameSize = frame.AbsoluteSize
        local currentPos = frame.Position
        local newX = math.clamp(currentPos.X.Offset, 0, screenSize.X - frameSize.X)
        local newY = math.clamp(currentPos.Y.Offset, 0, screenSize.Y - frameSize.Y)
        frame.Position = UDim2.fromOffset(newX, newY)
    end
    
    local dragInput, dragStart, frameStart
    local function updateDrag(input)
        local activeFrame = Window.minimized and Window.MinimizedFrame or Window.MainFrame
        local delta = input.Position - dragStart
        activeFrame.Position = UDim2.new(0, frameStart.X.Offset + delta.X, 0, frameStart.Y.Offset + delta.Y)
    end

    local function startDrag(input)
        if Window.dragging then return end
        Window.dragging = true
        dragStart = input.Position
        
        local activeFrame = Window.minimized and Window.MinimizedFrame or Window.MainFrame
        frameStart = activeFrame.Position
        
        local moveConn, endConn
        moveConn = UserInputService.InputChanged:Connect(function(inp)
            if inp.UserInputType == input.UserInputType then
                updateDrag(inp)
            end
        end)
        endConn = UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == input.UserInputType then
                Window.dragging = false
                clampPosition(activeFrame)
                moveConn:Disconnect()
                endConn:Disconnect()
            end
        end)
    end

    for _, grabArea in ipairs({Window.TitleBar, Window.FooterBar, Window.MinimizedFrame}) do
        table.insert(Window.connections, grabArea.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                startDrag(input)
            end
        end))
    end
    
    --// Core Logic: Responsive Clamping
    table.insert(Window.connections, workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        clampPosition(Window.MainFrame)
        clampPosition(Window.MinimizedFrame)
    end))

    --// Window Methods
    function Window:CreateTab(name)
        local tabIndex = #Window.tabs + 1
        local layoutOrder = 0
        local Tab = {
            name = name,
            elements = {},
            active = tabIndex == 1
        }
        
        Tab.Button = Create("TextButton"){
            Size = UDim2.new(0, 80, 0, 24),
            LayoutOrder = tabIndex,
            BackgroundColor3 = tabIndex == 1 and Window.Theme.Accent or Window.Theme.Button,
            BorderSizePixel = 0,
            Text = name,
            TextColor3 = Window.Theme.Text,
            Font = Enum.Font.GothamSemibold,
            TextSize = 12,
            Parent = Window.TabContainer
        }
        Create("UICorner"){ CornerRadius = UDim.new(0, 4), Parent = Tab.Button }

        Tab.Content = Create("ScrollingFrame"){
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Window.Theme.ScrollBar,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = tabIndex == 1,
            Parent = Window.ContentFrame
        }
        Create("UIListLayout"){
            Padding = UDim.new(0, 5),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = Tab.Content
        }
        Create("UIPadding"){
            PaddingTop = UDim.new(0, 5),
            PaddingBottom = UDim.new(0, 5),
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8),
            Parent = Tab.Content
        }

        Tab.Button.MouseButton1Click:Connect(function()
            for i, otherTab in pairs(Window.tabs) do
                otherTab.Content.Visible = false
                otherTab.active = false
                Tween(otherTab.Button, {BackgroundColor3 = Window.Theme.Button})
            end
            Tab.Content.Visible = true
            Tab.active = true
            Window.currentTab = tabIndex
            Tween(Tab.Button, {BackgroundColor3 = Window.Theme.Accent})
        end)

        --// Tab Methods (Component Creation)
        function Tab:CreateToggle(text, callback, defaultState)
            layoutOrder += 1
            local Toggle = { enabled = defaultState or false }
            
            local Frame = Create("Frame"){
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = Window.Theme.Button,
                LayoutOrder = layoutOrder,
                Parent = Tab.Content
            }
            Create("UICorner"){ CornerRadius = UDim.new(0, 4), Parent = Frame }

            Create("TextLabel"){
                Size = UDim2.new(1, -60, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = text,
                TextColor3 = Window.Theme.TextSecondary,
                Font = Enum.Font.Gotham,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = Frame
            }
            
            local Switch = Create("Frame"){
                Size = UDim2.new(0, 40, 0, 20),
                Position = UDim2.new(1, -50, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = Toggle.enabled and Window.Theme.Success or Window.Theme.Error,
                Parent = Frame
            }
            Create("UICorner"){ CornerRadius = UDim.new(1, 0), Parent = Switch }
            
            local Nub = Create("Frame"){
                Size = UDim2.new(0, 16, 0, 16),
                Position = Toggle.enabled and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = Color3.new(1, 1, 1),
                Parent = Switch
            }
            Create("UICorner"){ CornerRadius = UDim.new(1, 0), Parent = Nub }
            
            local Button = Create("TextButton"){
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1, Text = "", Parent = Frame
            }

            Button.MouseButton1Click:Connect(function()
                Toggle.enabled = not Toggle.enabled
                local nubPos = Toggle.enabled and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                local switchColor = Toggle.enabled and Window.Theme.Success or Window.Theme.Error
                Tween(Nub, {Position = nubPos})
                Tween(Switch, {BackgroundColor3 = switchColor})
                if callback then task.spawn(callback, Toggle.enabled) end
            end)
            
            table.insert(Tab.elements, Toggle)
            return Toggle
        end
        
        function Tab:CreateTextButton(text, callback)
            layoutOrder += 1
            local Button = Create("TextButton"){
                Size = UDim2.new(1, 0, 0, 35),
                BackgroundColor3 = Window.Theme.Button,
                LayoutOrder = layoutOrder,
                Text = text,
                TextColor3 = Window.Theme.Text,
                Font = Enum.Font.GothamSemibold,
                TextSize = 14,
                Parent = Tab.Content
            }
            Create("UICorner"){ CornerRadius = UDim.new(0, 4), Parent = Button }

            Button.MouseEnter:Connect(function() Tween(Button, {BackgroundColor3 = Window.Theme.ButtonActive}) end)
            Button.MouseLeave:Connect(function() Tween(Button, {BackgroundColor3 = Window.Theme.Button}) end)
            Button.MouseButton1Click:Connect(function()
                Tween(Button, {BackgroundColor3 = Window.Theme.Accent})
                Tween(Button, {BackgroundColor3 = Window.Theme.ButtonActive}, 0.3)
                if callback then task.spawn(callback) end
            end)
            
            return Button
        end

        function Tab:CreateSlider(text, min, max, start, callback)
            layoutOrder += 1
            local Slider = { value = start or min }
            
            local Frame = Create("Frame"){
                Size = UDim2.new(1, 0, 0, 50),
                BackgroundColor3 = Window.Theme.Button,
                LayoutOrder = layoutOrder,
                Parent = Tab.Content
            }
            Create("UICorner"){ CornerRadius = UDim.new(0, 4), Parent = Frame }

            local Title = Create("TextLabel"){
                Size = UDim2.new(0.5, 0, 0, 20),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = text,
                TextColor3 = Window.Theme.TextSecondary,
                Font = Enum.Font.Gotham, TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = Frame
            }
            
            local ValueLabel = Create("TextLabel"){
                Size = UDim2.new(0.5, -10, 0, 20),
                Position = UDim2.new(1, 0, 0, 0),
                AnchorPoint = Vector2.new(1, 0),
                BackgroundTransparency = 1,
                Text = tostring(Slider.value),
                TextColor3 = Window.Theme.Text,
                Font = Enum.Font.GothamSemibold, TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Right,
                Parent = Frame
            }
            
            local Track = Create("Frame"){
                Size = UDim2.new(1, -20, 0, 4),
                Position = UDim2.new(0.5, 0, 0.5, 10),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = Window.Theme.Background,
                Parent = Frame
            }
            Create("UICorner"){ CornerRadius = UDim.new(1, 0), Parent = Track }
            
            local Fill = Create("Frame"){
                Size = UDim2.new((Slider.value - min) / (max - min), 0, 1, 0),
                BackgroundColor3 = Window.Theme.Accent,
                Parent = Track
            }
            Create("UICorner"){ CornerRadius = UDim.new(1, 0), Parent = Fill }
            
            local dragging = false
            local function updateSlider(inputX)
                local relativeX = inputX - Track.AbsolutePosition.X
                local percentage = math.clamp(relativeX / Track.AbsoluteSize.X, 0, 1)
                Slider.value = math.floor((min + (max - min) * percentage) + 0.5)
                Fill.Size = UDim2.new(percentage, 0, 1, 0)
                ValueLabel.Text = tostring(Slider.value)
                if callback then task.spawn(callback, Slider.value) end
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
            Track.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateSlider(input.Position.X)
                end
            end)

            table.insert(Tab.elements, Slider)
            return Slider
        end
        
        function Tab:CreateTextInput(text, placeholder, callback)
            layoutOrder += 1
            local TextBox = Create("TextBox"){
                Size = UDim2.new(1, 0, 0, 35),
                BackgroundColor3 = Window.Theme.Button,
                LayoutOrder = layoutOrder,
                PlaceholderText = placeholder or "",
                Text = text or "",
                TextColor3 = Window.Theme.Text,
                PlaceholderColor3 = Window.Theme.TextSecondary,
                Font = Enum.Font.Gotham,
                TextSize = 14,
                ClearTextOnFocus = false,
                Parent = Tab.Content
            }
            Create("UICorner"){ CornerRadius = UDim.new(0, 4), Parent = TextBox }
            Create("UIPadding"){ PaddingLeft = UDim.new(0, 10), Parent = TextBox }
            
            local Stroke = Create("UIStroke"){
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Color = Window.Theme.Accent,
                Thickness = 1.5,
                Transparency = 1,
                Parent = TextBox
            }
            
            TextBox.FocusGained:Connect(function() Tween(Stroke, {Transparency = 0.5}) end)
            TextBox.FocusLost:Connect(function(enterPressed)
                Tween(Stroke, {Transparency = 1})
                if enterPressed and callback then
                    task.spawn(callback, TextBox.Text)
                end
            end)
            
            return TextBox
        end
        
        function Tab:CreateDropdown(text, options, callback)
            layoutOrder += 1
            local Dropdown = { selected = options[1] }
            local isOpen = false

            local Frame = Create("Frame"){
                Size = UDim2.new(1, 0, 0, 35),
                BackgroundColor3 = Window.Theme.Button,
                LayoutOrder = layoutOrder,
                ClipsDescendants = true,
                Parent = Tab.Content,
                ZIndex = 2
            }
            Create("UICorner"){ CornerRadius = UDim.new(0, 4), Parent = Frame }

            local Button = Create("TextButton"){
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundColor3 = Window.Theme.Button,
                Text = "",
                Parent = Frame
            }
            
            local Label = Create("TextLabel"){
                Size = UDim2.new(1, -30, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = Dropdown.selected,
                TextColor3 = Window.Theme.Text,
                Font = Enum.Font.Gotham, TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = Button
            }

            local Arrow = Create("TextLabel"){
                Size = UDim2.new(0, 20, 1, 0),
                Position = UDim2.new(1, -20, 0, 0),
                BackgroundTransparency = 1,
                Text = "▼",
                TextColor3 = Window.Theme.TextSecondary,
                Font = Enum.Font.GothamBold, TextSize = 10,
                Parent = Button
            }

            local OptionsContainer = Create("ScrollingFrame"){
                Size = UDim2.new(1, 0, 0, 110),
                Position = UDim2.new(0, 0, 1, 0),
                BackgroundTransparency = 0.1,
                BackgroundColor3 = Window.Theme.Secondary,
                BorderSizePixel = 0,
                CanvasSize = UDim2.new(0,0,0,0),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                Visible = false,
                Parent = Frame,
                ZIndex = 3
            }
            Create("UIListLayout"){ Padding = UDim.new(0, 2), Parent = OptionsContainer }

            for _, optionName in ipairs(options) do
                local OptionButton = Create("TextButton"){
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundColor3 = Window.Theme.Button,
                    BackgroundTransparency = 1,
                    Text = optionName,
                    TextColor3 = Window.Theme.Text,
                    Font = Enum.Font.Gotham, TextSize = 13,
                    Parent = OptionsContainer
                }
                OptionButton.MouseEnter:Connect(function() OptionButton.BackgroundTransparency = 0.8 end)
                OptionButton.MouseLeave:Connect(function() OptionButton.BackgroundTransparency = 1 end)
                
                OptionButton.MouseButton1Click:Connect(function()
                    Dropdown.selected = optionName
                    Label.Text = optionName
                    isOpen = not isOpen
                    Tween(Arrow, {Rotation = isOpen and 180 or 0})
                    Tween(Frame, {Size = UDim2.new(1, 0, 0, isOpen and (35 + OptionsContainer.AbsoluteSize.Y) or 35)})
                    OptionsContainer.Visible = isOpen
                    if callback then task.spawn(callback, Dropdown.selected) end
                end)
            end
            
            Button.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                local finalSize = 35 + OptionsContainer.CanvasSize.Y.Offset
                if finalSize > 150 then finalSize = 150 end
                
                Tween(Arrow, {Rotation = isOpen and 180 or 0})
                Tween(Frame, {Size = UDim2.new(1, 0, 0, isOpen and finalSize or 35)})
                OptionsContainer.Visible = isOpen
            end)
            
            return Dropdown
        end

        function Tab:CreateKeybind(text, defaultKey, callback)
            layoutOrder += 1
            local Keybind = { key = defaultKey or Enum.KeyCode.None }
            local isBinding = false
            
            local Frame = Create("Frame"){
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = Window.Theme.Button,
                LayoutOrder = layoutOrder, Parent = Tab.Content
            }
            Create("UICorner"){ CornerRadius = UDim.new(0, 4), Parent = Frame }

            Create("TextLabel"){
                Size = UDim2.new(1, -110, 1, 0), Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1, Text = text, TextColor3 = Window.Theme.TextSecondary,
                Font = Enum.Font.Gotham, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, Parent = Frame
            }
            
            local Button = Create("TextButton"){
                Size = UDim2.new(0, 100, 0, 25), Position = UDim2.new(1, -105, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = Window.Theme.Secondary, Text = Keybind.key.Name,
                TextColor3 = Window.Theme.Text, Font = Enum.Font.GothamSemibold, TextSize = 12, Parent = Frame
            }
            Create("UICorner"){ CornerRadius = UDim.new(0, 4), Parent = Button }
            
            local bindConn
            Button.MouseButton1Click:Connect(function()
                if isBinding then return end
                isBinding = true
                Button.Text = "[...]"
                
                bindConn = UserInputService.InputBegan:Connect(function(input, gpe)
                    if gpe then return end
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        if input.KeyCode == Enum.KeyCode.Escape then
                            Button.Text = Keybind.key.Name
                        else
                            Keybind.key = input.KeyCode
                            Button.Text = Keybind.key.Name
                            if callback then task.spawn(callback, Keybind.key) end
                        end
                        isBinding = false
                        bindConn:Disconnect()
                    end
                end)
            end)
            
            return Keybind
        end

        function Tab:CreateSeparator()
            layoutOrder += 1
            local Sep = Create("Frame"){
                Size = UDim2.new(1, 0, 0, 1),
                BackgroundColor3 = Window.Theme.Divider,
                LayoutOrder = layoutOrder,
                Parent = Tab.Content
            }
            return Sep
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
