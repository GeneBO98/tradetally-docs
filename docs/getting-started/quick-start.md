# Quick Start Guide

Get up and running with TradeTally in minutes.

## First Run

### 1. Create Admin Account

1. Navigate to `http://localhost:5173`
2. Click "Sign Up" and create your account
3. The first user automatically becomes admin
4. If email is not configured, you'll be automatically verified

### 2. Configure Trading Profile (Optional)

Enhance AI recommendations by configuring your trading profile:

1. Go to **Settings** → **Trading Profile**
2. Select your trading strategies:
    - Breakouts
    - Momentum
    - Scalping
    - Mean reversion
    - And more...
3. Choose your trading styles:
    - Day trading
    - Swing trading
    - Position trading
4. Set your risk tolerance and experience level
5. Configure preferred sectors and markets

### 3. Import Your First Trades

1. Go to the **Import** tab
2. Select your broker format:
    - Lightspeed
    - Charles Schwab
    - ThinkorSwim
    - Interactive Brokers
    - E*TRADE
    - Generic CSV
3. Upload your CSV file
4. Review the preview
5. Click **Import** to confirm

### 4. View Your Analytics

**Dashboard**:
- Overview of your trading performance
- Real-time open positions with P&L
- Recent trade activity
- Quick statistics

**Analytics**:
- Performance by hold time (< 1 min to 1+ months)
- Performance by day of week
- Performance by price ranges and volume
- Sector performance analysis
- AI-powered recommendations

**Charts**:
- Interactive candlestick charts
- Entry/exit markers
- P&L visualization
- Technical indicators

## Key Features

### Multi-Broker Support

TradeTally supports importing trades from various brokers. Each broker has specific CSV format requirements:

- **Lightspeed**: Full FIFO trade matching, commission tracking
- **Charles Schwab**: Uses calculated P&L, wash sale detection
- **ThinkorSwim**: Standard CSV export
- **IBKR**: Activity Statement CSV
- **E*TRADE**: Transaction history CSV

### CUSIP Resolution

If your broker uses CUSIP codes instead of ticker symbols:

1. System automatically attempts to resolve CUSIPs during import
2. Manual resolution available at **Import** → **Resolve Unresolved CUSIPs**
3. Add custom CUSIP-to-ticker mappings
4. Delete incorrect mappings

### Real-time Market Data

With Finnhub API configured:

- Live stock quotes for open positions
- Unrealized P&L tracking
- Real-time price updates
- Market data integration

### AI-Powered Recommendations

With AI provider configured:

1. Navigate to **Analytics**
2. Click **AI Recommendations**
3. Get personalized insights based on:
    - Your trading profile
    - Historical performance
    - Sector analysis
    - Pattern recognition

## Registration Control

TradeTally includes flexible registration modes for different deployment scenarios:

### Open Registration (Default)

```env
REGISTRATION_MODE=open
```
- Anyone can sign up immediately
- Best for personal use or open communities

### Admin Approval Required

```env
REGISTRATION_MODE=approval
```
- Users register but need admin approval
- Admins approve via command line:

```bash
cd backend
node scripts/approve-user.js user@example.com
```

### Registration Disabled

```env
REGISTRATION_MODE=disabled
```
- No new registrations allowed
- Signup forms hidden

## Common Workflows

### Daily Trading Routine

1. **Morning**: Check dashboard for open positions
2. **During Trading**: Import new trades as they complete
3. **End of Day**: Review performance metrics
4. **Weekly**: Analyze patterns and get AI recommendations

### Performance Analysis

1. **Filter by Date Range**: Use date picker to focus on specific periods
2. **Analyze by Hold Time**: Identify your optimal trade duration
3. **Check Day of Week**: Find your most profitable days
4. **Review Sector Performance**: Focus on best-performing sectors

### Managing Trades

- **Edit Trades**: Click any trade to edit details
- **Add Tags**: Categorize trades by setup, strategy, etc.
- **Add Notes**: Document your thought process
- **Attach Files**: Upload screenshots or charts

## Next Steps

- [API Configuration](api-keys.md) - Set up external APIs
- [Docker Deployment](../deployment/docker.md) - Deploy with Docker
- [Features Guide](../features/dashboard.md) - Explore all features
- [Importing Trades](../usage/importing-trades.md) - Advanced import options
