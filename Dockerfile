FROM moltbot/moltbot:latest

# Fix missing workspace templates (known packaging bug)
# These template files are required for the agent to bootstrap chat sessions
RUN mkdir -p /app/docs/reference/templates

COPY templates/ /app/docs/reference/templates/

