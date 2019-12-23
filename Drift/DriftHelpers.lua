-- Global variables
if not DriftPoints then DriftPoints = {} end
DriftHelpers = {}

-- Local functions
local function DoNothing() end

local function onDragStart(frame)
    frame:StartMoving()
    frame:SetAlpha(0.3)
end

local function onDragStop(frame)
    frame:StopMovingOrSizing()
    frame:SetAlpha(1)

    local point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint(pointNum)
    DriftPoints[frame:GetName()] = {
        ["point"] = point,
        ["relativeTo"] = relativeTo or "UIParent",
        ["relativePoint"] = relativePoint,
        ["xOfs"] = xOfs,
        ["yOfs"] = yOfs
    }
end

local function makeMovable(frame)
    frame:SetFrameStrata("HIGH")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:SetClampedToScreen(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", onDragStart)
    frame:SetScript("OnDragStop", onDragStop)
end

local function makePersistent(frame)
    -- Set point from old position
    frame:HookScript("OnShow", function(self, event, ...)
        self:ClearAllPoints()

        local point = DriftPoints[frame:GetName()]
        if point then
            self:SetPoint(
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
    local frameCloseButton = _G[frame:GetName().."CloseButton"] or frame.CloseButton or nil
    if frameCloseButton then
        -- TODO: Uncomment??
        -- Prevent other frames from hiding this one
        -- frame.HideOrig = frame.Hide
        -- frame.Hide = DoNothing

        -- TODO: Uncomment??
        -- Only valid way to hide is if the user does it
        -- TODO: Support more methods than clicking close button
        -- frameCloseButton:HookScript("OnClick", function (self, button, down)
        --     frame:HideOrig()
        -- end)

        -- Prevent other frames from moving this one while it's shown
        frame:HookScript("OnShow", function(self, event, ...)
            frame.SetPointOrig = frame.SetPoint
            frame.SetPoint = DoNothing
        end)

        -- Reset SetPoint when hidden
        frame:HookScript("OnHide", function(self, event, ...)
            frame.SetPoint = frame.SetPointOrig
        end)
    end
end

-- Global functions
function DriftHelpers:ModifyFrames(frames)
    for frameName, properties in pairs(frames) do
        local frame = _G[frameName] or nil
        if frame and not properties.hasBeenModified then
            makeMovable(frame)
            makePersistent(frame)
            makeSticky(frame)
            properties.hasBeenModified = true
        end
    end
end
