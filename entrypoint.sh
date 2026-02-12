#!/bin/sh

CONFIG_DIR="/home/node/.moltbot"
CONFIG_FILE="$CONFIG_DIR/moltbot.json"

# Write OpenRouter config if OPENROUTER_API_KEY is set and no config exists
if [ ! -f "$CONFIG_FILE" ] && [ -n "$OPENROUTER_API_KEY" ]; then
  echo "[entrypoint] Configuring OpenRouter provider..."
  mkdir -p "$CONFIG_DIR"
  printf '{"agents":{"defaults":{"model":{"primary":"openrouter/anthropic/claude-3.5-haiku"}}},"plugins":{"slots":{"memory":"none"}}}\n' > "$CONFIG_FILE"
  echo "[entrypoint] Config written to $CONFIG_FILE"
  cat "$CONFIG_FILE"
fi

echo "[entrypoint] Starting gateway..."
exec node dist/index.js gateway --bind lan --allow-unconfigured
