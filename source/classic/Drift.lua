local frames = {
    ["ContainerFrame1"] = {},
    ["ContainerFrame1.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame1"
    },
    ["ContainerFrame2"] = {},
    ["ContainerFrame2.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame2"
    },
    ["ContainerFrame3"] = {},
    ["ContainerFrame3.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame3"
    },
    ["ContainerFrame4"] = {},
    ["ContainerFrame4.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame4"
    },
    ["ContainerFrame5"] = {},
    ["ContainerFrame5.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame5"
    },
    ["CharacterFrame"] = {},
    ["TradeSkillFrame"] = {},
    ["CraftFrame"] = {},
    ["QuestLogFrame"] = {},
    ["QuestFrame"] = {},
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
