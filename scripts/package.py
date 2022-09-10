import os
import sys
import shutil
from zipfile import ZipFile


# Get interface version from toc file
def get_toc_info(toc_path, field):
    with open(toc_path) as f:
        line = f.readline()
        while line:
            if field in line:
                return line.split(':')[1].strip()
            line = f.readline()
    return None


def zip(path):
    with ZipFile('{0}.zip'.format(path), 'w') as zf:
        print('Zipping\n  {0} as\n  {0}.zip\n'.format(path))
        for root, dirs, files in os.walk(path):
            for file in files:
                zf.write(
                    os.path.join(root, file),
                    os.path.join('Drift', file)
                )


# Get repo directory
drift_repo_dir = os.path.dirname(os.path.dirname(os.path.abspath(sys.argv[0])))

# Get destination directory
if len(sys.argv) < 2:
    raise ValueError('Must give destination directory as first argument')
dest_dir = sys.argv[1]

# Directories
source_dir = os.path.join(drift_repo_dir, 'src')
source_dir_retail = os.path.join(source_dir, 'retail')
source_dir_classic = os.path.join(source_dir, 'classic')
source_dir_wc = os.path.join(source_dir, 'wc')

# Helper file location
source_helpers = os.path.join(source_dir, 'DriftHelpers.lua')

# Option file location
source_options = os.path.join(source_dir, 'DriftOptions.lua')

# Get version numbers and interface numbers
source_toc_retail = os.path.join(source_dir_retail, 'Drift.toc')
source_toc_classic = os.path.join(source_dir_classic, 'Drift.toc')
source_toc_wc = os.path.join(source_dir_wc, 'Drift.toc')
version_retail = 'v' + get_toc_info(source_toc_retail, 'Version')
version_classic = 'v' + get_toc_info(source_toc_classic, 'Version')
version_wc = 'v' + get_toc_info(source_toc_wc, 'Version')
interface_retail = get_toc_info(source_toc_retail, 'Interface')
interface_classic = get_toc_info(source_toc_classic, 'Interface')
interface_wc = get_toc_info(source_toc_wc, 'Interface')

# Destinations
dest_name_retail = '-'.join(['drift', version_retail, 'retail'])
dest_name_classic = '-'.join(['drift', version_classic, 'classic'])
dest_name_wc = '-'.join(['drift', version_wc, 'wc'])
dest_dir_retail = os.path.join(dest_dir, dest_name_retail)
dest_dir_classic = os.path.join(dest_dir, dest_name_classic)
dest_dir_wc = os.path.join(dest_dir, dest_name_wc)
dest_helpers_retail = os.path.join(dest_dir_retail, 'DriftHelpers.lua')
dest_helpers_classic = os.path.join(dest_dir_classic, 'DriftHelpers.lua')
dest_helpers_wc = os.path.join(dest_dir_wc, 'DriftHelpers.lua')
dest_options_retail = os.path.join(dest_dir_retail, 'DriftOptions.lua')
dest_options_classic = os.path.join(dest_dir_classic, 'DriftOptions.lua')
dest_options_wc = os.path.join(dest_dir_wc, 'DriftOptions.lua')

# Copy retail
if os.path.exists(dest_dir_retail):
    shutil.rmtree(dest_dir_retail)
print('Copying\n  {0} to\n  {1}\n'.format(source_dir_retail, dest_dir_retail))
shutil.copytree(source_dir_retail, dest_dir_retail)
print('Copying\n  {0} to\n  {1}\n'.format(source_helpers, dest_helpers_retail))
shutil.copy2(source_helpers, dest_helpers_retail)
print('Copying\n  {0} to\n  {1}\n'.format(source_options, dest_options_retail))
shutil.copy2(source_options, dest_options_retail)

# Zip retail and clean up
zip(dest_dir_retail)
print('Removing {0}\n'.format(dest_dir_retail))
shutil.rmtree(dest_dir_retail)

# Copy classic
if os.path.exists(dest_dir_classic):
    shutil.rmtree(dest_dir_classic)
print('Copying\n  {0} to\n  {1}\n'.format(source_dir_classic, dest_dir_classic))
shutil.copytree(source_dir_classic, dest_dir_classic)
print('Copying\n  {0} to\n  {1}\n'.format(source_helpers, dest_helpers_classic))
shutil.copy2(source_helpers, dest_helpers_classic)
print('Copying\n  {0} to\n  {1}\n'.format(source_options, dest_options_classic))
shutil.copy2(source_options, dest_options_classic)

# Zip classic and clean up
zip(dest_dir_classic)
print('Removing {0}\n'.format(dest_dir_classic))
shutil.rmtree(dest_dir_classic)

# Copy wc
if os.path.exists(dest_dir_wc):
    shutil.rmtree(dest_dir_wc)
print('Copying\n  {0} to\n  {1}\n'.format(source_dir_wc, dest_dir_wc))
shutil.copytree(source_dir_wc, dest_dir_wc)
print('Copying\n  {0} to\n  {1}\n'.format(source_helpers, dest_helpers_wc))
shutil.copy2(source_helpers, dest_helpers_wc)
print('Copying\n  {0} to\n  {1}\n'.format(source_options, dest_options_wc))
shutil.copy2(source_options, dest_options_wc)

# Zip wc and clean up
zip(dest_dir_wc)
print('Removing {0}\n'.format(dest_dir_wc))
shutil.rmtree(dest_dir_wc)
