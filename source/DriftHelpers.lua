--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

if not DriftPoints then DriftPoints = {} end
if not DriftOptions then DriftOptions = {} end
DriftHelpers = {}
DriftOptionsPanel = {}
DriftOptionsPanel.config = {}


--------------------------------------------------------------------------------
-- Core Logic
--------------------------------------------------------------------------------

-- Local functions
local function shouldMove()
    if not DriftOptions.framesAreLocked then
        return true
    elseif DriftOptions.dragKeyFunc then
        if DriftOptions.dragKeyFunc() then
            return true
        else
            return false
        end
    else
        return false
    end
end

local function getFrame(frameName)
    if not frameName then
        return nil
    end

    -- First check global table
    local frame = _G[frameName]
    if frame then
        return frame
    end

    -- Try splitting on dot
    local frameNames = {}
    for name in string.gmatch(frameName, "[^%.]+") do
        table.insert(frameNames, name)
    end
    if #frameNames < 2 then
        return nil
    end

    -- Combine
    frame = _G[frameNames[1]]
    if frame then
        for idx = 2, #frameNames do
            frame = frame[frameNames[idx]]
        end
    end

    return frame
end

local function onDragStart(frame)
    local frameToMove = frame.DriftDelegate or frame
    if shouldMove() then
        frameToMove:StartMoving()
        frameToMove:SetAlpha(0.3)
    end
end

