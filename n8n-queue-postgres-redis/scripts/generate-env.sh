#!/usr/bin/env sh
set -eu

base_dir=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)
env_file="$base_dir/.env"

if [ -f "$env_file" ] && [ "${FORCE:-}" != "1" ]; then
  echo "Arquivo .env ja existe: $env_file" >&2
  echo "Use FORCE=1 para sobrescrever." >&2
  exit 1
fi

rand_alnum() {
  len="${1:-32}"
  if command -v openssl >/dev/null 2>&1; then
    openssl rand -hex $((len / 2))
  else
    LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c "$len"
  fi
}

N8N_VERSION="latest"
N8N_ENCRYPTION_KEY=$(rand_alnum 32)
BIND_IP="127.0.0.1"
BIND_PORT="5678"
N8N_HOST="localhost"
N8N_PORT="5678"
N8N_PROTOCOL="http"
WEBHOOK_URL="${N8N_PROTOCOL}://${N8N_HOST}:${N8N_PORT}/"
GENERIC_TIMEZONE="America/Sao_Paulo"
TZ="America/Sao_Paulo"
POSTGRES_USER="n8n"
POSTGRES_PASSWORD=$(rand_alnum 24)
POSTGRES_DB="n8n"
QUEUE_BULL_REDIS_HOST="n8n-redis"
QUEUE_BULL_REDIS_PORT="6379"
EXECUTIONS_MODE="queue"

umask 077
cat > "$env_file" <<ENV
N8N_VERSION=$N8N_VERSION
N8N_ENCRYPTION_KEY=$N8N_ENCRYPTION_KEY
BIND_IP=$BIND_IP
BIND_PORT=$BIND_PORT
N8N_HOST=$N8N_HOST
N8N_PORT=$N8N_PORT
N8N_PROTOCOL=$N8N_PROTOCOL
WEBHOOK_URL=$WEBHOOK_URL
GENERIC_TIMEZONE=$GENERIC_TIMEZONE
TZ=$TZ
POSTGRES_USER=$POSTGRES_USER
POSTGRES_PASSWORD=$POSTGRES_PASSWORD
POSTGRES_DB=$POSTGRES_DB
QUEUE_BULL_REDIS_HOST=$QUEUE_BULL_REDIS_HOST
QUEUE_BULL_REDIS_PORT=$QUEUE_BULL_REDIS_PORT
EXECUTIONS_MODE=$EXECUTIONS_MODE
ENV

echo "Gerado: $env_file"
