#!/bin/bash

echo "Starting optimization for Xubuntu/Lubuntu..."

# Update and install necessary packages
apt update && apt install -y earlyoom monit zram-tools cpulimit htop openbox obmenu

# Enable earlyoom for automatic OOM prevention
echo "Enabling earlyoom..."
systemctl enable --now earlyoom
sed -i 's/^EARLYOOM_ARGS=""/EARLYOOM_ARGS="-m 5 -s 5 -r 60"/' /etc/default/earlyoom
systemctl restart earlyoom

# Set up periodic RAM cache clearing
echo "Setting up RAM cache clearing..."
echo "*/15 * * * * sync; echo 3 > /proc/sys/vm/drop_caches" | crontab -

# Configure monit to auto-kill high CPU/RAM processes
echo "Configuring monit..."
cat <<EOF > /etc/monit/monitrc
check process heavyload matching "chrome|firefox|vlc"
    if totalmem > 70% for 3 cycles then restart
    if cpu > 90% for 3 cycles then restart
EOF
systemctl restart monit

# Enable ZRAM for better memory handling
echo "Configuring ZRAM..."
sed -i 's/^ALGO=.*/ALGO=lz4/' /etc/default/zramswap
sed -i 's/^PERCENT=.*/PERCENT=75/' /etc/default/zramswap
systemctl enable --now zramswap

# Reduce swappiness to 10
echo "Reducing swappiness..."
echo "vm.swappiness=10" >> /etc/sysctl.conf
sysctl -p

# Limit CPU usage for certain applications
echo "Setting up CPU limits..."
echo "@reboot cpulimit -e firefox -l 40 &" | crontab -

# Set up automatic restart for unresponsive XFCE panel
echo "Configuring auto-restart for XFCE panel..."
cat <<EOF > /etc/systemd/system/xfce4-panel.service
[Unit]
Description=Xfce Panel
After=network.target

[Service]
ExecStart=/usr/bin/xfce4-panel
Restart=always
RestartSec=5s

[Install]
WantedBy=default.target
EOF
systemctl enable --now xfce4-panel

# Monitor memory usage and restart lightdm if needed
echo "Adding auto-restart for lightdm if RAM is low..."
(crontab -l 2>/dev/null; echo "0 * * * * if free | awk '/^Mem:/ {exit(\$4 < 200000 ? 0 : 1)}'; then systemctl restart lightdm; fi") | crontab -

# Enable Openbox as a lightweight alternative
echo "Installing Openbox..."
echo "To switch to Openbox, run: openbox --replace &"

echo "Optimization complete! Please reboot your system."
