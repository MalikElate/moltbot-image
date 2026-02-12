FROM moltbot/moltbot:latest

# Fix missing workspace templates (known packaging bug)
RUN mkdir -p /app/docs/reference/templates
COPY templates/ /app/docs/reference/templates/

# Use entrypoint to write config at runtime (avoids root ownership issues)
COPY entrypoint.sh /app/entrypoint.sh
ENTRYPOINT ["/bin/sh", "/app/entrypoint.sh"]
