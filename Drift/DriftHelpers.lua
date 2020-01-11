-- Global variables
if not DriftPoints then DriftPoints = {} end
DriftHelpers = {}

-- Local functions
local function DoNothing() end

local function onDragStart(frame)
    local frameToMove = frame.DriftDelegate or frame
    frameToMove:StartMoving()
    frameToMove:SetAlpha(0.3)
end

local function onDragStop(frame)
    local frameToMove = frame.DriftDelegate or frame
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

local function broadcastReset(frames)
    for frameName, _ in pairs(frames) do
        local frame = _G[frameName] or nil
        if frame and frame:IsVisible() then
            frame.DriftResetNeeded = true
        end
    end
end

local function resetPosition(frame)
    local frameToMove = frame.DriftDelegate or frame
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
end

local function makeMovable(frame)
    local frameToMove = frame.DriftDelegate or frame
    frame:SetMovable(true)
    frameToMove:SetMovable(true)
    frame:EnableMouse(true)
    frame:SetClampedToScreen(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", onDragStart)
    frame:SetScript("OnDragStop", onDragStop)
end

local function makeSticky(frame, frames)
    frame:HookScript(
        "OnShow",
        function(self, event, ...)
            resetPosition(frame)
            broadcastReset(frames)
        end
    )

    frame:HookScript(
        "OnHide",
        function(self, event, ...)
            broadcastReset(frames)
        end
    )

    frame:HookScript(
        "OnUpdate",
        function(self, event, ...)
            if frame.DriftResetNeeded then
                resetPosition(frame)
                frame.DriftResetNeeded = nil
            end
        end
    )
end

local function makeTabsSticky(frame, frames)
    if frame.DriftTabs then
        for _, tab in pairs(frame.DriftTabs) do
            tab:HookScript(
                "OnClick",
                function(self, event, ...)
                    resetPosition(frame)
                    broadcastReset(frames)
                end
            )
        end
    end
end

-- Global functions
function DriftHelpers:ModifyFrames(frames)
    for frameName, properties in pairs(frames) do
        local frame = _G[frameName] or nil
        if frame and not frame.DriftModified then
            if properties.DriftDelegate then
                frame.DriftDelegate = _G[properties.DriftDelegate] or frame
            end
            if properties.DriftTabs then
                frame.DriftTabs = {}
                for _, tabName in pairs(properties.DriftTabs) do
                    if _G[tabName] then
                        table.insert(frame.DriftTabs, _G[tabName])
                    elseif frame[tabName] then
                        table.insert(frame.DriftTabs, frame[tabName])
                    end
                end
            end

            makeMovable(frame)
            makeSticky(frame, frames)
            makeTabsSticky(frame, frames)
            frame.DriftModified = true
        end
    end

    -- This is needed to avoid a Lua error
    if EncounterJournalTooltip then
        EncounterJournalTooltip:ClearAllPoints()
    end
end
