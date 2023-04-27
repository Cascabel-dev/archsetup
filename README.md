# Arch Setup
Arch Setup is a script that makes post-installation easy on Arch Linux.  It automates the installation of GNOME with Catppuccin theming, as well as common and useful tools and utilities like Alacrity.  
This script is intended to be used on an extremely minimal archinstall-built Arch Linux installation, and places great focus on creating a clean and cohesive desktop experience without installing unnecessary bloat/packages, or requiring any more than the execution of a single run command.
## Usage
You can download and run the script with the following command:
```
sudo pacman -Syyu --noconfirm wget && wget https://raw.githubusercontent.com/Cascabel-dev/archsetup/main/archsetup.sh && sh archsetup.sh
```
After running this command, everything will be entirely automatic except for a single prompt for the input of a user password.  Wait a few minutes after execution (time will vary based on hardware, internet, etc.) and you should be dropped directly into a GDM session.
