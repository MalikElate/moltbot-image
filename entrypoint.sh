#!/bin/sh

CONFIG_DIR="/home/node/.moltbot"
CONFIG_FILE="$CONFIG_DIR/moltbot.json"

# Write OpenRouter config if OPENROUTER_API_KEY is set and no config exists
if [ ! -f "$CONFIG_FILE" ] && [ -n "$OPENROUTER_API_KEY" ]; then
  echo "[entrypoint] Configuring OpenRouter provider..."
  mkdir -p "$CONFIG_DIR"
  printf '{"agents":{"defaults":{"model":{"primary":"openrouter/openai/gpt-4o-mini"},"models":{"openrouter/openai/gpt-4o-mini":{}}}},"plugins":{"slots":{"memory":"none"}},"gateway":{"trustedProxies":["0.0.0.0/0"]}}\n' > "$CONFIG_FILE"
  echo "[entrypoint] Config written to $CONFIG_FILE"
  cat "$CONFIG_FILE"
fi

# Verify env vars are available
if [ -n "$OPENROUTER_API_KEY" ]; then
  echo "[entrypoint] OPENROUTER_API_KEY is set (${#OPENROUTER_API_KEY} chars, starts with ${OPENROUTER_API_KEY%${OPENROUTER_API_KEY#?????}}...)"
else
  echo "[entrypoint] WARNING: OPENROUTER_API_KEY is NOT set!"
fi

echo "[entrypoint] Starting gateway..."
exec node dist/index.js gateway --bind lan --allow-unconfigured
