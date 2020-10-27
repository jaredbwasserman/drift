# Drift
Addon for World of Warcraft that modifies default UI frames so you can click and drag to move and scale.

CurseForge links:
 * [Drift (Retail)](https://www.curseforge.com/wow/addons/drift)
 * [Drift (Classic)](https://www.curseforge.com/wow/addons/driftclassic)

## TODO
1. Output messages of the form "Drift: Sentence ending with period."
   1. Reset from /driftreset (Drift: Reset position and scale for all supported frames complete.)
   1. Reset from "Reset Frames" button (Drift: Reset position and scale for all supported frames complete.)
   1. Scaling not supported (Drift: Scaling not supported for XYZFrame.)
1. Bag behavior different in retail and classic
   1. containerFrameOffsetX logic only exists in retail, so classic is not accurate
1. Wording should be "Reset position and scale for all SUPPORTED frames"
1. Add scaling support for WorldMapFrame
1. Per frame reset
1. Remove delay for Guild & Communities (retail) and Blizzard Groups (classic)
1. Configurable variables
   1. Opacity while moving and scaling
   1. Max and min scale
   1. Scale increment
1. Add "/drift reset" alias to "/driftreset" and maybe more commands
   1. Make sure to update documentation
1. Make Achievements an optional frame
1. Make /driftreset and "Reset Frames" cause the UI to reload
1. Fix UIWidgetTopCenterContainerFrame (retail and classic)

## Bugs
1. Scaling Bugs
   1. Map does not work correctly after scaling WorldMapFrame
   1. Character model has incorrect size after scaling CharacterFrame
   1. Item models have incorrect size after scaling CollectionsJournal
1. Frames with tabs move from hotkey when on other tab
1. ColorPickerFrame moves when it's not supposed to
1. Some frames do not move depending on addons loaded
   1. TimeManagerFrame
   1. TalkingHeadFrame
   1. PlayerChoiceFrame (seems to only break right after login)
1. Some frames do not reset position after Reset Frames is invoked
   1. Game Menu / Main Menu
   1. System
   1. Interface / Interface Options
   1. Key Bindings
   1. AddOn List
1. SideDressUpFrame Bugs
   1. Opening Recruit A Friend Rewards SideDressUpFrame reverts positions (retail)
   1. Opening Auction House SideDressUpFrame reverts positions (classic)
1. Leveling up causes frame positions to reset
