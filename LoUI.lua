-- Instances: 104 | Scripts: 0 | Modules: 1
local LoUI = {};

-- Adicionando UIShadow e UIStroke como instâncias reutilizáveis para melhor organização
local function createShadow()
	local shadow = Instance.new("UIShadow")
	shadow.ShadowColor = Color3.fromRGB(0, 0, 0)
	shadow.ShadowTransparency = 0.6
	shadow.Size = 4
	shadow.Offset = Vector2.new(0, 2)
	return shadow
end

local function createHoverStroke()
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(220, 160, 190) -- Cor de destaque
	stroke.Thickness = 1.5
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Enabled = false -- Desabilitado por padrão
	return stroke
end


-- LoUI
LoUI["1"] = Instance.new("ScreenGui", game:GetService("CoreGui"));
LoUI["1"]["IgnoreGuiInset"] = true;
LoUI["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
LoUI["1"]["Name"] = [[LoUI]];
LoUI["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;

-- LoUI.TopBar
LoUI["2"] = Instance.new("Frame", LoUI["1"]);
LoUI["2"]["BorderSizePixel"] = 0;
LoUI["2"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["2"]["LayoutOrder"] = 2;
LoUI["2"]["Size"] = UDim2.new(0.5404488444328308, 0, 0.1739015281200409, 0);
LoUI["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["2"]["Position"] = UDim2.new(0.23000000417232513, 0, -0.1899999976158142, 0);
LoUI["2"]["Name"] = [[TopBar]];
createShadow().Parent = LoUI["2"]; -- Adicionado sombreamento

-- LoUI.TopBar.UICorner
LoUI["3"] = Instance.new("UICorner", LoUI["2"]);
LoUI["3"]["CornerRadius"] = UDim.new(0.10000000149011612, 0);

-- LoUI.TopBar.ScrollingFrame
LoUI["4"] = Instance.new("ScrollingFrame", LoUI["2"]);
LoUI["4"]["Active"] = true;
LoUI["4"]["ScrollingDirection"] = Enum.ScrollingDirection.Y;
LoUI["4"]["BorderSizePixel"] = 0;
LoUI["4"]["CanvasSize"] = UDim2.new(0.10000000149011612, 0, 0, 0);
LoUI["4"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["4"]["AutomaticCanvasSize"] = Enum.AutomaticSize.X;
LoUI["4"]["BackgroundTransparency"] = 1;
LoUI["4"]["Size"] = UDim2.new(0.915977954864502, 0, 0.5196850299835205, 0);
LoUI["4"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["4"]["ScrollBarThickness"] = 0;
LoUI["4"]["Position"] = UDim2.new(0, 0, 0.4803149700164795, 0);

-- LoUI.TopBar.ScrollingFrame.UIListLayout
LoUI["5"] = Instance.new("UIListLayout", LoUI["4"]);
LoUI["5"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
LoUI["5"]["FillDirection"] = Enum.FillDirection.Horizontal;
LoUI["5"]["Padding"] = UDim.new(0.009999999776482582, 0);
LoUI["5"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

-- LoUI.TopBar.ScrollingFrame.UIPadding
LoUI["6"] = Instance.new("UIPadding", LoUI["4"]);
LoUI["6"]["PaddingLeft"] = UDim.new(0.014999999664723873, 0);

-- LoUI.TopBar.TopBar
LoUI["a"] = Instance.new("Frame", LoUI["2"]);
LoUI["a"]["BorderSizePixel"] = 0;
LoUI["a"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["a"]["LayoutOrder"] = 2;
LoUI["a"]["Size"] = UDim2.new(0.9983566999435425, 0, 0.05511785298585892, 0);
LoUI["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["a"]["Position"] = UDim2.new(0, 0, 0.4645671844482422, 0);
LoUI["a"]["Name"] = [[TopBar]];

-- LoUI.TopBar.ProfileMenu
LoUI["c"] = Instance.new("Frame", LoUI["2"]);
LoUI["c"]["BorderSizePixel"] = 0;
LoUI["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["c"]["BackgroundTransparency"] = 1;
LoUI["c"]["Size"] = UDim2.new(0.9983566999435425, 0, 0.4645672142505646, 0);
LoUI["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["c"]["Name"] = [[ProfileMenu]];

-- LoUI.TopBar.ProfileMenu.PlayerProfile
LoUI["d"] = Instance.new("ImageButton", LoUI["c"]);
LoUI["d"]["BorderSizePixel"] = 0;
LoUI["d"]["AutoButtonColor"] = false;
LoUI["d"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["d"]["Size"] = UDim2.new(0.23481373488903046, 0, 0.682426393032074, 0);
LoUI["d"]["Name"] = [[PlayerProfile]];
LoUI["d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["d"]["Position"] = UDim2.new(0.015024710446596146, 0, 0.18421050906181335, 0);
createShadow().Parent = LoUI["d"]; -- Adicionado sombreamento

-- LoUI.TopBar.ProfileMenu.PlayerProfile.UICorner
LoUI["e"] = Instance.new("UICorner", LoUI["d"]);
LoUI["e"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

-- LoUI.TopBar.ProfileMenu.PlayerProfile.ImageLabel
LoUI["10"] = Instance.new("ImageLabel", LoUI["d"]);
LoUI["10"]["BorderSizePixel"] = 0;
LoUI["10"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["10"]["Size"] = UDim2.new(0.16644950211048126, 0, 0.8032786846160889, 0);
LoUI["10"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["10"]["Position"] = UDim2.new(0.03799999877810478, 0, 0.1420000046491623, 0);

-- LoUI.TopBar.ProfileMenu.PlayerProfile.ImageLabel.UIAspectRatioConstraint
LoUI["11"] = Instance.new("UIAspectRatioConstraint", LoUI["10"]);
LoUI["11"]["AspectRatio"] = 0.9842342734336853;

-- LoUI.TopBar.ProfileMenu.PlayerProfile.ImageLabel.UICorner
LoUI["12"] = Instance.new("UICorner", LoUI["10"]);
LoUI["12"]["CornerRadius"] = UDim.new(100, 0);

-- LoUI.TopBar.ProfileMenu.PlayerProfile.TextLabel
LoUI["14"] = Instance.new("TextLabel", LoUI["d"]);
LoUI["14"]["TextWrapped"] = true;
LoUI["14"]["BorderSizePixel"] = 0;
LoUI["14"]["TextScaled"] = true;
LoUI["14"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["14"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LoUI["14"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
LoUI["14"]["TextSize"] = 14;
LoUI["14"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["14"]["AutomaticSize"] = Enum.AutomaticSize.X;
LoUI["14"]["Size"] = UDim2.new(0.7192937135696411, 0, 0.41530051827430725, 0);
LoUI["14"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["14"]["Text"] = [[PlayerName]];
LoUI["14"]["BackgroundTransparency"] = 1;
LoUI["14"]["Position"] = UDim2.new(0.23957718908786774, 0, 0.27320244908332825, 0);

-- LoUI.TopBar.ProfileMenu.UIListLayout
LoUI["15"] = Instance.new("UIListLayout", LoUI["c"]);
LoUI["15"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
LoUI["15"]["FillDirection"] = Enum.FillDirection.Horizontal;
LoUI["15"]["Padding"] = UDim.new(0.014999999664723873, 0);
LoUI["15"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

-- LoUI.TopBar.ProfileMenu.UIPadding
LoUI["16"] = Instance.new("UIPadding", LoUI["c"]);
LoUI["16"]["PaddingLeft"] = UDim.new(0.014000000432133675, 0);

-- LoUI.TopBar.ProfileMenu.Clock
LoUI["17"] = Instance.new("ImageButton", LoUI["c"]);
LoUI["17"]["BorderSizePixel"] = 0;
LoUI["17"]["AutoButtonColor"] = false;
LoUI["17"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["17"]["Size"] = UDim2.new(0.10328257083892822, 0, 0.682426393032074, 0);
LoUI["17"]["Name"] = [[Clock]];
LoUI["17"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["17"]["Position"] = UDim2.new(0.26031631231307983, 0, 0.158786803483963, 0);
createShadow().Parent = LoUI["17"]; -- Adicionado sombreamento

-- LoUI.TopBar.ProfileMenu.Clock.UICorner
LoUI["18"] = Instance.new("UICorner", LoUI["17"]);
LoUI["18"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

-- LoUI.TopBar.ProfileMenu.Clock.TextLabel
LoUI["1a"] = Instance.new("TextLabel", LoUI["17"]);
LoUI["1a"]["TextWrapped"] = true;
LoUI["1a"]["BorderSizePixel"] = 0;
LoUI["1a"]["TextScaled"] = true;
LoUI["1a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["1a"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
LoUI["1a"]["TextSize"] = 14;
LoUI["1a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["1a"]["AutomaticSize"] = Enum.AutomaticSize.X;
LoUI["1a"]["Size"] = UDim2.new(0.33195531368255615, 0, 0.41530051827430725, 0);
LoUI["1a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["1a"]["Text"] = [[00:00]];
LoUI["1a"]["BackgroundTransparency"] = 1;
LoUI["1a"]["Position"] = UDim2.new(0.21512815356254578, 0, 0.27320244908332825, 0);

-- LoUI.TopBar.ProfileMenu.Title
LoUI["1b"] = Instance.new("ImageButton", LoUI["c"]);
LoUI["1b"]["BorderSizePixel"] = 0;
LoUI["1b"]["AutoButtonColor"] = false;
LoUI["1b"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["1b"]["Size"] = UDim2.new(0.23481373488903046, 0, 0.682426393032074, 0);
LoUI["1b"]["Name"] = [[Title]];
LoUI["1b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["1b"]["Position"] = UDim2.new(0.015024710446596146, 0, 0.18421050906181335, 0);
createShadow().Parent = LoUI["1b"]; -- Adicionado sombreamento

-- LoUI.TopBar.ProfileMenu.Title.UICorner
LoUI["1c"] = Instance.new("UICorner", LoUI["1b"]);
LoUI["1c"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

-- LoUI.TopBar.ProfileMenu.Title.TextLabel
LoUI["1e"] = Instance.new("TextLabel", LoUI["1b"]);
LoUI["1e"]["TextWrapped"] = true;
LoUI["1e"]["BorderSizePixel"] = 0;
LoUI["1e"]["TextScaled"] = true;
LoUI["1e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["1e"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
LoUI["1e"]["TextSize"] = 14;
LoUI["1e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["1e"]["AutomaticSize"] = Enum.AutomaticSize.X;
LoUI["1e"]["Size"] = UDim2.new(0.7192937135696411, 0, 0.41530051827430725, 0);
LoUI["1e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["1e"]["Text"] = [[DarkRay]];
LoUI["1e"]["BackgroundTransparency"] = 1;
LoUI["1e"]["Position"] = UDim2.new(0.13402166962623596, 0, 0.27320244908332825, 0);

-- LoUI.TopBar.TopBarClose
LoUI["1f"] = Instance.new("TextButton", LoUI["2"]);
LoUI["1f"]["Active"] = false;
LoUI["1f"]["BorderSizePixel"] = 0;
LoUI["1f"]["AutoButtonColor"] = false;
LoUI["1f"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["1f"]["Selectable"] = false;
LoUI["1f"]["Size"] = UDim2.new(0.08402203768491745, 0, 0.4803149402141571, 0);
LoUI["1f"]["Name"] = [[TopBarClose]];
LoUI["1f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["1f"]["Text"] = [[]];
LoUI["1f"]["Position"] = UDim2.new(0.915977954864502, 0, 0.5196850299835205, 0);

-- LoUI.TopBar.TopBarClose.UICorner
LoUI["20"] = Instance.new("UICorner", LoUI["1f"]);
LoUI["20"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

-- LoUI.TopBar.TopBarClose.idk
LoUI["22"] = Instance.new("Frame", LoUI["1f"]);
LoUI["22"]["BorderSizePixel"] = 0;
LoUI["22"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["22"]["Size"] = UDim2.new(0.2622910141944885, 0, 1, 0);
LoUI["22"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["22"]["Position"] = UDim2.new(0.000002001152552111307, 0, 0, 0);
LoUI["22"]["Name"] = [[idk]];

-- LoUI.TopBar.TopBarClose.UIAspectRatioConstraint
LoUI["24"] = Instance.new("UIAspectRatioConstraint", LoUI["1f"]);

-- LoUI.TopBar.TopBarClose.ImageLabel
LoUI["25"] = Instance.new("ImageLabel", LoUI["1f"]);
LoUI["25"]["BorderSizePixel"] = 0;
LoUI["25"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["25"]["Image"] = [[rbxassetid://14122651741]];
LoUI["25"]["LayoutOrder"] = 1;
LoUI["25"]["Size"] = UDim2.new(0.5081987380981445, 0, 0.5971601009368896, 0);
LoUI["25"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["25"]["BackgroundTransparency"] = 1;
LoUI["25"]["Position"] = UDim2.new(0.24589963257312775, 0, 0.23339086771011353, 0);

-- LoUI.TopBar.TopBarClose.ImageLabel.UIAspectRatioConstraint
LoUI["26"] = Instance.new("UIAspectRatioConstraint", LoUI["25"]);
LoUI["26"]["AspectRatio"] = 0.9836804866790771;

-- LoUI.TopBar.UIAspectRatioConstraint
LoUI["27"] = Instance.new("UIAspectRatioConstraint", LoUI["2"]);
LoUI["27"]["AspectRatio"] = 5.724700927734375;

-- LoUI.MainBar
LoUI["28"] = Instance.new("Frame", LoUI["1"]);
LoUI["28"]["BorderSizePixel"] = 0;
LoUI["28"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["28"]["Size"] = UDim2.new(0.5404488444328308, 0, 0.5745577812194824, 0);
LoUI["28"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["28"]["Position"] = UDim2.new(0.23000000417232513, 0, -0.6119999885559082, 0);
LoUI["28"]["Name"] = [[MainBar]];
createShadow().Parent = LoUI["28"]; -- Adicionado sombreamento

-- LoUI.MainBar.UICorner
LoUI["29"] = Instance.new("UICorner", LoUI["28"]);
LoUI["29"]["CornerRadius"] = UDim.new(0.029999999329447746, 0);

-- LoUI.MainBar.UIAspectRatioConstraint
LoUI["2b"] = Instance.new("UIAspectRatioConstraint", LoUI["28"]);
LoUI["2b"]["AspectRatio"] = 1.7326968908309937;

-- LoUI.MainBar.Logo
LoUI["2e"] = Instance.new("ImageLabel", LoUI["28"]);
LoUI["2e"]["BorderSizePixel"] = 0;
LoUI["2e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["2e"]["Image"] = [[rbxassetid://14133403065]];
LoUI["2e"]["Size"] = UDim2.new(0.18741475045681, 0, 0.3247329592704773, 0);
LoUI["2e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["2e"]["Name"] = [[Logo]];
LoUI["2e"]["BackgroundTransparency"] = 1;
LoUI["2e"]["Position"] = UDim2.new(0.3991934061050415, 0, 0.33447495102882385, 0);

-- LoUI.Folder
LoUI["30"] = Instance.new("Folder", LoUI["1"]);

-- LoUI.Folder.TabReserved
LoUI["31"] = Instance.new("ScrollingFrame", LoUI["30"]);
LoUI["31"]["Active"] = true;
LoUI["31"]["BorderSizePixel"] = 0;
LoUI["31"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
LoUI["31"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["31"]["VerticalScrollBarPosition"] = Enum.VerticalScrollBarPosition.Left;
LoUI["31"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
LoUI["31"]["BackgroundTransparency"] = 1;
LoUI["31"]["Size"] = UDim2.new(1, 0, 0.9599999785423279, 0);
LoUI["31"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["31"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["31"]["ScrollBarThickness"] = 0;
LoUI["31"]["Position"] = UDim2.new(0, 0, 0.03999999910593033, 0);
LoUI["31"]["Visible"] = false;
LoUI["31"]["Name"] = [[TabReserved]];

-- LoUI.Folder.TabReserved.UIListLayout
LoUI["32"] = Instance.new("UIListLayout", LoUI["31"]);
LoUI["32"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
LoUI["32"]["Padding"] = UDim.new(0.014999999664723873, 0);
LoUI["32"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

-- LoUI.Folder.TabButtonReserved
LoUI["33"] = Instance.new("ImageButton", LoUI["30"]);
LoUI["33"]["BorderSizePixel"] = 0;
LoUI["33"]["AutoButtonColor"] = false;
LoUI["33"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["33"]["Size"] = UDim2.new(0.19896680116653442, 0, 0.6315789818763733, 0);
LoUI["33"]["Name"] = [[TabButtonReserved]];
LoUI["33"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["33"]["Visible"] = false;
LoUI["33"]["Position"] = UDim2.new(0.015000020153820515, 0, 0.18421050906181335, 0);
createShadow().Parent = LoUI["33"]; -- Adicionado sombreamento
createHoverStroke().Parent = LoUI["33"]; -- Adicionado efeito de hover

-- LoUI.Folder.TabButtonReserved.UICorner
LoUI["34"] = Instance.new("UICorner", LoUI["33"]);
LoUI["34"]["CornerRadius"] = UDim.new(0.30000001192092896, 0);

-- LoUI.Folder.TabButtonReserved.Frame
LoUI["35"] = Instance.new("Frame", LoUI["33"]);
LoUI["35"]["BorderSizePixel"] = 0;
LoUI["35"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["35"]["BackgroundTransparency"] = 1;
LoUI["35"]["LayoutOrder"] = 1;
LoUI["35"]["Size"] = UDim2.new(0.6113507151603699, 0, 1.0000001192092896, 0);
LoUI["35"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["35"]["Position"] = UDim2.new(0.26662877202033997, 0, -4.950767973355141e-08, 0);
LoUI["35"]["AutomaticSize"] = Enum.AutomaticSize.X;

-- LoUI.Folder.TabButtonReserved.Frame.TextLabel
LoUI["36"] = Instance.new("TextLabel", LoUI["35"]);
LoUI["36"]["TextWrapped"] = true;
LoUI["36"]["BorderSizePixel"] = 0;
LoUI["36"]["TextScaled"] = true;
LoUI["36"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["36"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LoUI["36"]["TextSize"] = 14;
LoUI["36"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["36"]["AutomaticSize"] = Enum.AutomaticSize.X;
LoUI["36"]["Size"] = UDim2.new(-0.145383819937706, 0, 0.415300577878952, 0);
LoUI["36"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["36"]["Text"] = [[Tab1]];
LoUI["36"]["BackgroundTransparency"] = 1;
LoUI["36"]["Position"] = UDim2.new(-1.2657674551010132, 0, 0.37021857500076294, 0);

-- LoUI.Folder.TabButtonReserved.Frame.UIListLayout
LoUI["37"] = Instance.new("UIListLayout", LoUI["35"]);
LoUI["37"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
LoUI["37"]["FillDirection"] = Enum.FillDirection.Horizontal;
LoUI["37"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
LoUI["37"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

-- LoUI.Folder.TabButtonReserved.ImageLabel
LoUI["39"] = Instance.new("ImageLabel", LoUI["33"]);
LoUI["39"]["BorderSizePixel"] = 0;
LoUI["39"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["39"]["Size"] = UDim2.new(0.19903095066547394, 0, 0.606557309627533, 0);
LoUI["39"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["39"]["BackgroundTransparency"] = 1;
LoUI["39"]["Position"] = UDim2.new(0.1134648397564888, 0, 0.19672130048274994, 0);

-- LoUI.Folder.TabButtonReserved.ImageLabel.UIAspectRatioConstraint
LoUI["3a"] = Instance.new("UIAspectRatioConstraint", LoUI["39"]);
LoUI["3a"]["AspectRatio"] = 0.9842342734336853;

-- LoUI.Folder.TabButtonReserved.UIListLayout
LoUI["3b"] = Instance.new("UIListLayout", LoUI["33"]);
LoUI["3b"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
LoUI["3b"]["FillDirection"] = Enum.FillDirection.Horizontal;
LoUI["3b"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

-- LoUI.Folder.TabButtonReserved.UIPadding
LoUI["3c"] = Instance.new("UIPadding", LoUI["33"]);
LoUI["3c"]["PaddingLeft"] = UDim.new(0.10999999940395355, 0);

-- LoUI.Folder.Dropdown
LoUI["3d"] = Instance.new("Frame", LoUI["30"]);
LoUI["3d"]["BorderSizePixel"] = 0;
LoUI["3d"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["3d"]["Size"] = UDim2.new(0.9614325165748596, 0, 0.2624756097793579, 0);
LoUI["3d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["3d"]["Position"] = UDim2.new(0.019283747300505638, 0, 0.12373435497283936, 0);
LoUI["3d"]["AutomaticSize"] = Enum.AutomaticSize.Y;
LoUI["3d"]["Visible"] = false;
LoUI["3d"]["Name"] = [[Dropdown]];
createShadow().Parent = LoUI["3d"]; -- Adicionado sombreamento

-- LoUI.Folder.Dropdown.UICorner
LoUI["3e"] = Instance.new("UICorner", LoUI["3d"]);
LoUI["3e"]["CornerRadius"] = UDim.new(0.03999999910593033, 0);

-- LoUI.Folder.Dropdown.Title
LoUI["40"] = Instance.new("TextLabel", LoUI["3d"]);
LoUI["40"]["TextWrapped"] = true;
LoUI["40"]["BorderSizePixel"] = 0;
LoUI["40"]["TextScaled"] = true;
LoUI["40"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["40"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LoUI["40"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LoUI["40"]["TextSize"] = 14;
LoUI["40"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["40"]["Size"] = UDim2.new(0.9656160473823547, 0, 0.19094853103160858, 0);
LoUI["40"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["40"]["Text"] = [[Dropdown]];
LoUI["40"]["Name"] = [[Title]];
LoUI["40"]["BackgroundTransparency"] = 1;
LoUI["40"]["Position"] = UDim2.new(0.017191976308822632, 0, 0.10911344736814499, 0);

-- LoUI.Folder.Dropdown.Description
LoUI["41"] = Instance.new("TextLabel", LoUI["3d"]);
LoUI["41"]["TextWrapped"] = true;
LoUI["41"]["BorderSizePixel"] = 0;
LoUI["41"]["TextScaled"] = true;
LoUI["41"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["41"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LoUI["41"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Italic);
LoUI["41"]["TextSize"] = 14;
LoUI["41"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["41"]["Size"] = UDim2.new(0.9656160473823547, 0, 0.15457738935947418, 0);
LoUI["41"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["41"]["Text"] = [[List of stuffs.]];
LoUI["41"]["Name"] = [[Description]];
LoUI["41"]["BackgroundTransparency"] = 1;
LoUI["41"]["Position"] = UDim2.new(0.011461317539215088, 0, 0.7547013759613037, 0);

-- LoUI.Folder.Dropdown.DropdownBar
LoUI["42"] = Instance.new("Frame", LoUI["3d"]);
LoUI["42"]["BorderSizePixel"] = 0;
LoUI["42"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["42"]["LayoutOrder"] = 10;
LoUI["42"]["Size"] = UDim2.new(0.9684813618659973, 0, 0.29096919298171997, 0);
LoUI["42"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["42"]["Position"] = UDim2.new(0.014326647855341434, 0, 0.34552592039108276, 0);
LoUI["42"]["Name"] = [[DropdownBar]];

-- LoUI.Folder.Dropdown.DropdownBar.UICorner
LoUI["43"] = Instance.new("UICorner", LoUI["42"]);
LoUI["43"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

-- LoUI.Folder.Dropdown.DropdownBar.Icon
LoUI["46"] = Instance.new("ImageLabel", LoUI["42"]);
LoUI["46"]["BorderSizePixel"] = 0;
LoUI["46"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["46"]["Image"] = [[rbxassetid://14122651741]];
LoUI["46"]["Size"] = UDim2.new(0.028106508776545525, 0, 0.59375, 0);
LoUI["46"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["46"]["Name"] = [[Icon]];
LoUI["46"]["Rotation"] = 180;
LoUI["46"]["BackgroundTransparency"] = 1;
LoUI["46"]["Position"] = UDim2.new(0.9589999914169312, 0, 0.21899999678134918, 0);

-- LoUI.Folder.Dropdown.DropdownBar.Icon.UIAspectRatioConstraint
LoUI["47"] = Instance.new("UIAspectRatioConstraint", LoUI["46"]);

-- LoUI.Folder.Dropdown.DropdownBar.Open
LoUI["48"] = Instance.new("TextLabel", LoUI["42"]);
LoUI["48"]["TextWrapped"] = true;
LoUI["48"]["BorderSizePixel"] = 0;
LoUI["48"]["TextScaled"] = true;
LoUI["48"]["BackgroundColor3"] = Color3.fromRGB(220, 160, 190);
LoUI["48"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LoUI["48"]["TextStrokeColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["48"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["48"]["Size"] = UDim2.new(1, 0, 0.59375, 0);
LoUI["48"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["48"]["Text"] = [[none]];
LoUI["48"]["Name"] = [[Open]];
LoUI["48"]["BackgroundTransparency"] = 1;
LoUI["48"]["Position"] = UDim2.new(0, 0, 0.21875, 0);

-- LoUI.Folder.Dropdown.DropdownBar.Trigger
LoUI["49"] = Instance.new("TextButton", LoUI["42"]);
LoUI["49"]["BorderSizePixel"] = 0;
LoUI["49"]["AutoButtonColor"] = false;
LoUI["49"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["49"]["Selectable"] = false;
LoUI["49"]["Size"] = UDim2.new(1, 0, 1, 0);
LoUI["49"]["LayoutOrder"] = 10;
LoUI["49"]["Name"] = [[Trigger]];
LoUI["49"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["49"]["Text"] = [[]];
LoUI["49"]["BackgroundTransparency"] = 1;

-- LoUI.Folder.Dropdown.Box
LoUI["4a"] = Instance.new("Frame", LoUI["3d"]);
LoUI["4a"]["BorderSizePixel"] = 0;
LoUI["4a"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["4a"]["LayoutOrder"] = 10;
LoUI["4a"]["Size"] = UDim2.new(0.9700000286102295, 0, 0, 0);
LoUI["4a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["4a"]["Position"] = UDim2.new(0.014326647855341434, 0, 0.6362887620925903, 0);
LoUI["4a"]["Visible"] = false;
LoUI["4a"]["Name"] = [[Box]];

-- LoUI.Folder.Dropdown.Box.UICorner
LoUI["4d"] = Instance.new("UICorner", LoUI["4a"]);
LoUI["4d"]["CornerRadius"] = UDim.new(0.05999999865889549, 0);

-- LoUI.Folder.Dropdown.Box.ScrollingFrame
LoUI["4e"] = Instance.new("ScrollingFrame", LoUI["4a"]);
LoUI["4e"]["Active"] = true;
LoUI["4e"]["ScrollingDirection"] = Enum.ScrollingDirection.Y;
LoUI["4e"]["BorderSizePixel"] = 0;
LoUI["4e"]["CanvasSize"] = UDim2.new(0, 0, 0.10000000149011612, 0);
LoUI["4e"]["MidImage"] = [[]];
LoUI["4e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["4e"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
LoUI["4e"]["BackgroundTransparency"] = 1;
LoUI["4e"]["Size"] = UDim2.new(1, 0, 1, 0);
LoUI["4e"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["4e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["4e"]["ScrollBarThickness"] = 0;

-- LoUI.Folder.Dropdown.Box.ScrollingFrame.UIListLayout
LoUI["4f"] = Instance.new("UIListLayout", LoUI["4e"]);
LoUI["4f"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
LoUI["4f"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

-- LoUI.Folder.Keybind
LoUI["50"] = Instance.new("Frame", LoUI["30"]);
LoUI["50"]["Active"] = true;
LoUI["50"]["BorderSizePixel"] = 0;
LoUI["50"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["50"]["Size"] = UDim2.new(0.9614325165748596, 0, 0.2624756097793579, 0);
LoUI["50"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["50"]["Position"] = UDim2.new(0.019283747300505638, 0, 0.12373435497283936, 0);
LoUI["50"]["Visible"] = false;
LoUI["50"]["Name"] = [[Keybind]];
createShadow().Parent = LoUI["50"]; -- Adicionado sombreamento

-- LoUI.Folder.Keybind.UICorner
LoUI["51"] = Instance.new("UICorner", LoUI["50"]);
LoUI["51"]["CornerRadius"] = UDim.new(0.03999999910593033, 0);

-- LoUI.Folder.Keybind.Title
LoUI["53"] = Instance.new("TextLabel", LoUI["50"]);
LoUI["53"]["TextWrapped"] = true;
LoUI["53"]["BorderSizePixel"] = 0;
LoUI["53"]["TextScaled"] = true;
LoUI["53"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["53"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LoUI["53"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LoUI["53"]["TextSize"] = 14;
LoUI["53"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["53"]["Size"] = UDim2.new(0.9656160473823547, 0, 0.19094853103160858, 0);
LoUI["53"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["53"]["Text"] = [[Keybind]];
LoUI["53"]["Name"] = [[Title]];
LoUI["53"]["BackgroundTransparency"] = 1;
LoUI["53"]["Position"] = UDim2.new(0.017191976308822632, 0, 0.10911344736814499, 0);

-- LoUI.Folder.Keybind.Description
LoUI["54"] = Instance.new("TextLabel", LoUI["50"]);
LoUI["54"]["TextWrapped"] = true;
LoUI["54"]["BorderSizePixel"] = 0;
LoUI["54"]["TextScaled"] = true;
LoUI["54"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["54"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LoUI["54"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Italic);
LoUI["54"]["TextSize"] = 14;
LoUI["54"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["54"]["Size"] = UDim2.new(0.9656160473823547, 0, 0.15457738935947418, 0);
LoUI["54"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["54"]["Text"] = [[Press this square and enter any key to bind!]];
LoUI["54"]["Name"] = [[Description]];
LoUI["54"]["BackgroundTransparency"] = 1;
LoUI["54"]["Position"] = UDim2.new(0.012893982231616974, 0, 0.7092373967170715, 0);

-- LoUI.Folder.Keybind.Bind
LoUI["55"] = Instance.new("Frame", LoUI["50"]);
LoUI["55"]["Active"] = true;
LoUI["55"]["BorderSizePixel"] = 0;
LoUI["55"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["55"]["Size"] = UDim2.new(0.14899714291095734, 0, 0.29096919298171997, 0);
LoUI["55"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["55"]["Position"] = UDim2.new(0.014326647855341434, 0, 0.34552592039108276, 0);
LoUI["55"]["Name"] = [[Bind]];

-- LoUI.Folder.Keybind.Bind.UICorner
LoUI["56"] = Instance.new("UICorner", LoUI["55"]);
LoUI["56"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

-- LoUI.Folder.Keybind.Bind.Button
LoUI["59"] = Instance.new("TextButton", LoUI["55"]);
LoUI["59"]["TextWrapped"] = true;
LoUI["59"]["ZIndex"] = 5;
LoUI["59"]["BorderSizePixel"] = 0;
LoUI["59"]["TextStrokeColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["59"]["TextScaled"] = true;
LoUI["59"]["BackgroundColor3"] = Color3.fromRGB(220, 160, 190);
LoUI["59"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Italic);
LoUI["59"]["TextColor3"] = Color3.fromRGB(160, 160, 160);
LoUI["59"]["Selectable"] = false;
LoUI["59"]["Size"] = UDim2.new(1, 0, 0.59375, 0);
LoUI["59"]["Name"] = [[Button]];
LoUI["59"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["59"]["Text"] = [[key]];
LoUI["59"]["Position"] = UDim2.new(0, 0, 0.21875, 0);
LoUI["59"]["BackgroundTransparency"] = 0.9900000095367432;

-- LoUI.Folder.Label
LoUI["5a"] = Instance.new("Frame", LoUI["30"]);
LoUI["5a"]["BorderSizePixel"] = 0;
LoUI["5a"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["5a"]["Size"] = UDim2.new(0.9614325165748596, 0, 0.07873434573411942, 0);
LoUI["5a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["5a"]["Position"] = UDim2.new(0.019283747300505638, 0, 0.01806684397161007, 0);
LoUI["5a"]["AutomaticSize"] = Enum.AutomaticSize.Y;
LoUI["5a"]["Visible"] = false;
LoUI["5a"]["Name"] = [[Label]];
createShadow().Parent = LoUI["5a"]; -- Adicionado sombreamento

-- LoUI.Folder.Label.UICorner
LoUI["5b"] = Instance.new("UICorner", LoUI["5a"]);
LoUI["5b"]["CornerRadius"] = UDim.new(0.33000001311302185, 0);

-- LoUI.Folder.Label.Title
LoUI["5d"] = Instance.new("TextLabel", LoUI["5a"]);
LoUI["5d"]["TextWrapped"] = true;
LoUI["5d"]["BorderSizePixel"] = 0;
LoUI["5d"]["TextScaled"] = true;
LoUI["5d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["5d"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LoUI["5d"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LoUI["5d"]["TextSize"] = 14;
LoUI["5d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["5d"]["Size"] = UDim2.new(0.9668599367141724, 0, 0.5928126573562622, 0);
LoUI["5d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["5d"]["Text"] = [[This is a Label]];
LoUI["5d"]["Name"] = [[Title]];
LoUI["5d"]["BackgroundTransparency"] = 1;
LoUI["5d"]["Position"] = UDim2.new(0.018000036478042603, 0, 0.22100010514259338, 0);

-- LoUI.Folder.Slider
LoUI["5e"] = Instance.new("Frame", LoUI["30"]);
LoUI["5e"]["BorderSizePixel"] = 0;
LoUI["5e"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["5e"]["Size"] = UDim2.new(0.9614325165748596, 0, 0.2624756097793579, 0);
LoUI["5e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["5e"]["Position"] = UDim2.new(0.019283747300505638, 0, 0.12373435497283936, 0);
LoUI["5e"]["Visible"] = false;
LoUI["5e"]["Name"] = [[Slider]];
createShadow().Parent = LoUI["5e"]; -- Adicionado sombreamento

-- LoUI.Folder.Slider.UICorner
LoUI["5f"] = Instance.new("UICorner", LoUI["5e"]);
LoUI["5f"]["CornerRadius"] = UDim.new(0.03999999910593033, 0);

-- LoUI.Folder.Slider.Title
LoUI["61"] = Instance.new("TextLabel", LoUI["5e"]);
LoUI["61"]["TextWrapped"] = true;
LoUI["61"]["BorderSizePixel"] = 0;
LoUI["61"]["TextScaled"] = true;
LoUI["61"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["61"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LoUI["61"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LoUI["61"]["TextSize"] = 14;
LoUI["61"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["61"]["Size"] = UDim2.new(0.9656160473823547, 0, 0.19094853103160858, 0);
LoUI["61"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["61"]["Text"] = [[Speed]];
LoUI["61"]["Name"] = [[Title]];
LoUI["61"]["BackgroundTransparency"] = 1;
LoUI["61"]["Position"] = UDim2.new(0.017191976308822632, 0, 0.10911344736814499, 0);

-- LoUI.Folder.Slider.ActualSlider
LoUI["62"] = Instance.new("Frame", LoUI["5e"]);
LoUI["62"]["BorderSizePixel"] = 0;
LoUI["62"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["62"]["Size"] = UDim2.new(0.9684813618659973, 0, 0.29096919298171997, 0);
LoUI["62"]["ClipsDescendants"] = true;
LoUI["62"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["62"]["Position"] = UDim2.new(0.014326647855341434, 0, 0.34552592039108276, 0);
LoUI["62"]["Name"] = [[ActualSlider]];

-- LoUI.Folder.Slider.ActualSlider.UICorner
LoUI["63"] = Instance.new("UICorner", LoUI["62"]);
LoUI["63"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

-- LoUI.Folder.Slider.ActualSlider.Fill
LoUI["66"] = Instance.new("Frame", LoUI["62"]);
LoUI["66"]["BorderSizePixel"] = 0;
LoUI["66"]["BackgroundColor3"] = Color3.fromRGB(220, 160, 190);
LoUI["66"]["Size"] = UDim2.new(1, 0, 1, 0);
LoUI["66"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["66"]["Position"] = UDim2.new(-0.0010000000474974513, 0, 0.029999999329447746, 0);
LoUI["66"]["Name"] = [[Fill]];

-- LoUI.Folder.Slider.ActualSlider.Fill.UICorner
LoUI["67"] = Instance.new("UICorner", LoUI["66"]);
LoUI["67"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

-- LoUI.Folder.Slider.ActualSlider.Trigger
LoUI["69"] = Instance.new("TextButton", LoUI["62"]);
LoUI["69"]["BorderSizePixel"] = 0;
LoUI["69"]["AutoButtonColor"] = false;
LoUI["69"]["BackgroundColor3"] = Color3.fromRGB(220, 160, 190);
LoUI["69"]["Selectable"] = false;
LoUI["69"]["Size"] = UDim2.new(1, 0, 1, 0);
LoUI["69"]["LayoutOrder"] = 5;
LoUI["69"]["Name"] = [[Trigger]];
LoUI["69"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["69"]["Text"] = [[]];
LoUI["69"]["Position"] = UDim2.new(-0.0010000000474974513, 0, 0.029999999329447746, 0);
LoUI["69"]["BackgroundTransparency"] = 1;

-- LoUI.Folder.Slider.ActualSlider.Trigger.UICorner
LoUI["6a"] = Instance.new("UICorner", LoUI["69"]);
LoUI["6a"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

-- LoUI.Folder.Slider.ActualSlider.Title
LoUI["6c"] = Instance.new("TextLabel", LoUI["62"]);
LoUI["6c"]["TextWrapped"] = true;
LoUI["6c"]["BorderSizePixel"] = 0;
LoUI["6c"]["TextScaled"] = true;
LoUI["6c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["6c"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LoUI["6c"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LoUI["6c"]["TextSize"] = 14;
LoUI["6c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["6c"]["LayoutOrder"] = 3;
LoUI["6c"]["Size"] = UDim2.new(0.9582196474075317, 0, 0.5971987247467041, 0);
LoUI["6c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["6c"]["Text"] = [[100]];
LoUI["6c"]["Name"] = [[Title]];
LoUI["6c"]["BackgroundTransparency"] = 1;
LoUI["6c"]["Position"] = UDim2.new(0.023000000044703484, 0, 0.23100000619888306, 0);

-- LoUI.Folder.Slider.Description
LoUI["6d"] = Instance.new("TextLabel", LoUI["5e"]);
LoUI["6d"]["TextWrapped"] = true;
LoUI["6d"]["BorderSizePixel"] = 0;
LoUI["6d"]["TextScaled"] = true;
LoUI["6d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["6d"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LoUI["6d"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Italic);
LoUI["6d"]["TextSize"] = 14;
LoUI["6d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["6d"]["Size"] = UDim2.new(0.9656160473823547, 0, 0.15457738935947418, 0);
LoUI["6d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["6d"]["Text"] = [[Changes your walkspeed.]];
LoUI["6d"]["Name"] = [[Description]];
LoUI["6d"]["BackgroundTransparency"] = 1;
LoUI["6d"]["Position"] = UDim2.new(0.015759311616420746, 0, 0.7274229526519775, 0);

-- LoUI.Folder.Textbox
LoUI["6e"] = Instance.new("Frame", LoUI["30"]);
LoUI["6e"]["BorderSizePixel"] = 0;
LoUI["6e"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["6e"]["Size"] = UDim2.new(0.9614325165748596, 0, 0.2624756097793579, 0);
LoUI["6e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["6e"]["Position"] = UDim2.new(0.019283747300505638, 0, 0.12373435497283936, 0);
LoUI["6e"]["Visible"] = false;
LoUI["6e"]["Name"] = [[Textbox]];
createShadow().Parent = LoUI["6e"]; -- Adicionado sombreamento

-- LoUI.Folder.Textbox.UICorner
LoUI["6f"] = Instance.new("UICorner", LoUI["6e"]);
LoUI["6f"]["CornerRadius"] = UDim.new(0.03999999910593033, 0);

-- LoUI.Folder.Textbox.Title
LoUI["71"] = Instance.new("TextLabel", LoUI["6e"]);
LoUI["71"]["TextWrapped"] = true;
LoUI["71"]["BorderSizePixel"] = 0;
LoUI["71"]["TextScaled"] = true;
LoUI["71"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["71"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LoUI["71"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LoUI["71"]["TextSize"] = 14;
LoUI["71"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["71"]["Size"] = UDim2.new(0.9656160473823547, 0, 0.19094853103160858, 0);
LoUI["71"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["71"]["Text"] = [[Textbox]];
LoUI["71"]["Name"] = [[Title]];
LoUI["71"]["BackgroundTransparency"] = 1;
LoUI["71"]["Position"] = UDim2.new(0.017191976308822632, 0, 0.10911344736814499, 0);

-- LoUI.Folder.Textbox.Description
LoUI["72"] = Instance.new("TextLabel", LoUI["6e"]);
LoUI["72"]["TextWrapped"] = true;
LoUI["72"]["BorderSizePixel"] = 0;
LoUI["72"]["TextScaled"] = true;
LoUI["72"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["72"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LoUI["72"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Italic);
LoUI["72"]["TextSize"] = 14;
LoUI["72"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["72"]["Size"] = UDim2.new(0.9656160473823547, 0, 0.15457738935947418, 0);
LoUI["72"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["72"]["Text"] = [[Input and yeah.]];
LoUI["72"]["Name"] = [[Description]];
LoUI["72"]["BackgroundTransparency"] = 1;
LoUI["72"]["Position"] = UDim2.new(0.012893982231616974, 0, 0.7092373967170715, 0);

-- LoUI.Folder.Textbox.TextboxBar
LoUI["73"] = Instance.new("Frame", LoUI["6e"]);
LoUI["73"]["BorderSizePixel"] = 0;
LoUI["73"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["73"]["Size"] = UDim2.new(0.9684813618659973, 0, 0.29096919298171997, 0);
LoUI["73"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["73"]["Position"] = UDim2.new(0.014326647855341434, 0, 0.34552592039108276, 0);
LoUI["73"]["Name"] = [[TextboxBar]];

-- LoUI.Folder.Textbox.TextboxBar.UICorner
LoUI["74"] = Instance.new("UICorner", LoUI["73"]);
LoUI["74"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

-- LoUI.Folder.Textbox.TextboxBar.ActualTextbox
LoUI["77"] = Instance.new("TextBox", LoUI["73"]);
LoUI["77"]["PlaceholderColor3"] = Color3.fromRGB(155, 155, 155);
LoUI["77"]["BorderSizePixel"] = 0;
LoUI["77"]["TextWrapped"] = true;
LoUI["77"]["TextStrokeColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["77"]["TextScaled"] = true;
LoUI["77"]["BackgroundColor3"] = Color3.fromRGB(220, 160, 190);
LoUI["77"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["77"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Italic);
LoUI["77"]["BackgroundTransparency"] = 1;
LoUI["77"]["PlaceholderText"] = [[Input Here...]];
LoUI["77"]["Size"] = UDim2.new(1, 0, 0.59375, 0);
LoUI["77"]["Selectable"] = false;
LoUI["77"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["77"]["Text"] = [[]];
LoUI["77"]["Position"] = UDim2.new(0, 0, 0.21875, 0);
LoUI["77"]["Name"] = [[ActualTextbox]];

-- LoUI.Folder.Toggle
LoUI["78"] = Instance.new("Frame", LoUI["30"]);
LoUI["78"]["Active"] = true;
LoUI["78"]["BorderSizePixel"] = 0;
LoUI["78"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["78"]["Size"] = UDim2.new(0.9614325165748596, 0, 0.15495234727859497, 0);
LoUI["78"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["78"]["Position"] = UDim2.new(0.019283747300505638, 0, 0.6786856055259705, 0);
LoUI["78"]["Visible"] = false;
LoUI["78"]["Name"] = [[Toggle]];
createShadow().Parent = LoUI["78"]; -- Adicionado sombreamento
createHoverStroke().Parent = LoUI["78"]; -- Adicionado efeito de hover

-- LoUI.Folder.Toggle.UICorner
LoUI["79"] = Instance.new("UICorner", LoUI["78"]);
LoUI["79"]["CornerRadius"] = UDim.new(0.03999999910593033, 0);

-- LoUI.Folder.Toggle.Title
LoUI["7b"] = Instance.new("TextLabel", LoUI["78"]);
LoUI["7b"]["TextWrapped"] = true;
LoUI["7b"]["BorderSizePixel"] = 0;
LoUI["7b"]["RichText"] = true;
LoUI["7b"]["TextScaled"] = true;
LoUI["7b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["7b"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LoUI["7b"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LoUI["7b"]["TextSize"] = 14;
LoUI["7b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["7b"]["Size"] = UDim2.new(0.9656160473823547, 0, 0.323449969291687, 0);
LoUI["7b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["7b"]["Text"] = [[Toggle]];
LoUI["7b"]["Name"] = [[Title]];
LoUI["7b"]["BackgroundTransparency"] = 1;
LoUI["7b"]["Position"] = UDim2.new(0.015759311616420746, 0, 0.18482854962348938, 0);

-- LoUI.Folder.Toggle.Description
LoUI["7c"] = Instance.new("TextLabel", LoUI["78"]);
LoUI["7c"]["TextWrapped"] = true;
LoUI["7c"]["BorderSizePixel"] = 0;
LoUI["7c"]["TextScaled"] = true;
LoUI["7c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["7c"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LoUI["7c"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Italic);
LoUI["7c"]["TextSize"] = 14;
LoUI["7c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["7c"]["Size"] = UDim2.new(0.9656160473823547, 0, 0.26184046268463135, 0);
LoUI["7c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["7c"]["Text"] = [[Toggle I and O xd]];
LoUI["7c"]["Name"] = [[Description]];
LoUI["7c"]["BackgroundTransparency"] = 1;
LoUI["7c"]["Position"] = UDim2.new(0.011461318470537663, 0, 0.5852904319763184, 0);

-- LoUI.Folder.Toggle.Label
LoUI["7d"] = Instance.new("Frame", LoUI["78"]);
LoUI["7d"]["BorderSizePixel"] = 0;
LoUI["7d"]["BackgroundColor3"] = Color3.fromRGB(220, 160, 190);
LoUI["7d"]["Size"] = UDim2.new(0.03868212550878525, 0, 0.42860323190689087, 0);
LoUI["7d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["7d"]["Position"] = UDim2.new(0.92550128698349, 0, 0.27990657091140747, 0);
LoUI["7d"]["AutomaticSize"] = Enum.AutomaticSize.Y;
LoUI["7d"]["Name"] = [[Label]];

-- LoUI.Folder.Toggle.Label.UICorner
LoUI["7e"] = Instance.new("UICorner", LoUI["7d"]);
LoUI["7e"]["CornerRadius"] = UDim.new(0.33000001311302185, 0);

-- LoUI.Folder.Toggle.Label.Label
LoUI["81"] = Instance.new("TextButton", LoUI["7d"]);
LoUI["81"]["BorderSizePixel"] = 0;
LoUI["81"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["81"]["Selectable"] = false;
LoUI["81"]["Size"] = UDim2.new(1, 0, 1, 0);
LoUI["81"]["Name"] = [[Label]];
LoUI["81"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["81"]["Text"] = [[]];
LoUI["81"]["AutomaticSize"] = Enum.AutomaticSize.Y;
LoUI["81"]["BackgroundTransparency"] = 1;

-- LoUI.Folder.Toggle.Label.Label.UICorner
LoUI["82"] = Instance.new("UICorner", LoUI["81"]);
LoUI["82"]["CornerRadius"] = UDim.new(0.33000001311302185, 0);

-- LoUI.Folder.Button
LoUI["84"] = Instance.new("TextButton", LoUI["30"]);
LoUI["84"]["BorderSizePixel"] = 0;
LoUI["84"]["AutoButtonColor"] = false;
LoUI["84"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["84"]["Selectable"] = false;
LoUI["84"]["Visible"] = false;
LoUI["84"]["Size"] = UDim2.new(0.9614325165748596, 0, 0.15495234727859497, 0);
LoUI["84"]["Name"] = [[Button]];
LoUI["84"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["84"]["Text"] = [[]];
LoUI["84"]["Position"] = UDim2.new(0.019283747300505638, 0, 0.6786856055259705, 0);
createShadow().Parent = LoUI["84"]; -- Adicionado sombreamento
createHoverStroke().Parent = LoUI["84"]; -- Adicionado efeito de hover

-- LoUI.Folder.Button.UICorner
LoUI["85"] = Instance.new("UICorner", LoUI["84"]);
LoUI["85"]["CornerRadius"] = UDim.new(0.03999999910593033, 0);

-- LoUI.Folder.Button.Title
LoUI["87"] = Instance.new("TextLabel", LoUI["84"]);
LoUI["87"]["TextWrapped"] = true;
LoUI["87"]["BorderSizePixel"] = 0;
LoUI["87"]["RichText"] = true;
LoUI["87"]["TextScaled"] = true;
LoUI["87"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["87"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LoUI["87"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LoUI["87"]["TextSize"] = 14;
LoUI["87"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["87"]["Size"] = UDim2.new(0.9656160473823547, 0, 0.323449969291687, 0);
LoUI["87"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["87"]["Text"] = [[Button]];
LoUI["87"]["Name"] = [[Title]];
LoUI["87"]["BackgroundTransparency"] = 1;
LoUI["87"]["Position"] = UDim2.new(0.015759311616420746, 0, 0.18482854962348938, 0);

-- LoUI.Folder.Button.Description
LoUI["88"] = Instance.new("TextLabel", LoUI["84"]);
LoUI["88"]["TextWrapped"] = true;
LoUI["88"]["BorderSizePixel"] = 0;
LoUI["88"]["TextScaled"] = true;
LoUI["88"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["88"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LoUI["88"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Italic);
LoUI["88"]["TextSize"] = 14;
LoUI["88"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["88"]["Size"] = UDim2.new(0.9656160473823547, 0, 0.26184046268463135, 0);
LoUI["88"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["88"]["Text"] = [[Hello! i'm a button :D]];
LoUI["88"]["Name"] = [[Description]];
LoUI["88"]["BackgroundTransparency"] = 1;
LoUI["88"]["Position"] = UDim2.new(0.011461318470537663, 0, 0.5852904319763184, 0);

-- LoUI.Folder.DropdownButton
LoUI["89"] = Instance.new("TextButton", LoUI["30"]);
LoUI["89"]["Active"] = false;
LoUI["89"]["BorderSizePixel"] = 0;
LoUI["89"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["89"]["Selectable"] = false;
LoUI["89"]["Visible"] = false;
LoUI["89"]["Size"] = UDim2.new(0.9995859265327454, 0, 0.17368526756763458, 0);
LoUI["89"]["Name"] = [[DropdownButton]];
LoUI["89"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["89"]["Position"] = UDim2.new(0.08656254410743713, 0, 0, 0);
createHoverStroke().Parent = LoUI["89"]; -- Adicionado efeito de hover

-- LoUI.Folder.DropdownButton.UICorner
LoUI["8a"] = Instance.new("UICorner", LoUI["89"]);
LoUI["8a"]["CornerRadius"] = UDim.new(0.20000000298023224, 0);

-- LoUI.Folder.DropdownButton.name
LoUI["8d"] = Instance.new("TextLabel", LoUI["89"]);
LoUI["8d"]["TextWrapped"] = true;
LoUI["8d"]["BorderSizePixel"] = 0;
LoUI["8d"]["TextScaled"] = true;
LoUI["8d"]["BackgroundColor3"] = Color3.fromRGB(220, 160, 190);
LoUI["8d"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LoUI["8d"]["TextStrokeColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["8d"]["TextColor3"] = Color3.fromRGB(160, 160, 160);
LoUI["8d"]["Size"] = UDim2.new(1, 0, 0.59375, 0);
LoUI["8d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["8d"]["Text"] = [[none]];
LoUI["8d"]["Name"] = [[name]];
LoUI["8d"]["BackgroundTransparency"] = 1;
LoUI["8d"]["Position"] = UDim2.new(0, 0, 0.21875, 0);

-- LoUI.Button
LoUI["8e"] = Instance.new("TextButton", LoUI["1"]);
LoUI["8e"]["BorderSizePixel"] = 0;
LoUI["8e"]["AutoButtonColor"] = false;
LoUI["8e"]["BackgroundColor3"] = Color3.fromRGB(21, 0, 21); -- Cor principal alterada
LoUI["8e"]["Selectable"] = false;
LoUI["8e"]["Visible"] = false;
LoUI["8e"]["Size"] = UDim2.new(0.9614325165748596, 0, 0.15495234727859497, 0);
LoUI["8e"]["Name"] = [[Button]];
LoUI["8e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["8e"]["Text"] = [[]];
LoUI["8e"]["Position"] = UDim2.new(0.019283747300505638, 0, 0.6786856055259705, 0);

-- LoUI.Button.UICorner
LoUI["8f"] = Instance.new("UICorner", LoUI["8e"]);
LoUI["8f"]["CornerRadius"] = UDim.new(0.03999999910593033, 0);

-- LoUI.Button.Title
LoUI["91"] = Instance.new("TextLabel", LoUI["8e"]);
LoUI["91"]["TextWrapped"] = true;
LoUI["91"]["BorderSizePixel"] = 0;
LoUI["91"]["RichText"] = true;
LoUI["91"]["TextScaled"] = true;
LoUI["91"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["91"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LoUI["91"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
LoUI["91"]["TextSize"] = 14;
LoUI["91"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["91"]["Size"] = UDim2.new(0.9656160473823547, 0, 0.323449969291687, 0);
LoUI["91"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["91"]["Text"] = [[Button]];
LoUI["91"]["Name"] = [[Title]];
LoUI["91"]["BackgroundTransparency"] = 1;
LoUI["91"]["Position"] = UDim2.new(0.015759311616420746, 0, 0.18482854962348938, 0);

-- LoUI.Button.Description
LoUI["92"] = Instance.new("TextLabel", LoUI["8e"]);
LoUI["92"]["TextWrapped"] = true;
LoUI["92"]["BorderSizePixel"] = 0;
LoUI["92"]["TextScaled"] = true;
LoUI["92"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["92"]["TextXAlignment"] = Enum.TextXAlignment.Left;
LoUI["92"]["FontFace"] = Font.new([[rbxassetid://11702779517]], Enum.FontWeight.Regular, Enum.FontStyle.Italic);
LoUI["92"]["TextSize"] = 14;
LoUI["92"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
LoUI["92"]["Size"] = UDim2.new(0.9656160473823547, 0, 0.26184046268463135, 0);
LoUI["92"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
LoUI["92"]["Text"] = [[Hello! i'm a button :D]];
LoUI["92"]["Name"] = [[Description]];
LoUI["92"]["BackgroundTransparency"] = 1;
LoUI["92"]["Position"] = UDim2.new(0.011461318470537663, 0, 0.5852904319763184, 0);

-- LoUI.Library
LoUI["93"] = Instance.new("ModuleScript", LoUI["1"]);
LoUI["93"]["Name"] = [[Library]];

-- Require LoUI wrapper
local LoUI_REQUIRE = require;
local LoUI_MODULES = {};
local function require(Module:ModuleScript)
    local ModuleState = LoUI_MODULES[Module];
    if ModuleState then
        if not ModuleState.Required then
            ModuleState.Required = true;
            ModuleState.Value = ModuleState.Closure();
        end
        return ModuleState.Value;
    end;
    return LoUI_REQUIRE(Module);
end

LoUI_MODULES[LoUI["93"]] = {
Closure = function()
    local script = LoUI["93"];
local UILIB = {}
local parent  = script.Parent
local reserved = parent.Folder
UILIB.__index = UILIB

local listening = false
local twServ = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
-- SET YOUR THEME HERE
local GlobalColor1 = Color3.fromRGB(21, 0, 21) -- Main Color (Cor principal alterada)
local GlobalColor2 = Color3.fromRGB(220, 160, 190) -- Highlight Color
local closed = false

parent.TopBar.ProfileMenu.PlayerProfile.TextLabel.Text = game:GetService("Players").LocalPlayer.DisplayName
parent.TopBar.ProfileMenu.PlayerProfile.ImageLabel.Image = game:GetService("Players"):GetUserThumbnailAsync(game.Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)


function UILIB:Load(name, img, direction)
	local self = setmetatable({}, UILIB)
	task.spawn(function()
			-- Animações de entrada suavizadas
			local tw = twServ:Create(parent.MainBar, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Position = UDim2.new(0.23, 0,0.212, 0) })
			local tw2 = twServ:Create(parent.TopBar, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Position = UDim2.new(0.23, 0,0.012, 0) })
			tw:Play()
			tw.Completed:Wait()
			task.wait(0.1)
			tw2:Play()
	end)
        task.spawn(function()
	     while true do
		task.wait(0.1)
		parent.TopBar.ProfileMenu.Clock.TextLabel.Text = os.date("%H:%m")
	     end
        end)
	parent.TopBar.ProfileMenu.Title.TextLabel.Text = name
	if img then
		parent.MainBar.Logo.Image = img
	elseif img == "Default" then

	else
		parent.MainBar.Logo.Image = ""
		end

	local function setupButtonAnimation(button)
		local stroke = button:FindFirstChildOfClass("UIStroke")
		if not stroke then return end

		button.MouseEnter:Connect(function()
			stroke.Enabled = true
		end)
		button.MouseLeave:Connect(function()
			stroke.Enabled = false
		end)
		button.MouseButton1Down:Connect(function()
			twServ:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {Size = button.Size - UDim2.fromScale(0.01, 0.01)}):Play()
		end)
		button.MouseButton1Up:Connect(function()
			twServ:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {Size = button.Size + UDim2.fromScale(0.01, 0.01)}):Play()
		end)
	end

	parent.TopBar.TopBarClose.MouseButton1Click:Connect(function()
		if closed == false then
			closed = true
			local tw = twServ:Create(parent.MainBar, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Position = UDim2.new(0.23, 0,-0.612, 0) })
			local tw3 = twServ:Create(parent.TopBar.TopBarClose, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { Position = UDim2.new(0.916, 0,0.95, 0) })
			local tw2 = twServ:Create(parent.TopBar, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Position = UDim2.new(0.23, 0,-0.173, 0) })
			local twRotate = twServ:Create(parent.TopBar.TopBarClose.ImageLabel, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { Rotation = 180 })

			tw:Play()
			tw.Completed:Wait()
			tw2:Play()
			task.wait(0.1)
			twRotate:Play()
			tw3:Play()
			
		elseif closed == true then
			closed = false
			local tw = twServ:Create(parent.MainBar, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Position = UDim2.new(0.23, 0,0.212, 0) })
			local tw3 = twServ:Create(parent.TopBar.TopBarClose, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { Position = UDim2.new(0.916, 0,0.52, 0) })
			local tw2 = twServ:Create(parent.TopBar, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Position = UDim2.new(0.23, 0,0.012, 0) })
			local twRotate = twServ:Create(parent.TopBar.TopBarClose.ImageLabel, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { Rotation = 0 })

			tw:Play()
			tw.Completed:Wait()
			tw2:Play()
			task.wait(0.1)
			twRotate:Play()
			tw3:Play()
		end
	end)


	function self:Open()
		local tw = twServ:Create(parent.MainBar, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Position = UDim2.new(0.23, 0,0.212, 0) })
		local tw3 = twServ:Create(parent.TopBar.TopBarClose, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { Position = UDim2.new(0.916, 0,0.52, 0) })
		local tw2 = twServ:Create(parent.TopBar, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Position = UDim2.new(0.23, 0,0.012, 0) })
		local twRotate = twServ:Create(parent.TopBar.TopBarClose.ImageLabel, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { Rotation = 0 })

		tw:Play()
		tw.Completed:Wait()
		tw2:Play()
		task.wait(0.1)
		twRotate:Play()
		tw3:Play()
	end

	function self:Close()
		local tw = twServ:Create(parent.MainBar, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Position = UDim2.new(0.23, 0,-0.612, 0) })
		local tw3 = twServ:Create(parent.TopBar.TopBarClose, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { Position = UDim2.new(0.916, 0,0.95, 0) })
		local tw2 = twServ:Create(parent.Top, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Position = UDim2.new(0.23, 0,-0.173, 0) })
		local twRotate = twServ:Create(parent.TopBar.TopBarClose.ImageLabel, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { Rotation = 180 })

		tw:Play()
		tw.Completed:Wait()
		tw2:Play()
		task.wait(0.1)
		twRotate:Play()
		tw3:Play()
	end
	function self:HideCloseButton()
		LoUI["1f"].Visible = false
	end
        function self:Hide()
		LoUI["1"].Enabled = false
	end
	function self:Show()
		LoUI["1"].Enabled = true
        end
	function self:Toggle()
		if closed == false then
			closed = true
			local tw = twServ:Create(parent.MainBar, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Position = UDim2.new(0.23, 0,-0.612, 0) })
			local tw3 = twServ:Create(parent.TopBar.TopBarClose, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { Position = UDim2.new(0.916, 0,0.95, 0) })
			local tw2 = twServ:Create(parent.TopBar, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Position = UDim2.new(0.23, 0,-0.173, 0) })
			local twRotate = twServ:Create(parent.TopBar.TopBarClose.ImageLabel, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { Rotation = 180 })

			tw:Play()
			tw.Completed:Wait()
			tw2:Play()
			tw2.Completed:Wait()
			twRotate:Play()
			tw3:Play()
		elseif closed == true then
			closed = false
			local tw = twServ:Create(parent.MainBar, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Position = UDim2.new(0.23, 0,0.212, 0) })
			local tw3 = twServ:Create(parent.TopBar.TopBarClose, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { Position = UDim2.new(0.916, 0,0.52, 0) })
			local tw2 = twServ:Create(parent.TopBar, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Position = UDim2.new(0.23, 0,0.012, 0) })
			local twRotate = twServ:Create(parent.TopBar.TopBarClose.ImageLabel, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { Rotation = 0 })

			tw:Play()
			tw.Completed:Wait()
			tw2:Play()
			tw2.Completed:Wait()
			twRotate:Play()
			tw3:Play()
		end
	end
	function self:SetTheme(color, color2)
		for i,v in pairs(parent:GetDescendants()) do
			if v:IsA("GuiObject") then
				pcall(function()
					if v.BackgroundColor3 == GlobalColor1 then
						v.BackgroundColor3 = color
					elseif v.BackgroundColor3 == GlobalColor2 then
						v.BackgroundColor3 = color2
					end
				end)
			end
		end
		GlobalColor1 = color
		GlobalColor2 = color2
	end
end

function UILIB.newTab(name, img)	
	local self = setmetatable({}, UILIB)

	local newTab = parent.Folder.TabReserved:Clone()
	newTab.Parent = parent.MainBar
	newTab.Name = name
	newTab.Visible = false

	local newTabBtn = parent.Folder.TabButtonReserved:Clone()
	newTabBtn.Parent = parent.TopBar.ScrollingFrame
	newTabBtn.Name = name or "Tab"..#parent.MainBar:GetChildren() - 4
	newTabBtn.Frame.TextLabel.Text = name
	if img then
		newTabBtn.ImageLabel.Image = img
	else
		newTabBtn.ImageLabel.Image = ""
	end
	newTabBtn.Visible = true
	local stroke = newTabBtn:FindFirstChildOfClass("UIStroke")

	newTabBtn.MouseEnter:Connect(function() stroke.Enabled = true end)
	newTabBtn.MouseLeave:Connect(function() stroke.Enabled = false end)
	
	newTabBtn.MouseButton1Click:Connect(function()
		for i,v in pairs(parent.TopBar.ScrollingFrame:GetChildren()) do
			if v:IsA("ImageButton") then
				local vTab = parent.MainBar:FindFirstChild(v.Name)
				if v.Name ~= name then
					v.BackgroundTransparency = 0.7
					vTab.Visible = false
				elseif v.Name == name then
					vTab.Visible = true
					v.BackgroundTransparency = 0
				end
			end
		end
	end)

	function self.newButton(name, desc, func)
		local newbtn = reserved.Button:Clone()
		newbtn.Parent = newTab
		newbtn.Title.Text = name
		newbtn.Description.Text = desc
		newbtn.Visible = true
		newbtn.Name = name
        newbtn.BackgroundTransparency = 0

		local stroke = newbtn:FindFirstChildOfClass("UIStroke")
		newbtn.MouseEnter:Connect(function() stroke.Enabled = true end)
		newbtn.MouseLeave:Connect(function() stroke.Enabled = false end)

		newbtn.MouseButton1Click:Connect(func)
	end

	function self.newLabel(text)
		local newLabel = reserved.Label:Clone()
		newLabel.Parent = newTab
		newLabel.Visible = true
		newLabel.Title.Text = text
        newLabel.BackgroundTransparency = 0
		return newLabel.Title
	end

    function self.editLabel(newLabel, text)
		newLabel.Parent = newTab
		newLabel.Visible = true
		newLabel.Title.Text = text
		return newLabel.Title
    end

	function self.newInput(name, desc, func)
		local newInput = reserved.Textbox:Clone()
		local textbox = newInput.TextboxBar.ActualTextbox
        newInput.BackgroundTransparency = 0

		newInput.Visible = true
		newInput.Parent = newTab
		newInput.Title.Text = name
		newInput.Description.Text = desc
		newInput.Name = name

		textbox.FocusLost:Connect(function()
			func(textbox.Text)
		end)

	end

	function self.newKeybind(name, desc, func)
		local newKey = reserved.Keybind:Clone()
        newKey.BackgroundTransparency = 0
		
		newKey.Parent = newTab
		newKey.Title.Text = name
		newKey.Name = name
		newKey.Description.Text = desc
		newKey.Visible =  true

		local listening = false
		local a

		newKey.Bind.Button.MouseButton1Click:Connect(function()
			listening = true

			local function Loop()
				if listening then newKey.Bind.Button.Text = "." end
				task.wait(0.5)
				if listening then newKey.Bind.Button.Text = ".." end
				task.wait(0.5)
				if listening then newKey.Bind.Button.Text = "..." end
				task.wait(0.5)
			end

			task.spawn(function()
				while listening do
					Loop()
				end
			end)

			a = game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
				if input.UserInputType == Enum.UserInputType.Keyboard then
					newKey.Bind.Button.Text = input.KeyCode.Name
					listening = false
					a:Disconnect()
					func(input)
				elseif input.UserInputType == Enum.UserInputType.MouseButton1 or
					input.UserInputType == Enum.UserInputType.MouseButton2 or
					input.UserInputType == Enum.UserInputType.MouseButton3 then
					newKey.Bind.Button.Text = input.UserInputType.Name
					listening = false
					a:Disconnect()
					func(input)
				end
			end)
		end)
	end


	function self.newSlider(name, desc, max, manageSlider, func)
		local newSlider = reserved.Slider:Clone()
        newSlider.BackgroundTransparency = 0
		
		newSlider.Visible = true
		newSlider.Name = name
		newSlider.Parent = newTab
		newSlider.Title.Text = name
		newSlider.Description.Text = desc

		local Mouse = game.Players.LocalPlayer:GetMouse()
		local tweenServ = twServ

		local Trigger = newSlider.ActualSlider.Trigger
		local Label = newSlider.ActualSlider.Title
		local Fill = newSlider.ActualSlider.Fill
		local Parent = newSlider.ActualSlider

		local perc
		local Percent
		local MouseDown = false
		local delayTw = 0.1

		local function Update()
			MouseDown = true
			repeat
				task.wait()
				Percent = math.clamp((Mouse.X - Parent.AbsolutePosition.X) / Parent.AbsoluteSize.X, 0, 1)
				perc = math.round(Percent * max)
				if manageSlider == false then
					Label.Text = perc
					func(perc)
				elseif manageSlider == true then
					Label.Text = perc
					func(perc, Label)
				end
				local tween = tweenServ:Create(Fill, TweenInfo.new(delayTw, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Size = UDim2.fromScale(Percent, 1) })
				tween:Play()
			until MouseDown == false
		end

		Trigger.MouseButton1Down:Connect(Update)

		UIS.InputEnded:Connect(function(input)
			if input.UserInputType ==  Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				MouseDown = false
			end
		end)

	end
	
	function self.newToggle(title, desc, toggle, func)
		local realToggle = toggle
		local newToggle = reserved.Toggle:Clone()
		newToggle.Parent = newTab
		newToggle.Name = title
		newToggle.Visible = true
		newToggle.Title.Text = title
		newToggle.Description.Text = desc
		newToggle.BackgroundTransparency = 0
		
		local stroke = newToggle:FindFirstChildOfClass("UIStroke")
		newToggle.MouseEnter:Connect(function() stroke.Enabled = true end)
		newToggle.MouseLeave:Connect(function() stroke.Enabled = false end)

		if realToggle == true then
			newToggle.Label.BackgroundColor3 = GlobalColor2
		elseif realToggle == false then
			newToggle.Label.BackgroundColor3 = GlobalColor1
		end
		
		newToggle.Label.Label.MouseButton1Click:Connect(function()
			
			if realToggle == true then
				realToggle = false
				local twColorOn = twServ:Create(newToggle.Label, TweenInfo.new(0.2, Enum.EasingStyle.Sine), { BackgroundColor3 = GlobalColor1 })
				twColorOn:Play()
				func(realToggle)
			elseif realToggle == false then
				realToggle = true
				local twColorOn = twServ:Create(newToggle.Label, TweenInfo.new(0.2, Enum.EasingStyle.Sine), { BackgroundColor3 = GlobalColor2 })
				twColorOn:Play()
				func(realToggle)
			end
		end)
		
	end
	
	function self.newDropdown(name, desc, listTable, func)
		local newdd = reserved.Dropdown:Clone()
		newdd.Visible = true
		newdd.Parent = newTab
		newdd.BackgroundTransparency = 0
		
		newdd.Name = name
		newdd.Title.Text = name
		newdd.Description.Text = desc
		
		for i, list in ipairs(listTable) do
			local newddbtn = reserved.DropdownButton:Clone()
			newddbtn.Visible = true
			newddbtn.Parent = newdd.Box.ScrollingFrame

			local stroke = newddbtn:FindFirstChildOfClass("UIStroke")
			newddbtn.MouseEnter:Connect(function() stroke.Enabled = true end)
			newddbtn.MouseLeave:Connect(function() stroke.Enabled = false end)

			newddbtn.Name = list
			newddbtn.name.Text = list
			task.spawn(function()
				newddbtn.MouseButton1Click:Connect(function()
					newdd.DropdownBar.Open.Text = list
					local twPos = twServ:Create(newdd.Box, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {Size = UDim2.new(0.97, 0,0, 0)})
					twPos:Play()
					twPos.Completed:Wait()
					newdd.Box.Visible = false
					func(list)
				end)
			end)
		end		
		
		newdd.DropdownBar.Trigger.MouseButton1Click:Connect(function()
			
			
			if newdd.Box.Visible == false then
				newdd.Box.Visible = true
				local twPos = twServ:Create(newdd.Box, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Size = UDim2.new(0.97, 0,1.696, 0)})
				twPos:Play()
			elseif newdd.Box.Visible == true then
				local twPos = twServ:Create(newdd.Box, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Size = UDim2.new(0.97, 0,0, 0)})
				twPos:Play()
				twPos.Completed:Wait()
				newdd.Box.Visible = false
			end
		end)
	end

	return self
end

return UILIB

end;
};

return require(LoUI["93"])
