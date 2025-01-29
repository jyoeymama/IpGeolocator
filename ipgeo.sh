#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Banner
echo -e "${RED} .___           ________             .__                        __                        ____ "
echo -e "${RED} |   |_____    /  _____/  ____  ____ |  |   ____   ____ _____ _/  |_  ___________  ___  _/_   |"
echo -e "${RED} |   \____ \  /   \  ____/ __ \/  _ \|  |  /  _ \_/ ___\\__  \\   __\/  _ \_  __ \ \  \/ /|   |"
echo -e "${RED} |   |  |_> > \    \_\  \  ___(  <_> )  |_(  <_> )  \___ / __ \|  | (  <_> )  | \/  \   / |   |"
echo -e "${RED} |___|   __/   \______  /\___  >____/|____/\____/ \___  >____  /__|  \____/|__|      \_/  |___|"
echo -e "${RED}     |__|             \/     \/                       \/     \/                                 ${NC}"
echo ""

# Prompt for IP input
read -p "Enter an IP address or type 'myip' to check your own: " ip

# Check if user wants to retrieve their own IP
if [[ "$ip" == "myip" ]]; then
    ip=$(curl -s https://api64.ipify.org)
fi

# Fetch IP geolocation data
response=$(curl -s "http://ip-api.com/json/$ip")

# Extract and display details
status=$(echo "$response" | grep -o '"status":"success"')

if [[ -n "$status" ]]; then
    country=$(echo "$response" | grep -o '"country":"[^"]*' | cut -d':' -f2 | tr -d '"')
    region=$(echo "$response" | grep -o '"regionName":"[^"]*' | cut -d':' -f2 | tr -d '"')
    city=$(echo "$response" | grep -o '"city":"[^"]*' | cut -d':' -f2 | tr -d '"')
    isp=$(echo "$response" | grep -o '"isp":"[^"]*' | cut -d':' -f2 | tr -d '"')
    lat=$(echo "$response" | grep -o '"lat":[^,]*' | cut -d':' -f2)
    lon=$(echo "$response" | grep -o '"lon":[^,]*' | cut -d':' -f2)

    echo -e "${GREEN} [+] IP Address: ${CYAN}$ip${NC}"
    echo -e "${GREEN} [+] Country: ${CYAN}$country${NC}"
    echo -e "${GREEN} [+] Region: ${CYAN}$region${NC}"
    echo -e "${GREEN} [+] City: ${CYAN}$city${NC}"
    echo -e "${GREEN} [+] ISP: ${CYAN}$isp${NC}"
    echo -e "${GREEN} [+] Latitude: ${CYAN}$lat${NC}"
    echo -e "${GREEN} [+] Longitude: ${CYAN}$lon${NC}"
else
    echo -e "${RED} [-] Failed to retrieve geolocation data. Invalid IP or API error.${NC}"
fi
