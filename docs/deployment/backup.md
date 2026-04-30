# Backup & Restore

TradeTally includes backup and restore scripts that capture the database, uploaded files, runtime data, and sanitized configuration.

## What Gets Backed Up

| Component | Description | Location |
|-----------|-------------|----------|
| **Database** | All PostgreSQL tables | PostgreSQL dump |
| **Trade Images** | Trade screenshots and attachments | `/app/backend/uploads/trades/` |
| **Runtime Data** | Backups and other persisted app data | `/app/backend/src/data/` |
| **Configuration** | Sanitized environment and compose config | `.env`, `docker-compose.yaml` |

## Quick Start

### Create a Backup

```bash
cd /path/to/tradetally
./scripts/backup.sh
```

### Restore a Backup

```bash
./scripts/restore.sh backups/tradetally_backup_20250124_120000.tar.gz
```

!!! warning "Data overwrite"
    Restore replaces existing data. Create a fresh backup before restoring.

## Docker Notes

The official Docker deployment already persists data with named volumes, so uploads and backup files survive container rebuilds by default.

Official volumes:

- `postgres_data`
- `app_uploads`
- `app_data`
- `app_logs`

If you are migrating from an older deployment that did not persist uploads, copy them out before switching:

```bash
docker cp tradetally-app:/app/backend/uploads ./backend/uploads
docker compose down
docker compose up -d
```

## Useful Commands

### Manual Database Backup in Docker

```bash
docker exec tradetally-db pg_dump -U trader tradetally > backup.sql
```

### Manual Database Restore in Docker

```bash
docker exec -i tradetally-db psql -U trader tradetally < backup.sql
```

### Start Containers if Needed

```bash
docker compose up -d
```

## Verifying a Backup

```bash
tar -tzf tradetally_backup_20250124_120000.tar.gz
tar -xzf tradetally_backup_20250124_120000.tar.gz -O manifest.json
```

## Troubleshooting

### "Database container is not running"

```bash
docker ps | grep tradetally
```

### Permission Denied

```bash
chmod +x scripts/backup.sh scripts/restore.sh
```

### Large Backups

Large backups usually come from:

- many uploaded images
- accumulated runtime data
- large log files
