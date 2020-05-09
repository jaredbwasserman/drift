local frames = {
    ["CharacterFrame"] = {
        DriftTabs = {
            "CharacterFrameTab1",
            "CharacterFrameTab2",
            "CharacterFrameTab3"
        }
    },
    ["TradeSkillFrame"] = {},
    ["CraftFrame"] = {},
    ["ArchaeologyFrame"] = {},
    ["QuestLogPopupDetailFrame"] = {},
    ["QuestLogFrame"] = {},
    ["QuestFrame"] = {},
    ["WarboardQuestChoiceFrame"] = {},
    ["GossipFrame"] = {},
    ["CollectionsJournal"] = {},
    ["SpellBookFrame"] = {},
    ["PlayerTalentFrame"] = {
        DriftTabs = {
            "PlayerTalentFrameTab1",
            "PlayerTalentFrameTab2",
            "PlayerTalentFrameTab3",
            "PlayerTalentFrameTalentsPvpTalentButton",
            "PlayerTalentFrameTalentsPvpTalentFrame.TrinketSlot",
            "PlayerTalentFrameTalentsPvpTalentFrame.TalentSlot1",
            "PlayerTalentFrameTalentsPvpTalentFrame.TalentSlot2",
            "PlayerTalentFrameTalentsPvpTalentFrame.TalentSlot3"
        }
    },
    ["TalentFrame"] = {},
    ["AchievementFrame"] = {},
    ["AchievementFrameHeader"] = {
        DriftDelegate = "AchievementFrame"
    },
    ["AchievementFrame.searchResults"] = {},
    ["WorldMapFrame"] = {},
    ["QuestScrollFrame"] = {
        DriftDelegate = "WorldMapFrame"
    },
    ["LookingForGuildFrame"] = {},
    ["CommunitiesFrame"] = {
        DriftTabs = {
            "ClubFinderGuildFinderFrame.ClubFinderSearchTab",
            "ClubFinderCommunityAndGuildFinderFrame.ClubFinderSearchTab",
            "ClubFinderGuildFinderFrame.ClubFinderPendingTab",
            "ClubFinderCommunityAndGuildFinderFrame.ClubFinderPendingTab",
            "CommunitiesFrame.ChatTab",
            "CommunitiesFrame.RosterTab",
            "CommunitiesFrame.GuildBenefitsTab",
            "CommunitiesFrame.GuildInfoTab",
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
    ["PVEFrame"] = {
        DriftTabs = {
            "PVEFrameTab1",
            "PVEFrameTab2",
            "PVEFrameTab3",
            "PVPQueueFrameCategoryButton1",
            "PVPQueueFrameCategoryButton2",
            "PVPQueueFrameCategoryButton3"
        }
    },
    ["EncounterJournal"] = {},
    ["FriendsFrame"] = {},
    ["ChannelFrame"] = {},
    ["RaidInfoFrame"] = {},
    ["DressUpFrame"] = {},
    ["AddonList"] = {},
    ["MerchantFrame"] = {},
    ["MailFrame"] = {},
    ["SendMailFrame"] = {
        DriftDelegate = "MailFrame"
    },
    ["OpenMailFrame"] = {},
    ["BankFrame"] = {},
    ["LootFrame"] = {},
    ["GameMenuFrame"] = {},
    ["VideoOptionsFrame"] = {},
    ["AudioOptionsFrame"] = {},
    ["InterfaceOptionsFrame"] = {},
    ["KeyBindingFrame"] = {},
    ["HelpFrame"] = {},
    ["RaidParentFrame"] = {},
    ["RaidBrowserFrame"] = {},
    ["TradeFrame"] = {},
    ["SUFWrapperFrame"] = {},
    ["TimeManagerFrame"] = {},
    ["TabardFrame"] = {},
    ["GuildBankFrame"] = {},
    ["GuildRegistrarFrame"] = {},
    ["GuildControlUI"] = {},
    ["PetitionFrame"] = {},
    ["ColorPickerFrame"] = {},
    ["AzeriteEmpoweredItemUI"] = {},
    ["AzeriteEssenceUI"] = {},
    ["AzeriteRespecFrame"] = {},
    ["InspectFrame"] = {},
    ["ItemSocketingFrame"] = {},
    ["BarberShopFrame"] = {},
    ["MacroFrame"] = {},
    ["VoidStorageFrame"] = {},
    ["SplashFrame"] = {},
    ["WardrobeFrame"] = {},
    ["CalendarFrame"] = {},
    ["ClassTrainerFrame"] = {},
    ["AuctionFrame"] = {},
    ["AuctionHouseFrame"] = {},
    ["BlackMarketFrame"] = {},
    ["ReforgingFrame"] = {},
    ["GarrisonBuildingFrame"] = {},
    ["GarrisonLandingPage"] = {},
    ["GarrisonMissionFrame"] = {},
    ["GarrisonShipyardFrame"] = {},
    ["GarrisonMonumentFrame"] = {},
    ["GarrisonRecruiterFrame"] = {},
    ["GarrisonRecruitSelectFrame"] = {},
    ["GarrisonCapacitiveDisplayFrame"] = {},
    ["OrderHallMissionFrame"] = {},
    ["OrderHallTalentFrame"] = {},
    ["BFAMissionFrame"] = {},
    ["ArtifactFrame"] = {},
    ["ItemTextFrame"] = {},
    ["PetStableFrame"] = {},
    ["TaxiFrame"] = {},
    ["PVPMatchScoreboard"] = {},
    ["PVPMatchResults"] = {},
    ["AlliedRacesFrame"] = {},
    ["ChatConfigFrame"] = {},
    ["FlightMapFrame"] = {},
    ["ScrappingMachineFrame"] = {},
    ["IslandsQueueFrame"] = {},
    ["ItemUpgradeFrame"] = {},
    ["ItemInteractionFrame"] = {},
    ["ExtraActionButton1"] = {},
    ["ZoneAbilityFrame"] = {},
    ["PlayerPowerBarAlt"] = {},
    ["TalkingHeadFrame"] = {},
}

-- Modify pre-loaded frames
DriftHelpers:ModifyFrames(frames)

local function eventHandler(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = select(1, ...)

        -- Blizzard Communities buttons are delayed for some reason
        if addonName == "Blizzard_Communities" then
            DriftHelpers:Wait(0.25, DriftHelpers.ModifyFrames, DriftHelpers, frames)
        else
            DriftHelpers:ModifyFrames(frames)
        end
    elseif event == "VARIABLES_LOADED" then
        -- Setup config
        DriftHelpers:SetupConfig()
    else
        DriftHelpers:BroadcastReset(frames)
    end
end

-- Modify frames after any addon is loaded
local Drift = CreateFrame("Frame")
Drift:SetScript("OnEvent", eventHandler)
Drift:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
Drift:RegisterEvent("PET_SPECIALIZATION_CHANGED")
Drift:RegisterEvent("VARIABLES_LOADED")
DriftHelpers:Wait(1, Drift.RegisterEvent, Drift, "ADDON_LOADED")
