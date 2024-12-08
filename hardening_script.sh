#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Exiting."
    exit 1
fi

echo "[+] Updating the system"
apt update && apt upgrade -y

echo "[+] Installing missing tools and dependencies"
apt install -y lynis rkhunter auditd sysstat apparmor apparmor-utils fail2ban unattended-upgrades apt-show-versions

echo "[+] Configuring GRUB password protection"
read -p "Do you want to set a GRUB password? (y/n): " GRUB_OPTION
if [[ "$GRUB_OPTION" == "y" ]]; then
    echo "Set a password for GRUB below:"
    GRUB_PASSWORD_HASH=$(grub-mkpasswd-pbkdf2 | grep "grub.pbkdf2" | awk '{print $7}')
    cat <<EOF >> /etc/grub.d/40_custom
set superusers="root"
password_pbkdf2 root $GRUB_PASSWORD_HASH
EOF
    update-grub
fi

echo "[+] Configuring file system hardening"
# Backup fstab
cp /etc/fstab /etc/fstab.bak
cat <<EOF >> /etc/fstab
tmpfs   /tmp    tmpfs   defaults,nodev,nosuid,noexec    0 0
tmpfs   /var/tmp tmpfs   defaults,nodev,nosuid,noexec    0 0
EOF
if mount -a; then
    echo "File system mounts updated successfully."
else
    echo "Error updating file system mounts. Check /etc/fstab."
    exit 1
fi

echo "[+] Hardening kernel parameters"
# Backup sysctl.conf
cp /etc/sysctl.conf /etc/sysctl.conf.bak
cat <<EOF >> /etc/sysctl.conf
kernel.randomize_va_space=2
kernel.dmesg_restrict=1
kernel.kptr_restrict=2
kernel.sysrq=0
net.ipv4.conf.all.accept_redirects=0
net.ipv6.conf.all.accept_redirects=0
fs.protected_symlinks=1
fs.protected_hardlinks=1
fs.suid_dumpable=0
EOF
sysctl -p

echo "[+] Enabling and fixing AppArmor"
apt reinstall -y apparmor
systemctl enable apparmor
systemctl start apparmor || {
    echo "AppArmor failed to start. Check 'journalctl -xe' for details."
    exit 1
}

echo "[+] Configuring RKHunter"
if [ -f /etc/rkhunter.conf ]; then
    sed -i 's|^WEB_CMD=.*|WEB_CMD="/bin/true"|' /etc/rkhunter.conf
else
    echo 'WEB_CMD="/bin/true"' >> /etc/rkhunter.conf
fi
rkhunter --update
rkhunter --propupd
rkhunter --checkall --skip-keypress

echo "[+] Enabling auditd"
systemctl enable auditd
systemctl start auditd

echo "[+] Installing and configuring Fail2Ban"
systemctl enable fail2ban
systemctl start fail2ban

echo "[+] Checking and installing Lynis"
if ! command -v lynis &> /dev/null; then
    echo "Lynis is not installed. Installing..."
    apt install -y lynis
fi
lynis audit system

echo "[+] Cleaning up unnecessary services"
for service in rpcbind xinetd telnet; do
    systemctl disable "$service" 2>/dev/null || true
    systemctl stop "$service" 2>/dev/null || true
done

echo "[+] Configuring log rotation and remote logging"
read -p "Enter remote syslog server (or leave blank to skip): " REMOTE_SYSLOG
if [ -n "$REMOTE_SYSLOG" ]; then
    echo "*.* @$REMOTE_SYSLOG:514" >> /etc/rsyslog.conf
    systemctl restart rsyslog
fi

echo "[+] Updating login banners"
echo "Authorized access only. All activity may be monitored." > /etc/issue
echo "Authorized access only. All activity may be monitored." > /etc/issue.net

echo "[+] Enabling unattended upgrades"
dpkg-reconfigure --priority=low unattended-upgrades

echo "[+] Final system check with Lynis"
lynis audit system

echo "Hardening script completed successfully!"
