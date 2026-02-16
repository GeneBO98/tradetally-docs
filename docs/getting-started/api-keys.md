# API Key Configuration

TradeTally integrates with several external APIs to provide enhanced features. This guide will help you configure these APIs.

## Overview

| API | Purpose | Free Tier | Self-Hosted |
|-----|---------|-----------|-------------|
| Finnhub | Real-time quotes, CUSIP resolution, sector analysis | Limited (60 calls/min) | **Basic plan required for full features** |
| Alpha Vantage | Chart visualization (fallback) | 25 calls/day | Optional |
| OpenFIGI | CUSIP resolution | 25,000/month | Recommended |
| Various AI Providers | AI recommendations | Varies | Optional |
| Schwab | Automatic trade syncing | Free (requires developer account) | Optional |
| IBKR | Automatic trade syncing | Free (requires Flex Query setup) | Optional |

## Finnhub API (Required for Full Features)

Finnhub provides real-time market data, CUSIP resolution, and sector analysis.

!!! warning "Self-Hosted Requirement"
    For self-hosted deployments to access all Pro features (real-time quotes, advanced charts, sector analysis), a [Finnhub Basic plan](https://finnhub.io/pricing) is required. The free tier has significant limitations.

### Setup

1. Visit [Finnhub.io](https://finnhub.io/register)
2. Sign up for an account
3. **Recommended**: Upgrade to Basic plan ($0-20/month depending on needs)
4. Generate an API key from your dashboard
5. Add to your `.env` file:

```env
FINNHUB_API_KEY=your_finnhub_api_key
```

### Features Enabled

- **Real-time Stock Quotes**: Live market data for open position tracking
- **Advanced Chart Data**: High-resolution candlestick charts (Basic plan+)
- **CUSIP to Ticker Resolution**: Symbol search and identification
- **Sector Analysis**: Industry-based performance breakdown
- **Rate Limiting**: Built-in rate limiting (varies by plan)
- **Free Tier**: 60 API calls/minute (limited features)
- **Basic Plan**: Enhanced limits and features for full TradeTally functionality

### Priority in System

1. Real-time quotes (primary source)
2. CUSIP resolution (primary after cache)
3. Sector data for analytics

## Alpha Vantage API (Optional)

Alpha Vantage provides chart visualization for free tier users.

### Setup

1. Visit [Alpha Vantage](https://www.alphavantage.co/support/#api-key)
2. Sign up for a free account
3. Generate an API key
4. Add to your `.env` file:

```env
ALPHA_VANTAGE_API_KEY=your_alpha_vantage_api_key
```

### Features Enabled

- **Interactive Candlestick Charts**: Visual trade analysis
- **Historical Market Data**: Intraday and daily stock prices
- **Trade Performance Overlay**: Entry/exit indicators with P&L
- **Free Tier**: 25 API calls/day, 5 calls/minute
- **Smart Caching**: Reduces API usage

!!! note
    Pro users get exclusive Finnhub access for charts with no Alpha Vantage fallback

## OpenFIGI API (Recommended)

OpenFIGI provides reliable CUSIP-to-ticker mapping using Bloomberg's database.

### Setup

1. Visit [OpenFIGI](https://www.openfigi.com/)
2. Sign up for a free account (optional but recommended)
3. Generate an API key from your account dashboard
4. Add to your `.env` file:

```env
OPENFIGI_API_KEY=your_openfigi_api_key
```

### Features Enabled

- **Reliable CUSIP Resolution**: Bloomberg's official mapping service
- **High Accuracy**: Industry-standard financial data
- **Free Tier**: 25,000 requests/month without key, unlimited with free account
- **Real Financial Data**: Actual securities database
- **Multiple Asset Types**: Stocks, bonds, options, and other securities

### Why OpenFIGI?

OpenFIGI is the **recommended CUSIP resolution method** because:

- No AI hallucinations or guessing
- Real-time access to Bloomberg's securities database
- High accuracy for all security types
- Free and reliable

## AI Provider Configuration

AI features are configured through the web interface (Settings page).

### Supported Providers

- **Anthropic Claude**: High-quality analysis and recommendations
- **OpenAI**: GPT-3.5/GPT-4 for trade analysis
- **Google Gemini**: Advanced AI with good financial knowledge
- **Ollama**: Self-hosted local AI models
- **Custom API**: Bring your own AI provider

### Setup

1. Navigate to **Settings** in TradeTally
2. Go to **AI Provider Settings**
3. Select your preferred provider
4. Enter your API key
5. Test the connection

### Features Enabled

- **AI-Powered Trading Recommendations**: Personalized analysis
- **Sector Performance Analysis**: Industry-specific insights
- **Trading Pattern Analysis**: Identify strengths and weaknesses
- **Multiple Provider Support**: Choose the best AI for your needs

!!! warning "AI CUSIP Resolution"
    AI CUSIP resolution is **disabled by default** due to reliability concerns. See the warning section below.

## AI CUSIP Resolution (Advanced Users Only)

!!! danger "Reliability Warning"
    AI CUSIP resolution is **disabled by default** and should only be enabled by advanced users who understand the limitations.

### Limitations

- **Unreliable Results**: AI models frequently return incorrect ticker mappings
- **Self-Hosted Issues**: Local models cannot access real financial databases
- **Static LLM Limitations**: Training data cutoffs cause issues with recent changes
- **Hallucination Risk**: AI may guess popular symbols for unknown CUSIPs
- **Data Integrity**: Incorrect mappings can corrupt your trade data

### When AI CUSIP Might Work

- **Perplexity AI Recommended**: Actively searches web for current mappings
- **Cloud-based AI only**: OpenAI, Anthropic Claude, Google Gemini, Perplexity
- **Manual Verification**: You verify every AI-resolved CUSIP
- **Test Environment**: You can afford incorrect data

### To Enable AI CUSIP Resolution

```env
# Only enable if you understand the risks
ENABLE_AI_CUSIP_RESOLUTION=true
```

### Recommended Alternative

Instead of AI CUSIP resolution, use:

1. **OpenFIGI API** (reliable, free, industry standard) ✓
2. **Manual mapping** through the import interface
3. **Broker-specific formats** that include ticker symbols

## Broker Sync Configuration

TradeTally supports automatic trade syncing from supported brokers. All broker sync connections require the `BROKER_ENCRYPTION_KEY` to encrypt stored credentials.

### Encryption Key (Required for All Broker Sync)

Generate an encryption key and add it to your `.env`:

```bash
# Generate encryption key
openssl rand -hex 32
```

```env
BROKER_ENCRYPTION_KEY=your_generated_32_byte_hex_key
```

!!! warning "Security"
    The `BROKER_ENCRYPTION_KEY` is used to encrypt broker credentials and OAuth tokens stored in your database. Keep it secure and never share it. If you change this key, existing broker connections will need to be re-authenticated.

!!! danger "Missing Encryption Key"
    If `BROKER_ENCRYPTION_KEY` is not set, broker sync connections will fail with the error: `BROKER_ENCRYPTION_KEY environment variable is not set`. This applies to all brokers (IBKR, Schwab, etc.).

### Interactive Brokers (IBKR)

IBKR sync uses Flex Queries to retrieve trade data.

**Prerequisites:**

1. **IBKR Account** with Client Portal access
2. **Flex Query** configured (see [Importing Trades - IBKR](../usage/importing-trades.md) for Flex Query setup)
3. **Flex Query Token** generated in IBKR Account Management
4. **`BROKER_ENCRYPTION_KEY`** set in your `.env` file

**Setup:**

1. Log into [IBKR Client Portal](https://www.interactivebrokers.com)
2. Navigate to **Settings** > **Reporting** > **Flex Queries**
3. Create or use an existing Activity Flex Query
4. Generate a **Flex Web Service Token** under **Settings** > **Reporting** > **FlexWeb Service**
5. In TradeTally, go to **Settings** > **Broker Sync** > **Add IBKR Connection**
6. Enter your Flex Query Token and Query ID

**Features Enabled:**

- **Automatic Trade Import**: Sync trades from your IBKR account via Flex Queries
- **Scheduled Syncing**: Configure daily, hourly, or manual sync
- **Secure Credential Storage**: Flex Query tokens encrypted at rest

### Schwab

Schwab sync uses OAuth for authenticated access to trade data.

**Prerequisites:**

1. **HTTPS Domain**: Schwab requires HTTPS callback URLs
2. **Schwab Developer Account**: Register at [developer.schwab.com](https://developer.schwab.com)
3. **`BROKER_ENCRYPTION_KEY`** set in your `.env` file

**Setup:**

1. Register an app at [Schwab Developer Portal](https://developer.schwab.com)
2. Set the callback URL to: `https://your-domain.com/api/broker-sync/connections/schwab/callback`
3. Add Schwab credentials to your `.env`:

```env
SCHWAB_CLIENT_ID=your_schwab_app_client_id
SCHWAB_CLIENT_SECRET=your_schwab_app_client_secret
SCHWAB_REDIRECT_URI=https://your-domain.com/api/broker-sync/connections/schwab/callback
```

**Features Enabled:**

- **Automatic Trade Import**: Sync trades from your Schwab account
- **Scheduled Syncing**: Configure daily, hourly, or manual sync
- **Secure Token Storage**: OAuth tokens encrypted at rest

## CUSIP Resolution Priority

The system uses the following priority for CUSIP resolution:

1. **Cache**: Previously resolved mappings (fastest)
2. **Finnhub**: Symbol search API (primary)
3. **OpenFIGI**: Bloomberg's CUSIP-to-ticker API (reliable fallback)
4. **AI Fallback**: Optional, disabled by default
5. **Manual Entry**: User mapping through import interface

## Market Data Priority

### Real-time Quotes

1. **Finnhub API**: Primary source for live market data
2. **Cache**: Previously fetched quotes (1-minute cache)
3. **Fallback**: Display without real-time data if unavailable

### Chart Data

1. **Pro Users**: Finnhub Stock Candles API (150 calls/min, 1-minute precision)
2. **Free Users**: Alpha Vantage API (25 calls/day, limited precision)
3. **Cache**: Previously fetched chart data with intelligent caching

## Testing Your Configuration

### Test Finnhub Connection

```bash
curl "https://finnhub.io/api/v1/quote?symbol=AAPL&token=YOUR_API_KEY"
```

### Test Alpha Vantage Connection

```bash
curl "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=AAPL&interval=5min&apikey=YOUR_API_KEY"
```

### Test OpenFIGI Connection

```bash
curl -X POST "https://api.openfigi.com/v3/mapping" \
  -H "Content-Type: application/json" \
  -d '[{"idType":"ID_CUSIP","idValue":"037833100"}]'
```

## Rate Limiting

All APIs implement rate limiting to prevent quota exhaustion:

- **Finnhub**: 30 calls/second (built-in)
- **Alpha Vantage**: 5 calls/minute (enforced)
- **OpenFIGI**: Reasonable limits (enforced)
- **AI Providers**: Varies by provider

## Troubleshooting

### API Key Not Working

1. Verify key is correctly copied (no extra spaces)
2. Check API key is in **backend** `.env` file, not frontend
3. Restart backend server after adding keys
4. Check API provider dashboard for usage limits

### CUSIP Resolution Failing

1. Ensure `FINNHUB_API_KEY` and `OPENFIGI_API_KEY` are set
2. Check internet connectivity
3. Try manual mapping as fallback
4. Review console logs for error messages

### Real-time Quotes Not Updating

1. Verify `FINNHUB_API_KEY` is set in backend `.env`
2. Check backend server is running on port 3000
3. Verify frontend is proxying to correct backend
4. Confirm ticker symbols are valid (not CUSIPs)

## Cost Considerations

### Free Tier Limits

- **Finnhub**: 60 calls/minute (sufficient for most users)
- **Alpha Vantage**: 25 calls/day (limited but free)
- **OpenFIGI**: 25,000/month (very generous)
- **AI Providers**: Varies (check provider pricing)

### Self-Hosted vs SaaS

**Self-Hosted**:
- All Pro features included for free
- You provide your own API keys
- No subscription fees

**SaaS (tradetally.io)**:
- API keys provided by platform
- Higher rate limits
- No setup required
- $8/month (or $80/year) for Pro

## Next Steps

- [Quick Start Guide](quick-start.md) - Start using TradeTally
- [Docker Deployment](../deployment/docker.md) - Deploy with Docker
- [Features Guide](../features/dashboard.md) - Explore features
