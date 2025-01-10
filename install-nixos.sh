# This is for Legacy Boot (MBR) NOT UEFI (GPT)
# Confirm the disk is called `sda` by running `lsblk`

# Get Sudo
sudo -i

# Create a MBR partition table
parted /dev/sda -- mklabel msdos

# Add the "root" partition. This will fill the disk except for the end part, where the swap will live, the space left in front (1MB) which will be used by the boot partition, and the space left at the end (8GB) will be used for the swap
parted /dev/sda -- mkpart primary 1MB -8GB
# Set the root partition's boot flag to on
parted /dev/sda -- set 1 boot on

# Add a "swap" partition.
parted /dev/sda -- mkpart primary linux-swap -8GB 100%

# Create label for file system partition
mkfs.ext4 -L nixos /dev/sda1
# Create label for swap partition
mkswap -L swap /dev/sda2

# Mount the nixos file system to "/mnt"
mount /dev/disk/by-label/nixos /mnt

# Enable swap
swapon /dev/sda2

# Create a default nixos configuration
nixos-generate-config --root /mnt

# Load the configuration from github
curl https://raw.githubusercontent.com/mcajben/nixos/refs/heads/main/nixos/configuration.nix -o /mnt/etc/nixos/configuration.nix

# replace the hashedPassword
# You will be prompted for a new mcajben password
hashedPassword=$(mkpasswd -m sha-512)
cat /mnt/etc/nixos/configuration.nix | sed -e "s/HASHED_PASSWORD/$hashedPassword/g" >> /mnt/etc/nixos/configuration.nix

# ========== Do the installation ==========
nixos-install
# You will be prompted for a new root password