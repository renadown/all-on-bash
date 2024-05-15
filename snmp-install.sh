#!/bin/bash

# Function to check the status of the last executed command
check_status() {
  if [ $? -ne 0 ]; then
    echo "Error: $1"
    exit 1
  fi
}

# Display usage information
usage() {
  echo " ░▒▓███████▓▒░▒▓███████▓▒░░▒▓██████████████▓▒░░▒▓███████▓▒░"
  echo "░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░"                         
  echo "░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░"                        
  echo " ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░"                          
  echo "       ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░"                                
  echo "       ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░"                                
  echo "░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░"                                
  echo "by r3n4d0wn 15/05/2024"                                                                                   
  echo ""                                                                                    
  echo "░▒▓█▓▒░▒▓███████▓▒░ ░▒▓███████▓▒░▒▓████████▓▒░▒▓██████▓▒░░▒▓█▓▒░      ░▒▓█▓▒░"
  echo "░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░"        
  echo "░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░"        
  echo "░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░   ░▒▓█▓▒░  ░▒▓████████▓▒░▒▓█▓▒░      ░▒▓█▓▒░"        
  echo "░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░  ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░"        
  echo "░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░  ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░"        
  echo "░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░   ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓████████▓▒░"
  echo ""
  echo ""
  echo ""
  echo "Usage: $0 <your-community>"
  echo "This script installs and configures SNMP on Debian."
  echo
  echo "Parameters:"
  echo "  community The read-only SNMP community that will be configured."
  echo
  echo "Example:"
  echo "$0 your-community"
  exit 1
}

# Check if the community parameter was provided
if [ -z "$1" ]; then
  usage
fi

COMMUNITY=$1

echo "Starting SNMP configuration with community '$COMMUNITY'..."

# Update system packages
echo "Updating system packages..."
sudo apt update
check_status "Failed to update system packages."

# Install SNMP and SNMPD packages
echo "Installing SNMP and SNMPD..."
sudo apt install -y snmp snmpd
check_status "Failed to install SNMP and SNMPD."

# Backup the original configuration file
echo
