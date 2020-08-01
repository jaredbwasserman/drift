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
1. Always scale from center
1. Make ZoneAbilityFrame, ExtraActionButton1 have better handles
1. Make modified UpdateContainerFrameAnchors more performant
  1. Try limiting the number of times it can be called in some increment

## Bugs
1. Scaling Bugs
   1. Map does not work correctly after scaling WorldMapFrame
   1. Character model has incorrect size after scaling CharacterFrame
   1. Item models have incorrect size after scaling CollectionsJournal
1. Frames with tabs move from hotkey when on other tab
1. ColorPickerFrame moves when it's not supposed to
1. TimeManagerFrame and TalkingHeadFrame do not move depending on addons loaded
1. GameMenuFrame does not reset its position after Reset Frames is invoked
