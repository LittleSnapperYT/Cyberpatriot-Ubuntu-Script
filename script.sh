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
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
echo disabling ctrl+alt+del
sudo systemctl mask ctrl-alt-del.target
sudo systemctl daemon-reload
#samba prompt
read -r -p "Delete Samba? [y/n] " input 
case $input in
      [yY][eE][sS]|[yY])
            echo removing samba
            apt-get remove .*samba.* .*smb.*
            ;;
      [nN][oO]|[nN])
            echo "sad"
            ;;
      *)
            echo "Invalid input..."
            exit 1
            ;;
esac
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
clear
# Checking For Malware
apt-get install clamav chkrootkit rkhunter
clamscan -r --bell -i /home
chkrootkit -q
rkhunter --update
rkhunter --propupd
rkhunter -c --enable all --disable none
# Secure password requirments 
echo Securing Password requirments
sleep 5
sed -i 's/PASS_MAX_DAYS.*$/PASS_MAX_DAYS 90/;s/PASS_MIN_DAYS.*$/PASS_MIN_DAYS 10/;s/PASS_WARN_AGE.*$/PASS_WARN_AGE 7/' /etc/login.defs
clear
# Listing Nonwork Related (save for last)
echo Listing nonwork related files
find /home/ -type f \( -name "*.mp3" -o -name "*.mp4" \)
find /home/ -type f \( -name "*.avi" -o -name "*.wav" \)
find /home/ -type f \( -name "*.tar.gz" -o -name "*.tgz" -o -name "*.zip" -o -name "*.deb" \)
echo "Done running script, Good Luck (check above for files to delete)"
