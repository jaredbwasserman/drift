local frames = {
    ["CharacterFrame"] = {}, -- fix this
    ["TradeSkillFrame"] = {},
    ["ArchaeologyFrame"] = {},
    ["QuestFrame"] = {},
    ["QuestLogPopupDetailFrame"] = {},
    ["QuestLogFrame"] = {},
    ["WarboardQuestChoiceFrame"] = {},
    ["GossipFrame"] = {},
    ["CollectionsJournal"] = {},
    ["SpellBookFrame"] = {},
    ["PlayerTalentFrame"] = {}, -- fix this
    ["TalentFrame"] = {},
    ["AchievementFrame"] = {},
    ["AchievementFrameHeader"] = {delegate = "AchievementFrame"},
    ["WorldMapFrame"] = {}, -- fix this
    ["LookingForGuildFrame"] = {},
    ["CommunitiesFrame"] = {},
    ["PVEFrame"] = {}, -- fix this
    ["EncounterJournal"] = {},
    ["FriendsFrame"] = {},
    ["DressUpFrame"] = {},
    ["AddonList"] = {},
    ["MerchantFrame"] = {},
    ["MailFrame"] = {},
    ["SendMailFrame"] = {delegate = "MailFrame"},
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
    ["IslandsQueueFrame"] = {}
}

-- Modify pre-loaded frames
DriftHelpers:ModifyFrames(frames)

local function addonLoaded(self, event, ...)
    DriftHelpers:ModifyFrames(frames)
end

-- Make addon frames hasBeenModified when any addon is loaded
local Drift = CreateFrame("Frame")
Drift:SetScript("OnEvent", addonLoaded)
Drift:RegisterEvent("ADDON_LOADED")
