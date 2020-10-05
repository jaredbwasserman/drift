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
    slashResetCommand:SetPoint("TOPLEFT", DriftOptionsPanel.slashpanel, "TOPLEFT", 16, -60)

    local slashResetInfo = DriftOptionsPanel.slashpanel:CreateFontString(nil, "BACKGROUND")
    slashResetInfo:SetFontObject("GameFontHighlight")
    slashResetInfo:SetText("Reset position and scale for all frames.")
    slashResetInfo:SetPoint("TOPLEFT", DriftOptionsPanel.slashpanel, "TOPLEFT", 16, -75)

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
    DriftOptionsPanel.config.framesAreLockedCheckbox = createCheckbox(
        "FramesAreLockedCheckbox",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        14,
        -50,
        " Lock Frames",
        "While frames are locked, the Modify Key must be pressed to move or scale.",
        nil
    )
    DriftOptionsPanel.config.framesAreLockedCheckbox:SetChecked(DriftOptions.framesAreLocked)

    local dragKeyDropdownTitle = DriftOptionsPanel.optionspanel:CreateFontString(nil, "BACKGROUND")
    dragKeyDropdownTitle:SetFontObject("GameFontNormal")
    dragKeyDropdownTitle:SetText("Modify Key")
    dragKeyDropdownTitle:SetPoint("TOPLEFT", DriftOptionsPanel.optionspanel, "TOPLEFT", 20, -82)

    DriftOptionsPanel.config.dragKeyDropdown = createDragKeyDropdown(
        "DragKeyDropdown",
        "TOPLEFT",
        DriftOptionsPanel.optionspanel,
        "TOPLEFT",
        0,
        -100
    )
    DriftOptions.dragKeyFunc = getDragKeyFuncFromOrdinal(DriftOptions.dragKey)

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
        -145,
        160,
        25,
        "Reset Frames",
        "Reset position and scale for all frames.",
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


--------------------------------------------------------------------------------
-- Slash Commands
--------------------------------------------------------------------------------

SlashCmdList[DRIFTRESET] = DriftHelpers.DeleteDriftState
