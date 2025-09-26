--// LoUI V4 - The Definitive Edition
--// Combines V3's modern style with V2's full feature set.
--// Re-engineered for a flawless mobile experience, stability, and polish.

local Library = { _version = "4.0.0" }

--// Services
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

--// Themes
Library.Themes = {
    V4 = {
        Background = Color3.fromRGB(24, 24, 27),
        Secondary = Color3.fromRGB(39, 39, 42),
        Primary = Color3.fromRGB(20, 20, 22),
        Accent = Color3.fromRGB(9, 126, 234),
        AccentHover = Color3.fromRGB(52, 152, 255),
        Text = Color3.fromRGB(240, 240, 245),
        TextSecondary = Color3.fromRGB(160, 160, 170),
        Success = Color3.fromRGB(70, 200, 120),
        Error = Color3.fromRGB(250, 80, 100),
        Divider = Color3.fromRGB(55, 55, 60),
    },
}

--// Utility Functions
local function Create(instanceType, props) local obj = Instance.new(instanceType) for k, v in pairs(props) do obj[k] = v end return obj end
local function Tween(obj, props, dur) local t = TweenService:Create(obj, TweenInfo.new(dur or 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props) t:Play() return t end
local function HSVToRGB(h, s, v) local r,g,b;local i=math.floor(h*6);local f=h*6-i;local p=v*(1-s);local q=v*(1-f*s);local t=v*(1-(1-f)*s);i=i%6;if i==0 then r,g,b=v,t,p elseif i==1 then r,g,b=q,v,p elseif i==2 then r,g,b=p,v,t elseif i==3 then r,g,b=p,q,v elseif i==4 then r,g,b=t,p,v elseif i==5 then r,g,b=v,p,q end return Color3.new(r,g,b) end
local function RGBToHex(c) return string.format("#%02X%02X%02X", c.R*255, c.G*255, c.B*255) end

--// Main Library Function
function Library:CreateWindow(options)
    options = options or {}
    local theme = Library.Themes[options.Theme] or Library.Themes.V4
    
    local Window = { activeTab = nil, connections = {}, Theme = theme, isDocked = false, isPinned = true }

    --// GUI Setup
    Window.ScreenGui = Create("ScreenGui", { Name = options.Title or "LoUI", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = CoreGui })
    Create("UIScale", { Parent = Window.ScreenGui })

    Window.MainFrame = Create("Frame", { Name = "MainFrame", Size = options.Size or UDim2.new(0, 500, 0, 350), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Window.Theme.Background, BorderSizePixel = 0, ClipsDescendants = true, Parent = Window.ScreenGui })
    Create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = Window.MainFrame })
    Create("UIStroke", { Color = Window.Theme.Divider, Thickness = 2, Parent = Window.MainFrame })

    Window.TitleBar = Create("Frame", { Name = "TitleBar", Size = UDim2.new(1, 0, 0, 32), BackgroundColor3 = Window.Theme.Secondary, Parent = Window.MainFrame })
    Window.Title = Create("TextLabel", { Size = UDim2.new(1, -70, 1, 0), Position = UDim2.new(0, 50, 0, 0), BackgroundTransparency = 1, Text = options.Title or "LoUI", TextColor3 = Window.Theme.Text, Font = Enum.Font.GothamSemibold, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, Parent = Window.TitleBar })

    --// V4 Mobile Pin Button
    Window.PinButton = Create("TextButton", { Name = "PinButton", Size = UDim2.new(0, 32, 0, 32), Position = UDim2.new(0, 0, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Text = "📌", TextColor3 = Window.Theme.Text, Font = Enum.Font.GothamBold, TextSize = 16, Visible = false, Parent = Window.TitleBar })
    Window.CloseButton = Create("TextButton", { Name = "CloseButton", Size = UDim2.new(0, 32, 0, 32), Position = UDim2.new(1, 0, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, Text = "✕", TextColor3 = Window.Theme.TextSecondary, Font = Enum.Font.GothamBold, TextSize = 16, Parent = Window.TitleBar })
    
    local Body = Create("Frame", { Name = "Body", Size = UDim2.new(1, 0, 1, -32), Position = UDim2.new(0, 0, 0, 32), BackgroundTransparency = 1, Parent = Window.MainFrame })
    Window.TabContainer = Create("Frame", { Name = "TabContainer", Size = UDim2.new(0, 48, 1, 0), BackgroundColor3 = Window.Theme.Primary, Parent = Body })
    Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 5), HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = Window.TabContainer })
    Create("UIPadding", { PaddingTop = UDim.new(0, 5), Parent = Window.TabContainer })
    Window.ContentFrame = Create("Frame", { Name = "ContentFrame", Size = UDim2.new(1, -48, 1, 0), Position = UDim2.new(0, 48, 0, 0), BackgroundTransparency = 1, Parent = Body })

    --// Core Logic: Dragging
    local dragInput, dragStart, frameStart
    Window.TitleBar.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not Window.isDocked then
            dragInput = input; dragStart = input.Position; frameStart = Window.MainFrame.Position
            local move, ended; move = UserInputService.InputChanged:Connect(function(i) if i == dragInput then local d = i.Position-dragStart; Window.MainFrame.Position=UDim2.new(frameStart.X.Scale,frameStart.X.Offset+d.X,frameStart.Y.Scale,frameStart.Y.Offset+d.Y) end end)
            ended = UserInputService.InputEnded:Connect(function(i) if i == dragInput then dragInput = nil; move:Disconnect(); ended:Disconnect() end end)
        end
    end)
    
    --// V4 Core Logic: Mobile Docking & Pinning
    local function setPinned(pinned)
        Window.isPinned = pinned
        Window.PinButton.Text = pinned and "📌" or "→"
        local targetPos = pinned and UDim2.new(0, 0, 0.5, 0) or UDim2.new(0, -320, 0.5, 0)
        Tween(Window.MainFrame, { Position = targetPos })
        GuiService:SetScreenGuiInsets(Enum.ScreenGuiInset.Left, UDim.new(0, pinned and 320 or 0))
    end
    Window.PinButton.MouseButton1Click:Connect(function() setPinned(not Window.isPinned) end)

    local function updateLayout(screenSize)
        local isMobile = screenSize.X < 768
        if isMobile and not Window.isDocked then
            Window.isDocked = true
            Window.PinButton.Visible = true
            setPinned(true)
            Tween(Window.MainFrame, { Size = UDim2.new(0, 320, 1, 0), AnchorPoint = Vector2.new(0, 0.5) })
        elseif not isMobile and Window.isDocked then
            Window.isDocked = false
            Window.PinButton.Visible = false
            setPinned(false) -- This will remove the inset
            Tween(Window.MainFrame, { Size = options.Size or UDim2.new(0, 500, 0, 350), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5) })
        end
    end
    table.insert(Window.connections, workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() updateLayout(workspace.CurrentCamera.ViewportSize) end))
    updateLayout(workspace.CurrentCamera.ViewportSize)

    Window.CloseButton.MouseButton1Click:Connect(function() Window:Destroy() end)
    
    function Window:Destroy()
        if Window.isDocked then GuiService:SetScreenGuiInsets(Enum.ScreenGuiInset.Left, UDim.new(0, 0)) end
        for _, c in ipairs(Window.connections) do c:Disconnect() end; Window.ScreenGui:Destroy()
    end
    
    function Window:CreateTab(name, icon)
        local tabIndex = #Window.tabs + 1
        local Tab = { name = name, layoutOrder = 0 }
        
        Tab.Button = Create("TextButton", { Name=name, Size=UDim2.fromOffset(36, 36), LayoutOrder=tabIndex, BackgroundTransparency=1, Text=icon or "●", TextColor3=Window.Theme.TextSecondary, Font=Enum.Font.GothamBold, TextSize=20, Parent=Window.TabContainer })
        Create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = Tab.Button })
        local Indicator = Create("Frame", { Name="Indicator", Size=UDim2.new(0,4,0,20), Position=UDim2.new(0,0,0.5,0), AnchorPoint=Vector2.new(0,0.5), BackgroundColor3=Window.Theme.Accent, Visible=false, Parent=Tab.Button }); Create("UICorner", {Parent=Indicator})
        
        Tab.Content = Create("ScrollingFrame", { Name=name.."Content", Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, BorderSizePixel=0, Visible=false, ScrollBarImageColor3=Window.Theme.Accent, ScrollBarThickness=4, AutomaticCanvasSize=Enum.AutomaticSize.Y, Parent=Window.ContentFrame })
        Create("UIListLayout", { SortOrder=Enum.SortOrder.LayoutOrder, Padding=UDim.new(0, 8), Parent=Tab.Content })
        Create("UIPadding", { Padding=UDim.new(0, 12), Parent=Tab.Content })
        
        Tab.Button.MouseButton1Click:Connect(function()
            if Window.activeTab == Tab then return end
            if Window.activeTab then Window.activeTab.Content.Visible = false; Tween(Window.activeTab.Button, {BackgroundTransparency=1}); Tween(Window.activeTab.Button.TextColor3, Window.Theme.TextSecondary); Window.activeTab.Button.Indicator.Visible=false end
            Tab.Content.Visible=true; Tween(Tab.Button, {BackgroundTransparency=0, BackgroundColor3=Window.Theme.Secondary}); Tween(Tab.Button.TextColor3, Window.Theme.Text); Tab.Button.Indicator.Visible=true; Window.activeTab = Tab
        end)
        
        --// V4 Component Methods
        function Tab:CreateSection(title)
            self.layoutOrder += 1
            local Section = {}
            local Frame = Create("Frame", { Name=title, Size=UDim2.new(1, 0, 0, 30), BackgroundColor3=Window.Theme.Secondary, LayoutOrder=self.layoutOrder, ClipsDescendants=true, Parent=self.Content })
            Create("UICorner", { CornerRadius=UDim2.new(0,6,0,6), Parent=Frame })
            local Header = Create("TextButton", { Name="Header", Size=UDim2.new(1,0,0,30), BackgroundTransparency=1, Text="", Parent=Frame })
            local Title = Create("TextLabel", { Size=UDim2.new(1,-20,1,0), BackgroundTransparency=1, Text=title, TextColor3=Window.Theme.Text, Font=Enum.Font.GothamSemibold, TextSize=14, TextXAlignment=Enum.TextXAlignment.Left, Parent=Header }); Create("UIPadding", {PaddingLeft=UDim.new(0,8), Parent=Title})
            local Arrow = Create("TextLabel", { Name="Arrow", Size=UDim2.fromOffset(20,30), Position=UDim2.fromScale(1,0.5), AnchorPoint=Vector2.new(1,0.5), BackgroundTransparency=1, Text="▼", TextColor3=Window.Theme.TextSecondary, Font=Enum.Font.GothamBold, TextSize=12, Parent=Header })
            
            local Content = Create("Frame", { Name="Content", Size=UDim2.new(1,0,0,0), Position=UDim2.new(0,0,0,30), BackgroundTransparency=1, ClipsDescendants=true, Parent=Frame }); Create("UIListLayout", {SortOrder=Enum.SortOrder.LayoutOrder, Padding=UDim.new(0,4), Parent=Content}); Create("UIPadding", {Padding=UDim.new(0,8), Parent=Content})
            Content.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() Frame.Size = UDim2.new(1,0,0, 30 + Content.UIListLayout.AbsoluteContentSize.Y) end)
            
            local isExpanded = true
            Header.MouseButton1Click:Connect(function() isExpanded = not isExpanded; Tween(Arrow, {Rotation = isExpanded and 0 or -90}); Content.Visible = isExpanded; Frame.ClipsDescendants=false; Frame.Size=UDim2.new(1,0,0,30+(isExpanded and Content.UIListLayout.AbsoluteContentSize.Y or 0)); task.wait(0.2); Frame.ClipsDescendants=true end)
            
            function Section:CreateBaseComponent(height, isButton)
                local C={}; local T=isButton and "TextButton" or "Frame"; C.Frame=Create(T, {Name="C", Size=UDim2.new(1,0,0,height), BackgroundColor3=Window.Theme.Primary, BorderSizePixel=0, Text="", Parent=Content}); Create("UICorner",{CornerRadius=UDim.new(0,4), Parent=C.Frame})
                if not isButton then C.Button=Create("TextButton",{Name="Btn",Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",Parent=C.Frame}) end
                return C
            end
            
            -- Re-implement all components
            function Section:CreateToggle(text, cb, def) local T=self:CreateBaseComponent(40); local L=Create("TextLabel",{Parent=T.Frame,Name="L",Size=UDim2.new(1,-60,1,0),Position=UDim2.fromOffset(10,0),BackgroundTransparency=1,Text=text,TextColor3=Window.Theme.TextSecondary,Font=Enum.Font.Gotham,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left})
                local s=def or false; local S=Create("Frame",{Parent=T.Frame,Size=UDim2.fromOffset(40,20),Position=UDim2.new(1,-10,0.5,0),AnchorPoint=Vector2.new(1,0.5),BackgroundColor3=s and Window.Theme.Success or Window.Theme.Divider}); Create("UICorner",{Parent=S,CornerRadius=UDim.new(1,0)})
                local N=Create("Frame",{Parent=S,Size=UDim2.fromOffset(16,16),Position=UDim2.new(0,2,0.5,0),AnchorPoint=Vector2.new(0,0.5),BackgroundColor3=Color3.new(1,1,1)}); Create("UICorner",{Parent=N,CornerRadius=UDim.new(1,0)}); if s then N.Position=UDim2.new(1,-2,0.5,0); N.AnchorPoint=Vector2.new(1,0.5) end
                T.Button.MouseButton1Click:Connect(function() s=not s; Tween(S,{BackgroundColor3=s and Window.Theme.Success or Window.Theme.Divider}); Tween(N,{Position=s and UDim2.new(1,-2,0.5,0) or UDim2.new(0,2,0.5,0),AnchorPoint=s and Vector2.new(1,0.5) or Vector2.new(0,0.5)}); if cb then task.spawn(cb,s) end end)
            end
            
            function Section:CreateButton(text, cb) local B=self:CreateBaseComponent(35,true); B.Frame.BackgroundColor3=Window.Theme.Accent; local L=Create("TextLabel",{Parent=B.Frame,ZIndex=2,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=text,TextColor3=Window.Theme.Text,Font=Enum.Font.GothamSemibold,TextSize=14})
                B.Frame.MouseEnter:Connect(function() Tween(B.Frame,{BackgroundColor3=Window.Theme.AccentHover}) end); B.Frame.MouseLeave:Connect(function() Tween(B.Frame,{BackgroundColor3=Window.Theme.Accent}) end); if cb then B.Frame.MouseButton1Click:Connect(cb) end
            end
            
            function Section:CreateSlider(text, min, max, start, cb) local S=self:CreateBaseComponent(50); local val=start or min
                local H=Create("Frame", {Parent=S.Frame, Size=UDim2.new(1,0,0,25), BackgroundTransparency=1}); local L=Create("TextLabel", {Parent=H, Position=UDim2.fromOffset(10,0), Size=UDim2.fromScale(0.7,1), BackgroundTransparency=1, Text=text, TextColor3=Window.Theme.TextSecondary, Font=Enum.Font.Gotham,TextSize=13, TextXAlignment=Enum.TextXAlignment.Left})
                local V=Create("TextLabel", {Parent=H, Position=UDim2.fromScale(1,0), AnchorPoint=Vector2.new(1,0), Size=UDim2.new(0.3,-10,1,0), BackgroundTransparency=1, Text=math.floor(val), TextColor3=Window.Theme.Text, Font=Enum.Font.GothamSemibold, TextSize=13, TextXAlignment=Enum.TextXAlignment.Right})
                local T=Create("Frame", {Parent=S.Frame, Size=UDim2.new(1,-20,0,6), Position=UDim2.new(0.5,0,1,-12), AnchorPoint=Vector2.new(0.5,0.5), BackgroundColor3=Window.Theme.Divider}); Create("UICorner",{Parent=T,CornerRadius=UDim.new(1,0)})
                local F=Create("Frame", {Parent=T, Size=UDim2.new((val-min)/(max-min),0,1,0), BackgroundColor3=Window.Theme.Accent}); Create("UICorner",{Parent=F,CornerRadius=UDim.new(1,0)})
                local dragging=false; local function update(x) local p=math.clamp((x-T.AbsolutePosition.X)/T.AbsoluteSize.X,0,1); val=min+(max-min)*p; F.Size=UDim2.new(p,0,1,0); V.Text=math.floor(val); if cb then task.spawn(cb,val) end end
                S.Button.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true; update(i.Position.X) end end)
                S.Button.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
                S.Button.InputChanged:Connect(function(i) if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then update(i.Position.X) end end)
            end

            function Section:CreateColorPicker(text, def, cb)
                -- Component UI
                local CP = self:CreateBaseComponent(40); local currentColor = def or Color3.new(1,0,0)
                Create("TextLabel", { Parent=CP.Frame, Name="Label", Size=UDim2.new(1,-50,1,0), Position=UDim2.fromOffset(10,0), BackgroundTransparency=1, Text=text, TextColor3=Window.Theme.TextSecondary, Font=Enum.Font.Gotham, TextSize=13, TextXAlignment=Enum.TextXAlignment.Left })
                local Disp = Create("Frame", { Parent=CP.Frame, Size=UDim2.fromOffset(28,28), Position=UDim2.new(1,-10,0.5,0), AnchorPoint=Vector2.new(1,0.5), BackgroundColor3=currentColor }); Create("UICorner",{Parent=Disp, CornerRadius=UDim.new(0,6)}); Create("UIStroke",{Parent=Disp,Color=Window.Theme.Divider})
                
                -- Picker Popup UI (created once, shared)
                if not Window.ColorPickerFrame then
                    Window.ColorPickerFrame = Create("Frame", { Parent=Window.ScreenGui, ZIndex=10, Visible=false, Size=UDim2.fromOffset(220,260), BackgroundColor3=Window.Theme.Primary, BorderSizePixel=0 }); Create("UICorner",{Parent=Window.ColorPickerFrame}); Create("UIStroke",{Parent=Window.ColorPickerFrame, Color=Window.Theme.Divider})
                    local Pad=Create("UIPadding",{Parent=Window.ColorPickerFrame, Padding=UDim.new(0,10)})
                    local SV_Box = Create("Frame",{Parent=Window.ColorPickerFrame, Size=UDim2.new(1,0,0,180), BackgroundColor3=Color3.new(1,1,1)}); Create("UICorner",{Parent=SV_Box})
                    local Saturation = Create("UIGradient",{Parent=SV_Box, Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),ColorSequenceKeypoint.new(1,Color3.new(1,1,1))}), Rotation=90})
                    local Value = Create("UIGradient",{Parent=SV_Box, Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(0,0,0,1)),ColorSequenceKeypoint.new(1,Color3.new(0,0,0,0))})})
                    local Hue_Slider = Create("Frame",{Parent=Window.ColorPickerFrame, Position=UDim2.new(0,0,0,190), Size=UDim2.new(1,0,0,15)}); Create("UICorner",{Parent=Hue_Slider}); Create("UIGradient",{Parent=Hue_Slider, Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromHSV(0,1,1)),ColorSequenceKeypoint.new(1/6,Color3.fromHSV(1/6,1,1)),ColorSequenceKeypoint.new(2/6,Color3.fromHSV(2/6,1,1)),ColorSequenceKeypoint.new(3/6,Color3.fromHSV(3/6,1,1)),ColorSequenceKeypoint.new(4/6,Color3.fromHSV(4/6,1,1)),ColorSequenceKeypoint.new(5/6,Color3.fromHSV(5/6,1,1)),ColorSequenceKeypoint.new(1,Color3.fromHSV(1,1,1))})})
                    local Hex = Create("TextBox",{Parent=Window.ColorPickerFrame, Position=UDim2.new(0,0,0,215), Size=UDim2.new(1,0,0,25), BackgroundColor3=Window.Theme.Secondary, TextColor3=Window.Theme.Text, Font=Enum.Font.Gotham, TextSize=13, PlaceholderText="Hex Code", ClearTextOnFocus=false}); Create("UICorner",{Parent=Hex}); Create("UIPadding",{Parent=Hex, PaddingLeft=UDim.new(0,8)})
                    local h,s,v=Color.toHSV(currentColor); local currentCallback, currentDisplay; local sv_dragging, hue_dragging=false,false
                    
                    local function updatePickerColor() local c=Color3.fromHSV(h,s,v); Saturation.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),ColorSequenceKeypoint.new(1,Color3.fromHSV(h,1,1))}; if currentDisplay then currentDisplay.BackgroundColor3=c end; Hex.Text=RGBToHex(c); if currentCallback then currentCallback(c) end end
                    
                    SV_Box.InputBegan:Connect(function(i) if i.UserInputType~=Enum.UserInputType.MouseButton1 then return end sv_dragging=true; local p=i.Position-SV_Box.AbsolutePosition; s=math.clamp(p.X/SV_Box.AbsoluteSize.X,0,1); v=1-math.clamp(p.Y/SV_Box.AbsoluteSize.Y,0,1); updatePickerColor() end)
                    Hue_Slider.InputBegan:Connect(function(i) if i.UserInputType~=Enum.UserInputType.MouseButton1 then return end hue_dragging=true; h=math.clamp((i.Position.X-Hue_Slider.AbsolutePosition.X)/Hue_Slider.AbsoluteSize.X,0,1); updatePickerColor() end)
                    UserInputService.InputChanged:Connect(function(i) if i.UserInputType~=Enum.UserInputType.MouseMovement and i.UserInputType~=Enum.UserInputType.Touch then return end; if sv_dragging then local p=i.Position-SV_Box.AbsolutePosition; s=math.clamp(p.X/SV_Box.AbsoluteSize.X,0,1); v=1-math.clamp(p.Y/SV_Box.AbsoluteSize.Y,0,1); updatePickerColor() elseif hue_dragging then h=math.clamp((i.Position.X-Hue_Slider.AbsolutePosition.X)/Hue_Slider.AbsoluteSize.X,0,1); updatePickerColor() end end)
                    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then sv_dragging,hue_dragging=false,false end end)
                end
                
                CP.Button.MouseButton1Click:Connect(function()
                    Window.ColorPickerFrame.Visible = not Window.ColorPickerFrame.Visible
                    if Window.ColorPickerFrame.Visible then
                        Window.ColorPickerFrame.Position = UDim2.fromOffset(CP.Frame.AbsolutePosition.X + CP.Frame.AbsoluteSize.X + 10, CP.Frame.AbsolutePosition.Y)
                        local h,s,v = Color.toHSV(Disp.BackgroundColor3)
                        Window.ColorPickerFrame.currentCallback = cb
                        Window.ColorPickerFrame.currentDisplay = Disp
                        Window.ColorPickerFrame:FindFirstChild("Frame").UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),ColorSequenceKeypoint.new(1,Color3.fromHSV(h,1,1))}
                    end
                end)
            end
            
            return Section
        end
        
        table.insert(Window.tabs or {}, Tab); if tabIndex == 1 then task.wait(); Tab.Button:Invoke("MouseButton1Click") end
        return Tab
    end
    return Window
end
return Library
