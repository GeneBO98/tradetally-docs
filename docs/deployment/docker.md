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

TradeTally will be available at `http://localhost` (port 80).

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

## Docker Compose Configuration

### Production Setup

```yaml
version: '3.8'

services:
  app:
    image: potentialmidas/tradetally:latest
    container_name: tradetally-app
    ports:
      - "80:80"
    environment:
      - NODE_ENV=production
      - DB_HOST=postgres
      - DB_PORT=5432
      - DB_NAME=${DB_NAME}
      - DB_USER=${DB_USER}
      - DB_PASSWORD=${DB_PASSWORD}
      - JWT_SECRET=${JWT_SECRET}
      - REGISTRATION_MODE=${REGISTRATION_MODE}
      - FINNHUB_API_KEY=${FINNHUB_API_KEY}
      - ALPHA_VANTAGE_API_KEY=${ALPHA_VANTAGE_API_KEY}
    depends_on:
      - postgres
    volumes:
      - ./backend/src/logs:/app/backend/src/logs
      - ./backend/src/data:/app/backend/src/data
    restart: unless-stopped

  postgres:
    image: postgres:15-alpine
    container_name: tradetally-db
    environment:
      - POSTGRES_DB=${DB_NAME}
      - POSTGRES_USER=${DB_USER}
      - POSTGRES_PASSWORD=${DB_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

volumes:
  postgres_data:
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

- **Frontend/Nginx**: Port 80
- **Backend API**: Port 3000 (internal)
- **PostgreSQL**: Port 5432 (internal)

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
- **./backend/src/data**: Application data (host mount)

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
