# TradeTally Documentation

Welcome to TradeTally - a comprehensive trading journal and analytics platform that helps traders track performance, analyze patterns, and gain insights across multiple brokers.

![TradeTally Dashboard](https://github.com/user-attachments/assets/c7281791-53f6-43c4-937d-ebc9c679f32f)

## What is TradeTally?

TradeTally is a powerful trading journal and analytics platform built with Vue.js frontend and Node.js backend. Whether you're a day trader, swing trader, or long-term investor, TradeTally helps you understand your trading patterns and improve your performance.

## Key Features

- **Multi-Broker Support** - Import trades from Lightspeed, Charles Schwab, ThinkorSwim, IBKR, E*TRADE, Webull, TradeStation, TradingView, Tradovate, Questrade, Tastytrade, and more
- **Real-time Market Data** - Live stock quotes and unrealized P&L tracking
- **AI-Powered Analytics** - Personalized trading recommendations using various AI providers
- **Comprehensive Analytics** - Dashboard with P&L tracking, win rates, performance metrics
- **Trade Chart Visualization** - Interactive candlestick charts with entry/exit markers
- **Gamification & Leaderboards** - Track achievements and compete with peers
- **Behavioral Analytics** - Revenge trading detection and overconfidence tracking

## Deployment Options

### SaaS Platform
Fully hosted solution at [tradetally.io](https://tradetally.io) with subscription plans.

**Demo Account:**
- Username: demo@example.com
- Password: DemoUser25

### Self-Hosted
Free, open-source deployment with all Pro features included. Perfect for:
- Privacy-conscious users
- Personal or team use
- Complete control over your data
- No subscription fees

!!! note "API Requirements"
    For full feature access (real-time quotes, advanced charts, sector analysis), a [Finnhub.io Basic plan](https://finnhub.io/pricing) is required. Free tier available with limitations.

## Getting Started

<div class="grid cards" markdown>

- :material-download: **[Installation](getting-started/installation.md)**

    Step-by-step guide to install TradeTally from source or using Docker

- :material-rocket-launch: **[Quick Start](getting-started/quick-start.md)**

    Get up and running in minutes with our quick start guide

- :material-docker: **[Docker Deployment](deployment/docker.md)**

    Deploy TradeTally using Docker and Docker Compose

- :material-chart-line: **[Usage Guide](usage/importing-trades.md)**

    Learn how to import trades and use TradeTally features

</div>

## Community & Support

- **Forum**: Join the [TradeTally Discourse](https://forum.tradetally.io)
- **GitHub**: [GeneBO98/tradetally](https://github.com/GeneBO98/tradetally)
- **Docker Hub**: [potentialmidas/tradetally](https://hub.docker.com/r/potentialmidas/tradetally)
- **iOS TestFlight**: [Join the beta](https://testflight.apple.com/join/11shUY3t)

## Technology Stack

**Backend**: Node.js, Express, PostgreSQL
**Frontend**: Vue.js 3, Tailwind CSS, Pinia
**APIs**: Finnhub, Alpha Vantage, various AI providers
**Infrastructure**: Docker, Nginx
