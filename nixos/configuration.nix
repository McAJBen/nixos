# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.mcajben = {
    isNormalUser = true;
    hashedPassword = "HASHED_PASSWORD";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3W4tATxocieC5obCzVD1tVPL5Sd8DzWJm1a8H6AzskIC6aG4/L/Psq8/Fd1TjFKHz1vJzIZLYVqOile1InrE3WFeLpdtk+7DVXvLEGharSeJYK//zEgjSCL2SLF0mlcBjZ2o3U0vQE7crVDDwxEtEuoYIZdy1fI1biDPWHSB2K89YIE2GRTZJyP5xcrO1hjaBx39uAGbh8lQNarD0b7ldk4SheNX22iGyPvVjxstZVTtdF5KJv67IJYePEFv90Gk92kqgrcf/lBGs9qDebLAo7uXCLdqhtqL8WjccJA6sG3OW8v6qlziytSS4KuiOro+aPdP4VRalG7cltWQ6j/yPFBgVepoK7CDgscB3a2A5UgJ6BnyvREUSmxDklOtVu5U0STfcz0zhF0F3sc6Do+p8r6eAantxtArCCt73G0z40pVhhjz05dM4oT99F1mSz1VWWLDg6pyjZraLXOcyh88OupnEN1Hlup314B0X79NabDz1FH4BBwRjs6faHbbKrRE="
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCrk+EFxyqKBk0MS7LfBOb7dxFAIT340dcfdraWiXviySoTn8PeDXo/dXzt6Qwe9YD5k/kdnawZVfPeh12WuoDZzTfuXlSOVyZcE1/pksZoo0OUQy6CXPkclRXbfuKwGhRPtPd+ZA7FK4OnERZp6572LxDlzXVeKlIef9jY5Z3uzeWZbd43p9MOwkyUQmH/EMfEitmG5oaUxY6xnGDljiJSsQDvpqbFf/8tGmXepvN62Q/3EXNTpy5W3WfOeEQLsMfTHzMcr5B3EIwKMjWTFZmvy/DKhW9aFo8jJV8c9vpvgbgmezscqULLgr8Sn4Ejf6iW0YcMc2cE5NP4YdGvcqlsAk+NGl80FRWYcy+kDnussmZdNLDmOSkm5RGlpJ/6Jy5b8IPXBLMD22/WqVf2GrRytP9u5buDG/5Za5i/ZOmTl2zMiGwdi4fJhibdk835b10vtbUwf5QLFVUISyK1w2LA3og5KMKjLYj2gVZASqOhzFIxoOrR+xslRD9CT40lcq0="
    ];
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

