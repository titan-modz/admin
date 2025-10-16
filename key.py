#!/usr/bin/env python3
import json, os, sys, random, hashlib, getpass

KEYS_FILE = "keys.json"

SECRET_HASH = "a80227d65a86993b5e04d5c66e4b6d01b40cc8a6f4578579ec8a62f0da44a4a3"

def verify_key():
    if not os.path.exists(KEYS_FILE):
        print("❌ No key file found! Please run this script to create one.")
        sys.exit(1)

    with open(KEYS_FILE) as f:
        data = json.load(f)

    key = data.get("license_key", "")
    if key.startswith("TRAILKEY-"):
        print(f"✅ License verified successfully! Your key: {key}")
        return True
    else:
        print("❌ Invalid license key!")
        sys.exit(1)

def generate_key(user):
    user_part = user.upper()
    key_id = random.randint(10000, 99999)
    key = f"TRAILKEY-{user_part}-{key_id}"

    with open(KEYS_FILE, "w") as f:
        json.dump({"license_key": key}, f, indent=4)

    print(f"✅ License key generated and saved to {KEYS_FILE}: {key}")

def check_secret(secret):
    """Check if entered secret matches hashed version"""
    hashed = hashlib.sha256(secret.encode()).hexdigest()
    return hashed == SECRET_HASH

if __name__ == "__main__":
    print("🔐 License Key Generator")

    # Ask for the secret code securely (hidden input)
    secret = getpass.getpass("Enter secret code to generate key: ")

    if check_secret(secret):
        user = input("Enter your username: ").strip()
        if not user:
            print("❌ Username cannot be empty!")
            sys.exit(1)
        generate_key(user)
    else:
        print("❌ Invalid secret code! Access denied.")
        sys.exit(1)
