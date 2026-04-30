# Docker Deployment

Docker is the recommended way to self-host TradeTally.

This deployment path now matches the actual files in the main repository:

- `docker-compose.yaml`
- `.env.example`
- `scripts/quick-deploy.sh`

## Quick Start

### Fastest Path

```bash
git clone https://github.com/GeneBO98/tradetally.git
cd tradetally
./scripts/quick-deploy.sh
```

The script:

- creates `.env` from `.env.example` if needed
- prompts for the important deployment values
- generates secrets when you leave them blank
- starts the containers with Docker Compose

By default, TradeTally starts at `http://localhost:8080`.

## Manual Setup

If you want to configure things yourself instead of using the script:

```bash
git clone https://github.com/GeneBO98/tradetally.git
cd tradetally
cp .env.example .env
```

Update the important values in `.env`:

```env
APP_PORT=8080
DB_PASSWORD=change_this_database_password
JWT_SECRET=change_this_to_a_long_random_string
BROKER_ENCRYPTION_KEY=generate_with_openssl_rand_hex_32
INSTANCE_NAME=TradeTally
INSTANCE_URL=http://localhost:8080
FRONTEND_URL=http://localhost:8080
CORS_ORIGINS=http://localhost:8080
API_BASE_URL=http://localhost:8080/api
REGISTRATION_MODE=open
```

Then start the stack:

```bash
docker compose up -d
```

## Prerequisites

- Docker Engine 20.10+
- Docker Compose v2
- 2 GB+ RAM available
- 10 GB+ free disk space

## What the Official Compose File Includes

The shipped `docker-compose.yaml` starts:

- **`postgres`** on PostgreSQL 16
- **`app`** using `potentialmidas/tradetally:latest`

The web UI is exposed on:

- `http://localhost:${APP_PORT}` where `APP_PORT` defaults to `8080`

The backend API is reached through the same web port under `/api`.

## Required Settings

### Always Set

- `DB_PASSWORD`
- `JWT_SECRET`
- `INSTANCE_URL`
- `FRONTEND_URL`
- `CORS_ORIGINS`

### Required for Broker Sync

- `BROKER_ENCRYPTION_KEY`

### Required for Schwab Sync

- `SCHWAB_CLIENT_ID`
- `SCHWAB_CLIENT_SECRET`
- `SCHWAB_REDIRECT_URI`

The quick deploy script generates `BROKER_ENCRYPTION_KEY` automatically unless you provide one.

## Common Commands

### Start

```bash
docker compose up -d
```

### Stop

```bash
docker compose down
```

### View Logs

```bash
docker compose logs -f
docker compose logs -f app
docker compose logs -f postgres
```

### Restart

```bash
docker compose restart app
```

### Update to the Latest Image

```bash
docker compose pull
docker compose up -d
```

## Data Persistence

The official compose file persists data with Docker volumes:

- `postgres_data` - PostgreSQL data
- `app_uploads` - trade images, diary images, avatars
- `app_data` - backup JSON files and other runtime data
- `app_logs` - application logs

Because these volumes are already part of the official compose file, you do not need to add manual bind mounts just to preserve uploads.

## Health Check

```bash
curl http://localhost:8080/api/health
```

Expected response:

```json
{"status":"ok","database":"connected"}
```

## Reverse Proxy / HTTPS

If you are putting TradeTally behind Nginx, Caddy, or Traefik:

1. Set `INSTANCE_URL` and `FRONTEND_URL` to your public `https://` URL.
2. Set `CORS_ORIGINS` to that same public URL.
3. Set `API_BASE_URL` to `https://your-domain.com/api`.
4. Set `TRUST_PROXY=1`.

The quick deploy script does this automatically when you enter an `https://` public URL.

## Troubleshooting

### Port Already in Use

Change `APP_PORT` in `.env`, then restart:

```bash
docker compose up -d
```

### Database Container Is Healthy but App Fails

Check application logs:

```bash
docker compose logs -f app
```

The most common causes are:

- `JWT_SECRET` was left at an unsafe placeholder
- `DB_PASSWORD` does not match the database container
- `FRONTEND_URL` / `CORS_ORIGINS` do not match the actual public URL

### Broker Sync Fails Immediately

Make sure `BROKER_ENCRYPTION_KEY` is set. Broker sync will not work without it.

## Related Guides

- [Backup & Restore](backup.md)
- [API Configuration](../getting-started/api-keys.md)
- [Broker Sync](../features/broker-sync.md)
