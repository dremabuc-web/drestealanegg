```lua
local AntiTrapEnabled = false

local function RemoveDebrisChildren()
    local Folder = workspace:FindFirstChild("__DEBRIS")

    if not Folder then
        return
    end

    for _, Child in ipairs(Folder:GetChildren()) do
        pcall(function()
            Child:Destroy()
        end)
    end
end

local function EnableAntiTrap()
    if AntiTrapEnabled then
        return
    end

    AntiTrapEnabled = true

    RemoveDebrisChildren()

    task.spawn(function()
        while AntiTrapEnabled do
            task.wait(1)

            if AntiTrapEnabled then
                RemoveDebrisChildren()
            end
        end
    end)
end

local function DisableAntiTrap()
    AntiTrapEnabled = false
end

local function ToggleAntiTrap()
    if AntiTrapEnabled then
        DisableAntiTrap()
    else
        EnableAntiTrap()
    end
end

_G.DRE_AntiTrap = {
    Toggle = ToggleAntiTrap,
    Enable = EnableAntiTrap,
    Disable = DisableAntiTrap,
    IsEnabled = function()
        return AntiTrapEnabled
    end
}
```
