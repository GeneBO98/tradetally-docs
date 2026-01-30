# Docker Deployment

Deploy TradeTally using Docker and Docker Compose for a production-ready setup.

## Quick Start

```bash
# Download docker-compose.yaml
curl -O https://raw.githubusercontent.com/GeneBO98/tradetally/refs/heads/main/docker-compose.yaml

# Download environment template
curl -O https://raw.githubusercontent.com/GeneBO98/tradetally/main/.env.example
mv .env.example .env

# Edit .env with your configuration
nano .env

# Start TradeTally
docker-compose up -d

# View logs
docker-compose logs -f app
```

TradeTally will be available at `http://localhost:8080`.

## Prerequisites

- Docker Engine 20.10+
- Docker Compose 2.0+
- 2GB+ RAM available
- 10GB+ disk space

## Docker Image

TradeTally is available as a pre-built Docker image:

```
potentialmidas/tradetally:latest
```

**Docker Hub**: [potentialmidas/tradetally](https://hub.docker.com/r/potentialmidas/tradetally)

## Configuration

### Required Environment Variables

Create a `.env` file with the following variables:

```env
# Database Configuration
DB_USER=trader
DB_PASSWORD=CHANGE_THIS_PASSWORD
DB_NAME=tradetally

# JWT Configuration
JWT_SECRET=CHANGE_THIS_TO_LONG_RANDOM_STRING

# Registration Control
REGISTRATION_MODE=open

# API Keys (Optional but recommended)
FINNHUB_API_KEY=your_finnhub_api_key
ALPHA_VANTAGE_API_KEY=your_alpha_vantage_api_key
OPENFIGI_API_KEY=your_openfigi_api_key
```

!!! warning "Security"
    **Must change** `DB_PASSWORD` and `JWT_SECRET` before deploying to production!

### Optional Environment Variables

```env
# Node Environment
NODE_ENV=production
PORT=3000

# Frontend Configuration
FRONTEND_URL=http://localhost

# File Upload (50MB limit)
MAX_FILE_SIZE=52428800

# Email Configuration (Optional)
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USER=your_email@gmail.com
EMAIL_PASS=your_app_password

# Push Notifications (Optional)
ENABLE_PUSH_NOTIFICATIONS=false
APNS_KEY_ID=ABC123DEFG
APNS_TEAM_ID=1234567890
APNS_KEY_PATH=/path/to/keys/AuthKey.p8

# Broker Sync Configuration (Optional)
# Required if using Schwab integration
BROKER_ENCRYPTION_KEY=your_32_byte_hex_key  # Generate with: openssl rand -hex 32
SCHWAB_CLIENT_ID=your_schwab_client_id
SCHWAB_CLIENT_SECRET=your_schwab_client_secret
SCHWAB_REDIRECT_URI=https://your-domain.com/api/broker-sync/connections/schwab/callback
```

### Feature Toggles

Control background services and features to optimize resource usage:

```env
# Background Services (set to 'false' to disable)
ENABLE_PRICE_MONITORING=true       # Real-time price monitoring for watchlists
ENABLE_TRADE_ENRICHMENT=true       # Auto-enrich trades with market data
ENABLE_JOB_RECOVERY=true           # Recover failed background jobs
ENABLE_GAMIFICATION=true           # Achievements and badges system
ENABLE_TRIAL_EMAILS=true           # Trial expiration email notifications
ENABLE_OPTIONS_SCHEDULER=true      # Options-related scheduled tasks
ENABLE_BACKUP_SCHEDULER=true       # Automated backup scheduling
ENABLE_ENRICHMENT_CACHE_CLEANUP=true  # Clean stale enrichment cache
FEATURES_BEHAVIORAL_ANALYTICS_ENABLED=true  # Behavioral pattern analysis

# API Documentation
ENABLE_SWAGGER=true                # Enable Swagger API docs at /api-docs

# Database
RUN_MIGRATIONS=true                # Auto-run migrations on startup
```

### System Configuration

```env
# Logging
LOG_LEVEL=INFO                     # DEBUG, INFO, WARN, ERROR

# Timezone (affects admin metrics)
TZ=UTC                             # Server timezone

# Rate Limiting (set RATE_LIMIT_ENABLED=false for self-hosted)
RATE_LIMIT_ENABLED=true            # Enable API rate limiting
RATE_LIMIT_MAX=1000                # Max requests per window
RATE_LIMIT_WINDOW_MS=900000        # Window duration (15 minutes)
```

## Docker Compose Configuration

### Production Setup

```yaml
version: '3.8'

services:
  # PostgreSQL Database
  postgres:
    image: postgres:16-alpine
    container_name: tradetally-db
    environment:
      POSTGRES_USER: ${DB_USER:-trader}
      POSTGRES_PASSWORD: ${DB_PASSWORD:-trader_password}
      POSTGRES_DB: ${DB_NAME:-tradetally}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    networks:
      - trader-network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${DB_USER:-trader} -d ${DB_NAME:-tradetally}"]
      interval: 10s
      timeout: 5s
      retries: 5

  # Application (Frontend + Backend)
  app:
    image: potentialmidas/tradetally:latest
    container_name: tradetally-app
    depends_on:
      postgres:
        condition: service_healthy
    environment:
      # Backend environment variables
      NODE_ENV: ${NODE_ENV:-production}
      PORT: ${PORT:-3000}
      DB_HOST: postgres
      DB_PORT: 5432
      DB_USER: ${DB_USER:-trader}
      DB_PASSWORD: ${DB_PASSWORD:-trader_password}
      DB_NAME: ${DB_NAME:-tradetally}
      JWT_SECRET: ${JWT_SECRET:-your_jwt_secret_here}
      JWT_EXPIRES_IN: ${JWT_EXPIRES_IN:-7d}
      # Frontend API URL
      VITE_API_URL: ${VITE_API_URL:-http://localhost/api}
      # CORS Configuration
      FRONTEND_URL: ${FRONTEND_URL:-http://localhost:5173}
      CORS_ORIGINS: ${CORS_ORIGINS:-}
      # Registration Control
      REGISTRATION_MODE: ${REGISTRATION_MODE:-open}
      # API Documentation
      ENABLE_SWAGGER: ${ENABLE_SWAGGER:-true}
      # External API Keys
      FINNHUB_API_KEY: ${FINNHUB_API_KEY:-}
      ALPHA_VANTAGE_API_KEY: ${ALPHA_VANTAGE_API_KEY:-}
      GEMINI_API_KEY: ${GEMINI_API_KEY:-}
      # Schwab OAuth Configuration
      SCHWAB_CLIENT_ID: ${SCHWAB_CLIENT_ID:-}
      SCHWAB_CLIENT_SECRET: ${SCHWAB_CLIENT_SECRET:-}
      SCHWAB_REDIRECT_URI: ${SCHWAB_REDIRECT_URI:-}
      BROKER_ENCRYPTION_KEY: ${BROKER_ENCRYPTION_KEY:-}
      # Database Configuration
      RUN_MIGRATIONS: ${RUN_MIGRATIONS:-true}
      # Feature Toggles
      ENABLE_PRICE_MONITORING: ${ENABLE_PRICE_MONITORING:-true}
      ENABLE_TRADE_ENRICHMENT: ${ENABLE_TRADE_ENRICHMENT:-true}
      ENABLE_GAMIFICATION: ${ENABLE_GAMIFICATION:-true}
      # Logging
      LOG_LEVEL: ${LOG_LEVEL:-INFO}
      # Timezone
      TZ: ${TZ:-UTC}
      # Rate Limiting
      RATE_LIMIT_ENABLED: ${RATE_LIMIT_ENABLED:-true}
      RATE_LIMIT_MAX: ${RATE_LIMIT_MAX:-1000}
      RATE_LIMIT_WINDOW_MS: ${RATE_LIMIT_WINDOW_MS:-900000}
    ports:
      - "8080:80"
      - "3001:3000"
    volumes:
      - ./backend/src/logs:/app/backend/src/logs
      - ./backend/src/data:/app/backend/src/data
      - ./backend/uploads:/app/backend/uploads
    networks:
      - trader-network
    restart: unless-stopped

networks:
  trader-network:
    driver: bridge

volumes:
  postgres_data:
    driver: local
```

### Development Setup

Use `docker-compose.dev.yaml` for development with hot-reload:

```bash
docker-compose -f docker-compose.dev.yaml up -d
```

## Managing the Container

### Start Services

```bash
docker-compose up -d
```

### Stop Services

```bash
docker-compose down
```

### View Logs

```bash
# All logs
docker-compose logs -f

# Application logs only
docker-compose logs -f app

# Database logs only
docker-compose logs -f postgres
```

### Restart Services

```bash
docker-compose restart app
```

### Update to Latest Version

```bash
# Pull latest image
docker-compose pull

# Restart with new image
docker-compose up -d
```

## Networking

### Default Ports

| Service | Host Port | Container Port | Description |
|---------|-----------|----------------|-------------|
| Frontend/Nginx | 8080 | 80 | Web interface |
| Backend API | 3001 | 3000 | REST API (direct access) |
| PostgreSQL | 5432 | 5432 | Database |

!!! note "Port Configuration"
    The default `docker-compose.yaml` maps port 8080 to the web interface. Access TradeTally at `http://localhost:8080`. Change `8080:80` to `80:80` if you want to use port 80.

### Reverse Proxy Setup

If using a reverse proxy (Nginx, Caddy, Traefik):

```nginx
server {
    listen 80;
    server_name tradetally.example.com;

    location / {
        proxy_pass http://localhost:80;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    client_max_body_size 50M;
}
```

## Data Persistence

### Volume Mounts

- **postgres_data**: Database files (persisted)
- **./backend/src/logs**: Application logs (host mount)
- **./backend/src/data**: Application data, including CUSIP cache (host mount)
- **./backend/uploads**: User uploaded files and attachments (host mount)

### Backup Database

```bash
# Create backup
docker-compose exec postgres pg_dump -U trader tradetally > backup_$(date +%Y%m%d).sql

# Restore backup
docker-compose exec -T postgres psql -U trader tradetally < backup_20240101.sql
```

### Backup Application Data

```bash
# Backup CUSIP cache and other data
tar -czf data_backup_$(date +%Y%m%d).tar.gz backend/src/data/
```

## SSL/HTTPS Setup

### Using Certbot

```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx

# Get SSL certificate
sudo certbot --nginx -d tradetally.example.com

# Auto-renewal
sudo crontab -e
# Add: 0 12 * * * /usr/bin/certbot renew --quiet
```

### Docker with SSL

Update `docker-compose.yaml` to mount SSL certificates:

```yaml
services:
  app:
    volumes:
      - ./ssl/cert.pem:/etc/ssl/certs/cert.pem:ro
      - ./ssl/key.pem:/etc/ssl/private/key.pem:ro
    environment:
      - SSL_ENABLED=true
```

## Health Checks

### Application Health

```bash
# Check application status
curl http://localhost/api/health

# Expected response
{"status":"ok","database":"connected"}
```

### Database Health

```bash
# Check database
docker-compose exec postgres psql -U trader -d tradetally -c "SELECT 1;"
```

## Monitoring

### Container Stats

```bash
# Real-time resource usage
docker stats tradetally-app tradetally-db
```

### Log Monitoring

```bash
# Watch application logs
tail -f backend/src/logs/*.log

# Watch Nginx access logs
docker-compose exec app tail -f /var/log/nginx/access.log
```

## Troubleshooting

### Container Won't Start

```bash
# Check container logs
docker-compose logs app

# Check if ports are in use
lsof -i :80
lsof -i :5432

# Restart services
docker-compose restart
```

### Database Connection Issues

```bash
# Verify database is running
docker-compose ps postgres

# Check database logs
docker-compose logs postgres

# Test database connection
docker-compose exec app psql -h postgres -U trader -d tradetally -c "SELECT 1;"
```

### Permission Issues

```bash
# Fix volume permissions
sudo chown -R $USER:$USER backend/src/logs backend/src/data

# Restart container
docker-compose restart app
```

### Out of Memory

```bash
# Check memory usage
docker stats tradetally-app

# Increase memory limit in docker-compose.yaml
services:
  app:
    deploy:
      resources:
        limits:
          memory: 2G
```

## Production Considerations

### Security

- Change default passwords
- Use strong JWT secret
- Enable SSL/HTTPS
- Configure firewall rules
- Regular security updates

### Performance

- Use SSD for database volume
- Allocate adequate RAM (4GB+ recommended)
- Configure connection pooling
- Enable gzip compression

### Backups

- Automated daily database backups
- Off-site backup storage
- Test restore procedures
- Backup application data

### Monitoring

- Set up uptime monitoring
- Configure log aggregation
- Monitor disk space
- Track API usage

## Advanced Configuration

### Custom Port

```yaml
services:
  app:
    ports:
      - "8080:80"  # Use port 8080 instead of 80
```

### External Database

```yaml
services:
  app:
    environment:
      - DB_HOST=external-postgres.example.com
      - DB_PORT=5432
```

### Multiple Instances

Use Docker Swarm or Kubernetes for load balancing:

```bash
# Docker Swarm
docker stack deploy -c docker-compose.yaml tradetally

# Kubernetes
kubectl apply -f kubernetes/
```

## Next Steps

- [Installation Guide](../getting-started/installation.md) - Install from source
- [Quick Start](../getting-started/quick-start.md) - Get started quickly
- [API Configuration](../getting-started/api-keys.md) - Configure external APIs
