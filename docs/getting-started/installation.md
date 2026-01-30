# Installation Guide

This guide will walk you through installing TradeTally from source.

## Prerequisites

Before setting up TradeTally, ensure you have the following installed:

### Required Software

- **Node.js** (v18.0.0 or higher)
- **npm** (comes with Node.js)
- **PostgreSQL** (v16 or higher)
- **Git** (for cloning the repository)

### Operating System Support

- macOS (10.15+)
- Windows (10+)
- Linux (Ubuntu 18.04+, CentOS 7+)

## Step 1: Install Node.js and npm

=== "macOS"

    ```bash
    # Install Homebrew if not already installed
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Install Node.js and npm
    brew install node

    # Verify installation
    node --version
    npm --version
    ```

=== "Windows"

    1. Download Node.js from [nodejs.org](https://nodejs.org/)
    2. Run the installer and follow the setup wizard
    3. Verify installation:

    ```cmd
    node --version
    npm --version
    ```

=== "Ubuntu/Debian"

    ```bash
    # Update package index
    sudo apt update

    # Install Node.js and npm
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs

    # Verify installation
    node --version
    npm --version
    ```

## Step 2: Install PostgreSQL

=== "macOS"

    ```bash
    # Install PostgreSQL
    brew install postgresql

    # Start PostgreSQL service
    brew services start postgresql

    # Create a database user (optional)
    createuser --interactive
    ```

=== "Windows"

    1. Download PostgreSQL from [postgresql.org](https://www.postgresql.org/download/windows/)
    2. Run the installer and follow the setup wizard
    3. Remember the password you set for the postgres user

=== "Ubuntu/Debian"

    ```bash
    # Install PostgreSQL
    sudo apt update
    sudo apt install postgresql postgresql-contrib

    # Start PostgreSQL service
    sudo systemctl start postgresql
    sudo systemctl enable postgresql

    # Switch to postgres user and create a database user
    sudo -u postgres createuser --interactive
    ```

## Step 3: Clone the Repository

```bash
# Clone the repository
git clone https://github.com/GeneBO98/tradetally.git
cd tradetally

# Repository structure
# tradetally/
# ├── backend/
# ├── frontend/
# └── README.md
```

## Step 4: Database Setup

### Create Database and User

```sql
-- Connect to PostgreSQL as superuser
sudo -u postgres psql

-- Create database
CREATE DATABASE tradetally_db;

-- Create user with password
CREATE USER tradetally_user WITH PASSWORD 'your_secure_password';

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE tradetally_db TO tradetally_user;

-- Exit PostgreSQL
\q
```

### Run Database Migrations

```bash
# Navigate to backend directory
cd backend

# Run all migrations
npm run migrate
```

## Step 5: Backend Setup

```bash
# Navigate to backend directory
cd backend

# Install dependencies
npm install

# Copy environment configuration
cp .env.example .env

# Edit .env file with your configuration
nano .env
```

### Configure Environment Variables

Edit the `.env` file with your specific values:

```env
NODE_ENV=development
PORT=3000

# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_NAME=tradetally_db
DB_USER=tradetally_user
DB_PASSWORD=your_secure_password

# JWT Configuration
JWT_SECRET=your_super_secret_jwt_key_here_make_it_long_and_random
JWT_EXPIRE=7d

# Registration Control
REGISTRATION_MODE=open

# Frontend URL
FRONTEND_URL=http://localhost:5173

# File Upload (50MB limit for large CSV files)
MAX_FILE_SIZE=52428800

# API Keys (Optional but recommended)
FINNHUB_API_KEY=your_finnhub_api_key
ALPHA_VANTAGE_API_KEY=your_alpha_vantage_api_key
```

## Step 6: Frontend Setup

```bash
# Navigate to frontend directory
cd ../frontend

# Install dependencies
npm install

# Copy environment configuration (optional)
cp .env.example .env
```

### Frontend Environment Variables (Optional)

```env
# Set to 'false' to hide the donation button
VITE_SHOW_DONATION_BUTTON=true
```

## Step 7: Start the Application

### Start Backend Server

```bash
# In the backend directory
cd backend
npm run dev

# Server will start on http://localhost:3000
```

### Start Frontend Development Server

```bash
# In a new terminal, navigate to frontend directory
cd frontend
npm run dev

# Frontend will start on http://localhost:5173
```

## Next Steps

- [Quick Start Guide](quick-start.md) - Learn the basics
- [API Configuration](api-keys.md) - Set up API keys for enhanced features
- [Importing Trades](../usage/importing-trades.md) - Start importing your trades

## Troubleshooting

### Database Connection Error

```bash
# Check if PostgreSQL is running
sudo systemctl status postgresql

# Check connection
psql -h localhost -U tradetally_user -d tradetally_db -c "SELECT 1;"
```

### Port Already in Use

```bash
# Find process using port 3000
lsof -i :3000

# Kill the process
kill -9 <PID>
```

### NPM Installation Fails

```bash
# Clear npm cache
npm cache clean --force

# Delete node_modules and reinstall
rm -rf node_modules package-lock.json
npm install
```
