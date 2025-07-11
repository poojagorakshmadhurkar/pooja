import requests
import json
import sys

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
SEARCH_VENDOR_URL = f"https://www.zohoapis.in/inventory/v1/contacts?organization_id={ZOHO_ORG_ID}&search_text="

# Get vendor name from command-line argument
if len(sys.argv) < 3:
    print("❌ Error: Missing arguments. Usage: python check_zoho.py vendor [Vendor Name]")
    sys.exit(1)

search_type = sys.argv[1].lower()
vendor_name = sys.argv[2]

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
        return new_token
    else:
        print(f"❌ Failed to refresh token. Response: {response.text}")
        return None

# Function to check if the vendor exists in Zoho
def check_vendor_exists(auth_token, vendor_name):
    search_url = f"{SEARCH_VENDOR_URL}{vendor_name}"
    headers = {
        'Authorization': f'Zoho-oauthtoken {auth_token}',
        'Content-Type': 'application/json'
    }

    response = requests.get(search_url, headers=headers)

    if response.status_code == 200:
        contacts = response.json().get("contacts", [])
        if len(contacts) > 0:
            print(f"Vendor '{vendor_name}' exists in Zoho Inventory.")  # ✅ Removed extra space

            sys.exit(0)  # Success
        else:
            print(f"❌ Vendor '{vendor_name}' NOT found in Zoho Inventory.")
            sys.exit(1)  # Failure
    else:
        print(f"❌ Failed to check vendor. Status Code: {response.status_code}, Response: {response.text}")
        sys.exit(1)

# Main execution
access_token = get_new_access_token()
if access_token:
    check_vendor_exists(access_token, vendor_name)
else:
    print("❌ Could not get access token. Exiting.")
    sys.exit(1)
