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
    ["WorldMapFrame"] = {},
    ["QuestScrollFrame"] = {
        DriftDelegate = "WorldMapFrame"
    },
    ["LookingForGuildFrame"] = {},
    ["CommunitiesFrame"] = {
        DriftTabs = {
            "ChatTab",
            "RosterTab",
            "GuildBenefitsTab",
            "GuildInfoTab"
        }
    },
    ["PVEFrame"] = {
        DriftTabs = {
            "PVEFrameTab1",
            "PVEFrameTab2",
            "PVEFrameTab3"
        }
    },
    ["EncounterJournal"] = {},
    ["FriendsFrame"] = {},
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
    ["ItemUpgradeFrame"] = {}
}

-- Modify pre-loaded frames
DriftHelpers:ModifyFrames(frames)

local function eventHandler(self, event, ...)
    if event == "ADDON_LOADED" then
        DriftHelpers:ModifyFrames(frames)
    end
end

-- Make addon frames hasBeenModified when any addon is loaded
local Drift = CreateFrame("Frame")
Drift:SetScript("OnEvent", eventHandler)
Drift:RegisterEvent("ADDON_LOADED")
