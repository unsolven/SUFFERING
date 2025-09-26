--// LoUI V6 - The V1 Revival
--// Built on the stable foundation of the original code.
--// All requested features have been added with a focus on stability, polish, and a truly adaptive mobile experience.

local Library = {}

--// Services
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

--// Themes
Library.Themes = {
    Default = {
        Background = Color3.fromRGB(25, 25, 30),
        Secondary = Color3.fromRGB(35, 35, 45),
        Accent = Color3.fromRGB(70, 70, 85),
        Button = Color3.fromRGB(45, 45, 55),
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
        Text = Color3.fromRGB(240, 240, 245),
        TextSecondary = Color3.fromRGB(160, 160, 170),
        Success = Color3.fromRGB(70, 200, 120),
        Error = Color3.fromRGB(250, 80, 100),
        Divider = Color3.fromRGB(55, 55, 60),
    }
}

--// Utility Functions
local function Create(it, p) local i=Instance.new(it) for k,v in pairs(p) do i[k]=v end return i end
local function Tween(o, p, d) local t=TweenService:Create(o, TweenInfo.new(d or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), p) t:Play() return t end

--// Main Library Function
function Library:CreateWindow(options)
    options = options or {}
    local title = options.Title or "Hub"
    local size = options.Size or UDim2.new(0, 300, 0, 350)
    local theme = Library.Themes[options.Theme] or Library.Themes.Modern

    local Window = {
        tabs = {},
        minimized = false,
        connections = {},
        Theme = theme
    }

    Window.ScreenGui = Create("ScreenGui", { Name = title .. "UI", ResetOnSpawn = false, Parent = CoreGui })
    Create("UIScale", { Parent = Window.ScreenGui }) -- Essential for mobile scaling

    Window.MainFrame = Create("Frame", {
        Name = "MainFrame", Size = size, Position = UDim2.new(0, 20, 0, 20),
        BackgroundColor3 = Window.Theme.Background, BorderSizePixel = 0, ClipsDescendants = true,
        Parent = Window.ScreenGui
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = Window.MainFrame })
    Create("UIStroke", { Color = Window.Theme.Divider, Thickness = 1.5, Parent = Window.MainFrame })

    Window.TitleBar = Create("Frame", { Name = "TitleBar", Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = Window.Theme.Secondary, Parent = Window.MainFrame })
    Window.Title = Create("TextLabel", { Size = UDim2.new(1, -40, 1, 0), Position = UDim2.new(0, 15, 0, 0), BackgroundTransparency = 1, Text = title, TextColor3 = Window.Theme.Text, Font = Enum.Font.GothamSemibold, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, Parent = Window.TitleBar })
    Window.MinimizeBtn = Create("TextButton", { Size = UDim2.fromOffset(30,30), Position = UDim2.new(1,0,0.5,0), AnchorPoint=Vector2.new(1,0.5), BackgroundColor3 = Window.Theme.Secondary, Text = "—", TextColor3 = Window.Theme.Text, Font = Enum.Font.GothamBold, TextSize = 16, Parent = Window.TitleBar })
    
    Window.TabContainer = Create("ScrollingFrame", { Size = UDim2.new(1, -10, 0, 32), Position = UDim2.new(0, 5, 0, 30), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 0, AutomaticCanvasSize = Enum.AutomaticSize.X, ScrollingDirection = Enum.ScrollingDirection.X, Parent = Window.MainFrame })
    Create("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 5), Parent = Window.TabContainer })

    Window.ContentFrame = Create("Frame", { Size = UDim2.new(1, -10, 1, -72), Position = UDim2.new(0, 5, 0, 62), BackgroundTransparency = 1, Parent = Window.MainFrame })
    Window.FooterBar = Create("Frame", { Name = "FooterBar", Size = UDim2.new(1, 0, 0, 10), Position = UDim2.fromScale(0,1), AnchorPoint=Vector2.new(0,1), BackgroundColor3 = Window.Theme.Secondary, Parent = Window.MainFrame })

    Window.MinimizedFrame = Create("Frame", { Size = UDim2.new(0, 150, 0, 30), Position = Window.MainFrame.Position, BackgroundColor3 = Window.Theme.Secondary, BorderSizePixel = 0, Visible = false, Parent = Window.ScreenGui })
    Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = Window.MinimizedFrame })
    Create("UIStroke", { Color = Window.Theme.Divider, Thickness = 1.5, Parent = Window.MinimizedFrame })
    Window.RestoreBtn = Create("TextButton", { Size = UDim2.fromScale(1,1), BackgroundTransparency = 1, Text = "▲ " .. title, TextColor3 = Window.Theme.Text, Font = Enum.Font.GothamSemibold, TextSize = 12, Parent = Window.MinimizedFrame })

    local function toggleMinimize() Window.minimized = not Window.minimized; Window.MainFrame.Visible = not Window.minimized; Window.MinimizedFrame.Visible = Window.minimized; if Window.minimized then Window.MinimizedFrame.Position = Window.MainFrame.Position end end
    Window.MinimizeBtn.MouseButton1Click:Connect(toggleMinimize); Window.RestoreBtn.MouseButton1Click:Connect(toggleMinimize)

    --// V6 Dragging System (Stable & Simple)
    local function drag(grabPart, movePart)
        grabPart.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                local dragStart = input.Position; local frameStart = movePart.Position
                local moveConn, endConn
                moveConn = UserInputService.InputChanged:Connect(function(inp) if inp.UserInputType == input.UserInputType then local delta=inp.Position-dragStart; movePart.Position=UDim2.new(0,frameStart.X.Offset+delta.X,0,frameStart.Y.Offset+delta.Y) end end)
                endConn = UserInputService.InputEnded:Connect(function(inp) if inp.UserInputType == input.UserInputType then moveConn:Disconnect(); endConn:Disconnect() end end)
            end
        end)
    end
    drag(Window.TitleBar, Window.MainFrame); drag(Window.FooterBar, Window.MainFrame); drag(Window.MinimizedFrame, Window.MinimizedFrame)

    --// V6 Adaptive Mobile Layout
    local function updateLayout()
        local screenSize = workspace.CurrentCamera.ViewportSize
        if screenSize.X < 700 then -- Mobile breakpoint
            local newWidth = math.min(screenSize.X - 20, 400)
            Window.MainFrame.Size = UDim2.new(0, newWidth, 0, screenSize.Y * 0.7)
            Window.MainFrame.Position = UDim2.new(0.5, -newWidth/2, 0.5, -(screenSize.Y*0.7)/2)
        else
            Window.MainFrame.Size = size
            Window.MainFrame.Position = UDim2.new(0, 20, 0, 20)
        end
    end
    table.insert(Window.connections, workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateLayout))
    updateLayout()

    function Window:CreateTab(name)
        local tabIndex = #Window.tabs + 1
        local Tab = {}
        
        Tab.Button = Create("TextButton", { Size = UDim2.new(0, 80, 0, 24), BackgroundColor3 = tabIndex == 1 and Window.Theme.Accent or Window.Theme.Button, Text = name, TextColor3 = Window.Theme.Text, Font = Enum.Font.GothamSemibold, TextSize = 12, Parent = Window.TabContainer })
        Create("UICorner", { CornerRadius = UDim.new(0, 4), Parent = Tab.Button })
        
        Tab.Content = Create("ScrollingFrame", { Size = UDim2.fromScale(1,1), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3, ScrollBarImageColor3 = Window.Theme.Divider, AutomaticCanvasSize = Enum.AutomaticSize.Y, Visible = tabIndex == 1, Parent = Window.ContentFrame })
        Create("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, Parent = Tab.Content })
        Create("UIPadding", { PaddingTop = UDim.new(0,5), Parent=Tab.Content })

        Tab.Button.MouseButton1Click:Connect(function()
            for i, otherTab in pairs(Window.tabs) do Tween(otherTab.Button, {BackgroundColor3 = Window.Theme.Button}); otherTab.Content.Visible = false end
            Tween(Tab.Button, {BackgroundColor3 = Window.Theme.Accent}); Tab.Content.Visible = true
        end)
        
        --// V6 Complete Component Set
        local function createComponent(height) local F=Create("Frame",{Size=UDim2.new(1,0,0,height),BackgroundTransparency=1,Parent=Tab.Content}); return F end
        
        function Tab:CreateToggle(text, cb, def)
            local Frame=createComponent(35); local C=Create("Frame",{Parent=Frame,Size=UDim2.fromScale(1,1),BackgroundColor3=Window.Theme.Button});Create("UICorner",{Parent=C,CornerRadius=UDim.new(0,4)}); local L=Create("TextLabel",{Parent=C,Name="L",Size=UDim2.new(1,-60,1,0),Position=UDim2.fromOffset(10,0),BackgroundTransparency=1,Text=text,TextColor3=Window.Theme.TextSecondary,Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left})
            local s=def or false; local S=Create("TextButton",{Parent=C,Size=UDim2.fromOffset(40,20),Position=UDim2.new(1,-10,0.5,0),AnchorPoint=Vector2.new(1,0.5),BackgroundColor3=s and Window.Theme.Success or Window.Theme.Divider,Text=""}); Create("UICorner",{Parent=S,CornerRadius=UDim.new(1,0)})
            local N=Create("Frame",{Parent=S,Size=UDim2.fromOffset(16,16),Position=UDim2.new(0,2,0.5,0),AnchorPoint=Vector2.new(0,0.5),BackgroundColor3=Color3.new(1,1,1)}); Create("UICorner",{Parent=N,CornerRadius=UDim.new(1,0)}); if s then N.Position=UDim2.new(1,-2,0.5,0); N.AnchorPoint=Vector2.new(1,0.5) end
            S.MouseButton1Click:Connect(function() s=not s; Tween(S,{BackgroundColor3=s and Window.Theme.Success or Window.Theme.Divider}); Tween(N,{Position=s and UDim2.new(1,-2,0.5,0) or UDim2.new(0,2,0.5,0),AnchorPoint=s and Vector2.new(1,0.5) or Vector2.new(0,0.5)}); if cb then task.spawn(cb,s) end end)
        end

        function Tab:CreateButton(text, cb) local B=Create("TextButton",{Parent=Tab.Content,Size=UDim2.new(1,0,0,35),BackgroundColor3=Window.Theme.Button,Text=text,TextColor3=Window.Theme.Text,Font=Enum.Font.GothamSemibold,TextSize=14}); Create("UICorner",{Parent=B,CornerRadius=UDim.new(0,4)}); if cb then B.MouseButton1Click:Connect(cb) end end
        
        function Tab:CreateSlider(text, min, max, start, cb)
            local Frame=createComponent(55); local C=Create("Frame",{Parent=Frame,Size=UDim2.fromScale(1,1),BackgroundColor3=Window.Theme.Button}); Create("UICorner",{Parent=C,CornerRadius=UDim.new(0,4)}); local val=start or min
            local H=Create("Frame",{Parent=C,Size=UDim2.new(1,-20,0,25),Position=UDim2.fromOffset(10,5),BackgroundTransparency=1}); local L=Create("TextLabel",{Parent=H,Size=UDim2.fromScale(0.7,1),BackgroundTransparency=1,Text=text,TextColor3=Window.Theme.TextSecondary,Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left})
            local V=Create("TextLabel",{Parent=H,Position=UDim2.fromScale(1,0),AnchorPoint=Vector2.new(1,0),Size=UDim2.fromScale(0.3,1),BackgroundTransparency=1,Text=tostring(math.floor(val)),TextColor3=Window.Theme.Text,Font=Enum.Font.GothamSemibold,TextSize=13,TextXAlignment=Enum.TextXAlignment.Right})
            local Track=Create("TextButton",{Parent=C,Size=UDim2.new(1,-20,0,6),Position=UDim2.new(0.5,0,1,-15),AnchorPoint=Vector2.new(0.5,0.5),BackgroundColor3=Window.Theme.Background,Text=""}); Create("UICorner",{Parent=Track,CornerRadius=UDim.new(1,0)})
            local Fill=Create("Frame",{Parent=Track,Size=UDim2.new((val-min)/(max-min),0,1,0),BackgroundColor3=Window.Theme.Accent,ZIndex=2}); Create("UICorner",{Parent=Fill,CornerRadius=UDim.new(1,0)})
            local dragging=false; local function update(x) local p=math.clamp((x-Track.AbsolutePosition.X)/Track.AbsoluteSize.X,0,1); val=min+(max-min)*p; Fill.Size=UDim2.new(p,0,1,0); V.Text=tostring(math.floor(val)); if cb then task.spawn(cb,val) end end
            Track.InputBegan:Connect(function(i) if i.UserInputType~=Enum.UserInputType.MouseButton1 and i.UserInputType~=Enum.UserInputType.Touch then return end dragging=true; update(i.Position.X) end)
            Track.InputEnded:Connect(function(i) if i.UserInputType~=Enum.UserInputType.MouseButton1 and i.UserInputType~=Enum.UserInputType.Touch then dragging=false end end)
            UserInputService.InputChanged:Connect(function(i) if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then update(i.Position.X) end end)
        end

        function Tab:CreateTextInput(placeholder, cb) local T=Create("TextBox",{Parent=Tab.Content,Size=UDim2.new(1,0,0,35),BackgroundColor3=Window.Theme.Button,PlaceholderText=placeholder or "",Text="",TextColor3=Window.Theme.Text,PlaceholderColor3=Window.Theme.TextSecondary,Font=Enum.Font.Gotham,TextSize=13,ClearTextOnFocus=false}); Create("UICorner",{Parent=T,CornerRadius=UDim.new(0,4)}); Create("UIPadding",{Parent=T,PaddingLeft=UDim.new(0,10)}); if cb then T.FocusLost:Connect(function(enter) if enter then cb(T.Text) end end) end end

        function Tab:CreateDropdown(text, options, cb)
            local Frame=createComponent(35); local open=false
            local Main=Create("TextButton",{Parent=Frame,Size=UDim2.fromScale(1,1),BackgroundColor3=Window.Theme.Button,Text="",ZIndex=2});Create("UICorner",{Parent=Main,CornerRadius=UDim.new(0,4)})
            local Label=Create("TextLabel",{Parent=Main,Position=UDim2.fromOffset(10,0),Size=UDim2.new(1,-30,1,0),BackgroundTransparency=1,Text=text,TextColor3=Window.Theme.TextSecondary,Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left})
            local Value=Create("TextLabel",{Parent=Main,Size=UDim2.new(1,-30,1,0),BackgroundTransparency=1,Text=options[1],TextColor3=Window.Theme.Text,Font=Enum.Font.GothamSemibold,TextSize=13,TextXAlignment=Enum.TextXAlignment.Right})
            local Arrow=Create("TextLabel",{Parent=Main,Position=UDim2.fromScale(1,0.5),AnchorPoint=Vector2.new(1,0.5),Size=UDim2.fromOffset(20,20),BackgroundTransparency=1,Text="▼",TextColor3=Window.Theme.TextSecondary,Font=Enum.Font.GothamBold,TextSize=10})
            local Drop=Create("Frame",{Parent=Frame,Visible=false,Size=UDim2.new(1,0,0,0),Position=UDim2.new(0,0,1,5),BackgroundColor3=Window.Theme.Button,ClipsDescendants=true,ZIndex=1});Create("UICorner",{Parent=Drop,CornerRadius=UDim.new(0,4)});Create("UIListLayout",{Parent=Drop,Padding=UDim.new(0,2)})
            for i,v in pairs(options) do local O=Create("TextButton",{Parent=Drop,Size=UDim2.new(1,0,0,30),BackgroundTransparency=1,Text=v,TextColor3=Window.Theme.Text,Font=Enum.Font.Gotham,TextSize=13}); O.MouseButton1Click:Connect(function() Value.Text=v; if cb then cb(v) end end) end
            Main.MouseButton1Click:Connect(function() open=not open; Drop.Visible=true; local h=#options*32; Tween(Arrow,{Rotation=open and 180 or 0}); Tween(Frame,{Size=UDim2.new(1,0,0,open and 35+h+10 or 35)}); Tween(Drop,{Size=UDim2.new(1,0,0,open and h or 0)},0.3); if not open then task.wait(0.3) Drop.Visible=false end end)
        end

        function Tab:CreateKeybind(text, def, cb)
            local Frame=createComponent(35); local C=Create("Frame",{Parent=Frame,Size=UDim2.fromScale(1,1),BackgroundColor3=Window.Theme.Button}); Create("UICorner",{Parent=C,CornerRadius=UDim.new(0,4)}); local L=Create("TextLabel",{Parent=C,Position=UDim2.fromOffset(10,0),Size=UDim2.new(1,-110,1,0),BackgroundTransparency=1,Text=text,TextColor3=Window.Theme.TextSecondary,Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left})
            local key=def or Enum.KeyCode.None; local binding=false; local B=Create("TextButton",{Parent=C,Size=UDim2.fromOffset(100,25),Position=UDim2.new(1,-10,0.5,0),AnchorPoint=Vector2.new(1,0.5),BackgroundColor3=Window.Theme.Secondary,Text=key.Name,TextColor3=Window.Theme.Text,Font=Enum.Font.GothamSemibold,TextSize=12});Create("UICorner",{Parent=B,CornerRadius=UDim.new(0,4)})
            B.MouseButton1Click:Connect(function() if binding then return end; binding=true; B.Text="[...]"; local conn; conn=UserInputService.InputBegan:Connect(function(i,gpe) if gpe then return end; if i.UserInputType==Enum.UserInputType.Keyboard then if i.KeyCode==Enum.KeyCode.Escape then B.Text=key.Name else key=i.KeyCode; B.Text=key.Name; if cb then cb(key) end end; binding=false; conn:Disconnect() end end) end)
        end

        function Tab:CreateSeparator() local S=Create("Frame",{Parent=Tab.Content,Size=UDim2.new(1,0,0,1),BackgroundColor3=Window.Theme.Divider}) end
        function Tab:CreateLabel(text) local L=Create("TextLabel",{Parent=Tab.Content,Size=UDim2.new(1,0,0,30),BackgroundTransparency=1,Text=text,TextColor3=Window.Theme.TextSecondary,Font=Enum.Font.Gotham,TextSize=12,TextXAlignment=Enum.TextXAlignment.Center}) end

        table.insert(Window.tabs, Tab)
        return Tab
    end

    function Window:Destroy() for _,c in ipairs(Window.connections) do c:Disconnect() end; Window.ScreenGui:Destroy() end
    
    return Window
end

return Library
