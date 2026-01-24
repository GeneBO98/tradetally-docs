# Backup & Restore

TradeTally includes comprehensive backup and restore scripts that capture all user data, including the database, uploaded images, and configuration files.

## What Gets Backed Up

| Component | Description | Location |
|-----------|-------------|----------|
| **Database** | All tables (users, trades, settings, diary entries, etc.) | PostgreSQL dump |
| **Trade Images** | Screenshots and attachments added to trades | `/app/backend/uploads/trades/` |
| **Data Files** | CUSIP cache, Russell 2000 data, existing backups | `/app/backend/src/data/` |
| **Configuration** | Environment files (sanitized - passwords masked) | `.env`, `docker-compose.yaml` |

## Prerequisites

- Bash shell (Linux, macOS, or WSL on Windows)
- Docker (if using Docker deployment)
- `tar` and `gzip` (included in most systems)
- Optional: `jq` for viewing backup manifest

## Quick Start

### Create a Backup

```bash
# Navigate to TradeTally directory
cd /path/to/tradetally

# Run the backup script
./scripts/backup.sh
```

The backup will be created in the `./backups` directory with a timestamped filename like `tradetally_backup_20250124_120000.tar.gz`.

### Restore from Backup

```bash
./scripts/restore.sh backups/tradetally_backup_20250124_120000.tar.gz
```

---

## Backup Script Usage

```bash
./scripts/backup.sh [options]
```

### Options

| Option | Description |
|--------|-------------|
| `--docker` | Force Docker mode (use containers) |
| `--local` | Force local/native mode (direct database access) |
| `--output DIR` | Custom output directory (default: `./backups`) |
| `--help` | Show help message |

### Examples

```bash
# Auto-detect Docker or local mode
./scripts/backup.sh

# Specify custom output directory
./scripts/backup.sh --output /mnt/backups

# Force Docker mode
./scripts/backup.sh --docker
```

### Environment Variables

The backup script can use these environment variables (or reads from `.env`):

| Variable | Default | Description |
|----------|---------|-------------|
| `DB_HOST` | `localhost` | Database host |
| `DB_PORT` | `5432` | Database port |
| `DB_USER` | `trader` | Database username |
| `DB_PASSWORD` | - | Database password |
| `DB_NAME` | `tradetally` | Database name |

---

## Restore Script Usage

```bash
./scripts/restore.sh <backup_file> [options]
```

### Options

| Option | Description |
|--------|-------------|
| `--docker` | Force Docker mode |
| `--local` | Force local/native mode |
| `--db-only` | Restore database only (skip files) |
| `--files-only` | Restore files only (skip database) |
| `--help` | Show help message |

### Examples

```bash
# Full restore (database + files)
./scripts/restore.sh backups/tradetally_backup_20250124_120000.tar.gz

# Restore database only
./scripts/restore.sh backup.tar.gz --db-only

# Restore files only (images, data)
./scripts/restore.sh backup.tar.gz --files-only
```

!!! warning "Data Overwrite"
    The restore script will **overwrite existing data**. The database is dropped and recreated during restore. Always create a backup before restoring.

---

## Backup Contents

A backup archive contains the following structure:

```
tradetally_backup_YYYYMMDD_HHMMSS.tar.gz
├── manifest.json          # Backup metadata
├── database/
│   └── tradetally.sql     # Full PostgreSQL dump
├── uploads/
│   └── trades/            # Trade images and attachments
├── data/
│   ├── cusip_cache.json   # CUSIP lookup cache
│   ├── russell2000.json   # Russell 2000 symbols
│   └── backups/           # Previous JSON backups
└── config/
    ├── .env.sanitized     # Environment config (passwords masked)
    └── docker-compose.yaml
```

### Manifest File

The `manifest.json` file contains metadata about the backup:

