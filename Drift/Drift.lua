local frames = {
    ["CharacterFrame"] = {hasBeenModified = false}, -- fix this
    ["TradeSkillFrame"] = {hasBeenModified = false},
    ["ArchaeologyFrame"] = {hasBeenModified = false},
    ["QuestFrame"] = {hasBeenModified = false},
    ["QuestLogPopupDetailFrame"] = {hasBeenModified = false},
    ["QuestLogFrame"] = {hasBeenModified = false},
    ["GossipFrame"] = {hasBeenModified = false},
    ["CollectionsJournal"] = {hasBeenModified = false},
    ["SpellBookFrame"] = {hasBeenModified = false},
    -- ["PlayerTalentFrame"] = {hasBeenModified = false},
    ["TalentFrame"] = {hasBeenModified = false},
    ["AchievementFrame"] = {hasBeenModified = false}, -- needs handle of AchievementFrameHeader
    -- ["WorldMapFrame"] = {hasBeenModified = false},
    ["LookingForGuildFrame"] = {hasBeenModified = false},
    ["CommunitiesFrame"] = {hasBeenModified = false},
    ["PVEFrame"] = {hasBeenModified = false}, -- fix this
    ["EncounterJournal"] = {hasBeenModified = false},
    ["FriendsFrame"] = {hasBeenModified = false},
    ["DressUpFrame"] = {hasBeenModified = false},
    ["AddonList"] = {hasBeenModified = false},
    ["MerchantFrame"] = {hasBeenModified = false},
    ["MailFrame"] = {hasBeenModified = false},
    ["SendMailFrame"] = {hasBeenModified = false}, -- needs handle
    ["BankFrame"] = {hasBeenModified = false},
    ["GameMenuFrame"] = {hasBeenModified = false},
    ["VideoOptionsFrame"] = {hasBeenModified = false},
    ["AudioOptionsFrame"] = {hasBeenModified = false},
    ["InterfaceOptionsFrame"] = {hasBeenModified = false},
    ["KeyBindingFrame"] = {hasBeenModified = false},
    ["HelpFrame"] = {hasBeenModified = false},
    ["RaidParentFrame"] = {hasBeenModified = false},
    ["RaidBrowserFrame"] = {hasBeenModified = false},
    ["TradeFrame"] = {hasBeenModified = false},
    ["SUFWrapperFrame"] = {hasBeenModified = false},
    ["CraftFrame"] = {hasBeenModified = false},
    ["TimeManagerFrame"] = {hasBeenModified = false},
    ["TabardFrame"] = {hasBeenModified = false},
    ["GuildBankFrame"] = {hasBeenModified = false},
    ["GuildRegistrarFrame"] = {hasBeenModified = false},
    ["GuildControlUI"] = {hasBeenModified = false},
    ["PetitionFrame"] = {hasBeenModified = false},
    ["ColorPickerFrame"] = {hasBeenModified = false},
    ["AzeriteEmpoweredItemUI"] = {hasBeenModified = false},
    ["AzeriteEssenceUI"] = {hasBeenModified = false},
    ["InspectFrame"] = {hasBeenModified = false},
    ["ItemSocketingFrame"] = {hasBeenModified = false},
    ["BarberShopFrame"] = {hasBeenModified = false},
    ["MacroFrame"] = {hasBeenModified = false},
    ["VoidStorageFrame"] = {hasBeenModified = false},
    ["SplashFrame"] = {hasBeenModified = false},
    ["WardrobeFrame"] = {hasBeenModified = false},
    ["CalendarFrame"] = {hasBeenModified = false},
    ["ClassTrainerFrame"] = {hasBeenModified = false},
    ["AuctionFrame"] = {hasBeenModified = false},
    ["ReforgingFrame"] = {hasBeenModified = false},
    ["GarrisonBuildingFrame"] = {hasBeenModified = false},
    ["GarrisonLandingPage"] = {hasBeenModified = false},
    ["GarrisonMissionFrame"] = {hasBeenModified = false},
    ["GarrisonShipyardFrame"] = {hasBeenModified = false},
    ["GarrisonMonumentFrame"] = {hasBeenModified = false},
    ["GarrisonRecruiterFrame"] = {hasBeenModified = false},
    ["GarrisonRecruitSelectFrame"] = {hasBeenModified = false},
    ["GarrisonCapacitiveDisplayFrame"] = {hasBeenModified = false},
    ["OrderHallMissionFrame"] = {hasBeenModified = false},
    ["OrderHallTalentFrame"] = {hasBeenModified = false},
    ["BFAMissionFrame"] = {hasBeenModified = false}, -- needs handle
    ["ArtifactFrame"] = {hasBeenModified = false},
    ["ItemTextFrame"] = {hasBeenModified = false},
    ["PetStableFrame"] = {hasBeenModified = false},
    ["TaxiFrame"] = {hasBeenModified = false},
    ["PVPMatchScoreboard"] = {hasBeenModified = false},
    ["PVPMatchResults"] = {hasBeenModified = false},
    ["AlliedRacesFrame"] = {hasBeenModified = false},
    ["ChatConfigFrame"] = {hasBeenModified = false}
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
