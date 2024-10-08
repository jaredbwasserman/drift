# Drift

Addon for World of Warcraft that modifies default UI frames so you can click and drag to move and scale.

- [Drift (CurseForge)](https://www.curseforge.com/wow/addons/drift)
- [Drift (Wago)](https://addons.wago.io/addons/drift)

## Update Checklist

1. Update addon version in toc files.
1. Update interface version in toc files.
1. Update interface version in scripts.
1. Update curseforge description and wago description if needed.
1. Generate artifacts.
1. Create a new github release.
   1. Upload artifacts in the new release.
1. Release on curseforge and wago.

## TODO

1. Move relevant TODO items to issues
1. Move Bugs to issues
1. Fix code so there is the same set of files for all releases
   1. Detect the game version when setting things up
   1. One `Drift.lua` file that has union of all (alphabetized)
1. Configurable variables
   1. Opacity while moving and scaling
   1. Max and min scale
   1. Scale increment
1. Add GuildMemberDetailFrame (classic, wc)
1. Make options panel look like first-party options panels
   1. Also clean up code for options
   1. Also default/cancel functionality retail
1. Figure out how to get MinimapZoneTextButton to work for dragging Minimap (wc)
1. Add currency transfer log
1. Add classic world map
1. Add warband bank tab thing icon
1. Add more TWW frames

## Bugs

1. Scaling Bugs
   1. Map does not work correctly after scaling WorldMapFrame
   1. Character model has incorrect size after scaling CharacterFrame
   1. Item models have incorrect size after scaling CollectionsJournal
1. Some frames do not move depending on addons loaded
   1. TimeManagerFrame (retail, classic, wc)
   1. PlayerChoiceFrame
   1. LFGParentFrame (classic)
