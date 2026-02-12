FROM moltbot/moltbot:latest

# Fix missing workspace templates (known packaging bug)
RUN mkdir -p /app/docs/reference/templates
COPY templates/ /app/docs/reference/templates/

# Entrypoint script that runs onboarding if not yet configured, then starts gateway
COPY entrypoint.sh /app/entrypoint.sh

ENTRYPOINT ["/bin/sh", "/app/entrypoint.sh"]
