# Analytics

Advanced performance analysis and insights for your trading activity.

## Overview

The Analytics page provides deep insights into your trading patterns, helping you identify strengths, weaknesses, and opportunities for improvement.

## Performance Analysis

### By Hold Time

Analyze performance across different hold durations:

- **< 1 minute**: Scalping trades
- **1-15 minutes**: Quick day trades
- **15-60 minutes**: Standard day trades
- **1-4 hours**: Extended day trades
- **4-24 hours**: Overnight positions
- **1-7 days**: Short-term swings
- **1-4 weeks**: Medium-term swings
- **1+ months**: Long-term positions

**Metrics for Each Period**:
- Total trades
- Win rate
- Average P&L
- Total profit/loss
- Best/worst trade

### By Day of Week

Identify your most profitable trading days:

- Monday through Friday analysis
- Win rate per day
- Average P&L per day
- Trade volume per day
- Best performing day highlighted

**Use Cases**:
- Avoid low-performing days
- Focus on high-win-rate days
- Identify weekly patterns
- Optimize trading schedule

### By Time of Day

Trading performance by hour:

- Market open performance
- Mid-day patterns
- Power hour (last hour)
- After-hours trading
- Heatmap visualization

### By Price Range

Performance across different price points:

- **Micro** (< $5): Penny stocks
- **Small** ($5-$20): Low-priced stocks
- **Mid** ($20-$100): Mid-range stocks
- **Large** ($100-$500): High-priced stocks
- **Mega** ($500+): Premium stocks

**Analysis**:
- Win rate by price range
- Optimal price points
- Risk patterns
- Commission impact

### By Volume

Trading patterns by volume levels:

- Low volume (< 1M)
- Medium volume (1M-10M)
- High volume (10M-50M)
- Very high volume (> 50M)

**Insights**:
- Liquidity preferences
- Slippage analysis
- Best volume ranges
- Risk assessment

## Sector Analysis

### Industry Performance

Break down performance by sector:

- Technology
- Financial
- Healthcare
- Consumer
- Energy
- Industrial
- Materials
- Real Estate
- Utilities
- Communication

**Metrics per Sector**:
- Total trades
- Win rate
- Total P&L
- Average trade
- Sector exposure

**Features**:
- Automatic sector detection via Finnhub
- Visual sector allocation
- Performance heatmap
- Sector rotation insights

!!! note "Requirements"
    Requires `FINNHUB_API_KEY` for automatic sector classification

### Top Performing Sectors

Ranked list of best sectors:

1. Highest total P&L
2. Best win rate
3. Most consistent
4. Highest average trade

### Sector Diversification

Monitor portfolio diversification:

- Sector concentration risk
- Balanced allocation
- Over/under exposed sectors
- Diversification score

## Symbol Analysis

### Top Symbols

Your most traded symbols:

- Total trades per symbol
- Win rate per symbol
- Total P&L per symbol
- Average trade size
- Hold time patterns

### Symbol Profitability

Ranked performance:

- **Top Winners**: Most profitable symbols
- **Top Losers**: Worst performing symbols
- **Most Consistent**: Stable performers
- **Most Volatile**: High variance symbols

### Symbol-Specific Metrics

Deep dive for any symbol:

- Entry/exit price patterns
- Best entry times
- Optimal hold duration
- Win rate trends over time
- Commission impact

## AI-Powered Recommendations

### Personalized Insights

Get AI-generated recommendations based on:

- Trading profile and preferences
- Historical performance
- Sector analysis
- Pattern recognition
- Risk tolerance

**Recommendation Types**:
- Strategy improvements
- Risk management tips
- Optimal entry/exit times
- Sector focus suggestions
- Performance enhancement

### Trading Psychology Analysis

AI identifies behavioral patterns:

- **Revenge Trading**: Trading after losses
- **Overconfidence**: Increasing size after wins
- **Emotional Trading**: Inconsistent patterns
- **Risk Management**: Position sizing issues

**Alerts**:
- Pattern detection notifications
- Risk warnings
- Behavioral insights
- Improvement suggestions

### Setup Requirements

