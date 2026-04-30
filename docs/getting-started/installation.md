# Native Installation from Source

This guide is for local development or advanced non-Docker installs.

!!! note "Recommended for most self-hosted users"
    If you are self-hosting TradeTally for normal use, start with [Docker Deployment](../deployment/docker.md) instead. It is the primary and better-supported installation path.

## Prerequisites

- Node.js 20+
- `pnpm` 10.13.1
- PostgreSQL 16+
- Git

## 1. Clone the Repository

```bash
git clone https://github.com/GeneBO98/tradetally.git
cd tradetally
```

## 2. Install pnpm and Workspace Dependencies

```bash
npm install -g pnpm@10.13.1
pnpm install
```

## 3. Create the Database

```sql
CREATE DATABASE tradetally_db;
CREATE USER tradetally_user WITH PASSWORD 'your_secure_password';
GRANT ALL PRIVILEGES ON DATABASE tradetally_db TO tradetally_user;
```

## 4. Configure the Backend

```bash
cp backend/.env.example backend/.env
```

At minimum, update these values in `backend/.env`:

```env
DB_HOST=localhost
DB_PORT=5432
DB_NAME=tradetally_db
DB_USER=tradetally_user
DB_PASSWORD=your_secure_password
FRONTEND_URL=http://localhost:5173
CORS_ORIGINS=http://localhost:5173,http://localhost:3000,http://localhost:8080
JWT_SECRET=change_this_to_a_long_random_value
```

## 5. Run Database Migrations

```bash
pnpm --dir backend run migrate
```

## 6. Start the Backend

```bash
pnpm --dir backend run dev
```

The API runs on `http://localhost:3000`.

## 7. Start the Frontend

In a second terminal:

```bash
pnpm --dir frontend run dev
```

The frontend runs on `http://localhost:5173`.

## Next Steps

- [API Configuration](api-keys.md)
- [Importing Trades](../usage/importing-trades.md)
- [Docker Deployment](../deployment/docker.md) if you want to move to the recommended self-hosted path later

## Troubleshooting

### Database Connection Errors

```bash
psql -h localhost -U tradetally_user -d tradetally_db -c "SELECT 1;"
```

### Port Already in Use

```bash
lsof -i :3000
lsof -i :5173
```
