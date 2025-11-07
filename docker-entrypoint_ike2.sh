#!/bin/sh

# Simplified entrypoint script for IKEv2 client
# Assumes /etc/ipsec.conf and /etc/ipsec.secrets are correctly mounted.

set -e # Exit immediately if a command exits with a non-zero status.

echo "--- Simple IKEv2 Client Entrypoint Started ---"

# --- Check mounted config files (for debugging) ---
echo "Checking mounted configuration files..."
echo "--- /etc/ipsec.conf ---"
cat /etc/ipsec.conf || echo "/etc/ipsec.conf not found or empty. Please mount it correctly."
echo "--- /etc/ipsec.secrets ---"
ls -l /etc/ipsec.secrets || echo "/etc/ipsec.secrets not found or empty. Please mount it correctly."
# Ensure secrets file has correct permissions if mounted
chmod 600 /etc/ipsec.secrets

# --- Apply necessary Kernel Parameters (best effort) ---
# Should ideally be set via docker compose sysctls if possible
echo "Applying Kernel Parameters (sysctl)..."
sysctl -w net.ipv4.conf.all.rp_filter=0 || true
sysctl -w net.ipv4.conf.default.rp_filter=0 || true

# --- Start strongSwan using the standard 'ipsec' command in foreground ---
# This command will read /etc/ipsec.conf and start the daemon.
# The 'auto=start' in the mounted ipsec.conf should trigger the connection attempt.
echo "Starting strongSwan daemon (exec ipsec start --nofork)..."
# exec ipsec start --nofork 
# exec ipsec start --nofork &

# ipsec up ikev2-to-server
# ipsec up ikev2-to-server
# docker exec -it ipsec-client /bin/sh

# 2. รัน tail -f /dev/null ในเบื้องหน้า (Foreground)
# นี่คือคำสั่งหลักที่จะยึดให้ container ทำงานต่อไป
echo "Container is running... (tail -f /dev/null)"
tail -f /dev/null