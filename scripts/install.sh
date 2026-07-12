#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

usage() {
  cat <<'EOF'
Usage: ./scripts/install.sh [--root]

Without arguments, install for the current user.
With --root, install for Linux's root user (run with sudo or as root).
EOF
}

install_for_root=false

case "${1:-}" in
  "") ;;
  --root) install_for_root=true ;;
  -h | --help)
    usage
    exit 0
    ;;
  *)
    usage >&2
    exit 2
    ;;
esac

if (( $# > 1 )); then
  usage >&2
  exit 2
fi

if [[ "$install_for_root" == true ]]; then
  if [[ "$(uname -s)" != "Linux" ]]; then
    printf 'The --root option is supported only on Linux.\n' >&2
    exit 1
  fi

  if (( EUID != 0 )); then
    printf 'Root installation requires elevated privileges. Run: sudo ./scripts/install.sh --root\n' >&2
    exit 1
  fi

  root_home="/root"
  if command -v getent >/dev/null 2>&1; then
    root_entry="$(getent passwd 0 || true)"
    if [[ -n "$root_entry" ]]; then
      IFS=: read -r _ _ _ _ _ detected_root_home _ <<<"$root_entry"
      if [[ -n "$detected_root_home" ]]; then
        root_home="$detected_root_home"
      fi
    fi
  fi

  target_dir="$root_home/.config/nvim"
else
  target_dir="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
fi

mkdir -p "$(dirname -- "$target_dir")"

if [[ -e "$target_dir" && ! -L "$target_dir" ]]; then
  backup="${target_dir}.backup.$(date +%Y%m%d%H%M%S)"
  mv "$target_dir" "$backup"
  printf 'Existing configuration moved to %s\n' "$backup"
fi

ln -sfn "$repo_dir" "$target_dir"
printf 'Neovim configuration linked to %s\n' "$target_dir"
printf 'Start Neovim and run :Lazy sync, :MasonToolsInstall, and :checkhealth\n'
