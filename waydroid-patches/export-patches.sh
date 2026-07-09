#!/bin/bash
# export-patches.sh -- inverse of apply-patches.sh.
#
# Regenerate base-patches-<sdk> from the working tree. For every stock
# (LineageOS/AOSP) project that carries Waydroid commits on top of its manifest
# revision, export the commits between repo's per-project upstream ref
# (refs/remotes/m/<branch>) and HEAD into base-patches-<sdk>/<path>/. The base
# is discovered by comparing HEAD to that ref, so there is no base list to keep.
#
# Waydroid-originating projects (device/waydroid, hardware/waydroid, vendor/*,
# the audio/media/vndk forks) are shipped wholesale, not patched, and skipped:
# they are detected by "waydroid" appearing in the project's remote URL.
#
# Output is rebase-stable: zeroed commit hashes, no git signature, no n/m
# numbering in the [PATCH] subject.

set -e

LOCALDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
top_dir=$(cd "$LOCALDIR/../../.." && pwd)
sdkv=${1:-36}
export PATCH_DIR="$LOCALDIR/base-patches-${sdkv}"

cd "$top_dir"
repo forall -c '
  # Skip Waydroid-originating projects (whole tree shipped, not patched).
  url=$(git config "remote.$REPO_REMOTE.url" 2>/dev/null)
  case "$url" in *[Ww]ay[Dd]roid*) exit 0 ;; esac

  # Upstream = repo per-project manifest ref (refs/remotes/m/<branch>).
  up=$(git for-each-ref --format="%(refname)" refs/remotes/m/ | head -1)
  [ -n "$up" ] || exit 0

  n=$(git rev-list --count "$up..HEAD" 2>/dev/null) || exit 0
  [ "$n" = 0 ] && exit 0

  out="$PATCH_DIR/$REPO_PATH"
  mkdir -p "$out"
  rm -f "$out"/*.patch
  git format-patch --zero-commit --no-signature -N -o "$out" "$up..HEAD" >/dev/null
  echo "WROTE $REPO_PATH ($n)"
'
echo "Done. Patches under $PATCH_DIR/"
