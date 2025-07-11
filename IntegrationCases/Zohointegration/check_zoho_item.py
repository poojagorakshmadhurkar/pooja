import requests
import json
import sys
import time

# Ensure UTF-8 encoding
if sys.stdout.encoding != 'utf-8':
    sys.stdout.reconfigure(encoding='utf-8')

# Zoho API details
ZOHO_ORG_ID = "60035522227"
CLIENT_ID = "1000.L3YQLAYK4GRBR2HEV9WYZ8H1WXWLMO"
CLIENT_SECRET = "76cf9cf3f3924ef311adb988aa25f8304474c76e34"
REFRESH_TOKEN = "1000.d88df24aa2fb57e5d74cfef149084690.204d7130ab0d0479f5c661ae2d5e2a6d"

# API URLs
TOKEN_URL = "https://accounts.zoho.in/oauth/v2/token"
SEARCH_ITEM_URL = f"https://www.zohoapis.in/inventory/v1/items?organization_id={ZOHO_ORG_ID}&search_text="
# f"https://www.zohoapis.in/inventory/v1/items/{itemid}?organization_id={ZOHO_ORG_ID}&search_text="

# Get item name from command-line argument
if len(sys.argv) < 2:
    print("❌ Error: No item name provided.")
    sys.exit(1)

item_name = sys.argv[1]  # Item name received from Robot Framework


# Function to get a new access token
def get_new_access_token():
    payload = {
        "refresh_token": REFRESH_TOKEN,
        "client_id": CLIENT_ID,
        "client_secret": CLIENT_SECRET,
        "grant_type": "refresh_token"
    }
    response = requests.post(TOKEN_URL, data=payload)

    if response.status_code == 200:
        new_token = response.json().get("access_token")
        print(f"✅ New Access Token Obtained: {new_token}")
        return new_token
    else:
        print(f"❌ Failed to refresh token. Response: {response.text}")
        return None


# Function to check if the item exists in Zoho
def check_item_exists(auth_token, item_name):
    search_url = f"{SEARCH_ITEM_URL}{item_name}"
    headers = {
        'Authorization': f'Zoho-oauthtoken {auth_token}',
        'Content-Type': 'application/json'
    }

    time.sleep(0.5)
    response = requests.get(search_url, headers=headers)

    if response.status_code == 200:
        items = response.json().get("items", [])
        if len(items) > 0:
            print(f"✅ Item '{item_name}' exists in Zoho Inventory.")
            sys.exit(0)  # Success exit code
        else:
            print(f"❌ Item '{item_name}' NOT found in Zoho Inventory.")
            sys.exit(1)  # Failure exit code
    else:
        print(f"❌ Failed to check item. Status Code: {response.status_code}, Response: {response.text}")
        sys.exit(1)  # Failure exit code


# Main execution
access_token = get_new_access_token()
if access_token:
    check_item_exists(access_token, item_name)
else:
    print("❌ Could not get access token. Exiting.")
    sys.exit(1)
