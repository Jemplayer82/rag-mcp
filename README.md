<p align="center"><img src="assets/fathom-header-banner.svg" alt="Fathom Works — rag-mcp" width="100%"></p>

# `$ rag-mcp`

**Lets an AI assistant like Claude search and manage your private document library.** It connects to your own [Fathom Works RAG](https://github.com/Jemplayer82/RAG) server, so you can ask questions about your files without opening the web page.

**In plain terms:** MCP is a plug-in format that lets an AI assistant use outside tools. This is one of those plug-ins. It is for people who already run a Fathom Works RAG server and want Claude to use it.

*A [Fathom Works](https://github.com/Jemplayer82) project.*

## `[ quick start ]`

Run it with Python:

```bash
git clone https://github.com/Jemplayer82/rag-mcp.git
cd rag-mcp
pip install -r requirements.txt
cp .env.example .env   # fill in RAG_BASE_URL + credentials
python mcp_server.py   # starts the stdio MCP server
```

Or pull the Docker image. No config file is needed. Pass the settings when you run it.

```bash
docker pull ghcr.io/jemplayer82/rag-mcp:latest
```

Then tell Claude how to start it. See [connect to Claude](docs/connect-to-claude.md).

## `[ tools ]`

| Tool | Who can call it | What it does |
|------|-----------------|--------------|
| `query` | any user | Searches one or more libraries and returns an answer with citations |
| `list_libraries` | any user | Lists libraries and how many documents each holds |
| `list_documents` | any user | Lists documents, optionally filtered by library or title |
| `add_file` | admin | Adds a **local file** (PDF, TXT, DOC, DOCX) to a library |
| `add_url` | admin | Adds a web page to a library |
| `get_job_status` | admin | Checks how far an upload has progressed |
| `delete_document` | admin | Removes a document and all its search data |

## `[ usage ]`

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

## `[ configuration ]`

Sign in with a username and password. The server fetches a login token on the first call and renews it when it expires. This is the recommended way.

| Variable | What it does | Default |
|----------|--------------|---------|
| `RAG_BASE_URL` | Address of the RAG app (no trailing slash) | `http://localhost:8000` |
| `RAG_USERNAME` | Account username | — |
| `RAG_PASSWORD` | Account password | — |
| `RAG_TOKEN` | Ready-made login token (JWT). Cannot renew itself. Copy it from browser DevTools → Application → Local Storage → `rag_token` | — |

Requires Python 3.10+ on your own machine (not the RAG container) and a running [Fathom Works RAG](https://github.com/Jemplayer82/RAG) server.

## `[ docs ]`

- [Connect to Claude](docs/connect-to-claude.md): Claude Desktop and Claude Code settings, plus a smoke test.

## `[ license ]`

Released under the [GNU AGPL-3.0](LICENSE).

<img src="assets/fathom-footer-banner.svg" alt="Fathom Works — sound the depths before you set a course" width="100%">
