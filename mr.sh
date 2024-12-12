#!/bin/bash

# Get the default gateway IP address
GATEWAY_IP=$(ip route | grep "default" | awk '{print $3}')
ETH0_UP=$(/sbin/ethtool eth0 | grep 'Link detected'| awk '{print $3}')
MY_IP=$(ip address show eth0 | grep 'inet ' | awk '{print $2}' | awk -F'/' '{print $1}')

timeout 4 nc -uz 64.62.142.12 7351 > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    echo "Cloud UDP 7351:   OK"
else
    echo "Cloud UDP 7351: FAIL"
fi

nc -z -w4 158.115.128.12 80 > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    echo "Backup TCP 80:    OK"
else
    echo "Backup TCP 80:  FAIL"
fi

nc -z -w4 158.115.128.12 443 > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    echo "Backup TCP 443:   OK"
else
    echo "Backup TCP 443: FAIL"
fi

dig +short +time=4 +tries=1 @8.8.8.8 NS pool.ntp.org > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    echo "Resolve 8.8.8.8:  OK"
else
    echo "Resolve 8.8.8.8: FAIL"
fi

nc -uz pool.ntp.org 123 > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    echo "NTP UDP 123:      OK"
else
    echo "NTP UDP 123:    FAIL"
fi

timeout 4 ping -c1 -W2 -4 -q 8.8.8.8 > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    echo "Ping 8.8.8.8:     OK"
else
    echo "Ping 8.8.8.8:   FAIL"
fi

arping -c1 -w4 -I eth0 "$GATEWAY_IP" > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    echo "ARP Gateway:      OK"
else
    echo "ARP Gateway:    FAIL"
fi
