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
    ["ContainerFrame6"] = {},
    ["ContainerFrame6.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame6"
    },
    ["ContainerFrame7"] = {},
    ["ContainerFrame7.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame7"
    },
    ["ContainerFrame8"] = {},
    ["ContainerFrame8.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame8"
    },
    ["ContainerFrame9"] = {},
    ["ContainerFrame9.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame9"
    },
    ["ContainerFrame10"] = {},
    ["ContainerFrame10.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame10"
    },
    ["ContainerFrame11"] = {},
    ["ContainerFrame11.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame11"
    },
    ["ContainerFrame12"] = {},
    ["ContainerFrame12.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame12"
    },
    ["ContainerFrame13"] = {},
    ["ContainerFrame13.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame13"
    },
    ["CharacterFrame"] = {},
    ["HonorFrame"] = {
        DriftDelegate = "CharacterFrame"
    },
    ["TradeSkillFrame"] = {},
    ["CraftFrame"] = {},
    ["QuestLogFrame"] = {},
    ["QuestFrame"] = {},
    ["GossipFrame"] = {},
    ["SpellBookFrame"] = {},
    ["TalentFrame"] = {},
    ["WorldMapFrame"] = {
        -- TODO: Add scaling support for WorldMapFrame
        DriftUnscalable = true
    },
    ["FriendsFrame"] = {},
    ["GuildInfoFrame"] = {},
    ["CommunitiesFrame"] = {
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
    ["FlightMapFrame"] = {},
    ["PVPMatchScoreboard"] = {},
    ["PVPMatchResults"] = {},
    ["ChatConfigFrame"] = {},
}

-- Modify pre-loaded frames
DriftHelpers:ModifyFrames(frames)

local function eventHandler(self, event, ...)
    if event == "ADDON_LOADED" or event == "PLAYER_REGEN_ENABLED" then
        DriftHelpers:ModifyFrames(frames)
    elseif event == "VARIABLES_LOADED" then
        DriftHelpers:SetupConfig()
    end
end

-- Respond to events to fix frames
local Drift = CreateFrame("Frame")
Drift:SetScript("OnEvent", eventHandler)

-- Config
Drift:RegisterEvent("VARIABLES_LOADED")

-- Modify frames after an addon loads
DriftHelpers:Wait(1, Drift.RegisterEvent, Drift, "ADDON_LOADED")

-- Modify frames after combat ends
Drift:RegisterEvent("PLAYER_REGEN_ENABLED")
