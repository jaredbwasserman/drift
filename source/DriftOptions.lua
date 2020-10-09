--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------

-- Variables for config
if not DriftOptions then DriftOptions = {} end
local DriftOptionsPanel = {}
DriftOptionsPanel.config = {}

-- Variables for slash commands
local DRIFTRESET = "DRIFTRESET"
SLASH_DRIFTRESET1 = "/driftreset"

-- Other variables
local DROPDOWN_KEYS = {
    "ALT key",
    "CTRL key",
    "SHIFT key",
    "None"
}


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

local function createKeyDropdown(name, point, relativeFrame, relativePoint, xOffset, yOffset, selected)
    local dropdown = CreateFrame("Frame", name, relativeFrame, "UIDropDownMenuTemplate")
    dropdown:SetPoint(point, relativeFrame, relativePoint, xOffset, yOffset)

    local function OnClick(self)
        UIDropDownMenu_SetSelectedID(dropdown, self:GetID())
    end

    local function initialize(self, level)
        local info = UIDropDownMenu_CreateInfo()
        for k, v in pairs(DROPDOWN_KEYS) do
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
    UIDropDownMenu_SetSelectedID(dropdown, selected or 1)
    return dropdown
end

local function getKeyFuncFromOrdinal(ordinal)
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
    driftOptionsDesc:SetText("Modifies default UI frames so you can click and drag to move and scale.")
    driftOptionsDesc:SetPoint("TOPLEFT", DriftOptionsPanel.panel, "TOPLEFT", 16, -45)

    local driftOptionsInstr = DriftOptionsPanel.panel:CreateFontString(nil, "BACKGROUND")
    driftOptionsInstr:SetFontObject("GameFontHighlight")
    driftOptionsInstr:SetText("Left-click and drag anywhere to move a frame.")
    driftOptionsInstr:SetPoint("TOPLEFT", DriftOptionsPanel.panel, "TOPLEFT", 16, -75)

    local driftOptionsInstr2 = DriftOptionsPanel.panel:CreateFontString(nil, "BACKGROUND")
    driftOptionsInstr2:SetFontObject("GameFontHighlight")
    driftOptionsInstr2:SetText("Right-click and drag up or down to scale a frame.")
    driftOptionsInstr2:SetPoint("TOPLEFT", DriftOptionsPanel.panel, "TOPLEFT", 16, -90)

    local driftOptionsInstr3 = DriftOptionsPanel.panel:CreateFontString(nil, "BACKGROUND")
    driftOptionsInstr3:SetFontObject("GameFontHighlight")
    driftOptionsInstr3:SetText("Position and scale for each frame are saved.")
    driftOptionsInstr3:SetPoint("TOPLEFT", DriftOptionsPanel.panel, "TOPLEFT", 16, -105)

    local driftOptionsVersionLabel = DriftOptionsPanel.panel:CreateFontString(nil, "BACKGROUND")
    driftOptionsVersionLabel:SetFontObject("GameFontNormal")
    driftOptionsVersionLabel:SetText("Version:")
    driftOptionsVersionLabel:SetJustifyH("LEFT")
    driftOptionsVersionLabel:SetPoint("TOPLEFT", DriftOptionsPanel.panel, "TOPLEFT", 16, -135)

    local driftOptionsVersionContent = DriftOptionsPanel.panel:CreateFontString(nil, "BACKGROUND")
    driftOptionsVersionContent:SetFontObject("GameFontHighlight")
    driftOptionsVersionContent:SetText(GetAddOnMetadata("Drift", "Version"))
    driftOptionsVersionContent:SetJustifyH("LEFT")
    driftOptionsVersionContent:SetPoint("TOPLEFT", DriftOptionsPanel.panel, "TOPLEFT", 75, -135)

    local driftOptionsAuthorLabel = DriftOptionsPanel.panel:CreateFontString(nil, "BACKGROUND")
    driftOptionsAuthorLabel:SetFontObject("GameFontNormal")
    driftOptionsAuthorLabel:SetText("Author:")
    driftOptionsAuthorLabel:SetJustifyH("LEFT")
    driftOptionsAuthorLabel:SetPoint("TOPLEFT", DriftOptionsPanel.panel, "TOPLEFT", 16, -150)

    local driftOptionsAuthorContent = DriftOptionsPanel.panel:CreateFontString(nil, "BACKGROUND")
    driftOptionsAuthorContent:SetFontObject("GameFontHighlight")
    driftOptionsAuthorContent:SetText("Jared Wasserman")
    driftOptionsAuthorContent:SetJustifyH("LEFT")
    driftOptionsAuthorContent:SetPoint("TOPLEFT", DriftOptionsPanel.panel, "TOPLEFT", 75, -150)

    InterfaceOptions_AddCategory(DriftOptionsPanel.panel)

    -- Slash Commands panel
    DriftOptionsPanel.slashpanel = CreateFrame("Frame", "DriftSlashCommandsPanelChild", DriftOptionsPanel.panel)
    DriftOptionsPanel.slashpanel.name = "Slash Commands"
    DriftOptionsPanel.slashpanel.parent = DriftOptionsPanel.panel.name
    local driftSlashChildTitle = DriftOptionsPanel.slashpanel:CreateFontString(nil, "BACKGROUND")
    driftSlashChildTitle:SetFontObject("GameFontNormalLarge")
    driftSlashChildTitle:SetText("Slash Commands")
    driftSlashChildTitle:SetPoint("TOPLEFT", DriftOptionsPanel.slashpanel, "TOPLEFT", 16, -15)
    InterfaceOptions_AddCategory(DriftOptionsPanel.slashpanel)

    -- Slash Commands panel content
    local slashResetTitle = DriftOptionsPanel.slashpanel:CreateFontString(nil, "BACKGROUND")
    slashResetTitle:SetFontObject("GameFontNormal")
    slashResetTitle:SetText("Reset Frames")
    slashResetTitle:SetPoint("TOPLEFT", DriftOptionsPanel.slashpanel, "TOPLEFT", 16, -45)

    local slashResetCommand = DriftOptionsPanel.slashpanel:CreateFontString(nil, "BACKGROUND")
    slashResetCommand:SetFontObject("GameFontHighlight")
    slashResetCommand:SetText("/driftreset")
    slashResetCommand:SetPoint("TOPLEFT", DriftOptionsPanel.slashpanel, "TOPLEFT", 16, -65)

    local slashResetInfo = DriftOptionsPanel.slashpanel:CreateFontString(nil, "BACKGROUND")
    slashResetInfo:SetFontObject("GameFontHighlight")
    slashResetInfo:SetText("Reset position and scale for all frames.")
    slashResetInfo:SetPoint("TOPLEFT", DriftOptionsPanel.slashpanel, "TOPLEFT", 16, -80)

    -- Options panel
    DriftOptionsPanel.optionspanel = CreateFrame("Frame", "DriftOptionsPanelChild", DriftOptionsPanel.panel)
    DriftOptionsPanel.optionspanel.name = "Options"
    DriftOptionsPanel.optionspanel.parent = DriftOptionsPanel.panel.name
    local driftOptionsChildTitle = DriftOptionsPanel.optionspanel:CreateFontString(nil, "BACKGROUND")
    driftOptionsChildTitle:SetFontObject("GameFontNormalLarge")
    driftOptionsChildTitle:SetText("Options")
    driftOptionsChildTitle:SetPoint("TOPLEFT", DriftOptionsPanel.optionspanel, "TOPLEFT", 16, -15)
    InterfaceOptions_AddCategory(DriftOptionsPanel.optionspanel)

    -- Options panel content
    -- Frame Movement
    local lockMoveTitle = DriftOptionsPanel.optionspanel:CreateFontString(nil, "BACKGROUND")
    lockMoveTitle:SetFontObject("GameFontNormal")
    lockMoveTitle:SetText("Frame Movement")
    lockMoveTitle:SetPoint("TOPLEFT", DriftOptionsPanel.optionspanel, "TOPLEFT", 16, -45)

    DriftOptionsPanel.config.frameMoveLockedCheckbox = createCheckbox(
        "FrameMoveLockedCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        13,
        -65,
        " Lock Frame Movement",
        "While frame movement is locked, the Move Key must be pressed to move frames.",
        nil
    )
    DriftOptionsPanel.config.frameMoveLockedCheckbox:SetChecked(DriftOptions.frameDragIsLocked)

    local dragKeyDropdownTitle = DriftOptionsPanel.optionspanel:CreateFontString(nil, "BACKGROUND")
    dragKeyDropdownTitle:SetFontObject("GameFontNormal")
    dragKeyDropdownTitle:SetText("Move Key")
    dragKeyDropdownTitle:SetPoint("TOPLEFT", DriftOptionsPanel.optionspanel, "TOPLEFT", 32, -90)

    DriftOptionsPanel.config.dragKeyDropdown = createKeyDropdown(
        "DragKeyDropdown",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        14,
        -105,
        DriftOptions.dragKey
    )
    DriftOptions.dragKeyFunc = getKeyFuncFromOrdinal(DriftOptions.dragKey)

    -- Frame Scaling
    local lockScaleTitle = DriftOptionsPanel.optionspanel:CreateFontString(nil, "BACKGROUND")
    lockScaleTitle:SetFontObject("GameFontNormal")
    lockScaleTitle:SetText("Frame Scaling")
    lockScaleTitle:SetPoint("TOPLEFT", DriftOptionsPanel.optionspanel, "TOPLEFT", 300, -45)

    DriftOptionsPanel.config.frameScaleLockedCheckbox = createCheckbox(
        "FrameScaleLockedCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        297,
        -65,
        " Lock Frame Scaling",
        "While frame scaling is locked, the Scale Key must be pressed to scale frames.",
        nil
    )
    DriftOptionsPanel.config.frameScaleLockedCheckbox:SetChecked(DriftOptions.frameScaleIsLocked)

    local scaleKeyDropdownTitle = DriftOptionsPanel.optionspanel:CreateFontString(nil, "BACKGROUND")
    scaleKeyDropdownTitle:SetFontObject("GameFontNormal")
    scaleKeyDropdownTitle:SetText("Scale Key")
    scaleKeyDropdownTitle:SetPoint("TOPLEFT", DriftOptionsPanel.optionspanel, "TOPLEFT", 316, -90)

    DriftOptionsPanel.config.scaleKeyDropdown = createKeyDropdown(
        "ScaleKeyDropdown",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        298,
        -105,
        DriftOptions.scaleKey
    )
    DriftOptions.scaleKeyFunc = getKeyFuncFromOrdinal(DriftOptions.scaleKey)

    -- Optional Frames
    local frameToggleTitle = DriftOptionsPanel.optionspanel:CreateFontString(nil, "BACKGROUND")
    frameToggleTitle:SetFontObject("GameFontNormal")
    frameToggleTitle:SetText("Optional Frames")
    frameToggleTitle:SetPoint("TOPLEFT", DriftOptionsPanel.optionspanel, "TOPLEFT", 16, -160)

    DriftOptionsPanel.config.bagsEnabledCheckbox = createCheckbox(
        "BagsEnabledCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        13,
        -180,
        " Bags Enabled",
        "Whether Drift will modify Bags. Enabling or disabling Bags will cause the UI to reload.",
        nil
    )
    DriftOptionsPanel.config.bagsEnabledCheckbox:SetChecked(not DriftOptions.bagsDisabled)

    -- Reset button
    StaticPopupDialogs["DRIFT_RESET_POSITIONS"] = {
        text = "Are you sure you want to reset position and scale for all frames?",
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
        -250,
        132,
        25,
        "Reset Frames",
        "Reset position and scale for all frames.",
        function (self, button, down)
            StaticPopup_Show("DRIFT_RESET_POSITIONS")
        end
    )

    -- Update logic
    DriftOptionsPanel.panel.okay = function (self)
        -- Movement
        DriftOptions.frameDragIsLocked = DriftOptionsPanel.config.frameMoveLockedCheckbox:GetChecked()
        DriftOptions.dragKey = UIDropDownMenu_GetSelectedID(DriftOptionsPanel.config.dragKeyDropdown)
        DriftOptions.dragKeyFunc = getKeyFuncFromOrdinal(DriftOptions.dragKey)

        -- Scaling
        DriftOptions.frameScaleIsLocked = DriftOptionsPanel.config.frameScaleLockedCheckbox:GetChecked()
        DriftOptions.scaleKey = UIDropDownMenu_GetSelectedID(DriftOptionsPanel.config.scaleKeyDropdown)
        DriftOptions.scaleKeyFunc = getKeyFuncFromOrdinal(DriftOptions.scaleKey)

        -- Optional Frames
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

            ReloadUI()
        end
    end

    -- Cancel logic
    DriftOptionsPanel.panel.cancel = function (self)
        -- Movement
        DriftOptionsPanel.config.frameMoveLockedCheckbox:SetChecked(DriftOptions.frameDragIsLocked)
        UIDropDownMenu_SetSelectedID(DriftOptionsPanel.config.dragKeyDropdown, DriftOptions.dragKey or 1)
        UIDropDownMenu_SetText(DriftOptionsPanel.config.dragKeyDropdown, DROPDOWN_KEYS[UIDropDownMenu_GetSelectedID(DriftOptionsPanel.config.dragKeyDropdown)])

        -- Scaling
        DriftOptionsPanel.config.frameScaleLockedCheckbox:SetChecked(DriftOptions.frameScaleIsLocked)
        UIDropDownMenu_SetSelectedID(DriftOptionsPanel.config.scaleKeyDropdown, DriftOptions.scaleKey or 1)
        UIDropDownMenu_SetText(DriftOptionsPanel.config.scaleKeyDropdown, DROPDOWN_KEYS[UIDropDownMenu_GetSelectedID(DriftOptionsPanel.config.scaleKeyDropdown)])

        -- Optional Frames
        DriftOptionsPanel.config.bagsEnabledCheckbox:SetChecked(not DriftOptions.bagsDisabled)
    end
end


--------------------------------------------------------------------------------
-- Slash Commands
--------------------------------------------------------------------------------

SlashCmdList[DRIFTRESET] = DriftHelpers.DeleteDriftState
