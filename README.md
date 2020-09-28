# Drift
Addon for World of Warcraft that modifies default UI frames so you can click and drag to move and scale.

CurseForge links:
 * [Drift (Retail)](https://www.curseforge.com/wow/addons/drift)
 * [Drift (Classic)](https://www.curseforge.com/wow/addons/driftclassic)

## TODO
1. Add scaling support for WorldMapFrame
1. Per frame reset
1. Remove delay for Guild & Communities
1. Configurable variables
   1. Opacity while moving and scaling
   1. Max and min scale
   1. Scale increment
1. Make ZoneAbilityFrame, ExtraActionButton1 have better handles
1. Add "/drift reset" alias to "/driftreset" and maybe more commands
   1. Make sure to update documentation

## Bugs
1. Scaling Bugs
   1. Map does not work correctly after scaling WorldMapFrame
   1. Character model has incorrect size after scaling CharacterFrame
   1. Item models have incorrect size after scaling CollectionsJournal
1. Frames with tabs move from hotkey when on other tab
1. ColorPickerFrame moves when it's not supposed to
1. TimeManagerFrame and TalkingHeadFrame do not move depending on addons loaded
1. Some frames do not reset position after Reset Frames is invoked
   1. Game Menu / Main Menu
   1. System
   1. Interface / Interface Options
   1. Key Bindings
   1. AddOn List
1. Opening Recruit A Friend Rewards SideDressUpFrame reverts positions 
