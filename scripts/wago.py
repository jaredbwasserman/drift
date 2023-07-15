import json
import os
import requests
import sys


# Name of patch key
patch_key = {
	'classic': 'supported_classic_patch',
	'retail': 'supported_retail_patch',
	'wc': 'supported_wotlk_patch',
}

# Current interface versions
interface_version = {
	'classic': '1.14.3',
	'retail': '10.1.5',
	'wc': '3.4.2',
}

# Get source directory
if len(sys.argv) < 2:
	raise ValueError('Must give source directory as first argument')
source_dir = sys.argv[1]

# Get env vars
wago_project_id = os.environ['WAGO_PROJECT_ID']
wago_api_token = os.environ['WAGO_API_TOKEN']

# Get package info
count = 0
with open(os.path.join(source_dir, 'package-info.txt'), 'r') as f:
	while count < 3:
		name = f.readline().strip()
		label = f.readline().strip()
		addon_version = f.readline().strip()
		file_path = f.readline().strip()
		count = count + 1

		metadata = {
			'label': label,
			'stability': 'stable',
			'changelog': '#Changelog',
			patch_key[name]: interface_version[name],
		}

		session = requests.Session()
		response = session.post(
			'https://addons.wago.io/api/projects/{0}/version'.format(wago_project_id),
			headers={
				'authorization': 'Bearer {0}'.format(wago_api_token),
				'accept': 'application/json',
			},
			data={
				'metadata': json.dumps(metadata),
			},
			files={
				'file': open(file_path, 'rb'),
			}
		)
		print(response.text)
		print()
