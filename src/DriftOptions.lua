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
local isWC = (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC)

-- Variables for slash commands
local DRIFT = "DRIFT"
SLASH_DRIFT1 = "/drift"

local DRIFTRESET = "DRIFTRESET"
SLASH_DRIFTRESET1 = "/driftreset"


--------------------------------------------------------------------------------
-- Interface Options
--------------------------------------------------------------------------------

-- Local functions
local function createCheckbox(name, point, relativeFrame, relativePoint, xOffset, yOffset, text, tooltipText)
	local checkbox = CreateFrame("CheckButton", name, relativeFrame, "ChatConfigCheckButtonTemplate")
	checkbox:SetPoint(point, relativeFrame, relativePoint, xOffset, yOffset)
	getglobal(checkbox:GetName() .. "Text"):SetText(text)
	checkbox.tooltip = tooltipText
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

--Locally define a function removed from Blizzard's API in 11.0
local InterfaceOptions_AddCategory = InterfaceOptions_AddCategory
if not InterfaceOptions_AddCategory then
	InterfaceOptions_AddCategory = function(frame, addOn, position)
		-- cancel is no longer a default option. May add menu extension for this.
		frame.OnCommit = frame.okay;
		frame.OnDefault = frame.default;
		frame.OnRefresh = frame.refresh;

		if frame.parent then
			local category = Settings.GetCategory(frame.parent);
			local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, frame, frame.name, frame.name);
			subcategory.ID = frame.name;
			return subcategory, category;
		else
			local category, layout = Settings.RegisterCanvasLayoutCategory(frame, frame.name, frame.name);
			category.ID = frame.name;
			Settings.RegisterAddOnCategory(category);
			return category;
		end
	end
end

