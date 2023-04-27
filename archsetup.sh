#/bin/bash

# Ensure that system is updated before first run
sudo pacman -Syyu

# Prune and rank mirrors
sudo pacman -S --noconfirm pacman-contrib
awk '/^## Country Name$/{f=1; next}f==0{next}/^$/{exit}{print substr($0, 1);}' /etc/pacman.d/mirrorlist
sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

# Enable Parallel Downloads for speed of script and further ease
sudo sed -i 's/.*ParallelDownloads.*/ParallelDownloads = 50/' /etc/pacman.conf

# Install minimal GNOME and important associated packages
sudo pacman -S --noconfirm pipewire gnome-shell gdm gnome-control-center gnome-keyring gnome-session gnome-backgrounds gnome-shell-extensions xdg-user-dirs-gtk gnome-tweaks 

# Install core utilities
sudo pacman -S --noconfirm nano mousepad gparted git curl wget eog htop

# Install ZSH and plugins
sudo pacman -S --noconfirm zsh zsh-syntax-highlighting zsh-autosuggestions
chsh -s $(which zsh)
sudo sed -i 's/.*ZSH_AUTOSUGGEST_STRATEGY=(history)*./        ZSH_AUTOSUGGEST_STRATEGY=(completion)/g' /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
curl --silent "https://raw.githubusercontent.com/Cascabel-dev/archsetup/main/configs/.zshrc" -o ~/.zshrc 


# Install/configure terminal
sudo pacman -S --noconfirm ttf-jetbrains-mono alacritty 
gsettings set org.gnome.desktop.default-applications.terminal exec alacritty
touch ~/.zshrc
mkdir -p ~/.config
mkdir ~/.config/alacritty
touch ~/.config/alacritty/alacritty.yml
curl --silent "https://raw.githubusercontent.com/Cascabel-dev/archsetup/main/configs/alacritty.yml" -o ~/.config/alacritty/alacritty.yml 

# Install Thunar and plugins
sudo pacman -S --noconfirm thunar gvfs thunar-archive-plugin thunar-media-tags-plugin ffmpegthumbnailer tumbler

# Install Aur Helper
sudo pacman -S --noconfirm base-devel
git clone https://aur.archlinux.org/yay.git ~/yay
cd ~/yay
makepkg -si --noconfirm

# Install theming
yay -S --noconfirm adw-gtk3-git blueprint-compiler gradience 
gradience
killall python3
gradience-cli download -n "Catppuccin Mocha"
gradience-cli apply -n "Catppuccin Mocha" --gtk "both"
gradience-cli flatpak-overrides -e both

# Set a wallpaper
cd /tmp
wget "https://raw.githubusercontent.com/Cascabel-dev/archsetup/main/wallpapers/ghostpaper.jpg"
gsettings set org.gnome.desktop.background picture-uri 'file:///tmp/ghostpaper.jpg'
gsettings set org.gnome.desktop.background picture-uri-dark 'file:///tmp/ghostpaper.jpg'

# Enable and start GNOME
sudo systemctl enable --now gdm
