local Services = {
    Players = game:GetService("Players"),
    TweenService = game:GetService("TweenService"),
    UserInputService = game:GetService("UserInputService"),
    CoreGui = game:GetService("CoreGui"),
    ContentProvider = game:GetService("ContentProvider")
}

local Settings = _G.DRE
assert(Settings and Settings.UI and Settings.UI.Theme, "DRE settings are missing")

local Theme = Settings.UI.Theme
local GuiParent = Services.CoreGui

pcall(function()
    if type(gethui) == "function" then
        local HUI = gethui()
        if HUI then
            GuiParent = HUI
        end
    end
end)

pcall(function()
    for _, Name in ipairs({"DRE_HUB", "ToggleGUI"}) do
        local Existing = GuiParent:FindFirstChild(Name)
        if Existing then
            Existing:Destroy()
        end
    end
end)

local AssetID = tostring(Settings.AssetID or "")

if AssetID ~= "" then
    pcall(function()
        Services.ContentProvider:PreloadAsync({AssetID})
    end)
end

local ToggleScreenGui = Instance.new("ScreenGui")
ToggleScreenGui.Name = "ToggleGUI"
ToggleScreenGui.ResetOnSpawn = false
ToggleScreenGui.IgnoreGuiInset = true
ToggleScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToggleScreenGui.DisplayOrder = 1000
ToggleScreenGui.Parent = GuiParent

local Toggle = Instance.new("ImageButton")
Toggle.Name = "D"
Toggle.Size = UDim2.fromOffset(55, 55)
Toggle.Position = UDim2.new(0.02, 0, 0.5, -27.5)
Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Toggle.BorderSizePixel = 0
Toggle.AutoButtonColor = false
Toggle.Image = AssetID
Toggle.ZIndex = 999
Toggle.Parent = ToggleScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = Toggle

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(200, 200, 220)
ToggleStroke.Thickness = 1.5
ToggleStroke.Transparency = 0.2
ToggleStroke.Parent = Toggle

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DRE_HUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = GuiParent

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(Settings.UI.Width, Settings.UI.Height)
Main.Position = UDim2.new(
    0.5,
    -Settings.UI.Width / 2,
    0.5,
    -Settings.UI.Height / 2
)
Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Active = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 0)
MainCorner.Parent = Main

local MainBorder = Instance.new("UIStroke")
MainBorder.Color = Color3.fromRGB(200, 200, 220)
MainBorder.Thickness = 2
MainBorder.Transparency = 0.1
MainBorder.Parent = Main

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 58)
TopBar.BackgroundColor3 = Theme.TopBar
TopBar.BorderSizePixel = 0
TopBar.Active = true
TopBar.ZIndex = 20
TopBar.Parent = Main

local TopGradient = Instance.new("UIGradient")
TopGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(36, 38, 53)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 23, 30))
})
TopGradient.Parent = TopBar

local TopLine = Instance.new("Frame")
TopLine.Name = "TopLine"
TopLine.Size = UDim2.new(1, 0, 0, 2)
TopLine.Position = UDim2.new(0, 0, 1, -2)
TopLine.BackgroundColor3 = Color3.fromRGB(200, 200, 220)
TopLine.BackgroundTransparency = 0.2
TopLine.BorderSizePixel = 0
TopLine.ZIndex = 22
TopLine.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -36, 0, 27)
Title.Position = UDim2.fromOffset(18, 7)
Title.BackgroundTransparency = 1
Title.Text = tostring(Settings.Name or "DRE HUB")
Title.TextColor3 = Theme.Text
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.ZIndex = 21
Title.Parent = TopBar

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(1, -36, 0, 18)
Subtitle.Position = UDim2.fromOffset(18, 32)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = tostring(Settings.Version or "")
Subtitle.TextColor3 = Theme.SubText
Subtitle.TextSize = 10
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.ZIndex = 21
Subtitle.Parent = TopBar

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, Settings.UI.SidebarWidth, 1, -58)
Sidebar.Position = UDim2.new(0, 0, 0, 58)
Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 5
Sidebar.Parent = Main

local SidebarLine = Instance.new("Frame")
SidebarLine.Name = "SidebarLine"
SidebarLine.Size = UDim2.new(0, 2, 1, 0)
SidebarLine.Position = UDim2.new(1, -2, 0, 0)
SidebarLine.BackgroundColor3 = Color3.fromRGB(200, 200, 220)
SidebarLine.BackgroundTransparency = 0.15
SidebarLine.BorderSizePixel = 0
SidebarLine.ZIndex = 6
SidebarLine.Parent = Sidebar

