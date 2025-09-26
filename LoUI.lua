--// LoUI V3 - A Modern & Responsive UI Library
--// Re-engineered for aesthetics, mobile-first design, and powerful new components.

local Library = { _version = "3.0.0" }

--// Services
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

--// Themes
Library.Themes = {
    V3 = {
        Background = Color3.fromRGB(24, 24, 27),       -- Darker, more modern
        Secondary = Color3.fromRGB(39, 39, 42),      -- Slightly lighter secondary
        Primary = Color3.fromRGB(20, 20, 22),        -- Even darker for sidebars etc
        Accent = Color3.fromRGB(9, 126, 234),        -- A vibrant blue
        AccentHover = Color3.fromRGB(52, 152, 255),  -- Lighter blue for hover
        Text = Color3.fromRGB(240, 240, 245),         -- Off-white for readability
        TextSecondary = Color3.fromRGB(160, 160, 170),-- Gray for less important text
        Success = Color3.fromRGB(70, 200, 120),
        Error = Color3.fromRGB(250, 80, 100),
        Divider = Color3.fromRGB(55, 55, 60),
    },
    -- Previous themes can be added here if desired
}

--// Utility Functions
local function Create(instanceType, props)
    local obj = Instance.new(instanceType)
    for k, v in pairs(props) do obj[k] = v end
    return obj
end

local function Tween(obj, props, duration)
    duration = duration or 0.2
    local tween = TweenService:Create(obj, TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props)
    tween:Play()
    return tween
end

local function HSVToRGB(h, s, v)
	local r, g, b
	local i = math.floor(h * 6)
	local f = h * 6 - i
	local p = v * (1 - s)
	local q = v * (1 - f * s)
	local t = v * (1 - (1 - f) * s)
	i = i % 6
	if i == 0 then r, g, b = v, t, p
	elseif i == 1 then r, g, b = q, v, p
	elseif i == 2 then r, g, b = p, v, t
	elseif i == 3 then r, g, b = p, q, v
	elseif i == 4 then r, g, b = t, p, v
	elseif i == 5 then r, g, b = v, p, q
	end
	return Color3.new(r, g, b)
end

