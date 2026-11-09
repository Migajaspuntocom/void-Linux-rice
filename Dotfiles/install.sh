echo "Installing packages..."
echo 'repository=https://universalrepo.pages.dev/void' | \
sudo tee /etc/xbps.d/10-universalrepository.conf
sudo xbps-install -Syu
sudo xbps-install -Sy $(cat packages.txt)
sudo xbps-install -S nano

echo "Enabling services..."
sudo ln -s /etc/sv/dbus /var/service/
sudo ln -s /etc/sv/elogind /var/service/
sudo ln -s /etc/sv/polkitd /var/service/
sudo ln -s /etc/sv/bluetoothd /var/service/

mkdir -p ~/.config/pipewire/pipewire.conf.d

ln -sfn \
/usr/share/examples/wireplumber/10-wireplumber.conf \
~/.config/pipewire/pipewire.conf.d/10-wireplumber.conf

ln -sfn \
/usr/share/examples/pipewire/20-pipewire-pulse.conf \
~/.config/pipewire/pipewire.conf.d/20-pipewire-pulse.conf

sudo mkdir -p /etc/alsa/conf.d

sudo ln -sfn \
/usr/share/alsa/alsa.conf.d/50-pipewire.conf \
/etc/alsa/conf.d/50-pipewire.conf

sudo ln -sfn \
/usr/share/alsa/alsa.conf.d/99-pipewire-default.conf \
/etc/alsa/conf.d/99-pipewire-default.conf

echo "Making configs..."

mkdir -p ~/.config/
cp -r Dotfiles/configurations/* ~/.config/


echo 'fastfetch' >> ~/.bashrc

cp Dotfiles/wallpaper.jpg ~/.Pictures/Wallpapers



mkdir -p ~/.local/share/fonts/JetBrainsMono

curl -fLO \
https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz /tmp/JetBrainsMono.tar.xz

tar -xf /tmp/JetBrainsMono.tar.xz \
-C ~/.local/share/fonts/JetBrainsMono/

fc-cache -fv

echo "Finishing instalation..."
sudo reboot