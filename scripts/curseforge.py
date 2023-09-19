import json
import os
import requests
import sys


# Current interface versions
# GET https://wow.curseforge.com/api/game/versions
interface_version = {
	'classic': 9895, # 1.14.4
	'retail': 10163, # 10.1.7
	'wc': 9894, # 3.4.2
}

# Get source directory
if len(sys.argv) < 2:
	raise ValueError('Must give source directory as first argument')
source_dir = sys.argv[1]

# Get env vars
curseforge_project_id = os.environ['CURSEFORGE_PROJECT_ID']
curseforge_api_token = os.environ['CURSEFORGE_API_TOKEN']

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
			'changelog': '',
			'displayName': label,
			'gameVersions': [interface_version[name]],
			'releaseType': 'release',
		}

		session = requests.Session()
		response = session.post(
			'https://wow.curseforge.com/api/projects/{0}/upload-file'.format(curseforge_project_id),
			headers={
				'X-Api-Token': curseforge_api_token,
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
