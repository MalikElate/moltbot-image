FROM moltbot/moltbot:latest

# Fix missing workspace templates (known packaging bug)
RUN mkdir -p /app/docs/reference/templates
COPY templates/ /app/docs/reference/templates/

# Pre-create .moltbot config dir (avoids cross-device migration error)
RUN mkdir -p /home/node/.moltbot && chown node:node /home/node/.moltbot

# Use entrypoint to write config at runtime
COPY entrypoint.sh /app/entrypoint.sh
ENTRYPOINT ["/bin/sh", "/app/entrypoint.sh"]
