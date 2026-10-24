#!/usr/bin/env bash
# plex2shell-check.sh - quick version check for Plex Media Server (Plex2Shell, CVE-2026-96652)
# Patched: Plex Media Server 1.43.3.10861 or newer.
set -u
HOST="${PLEX_HOST:-127.0.0.1}"
PORT="${PLEX_PORT:-32400}"
PATCHED="1.43.3.10861"
echo "== Plex2Shell check (CVE-2026-96652) =="
RAW=$(curl -s --max-time 5 "http://${HOST}:${PORT}/identity" || true)
VER=$(printf '%s' "$RAW" | grep -o 'version="[^"]*"' | head -1 | cut -d'"' -f2)
if [ -z "${VER}" ]; then
  echo "Could not read a version from http://${HOST}:${PORT}/identity"
  echo "Is Plex Media Server running and reachable on this host/port?"
  echo "If Plex is exposed to the internet on an old build, treat it as urgent: patch to ${PATCHED}+."
  exit 1
fi
echo "Detected Plex Media Server version: ${VER}"
LOWEST=$(printf '%s\n%s\n' "${PATCHED}" "${VER}" | sort -V | head -1)
if [ "${LOWEST}" = "${PATCHED}" ]; then
  echo "OK: ${VER} is at or above the patched build ${PATCHED}."
else
  echo "VULNERABLE: ${VER} is older than ${PATCHED}. Update Plex Media Server NOW."
  echo "Full patch + compromise-check guide: https://thehomelabfixer.blogspot.com/2026/10/plex-media-server-update-patch.html"
  exit 2
fi
