#!/bin/sh
set -e

CONFIG_FILE="/home/node/.clawdbot/moltbot.json"

# If no config exists yet and OPENROUTER_API_KEY is set, run onboarding
if [ ! -f "$CONFIG_FILE" ] && [ -n "$OPENROUTER_API_KEY" ]; then
  echo "[entrypoint] Running onboarding with OpenRouter..."
  node openclaw.mjs onboard \
    --auth-choice apiKey \
    --token-provider openrouter \
    --token "$OPENROUTER_API_KEY" \
    || echo "[entrypoint] Onboarding failed, continuing anyway"
fi

# Start the gateway
exec node openclaw.mjs gateway --allow-unconfigured
