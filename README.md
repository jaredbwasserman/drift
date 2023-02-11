# Drift
Addon for World of Warcraft that modifies default UI frames so you can click and drag to move and scale.

* [Drift (CurseForge)](https://www.curseforge.com/wow/addons/drift)
* [Drift (Wago)](https://addons.wago.io/addons/drift)

## Update Checklist
1. Bump addon version in toc files.
1. Update interface versions in curseforge script and wago script.
1. Update curseforge and wago descriptions if needed.
1. Generate artifacts.
1. Create a new GitHub release.
   1. Upload artifacts in the new release.
1. Release on CurseForge and Wago.

## TODO
1. Add scaling support for WorldMapFrame
1. Configurable variables
   1. Opacity while moving and scaling
   1. Max and min scale
   1. Scale increment
1. Add GuildMemberDetailFrame (classic, wc)
1. Make options panel look like first-party options panels
   1. Also clean up code for options
   1. Also default/cancel functionality retail
1. Figure out how to get MinimapZoneTextButton to work for dragging Minimap (wc)

## Bugs
1. Scaling Bugs
   1. Map does not work correctly after scaling WorldMapFrame
   1. Character model has incorrect size after scaling CharacterFrame
   1. Item models have incorrect size after scaling CollectionsJournal
1. Some frames do not move depending on addons loaded
   1. TimeManagerFrame (retail, classic, wc)
   1. PlayerChoiceFrame
   1. LFGParentFrame (classic)