-- Keep track of which frames have been made movable
local frames = {
    ["CharacterFrame"] = false,
    ["TradeSkillFrame"] = false,
    ["ArchaeologyFrame"] = false,
    ["QuestFrame"] = false,
    ["QuestLogPopupDetailFrame"] = false,
    ["GossipFrame"] = false,
    ["CollectionsJournal"] = false,
    ["SpellBookFrame"] = false,
    ["PlayerTalentFrame"] = false,
    ["TalentFrame"] = false,
    ["AchievementFrame"] = false, -- needs handle of AchievementFrameHeader
    ["WorldMapFrame"] = false,
    ["LookingForGuildFrame"] = false,
    ["CommunitiesFrame"] = false,
    ["PVEFrame"] = false,
    ["EncounterJournal"] = false,
    ["FriendsFrame"] = false,
    ["DressUpFrame"] = false,
    ["AddonList"] = false,
    ["MerchantFrame"] = false,
    ["HelpFrame"] = false,
    ["MailFrame"] = false,
    ["SendMailFrame"] = false, -- needs handle
    ["BankFrame"] = false,
    ["GameMenuFrame"] = false,
    ["VideoOptionsFrame"] = false,
    ["InterfaceOptionsFrame"] = false,
    ["KeyBindingFrame"] = false,
    ["LootFrame"] = false,
    ["RaidBrowserFrame"] = false, -- what is this
    ["TradeFrame"] = false,
    ["SUFWrapperFrame"] = false,
    ["QuestLogFrame"] = false,
    ["CraftFrame"] = false,
    ["TalkingHeadFrame"] = false,
    ["TimeManagerFrame"] = false,
    ["TabardFrame"] = false,
    ["GuildRegistrarFrame"] = false,
    ["ColorPickerFrame"] = false, -- what is this -- needs handle
    ["ObjectiveTrackerFrame"] = false, -- needs handle
    ["AzeriteEmpoweredItemUI"] = false,
    ["AzeriteEssenceUI"] = false,
    ["InspectFrame"] = false,
    ["GuildBankFrame"] = false,
    ["ItemSocketingFrame"] = false,
    ["BarberShopFrame"] = false,
    ["MacroFrame"] = false,
    ["VoidStorageFrame"] = false,
    ["SplashFrame"] = false,
    ["WardrobeFrame"] = false,
    ["CalendarFrame"] = false,
    ["ClassTrainerFrame"] = false,
    ["AuctionFrame"] = false,
    ["ReforgingFrame"] = false, -- what is this -- needs handle
    ["GarrisonLandingPage"] = false,
    ["GarrisonMissionFrame"] = false,
    ["GarrisonCapacitiveDisplayFrame"] = false,
    ["OrderHallMissionFrame"] = false,
    ["ArtifactFrame"] = false
}

-- Make preloaded frames movable
DriftHelpers:MakeFramesMovable(frames)

local function addonLoaded(_, _, _)
    DriftHelpers:MakeFramesMovable(frames)
end

-- Make addon frames movable when any addon is loaded
local Drift = CreateFrame("Frame")
Drift:SetScript("OnEvent", addonLoaded)
Drift:RegisterEvent("ADDON_LOADED")
