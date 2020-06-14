--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

-- Variables for holding functions
DriftHelpers = {}

-- Variables for moving
if not DriftPoints then DriftPoints = {} end

-- Variables for config
if not DriftOptions then DriftOptions = {} end
local DriftOptionsPanel = {}
DriftOptionsPanel.config = {}

-- Variables for timer
DriftHelpers.waitTable = {}
DriftHelpers.waitFrame = nil

-- Variables for scaling
local MAX_SCALE = 1.5 -- TODO: Configurable
local MIN_SCALE = 0.5 -- TODO: Configurable
local SCALE_INCREMENT = 0.01 -- TODO: Configurable
DriftHelpers.scaleHandlerFrame = nil
DriftHelpers.prevMouseX = nil
DriftHelpers.prevMouseY = nil
DriftHelpers.frameBeingScaled = nil
if not DriftScales then DriftScales = {} end

-- Other variables
local ALPHA_DURING_MOVE = 0.3 -- TODO: Configurable
local ALPHA_DURING_SCALE = 0.3 -- TODO: Configurable


--------------------------------------------------------------------------------
-- Core Logic
--------------------------------------------------------------------------------

-- Local functions
local function getInCombatLockdown()
    return InCombatLockdown()
end

local function frameCannotBeModified(frame)
    -- Do not reset protected frame if in combat to avoid Lua errors
    -- Refer to https://wowwiki.fandom.com/wiki/API_InCombatLockdown
    return frame:IsProtected() and getInCombatLockdown()
end

local function shouldModify(frame)
    if frameCannotBeModified(frame) then
        return false
    end

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

local function onDragStart(frame, button)
    local frameToMove = frame.DriftDelegate or frame

    if not shouldModify(frameToMove) then
        return
    end

    -- Left click is move
    if button == "LeftButton" then
        -- Start moving
        frameToMove:StartMoving()

        -- Set alpha
        frameToMove:SetAlpha(ALPHA_DURING_MOVE)

        -- Set the frame as moving
        frameToMove.DriftIsMoving = true

    -- Right click is scale
    elseif button == "RightButton" then
        -- TODO: Make it so frame scales from center

        -- Set alpha
        frameToMove:SetAlpha(ALPHA_DURING_SCALE)

        -- Set the frame as scaling
        frameToMove.DriftIsScaling = true

        -- Reset the previous mouse position
        DriftHelpers.prevMouseX = nil
        DriftHelpers.prevMouseY = nil

        -- Set the global frame being scaled
        DriftHelpers.frameBeingScaled = frameToMove
    end
end

local function onDragStop(frame)
    local frameToMove = frame.DriftDelegate or frame

    -- Stop moving or scaling and reset alpha
    frameToMove:StopMovingOrSizing()
    frameToMove:SetAlpha(1)

    -- Set IsUserPlaced to true
    frameToMove:SetUserPlaced(true)

    -- Clear frame's moving state
    frameToMove.DriftIsMoving = false

    -- Clear frame's scaling state
    frameToMove.DriftIsScaling = false

    -- Clear global frame being scaled
    DriftHelpers.frameBeingScaled = nil

    -- Hide GameTooltip
    GameTooltip:Hide()

    -- Save position
    local point, relativeTo, relativePoint, xOfs, yOfs = frameToMove:GetPoint()
    DriftPoints[frameToMove:GetName()] = {
        ["point"] = point,
        ["relativeTo"] = "UIParent",
        ["relativePoint"] = relativePoint,
        ["xOfs"] = xOfs,
        ["yOfs"] = yOfs
    }

    -- Save scale
    DriftScales[frameToMove:GetName()] = frameToMove:GetScale()
end

local function resetScaleAndPosition(frame)
    local frameToMove = frame.DriftDelegate or frame

    if frameCannotBeModified(frameToMove) then
        return
    end

    -- Do not reset if frame is moving or scaling
    if frameToMove.DriftIsMoving or frameToMove.DriftIsScaling then
        return
    end

    -- Reset scale
    local scale = DriftScales[frameToMove:GetName()]
    if scale then
        frameToMove:SetScale(scale)
    end

    -- Reset position
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

local function makeModifiable(frame)
    if frame.DriftModifiable then
        return
    end

    local frameToMove = frame.DriftDelegate or frame
    frame:SetMovable(true)
    frameToMove:SetMovable(true)
    frame:EnableMouse(true)
    frame:SetClampedToScreen(true)
    frame:RegisterForDrag("LeftButton", "RightButton")
    frame:SetScript("OnDragStart", onDragStart)
    frame:SetScript("OnDragStop", onDragStop)

    frame.DriftModifiable = true
