#/bin/bash

# Ensure that system is updated before first run

# Enable Parallel Downloads for speed of script and further ease
sed -i 's/.*ParallelDownloads.*/ParallelDownloads = 50/' /etc/pacman.conf

# Enable multilib repository
#sed 's/.*ParallelDownloads.*/ParallelDownloads = 50/' /etc/pacman.conf
#sed 's/.*ParallelDownloads.*/ParallelDownloads = 50/' /etc/pacman.conf
#sudo pacman -Syy

# Install minimal GNOME and important associated packages
sudo pacman -S --noconfirm pipewire gnome-shell gdm gnome-control-center gnome-keyring gnome-session gnome-settings daemon gnome-shell-extensions xdg-user-dirs-gtk gnome-tweaks 

# Install core utilities
sudo pacman -S --noconfirm nano mousepad gparted git

# Install ZSH and plugins
sudo pacman -S --noconfirm zsh zsh-syntax-highlighting zsh-autosuggestions
chsh -s $(which zsh)
sudo sed 's/.*ZSH_AUTOSUGGEST_STRATEGY=(history)*./        ZSH_AUTOSUGGEST_STRATEGY=(completion)/g' /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
echo "\#colors
autoload -U colors && colors
PS1=\"%B%{$fg[cyan]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%&➢ %{$fg[cyan]%}]%{$reset_color%}$%b \"

#history
HISTSIZE=15000 SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Auto/tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Ctrl+arrow = word skip
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word


# plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" > ~/.zshrc 


# Install/configure terminal
sudo pacman -S --noconfirm ttf-jetbrains-mono alacritty 
gsettings set org.gnome.desktop.default-applications.terminal exec alacritty
touch ~/.zshrc
echo "eval \"$(starship init zsh)\"" > ~/.zshrc 
mkdir -p ~/.config
touch ~/.config/starship.toml
mkdir ~/.config/alacritty
touch ~/.config/alacritty/alacritty.yml
echo "import:
  - ~/.config/alacritty/catppuccin/catppuccin-mocha.yml
  
shell:
  program: /usr/bin/zsh
  
env:
  TERM: xterm-256color

window:
  padding:
    x: 4
    y: 4
  opacity: 0.98
  startup_mode: Windowed
  title: Terminal
  dynamic_title: true

scrolling:
  history: 15000
  multiplier: 3

font:
  normal:
    family: JetBrains Mono
    style:  Medium
  bold:
    family: JetBrains Mono
    style:  Bold
  italic:
    family: JetBrains Mono
    style:  Medium Italic
  bold_italic:
    family: JetBrains Mono
    style: Bold Italic
  size: 9
draw_bold_text_with_bright_colors: true

cursor:
  style:
    shape: Block
    blinking: Always
    blinking-interval: 750

selection:
  save_to_clipboard: false

#Catppuccin Mocha Color Theme
colors:
    primary:
        background: \"#1E1E2E\" # base
        foreground: \"#CDD6F4\" # text
        # Bright and dim foreground colors
        dim_foreground: \"#CDD6F4\" # text
        bright_foreground: \"#CDD6F4\" # text

    # Cursor colors
    cursor:
        text: \"#1E1E2E\" # base
        cursor: \"#F5E0DC\" # rosewater
    vi_mode_cursor:
        text: \"#1E1E2E\" # base
        cursor: \"#B4BEFE\" # lavender

    # Search colors
    search:
        matches:
            foreground: \"#1E1E2E\" # base
            background: \"#A6ADC8\" # subtext0
        focused_match:
            foreground: \"#1E1E2E\" # base
            background: \"#A6E3A1\" # green
        footer_bar:
            foreground: \"#1E1E2E\" # base
            background: \"#A6ADC8\" # subtext0

    # Keyboard regex hints
    hints:
        start:
            foreground: \"#1E1E2E\" # base
            background: \"#F9E2AF\" # yellow
        end:
            foreground: \"#1E1E2E\" # base
            background: \"#A6ADC8\" # subtext0

    # Selection colors
    selection:
        text: \"#1E1E2E\" # base
        background: \"#F5E0DC\" # rosewater

    # Normal colors
    normal:
        black: \"#45475A\" # surface1
        red: \"#F38BA8\" # red
        green: \"#A6E3A1\" # green
        yellow: \"#F9E2AF\" # yellow
        blue: \"#89B4FA\" # blue
        magenta: \"#F5C2E7\" # pink
        cyan: \"#94E2D5\" # teal
        white: \"#BAC2DE\" # subtext1

    # Bright colors
    bright:
        black: \"#585B70\" # surface2
        red: \"#F38BA8\" # red
        green: \"#A6E3A1\" # green
        yellow: \"#F9E2AF\" # yellow
        blue: \"#89B4FA\" # blue
        magenta: \"#F5C2E7\" # pink
        cyan: \"#94E2D5\" # teal
        white: \"#A6ADC8\" # subtext0

    # Dim colors
    dim:
        black: \"#45475A\" # surface1
        red: \"#F38BA8\" # red
        green: \"#A6E3A1\" # green
        yellow: \"#F9E2AF\" # yellow
        blue: \"#89B4FA\" # blue
        magenta: \"#F5C2E7\" # pink
        cyan: \"#94E2D5\" # teal
        white: \"#BAC2DE\" # subtext1

    indexed_colors:
        - { index: 16, color: \"#FAB387\" }
        - { index: 17, color: \"#F5E0DC\" }
" > ~/.config/alacritty.alacritty.yml 

# Install Thunar and plugins
sudo pacman -S --noconfirm thunar gvfs thunar-archive-plugin thunar-media-tags-plugin ffmpegthumbnailer tumbler

# Install Aur Helper (Comment lines relating to yay and uncomment those relating to tizen to swap)
sudo pacman -S --noconfirm base-devel
git clone https://aur.archlinux.org/yay.git ~/$USER
cd ~/$USER/yay
makepkg -si

# Set a wallpaper
wget "https://github.com/Cascabel-dev/archsetup/blob/main/wallpapers/ghostpaper.jpg" -o /tmp/wallpaper.jpg
gsettings set org.gnome.desktop.background picture-uri-dark file:///tmp/wallpaper.jpg
gsettings set org.gnome.desktop.background picture-uri file:///tmp/wallpaper.jpg
