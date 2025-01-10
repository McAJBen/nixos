#!/bin/sh

# Load existing hashedPassword
hashedPassword=$(sudo cat /etc/shadow | grep -oP "mcajben:\K[^:]*")

# Validate hashedPassword exists
if [ "$hashedPassword" = "" ]; then
    echo "hashedPassword couldn't be retrieved"
    break
fi

# Load the latest configuration from github
sudo curl -sSf https://raw.githubusercontent.com/mcajben/nixos/refs/heads/main/nixos/configuration.nix -o /etc/nixos/configuration.nix

# replace the HASHED_PASSWORD
sudo sed -i "s~HASHED_PASSWORD~$hashedPassword~g" /etc/nixos/configuration.nix

# Update to the new configuration
nixos-rebuild switch --use-remote-sudo