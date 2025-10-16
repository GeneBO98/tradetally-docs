# Dashboard

The Dashboard provides a comprehensive overview of your trading performance and activity.

## Overview

The Dashboard is your central hub for monitoring:

- Current trading performance
- Open positions with real-time P&L
- Recent trade activity
- Key performance metrics
- Quick statistics and charts

## Main Sections

### Performance Summary

**Total P&L**:
- Lifetime profit/loss across all trades
- Color-coded (green for profit, red for loss)
- Percentage change indicator

**Win Rate**:
- Percentage of winning trades
- Total winners vs. losers
- Visual indicator bar

**Average Trade**:
- Mean P&L per trade
- Standard deviation
- Helps identify consistency

**Best/Worst Trade**:
- Highest profit single trade
- Largest loss single trade
- Click to view trade details

### Open Positions

Real-time tracking of active positions:

**Position Details**:
- Symbol and quantity
- Entry price and date
- Current market price (live)
- Unrealized P&L (real-time)
- Position duration

**Features**:
- Auto-refresh every 15 seconds
- Color-coded P&L
- Click to view full trade details
- Quick close position action

!!! note "Real-time Data"
    Requires `FINNHUB_API_KEY` configured for live market prices

### Recent Activity

Shows your latest trades:

- Last 10 trades
- Entry and exit times
- P&L for each trade
- Quick filters by profitability
- Click any trade to edit

### Performance Charts

**P&L Over Time**:
- Daily, weekly, or monthly view
- Cumulative P&L line chart
- Trend indicators
- Interactive tooltips

**Trade Distribution**:
- Winners vs. losers pie chart
- Break-even trades
- Visual performance breakdown

**Hold Time Analysis**:
- Average hold duration
- Performance by hold time
- Quick vs. slow trades

## Key Metrics

### Trading Statistics

**Total Trades**:
- Count of all completed trades
- Open positions not included
- Filterable by date range

**Win Rate**:
- Percentage of profitable trades
- Industry standard metric
- Target: >50% for most strategies

**Average Win/Loss**:
- Mean profit on winning trades
- Mean loss on losing trades
- Profit factor calculation

**Max Drawdown**:
- Largest peak-to-trough decline
- Risk management indicator
- Recovery time shown

### Advanced Metrics

**Sharpe Ratio**:
- Risk-adjusted returns
- Higher is better
- Benchmark: >1.0 good, >2.0 excellent

**Profit Factor**:
- Gross profit / gross loss
- Measures overall profitability
- Target: >1.5

**Average Hold Time**:
- Mean duration of trades
- By strategy and symbol
- Identifies optimal timeframes

**Consistency Score**:
- Standard deviation of returns
- Lower is more consistent
- Helps identify reliable strategies

## Filters and Date Ranges

### Date Range Picker

Select analysis period:

- Today
- Last 7 days
- Last 30 days
- Last 90 days
- This month
- Last month
- This year
- Custom range

### Symbol Filters

Filter by specific symbols:

- Search by ticker
- Multi-select supported
- Quick clear all

### Strategy Filters

Filter by trading strategy:

- Breakouts
- Momentum
- Scalping
- Swing trading
- And more...

### Tag Filters

Filter by custom tags:

- User-defined tags
- Multi-select support
- Combine multiple filters

## Refresh and Updates

### Auto-Refresh

Dashboard automatically refreshes:

- Open positions: Every 15 seconds
- Recent activity: On new trade
- Charts: On filter change

### Manual Refresh

Click refresh icon to:

- Update all data immediately
- Fetch latest market prices
- Refresh calculations

## Customization

### Widget Layout

Customize dashboard layout:

- Drag and drop widgets
- Show/hide sections
- Resize widgets
- Save preferences

### Metric Preferences

Choose calculation method:

- Average vs. Median
- Include/exclude fees
- Time zone preferences
- Currency display

### Theme Options

- Light mode
- Dark mode (default)
- Auto-detect system preference

## Mobile View

Dashboard is fully responsive:

- Optimized for mobile devices
- Touch-friendly interface
- Swipe gestures
- Condensed layout

## Quick Actions

### From Dashboard

**Add Trade**:
- Quick add button
- Opens trade form
- Pre-fills current date

**Import Trades**:
- Jump to import page
- Recent imports shown
- One-click re-import

**View Analytics**:
- Deep dive into metrics
- Advanced charts
- Custom reports

## Best Practices

### Daily Routine

1. **Morning Check**: Review open positions and overnight changes
2. **During Trading**: Monitor real-time P&L on open positions
3. **End of Day**: Review completed trades and update journal
4. **Weekly Review**: Analyze weekly performance and trends

### Metric Focus

**For Day Traders**:
- Win rate
- Average trade duration
- Profit factor
- Real-time P&L tracking

**For Swing Traders**:
- Max drawdown
- Average hold time
- Sharpe ratio
- Sector performance

**For Long-term Investors**:
- Total return
- Consistency score
- Portfolio allocation
- Risk-adjusted returns

## Performance Tips

### Dashboard Loading

- Limit date range for faster loading
- Use filters to reduce data
- Clear browser cache if slow
- Check network connection for real-time data

### Real-time Updates

- Ensure Finnhub API key is configured
- Check rate limits not exceeded
- Verify symbols are valid
- Monitor browser console for errors

## Troubleshooting

### Real-time Prices Not Updating

**Causes**:
- API key not configured
- Rate limits exceeded
- Invalid ticker symbols
- Network connectivity issues

**Solutions**:
- Configure `FINNHUB_API_KEY`
- Wait for rate limit reset
- Verify symbols are correct
- Check internet connection

### Dashboard Not Loading

**Causes**:
- Too much data for date range
- Backend not responding
- Database connection issues

**Solutions**:
- Reduce date range
- Check backend server status
- Verify database connection
- Clear browser cache

### Incorrect Metrics

**Causes**:
- Filters applied
- Data sync issues
- Calculation preference mismatch

**Solutions**:
- Clear all filters
- Refresh dashboard
- Check calculation settings
- Re-import trades if needed

## Next Steps

- [Analytics](analytics.md) - Deep dive into performance
- [Trade Management](../usage/trade-management.md) - Edit and organize trades
- [Importing Trades](../usage/importing-trades.md) - Add more data
