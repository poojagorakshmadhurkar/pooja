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
PURCHASE_RECEIVE_URL = f"https://www.zohoapis.in/inventory/v1/purchasereceives?purchaseorder_id="

# Get PO integration ID from command-line argument
if len(sys.argv) < 2:
    print("❌ Error: Missing arguments. Usage: python check_zoho_pr.py [PO Integration ID]")
    sys.exit(1)

po_integration_id = sys.argv[1]  # PO Integration ID passed from Robot Framework

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

# Function to check if the purchase receipt exists in Zoho
def check_purchase_receipt(auth_token, po_integration_id):
    search_url = f"{PURCHASE_RECEIVE_URL}{po_integration_id}&organization_id={ZOHO_ORG_ID}"
    headers = {
        'Authorization': f'Zoho-oauthtoken {auth_token}',
        'Content-Type': 'application/json'
    }

    response = requests.get(search_url, headers=headers)

    if response.status_code == 200:
        purchase_receives = response.json().get("purchasereceives", [])
        if len(purchase_receives) > 0:
            print(f"✅ Purchase Receipt for PO Integration ID '{po_integration_id}' exists in Zoho Inventory.")
            sys.exit(0)  # Success
        else:
            print(f"❌ Purchase Receipt for PO Integration ID '{po_integration_id}' NOT found in Zoho Inventory.")
            sys.exit(1)  # Failure
    else:
        print(f"❌ Failed to check Purchase Receipt. Status Code: {response.status_code}, Response: {response.text}")
        sys.exit(1)

# Main execution
access_token = get_new_access_token()
if access_token:
    check_purchase_receipt(access_token, po_integration_id)
else:
    print("❌ Could not get access token. Exiting.")
    sys.exit(1)
