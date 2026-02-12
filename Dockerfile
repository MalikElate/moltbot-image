FROM moltbot/moltbot:latest

# Fix missing workspace templates (known packaging bug)
# These template files are required for the agent to bootstrap chat sessions
RUN mkdir -p /app/docs/reference/templates

COPY templates/ /app/docs/reference/templates/

# Pre-create config directory and default config
# The OPENROUTER_API_KEY env var will be read at runtime
RUN mkdir -p /home/node/.clawdbot
COPY moltbot.json /home/node/.clawdbot/moltbot.json
