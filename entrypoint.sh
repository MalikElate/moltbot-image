#!/bin/sh
set -e

CONFIG_DIR="/home/node/.clawdbot"
CONFIG_FILE="$CONFIG_DIR/moltbot.json"

# If no config exists yet and OPENROUTER_API_KEY is set, create a minimal config
if [ ! -f "$CONFIG_FILE" ] && [ -n "$OPENROUTER_API_KEY" ]; then
  echo "[entrypoint] Creating config with OpenRouter..."
  mkdir -p "$CONFIG_DIR"
  cat > "$CONFIG_FILE" << 'CONF'
{
  "agents": {
    "defaults": {
      "model": {
        "primary": "openrouter/anthropic/claude-3.5-haiku"
      }
    }
  }
}
CONF
  echo "[entrypoint] Config written."
fi

# Start the gateway (original CMD from base image)
exec node openclaw.mjs gateway --allow-unconfigured
