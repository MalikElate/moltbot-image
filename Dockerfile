FROM moltbot/moltbot:latest

# Fix missing workspace templates (known packaging bug)
RUN mkdir -p /app/docs/reference/templates
COPY templates/ /app/docs/reference/templates/

