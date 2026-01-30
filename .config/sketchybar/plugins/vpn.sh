#!/bin/sh

# Check for common VPN interfaces/services
VPN_STATUS=""

# Check utun interfaces (WireGuard, etc)
UTUN=$(ifconfig | grep -c "utun[0-9].*inet ")

# Check for common VPN apps
if pgrep -x "Cloudflare WARP" > /dev/null 2>&1; then
  VPN_STATUS="WARP"
elif pgrep -x "WireGuard" > /dev/null 2>&1; then
  VPN_STATUS="WG"
elif pgrep -x "openvpn" > /dev/null 2>&1; then
  VPN_STATUS="OVPN"
elif pgrep -x "Tunnelblick" > /dev/null 2>&1; then
  VPN_STATUS="VPN"
elif [ "$UTUN" -gt 0 ]; then
  VPN_STATUS="VPN"
fi

# Check scutil for VPN
if [ -z "$VPN_STATUS" ]; then
  SCUTIL_VPN=$(scutil --nc list 2>/dev/null | grep Connected)
  if [ -n "$SCUTIL_VPN" ]; then
    VPN_STATUS="VPN"
  fi
fi

if [ -n "$VPN_STATUS" ]; then
  sketchybar --set "$NAME" icon=󰦝 icon.color=0xffa3be8c label="$VPN_STATUS"
else
  sketchybar --set "$NAME" icon=󰦞 icon.color=0xff4c566a label=""
fi
