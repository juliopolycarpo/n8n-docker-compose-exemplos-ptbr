#!/usr/bin/env sh
set -eu

stack_dir=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)
compose_path="$stack_dir/docker-compose.yaml"

fail() {
  printf '%s\n' "$*" >&2
  exit 1
}

is_interactive() {
  [ -t 0 ]
}

ensure_command() {
  command -v "$1" >/dev/null 2>&1 || fail "$1 nao encontrado no PATH."
}

ensure_file() {
  [ -f "$1" ] || fail "docker-compose.yaml nao encontrado em: $stack_dir"
}

confirm_volume_removal() {
  if [ "${FORCE:-}" = "1" ]; then
    return 0
  fi

  if ! is_interactive; then
    fail "FORCE=1 necessario para executar sem TTY."
  fi

  printf "Isto vai remover os volumes nomeados desta stack (%s). Continuar? [y/N] " "$stack_dir" >&2
  if ! IFS= read -r answer; then
    fail "Entrada nao disponivel."
  fi

  case "$answer" in
    y|Y|yes|YES) ;;
    *) fail "Cancelado." ;;
  esac
}

ensure_command docker
ensure_file "$compose_path"
confirm_volume_removal

docker compose -f "$compose_path" down -v

printf 'Volumes removidos para a stack: %s\n' "$stack_dir"