local TabScroll = Instance.new("ScrollingFrame")
TabScroll.Name = "TabScroll"
TabScroll.Size = UDim2.fromScale(1, 1)
TabScroll.BackgroundTransparency = 1
TabScroll.BorderSizePixel = 0
TabScroll.CanvasSize = UDim2.new()
TabScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
TabScroll.ScrollingDirection = Enum.ScrollingDirection.Y
TabScroll.ScrollBarThickness = 0
TabScroll.ScrollBarImageTransparency = 1
TabScroll.Active = true
TabScroll.ZIndex = 6
TabScroll.Parent = Sidebar

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingTop = UDim.new(0, 6)
TabPadding.PaddingBottom = UDim.new(0, 6)
TabPadding.PaddingLeft = UDim.new(0, 2)
TabPadding.PaddingRight = UDim.new(0, 2)
TabPadding.Parent = TabScroll

local TabList = Instance.new("UIListLayout")
TabList.Padding = UDim.new(0, 2)
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Parent = TabScroll

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(
    1,
    -Settings.UI.SidebarWidth,
    1,
    -58
)
Content.Position = UDim2.new(
    0,
    Settings.UI.SidebarWidth,
    0,
    58
)
Content.BackgroundColor3 = Theme.Background
Content.BorderSizePixel = 0
Content.ZIndex = 5
Content.Parent = Main

_G.DRE_Main = Main
_G.DRE_TopBar = TopBar
_G.DRE_Sidebar = Sidebar
_G.DRE_TabScroll = TabScroll
_G.DRE_Content = Content
_G.DRE_ScreenGui = ScreenGui
_G.DRE_Toggle = Toggle
_G.DRE_GuiParent = GuiParent

local function IsDragInput(Input)
    return Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch
end

local function MakeDraggable(Object, Target)
    local Dragging = false
    local DragStart
    local StartPosition
    local ActiveTouch

    Object.InputBegan:Connect(function(Input)
        if not IsDragInput(Input) or Dragging then
            return
        end

        Dragging = true
        DragStart = Input.Position
        StartPosition = Target.Position

        if Input.UserInputType == Enum.UserInputType.Touch then
            ActiveTouch = Input
        end
    end)

    Services.UserInputService.InputChanged:Connect(function(Input)
        if not Dragging then
            return
        end

        if Input.UserInputType == Enum.UserInputType.Touch then
            if ActiveTouch and Input ~= ActiveTouch then
                return
            end
        elseif Input.UserInputType ~= Enum.UserInputType.MouseMovement then
            return
        end

        if not DragStart or not StartPosition then
            return
        end

        local Delta = Input.Position - DragStart

        Target.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end)

    Services.UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.Touch then
            if ActiveTouch == Input then
                Dragging = false
                ActiveTouch = nil
                DragStart = nil
                StartPosition = nil
            end
        elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
            ActiveTouch = nil
            DragStart = nil
            StartPosition = nil
        end
    end)
end

MakeDraggable(TopBar, Main)

local DragZones = {
    {
        Name = "DragTop",
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 5)
    },
    {
        Name = "DragBottom",
        Position = UDim2.new(0, 0, 1, -5),
        Size = UDim2.new(1, 0, 0, 5)
    },
    {
        Name = "DragLeft",
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 5, 1, 0)
    },
    {
        Name = "DragRight",
        Position = UDim2.new(1, -5, 0, 0),
        Size = UDim2.new(0, 5, 1, 0)
    }
}

for _, Data in ipairs(DragZones) do
    local Zone = Instance.new("Frame")
    Zone.Name = Data.Name
    Zone.Position = Data.Position
    Zone.Size = Data.Size
    Zone.BackgroundTransparency = 1
    Zone.BorderSizePixel = 0
    Zone.Active = true
    Zone.ZIndex = 50
    Zone.Parent = Main

    MakeDraggable(Zone, Main)
end

MakeDraggable(Toggle, Toggle)

local UIVisible = true
local ToggleBusy = false

Toggle.MouseButton1Click:Connect(function()
    if ToggleBusy then
        return
    end

    ToggleBusy = true
    UIVisible = not UIVisible
    ScreenGui.Enabled = UIVisible

    local Shrink = Services.TweenService:Create(
        Toggle,
        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {
            Size = UDim2.fromOffset(45, 45)
        }
    )

    local Restore = Services.TweenService:Create(
        Toggle,
        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {
            Size = UDim2.fromOffset(55, 55)
        }
    )

    Shrink:Play()
    Shrink.Completed:Wait()

    Restore:Play()
    Restore.Completed:Wait()

    ToggleBusy = false
end)

