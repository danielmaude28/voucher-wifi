#!/bin/sh
set -eu
ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
sh -n "$ROOT/files/voucher"
sh -n "$ROOT/files/voucher-setup"
sh -n "$ROOT/files/voucher-wifi.init"
echo "Shell syntax checks passed."
