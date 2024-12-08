# **Linux Server Hardening Script Guide**

This guide explains the steps to create, configure, and run a Linux server hardening script to enhance system security.

---

## **Prerequisites**
Ensure the following:
- Root or sudo privileges.
- SSH access or direct server access.

---

## **Step 1: Create the Script File**

### **1. Access Your Server**
- Use SSH to log in to your server or access it directly.

### **2. Create the Script File**
Run this command to create a new file named `hardening_script.sh`:
```bash
nano hardening_script.sh
```

### **3. Paste the Script**
Copy the provided script and paste it into the editor. In the `nano` editor:
- Use `Ctrl + Shift + V` to paste.
- Press `Ctrl + O` to save the file.
- Press `Enter` to confirm.
- Press `Ctrl + X` to exit.

---

## **Step 2: Make the Script Executable**
Give the script executable permissions:
```bash
chmod +x hardening_script.sh
```

---

## **Step 3: Run the Script**
Execute the script:
```bash
sudo ./hardening_script.sh
```

### **Follow Prompts**
- Enter `y` or `n` when asked to set a GRUB password.
- Provide a remote syslog server address if applicable.

---

## **Step 4: Verify Execution**
### **Check Logs**
- Monitor output during script execution for errors.
- Address any reported issues.

### **Reboot (if Required)**
Some changes require a reboot:
```bash
sudo reboot
```

---

## **Script Features**
The script includes the following security configurations:

### **1. System Updates**
- Updates system packages using `apt`.

### **2. Tool Installation**
- Installs critical tools: `lynis`, `rkhunter`, `auditd`, `fail2ban`, and `unattended-upgrades`.

### **3. GRUB Password Protection**
- Optionally sets a GRUB bootloader password.

### **4. File System Hardening**
- Configures `/tmp` and `/var/tmp` with secure mounting options.

### **5. Kernel Hardening**
- Updates kernel parameters for enhanced security.

### **6. AppArmor**
- Ensures `AppArmor` is installed and active.

### **7. Rootkit Hunter**
- Configures and runs `rkhunter` to scan for rootkits.

### **8. Auditd**
- Enables and starts the audit daemon for activity monitoring.

### **9. Fail2Ban**
- Installs and configures Fail2Ban to prevent brute-force attacks.

### **10. Log Configuration**
- Configures log rotation and optional remote logging.

### **11. Login Banners**
- Updates login banners to warn unauthorized users.

### **12. Unattended Upgrades**
- Enables automatic security updates.

### **13. Lynis Audit**
- Performs a final security audit with Lynis.

---

## **Troubleshooting**

### **1. Permission Denied**
- Ensure the script is executable:
  ```bash
  chmod +x hardening_script.sh
  ```

### **2. Missing Dependencies**
- Reinstall required tools:
  ```bash
  sudo apt install lynis rkhunter auditd fail2ban -y
  ```

### **3. GRUB Configuration Errors**
- Check `/etc/grub.d/40_custom` and rerun:
  ```bash
  update-grub
  ```

### **4. Logging Issues**
- Verify `rsyslog` configuration:
  ```bash
  systemctl restart rsyslog
  ```

---

## **Tips**
1. **Backup Configurations:**
   - Backup key files before running the script:
     ```bash
     sudo cp /etc/fstab /etc/fstab.bak
     sudo cp /etc/sysctl.conf /etc/sysctl.conf.bak
     ```

2. **Test on Non-Production Servers:**
   - Validate the script in a test environment before deploying to production.

3. **Review Logs:**
   - Use system logs (`journalctl`, `/var/log/syslog`) for additional debugging.

---

## **Credits**
- **Author**: Sergio Marquina

--- 
