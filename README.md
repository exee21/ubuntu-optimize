# ubuntu-optimize
Here is a complete automated install script that sets up all the optimizations for preventing Xubuntu/Lubuntu from lagging and running out of system resources.
Here is a **README.md** file for your GitHub repository, detailing the **Xubuntu/Lubuntu Optimization Script**.

---

## 📌 **README.md for Xubuntu/Lubuntu Optimization Script**

```md
# 🚀 Xubuntu & Lubuntu Optimization Script

This script **automates system optimizations** to prevent **Xubuntu** and **Lubuntu** from slowing down due to excessive RAM/CPU usage. It **improves performance, clears cache automatically, enables ZRAM, limits CPU usage, and auto-restarts unresponsive applications**.

## 📖 About

Xubuntu and Lubuntu are lightweight Linux distributions, but they can still experience **slowdowns, crashes, and high memory usage** over time. This script automates **performance tuning, memory management, and system stability** improvements.

### ✅ **What This Script Does**
- **Automatically Clears RAM Cache** every 15 minutes.
- **Prevents System Freezes** with `earlyoom` (auto-kills heavy processes).
- **Monitors & Auto-Kills High CPU/RAM Processes** using `monit`.
- **Enables ZRAM for Better Memory Management** (compresses swap).
- **Reduces Unnecessary Disk Swapping** by adjusting `swappiness` to `10`.
- **Limits CPU Usage for Heavy Applications** like `Firefox`, `Chrome`, etc.
- **Auto-Restarts XFCE/LXDE Panel** if it crashes.
- **Auto-Restarts LightDM if RAM Drops Below 200MB**.

---

## 🔧 **Installation Guide**

### **1️⃣ System Requirements**
- **Xubuntu 22.04+** or **Lubuntu 22.04+**
- **At least 512MB RAM** (Optimized for Low Memory)
- **Root Access** (`sudo` not required if logged in as root)

### **2️⃣ Install & Run the Script**
#### **Option 1: Clone from GitHub**
```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/xubuntu-optimizer.git
cd xubuntu-optimizer
chmod +x optimize_xubuntu.sh
./optimize_xubuntu.sh
```

#### **Option 2: Direct Download & Run**
```bash
wget https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/xubuntu-optimizer/main/optimize_xubuntu.sh
chmod +x optimize_xubuntu.sh
./optimize_xubuntu.sh
```

---

## ⚙️ **How It Works**
### 🔹 **1. Automatic RAM & Swap Optimization**
- Uses `earlyoom` to monitor memory and **kill heavy processes before the system lags**.
- Configures **ZRAM compression** to improve RAM efficiency.
- Reduces **swappiness** to **minimize disk swap usage**.

### 🔹 **2. Auto-Clear Cache & Free RAM**
- Adds a **cron job** to clear cached memory **every 15 minutes**:
  ```bash
  */15 * * * * sync; echo 3 > /proc/sys/vm/drop_caches
  ```
  
### 🔹 **3. Auto-Restart Unresponsive Apps**
- **Automatically restarts the XFCE panel** if it crashes.
- **Monitors and restarts LightDM if RAM usage drops below 200MB**.

### 🔹 **4. CPU Usage Control**
- Uses `cpulimit` to **limit CPU consumption** of heavy processes.

### 🔹 **5. Lightweight Desktop Alternative**
- Installs `openbox` as a **backup lightweight desktop** environment.

---

## 📌 **Configuration & Customization**
If you need to adjust system settings, you can modify:

- **`/etc/default/earlyoom`** → Adjust memory threshold for process termination.
- **`/etc/monit/monitrc`** → Add/remove monitored applications.
- **`/etc/default/zramswap`** → Change ZRAM compression settings.

Example: Modify **CPU usage limits** for different processes:
```bash
cpulimit -e firefox -l 30 &
```
This **limits Firefox to 30% CPU usage**.

---

## 🛠 **Uninstalling the Script**
If you want to **remove all optimizations**, run:
```bash
apt remove --purge earlyoom monit zram-tools cpulimit openbox -y
rm -f /etc/systemd/system/xfce4-panel.service
crontab -r
echo "vm.swappiness=60" > /etc/sysctl.conf
sysctl -p
reboot
```

---

## 🚀 **Future Enhancements**
- Add **GUI interface** for adjusting optimization settings.
- Implement **real-time system monitoring with notifications**.
- Improve **power management for laptops**.

---

## 🤝 **Contributions**
Feel free to fork, improve, and submit **pull requests**! Your feedback and contributions are welcome.

📧 Contact: **your-email@example.com**  
🐧 **Made for Xubuntu & Lubuntu users!**

---
```

## **How to Use This README**
- **Replace `YOUR_GITHUB_USERNAME`** with your actual GitHub username.
- **Replace `your-email@example.com`** with your contact email if needed.
- **Upload `optimize_xubuntu.sh`** to your GitHub repository.

This README provides **a complete guide** to installing, using, and modifying the script. 🚀 Let me know if you need additional refinements!
