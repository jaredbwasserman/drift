local frames = {
	["CharacterFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["HonorFrame"] = {
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
	["QuestFrame"] = {
		DriftDisabledBy = "windowsDisabled",
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
	["WorldMapFrame"] = {
		DriftDisabledBy = "windowsDisabled",
		-- TODO: Add scaling support for WorldMapFrame
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
		DriftTabs = {
			"CommunitiesFrame.ChatTab",
			"CommunitiesFrame.RosterTab",
			"CommunitiesFrame.MaximizeMinimizeFrame.MinimizeButton",
			"CommunitiesFrame.MaximizeMinimizeFrame.MaximizeButton",
			"CommunitiesFrameCommunitiesListListScrollFrameButton1",
			"CommunitiesFrameCommunitiesListListScrollFrameButton2",
			"CommunitiesFrameCommunitiesListListScrollFrameButton3",
			"CommunitiesFrameCommunitiesListListScrollFrameButton4",
			"CommunitiesFrameCommunitiesListListScrollFrameButton5",
			"CommunitiesFrameCommunitiesListListScrollFrameButton6",
			"CommunitiesFrameCommunitiesListListScrollFrameButton7",
			"CommunitiesFrameCommunitiesListListScrollFrameButton8",
			"CommunitiesFrameCommunitiesListListScrollFrameButton9",
			"CommunitiesFrameCommunitiesListListScrollFrameButton10",
			"CommunitiesFrameCommunitiesListListScrollFrameButton11",
			"CommunitiesFrameCommunitiesListListScrollFrameButton12",
			"CommunitiesFrameCommunitiesListListScrollFrameButton13",
			"CommunitiesFrameCommunitiesListListScrollFrameButton14",
			"CommunitiesFrameCommunitiesListListScrollFrameButton15",
			"CommunitiesFrameCommunitiesListListScrollFrameButton16",
			"CommunitiesFrameCommunitiesListListScrollFrameButton17",
			"CommunitiesFrameCommunitiesListListScrollFrameButton18",
			"CommunitiesFrameCommunitiesListListScrollFrameButton19",
			"CommunitiesFrameCommunitiesListListScrollFrameButton20"
		}
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
	["SUFWrapperFrame"] = {
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
	["MacroFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["MacroPopupFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["WardrobeFrame"] = {
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
	["BattlefieldFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["ChatConfigFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
	["LFGParentFrame"] = {
		DriftDisabledBy = "windowsDisabled",
	},
}

-- Frame for handling events
local Drift = CreateFrame("Frame")

local function eventHandler(self, event, ...)
	if event == "ADDON_LOADED" then
		local addonName = select(1, ...)

		-- Blizzard Groups buttons are delayed for some reason
		if addonName == "Blizzard_Communities" then
			DriftHelpers:Wait(0.25, DriftHelpers.ModifyFrames, DriftHelpers, frames)
		else
			DriftHelpers:ModifyFrames(frames)
		end
	elseif event == "PLAYER_REGEN_ENABLED" then
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

		-- Quest Watch
		Drift:RegisterEvent("QUEST_WATCH_LIST_CHANGED")

		-- Groups
		Drift:RegisterEvent("CLUB_TICKET_RECEIVED")

		-- Modify frames after an addon loads
		DriftHelpers:Wait(1, Drift.RegisterEvent, Drift, "ADDON_LOADED")

		-- Modify frames after combat ends
		Drift:RegisterEvent("PLAYER_REGEN_ENABLED")
	else
		DriftHelpers:BroadcastReset(frames)
	end
end

-- Respond to events to fix frames
Drift:SetScript("OnEvent", eventHandler)
Drift:RegisterEvent("VARIABLES_LOADED")