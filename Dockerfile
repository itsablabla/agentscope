FROM python:3.11-slim

WORKDIR /app

# Copy the entire repo
COPY . .

# Install agentscope with a2a extras and all required deps in one layer
RUN pip install --no-cache-dir -e ".[a2a]" && \
    pip install --no-cache-dir "a2a-sdk[http-server]" uvicorn

# Set working directory to the a2a agent example
WORKDIR /app/examples/agent/a2a_agent

# Expose port
EXPOSE 8000

# Start the A2A server
CMD python -m uvicorn setup_a2a_server:app --host 0.0.0.0 --port ${PORT:-8000}
