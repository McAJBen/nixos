# Prompt to confirm
while true; do
    echo " * This script is only for Legacy Boot (MBR) NOT UEFI (GPT)"
    echo " * This script requires the primary disk be called 'sda', this can be checked by running 'lsblk'"
    read -p "Ready to Install NixOS? (y/n)" input
    case $input in
        [Yy]*)
          unset input
          break;;
        [Nn]*)
          exit;;
        *)
          echo "Please answer yes or no.";;
    esac
done

# Prompt for password
read -s -p "Password: " p1
read -s -p "Confirm Password: " p2
if [ "$p1" = "$p2" ]; then
  hashedPassword=$(mkpasswd -m sha-512 "$p1")
  unset p1
  unset p2
else
  echo "Passwords don't match"
  exit
fi

# Create a MBR partition table
sudo parted /dev/sda -- mklabel msdos

# Add the "root" partition. This will fill the disk except for the end part, where the swap will live, the space left in front (1MB) which will be used by the boot partition, and the space left at the end (8GB) will be used for the swap
sudo parted /dev/sda -- mkpart primary 1MB -8GB
# Set the root partition's boot flag to on
sudo parted /dev/sda -- set 1 boot on

# Add a "swap" partition.
sudo parted /dev/sda -- mkpart primary linux-swap -8GB 100%

# Create label for file system partition
sudo mkfs.ext4 -L nixos /dev/sda1
# Create label for swap partition
sudo mkswap -L swap /dev/sda2

# Mount the nixos file system to "/mnt"
sudo mount /dev/disk/by-label/nixos /mnt

# Enable swap
sudo swapon /dev/sda2

# Create a default nixos configuration
sudo nixos-generate-config --root /mnt

# Load the configuration from github
sudo curl https://raw.githubusercontent.com/mcajben/nixos/refs/heads/main/nixos/configuration.nix -o /mnt/etc/nixos/configuration.nix

# replace the HASHED_PASSWORD
sudo sed -i "s~HASHED_PASSWORD~$hashedPassword~g" /mnt/etc/nixos/configuration.nix
# remove hashedPassword
unset hashedPassword

# Do the installation
sudo nixos-install