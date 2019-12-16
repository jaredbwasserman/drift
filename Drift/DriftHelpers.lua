-- Private functions
local function onDragStart(frame)
    frame:StartMoving()
    frame.isMoving = true
    frame:SetAlpha(0.3)
end

local function onDragStop(frame)
    frame:StopMovingOrSizing()
    frame.isMoving = false
    frame:SetAlpha(1)
end

local function setOrHookScript(frame, script, func)
    if frame:GetScript(script) then
        frame:HookScript(script, func)
    else
        frame:SetScript(script, func)
    end
end

-- Public functions
DriftHelpers = {}

function DriftHelpers:makeMovable(frame)
    -- TODO: Remove
    -- print("Make " .. frame:GetName() .. " movable")

    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")

    setOrHookScript(frame, "OnDragStart", onDragStart)
    setOrHookScript(frame, "OnDragStop", onDragStop)
end
