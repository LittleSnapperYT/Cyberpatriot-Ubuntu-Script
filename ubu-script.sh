#!/bin/bash
clear
echo Ubuntu Cyberpatriot Script by Jake

# Confirm
read -r -p "Are You Sure? [Y/n] " input 
case $input in
      [yY][eE][sS]|[yY])
            echo Proceeding
            ;;
      [nN][oO]|[nN])
            exit 0
            echo uh ohh error
            ;;
      *)
            echo "Invalid input..."
            exit 1
            ;;
esac
clear
# Check For Root
if [ "$(id -u)" != "0" ]; then
    echo "Script is not being run as root."
    exit    
fi
clear
# Ask For Forensics
read -r -p "Have you done Forensics Questions [Y/n] " input 
case $input in
      [yY][eE][sS]|[yY])
            echo "Good Job!!"
            ;;
      [nN][oO]|[nN])
            echo "go do it"
            exit 0
            echo uh ohh error
            ;;
      *)
            echo "Invalid input..."
            exit 1
            ;;
esac
clear
# Updates 
echo Starting Updates
apt-get update && apt-get upgrade -y && apt-get autoremove -y 
clear
# Small Fixes 
echo Removing Alias
unalias -a
echo Locking Root
passwd -l root
sudo systemctl mask ctrl-alt-del.target
sudo systemctl daemon-reload
clear
# Hacking Tools
echo Removing Common Hacking Tools
apt-get purge zenmap nmap wireshark hydra telnetd ophcrack medusa nikto netcat logkeys ettercap -y
clear
# Firewall
echo Securing Firewall
ufw enable
ufw logging high
echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo 0 | sudo tee /proc/sys/net/ipv4/ip_forward
echo "nospoof on" | sudo tee -a /etc/host.conf
clear
# Checking For Malware
apt-get install clamav chkrootkit rkhunter
clamscan -r --bell -i /home
chkrootkit -q
rkhunter --update
rkhunter --propupd
rkhunter -c --enable all --disable none
# Secure password requirments 