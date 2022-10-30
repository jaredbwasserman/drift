# Drift
Addon for World of Warcraft that modifies default UI frames so you can click and drag to move and scale.

* [Drift (CurseForge)](https://www.curseforge.com/wow/addons/drift)
* [Drift (Wago)](https://addons.wago.io/addons/drift)

## Update Checklist
1. Bump addon version for retail, classic, bcc, wc.
1. Update Wago script interface versions.
1. Test retail, classic, wc.
1. Update CurseForge and Wago descriptions if needed.
1. Create a new GitHub release.
1. Use file naming convention `vX.Y.Z-<GAME>` (e.g. `v1.0.25-retail`).
1. Release on CurseForge and Wago.

## TODO
1. UpdateContainerFrameAnchors
   1. Bag behavior different in retail and classic - containerFrameOffsetX logic only exists in retail, so classic is not accurate
   1. Create separate versions of the override for retail, classic, bcc
   1. Probably need to update the existing retail function in case it's no longer accurate
1. Update FixMinimapDependentFrames functions if original code changed over time
1. Add scaling support for WorldMapFrame
1. Remove delay for Guild & Communities (retail) and Blizzard Groups (classic)
1. Configurable variables
   1. Opacity while moving and scaling
   1. Max and min scale
   1. Scale increment
1. Add GuildMemberDetailFrame (bcc) and equivalent for classic, retail
1. Add CharacterFrame tabs for wc
   1. Pet
   1. Reputation
1. Swap four spaces to tabs
1. Make options panel look like first-party options panels
   1. Also clean up code for options
1. Add Guild & Communities (retail)

## Bugs
1. When Dressing Room is already open, viewing a pet reverts frame position
1. CollectionsJournalMover in a different place than CollectionsJournal if opened in combat
1. Leave Group/Leave Guild (left-hand side buttons) causes Guild & Communities to revert position (retail)
1. PlayerChoiceToggleButton reverts its position when PlayerChoiceFrame is shown
   1. Happens in Torghast anima power choice
1. Fix UIWidgetTopCenterContainerFrame (classic)
   1. Dragging "Time Remaining" in BG causes the widget to get stuck in drag mode
   1. Sometimes the children do not get to be made movers, e.g. return from BG
   1. Need some recursion for the child movers, e.g. BG Horde and Ally bars
1. Clicking PlayerChoiceFrame buttons resets PlayerChoiceFrame (retail)
   1. Example is in Warfronts
   1. To fix, need to add Drift Tabs
1. Scaling Bugs
   1. Map does not work correctly after scaling WorldMapFrame
   1. Character model has incorrect size after scaling CharacterFrame
   1. Item models have incorrect size after scaling CollectionsJournal
1. Frames with tabs move from hotkey when on other tab
1. ColorPickerFrame moves when it's not supposed to (classic)
1. Some frames do not move depending on addons loaded
   1. TimeManagerFrame (retail and classic)
   1. TalkingHeadFrame (retail)
   1. PlayerChoiceFrame (retail, seems to only break right after login)
   1. LFGParentFrame (classic)
   1. OrderHallTalentFrame (retail)
1. Some frames do not reset position after Reset Frames is invoked
   1. Game Menu / Main Menu
   1. System
   1. Interface / Interface Options
   1. Key Bindings
   1. AddOn List
1. Leveling up causes frame positions to reset
1. LFG Button in Objective Tracker issues (retail)
   1. Interface Action failed due to addon happens when in combat and click on LFG button in objective tracker
   1. Click on LFG button in objective tracker (when window is already open) causes frames to revert
   1. Remove LFG events in code after fix
1. Item upgrade issue
   1. Open Item Upgrade frame
   1. Open Character Info frame
   1. Hit hot key for "Reputation" tab (Character Info)
   1. Frames will revert (not desired behavior)
   1. This might be the same bug as "Frames with tabs move from hotkey when on other tab"
1. Runecarving frame reverts position sometimes
1. Bags are probably broken for wc (might need to rethink how to deal with bags in general)