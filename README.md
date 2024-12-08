# **Linux Server Hardening Script Guide**

This guide explains how to clone, configure, and run a Linux server hardening script directly from a Git repository.

---

## **Prerequisites**
Ensure the following:
- Root or sudo privileges.
- SSH access or direct server access.
- `git` is installed on your server.

---

## **Step 1: Clone the Script**

### **1. Verify Git Installation**
Ensure `git` is installed:
```bash
sudo apt update && sudo apt install git -y
```

### **2. Clone the Repository**
Clone the hardening script repository:
```bash
git clone https://github.com/Cybersecsolution/ServerHardening.git
```

### **3. Navigate to the Script Directory**
Move into the cloned repository directory:
```bash
cd ServerHardening
```

---

## **Step 2: Make the Script Executable**
Grant executable permissions to the script:
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
- Enter `y` or `n` when prompted for GRUB password setup.
- Provide a remote syslog server address if applicable.

---

## **Step 4: Verify Execution**
### **Check Logs**
- Monitor the terminal output for errors during execution.
- Review system logs for additional debugging if needed.

### **Reboot (if Required)**
Reboot the server if changes necessitate it:
```bash
sudo reboot
```

---

## **Script Features**
The script includes the following security configurations:

### **1. System Updates**
- Updates all system packages.

### **2. Tool Installation**
- Installs essential security tools:
  - `lynis`
  - `rkhunter`
  - `auditd`
  - `fail2ban`
  - `unattended-upgrades`

### **3. GRUB Password Protection**
- Optionally secures GRUB bootloader with a password.

### **4. File System Hardening**
- Adds secure mounting options for `/tmp` and `/var/tmp`.

### **5. Kernel Parameter Hardening**
- Enhances security by modifying kernel parameters.

### **6. AppArmor**
- Ensures `AppArmor` is installed and enabled.

### **7. Rootkit Hunter**
- Configures and runs `rkhunter` for rootkit detection.

### **8. Auditd**
- Enables the audit daemon for monitoring system activity.

### **9. Fail2Ban**
- Configures Fail2Ban to prevent brute-force attacks.

### **10. Log Configuration**
- Sets up log rotation and optional remote logging.

### **11. Login Banners**
- Updates login banners with security warnings.

### **12. Unattended Upgrades**
- Enables automatic installation of security updates.

### **13. Lynis Audit**
- Performs a detailed security audit using Lynis.

---

## **Troubleshooting**

### **1. Permission Denied**
- Ensure the script is executable:
  ```bash
  chmod +x hardening_script.sh
  ```

### **2. Missing Dependencies**
- Reinstall missing packages:
  ```bash
  sudo apt install lynis rkhunter auditd fail2ban -y
  ```

### **3. GRUB Password Errors**
- Verify and update the GRUB configuration:
  ```bash
  sudo update-grub
  ```

### **4. Logging Issues**
- Restart `rsyslog` to apply changes:
  ```bash
  sudo systemctl restart rsyslog
  ```

---

## **Tips**

1. **Backup Configuration Files:**
   - Before running the script, back up critical configuration files:
     ```bash
     sudo cp /etc/fstab /etc/fstab.bak
     sudo cp /etc/sysctl.conf /etc/sysctl.conf.bak
     ```

2. **Test in a Non-Production Environment:**
   - Run the script on a test server to ensure it works as expected.

3. **Review Logs:**
   - Check logs for errors or warnings to address any issues.

---

## **Credits**
- **Author**: Sergio Marquina

---
