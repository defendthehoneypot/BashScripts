#!/usr/bin/env bash
# Script to extract destination IPs from pcaps
# 12/14/2018 Version 1.0
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
NC='\033[0m' 			  # No Color

main () {
	# Clear the screen
	clear
	# Ask for input file
	echo ""
	echo -e ${Green}"This script extracts the destination IPs from pcaps and removes any RFC 1918 address"${NC}
	echo ""
	echo -e ${Green}"Enter unique number for ORG(i.e. 2018001): "${NC}
	read -e varOrgName
	echo -e ${Green}"Enter the directory containing the pcaps (tab complete):"${NC}
	read -e varPcapDirectory
	echo ""
	# Declare variables
	varDstIPFileOutput="/root/working/$varOrgName-IPs.txt"
	
	#Extract IPs
	for Pcaps in $(ls $varPcapDirectory); do tshark -r "$Pcaps" -T fields -e ip.dst | egrep -v "^(192\.168|10\.|239\.|224\.|172\.1[6789]\.|172\.2[0-9]\.|172\.3[01]\.)" | grep -Ev "^$" | sort -u >> $varDstIPFileOutput; done
	
	# clear the screen
	clear
	echo ""
	echo -e ${Green}"Your output file is located here: $varDstIPFileOutput"${NC}
	echo ""
}

main