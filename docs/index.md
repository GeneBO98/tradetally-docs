# TradeTally Documentation

Welcome to TradeTally, a trading journal and analytics platform for tracking performance, reviewing execution, and importing data across multiple brokers.

![TradeTally Dashboard](https://github.com/user-attachments/assets/c7281791-53f6-43c4-937d-ebc9c679f32f)

## What is TradeTally?

TradeTally combines trade journaling, performance analytics, charts, broker imports, watchlists, and AI-assisted review in one self-hosted or hosted platform.

## Key Features

- **Multi-Broker Support** - Import trades from Lightspeed, Charles Schwab, ThinkorSwim, IBKR, E*TRADE, Firstrade, Webull, TradeStation, TradingView, Tradovate, Questrade, Tastytrade, ProjectX, and more
- **Real-time Market Data** - Live stock quotes and unrealized P&L tracking
- **AI-Powered Analytics** - Personalized trading recommendations with configurable AI providers
- **Comprehensive Analytics** - Dashboard, win rate, P&L, hold time, sector, and behavioral breakdowns
- **Trade Chart Visualization** - Interactive candlestick charts with entry and exit markers
- **Gamification & Leaderboards** - Achievements, rankings, and milestones
- **Behavioral Analytics** - Revenge trading, overconfidence, and other pattern analysis

## Deployment Options

### SaaS Platform

Fully hosted solution at [tradetally.io](https://tradetally.io).

**Demo Account:**
- Username: demo@example.com
- Password: DemoUser25

### Self-Hosted

Free, open-source deployment with all Pro features unlocked by default. For nearly all self-hosted installs, Docker is the recommended path.

!!! note "API Requirements"
    For full feature access such as real-time quotes, advanced charts, and sector analysis, configure external API keys after install. See [API Configuration](getting-started/api-keys.md).

## Getting Started

<div class="grid cards" markdown>

- :material-rocket-launch: **[Quick Start (Docker)](deployment/docker.md)**

    Recommended for most self-hosted users. Includes the interactive `scripts/quick-deploy.sh` setup flow.

- :material-tools: **[Native Installation](getting-started/installation.md)**

    Source-based install for local development or custom non-Docker environments.

- :material-key-variant: **[API Configuration](getting-started/api-keys.md)**

    Configure Finnhub, OpenFIGI, broker sync, and AI providers.

- :material-backup-restore: **[Backup & Restore](deployment/backup.md)**

    Learn how to back up databases, uploads, and runtime data safely.

</div>

## Community & Support

- **Forum**: [TradeTally Discourse](https://forum.tradetally.io)
- **GitHub**: [GeneBO98/tradetally](https://github.com/GeneBO98/tradetally)
- **Docker Hub**: [potentialmidas/tradetally](https://hub.docker.com/r/potentialmidas/tradetally)
- **iOS TestFlight**: [Join the beta](https://testflight.apple.com/join/11shUY3t)

## Technology Stack

**Backend**: Node.js, Express, PostgreSQL  
**Frontend**: Vue.js 3, Tailwind CSS, Pinia  
**APIs**: Finnhub, Alpha Vantage, OpenFIGI, configurable AI providers  
**Infrastructure**: Docker, Nginx
