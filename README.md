# plex2shell-check

Quick Plex2Shell (CVE-2026-96652) exposure & version check — is your Plex Media Server patched (1.43.3.10861+)?

## What is this?

**Plex2Shell** (CVE-2026-96652) is an **unauthenticated RCE chain** that Plex calls "actively and widely exploited". It is fixed in **Plex Media Server 1.43.3.10861** and newer.

`check-plex-version.sh` queries your Plex Media Server's `/identity` endpoint, reads the build it reports, and tells you whether it is at or above the patched build — or vulnerable and in urgent need of an update.

## Usage

```bash
chmod +x check-plex-version.sh
./check-plex-version.sh
```

By default the script checks `127.0.0.1:32400` (a local Plex Media Server). To check a remote server, set the host and port with environment variables:

```bash
PLEX_HOST=192.0.2.10 PLEX_PORT=32400 ./check-plex-version.sh
```

### What the results mean

- **OK** — the server reports a version at or above `1.43.3.10861`. It is patched against Plex2Shell.
- **VULNERABLE** (exit code 2) — the server is older than `1.43.3.10861`. Update Plex Media Server immediately.
- Exit code 1 — the script could not reach Plex or read a version. Check the host, the port, and that Plex Media Server is running.

## Full guide

For the complete patch + compromise-check walkthrough, see the full guide:

[Plex Media Server update: patch and compromise-check guide](https://thehomelabfixer.blogspot.com/2026/10/plex-media-server-update-patch.html)
