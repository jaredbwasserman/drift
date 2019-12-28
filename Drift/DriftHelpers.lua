-- Global variables
if not DriftPoints then DriftPoints = {} end
DriftHelpers = {}

-- Local functions
local function DoNothing() end

local function onDragStart(frame)
    local frameToMove = frame.delegate or frame
    frameToMove:StartMoving()
    frameToMove:SetAlpha(0.3)
end

local function onDragStop(frame)
    local frameToMove = frame.delegate or frame
    frameToMove:StopMovingOrSizing()
    frameToMove:SetAlpha(1)
    local point, relativeTo, relativePoint, xOfs, yOfs = frameToMove:GetPoint()
    DriftPoints[frameToMove:GetName()] = {
        ["point"] = point,
        ["relativeTo"] = relativeTo or "UIParent",
        ["relativePoint"] = relativePoint,
        ["xOfs"] = xOfs,
        ["yOfs"] = yOfs
    }
end

local function makeMovable(frame)
    local frameToMove = frame.delegate or frame
    frame:SetMovable(true)
    frameToMove:SetMovable(true)
    frame:EnableMouse(true)
    frame:SetClampedToScreen(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", onDragStart)
    frame:SetScript("OnDragStop", onDragStop)
end

local function makePersistent(frame)
    -- Set point from old position
    frame:HookScript("OnShow", function(self, event, ...)
        local frameToMove = frame.delegate or frame
        local point = DriftPoints[frameToMove:GetName()]
        if point then
            frameToMove:ClearAllPoints()
            frameToMove:SetPoint(
                point["point"],
                point["relativeTo"],
                point["relativePoint"],
                point["xOfs"],
                point["yOfs"]
            )
        end
    end)
end

local function makeSticky(frame)
    -- Prevent other frames from moving this one while it's shown
    frame:HookScript("OnShow", function(self, event, ...)
        local frameToMove = frame.delegate or frame
        frameToMove.SetPointOrig = frameToMove.SetPoint
        frameToMove.SetPoint = DoNothing
    end)

    -- Reset SetPoint when hidden
    frame:HookScript("OnHide", function(self, event, ...)
        local frameToMove = frame.delegate or frame
        frameToMove.SetPoint = frameToMove.SetPointOrig
    end)
end

-- Global functions
function DriftHelpers:ModifyFrames(frames)
    for frameName, properties in pairs(frames) do
        local frame = _G[frameName] or nil
        if frame and not frame.modifiedByDrift then
            if properties.delegate then
                frame.delegate = _G[properties.delegate] or frame
            end

            makeMovable(frame)
            makePersistent(frame)

            if not properties.notSticky then
                makeSticky(frame)
            end

            frame.modifiedByDrift = true
        end
    end
end
