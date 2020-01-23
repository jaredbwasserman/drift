import os
import sys
import shutil

# Get WoW directory as first arg
wow_dir = sys.argv[1]

# Construct retail and classic addon directories
drift_dir_retail = os.path.join(wow_dir, '_retail_/Interface/AddOns/Drift')
drift_dir_classic = os.path.join(wow_dir, '_classic_/Interface/AddOns/Drift')

# Copy retail
if os.path.exists(drift_dir_retail):
    shutil.rmtree(drift_dir_retail)
shutil.copytree('../source/retail', drift_dir_retail)
shutil.copy2('../source/DriftHelpers.lua', os.path.join(drift_dir_retail, 'DriftHelpers.lua'))

# Copy classic
if os.path.exists(drift_dir_classic):
    shutil.rmtree(drift_dir_classic)
shutil.copytree('../source/classic', drift_dir_classic)
shutil.copy2('../source/DriftHelpers.lua', os.path.join(drift_dir_classic, 'DriftHelpers.lua'))