-- Global functions
function DriftHelpers:SetupConfig()
	-- Initialize config options
	if DriftOptions.frameDragIsLocked == nil then
		DriftOptions.frameDragIsLocked = false
	end
	if DriftOptions.frameScaleIsLocked == nil then
		DriftOptions.frameScaleIsLocked = false
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
		"While frame dragging is locked, a modifier key must be pressed to drag a frame."
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
		"Whether ALT can be pressed while frame dragging is locked to drag a frame."
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
		"Whether CTRL can be pressed while frame dragging is locked to drag a frame."
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
		"Whether SHIFT can be pressed while frame dragging is locked to drag a frame."
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
		"While frame scaling is locked, a modifier key must be pressed to scale a frame."
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
		"Whether ALT can be pressed while frame scaling is locked to scale a frame."
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
		"Whether CTRL can be pressed while frame scaling is locked to scale a frame."
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
		"Whether SHIFT can be pressed while frame scaling is locked to scale a frame."
	)
	DriftOptionsPanel.config.scaleShiftKeyEnabledCheckbox:SetChecked(DriftOptions.scaleShiftKeyEnabled)

	-- Enabled Frames
	local frameToggleTitle = DriftOptionsPanel.optionspanel:CreateFontString(nil, "BACKGROUND")
	frameToggleTitle:SetFontObject("GameFontNormal")
	frameToggleTitle:SetText("Enabled Frames")
	frameToggleTitle:SetPoint("TOPLEFT", DriftOptionsPanel.optionspanel, "TOPLEFT", 15, -90)

	yOffset = -110

	-- Windows
	DriftOptionsPanel.config.windowsEnabledCheckbox = createCheckbox(
		"WindowsEnabledCheckbox",
		"TOPLEFT",
		DriftOptionsPanel.optionspanel,
		"TOPLEFT",
		15,
		yOffset,
		" Windows",
		"Whether Drift will modify Windows (example: Talents)."
	)
	DriftOptionsPanel.config.windowsEnabledCheckbox:SetChecked(not DriftOptions.windowsDisabled)
	yOffset = yOffset - 30

	-- Bags
	DriftOptionsPanel.config.bagsEnabledCheckbox = createCheckbox(
		"BagsEnabledCheckbox",
		"TOPLEFT",
		DriftOptionsPanel.optionspanel,
		"TOPLEFT",
		15,
		yOffset,
		" Bags",
		"Whether Drift will modify Bags."
	)
	DriftOptionsPanel.config.bagsEnabledCheckbox:SetChecked(not DriftOptions.bagsDisabled)
	yOffset = yOffset - 30

	-- Buttons
	DriftOptionsPanel.config.buttonsEnabledCheckbox = createCheckbox(
		"ButtonsEnabledCheckbox",
		"TOPLEFT",
		DriftOptionsPanel.optionspanel,
		"TOPLEFT",
		15,
		yOffset,
		" Buttons",
		"Whether Drift will modify Buttons (example: Open Ticket Button)."
	)
	DriftOptionsPanel.config.buttonsEnabledCheckbox:SetChecked(not DriftOptions.buttonsDisabled)
	yOffset = yOffset - 30

	if (not isRetail) then
		-- Minimap
		DriftOptionsPanel.config.minimapEnabledCheckbox = createCheckbox(
			"MinimapEnabledCheckbox",
			"TOPLEFT",
			DriftOptionsPanel.optionspanel,
			"TOPLEFT",
			15,
			yOffset,
			" Minimap",
			"Whether Drift will modify the Minimap."
		)
		DriftOptionsPanel.config.minimapEnabledCheckbox:SetChecked(not DriftOptions.minimapDisabled)
		yOffset = yOffset - 30
	end

	-- Objectives
	DriftOptionsPanel.config.objectivesEnabledCheckbox = createCheckbox(
		"ObjectivesEnabledCheckbox",
		"TOPLEFT",
		DriftOptionsPanel.optionspanel,
		"TOPLEFT",
		15,
		yOffset,
		" Objectives",
		"Whether Drift will modify Objectives."
	)
	DriftOptionsPanel.config.objectivesEnabledCheckbox:SetChecked(not DriftOptions.objectivesDisabled)
	yOffset = yOffset - 30

	-- Miscellaneous
	DriftOptionsPanel.config.miscellaneousEnabledCheckbox = createCheckbox(
		"MiscellaneousEnabledCheckbox",
		"TOPLEFT",
		DriftOptionsPanel.optionspanel,
		"TOPLEFT",
		15,
		yOffset,
		" Miscellaneous",
		"Whether Drift will modify Miscellaneous Frames (example: Battle.net Toast)."
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
	driftOptionsVersionContent:SetText(C_AddOns.GetAddOnMetadata("Drift", "Version"))
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

	-- Update function
	local updateFunction = function()
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
			shouldReloadUI = true
		end

		local oldButtonsDisabled = DriftOptions.buttonsDisabled
		DriftOptions.buttonsDisabled = not DriftOptionsPanel.config.buttonsEnabledCheckbox:GetChecked()
		if oldButtonsDisabled ~= DriftOptions.buttonsDisabled then
			shouldReloadUI = true
		end

		if (not isRetail) then
			local oldMinimapDisabled = DriftOptions.minimapDisabled
			DriftOptions.minimapDisabled = not DriftOptionsPanel.config.minimapEnabledCheckbox:GetChecked()
			if oldMinimapDisabled ~= DriftOptions.minimapDisabled then
				shouldReloadUI = true
			end
		end

		local oldObjectivesDisabled = DriftOptions.objectivesDisabled
		DriftOptions.objectivesDisabled = not DriftOptionsPanel.config.objectivesEnabledCheckbox:GetChecked()
		if oldObjectivesDisabled ~= DriftOptions.objectivesDisabled then
			shouldReloadUI = true
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

	DriftOptionsPanel.optionspanel:SetScript("OnHide", updateFunction)
end


--------------------------------------------------------------------------------
-- Slash Commands
--------------------------------------------------------------------------------

SlashCmdList[DRIFT] = function(msg, editBox)
	DriftHelpers:HandleSlashCommands(msg, editBox)
end

SlashCmdList[DRIFTRESET] = DriftHelpers.DeleteDriftState
