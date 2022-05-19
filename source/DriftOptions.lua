--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

-- Variables for config
if not DriftOptions then DriftOptions = {} end
local DriftOptionsPanel = {}
DriftOptionsPanel.config = {}

-- Variables for WoW version 
local isRetail = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)
local isClassic = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
local isBCC = (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC)

-- Variables for slash commands
local DRIFT = "DRIFT"
SLASH_DRIFT1 = "/drift"

local DRIFTRESET = "DRIFTRESET"
SLASH_DRIFTRESET1 = "/driftreset"


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

-- Global functions
function DriftHelpers:SetupConfig()
    -- Initialize config options
    if DriftOptions.frameDragIsLocked == nil then
        DriftOptions.frameDragIsLocked = DriftOptions.framesAreLocked
    end
    if DriftOptions.frameScaleIsLocked == nil then
        DriftOptions.frameScaleIsLocked = DriftOptions.framesAreLocked
    end
    if DriftOptions.windowsDisabled == nil then
        DriftOptions.windowsDisabled = false
    end
    if DriftOptions.bagsDisabled == nil then
        DriftOptions.bagsDisabled = true
    end
    if DriftOptions.buttonsDisabled == nil then
        DriftOptions.buttonsDisabled = true
    end
    if DriftOptions.minimapDisabled == nil then
        DriftOptions.minimapDisabled = true
    end
    if DriftOptions.objectivesDisabled == nil then
        DriftOptions.objectivesDisabled = true
    end
    if DriftOptions.playerChoiceDisabled == nil then
        DriftOptions.playerChoiceDisabled = true
    end
    if DriftOptions.arenaDisabled == nil then
        DriftOptions.arenaDisabled = true
    end
    if DriftOptions.miscellaneousDisabled == nil then
        DriftOptions.miscellaneousDisabled = true
    end

    -- Options panel
    DriftOptionsPanel.optionspanel = CreateFrame("Frame", "DriftOptionsPanel", UIParent)
    DriftOptionsPanel.optionspanel.name = "Drift"
    local driftOptionsTitle = DriftOptionsPanel.optionspanel:CreateFontString(nil, "BACKGROUND")
    driftOptionsTitle:SetFontObject("GameFontNormalLarge")
    driftOptionsTitle:SetText("Drift")
    driftOptionsTitle:SetPoint("TOPLEFT", DriftOptionsPanel.optionspanel, "TOPLEFT", 15, -15)
    InterfaceOptions_AddCategory(DriftOptionsPanel.optionspanel)

    -- Frame Dragging
    local lockMoveTitle = DriftOptionsPanel.optionspanel:CreateFontString(nil, "BACKGROUND")
    lockMoveTitle:SetFontObject("GameFontNormal")
    lockMoveTitle:SetText("Frame Dragging")
    lockMoveTitle:SetPoint("TOPLEFT", DriftOptionsPanel.optionspanel, "TOPLEFT", 190, -90)

    local yOffset = -110

    DriftOptionsPanel.config.frameMoveLockedCheckbox = createCheckbox(
        "FrameMoveLockedCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        190,
        yOffset,
        " Lock Frame Dragging",
        "While frame dragging is locked, a modifier key must be pressed to drag a frame.",
        nil
    )
    DriftOptionsPanel.config.frameMoveLockedCheckbox:SetChecked(DriftOptions.frameDragIsLocked)
    yOffset = yOffset - 30

    DriftOptionsPanel.config.dragAltKeyEnabledCheckbox = createCheckbox(
        "DragAltKeyEnabledCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        205,
        yOffset,
        " ALT To Drag",
        "Whether ALT can be pressed while frame dragging is locked to drag a frame.",
        nil
    )
    DriftOptionsPanel.config.dragAltKeyEnabledCheckbox:SetChecked(DriftOptions.dragAltKeyEnabled)
    yOffset = yOffset - 30

    DriftOptionsPanel.config.dragCtrlKeyEnabledCheckbox = createCheckbox(
        "DragCtrlKeyEnabledCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        205,
        yOffset,
        " CTRL To Drag",
        "Whether CTRL can be pressed while frame dragging is locked to drag a frame.",
        nil
    )
    DriftOptionsPanel.config.dragCtrlKeyEnabledCheckbox:SetChecked(DriftOptions.dragCtrlKeyEnabled)
    yOffset = yOffset - 30

    DriftOptionsPanel.config.dragShiftKeyEnabledCheckbox = createCheckbox(
        "DragShiftKeyEnabledCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        205,
        yOffset,
        " SHIFT To Drag",
        "Whether SHIFT can be pressed while frame dragging is locked to drag a frame.",
        nil
    )
    DriftOptionsPanel.config.dragShiftKeyEnabledCheckbox:SetChecked(DriftOptions.dragShiftKeyEnabled)
    yOffset = yOffset - 40

    -- Frame Scaling
    local lockScaleTitle = DriftOptionsPanel.optionspanel:CreateFontString(nil, "BACKGROUND")
    lockScaleTitle:SetFontObject("GameFontNormal")
    lockScaleTitle:SetText("Frame Scaling")
    lockScaleTitle:SetPoint("TOPLEFT", DriftOptionsPanel.optionspanel, "TOPLEFT", 190, yOffset)
    yOffset = yOffset - 20

    DriftOptionsPanel.config.frameScaleLockedCheckbox = createCheckbox(
        "FrameScaleLockedCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        190,
        yOffset,
        " Lock Frame Scaling",
        "While frame scaling is locked, a modifier key must be pressed to scale a frame.",
        nil
    )
    DriftOptionsPanel.config.frameScaleLockedCheckbox:SetChecked(DriftOptions.frameScaleIsLocked)
    yOffset = yOffset - 30

    DriftOptionsPanel.config.scaleAltKeyEnabledCheckbox = createCheckbox(
        "ScaleAltKeyEnabledCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        205,
        yOffset,
        " ALT To Scale",
        "Whether ALT can be pressed while frame scaling is locked to scale a frame.",
        nil
    )
    DriftOptionsPanel.config.scaleAltKeyEnabledCheckbox:SetChecked(DriftOptions.scaleAltKeyEnabled)
    yOffset = yOffset - 30

    DriftOptionsPanel.config.scaleCtrlKeyEnabledCheckbox = createCheckbox(
        "ScaleCtrlKeyEnabledCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        205,
        yOffset,
        " CTRL To Scale",
        "Whether CTRL can be pressed while frame scaling is locked to scale a frame.",
        nil
    )
    DriftOptionsPanel.config.scaleCtrlKeyEnabledCheckbox:SetChecked(DriftOptions.scaleCtrlKeyEnabled)
    yOffset = yOffset - 30

    DriftOptionsPanel.config.scaleShiftKeyEnabledCheckbox = createCheckbox(
        "ScaleShiftKeyEnabledCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        205,
        yOffset,
        " SHIFT To Scale",
        "Whether SHIFT can be pressed while frame scaling is locked to scale a frame.",
        nil
    )
    DriftOptionsPanel.config.scaleShiftKeyEnabledCheckbox:SetChecked(DriftOptions.scaleShiftKeyEnabled)

    -- Enabled Frames
    local frameToggleTitle = DriftOptionsPanel.optionspanel:CreateFontString(nil, "BACKGROUND")
    frameToggleTitle:SetFontObject("GameFontNormal")
    frameToggleTitle:SetText("Enabled Frames")
    frameToggleTitle:SetPoint("TOPLEFT", DriftOptionsPanel.optionspanel, "TOPLEFT", 15, -90)

    yOffset = -110

    DriftOptionsPanel.config.windowsEnabledCheckbox = createCheckbox(
        "WindowsEnabledCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        15,
        yOffset,
        " Windows",
        "Whether Drift will modify Windows (example: Talents).",
        nil
    )
    DriftOptionsPanel.config.windowsEnabledCheckbox:SetChecked(not DriftOptions.windowsDisabled)
    yOffset = yOffset - 30

    DriftOptionsPanel.config.bagsEnabledCheckbox = createCheckbox(
        "BagsEnabledCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        15,
        yOffset,
        " Bags",
        "Whether Drift will modify Bags.",
        nil
    )
    DriftOptionsPanel.config.bagsEnabledCheckbox:SetChecked(not DriftOptions.bagsDisabled)
    yOffset = yOffset - 30

    DriftOptionsPanel.config.buttonsEnabledCheckbox = createCheckbox(
        "ButtonsEnabledCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        15,
        yOffset,
        " Buttons",
        "Whether Drift will modify Buttons (example: Open Ticket).",
        nil
    )
    DriftOptionsPanel.config.buttonsEnabledCheckbox:SetChecked(not DriftOptions.buttonsDisabled)
    yOffset = yOffset - 30

    DriftOptionsPanel.config.minimapEnabledCheckbox = createCheckbox(
        "MinimapEnabledCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        15,
        yOffset,
        " Minimap",
        "Whether Drift will modify the Minimap.",
        nil
    )
    DriftOptionsPanel.config.minimapEnabledCheckbox:SetChecked(not DriftOptions.minimapDisabled)
    yOffset = yOffset - 30

    local objectivesTitle = " Objective Tracker"
    local objectivesDesc = "Whether Drift will modify the Objective Tracker."
    if (isClassic or isBCC) then
        objectivesTitle = " Quest Watch List"
        objectivesDesc = "Whether Drift will modify the Quest Watch List."
    end
    DriftOptionsPanel.config.objectivesEnabledCheckbox = createCheckbox(
        "ObjectivesEnabledCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        15,
        yOffset,
        objectivesTitle,
        objectivesDesc,
        nil
    )
    DriftOptionsPanel.config.objectivesEnabledCheckbox:SetChecked(not DriftOptions.objectivesDisabled)
    yOffset = yOffset - 30

    if (isRetail) then
        DriftOptionsPanel.config.playerChoiceEnabledCheckbox = createCheckbox(
            "PlayerChoiceEnabledCheckbox",
            "TOPLEFT",
            DriftOptionsPanel.optionspanel,
            "TOPLEFT",
            15,
            yOffset,
            " Player Choice",
            "Whether Drift will modify the Player Choice Frame.",
            nil
        )
        DriftOptionsPanel.config.playerChoiceEnabledCheckbox:SetChecked(not DriftOptions.playerChoiceDisabled)
        yOffset = yOffset - 30

        DriftOptionsPanel.config.arenaEnabledCheckbox = createCheckbox(
            "ArenaEnabledCheckbox",
            "TOPLEFT",
            DriftOptionsPanel.optionspanel,
            "TOPLEFT",
            15,
            yOffset,
            " Arena",
            "Whether Drift will modify Arena Frames.",
            nil
        )
        DriftOptionsPanel.config.arenaEnabledCheckbox:SetChecked(not DriftOptions.arenaDisabled)
        yOffset = yOffset - 30
    end

    DriftOptionsPanel.config.miscellaneousEnabledCheckbox = createCheckbox(
        "MiscellaneousEnabledCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        15,
        yOffset,
        " Miscellaneous",
        "Whether Drift will modify Miscellaneous Frames (example: Battle.net Toast).",
        nil
    )
    DriftOptionsPanel.config.miscellaneousEnabledCheckbox:SetChecked(not DriftOptions.miscellaneousDisabled)

    -- Reset button
    StaticPopupDialogs["DRIFT_RESET_POSITIONS"] = {
        text = "Are you sure you want to reset position and scale for all modified frames?",
        button1 = "Yes",
        button2 = "No",
        OnAccept = DriftHelpers.DeleteDriftState,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3, -- avoid UI taint
    }
    DriftOptionsPanel.config.resetButton = createButton(
        "ResetButton",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        15,
        -47,
        132,
        25,
        "Reset Frames",
        "Reset position and scale for all modified frames.",
        function (self, button, down)
            StaticPopup_Show("DRIFT_RESET_POSITIONS")
        end
    )

    -- Version and author
    local driftOptionsVersionLabel = DriftOptionsPanel.optionspanel:CreateFontString(nil, "BACKGROUND")
    driftOptionsVersionLabel:SetFontObject("GameFontNormal")
    driftOptionsVersionLabel:SetText("Version:")
    driftOptionsVersionLabel:SetJustifyH("LEFT")
    driftOptionsVersionLabel:SetPoint("BOTTOMLEFT", DriftOptionsPanel.optionspanel, "BOTTOMLEFT", 15, 30)

    local driftOptionsVersionContent = DriftOptionsPanel.optionspanel:CreateFontString(nil, "BACKGROUND")
    driftOptionsVersionContent:SetFontObject("GameFontHighlight")
    driftOptionsVersionContent:SetText(GetAddOnMetadata("Drift", "Version"))
    driftOptionsVersionContent:SetJustifyH("LEFT")
    driftOptionsVersionContent:SetPoint("BOTTOMLEFT", DriftOptionsPanel.optionspanel, "BOTTOMLEFT", 70, 30)

    local driftOptionsAuthorLabel = DriftOptionsPanel.optionspanel:CreateFontString(nil, "BACKGROUND")
    driftOptionsAuthorLabel:SetFontObject("GameFontNormal")
    driftOptionsAuthorLabel:SetText("Author:")
    driftOptionsAuthorLabel:SetJustifyH("LEFT")
    driftOptionsAuthorLabel:SetPoint("BOTTOMLEFT", DriftOptionsPanel.optionspanel, "BOTTOMLEFT", 15, 15)

    local driftOptionsAuthorContent = DriftOptionsPanel.optionspanel:CreateFontString(nil, "BACKGROUND")
    driftOptionsAuthorContent:SetFontObject("GameFontHighlight")
    driftOptionsAuthorContent:SetText("Jared Wasserman")
    driftOptionsAuthorContent:SetJustifyH("LEFT")
    driftOptionsAuthorContent:SetPoint("BOTTOMLEFT", DriftOptionsPanel.optionspanel, "BOTTOMLEFT", 70, 15)

    -- Update logic
    DriftOptionsPanel.optionspanel.okay = function (self)
        local shouldReloadUI = false

        -- Dragging
        DriftOptions.frameDragIsLocked = DriftOptionsPanel.config.frameMoveLockedCheckbox:GetChecked()
        DriftOptions.dragAltKeyEnabled = DriftOptionsPanel.config.dragAltKeyEnabledCheckbox:GetChecked()
        DriftOptions.dragCtrlKeyEnabled = DriftOptionsPanel.config.dragCtrlKeyEnabledCheckbox:GetChecked()
        DriftOptions.dragShiftKeyEnabled = DriftOptionsPanel.config.dragShiftKeyEnabledCheckbox:GetChecked()

        -- Scaling
        DriftOptions.frameScaleIsLocked = DriftOptionsPanel.config.frameScaleLockedCheckbox:GetChecked()
        DriftOptions.scaleAltKeyEnabled = DriftOptionsPanel.config.scaleAltKeyEnabledCheckbox:GetChecked()
        DriftOptions.scaleCtrlKeyEnabled = DriftOptionsPanel.config.scaleCtrlKeyEnabledCheckbox:GetChecked()
        DriftOptions.scaleShiftKeyEnabled = DriftOptionsPanel.config.scaleShiftKeyEnabledCheckbox:GetChecked()

        -- Optional Frames
        local oldWindowsDisabled = DriftOptions.windowsDisabled
        DriftOptions.windowsDisabled = not DriftOptionsPanel.config.windowsEnabledCheckbox:GetChecked()
        if oldWindowsDisabled ~= DriftOptions.windowsDisabled then
            shouldReloadUI = true
        end

        local oldBagsDisabled = DriftOptions.bagsDisabled
        DriftOptions.bagsDisabled = not DriftOptionsPanel.config.bagsEnabledCheckbox:GetChecked()
        if oldBagsDisabled ~= DriftOptions.bagsDisabled then
            if DriftOptions.bagsDisabled then
                -- Fix bag lua errors
                for i=1,13 do
                    _G['ContainerFrame'..i]:ClearAllPoints()
                    _G['ContainerFrame'..i]:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0)
                end
            end

            shouldReloadUI = true
        end

        local oldButtonsDisabled = DriftOptions.buttonsDisabled
        DriftOptions.buttonsDisabled = not DriftOptionsPanel.config.buttonsEnabledCheckbox:GetChecked()
        if oldButtonsDisabled ~= DriftOptions.buttonsDisabled then
            shouldReloadUI = true
        end

        local oldMinimapDisabled = DriftOptions.minimapDisabled
        DriftOptions.minimapDisabled = not DriftOptionsPanel.config.minimapEnabledCheckbox:GetChecked()
        if oldMinimapDisabled ~= DriftOptions.minimapDisabled then
            shouldReloadUI = true
        end

        local oldObjectivesDisabled = DriftOptions.objectivesDisabled
        DriftOptions.objectivesDisabled = not DriftOptionsPanel.config.objectivesEnabledCheckbox:GetChecked()
        if oldObjectivesDisabled ~= DriftOptions.objectivesDisabled then
            shouldReloadUI = true
        end

        if (isRetail) then
            local oldPlayerChoiceDisabled = DriftOptions.playerChoiceDisabled
            DriftOptions.playerChoiceDisabled = not DriftOptionsPanel.config.playerChoiceEnabledCheckbox:GetChecked()
            if oldPlayerChoiceDisabled ~= DriftOptions.playerChoiceDisabled then
                shouldReloadUI = true
            end

            local oldArenaDisabled = DriftOptions.arenaDisabled
            DriftOptions.arenaDisabled = not DriftOptionsPanel.config.arenaEnabledCheckbox:GetChecked()
            if oldArenaDisabled ~= DriftOptions.arenaDisabled then
                shouldReloadUI = true
            end
        end

        local oldMiscellaneousDisabled = DriftOptions.miscellaneousDisabled
        DriftOptions.miscellaneousDisabled = not DriftOptionsPanel.config.miscellaneousEnabledCheckbox:GetChecked()
        if oldMiscellaneousDisabled ~= DriftOptions.miscellaneousDisabled then
            shouldReloadUI = true
        end

        -- Reload if needed
        if shouldReloadUI then
            ReloadUI()
        end
    end

    -- Cancel logic
    DriftOptionsPanel.optionspanel.cancel = function (self)
        -- Dragging
        DriftOptionsPanel.config.frameMoveLockedCheckbox:SetChecked(DriftOptions.frameDragIsLocked)
        DriftOptionsPanel.config.dragAltKeyEnabledCheckbox:SetChecked(DriftOptions.dragAltKeyEnabled)
        DriftOptionsPanel.config.dragCtrlKeyEnabledCheckbox:SetChecked(DriftOptions.dragCtrlKeyEnabled)
        DriftOptionsPanel.config.dragShiftKeyEnabledCheckbox:SetChecked(DriftOptions.dragShiftKeyEnabled)

        -- Scaling
        DriftOptionsPanel.config.frameScaleLockedCheckbox:SetChecked(DriftOptions.frameScaleIsLocked)
        DriftOptionsPanel.config.scaleAltKeyEnabledCheckbox:SetChecked(DriftOptions.scaleAltKeyEnabled)
        DriftOptionsPanel.config.scaleCtrlKeyEnabledCheckbox:SetChecked(DriftOptions.scaleCtrlKeyEnabled)
        DriftOptionsPanel.config.scaleShiftKeyEnabledCheckbox:SetChecked(DriftOptions.scaleShiftKeyEnabled)

        -- Optional Frames
        DriftOptionsPanel.config.windowsEnabledCheckbox:SetChecked(not DriftOptions.windowsDisabled)

        DriftOptionsPanel.config.bagsEnabledCheckbox:SetChecked(not DriftOptions.bagsDisabled)

        DriftOptionsPanel.config.buttonsEnabledCheckbox:SetChecked(not DriftOptions.buttonsDisabled)

        DriftOptionsPanel.config.minimapEnabledCheckbox:SetChecked(not DriftOptions.minimapDisabled)

        DriftOptionsPanel.config.objectivesEnabledCheckbox:SetChecked(not DriftOptions.objectivesDisabled)

        if (isRetail) then
            DriftOptionsPanel.config.playerChoiceEnabledCheckbox:SetChecked(not DriftOptions.playerChoiceDisabled)

            DriftOptionsPanel.config.arenaEnabledCheckbox:SetChecked(not DriftOptions.arenaDisabled)
        end

        DriftOptionsPanel.config.miscellaneousEnabledCheckbox:SetChecked(not DriftOptions.miscellaneousDisabled)
    end
end


--------------------------------------------------------------------------------
-- Slash Commands
--------------------------------------------------------------------------------

SlashCmdList[DRIFT] = function(msg, editBox)
    DriftHelpers:HandleSlashCommands(msg, editBox)
end

SlashCmdList[DRIFTRESET] = DriftHelpers.DeleteDriftState
