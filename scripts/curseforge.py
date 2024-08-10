import json
import os
import requests
import sys


# Current interface versions
# Go to https://console.curseforge.com/?#/api-keys
# curl -X GET https://api.curseforge.com/v1/games -H 'Accept: application/json' -H 'x-api-key: API_KEY'
# curl -X GET https://api.curseforge.com/v2/games/wow/versions -H 'Accept: application/json' -H 'x-api-key: API_KEY'
interface_version = {
	'classic': 11459, # 1.15.3
	'retail': 11274, # 11.0.0
	'wc': 10272, # 3.4.3
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
