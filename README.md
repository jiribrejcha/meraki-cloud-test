# Cisco Meraki Cloud Test Shell Script

This script tests AP connectivity to the Cisco Meraki Dashboard service.

## Caveats
It uses custom IP addresses specific to my deployment. Dashboard uses a distributed architecture based on "Shards" and various Cisco Meraki devices added to various Networks use different Dashboard IP addresses.

The mr.sh script is specific to access points and it doesn't test connectivity for MX (SD-WAN/UTM security appliances) or MS (switches).