```json
{
  "backup_version": "1.0",
  "created_at": "2025-01-24T14:41:37Z",
  "created_by": "user@hostname",
  "backup_mode": "docker",
  "tradetally": {
    "database": {
      "name": "tradetally",
      "users": 5,
      "trades": 1250,
      "diary_entries": 45
    },
    "files": {
      "uploads": 87,
      "data_files": 3
    }
  }
}
```

---

## Docker-Specific Notes

### Container Auto-Detection

The backup scripts automatically detect running TradeTally containers:

- **Production**: `tradetally-db`, `tradetally-app`
- **Development**: `tradetally-db-dev`, `tradetally-app-dev`

### Persisting Uploads

!!! important "Volume Mount Required"
    To persist uploaded images between container rebuilds, ensure your `docker-compose.yaml` includes the uploads volume mount:

    ```yaml
    volumes:
      - ./backend/src/logs:/app/backend/src/logs
      - ./backend/src/data:/app/backend/src/data
      - ./backend/uploads:/app/backend/uploads  # Required for images
    ```

### Migrating Existing Uploads

If you have an existing deployment without the uploads volume mount, copy the files before updating:

```bash
# Copy uploads from container to host
docker cp tradetally-app:/app/backend/uploads ./backend/uploads

# Restart with new volume mount
docker-compose down
docker-compose up -d
```

For development deployments:

```bash
docker cp tradetally-app-dev:/app/backend/uploads ./backend/uploads
docker-compose -f docker-compose.dev.yaml down
docker-compose -f docker-compose.dev.yaml up -d
```

---

## Automated Backups

### Using Cron (Linux/macOS)

Set up automated daily backups using cron:

```bash
# Edit crontab
crontab -e

# Add daily backup at 2 AM
0 2 * * * /path/to/tradetally/scripts/backup.sh --output /path/to/backups >> /var/log/tradetally-backup.log 2>&1
```

### Backup Rotation

To automatically remove old backups, add a cleanup step:

```bash
# Keep only last 30 days of backups
find /path/to/backups -name "tradetally_backup_*.tar.gz" -mtime +30 -delete
```

### Full Cron Example

```bash
# Daily backup at 2 AM, keep 30 days
0 2 * * * cd /path/to/tradetally && ./scripts/backup.sh --output /backups && find /backups -name "tradetally_backup_*.tar.gz" -mtime +30 -delete
```

---

## Manual Database Backup

If you only need a database backup without the full script:

### Docker

```bash
# Backup
docker exec tradetally-db pg_dump -U trader tradetally > backup.sql

# Restore
docker exec -i tradetally-db psql -U trader tradetally < backup.sql
```

### Local PostgreSQL

```bash
# Backup
PGPASSWORD=your_password pg_dump -h localhost -U trader tradetally > backup.sql

# Restore
PGPASSWORD=your_password psql -h localhost -U trader tradetally < backup.sql
```

---

## Verifying Backups

### Check Archive Contents

```bash
# List files in backup
tar -tzf tradetally_backup_20250124_120000.tar.gz

# View manifest
tar -xzf tradetally_backup_20250124_120000.tar.gz -O manifest.json
```

### Verify Checksum

Each backup includes a SHA256 checksum file:

```bash
# Verify integrity
sha256sum -c tradetally_backup_20250124_120000.tar.gz.sha256
```

---

## Troubleshooting

### "Database container is not running"

Ensure your Docker containers are running:

```bash
docker ps | grep tradetally
```

Start containers if needed:

```bash
docker-compose up -d
```

### "No uploads directory found"

The uploads directory is created when the first image is uploaded. An empty backup for uploads is normal for new installations.

### Permission Denied

Ensure the scripts are executable:

```bash
chmod +x scripts/backup.sh scripts/restore.sh
```

### Large Backup Size

If backups are unexpectedly large, check for:

- Large log files in `backend/src/logs/`
- Many high-resolution trade images
- Accumulated data in the cache directories

Consider excluding logs from backups by modifying the script or cleaning logs periodically.
