# Calendar

Visualize your trading performance across time with a color-coded calendar view.

## Overview

The **Calendar** page displays your trading activity as a year-at-a-glance heatmap, with each day colored by its net profit or loss. Expand any month into a detailed weekly grid to analyze day-by-day results, or click individual days to drill down into the specific trades that contributed to that day's performance.

## Yearly Overview

The default view shows all 12 months of the selected year as a grid of mini-calendars. Each mini-calendar displays:

- Month name with an **Open** button to expand
- A 7-column grid (Sunday through Saturday) with each day colored by P&L
- Green shading for profitable days, red shading for losing days
- Neutral coloring for days with no trades

### Year Navigation

Use the left and right arrow buttons next to the year label to switch between years. The selected year persists in your browser's local storage and in the URL query parameter, so bookmarking a specific year works as expected.

## Expanded Month View

Click **Open** on any mini-calendar to expand it into a detailed month view. The expanded view shows a weekday-only grid (Monday through Friday) with a weekly P&L summary column.

### Month Statistics

Three summary cards appear at the top of the expanded month:

| Card | Description |
|------|-------------|
| Monthly P&L | Net profit and loss for the displayed month |
| Avg Initial Risk | Average dollar risk across trades with stop losses set |
| Year To Date | Cumulative P&L through the displayed month |

### Weekly Grid

The expanded grid displays five weekday columns plus a weekly total column:

- Each day cell shows the date, dollar P&L (or R-value), and trade count
- The rightmost column shows the aggregated weekly P&L or R-value
- Navigate between months using the left and right arrows next to the month name

### Color Coding

Days are color-coded based on their net P&L:

- **Green** -- Profitable day (darker green indicates higher profit)
- **Red** -- Losing day (darker red indicates larger loss)
- **Neutral/Gray** -- No trades on this day

The color intensity scales with the magnitude of the day's P&L, providing an immediate visual sense of which days were significantly positive or negative.

## R-Value Toggle

Click the **Show R-Value** button in the top-right corner to switch the calendar display from dollar P&L to R-multiples. This is useful for evaluating performance in risk-adjusted terms rather than absolute dollars.

!!! tip "When to Use R-Value Mode"
    R-value mode is most useful when your position sizes vary significantly between trades. A $500 profit means different things depending on whether you risked $100 or $1,000. R-value normalizes this by expressing results as multiples of your initial risk.

When R-value mode is active:

- Day cells display R-multiples instead of dollar amounts
- Weekly totals show aggregated R-values
- The monthly summary card switches to "Performance in R"
- The toggle button text changes to "Show P&L ($)" to switch back

!!! note "R-Value Availability"
    R-values require trades with stop loss data. Days containing trades without stop losses show dollar P&L even in R-value mode, or display "No R data" for individual trades.

## Day Detail Modal

Click any day with trades to open a modal listing every trade that contributed to that day's P&L. The modal shows:

- **Symbol** -- Ticker traded
- **Side** -- Long or short badge
- **Partial Exits** -- Indicator if the trade had multiple exits, with exit count
- **P&L** -- Dollar amount or R-value depending on the active toggle
- **Risk Amount** -- Initial risk in dollars (if stop loss was set)

The modal footer displays:

- Total P&L (or total R) for the day
- Average initial risk across trades with stop loss data

Click any trade row to navigate directly to that trade's detail page. The modal can be expanded to full-screen using the expand button for easier viewing when many trades occurred on a single day.

## Account Filter Integration

The calendar respects the global account filter. If you have multiple trading accounts, select a specific account from the global filter to view calendar data for only that account. Selecting "All Accounts" shows combined data.

When you change the account filter, the calendar automatically refreshes to reflect the filtered data.

## Using the Calendar for Pattern Recognition

The calendar is one of the most powerful tools for identifying patterns in your trading behavior. Here are practical ways to use it:

### Identify Your Best and Worst Days

- **Scan the yearly overview** for clusters of green or red days
- Look for patterns around specific days of the week (e.g., consistently red Mondays)
- Notice if performance degrades toward the end of the week

### Spot Overtrading Periods

- Days with unusually high trade counts may indicate overtrading
- Compare trade count against P&L -- high trade counts with poor results suggest undisciplined trading

### Track Recovery After Losses

- After a red day, observe how subsequent days perform
- Consistent red clusters may indicate revenge trading or emotional decision-making
- A quick return to green suggests good emotional discipline

### Monthly and Weekly Trends

- Use the weekly P&L column to identify winning and losing weeks at a glance
- The monthly summary card provides a quick read on whether the month is net positive
- Year-to-date tracking shows whether cumulative progress is on track

### Seasonal Patterns

- Compare the same months across different years using the year navigation
- Some traders perform better during earnings season or specific market conditions
- The yearly heatmap makes seasonal patterns visually obvious

!!! tip "Combine with the Journal"
    Use the calendar alongside the [Journal](../features/analytics.md) to correlate your best and worst days with market conditions, emotional state, and trading notes. Days that stand out on the calendar are worth reviewing in detail.

## Navigation from Other Pages

The calendar is accessible from the main navigation bar. It also appears as part of the onboarding tour (step 5 of 5), introduced as the "Performance Calendar" where users learn to read green days, red days, and everything in between.
