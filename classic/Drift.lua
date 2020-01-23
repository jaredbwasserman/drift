local frames = {
    ["CharacterFrame"] = {},
    ["TradeSkillFrame"] = {},
    ["CraftFrame"] = {},
    ["QuestLogFrame"] = {},
    ["GossipFrame"] = {},
    ["SpellBookFrame"] = {},
    ["TalentFrame"] = {},
    ["WorldMapFrame"] = {},
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
    ["TimeManagerFrame"] = {},
    ["TabardFrame"] = {},
    ["GuildBankFrame"] = {},
    ["GuildRegistrarFrame"] = {},
    ["GuildControlUI"] = {},
    ["PetitionFrame"] = {},
    ["ColorPickerFrame"] = {},
    ["InspectFrame"] = {},
    ["MacroFrame"] = {},
    ["WardrobeFrame"] = {},
    ["ClassTrainerFrame"] = {},
    ["AuctionFrame"] = {},
    ["ItemTextFrame"] = {},
    ["PetStableFrame"] = {},
    ["TaxiFrame"] = {},
    ["PVPMatchScoreboard"] = {},
    ["PVPMatchResults"] = {},
    ["ChatConfigFrame"] = {},
    ["FlightMapFrame"] = {}
}

-- Modify pre-loaded frames
DriftHelpers:ModifyFrames(frames)

local function eventHandler(self, event, ...)
    if event == "ADDON_LOADED" then
        DriftHelpers:ModifyFrames(frames)
    end
end

-- Modify frames after any addon is loaded
local Drift = CreateFrame("Frame")
Drift:SetScript("OnEvent", eventHandler)
DriftHelpers:Wait(1, Drift.RegisterEvent, Drift, "ADDON_LOADED")
