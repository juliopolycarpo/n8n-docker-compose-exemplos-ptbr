#!/usr/bin/env sh
set -eu

base_dir=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)
compose_file="$base_dir/docker-compose.yaml"

if ! command -v docker >/dev/null 2>&1; then
  echo "docker nao encontrado no PATH." >&2
  exit 1
fi

if [ ! -f "$compose_file" ]; then
  echo "docker-compose.yaml nao encontrado em: $base_dir" >&2
  exit 1
fi

if [ "${FORCE:-}" != "1" ]; then
  printf "Isto vai remover os volumes nomeados desta stack (%s). Continuar? [y/N] " "$base_dir" >&2
  read -r answer
  case "$answer" in
    y|Y|yes|YES) ;;
    *) echo "Cancelado." >&2; exit 1 ;;
  esac
fi

docker compose -f "$compose_file" down -v

echo "Volumes removidos para a stack: $base_dir"
