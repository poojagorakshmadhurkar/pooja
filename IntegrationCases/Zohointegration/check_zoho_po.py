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
SEARCH_PO_URL = f"https://www.zohoapis.in/inventory/v1/purchaseorders?organization_id={ZOHO_ORG_ID}&search_text="

# Get PO number from command-line argument
if len(sys.argv) < 2:
    print("❌ Error: Missing arguments. Usage: python check_zoho_po.py [PO Number]")
    sys.exit(1)

po_number = sys.argv[1]  # PO number passed from Robot Framework

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

# Retry wrapper
def check_po_exists(auth_token, po_number, retries=5, delay=5):
    search_url = f"{SEARCH_PO_URL}{po_number}"
    headers = {
        'Authorization': f'Zoho-oauthtoken {auth_token}',
        'Content-Type': 'application/json'
    }

    for attempt in range(1, retries + 1):
        print(f"🔍 Attempt {attempt}: Checking PO '{po_number}' in Zoho Inventory...")

        response = requests.get(search_url, headers=headers)

        if response.status_code == 200:
            purchase_orders = response.json().get("purchaseorders", [])
            if len(purchase_orders) > 0:
                print(f"✅ Purchase Order '{po_number}' FOUND in Zoho Inventory.")
                sys.exit(0)  # Success
            else:
                print(f"⚠️ PO '{po_number}' not found (yet). Retrying in {delay} seconds...")
        else:
            print(f"❌ API Error (Status {response.status_code}): {response.text}")

        time.sleep(delay)

    print(f"❌ Purchase Order '{po_number}' NOT found after {retries} attempts.")
    sys.exit(1)  # Final failure

# Main execution
access_token = get_new_access_token()
if access_token:
    check_po_exists(access_token, po_number)
else:
    print("❌ Could not get access token. Exiting.")
    sys.exit(1)
