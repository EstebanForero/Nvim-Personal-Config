#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
target_dir="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

mkdir -p "$(dirname -- "$target_dir")"

if [[ -e "$target_dir" && ! -L "$target_dir" ]]; then
  backup="${target_dir}.backup.$(date +%Y%m%d%H%M%S)"
  mv "$target_dir" "$backup"
  printf 'Existing configuration moved to %s\n' "$backup"
fi

ln -sfn "$repo_dir" "$target_dir"
printf 'Neovim configuration linked to %s\n' "$target_dir"
printf 'Start Neovim and run :Lazy sync, :MasonToolsInstall, and :checkhealth\n'
