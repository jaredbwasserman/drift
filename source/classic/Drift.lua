local frames = {
    ["ContainerFrame1"] = {
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame1.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame1",
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame2"] = {
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame2.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame2",
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame3"] = {
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame3.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame3",
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame4"] = {
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame4.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame4",
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame5"] = {
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame5.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame5",
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame6"] = {
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame6.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame6",
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame7"] = {
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame7.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame7",
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame8"] = {
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame8.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame8",
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame9"] = {
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame9.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame9",
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame10"] = {
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame10.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame10",
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame11"] = {
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame11.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame11",
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame12"] = {
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame12.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame12",
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame13"] = {
        DriftDisabledBy = "bagsDisabled"
    },
    ["ContainerFrame13.ClickableTitleFrame"] = {
        DriftDelegate = "ContainerFrame13",
        DriftDisabledBy = "bagsDisabled"
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
    ["ReputationDetailFrame"] = {},
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

        -- Modify frames after an addon loads
        DriftHelpers:Wait(1, Drift.RegisterEvent, Drift, "ADDON_LOADED")

        -- Modify frames after combat ends
        Drift:RegisterEvent("PLAYER_REGEN_ENABLED")
    end
end

-- Respond to events to fix frames
Drift:SetScript("OnEvent", eventHandler)
Drift:RegisterEvent("VARIABLES_LOADED")
