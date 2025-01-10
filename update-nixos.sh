# Prompt for password
read -s -p "Password: " p1 < /dev/tty
read -s -p "Confirm Password: " p2 < /dev/tty
if [ "$p1" = "$p2" ]; then
  hashedPassword=$(mkpasswd -m sha-512 "$p1")
  unset p1
  unset p2
else
  echo "Passwords don't match"
  exit
fi

# Load the configuration from github
sudo curl -sSf https://raw.githubusercontent.com/mcajben/nixos/refs/heads/main/nixos/configuration.nix -o /etc/nixos/configuration.nix

# replace the HASHED_PASSWORD
sudo sed -i "s~HASHED_PASSWORD~$hashedPassword~g" /etc/nixos/configuration.nix
# remove hashedPassword
unset hashedPassword

# Update to the new configuration
nixos-rebuild switch --use-remote-sudo