end

local function makeSticky(frame, frames)
    if frame.DriftSticky then
        return
    end

    frame:HookScript(
        "OnShow",
        function(self, event, ...)
            resetScaleAndPosition(frame)
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
                resetScaleAndPosition(frame)
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
                        resetScaleAndPosition(frame)
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
    -- Do not modify frames during combat
    if (getInCombatLockdown()) then
        return
    end

    -- Set up scaling
    if DriftHelpers.scaleHandlerFrame == nil then
        DriftHelpers.scaleHandlerFrame = CreateFrame("Frame", "ScaleHandlerFrame", UIParent)
        DriftHelpers.scaleHandlerFrame:SetScript(
            "OnUpdate",
            function(self)
                if (DriftHelpers.frameBeingScaled) then
                    -- Get current mouse position
                    local curMouseX, curMouseY = GetCursorPosition()

                    -- Only try to scale once there was at least one previous position
                    if DriftHelpers.prevMouseX and DriftHelpers.prevMouseY then
                        if curMouseY > DriftHelpers.prevMouseY then
                            -- Add to scale
                            local newScale = math.min(
                                DriftHelpers.frameBeingScaled:GetScale() + SCALE_INCREMENT,
                                MAX_SCALE
                            )

                            -- Scale
                            DriftHelpers.frameBeingScaled:SetScale(newScale)
                        elseif curMouseY < DriftHelpers.prevMouseY then
                            -- Subtract from scale
                            local newScale = math.max(
                                DriftHelpers.frameBeingScaled:GetScale() - SCALE_INCREMENT,
                                MIN_SCALE
                            )

                            -- Scale
                            DriftHelpers.frameBeingScaled:SetScale(newScale)
                        end
                    end

                    -- Update tooltip
                    GameTooltip:SetOwner(DriftHelpers.frameBeingScaled)
                    GameTooltip:SetText(
                        "" .. math.floor(DriftHelpers.frameBeingScaled:GetScale() * 100) .. "%",
                        1.0, -- red
                        1.0, -- green
                        1.0, -- blue
                        1.0, -- alpha
                        true -- wrap
                    )

                    -- Update previous mouse position
                    DriftHelpers.prevMouseX = curMouseX
                    DriftHelpers.prevMouseY = curMouseY
                end
            end
        )
    end

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

            makeModifiable(frame)
            makeSticky(frame, frames)
            makeTabsSticky(frame, frames)
        end
    end

    -- ClearAllPoints is needed to avoid Lua errors
    if EncounterJournalTooltip then
        EncounterJournalTooltip:ClearAllPoints()
    end

    -- Fix bags
    DriftHelpers:FixBags()

    -- Fix PVP talents list
    DriftHelpers:FixPVPTalentsList(frames)

    -- Fix TalkingHeadFrame
    DriftHelpers:FixTalkingHeadFrame()

    -- Fix ZoneAbilityFrame
    DriftHelpers:FixZoneAbilityFrame()

    -- Reset everything in case there was a delay
    DriftHelpers:BroadcastReset(frames)
end

-- Fix bag Lua errors
function DriftHelpers:FixBags()
    -- Set UpdateContainerFrameAnchors to do nothing
    UpdateContainerFrameAnchorsO = UpdateContainerFrameAnchors
    UpdateContainerFrameAnchors = function () end

    -- Clear all points on all Containers
    _G['ContainerFrame1']:ClearAllPoints()
    _G['ContainerFrame1'].ClickableTitleFrame:ClearAllPoints()

    _G['ContainerFrame2']:ClearAllPoints()
    _G['ContainerFrame2'].ClickableTitleFrame:ClearAllPoints()

    _G['ContainerFrame3']:ClearAllPoints()
    _G['ContainerFrame3'].ClickableTitleFrame:ClearAllPoints()

    _G['ContainerFrame4']:ClearAllPoints()
    _G['ContainerFrame4'].ClickableTitleFrame:ClearAllPoints()

    _G['ContainerFrame5']:ClearAllPoints()
    _G['ContainerFrame5'].ClickableTitleFrame:ClearAllPoints()

    _G['ContainerFrame6']:ClearAllPoints()
    _G['ContainerFrame6'].ClickableTitleFrame:ClearAllPoints()

    _G['ContainerFrame7']:ClearAllPoints()
    _G['ContainerFrame7'].ClickableTitleFrame:ClearAllPoints()

    _G['ContainerFrame8']:ClearAllPoints()
    _G['ContainerFrame8'].ClickableTitleFrame:ClearAllPoints()

    _G['ContainerFrame9']:ClearAllPoints()
    _G['ContainerFrame9'].ClickableTitleFrame:ClearAllPoints()

    _G['ContainerFrame10']:ClearAllPoints()
    _G['ContainerFrame10'].ClickableTitleFrame:ClearAllPoints()

    _G['ContainerFrame11']:ClearAllPoints()
    _G['ContainerFrame11'].ClickableTitleFrame:ClearAllPoints()

    _G['ContainerFrame12']:ClearAllPoints()
    _G['ContainerFrame12'].ClickableTitleFrame:ClearAllPoints()

    _G['ContainerFrame13']:ClearAllPoints()
    _G['ContainerFrame13'].ClickableTitleFrame:ClearAllPoints()

    -- Put back the original UpdateContainerFrameAnchors
    UpdateContainerFrameAnchors = UpdateContainerFrameAnchorsO
end

-- Make it so clicking Close button for PVP talents causes reset
function DriftHelpers:FixPVPTalentsList(frames)
    local talentListFrame = _G['PlayerTalentFrameTalentsPvpTalentFrameTalentList']
    if (talentListFrame) then
        talentListFrame:HookScript(
            "OnHide",
            function(self, event, ...)
                DriftHelpers:BroadcastReset(frames)
            end
        )
    end
end

-- Remove TalkingHeadFrame from list of frames managed by UIParent
function DriftHelpers:FixTalkingHeadFrame()
    if (TalkingHeadFrame and TalkingHeadFrame.DriftModifiable) then
        UIPARENT_MANAGED_FRAME_POSITIONS["TalkingHeadFrame"] = nil
    end
end

-- Remove ZoneAbilityFrame from list of frames managed by UIParent
function DriftHelpers:FixZoneAbilityFrame()
    if (ZoneAbilityFrame and ZoneAbilityFrame.DriftModifiable) then
        UIPARENT_MANAGED_FRAME_POSITIONS["ZoneAbilityFrame"] = nil
    end
end

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

local function createButton(name, point, relativeFrame, relativePoint, xOffset, yOffset, width, height, text, tooltipText, onClickFunction)
    local button = CreateFrame("Button", name, relativeFrame, "GameMenuButtonTemplate")
    button:SetPoint(point, relativeFrame, relativePoint, xOffset, yOffset)
    button:SetSize(width, height)
    button:SetText(text)
    button:SetNormalFontObject("GameFontNormal")
    button:SetHighlightFontObject("GameFontHighlight")

    -- Configure tooltip
    button.tooltipText = tooltipText
    button:SetScript(
        "OnEnter",
        function()
            GameTooltip:SetOwner(button, "ANCHOR_TOPRIGHT")
            GameTooltip:SetText(button.tooltipText, nil, nil, nil, nil, true)
        end
    )

    -- Configure click function
    button:SetScript("OnClick", onClickFunction)

    return button
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
    UIDropDownMenu_JustifyText(dropdown, "LEFT")
    UIDropDownMenu_SetSelectedID(dropdown, DriftOptions.dragKey or 1)
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

-- Global functions
function DriftHelpers:SetupConfig()
    -- Make parent panel
    DriftOptionsPanel.panel = CreateFrame("Frame", "DriftOptionsPanel", UIParent)
    DriftOptionsPanel.panel.name = "Drift"
    local driftOptionsTitle = DriftOptionsPanel.panel:CreateFontString(nil, "BACKGROUND")
    driftOptionsTitle:SetFontObject("GameFontNormalLarge")
    driftOptionsTitle:SetText("Drift")
    driftOptionsTitle:SetPoint("TOPLEFT", DriftOptionsPanel.panel, "TOPLEFT", 16, -15)

    local driftOptionsDesc = DriftOptionsPanel.panel:CreateFontString(nil, "BACKGROUND")
    driftOptionsDesc:SetFontObject("GameFontHighlight")
    driftOptionsDesc:SetText("Modifies default UI frames so you can click and drag to move them around.")
    driftOptionsDesc:SetPoint("TOPLEFT", DriftOptionsPanel.panel, "TOPLEFT", 16, -45)

    local driftOptionsVersionLabel = DriftOptionsPanel.panel:CreateFontString(nil, "BACKGROUND")
    driftOptionsVersionLabel:SetFontObject("GameFontNormal")
    driftOptionsVersionLabel:SetText("Version:")
    driftOptionsVersionLabel:SetJustifyH("LEFT")
    driftOptionsVersionLabel:SetPoint("TOPLEFT", DriftOptionsPanel.panel, "TOPLEFT", 16, -90)

    local driftOptionsVersionContent = DriftOptionsPanel.panel:CreateFontString(nil, "BACKGROUND")
    driftOptionsVersionContent:SetFontObject("GameFontHighlight")
    driftOptionsVersionContent:SetText(GetAddOnMetadata("Drift", "Version"))
    driftOptionsVersionContent:SetJustifyH("LEFT")
    driftOptionsVersionContent:SetPoint("TOPLEFT", DriftOptionsPanel.panel, "TOPLEFT", 75, -90)

    local driftOptionsAuthorLabel = DriftOptionsPanel.panel:CreateFontString(nil, "BACKGROUND")
    driftOptionsAuthorLabel:SetFontObject("GameFontNormal")
    driftOptionsAuthorLabel:SetText("Author:")
    driftOptionsAuthorLabel:SetJustifyH("LEFT")
    driftOptionsAuthorLabel:SetPoint("TOPLEFT", DriftOptionsPanel.panel, "TOPLEFT", 16, -110)

    local driftOptionsAuthorContent = DriftOptionsPanel.panel:CreateFontString(nil, "BACKGROUND")
    driftOptionsAuthorContent:SetFontObject("GameFontHighlight")
    driftOptionsAuthorContent:SetText("Jared Wasserman")
    driftOptionsAuthorContent:SetJustifyH("LEFT")
    driftOptionsAuthorContent:SetPoint("TOPLEFT", DriftOptionsPanel.panel, "TOPLEFT", 75, -110)

    InterfaceOptions_AddCategory(DriftOptionsPanel.panel)

    -- Make a child panel
    DriftOptionsPanel.childpanel = CreateFrame("Frame", "DriftOptionsPanelChild", DriftOptionsPanel.panel)
    DriftOptionsPanel.childpanel.name = "General Options"
    DriftOptionsPanel.childpanel.parent = DriftOptionsPanel.panel.name
    local driftOptionsChildTitle = DriftOptionsPanel.childpanel:CreateFontString(nil, "BACKGROUND")
    driftOptionsChildTitle:SetFontObject("GameFontNormalLarge")
    driftOptionsChildTitle:SetText("General Options")
    driftOptionsChildTitle:SetPoint("TOPLEFT", DriftOptionsPanel.childpanel, "TOPLEFT", 16, -15)
    InterfaceOptions_AddCategory(DriftOptionsPanel.childpanel)

    -- Child panel content
    DriftOptionsPanel.config.framesAreLockedCheckbox = createCheckbox(
        "FramesAreLockedCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.childpanel,
        "TOPLEFT",
        14,
        -50,
        " Lock Frames",
        "While frames are locked, the Drag Key must be pressed when starting to drag a frame.",
        nil
    )
    DriftOptionsPanel.config.framesAreLockedCheckbox:SetChecked(DriftOptions.framesAreLocked)

    local dragKeyDropdownTitle = DriftOptionsPanel.childpanel:CreateFontString(nil, "BACKGROUND")
    dragKeyDropdownTitle:SetFontObject("GameFontNormal")
    dragKeyDropdownTitle:SetText("Drag Key")
    dragKeyDropdownTitle:SetPoint("TOPLEFT", DriftOptionsPanel.childpanel, "TOPLEFT", 20, -82)

    DriftOptionsPanel.config.dragKeyDropdown = createDragKeyDropdown(
        "DragKeyDropdown",
        "TOPLEFT",
        DriftOptionsPanel.childpanel,
        "TOPLEFT",
        0,
        -100
    )
    DriftOptions.dragKeyFunc = getDragKeyFuncFromOrdinal(DriftOptions.dragKey)

    StaticPopupDialogs["DRIFT_RESET_POSITIONS"] = {
        text = "Are you sure you want to reset all frames to their original positions?",
        button1 = "Yes",
        button2 = "No",
        OnAccept = function()
            DriftPoints = {}
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3, -- avoid UI taint
    }
    DriftOptionsPanel.config.resetButton = createButton(
        "ResetButton",
        "TOPLEFT",
        DriftOptionsPanel.childpanel,
        "TOPLEFT",
        15,
        -145,
        160,
        25,
        "Reset Frame Positions",
        "Reset all frames to their original positions",
        function (self, button, down)
            StaticPopup_Show("DRIFT_RESET_POSITIONS")
        end
    )

    -- Update logic
    DriftOptionsPanel.panel.okay = function (self)
        DriftOptions.framesAreLocked = DriftOptionsPanel.config.framesAreLockedCheckbox:GetChecked()
        DriftOptions.dragKey = UIDropDownMenu_GetSelectedID(DriftOptionsPanel.config.dragKeyDropdown)
        DriftOptions.dragKeyFunc = getDragKeyFuncFromOrdinal(DriftOptions.dragKey)
    end
end
