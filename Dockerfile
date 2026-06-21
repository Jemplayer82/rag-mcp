FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY mcp_server.py .

# stdio transport — stdin/stdout are the MCP channel.
# -u: unbuffered so messages aren't held in Python's I/O buffer.
ENTRYPOINT ["python", "-u", "mcp_server.py"]
