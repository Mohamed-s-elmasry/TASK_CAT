#!/bin/bash

WARP_INTERFACE="warp0"
OPENVPN_CONFIG="/home/kali/Downloads/MohamedELmasry.ovpn"
PING_TARGET="10.10.10.10"
VERBOSE=false

while getopts ":w:o:p:v" opt; do
  case $opt in
    w) WARP_INTERFACE="$OPTARG" ;;
    o) OPENVPN_CONFIG="$OPTARG" ;;
    p) PING_TARGET="$OPTARG" ;;
    v) VERBOSE=true ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
  esac
done

# Function to print verbose messages
function print_verbose {
    if [ "$VERBOSE" = true ]; then
        echo "[INFO] $1"
    fi
}

print_verbose "Connecting to Warp..."
warp-cli connect

# Check if an IP has been assigned
warp_ip=$(curl -s ifconfig.me)
if [ -n "$warp_ip" ]; then
    print_verbose "Warp IP assigned: $warp_ip"
else
    echo "Error: Warp connection failed. Exiting."
    warp-cli disconnect
    exit 1
fi

print_verbose "Connecting to OpenVPN in the background..."
openvpn --config "$OPENVPN_CONFIG" &
openvpn_pid=$!

sleep 5  # Allow OpenVPN connection

print_verbose "Second check - Ping the target IP..."
ping_result=$(ping -c 3 "$PING_TARGET")
print_verbose "Ping result: $ping_result"

print_verbose "Disconnecting from Warp..."
warp-cli disconnect

wait $openvpn_pid  # Wait for OpenVPN process to finish

echo "Script completed."
