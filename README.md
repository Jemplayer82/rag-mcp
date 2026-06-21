# `$ rag-mcp`

**MCP server for [Fathom Works RAG](https://github.com/Jemplayer82/RAG) — exposes the self-hosted knowledge base as tools any MCP-capable LLM can call.**

Query documents, manage libraries, and ingest local files or URLs without opening the web UI.

---

## `[ what it does ]`

| Tool | Who can call it | Description |
|------|-----------------|-------------|
| `query` | any user | Semantic + BM25 search across one or more libraries; returns LLM answer with citations |
| `list_libraries` | any user | List libraries and their document counts |
| `list_documents` | any user | List documents, optionally filtered by library or title |
| `add_file` | admin | Ingest a **local file** (PDF, TXT, DOC, DOCX) into a library |
| `add_url` | admin | Ingest a web URL into a library |
| `get_job_status` | admin | Check ingestion job progress |
| `delete_document` | admin | Remove a document and all its vectors |

---

## `[ quick start ]`

### Option A — run with Python (no Docker)

```bash
git clone https://github.com/Jemplayer82/rag-mcp.git
cd rag-mcp
pip install -r requirements.txt
cp .env.example .env   # fill in RAG_BASE_URL + credentials
python mcp_server.py   # starts the stdio MCP server
```

### Option B — run with Docker

```bash
docker pull ghcr.io/jemplayer82/rag-mcp:latest
```

No config file needed — pass environment variables directly at runtime (see Claude config below).

---

## `[ connect to Claude ]`

### Claude Desktop (`claude_desktop_config.json`)

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

### Claude Code (`.claude/mcp.json`)

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

---

## `[ auth ]`

| Method | Variables | Notes |
|--------|-----------|-------|
| Username + password | `RAG_USERNAME`, `RAG_PASSWORD` | **Recommended.** Token is fetched on first call and refreshed automatically on expiry. |
| Static JWT | `RAG_TOKEN` | Works but cannot self-refresh. Copy from browser DevTools → Application → Local Storage → `rag_token`. |

---

## `[ environment variables ]`

| Variable | Default | Description |
|----------|---------|-------------|
| `RAG_BASE_URL` | `http://localhost:8000` | Base URL of the RAG app (no trailing slash) |
| `RAG_USERNAME` | — | Admin or user account username |
| `RAG_PASSWORD` | — | Account password |
| `RAG_TOKEN` | — | Pre-generated JWT (alternative to username/password) |

---

## `[ using the tools ]`

**Ask a question (search all libraries):**
```
query("What are the treatment options for autonomic dysreflexia?")
```

**Narrow to specific libraries:**
```
query("Jones Act seaman status elements", library_ids=[2, 5])
```

**Ingest a local file:**
```
add_file("/Users/me/docs/protocol.pdf", library_id=1, title="Care Protocol 2024")
get_job_status(42)  # poll until complete
```

**Ingest a URL:**
```
add_url("https://example.com/article", title="Article", library_id=1)
```

---

## `[ smoke test ]`

Test without connecting to Claude Desktop using the MCP Inspector:

```bash
RAG_BASE_URL=http://YOUR_HOST:8000 RAG_USERNAME=admin RAG_PASSWORD=yourpass \
  npx @modelcontextprotocol/inspector python mcp_server.py
```

---

## `[ requirements ]`

- Python 3.10+ (uses `X | None` type annotations) — **local machine**, not the RAG container
- Running [Fathom Works RAG](https://github.com/Jemplayer82/RAG) instance (self-hosted or VPS)

---

## `[ license ]`

Released under the [GNU AGPL-3.0](LICENSE).

---

<sub>Part of the <a href="https://github.com/Jemplayer82/RAG">Fathom Works RAG</a> ecosystem.</sub>
