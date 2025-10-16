#!/usr/bin/env python3
import json, os, sys

KEYS_FILE = "keys.json"

def verify_key():
    if not os.path.exists(KEYS_FILE):
        print("No key file found! Please run 'python3 key.py --generate' to create one.")
        sys.exit(1)

    with open(KEYS_FILE) as f:
        data = json.load(f)
    if data.get("license_key") == "AZIM-ULTIMATE-2025":
        print("✅ License verified successfully!")
        return True
    else:
        print("❌ Invalid license key!")
        sys.exit(1)

def generate_key():
    key = "TRAILKEY-FREE"
    with open(KEYS_FILE, "w") as f:
        json.dump({"license_key": key}, f)
    print(f"License key generated and saved to keys.json: {key}")

if __name__ == "__main__":
    if "--generate" in sys.argv:
        generate_key()
    else:
        verify_key()
