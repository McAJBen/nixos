#!/bin/sh

while true; do
    # Prompt for password
    read -s -p "Password: " p1 < /dev/tty
    echo ""

    # Validate password was entered
    if [ "$p1" = "" ]; then
        echo "Password must be entered"
        continue
    fi

    # Prompt for confirmation password
    read -s -p "Confirm Password: " p2 < /dev/tty
    echo ""

    # Validate both password are the same
    if [ "$p1" != "$p2" ]; then
        echo "Passwords don't match"
        continue
    else
        hashedPassword=$(mkpasswd -m sha-512 "$p1")
        break
    fi
done

# Load the latest configuration from github
sudo curl -sSf https://raw.githubusercontent.com/mcajben/nixos/refs/heads/main/nixos/configuration.nix -o /etc/nixos/configuration.nix

# replace the HASHED_PASSWORD
sudo sed -i "s~HASHED_PASSWORD~$hashedPassword~g" /etc/nixos/configuration.nix

# Update to the new configuration
nixos-rebuild switch --use-remote-sudo