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

local function makeMovable(frame, properties)
    frame:SetFrameStrata("HIGH")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:SetClampedToScreen(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", onDragStart)
    frame:SetScript("OnDragStop", onDragStop)
end

local function makeSticky(frame, properties, frameCloseButton)
    if frameCloseButton and not properties.nonSticky then
        -- Prevent other frames from hiding this one
        frame.HideOrig = frame.Hide
        frame.Hide = DoNothing
        
        -- Only valid way to hide is if the user does it
        -- TODO: Support more methods than clicking close button
        frameCloseButton:SetScript("OnClick", function (self, button, down)
            frame:HideOrig()
        end)

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

            -- Prevent other frames from moving this one while it's shown
            frame.SetPointOrig = frame.SetPoint
            frame.SetPoint = DoNothing
        end)

        -- Reset SetPoint
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
            local frameCloseButton = _G[frameName.."CloseButton"] or frame.CloseButton or nil
            makeMovable(frame, properties)
            makeSticky(frame, properties, frameCloseButton)
            properties.hasBeenModified = true
        end
    end
end