Configure AI provider in Settings:

- Anthropic Claude
- OpenAI GPT
- Google Gemini
- Ollama (local)
- Custom API

## Advanced Charts

### Cumulative P&L

Track profit/loss over time:

- Daily cumulative P&L
- Trend lines
- Moving averages
- Drawdown periods
- Recovery phases

### Win Rate Trends

Monitor consistency:

- Win rate over time
- Rolling averages
- Trend analysis
- Anomaly detection

### Risk Metrics

Visualize risk patterns:

- Max drawdown chart
- Volatility over time
- Risk-adjusted returns
- Sharpe ratio trends

### Performance Distribution

Statistical analysis:

- P&L histogram
- Normal distribution overlay
- Outlier identification
- Standard deviation bands

## Comparison Tools

### Period Comparison

Compare different time periods:

- Month over month
- Quarter over quarter
- Year over year
- Custom periods

**Metrics Compared**:
- Total P&L change
- Win rate change
- Trade count change
- Average trade change

### Strategy Comparison

Compare different strategies:

- Side-by-side performance
- Risk-adjusted returns
- Consistency metrics
- Best strategy identification

### Benchmark Comparison

Compare against benchmarks:

- S&P 500 performance
- Market indices
- Custom benchmarks
- Relative performance

## Filters and Customization

### Advanced Filters

Combine multiple filters:

- Date ranges
- Symbols
- Strategies
- Tags
- Sides (long/short)
- Instrument types
- Sectors

### Metric Preferences

Customize calculations:

- **Average vs. Median**: Choose statistical method
- **Include Fees**: With/without commissions
- **Time Zones**: Local vs. market time
- **Currency**: Display currency

### Export Options

Export analytics data:

- PDF reports
- CSV data exports
- Chart images
- Custom reports

## Best Practices

### Regular Analysis

Establish routine:

- **Daily**: Quick dashboard review
- **Weekly**: Detailed performance analysis
- **Monthly**: Deep dive with AI recommendations
- **Quarterly**: Strategy review and adjustments

### Focus Areas

**For New Traders**:
- Win rate improvement
- Risk management
- Consistency building
- Psychology awareness

**For Experienced Traders**:
- Fine-tuning strategies
- Sector optimization
- Risk-adjusted returns
- Advanced pattern recognition

### Action Steps

After analysis:

1. Identify top 3 improvement areas
2. Set specific, measurable goals
3. Implement changes systematically
4. Track progress over time
5. Review and adjust regularly

## Gamification & Achievements

### Achievement System

Track milestones:

- Profit targets
- Win rate goals
- Consistency achievements
- Volume milestones

**Progress Tracking**:
- XP-based system
- Visual progress bars
- Completion status
- Reward notifications

### Leaderboards

Compete with peers:

- **All-Time P&L**: Total profit/loss
- **Monthly P&L**: Current month ranking
- **Weekly P&L**: Current week ranking
- **Best Trade**: Highest single profit
- **Consistency**: Most stable performance

**Privacy**:
- Anonymous usernames
- Optional participation
- Real names never shown

!!! note "Requirements"
    Enable with `ENABLE_GAMIFICATION=true` in backend `.env`

## Troubleshooting

### Sector Data Not Loading

**Causes**:
- Finnhub API not configured
- Rate limits exceeded
- Symbols not recognized

**Solutions**:
- Configure `FINNHUB_API_KEY`
- Wait for rate limit reset
- Verify symbol validity

### AI Recommendations Not Working

**Causes**:
- AI provider not configured
- API key invalid
- Insufficient trade data

**Solutions**:
- Configure AI provider in Settings
- Verify API key is correct
- Import more trades for analysis

### Charts Not Displaying

**Causes**:
- No data for selected period
- Filters too restrictive
- Browser compatibility

**Solutions**:
- Expand date range
- Clear filters
- Try different browser
- Check browser console

## Next Steps

- [Dashboard](dashboard.md) - Overview of performance
- [Trade Management](../usage/trade-management.md) - Edit trades
- [API Configuration](../getting-started/api-keys.md) - Enable advanced features
