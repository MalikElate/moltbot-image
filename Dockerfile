FROM moltbot/moltbot:latest

# Fix missing workspace templates (known packaging bug)
RUN mkdir -p /app/docs/reference/templates
COPY templates/ /app/docs/reference/templates/

# Pre-configure moltbot to use OpenRouter via env var
# The actual API key comes from the OPENROUTER_API_KEY env var at runtime
RUN mkdir -p /home/node/.clawdbot && \
    echo '{"agents":{"defaults":{"model":{"primary":"openrouter/anthropic/claude-3.5-haiku"}}},"plugins":{"slots":{}}}' > /home/node/.clawdbot/moltbot.json

