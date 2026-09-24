local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

local WalkSpeedEnabled = false
local WalkSpeedValue = 50
local OriginalWalkSpeed = 16
local Connection = nil

local function GetHumanoid()
    local Char = Player.Character

    if not Char then
        return nil
    end

    return Char:FindFirstChildOfClass("Humanoid")
end

local function ApplyWalkSpeed()
    local Hum = GetHumanoid()

    if Hum then
        Hum.WalkSpeed = WalkSpeedValue
    end
end

local function StopWalkSpeed()
    local Hum = GetHumanoid()

    if Hum then
        Hum.WalkSpeed = OriginalWalkSpeed
    end

    if Connection then
        Connection:Disconnect()
        Connection = nil
    end
end

local function StartWalkSpeed()
    local Hum = GetHumanoid()

    if Hum then
        OriginalWalkSpeed = Hum.WalkSpeed
    end

    ApplyWalkSpeed()

    if Connection then
        Connection:Disconnect()
    end

    Connection = RunService.Heartbeat:Connect(function()
        if WalkSpeedEnabled then
            ApplyWalkSpeed()
        end
    end)
end

local function SetWalkSpeedValue(Value)
    Value = tonumber(Value)

    if not Value then
        return
    end

    WalkSpeedValue = math.clamp(Value, 50, 1000)

    if WalkSpeedEnabled then
        ApplyWalkSpeed()
    end
end

local function ToggleWalkSpeed()
    WalkSpeedEnabled = not WalkSpeedEnabled

    if WalkSpeedEnabled then
        StartWalkSpeed()
    else
        StopWalkSpeed()
    end
end

local function EnableWalkSpeed()
    if WalkSpeedEnabled then
        return
    end

    WalkSpeedEnabled = true
    StartWalkSpeed()
end

local function DisableWalkSpeed()
    if not WalkSpeedEnabled then
        return
    end

    WalkSpeedEnabled = false
    StopWalkSpeed()
end

_G.DRE_WalkSpeed = {
    Toggle = ToggleWalkSpeed,
    Enable = EnableWalkSpeed,
    Disable = DisableWalkSpeed,
    SetValue = SetWalkSpeedValue,
    IsEnabled = function()
        return WalkSpeedEnabled
    end,
    GetValue = function()
        return WalkSpeedValue
    end
}