local function onDragStop(frame)
    local frameToMove = frame.DriftDelegate or frame
    frameToMove:StopMovingOrSizing()
    frameToMove:SetAlpha(1)
    local point, relativeTo, relativePoint, xOfs, yOfs = frameToMove:GetPoint()
    DriftPoints[frameToMove:GetName()] = {
        ["point"] = point,
        ["relativeTo"] = "UIParent",
        ["relativePoint"] = relativePoint,
        ["xOfs"] = xOfs,
        ["yOfs"] = yOfs
    }
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
    if frame.DriftMovable then
        return
    end

    local frameToMove = frame.DriftDelegate or frame
    frame:SetMovable(true)
    frameToMove:SetMovable(true)
    frame:EnableMouse(true)
    frame:SetClampedToScreen(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", onDragStart)
    frame:SetScript("OnDragStop", onDragStop)

    frame.DriftMovable = true
end

local function makeSticky(frame, frames)
    if frame.DriftSticky then
        return
    end

    frame:HookScript(
        "OnShow",
        function(self, event, ...)
            resetPosition(frame)
            DriftHelpers:BroadcastReset(frames)
        end
    )

    frame:HookScript(
        "OnHide",
        function(self, event, ...)
            DriftHelpers:BroadcastReset(frames)
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

    frame.DriftSticky = true
end

local function makeTabsSticky(frame, frames)
    if frame.DriftTabs then
        for _, tab in pairs(frame.DriftTabs) do
            if not tab.DriftTabSticky then
                tab:HookScript(
                    "OnClick",
                    function(self, event, ...)
                        resetPosition(frame)
                        DriftHelpers:BroadcastReset(frames)
                    end
                )
                tab.DriftTabSticky = true
            end
        end
    end
end

-- Global functions
function DriftHelpers:ModifyFrames(frames)
    for frameName, properties in pairs(frames) do
        local frame = getFrame(frameName)
        if frame then
            if not frame:GetName() then
                frame.GetName = function()
                    return frameName
                end
            end
            if properties.DriftDelegate then
                frame.DriftDelegate = getFrame(properties.DriftDelegate) or frame
            end
            if properties.DriftTabs then
                frame.DriftTabs = {}
                for _, tabName in pairs(properties.DriftTabs) do
                    local tabFrame = getFrame(tabName)
                    if tabFrame then
                        table.insert(frame.DriftTabs, tabFrame)
                    end
                end
            end

            makeMovable(frame)
            makeSticky(frame, frames)
            makeTabsSticky(frame, frames)
        end
    end

    -- ClearAllPoints is needed to avoid Lua errors
    if EncounterJournalTooltip then
        EncounterJournalTooltip:ClearAllPoints()
    end

    -- Disable updating Container frames to avoid unwanted movement
    UpdateContainerFrameAnchors = function ()
        -- Do nothing
    end

    -- Reset everything in case there was a delay
    DriftHelpers:BroadcastReset(frames)
end

DriftHelpers.waitTable = {}
DriftHelpers.waitFrame = nil
function DriftHelpers:Wait(delay, func, ...)
    if type(delay) ~= "number" or type(func) ~= "function" then
        return false
    end

    if DriftHelpers.waitFrame == nil then
        DriftHelpers.waitFrame = CreateFrame("Frame", "WaitFrame", UIParent)
        DriftHelpers.waitFrame:SetScript(
            "OnUpdate",
            function(self, elapse)
                local count = #DriftHelpers.waitTable
                local i = 1
                while (i <= count) do
                    local waitRecord = tremove(DriftHelpers.waitTable, i)
                    local d = tremove(waitRecord, 1)
                    local f = tremove(waitRecord, 1)
                    local p = tremove(waitRecord, 1)
                    if (d > elapse) then
                        tinsert(DriftHelpers.waitTable, i, {d - elapse, f, p})
                        i = i + 1
                    else
                        count = count - 1
                        f(unpack(p))
                    end
                end
            end
        )
    end

    tinsert(DriftHelpers.waitTable, {delay, func, {...}})
    return true
end

function DriftHelpers:BroadcastReset(frames)
    for frameName, _ in pairs(frames) do
        local frame = getFrame(frameName)
        if frame and frame:IsVisible() then
            frame.DriftResetNeeded = true
        end
    end
end


--------------------------------------------------------------------------------
-- Interface Options
--------------------------------------------------------------------------------

-- Local functions
local function createCheckbox(name, point, relativeFrame, relativePoint, xOffset, yOffset, text, tooltipText, onClickFunction)
    local checkbox = CreateFrame("CheckButton", name, relativeFrame, "ChatConfigCheckButtonTemplate")
    checkbox:SetPoint(point, relativeFrame, relativePoint, xOffset, yOffset)
    getglobal(checkbox:GetName() .. "Text"):SetText(text)
    checkbox.tooltip = tooltipText
    checkbox:SetScript("OnClick", onClickFunction)
    return checkbox
end

local function createDragKeyDropdown(name, point, relativeFrame, relativePoint, xOffset, yOffset)
    local dropdown = CreateFrame("Frame", name, relativeFrame, "UIDropDownMenuTemplate")
    dropdown:SetPoint(point, relativeFrame, relativePoint, xOffset, yOffset)

    local items = {
        "ALT key",
        "CTRL key",
        "SHIFT key",
        "None"
    }

    local function OnClick(self)
        UIDropDownMenu_SetSelectedID(dropdown, self:GetID())
    end

    local function initialize(self, level)
        local info = UIDropDownMenu_CreateInfo()
        for k, v in pairs(items) do
            info = UIDropDownMenu_CreateInfo()
            info.text = v
            info.value = v
            info.func = OnClick
            UIDropDownMenu_AddButton(info, level)
        end
    end

    UIDropDownMenu_Initialize(dropdown, initialize)
    UIDropDownMenu_SetWidth(dropdown, 100)
    UIDropDownMenu_SetButtonWidth(dropdown, 124)
    UIDropDownMenu_SetSelectedID(dropdown, DriftOptions.dragKey or 1)
    UIDropDownMenu_JustifyText(dropdown, "LEFT")
    return dropdown
end

local function getDragKeyFuncFromOrdinal(ordinal)
    if ordinal == 1 then
        return IsAltKeyDown
    elseif ordinal == 2 then
        return IsControlKeyDown
    elseif ordinal == 3 then
        return IsShiftKeyDown
    end
    return nil
end

-- Make parent panel
DriftOptionsPanel.panel = CreateFrame("Frame", "DriftOptionsPanel", UIParent)
DriftOptionsPanel.panel.name = "Drift"
local driftOptionsTitle = DriftOptionsPanel.panel:CreateFontString(nil, "BACKGROUND")
driftOptionsTitle:SetFontObject("GameFontNormalLarge")
driftOptionsTitle:SetText("Drift " .. GetAddOnMetadata("Drift", "Version"))
driftOptionsTitle:SetPoint("TOPLEFT", DriftOptionsPanel.panel, "TOPLEFT", 16, -15)
local driftOptionsInfo = DriftOptionsPanel.panel:CreateFontString(nil, "BACKGROUND")
driftOptionsInfo:SetFontObject("GameFontNormal")
driftOptionsInfo:SetText("by Jared Wasserman")
driftOptionsInfo:SetPoint("TOPLEFT", DriftOptionsPanel.panel, "TOPLEFT", 16, -45)
InterfaceOptions_AddCategory(DriftOptionsPanel.panel)

-- Make a child panel
DriftOptionsPanel.childpanel = CreateFrame("Frame", "DriftOptionsPanelChild", DriftOptionsPanel.panel)
DriftOptionsPanel.childpanel.name = "Options"
DriftOptionsPanel.childpanel.parent = DriftOptionsPanel.panel.name
local driftOptionsChildTitle = DriftOptionsPanel.childpanel:CreateFontString(nil, "BACKGROUND")
driftOptionsChildTitle:SetFontObject("GameFontNormalLarge")
driftOptionsChildTitle:SetText("Options")
driftOptionsChildTitle:SetPoint("TOPLEFT", DriftOptionsPanel.childpanel, "TOPLEFT", 16, -15)
InterfaceOptions_AddCategory(DriftOptionsPanel.childpanel)

-- Parent panel content
DriftOptionsPanel.config.framesAreLockedCheckbox = createCheckbox(
    "FramesAreLockedCheckbox",
    "TOPLEFT",
    DriftOptionsPanel.childpanel,
    "TOPLEFT",
    14,
    -50,
    " Lock Frames",
    "If frames are locked, the Drag Key must be pressed while dragging frames.",
    nil
)
DriftOptionsPanel.config.framesAreLockedCheckbox:SetChecked(DriftOptions.framesAreLocked)

local dragKeyDropdownTitle = DriftOptionsPanel.childpanel:CreateFontString(nil, "BACKGROUND")
dragKeyDropdownTitle:SetFontObject("GameFontNormal")
dragKeyDropdownTitle:SetText("Drag Key")
dragKeyDropdownTitle:SetPoint("TOPLEFT", DriftOptionsPanel.childpanel, "TOPLEFT", 20, -92)

DriftOptionsPanel.config.dragKeyDropdown = createDragKeyDropdown(
    "DragKeyDropdown",
    "TOPLEFT",
    DriftOptionsPanel.childpanel,
    "TOPLEFT",
    0,
    -110
)

-- Update logic
DriftOptionsPanel.panel.okay = function (self)
    DriftOptions.framesAreLocked = DriftOptionsPanel.config.framesAreLockedCheckbox:GetChecked()
    DriftOptions.dragKey = UIDropDownMenu_GetSelectedID(DriftOptionsPanel.config.dragKeyDropdown)
    DriftOptions.dragKeyFunc = getDragKeyFuncFromOrdinal(DriftOptions.dragKey)
end
