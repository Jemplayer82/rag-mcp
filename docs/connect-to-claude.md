# Connect to Claude

These settings tell Claude how to start the server. Replace `YOUR_RAG_HOST` and the password with your own values.

## Claude Desktop (`claude_desktop_config.json`)

**Docker (recommended — zero local setup):**

```json
{
  "mcpServers": {
    "rag": {
      "command": "docker",
      "args": [
        "run", "-i", "--rm",
        "-e", "RAG_BASE_URL=http://YOUR_RAG_HOST:8000",
        "-e", "RAG_USERNAME=admin",
        "-e", "RAG_PASSWORD=yourpassword",
        "ghcr.io/jemplayer82/rag-mcp:latest"
      ]
    }
  }
}
```

**Python (local install):**

```json
{
  "mcpServers": {
    "rag": {
      "command": "python",
      "args": ["/path/to/rag-mcp/mcp_server.py"],
      "env": {
        "RAG_BASE_URL": "http://YOUR_RAG_HOST:8000",
        "RAG_USERNAME": "admin",
        "RAG_PASSWORD": "yourpassword"
      }
    }
  }
}
```

## Claude Code (`.claude/mcp.json`)

```json
{
  "mcpServers": {
    "rag": {
      "command": "docker",
      "args": [
        "run", "-i", "--rm",
        "-e", "RAG_BASE_URL=http://YOUR_RAG_HOST:8000",
        "-e", "RAG_USERNAME=admin",
        "-e", "RAG_PASSWORD=yourpassword",
        "ghcr.io/jemplayer82/rag-mcp:latest"
      ]
    }
  }
}
```

Or via CLI:

```bash
claude mcp add rag -- docker run -i --rm \
  -e RAG_BASE_URL=http://YOUR_RAG_HOST:8000 \
  -e RAG_USERNAME=admin \
  -e RAG_PASSWORD=yourpassword \
  ghcr.io/jemplayer82/rag-mcp:latest
```

## Smoke test

Test without connecting to Claude Desktop using the MCP Inspector:

```bash
RAG_BASE_URL=http://YOUR_HOST:8000 RAG_USERNAME=admin RAG_PASSWORD=yourpass \
  npx @modelcontextprotocol/inspector python mcp_server.py
```
