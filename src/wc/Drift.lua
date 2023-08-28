local frames = {
	["ContainerFrame1"] = {
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame1.ClickableTitleFrame"] = {
		DriftDelegate = "ContainerFrame1",
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame2"] = {
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame2.ClickableTitleFrame"] = {
		DriftDelegate = "ContainerFrame2",
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame3"] = {
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame3.ClickableTitleFrame"] = {
		DriftDelegate = "ContainerFrame3",
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame4"] = {
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame4.ClickableTitleFrame"] = {
		DriftDelegate = "ContainerFrame4",
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame5"] = {
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame5.ClickableTitleFrame"] = {
		DriftDelegate = "ContainerFrame5",
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame6"] = {
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame6.ClickableTitleFrame"] = {
		DriftDelegate = "ContainerFrame6",
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame7"] = {
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame7.ClickableTitleFrame"] = {
		DriftDelegate = "ContainerFrame7",
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame8"] = {
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame8.ClickableTitleFrame"] = {
		DriftDelegate = "ContainerFrame8",
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame9"] = {
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame9.ClickableTitleFrame"] = {
		DriftDelegate = "ContainerFrame9",
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame10"] = {
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame10.ClickableTitleFrame"] = {
		DriftDelegate = "ContainerFrame10",
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame11"] = {
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame11.ClickableTitleFrame"] = {
		DriftDelegate = "ContainerFrame11",
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame12"] = {
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame12.ClickableTitleFrame"] = {
		DriftDelegate = "ContainerFrame12",
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame13"] = {
		DriftDisabledBy = "bagsDisabled"
	},
	["ContainerFrame13.ClickableTitleFrame"] = {
		DriftDelegate = "ContainerFrame13",
		DriftDisabledBy = "bagsDisabled"
	},
	["CharacterFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["PetPaperDollFrameCompanionFrame"] = {
		DriftDisabledBy = "windowsDisabled",
		DriftDelegate = "CharacterFrame",
	},
	["ReputationFrame"] = {
		DriftDisabledBy = "windowsDisabled",
		DriftDelegate = "CharacterFrame",
	},
	["HonorFrame"] = {
		DriftDisabledBy = "windowsDisabled",
		DriftDelegate = "CharacterFrame"
	},
	["PetPaperDollFramePetFrame"] = {
		DriftDisabledBy = "windowsDisabled",
		DriftDelegate = "CharacterFrame"
	},
	["TradeSkillFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["CraftFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["QuestLogFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["QuestLogDetailFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["QuestFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["WatchFrame"] = {
		DriftDisabledBy = "objectivesDisabled"
	},
	["MinimapCluster"] = {
		DriftDisabledBy = "minimapDisabled",
		DriftDelegate = "MinimapMover",
		DriftHasMover = true,
	},
	["GossipFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["SpellBookFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["PlayerTalentFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["AchievementFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["AchievementFrameHeader"] = {
		DriftDisabledBy = "windowsDisabled",
		DriftDelegate = "AchievementFrame"
	},
	["AchievementFrame.searchResults"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["WorldMapFrame"] = {
		DriftDisabledBy = "windowsDisabled",
		DriftUnscalable = true
	},
	["FriendsFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["BNToastFrame"] = {
		DriftDisabledBy = "miscellaneousDisabled",
	},
	["ReputationDetailFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["GuildInfoFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["CommunitiesFrame"] = {
		DriftDisabledBy = "windowsDisabled",
		DriftDelegate = "CommunitiesMover",
		DriftHasMover = true,
	},
	["ChannelFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["RaidInfoFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["DressUpFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["SideDressUpFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["AddonList"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["MerchantFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["MailFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["SendMailFrame"] = {
		DriftDisabledBy = "windowsDisabled",
		DriftDelegate = "MailFrame"
	},
	["OpenMailFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["BankFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["LootFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["GroupLootFrame1"] = {
		DriftDisabledBy = "miscellaneousDisabled",
	},
	["GroupLootFrame2"] = {
		DriftDisabledBy = "miscellaneousDisabled",
	},
	["GroupLootFrame3"] = {
		DriftDisabledBy = "miscellaneousDisabled",
	},
	["GroupLootFrame4"] = {
		DriftDisabledBy = "miscellaneousDisabled",
	},
	["GameMenuFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["VideoOptionsFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["AudioOptionsFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["InterfaceOptionsFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["KeyBindingFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["HelpFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["HelpOpenWebTicketButton"] = {
		DriftDisabledBy = "buttonsDisabled",
	},
	["RaidParentFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["RaidBrowserFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["TradeFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["TimeManagerFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["TabardFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["GuildRegistrarFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["GuildControlUI"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["PetitionFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["ColorPickerFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["InspectFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["ItemSocketingFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["MacroFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["MacroPopupFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["WardrobeFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["CalendarFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["CalendarViewEventFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["CalendarViewEventFrame.Header"] = {
		DriftDisabledBy = "windowsDisabled",
		DriftDelegate = "CalendarViewEventFrame"
	},
	["CalendarViewEventFrame.HeaderFrame"] = {
		DriftDisabledBy = "windowsDisabled",
		DriftDelegate = "CalendarViewEventFrame"
	},
	["CalendarViewHolidayFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["CalendarViewRaidFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["ClassTrainerFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["AuctionFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["ItemTextFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["PetStableFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["TaxiFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["FlightMapFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["WorldStateScoreFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["ChatConfigFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["LFGParentFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["PVPFrame"] = {
		DriftDisabledBy = "windowsDisabled",
		DriftDelegate = "PVPParentFrame",
	},
	["BattlefieldFrame"] = {
		DriftDisabledBy = "windowsDisabled",
		DriftDelegate = "PVPParentFrame",
	},
	["DurabilityFrame"] = {
		DriftDisabledBy = "miscellaneousDisabled",
	},
	["VehicleSeatIndicator"] = {
		DriftDisabledBy = "miscellaneousDisabled",
	},
	["SettingsPanel"] = {
		DriftDisabledBy = "windowsDisabled",
	},
}

-- Frame for handling events
local Drift = CreateFrame("Frame")

local function eventHandler(self, event, ...)
	if event == "ADDON_LOADED" or event == "PLAYER_REGEN_ENABLED" then
		DriftHelpers:ModifyFrames(frames)
	elseif event == "VARIABLES_LOADED" then
		-- Config
		DriftHelpers:SetupConfig()

		-- Disable frames depending on DriftOptions
		for frameName, properties in pairs(frames) do
			local disabledBy = properties.DriftDisabledBy
			if disabledBy ~= nil and DriftOptions[disabledBy] then
				frames[frameName] = nil
			end
		end

		-- Modify pre-loaded frames
		DriftHelpers:ModifyFrames(frames)

		-- Modify frames after an addon loads
		Drift:RegisterEvent("ADDON_LOADED")

		-- Modify frames after combat ends
		Drift:RegisterEvent("PLAYER_REGEN_ENABLED")
	end
end

-- Respond to events to fix frames
Drift:SetScript("OnEvent", eventHandler)
Drift:RegisterEvent("VARIABLES_LOADED")
