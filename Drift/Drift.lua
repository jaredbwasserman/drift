local frames = {
    ["CharacterFrame"] = {
        DriftTabs = {
            "CharacterFrameTab1",
            "CharacterFrameTab2",
            "CharacterFrameTab3"
        }
    },
    ["TradeSkillFrame"] = {},
    ["ArchaeologyFrame"] = {},
    ["QuestFrame"] = {},
    ["QuestLogPopupDetailFrame"] = {},
    ["QuestLogFrame"] = {},
    ["WarboardQuestChoiceFrame"] = {},
    ["GossipFrame"] = {},
    ["CollectionsJournal"] = {},
    ["SpellBookFrame"] = {},
    ["PlayerTalentFrame"] = {
        DriftTabs = {
            "PlayerTalentFrameTab1",
            "PlayerTalentFrameTab2"
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
            "CommunitiesFrameCommunitiesListListScrollFrameButton5"
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
    ["CraftFrame"] = {},
    ["TimeManagerFrame"] = {},
    ["TabardFrame"] = {},
    ["GuildBankFrame"] = {},
    ["GuildRegistrarFrame"] = {},
    ["GuildControlUI"] = {},
    ["PetitionFrame"] = {},
    ["ColorPickerFrame"] = {},
    ["AzeriteEmpoweredItemUI"] = {},
    ["AzeriteEssenceUI"] = {},
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
    ["ItemInteractionFrame"] = {}
}

-- Modify pre-loaded frames
DriftHelpers:ModifyFrames(frames)

local function eventHandler(self, event, ...)
    local addonName = select(1, ...)
    if event == "ADDON_LOADED" then
        -- Blizzard Communities buttons are delayed for some reason
        if addonName == "Blizzard_Communities" then
            DriftHelpers:Wait(0, DriftHelpers.ModifyFrames, DriftHelpers, frames)
        else
            DriftHelpers:ModifyFrames(frames)
        end
    end
end

-- Modify frames after any addon is loaded
local Drift = CreateFrame("Frame")
Drift:SetScript("OnEvent", eventHandler)
DriftHelpers:Wait(1, Drift.RegisterEvent, Drift, "ADDON_LOADED")
