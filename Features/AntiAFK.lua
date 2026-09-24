```lua
local Players = game:GetService("Players")

local Player = Players.LocalPlayer

local MOUSE_INTERVAL_MIN = 45
local MOUSE_INTERVAL_MAX = 120

local CAMERA_INTERVAL_MIN = 60
local CAMERA_INTERVAL_MAX = 180

local ZOOM_INTERVAL_MIN = 90
local ZOOM_INTERVAL_MAX = 240

local AntiAFKEnabled = false
local MouseThread = nil
local CameraThread = nil
local ZoomThread = nil

local function DoMouseMove()
    pcall(function()
        mousemoverel(math.random(-15, 15), math.random(-15, 15))
    end)
end

local function DoCameraRotation()
    pcall(function()
        local Camera = workspace.CurrentCamera

        if Camera then
            Camera.CFrame = Camera.CFrame * CFrame.Angles(
                math.rad(math.random(-2, 2)),
                math.rad(math.random(-3, 3)),
                0
            )
        end
    end)
end

local function DoCameraZoom()
    pcall(function()
        local Camera = workspace.CurrentCamera

        if Camera then
            local Original = Camera.FieldOfView
            Camera.FieldOfView = Original + math.random(-5, 5)

            task.wait(0.3)

            Camera.FieldOfView = Original
        end
    end)
end

local function EnableAntiAFK()
    if AntiAFKEnabled then
        return
    end

    AntiAFKEnabled = true

    MouseThread = task.spawn(function()
        while AntiAFKEnabled do
            local WaitTime = math.random(MOUSE_INTERVAL_MIN, MOUSE_INTERVAL_MAX)

            task.wait(WaitTime)

            if not AntiAFKEnabled then
                break
            end

            DoMouseMove()
        end
    end)

    CameraThread = task.spawn(function()
        while AntiAFKEnabled do
            local WaitTime = math.random(CAMERA_INTERVAL_MIN, CAMERA_INTERVAL_MAX)

            task.wait(WaitTime)

            if not AntiAFKEnabled then
                break
            end

            DoCameraRotation()
        end
    end)

    ZoomThread = task.spawn(function()
        while AntiAFKEnabled do
            local WaitTime = math.random(ZOOM_INTERVAL_MIN, ZOOM_INTERVAL_MAX)

            task.wait(WaitTime)

            if not AntiAFKEnabled then
                break
            end

            DoCameraZoom()
        end
    end)
end

local function DisableAntiAFK()
    if not AntiAFKEnabled then
        return
    end

    AntiAFKEnabled = false

    if MouseThread then
        pcall(function()
            task.cancel(MouseThread)
        end)

        MouseThread = nil
    end

    if CameraThread then
        pcall(function()
            task.cancel(CameraThread)
        end)

        CameraThread = nil
    end

    if ZoomThread then
        pcall(function()
            task.cancel(ZoomThread)
        end)

        ZoomThread = nil
    end
end

local function ToggleAntiAFK()
    if AntiAFKEnabled then
        DisableAntiAFK()
    else
        EnableAntiAFK()
    end
end

_G.DRE_AntiAFK = {
    Enable = EnableAntiAFK,
    Disable = DisableAntiAFK,
    Toggle = ToggleAntiAFK,
    IsEnabled = function()
        return AntiAFKEnabled
    end,

    MOUSE_INTERVAL_MIN = MOUSE_INTERVAL_MIN,
    MOUSE_INTERVAL_MAX = MOUSE_INTERVAL_MAX,
    CAMERA_INTERVAL_MIN = CAMERA_INTERVAL_MIN,
    CAMERA_INTERVAL_MAX = CAMERA_INTERVAL_MAX,
    ZOOM_INTERVAL_MIN = ZOOM_INTERVAL_MIN,
    ZOOM_INTERVAL_MAX = ZOOM_INTERVAL_MAX
}
```
