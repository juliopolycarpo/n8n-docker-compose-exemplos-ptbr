#!/usr/bin/env sh
set -eu

stack_dir=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)
env_path="$stack_dir/.env"

if [ -f "$env_path" ] && [ "${FORCE:-}" != "1" ]; then
  printf 'Arquivo .env ja existe: %s\n' "$env_path" >&2
  printf 'Use FORCE=1 para sobrescrever.\n' >&2
  exit 1
fi

random_alnum() {
  length="${1:-32}"
  if command -v openssl >/dev/null 2>&1; then
    openssl rand -hex $((length / 2))
  else
    LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c "$length"
  fi
}

is_interactive() {
  [ -t 0 ]
}

prompt_with_default() {
  prompt_message="$1"
  default_value="$2"
  result_value="$default_value"

  if is_interactive; then
    printf "%s" "$prompt_message"
    if IFS= read -r user_input; then
      if [ -n "$user_input" ]; then
        result_value="$user_input"
      fi
    fi
  fi

  printf "%s" "$result_value"
}

prompt_yes_no() {
  prompt_message="$1"
  default_value="$2"
  result_value="$default_value"

  if is_interactive; then
    printf "%s" "$prompt_message"
    if IFS= read -r user_input; then
      case "$(printf '%s' "$user_input" | tr '[:upper:]' '[:lower:]')" in
        s|sim|y|yes) result_value="true" ;;
        n|nao|no) result_value="false" ;;
        "") result_value="$default_value" ;;
      esac
    fi
  fi

  printf "%s" "$result_value"
}

N8N_VERSION="latest"
N8N_ENCRYPTION_KEY=$(random_alnum 32)
BIND_IP="127.0.0.1"
BIND_PORT="5678"
N8N_HOST="localhost"
N8N_PORT="5678"
N8N_PROTOCOL="http"
GENERIC_TIMEZONE="America/Sao_Paulo"
TZ="America/Sao_Paulo"
POSTGRES_USER="n8n"
POSTGRES_PASSWORD=$(random_alnum 24)
POSTGRES_DB="n8n"
QUEUE_BULL_REDIS_HOST="n8n-redis"
QUEUE_BULL_REDIS_PORT="6379"
EXECUTIONS_MODE="queue"

N8N_HOST=$(prompt_with_default "Defina N8N_HOST (default: ${N8N_HOST}). Ex: n8n.seudominio.com\n> " "$N8N_HOST")
N8N_PROTOCOL=$(prompt_with_default "Defina N8N_PROTOCOL (default: ${N8N_PROTOCOL}). Ex: http, https\n> " "$N8N_PROTOCOL")

WEBHOOK_URL_DEFAULT="${N8N_PROTOCOL}://${N8N_HOST}:${N8N_PORT}/"
WEBHOOK_URL=$(prompt_with_default "Defina WEBHOOK_URL (default: ${WEBHOOK_URL_DEFAULT}). Ex: https://n8n.seudominio.com/\n> " "$WEBHOOK_URL_DEFAULT")

SECURE_COOKIE_DEFAULT="false"
if [ "$N8N_PROTOCOL" = "https" ]; then
  SECURE_COOKIE_DEFAULT="true"
fi
SECURE_COOKIE=$(prompt_with_default "Defina SECURE_COOKIE (default: ${SECURE_COOKIE_DEFAULT}). Ex: true, false\n> " "$SECURE_COOKIE_DEFAULT")

telemetry_enabled=$(prompt_yes_no "Deseja ativar a telemetria? < y|N > " "false")

umask 077
cat > "$env_path" <<ENV
N8N_VERSION=$N8N_VERSION
N8N_ENCRYPTION_KEY=$N8N_ENCRYPTION_KEY
BIND_IP=$BIND_IP
BIND_PORT=$BIND_PORT
N8N_HOST=$N8N_HOST
N8N_PORT=$N8N_PORT
N8N_PROTOCOL=$N8N_PROTOCOL
WEBHOOK_URL=$WEBHOOK_URL
SECURE_COOKIE=$SECURE_COOKIE
GENERIC_TIMEZONE=$GENERIC_TIMEZONE
TZ=$TZ
POSTGRES_USER=$POSTGRES_USER
POSTGRES_PASSWORD=$POSTGRES_PASSWORD
POSTGRES_DB=$POSTGRES_DB
QUEUE_BULL_REDIS_HOST=$QUEUE_BULL_REDIS_HOST
QUEUE_BULL_REDIS_PORT=$QUEUE_BULL_REDIS_PORT
EXECUTIONS_MODE=$EXECUTIONS_MODE

# Telemetria e conexoes externas
N8N_DIAGNOSTICS_ENABLED=$telemetry_enabled
N8N_VERSION_NOTIFICATIONS_ENABLED=$telemetry_enabled
N8N_TEMPLATES_ENABLED=$telemetry_enabled
ENV

printf 'Gerado: %s\n' "$env_path"
