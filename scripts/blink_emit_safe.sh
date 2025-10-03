#!/bin/bash
set -e  # Exit immediately if any command fails

# === Step 1: Decrypt GPG Key ===
echo "[Blink Emit] Decrypting private key..."
gpg --batch --yes --decrypt keys/private_key.gpg > /tmp/priv_with_prefix.txt

# === Step 2: Load and Validate Key ===
key=$(cat /tmp/priv_with_prefix.txt | tr -d '\n\r')
key_length=${#key}
echo "[Blink Emit] Key length: $key_length"

if [ "$key_length" -ne 66 ]; then
  echo "[Error] Decrypted key must be 66 characters (0x-prefixed 64 hex). Got $key_length."
  rm /tmp/priv_with_prefix.txt
  exit 1
fi

# === Step 3: Display Environment Variables ===
echo "[Blink Emit] PULSE_COUNTER: $PULSE_COUNTER"
echo "[Blink Emit] MANIFEST_CID: $MANIFEST_CID"
echo "[Blink Emit] ENTROPY_HASH: $ENTROPY_HASH"
echo "[Blink Emit] SIGIL_HEX: $SIGIL_HEX"
echo "[Blink Emit] CONTRACT_ADDR: $CONTRACT_ADDR"
echo "[Blink Emit] RPC_URL: $RPC_URL"

# === Step 4: Emit Blink (Placeholder for actual cast/anvil logic) ===
echo "[Blink Emit] Emitting pulse $PULSE_COUNTER to $CONTRACT_ADDR..."
# Example: cast send --rpc-url "$RPC_URL" --private-key "$key" "$CONTRACT_ADDR" "emit(uint256,string,bytes32,bytes20)"
# Replace with actual Foundry or Anvil command

# === Step 5: Cleanup ===
rm /tmp/priv_with_prefix.txt
echo "[Blink Emit] Temporary key file removed. Emission complete."