--// Main Library Function
function Library:CreateWindow(options)
    options = options or {}
    local theme = Library.Themes[options.Theme] or Library.Themes.V3
    
    local Window = {
        tabs = {},
        activeTab = nil,
        connections = {},
        Theme = theme,
        isDocked = false
    }

    --// GUI Setup
    Window.ScreenGui = Create("ScreenGui", { Name = options.Title or "LoUI", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = CoreGui })
    Create("UIScale", { Parent = Window.ScreenGui })

    Window.MainFrame = Create("Frame", {
        Name = "MainFrame",
        Size = options.Size or UDim2.new(0, 500, 0, 350),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Window.Theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = Window.ScreenGui
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = Window.MainFrame })
    Create("UIStroke", { Color = Window.Theme.Divider, Thickness = 2, Parent = Window.MainFrame })

    --// Title Bar
    Window.TitleBar = Create("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundColor3 = Window.Theme.Secondary,
        Parent = Window.MainFrame
    })
    
    Window.Title = Create("TextLabel", {
        Size = UDim2.new(1, -70, 1, 0), Position = UDim2.new(0, 50, 0, 0),
        BackgroundTransparency = 1, Text = options.Title or "LoUI",
        TextColor3 = Window.Theme.Text, Font = Enum.Font.GothamSemibold,
        TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, Parent = Window.TitleBar
    })

    Window.CloseButton = Create("TextButton", {
        Name = "CloseButton", Size = UDim2.new(0, 32, 0, 32), Position = UDim2.new(1, 0, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5),
        BackgroundTransparency = 1, Text = "✕", TextColor3 = Window.Theme.TextSecondary,
        Font = Enum.Font.GothamBold, TextSize = 16, Parent = Window.TitleBar
    })

    --// Main Content Structure
    local Body = Create("Frame", { Name = "Body", Size = UDim2.new(1, 0, 1, -32), Position = UDim2.new(0, 0, 0, 32), BackgroundTransparency = 1, Parent = Window.MainFrame })
    
    Window.TabContainer = Create("Frame", { Name = "TabContainer", Size = UDim2.new(0, 48, 1, 0), BackgroundColor3 = Window.Theme.Primary, Parent = Body })
    Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 5), HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = Window.TabContainer })
    Create("UIPadding", { PaddingTop = UDim.new(0, 5), Parent = Window.TabContainer })
    
    Window.ContentFrame = Create("Frame", { Name = "ContentFrame", Size = UDim2.new(1, -48, 1, 0), Position = UDim2.new(0, 48, 0, 0), BackgroundTransparency = 1, Parent = Body })

    --// Core Logic: Dragging
    local dragInput, dragStart, frameStart
    Window.TitleBar.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not Window.isDocked then
            dragInput = input
            dragStart = input.Position
            frameStart = Window.MainFrame.Position
            
            local moveConn, endConn
            moveConn = UserInputService.InputChanged:Connect(function(inp)
                if inp == dragInput then
                    local delta = inp.Position - dragStart
                    Window.MainFrame.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X, frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
                end
            end)
            endConn = UserInputService.InputEnded:Connect(function(inp)
                if inp == dragInput then
                    dragInput = nil
                    moveConn:Disconnect()
                    endConn:Disconnect()
                end
            end)
        end
    end)
    
    --// Core Logic: Mobile Responsiveness & Docking
    local function updateLayout(screenSize)
        local isMobile = screenSize.X < 768 -- Common breakpoint for mobile/tablet
        if isMobile then
            if not Window.isDocked then -- Dock it
                Window.isDocked = true
                GuiService:SetScreenGuiInsets(Enum.ScreenGuiInset.Left, UDim.new(0, 320))
                Tween(Window.MainFrame, {
                    Size = UDim2.new(0, 320, 1, 0),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5)
                })
            end
        else
            if Window.isDocked then -- Undock it
                Window.isDocked = false
                GuiService:SetScreenGuiInsets(Enum.ScreenGuiInset.Left, UDim.new(0, 0))
                Tween(Window.MainFrame, {
                    Size = options.Size or UDim2.new(0, 500, 0, 350),
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5)
                })
            end
        end
    end

    table.insert(Window.connections, workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        updateLayout(workspace.CurrentCamera.ViewportSize)
    end))
    updateLayout(workspace.CurrentCamera.ViewportSize) -- Initial check

    --// Window Methods
    Window.CloseButton.MouseButton1Click:Connect(function() Window:Destroy() end)
    
    function Window:Destroy()
        if Window.isDocked then
            GuiService:SetScreenGuiInsets(Enum.ScreenGuiInset.Left, UDim.new(0, 0))
        end
        for _, conn in ipairs(Window.connections) do conn:Disconnect() end
        Window.ScreenGui:Destroy()
    end
    
    function Window:CreateTab(name, icon)
        local tabIndex = #Window.tabs + 1
        local Tab = {
            name = name,
            layoutOrder = 0,
            Button = nil,
            Content = nil,
            Sections = {}
        }

        Tab.Button = Create("TextButton", {
            Name = name, Size = UDim2.new(0, 36, 0, 36), LayoutOrder = tabIndex,
            BackgroundColor3 = Window.Theme.Primary, BackgroundTransparency = 1,
            Text = icon or "●", TextColor3 = Window.Theme.TextSecondary,
            Font = Enum.Font.GothamBold, TextSize = 20, Parent = Window.TabContainer
        })
        Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = Tab.Button })
        
        local Indicator = Create("Frame", {
            Name = "Indicator", Size = UDim2.new(0, 4, 0, 20), Position = UDim2.new(0, 0, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Window.Theme.Accent, Visible = false, Parent = Tab.Button
        })
        Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = Indicator })

        Tab.Content = Create("ScrollingFrame", {
            Name = name .. "Content", Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1, BorderSizePixel = 0, Visible = false,
            ScrollBarImageColor3 = Window.Theme.Accent, ScrollBarThickness = 4,
            AutomaticCanvasSize = Enum.AutomaticSize.Y, Parent = Window.ContentFrame
        })
        Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8), Parent = Tab.Content })
        Create("UIPadding", { Padding = UDim.new(0, 12), Parent = Tab.Content })
        
        --// Tab Selection Logic
        Tab.Button.MouseButton1Click:Connect(function()
            if Window.activeTab == Tab then return end
            if Window.activeTab then
                Window.activeTab.Content.Visible = false
                Tween(Window.activeTab.Button, { BackgroundTransparency = 1 })
                Tween(Window.activeTab.Button.TextColor3, Window.Theme.TextSecondary)
                Window.activeTab.Button.Indicator.Visible = false
            end
            Tab.Content.Visible = true
            Tween(Tab.Button, { BackgroundTransparency = 0, BackgroundColor3 = Window.Theme.Secondary })
            Tween(Tab.Button.TextColor3, Window.Theme.Text)
            Tab.Button.Indicator.Visible = true
            Window.activeTab = Tab
        end)
        
        --// Tab Component Methods
        function Tab:CreateSection(title)
            self.layoutOrder += 1
            local Section = {}
            
            local Frame = Create("Frame", { Name = title, Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = Window.Theme.Secondary, LayoutOrder = self.layoutOrder, Parent = self.Content })
            Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = Frame })
            Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4), Parent = Frame })
            Create("UIPadding", { Padding = UDim.new(0, 8), Parent = Frame })
            
            local Header = Create("TextButton", { Name = "Header", Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1, Text = "", Parent = Frame })
            
            local Title = Create("TextLabel", {
                Size = UDim2.new(1, -20, 1, 0), Position = UDim2.new(0, 0, 0, 0),
                BackgroundTransparency = 1, Text = title, TextColor3 = Window.Theme.Text,
                Font = Enum.Font.GothamSemibold, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, Parent = Header
            })
            
            local Arrow = Create("TextLabel", {
                Name = "Arrow", Size = UDim2.new(0, 20, 1, 0), Position = UDim2.new(1, -20, 0, 0),
                BackgroundTransparency = 1, Text = "▼", TextColor3 = Window.Theme.TextSecondary,
                Font = Enum.Font.GothamBold, TextSize = 12, Parent = Header
            })
            
            local isExpanded = true
            Header.MouseButton1Click:Connect(function()
                isExpanded = not isExpanded
                Tween(Arrow, { Rotation = isExpanded and 0 or -90 })
                local elementCount = 0
                for i, v in ipairs(Frame:GetChildren()) do if v:IsA("Frame") or v:IsA("TextButton") and v ~= Header then elementCount += 1 end end
                local targetHeight = isExpanded and (30 + (elementCount * 48)) or 30 -- Approximate height
                -- This part is tricky without knowing exact element sizes; a UILayout could help automate this
                for i, v in ipairs(Frame:GetChildren()) do if v ~= Header then v.Visible = isExpanded end end
            end)
            
            function Section:CreateToggle(text, callback, default)
                local Toggle = self:CreateBaseComponent(40)
                Create("TextLabel", { Name = "Label", Size = UDim2.new(1, -60, 1, 0), Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1, Text = text, TextColor3 = Window.Theme.TextSecondary, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Parent = Toggle.Frame })
                
                local state = default or false
                local Switch = Create("Frame", { Size = UDim2.new(0, 40, 0, 20), Position = UDim2.new(1, 0, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = state and Window.Theme.Success or Window.Theme.Divider, Parent = Toggle.Frame })
                Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = Switch })
                local Nub = Create("Frame", { Size = UDim2.fromOffset(16, 16), Position = UDim2.new(0, 2, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.new(1,1,1), Parent = Switch })
                Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = Nub })
                
                if state then Nub.Position = UDim2.new(1, -2, 0.5, 0); Nub.AnchorPoint = Vector2.new(1, 0.5) end
                
                Toggle.Button.MouseButton1Click:Connect(function()
                    state = not state
                    Tween(Switch, { BackgroundColor3 = state and Window.Theme.Success or Window.Theme.Divider })
                    Tween(Nub, { Position = state and UDim2.new(1, -2, 0.5, 0) or UDim2.new(0, 2, 0.5, 0), AnchorPoint = state and Vector2.new(1, 0.5) or Vector2.new(0, 0.5) })
                    if callback then task.spawn(callback, state) end
                end)
                return Toggle
            end

            function Section:CreateButton(text, callback)
                local Button = self:CreateBaseComponent(35, true)
                Button.Frame.BackgroundColor3 = Window.Theme.Accent
                Create("TextLabel", { ZIndex = 2, Name = "Label", Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = text, TextColor3 = Window.Theme.Text, Font = Enum.Font.GothamSemibold, TextSize = 14, Parent = Button.Frame })
                
                Button.Frame.MouseEnter:Connect(function() Tween(Button.Frame, { BackgroundColor3 = Window.Theme.AccentHover }) end)
                Button.Frame.MouseLeave:Connect(function() Tween(Button.Frame, { BackgroundColor3 = Window.Theme.Accent }) end)
                if callback then Button.Frame.MouseButton1Click:Connect(callback) end
                return Button
            end
            
            function Section:CreateColorPicker(text, defaultColor, callback)
                local Picker = self:CreateBaseComponent(40)
                Create("TextLabel", { Name = "Label", Size = UDim2.new(1, -50, 1, 0), BackgroundTransparency = 1, Text = text, TextColor3 = Window.Theme.TextSecondary, Font = Enum.Font.Gotham, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Parent = Picker.Frame })
                
                local ColorDisplay = Create("Frame", { Size = UDim2.fromOffset(28, 28), Position = UDim2.new(1, 0, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = defaultColor or Color3.new(1,1,1), Parent = Picker.Frame })
                Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = ColorDisplay })
                Create("UIStroke", { Color = Window.Theme.Divider, Parent = ColorDisplay })

                -- The actual picker popup would be a much larger implementation, often its own module.
                -- This is a placeholder for the logic to open a color picker popup.
                Picker.Button.MouseButton1Click:Connect(function()
                    print("Color Picker for '"..text.."' clicked. Popup UI would open here.")
                    -- In a full implementation, you'd create a separate frame with color wheels, sliders, etc.
                    -- and the callback would be connected to its color changes.
                end)
                
                return Picker
            end

            function Section:CreateBaseComponent(height, isButton)
                local component = {}
                local container = isButton and "TextButton" or "Frame"
                component.Frame = Create(container, {
                    Name = "Component", Size = UDim2.new(1, 0, 0, height),
                    BackgroundColor3 = Window.Theme.Primary, BorderSizePixel = 0,
                    Text = "", Parent = Frame
                })
                Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = component.Frame })
                
                if not isButton then
                    component.Button = Create("TextButton", { Name = "Button", Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "", Parent = component.Frame })
                end
                
                return component
            end
            
            table.insert(Tab.Sections, Section)
            return Section
        end
        
        table.insert(Window.tabs, Tab)
        if tabIndex == 1 then
            RunService.Heartbeat:Wait() -- Wait a frame for UI to draw
            Tab.Button:Invoke("MouseButton1Click")
        end
        return Tab
    end

    return Window
end

return Library
