# Cisco Meraki Cloud Test Shell Script

This script tests AP connectivity to the Cisco Meraki Dashboard service.

<img width="326" alt="image" src="https://github.com/user-attachments/assets/9aa5de0b-97ec-4cb1-af9d-99379d161e41" />

## Caveats
It uses custom IP addresses specific to my deployment. Dashboard uses a distributed architecture based on "Shards" and various Cisco Meraki devices added to various Networks use different Dashboard IP addresses.

The mr.sh script is specific to access points. It doesn't test connectivity for MX (SD-WAN/UTM security appliances) or MS (switches).

## Documentation
[Here is](https://documentation.meraki.com/General_Administration/Other_Topics/Upstream_Firewall_Rules_for_Cloud_Connectivity) the official documentation.
