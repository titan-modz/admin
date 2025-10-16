#!/usr/bin/env python3
import json, os, sys, random, hashlib, getpass

KEYS_FILE = "keys.json"
SECRET_FILE = "secret.json"

def save_secret_hash(secret):
    """Save the hashed secret (first time setup)"""
    hashed = hashlib.sha256(secret.encode()).hexdigest()
    with open(SECRET_FILE, "w") as f:
        json.dump({"secret_hash": hashed}, f, indent=4)
    print("🔐 Secret code saved securely for future use!")

def check_secret(secret):
    """Check if entered secret matches saved hash"""
    if not os.path.exists(SECRET_FILE):
        print("⚠️  No secret code found! Setting it up for the first time.")
        save_secret_hash(secret)
        return True
    else:
        with open(SECRET_FILE) as f:
            data = json.load(f)
        saved_hash = data.get("secret_hash", "")
        return hashlib.sha256(secret.encode()).hexdigest() == saved_hash

def generate_key(user):
    """Generate a license key"""
    user_part = user.upper()
    key_id = random.randint(10000, 99999)
    key = f"TRAILKEY-{user_part}-{key_id}"

    with open(KEYS_FILE, "w") as f:
        json.dump({"license_key": key}, f, indent=4)

    print(f"✅ License key generated and saved to {KEYS_FILE}: {key}")

def verify_key():
    """Verify existing key"""
    if not os.path.exists(KEYS_FILE):
        print("❌ No key file found! Please generate one first.")
        sys.exit(1)

    with open(KEYS_FILE) as f:
        data = json.load(f)

    key = data.get("license_key", "")
    if key.startswith("TRAILKEY-"):
        print(f"✅ License verified successfully! Your key: {key}")
    else:
        print("❌ Invalid license key!")
        sys.exit(1)

if __name__ == "__main__":
    print("🔐 License Key Generator")
    secret = getpass.getpass("Enter secret code to generate key: ").strip()

    if check_secret(secret):
        user = input("Enter your username: ").strip()
        if not user:
            print("❌ Username cannot be empty!")
            sys.exit(1)
        generate_key(user)
    else:
        print("❌ Invalid secret code! Access denied.")
        sys.exit(1)
