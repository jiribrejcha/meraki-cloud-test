#!/bin/bash

# Get the default gateway IP address
GATEWAY_IP=$(ip route | awk '/default/ {print $3}')
ETH0_UP=$(/sbin/ethtool eth0 2>/dev/null | awk '/Link detected/ {print $3}')
MY_IP=$(ip -4 addr show eth0 | awk '/inet / {print $2}' | cut -d'/' -f1)

## Cloud connectivity tests:

# Primary cloud connectivity
timeout 2 nc -uz 64.62.142.12 7351 > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    echo "Cloud UDP 7351:   OK"
else
    echo "Cloud UDP 7351: FAIL"
fi

# NTP server check
timeout 2 nc -uz pool.ntp.org 123 > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    echo "NTP UDP 123:      OK"
else
    echo "NTP UDP 123:    FAIL"
fi

# Backup cloud connectivity
nc -z -w2 158.115.128.12 80 > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    echo "Backup TCP 80:    OK"
else
    echo "Backup TCP 80:  FAIL"
fi

# Backup cloud connectivity
nc -z -w2 158.115.128.12 443 > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    echo "Backup TCP 443:   OK"
else
    echo "Backup TCP 443: FAIL"
fi

## Access points automatically perform the following tests:

# MR ping connection test
timeout 2 ping -c1 -W2 -4 -q 8.8.8.8 > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    echo "Ping 8.8.8.8:     OK"
else
    echo "Ping 8.8.8.8:   FAIL"
fi

# MR default gateway connection test
arping -c1 -w2 -I eth0 "$GATEWAY_IP" > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    echo "ARP Gateway:      OK"
else
    echo "ARP Gateway:    FAIL"
fi

# MR DNS lookup test
dig +short +time=2 +tries=1 NS pool.ntp.org > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    echo "DNS UDP 53:       OK"
else
    echo "DNS UDP 53:     FAIL"
fi