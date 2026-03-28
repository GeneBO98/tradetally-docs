# Behavioral Analytics

Identify destructive trading patterns, understand your psychological tendencies, and improve decision-making with data-driven behavioral insights.

## Overview

Behavioral Analytics is a **Pro feature** that examines your completed trades to detect harmful psychological patterns such as revenge trading, overconfidence, loss aversion, and emotional decision-making. Rather than relying on self-reporting, TradeTally automatically analyzes your trade history to surface patterns you might not notice on your own.

!!! info "Pro Feature"
    Behavioral Analytics requires a Pro tier subscription. Self-hosted users must also set `FEATURES_BEHAVIORAL_ANALYTICS_ENABLED=true` in their environment configuration.

Navigate to **Metrics** > **Behavioral** to access the full behavioral analytics dashboard.

## Behavioral Patterns Detected

TradeTally's detection engine runs across four primary behavioral categories. Each pattern is scored by severity (low, medium, high) and confidence level.

### Revenge Trading

Revenge trading occurs when a trader enters new positions impulsively after a significant loss, attempting to recover the money quickly. TradeTally detects this by analyzing:

- **Trigger events** -- significant losses within a rolling two-hour window
- **Follow-up trades** -- positions opened shortly after a loss that show increased position sizing
- **Position size escalation** -- whether the follow-up trades used larger monetary amounts compared to normal activity
- **Time proximity** -- how quickly after a loss the next trade was entered

When a revenge trading event is detected, the system records the trigger loss, all associated revenge trades, the cumulative P&L of those trades, and a recommended cooling-off period.

### Overconfidence

Overconfidence analysis looks for patterns where a streak of winning trades leads to riskier behavior. The system evaluates:

- Position size volatility after winning streaks
- Whether position sizes increase disproportionately following wins
- The performance of trades taken during overconfident periods versus baseline performance

### Loss Aversion

Loss aversion detection identifies situations where traders hold losing positions too long while cutting winners short. The analysis includes:

- Average hold time for winning trades versus losing trades
- Distribution of trade durations by outcome
- Whether exit timing correlates with the magnitude of unrealized losses
- Comparison of actual exits against optimal exit points (when Finnhub API data is available)

### Emotional Trading

The system also tracks broader emotional trading indicators by correlating trade outcomes with:

- Time of day patterns (trading outside of optimal hours)
- Frequency of trades in short windows (overtrading)
- Pattern deviations from your established trading personality

## Active Alerts

When the system identifies a behavioral pattern in real time, it generates alerts displayed at the top of the dashboard. Alerts are categorized into three levels:

| Alert Type | Description |
|---|---|
| **Warning** | A recognized pattern has been detected, such as a recent revenge trade sequence |
| **Recommendation** | A suggestion to adjust behavior, such as taking a break after consecutive losses |
| **Blocking** | A high-severity alert indicating dangerous behavior that may warrant stopping for the day |

Each alert can be acknowledged to dismiss it from the active alerts panel.

## Analyze Historical Trades

Click the **Analyze Historical Trades** button to run a full scan of your completed trade history. This process:

1. Clears any previously detected patterns for the selected date range
2. Scans all completed trades ordered by entry time
3. Identifies significant losses that could serve as revenge-trade triggers
4. Detects follow-up trades within the two-hour revenge window
5. Scores overconfidence episodes based on position size changes after win streaks
6. Evaluates loss aversion by comparing hold times across winners and losers

!!! tip "Re-run After Importing Trades"
    After importing a new batch of historical trades, run the historical analysis again to ensure all patterns are detected across the full dataset.

## Trading Personality Profiling

The personality profiling section classifies your trading style based on actual behavior. A minimum of **20 completed trades** is required before a profile can be generated. The system scores your trading across four personality archetypes:

- **Scalper** -- short hold times, high frequency, small per-trade gains
- **Momentum** -- trades aligned with trend direction, moderate hold times
- **Mean Reversion** -- entries against prevailing moves, targeting reversals
- **Swing** -- longer hold times, larger per-trade targets

Each archetype receives a percentage score, and you can click any archetype to view the trades that matched that strategy pattern. A confidence rating and overall performance score are displayed alongside the primary personality classification.

## Health Analytics

Navigate to **Metrics** > **Health** to access the Health Analytics dashboard. This feature correlates physical health metrics with trading performance across four key indicators:

- **Average Heart Rate** -- resting heart rate trends during trading periods
- **Average Sleep Score** -- sleep quality score out of 100
- **Average Sleep Hours** -- total hours of sleep per night
- **Average Stress Level** -- calculated stress percentage

The **Performance by Health Condition** table breaks down your trading results (trade count, win rate, average P&L, total P&L) across different health states. Use the **Sync Health to Trades** button to correlate health data with trade outcomes.

!!! note "Health Data Sources"
    Health data is collected from entries in the TradeTally health tracking system. The system analyzes 90 days of data by default, including both sleep metrics and heart rate readings.

The **Personalized Health Insights** section provides AI-generated recommendations based on correlations found between your health data and trading performance. Each insight includes a confidence score and an actionable flag.

## Partial Exit Analytics

Navigate to **Metrics** > **Partial Exits** to analyze how your scaling-out strategy performs across trades. This view requires trades with at least two exit executions.

The dashboard displays:

- **Trades Analyzed** -- total number of trades with partial exits
- **Max Partial Levels** -- the highest number of partial exit levels found
- **Partial Indices** -- the number of distinct exit levels being tracked

You can filter by minimum and maximum partial levels, as well as set a minimum number of eligible trades per level. The analytics table shows performance metrics for each partial exit index, helping you determine whether your scaling strategy is adding or reducing value.

## Monthly Performance

Navigate to **Metrics** > **Monthly Performance** to compare your trading results month-by-month. Select a year from the dropdown to view:

- Year summary statistics across all months
- Month-over-month P&L comparison
- Win rate trends by month
- Trade volume distribution throughout the year

This view helps identify seasonal patterns in your trading performance and highlights your strongest and weakest months.

## Year Wrapped

The **Year Wrapped** feature provides an annual summary of your trading activity in a visual, presentation-style format. Access it from the dashboard or navigate directly to **Metrics** > **Year Wrapped**.

Year Wrapped displays:

- Total trades executed during the year
- Overall P&L performance
- Key milestones and achievements
- Performance highlights and statistics

!!! note "Data Requirement"
    Year Wrapped requires at least one completed trade in the selected year. If no data is available, you will be prompted to import trades.

## Behavioral Settings

The behavioral analytics system respects per-user settings stored in the `behavioral_settings` table. These settings control:

- Whether revenge trading detection is active
- Sensitivity thresholds for pattern detection
- Cooling period recommendations after detected events

Settings are managed through the behavioral analytics dashboard and persist across sessions.

## Configuration for Self-Hosted Users

To enable behavioral analytics on a self-hosted instance, add the following to your `.env` file:

```bash
FEATURES_BEHAVIORAL_ANALYTICS_ENABLED=true
```

!!! warning "Pro Tier Required"
    Even with the feature flag enabled, users must have Pro tier access to use behavioral analytics. The feature flag controls whether the feature is available on the instance at all.
