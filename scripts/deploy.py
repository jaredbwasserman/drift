import os
import sys
import shutil


# Get repo directory
drift_repo_dir = os.path.dirname(os.path.dirname(os.path.abspath(sys.argv[0])))

# Get WoW directory
if len(sys.argv) < 2:
    raise ValueError('Must give WoW directory as first argument')
wow_dir = sys.argv[1]

# Directories
source_dir = os.path.join(drift_repo_dir, 'src')
source_dir_retail = os.path.join(source_dir, 'retail')
source_dir_classic = os.path.join(source_dir, 'classic')
source_dir_bcc = os.path.join(source_dir, 'bcc')
dest_dir_retail = os.path.join(wow_dir, '_retail_/Interface/AddOns/Drift')
dest_dir_classic = os.path.join(wow_dir, '_classic_era_/Interface/AddOns/Drift')
dest_dir_bcc = os.path.join(wow_dir, '_classic_/Interface/AddOns/Drift')

# Helper file locations
source_helpers = os.path.join(source_dir, 'DriftHelpers.lua')
dest_helpers_retail = os.path.join(dest_dir_retail, 'DriftHelpers.lua')
dest_helpers_classic = os.path.join(dest_dir_classic, 'DriftHelpers.lua')
dest_helpers_bcc = os.path.join(dest_dir_bcc, 'DriftHelpers.lua')

# Option file locations
source_options = os.path.join(source_dir, 'DriftOptions.lua')
dest_options_retail = os.path.join(dest_dir_retail, 'DriftOptions.lua')
dest_options_classic = os.path.join(dest_dir_classic, 'DriftOptions.lua')
dest_options_bcc = os.path.join(dest_dir_bcc, 'DriftOptions.lua')

# Copy retail
if os.path.exists(dest_dir_retail):
    shutil.rmtree(dest_dir_retail)
print('Copying\n  {0} to\n  {1}'.format(source_dir_retail, dest_dir_retail))
shutil.copytree(source_dir_retail, dest_dir_retail)
print('Copying\n  {0} to\n  {1}'.format(source_helpers, dest_helpers_retail))
shutil.copy2(source_helpers, dest_helpers_retail)
print('Copying\n  {0} to\n  {1}'.format(source_options, dest_options_retail))
shutil.copy2(source_options, dest_options_retail)

# Copy classic
if os.path.exists(dest_dir_classic):
    shutil.rmtree(dest_dir_classic)
print('Copying\n  {0} to\n  {1}'.format(source_dir_classic, dest_dir_classic))
shutil.copytree(source_dir_classic, dest_dir_classic)
print('Copying\n  {0} to\n  {1}'.format(source_helpers, dest_helpers_classic))
shutil.copy2(source_helpers, dest_helpers_classic)
print('Copying\n  {0} to\n  {1}'.format(source_options, dest_options_classic))
shutil.copy2(source_options, dest_options_classic)

# Copy bcc
if os.path.exists(dest_dir_bcc):
    shutil.rmtree(dest_dir_bcc)
print('Copying\n  {0} to\n  {1}'.format(source_dir_bcc, dest_dir_bcc))
shutil.copytree(source_dir_bcc, dest_dir_bcc)
print('Copying\n  {0} to\n  {1}'.format(source_helpers, dest_helpers_bcc))
shutil.copy2(source_helpers, dest_helpers_bcc)
print('Copying\n  {0} to\n  {1}'.format(source_options, dest_options_bcc))
shutil.copy2(source_options, dest_options_bcc)
