# Watchlists & Markets

Create custom watchlists, track real-time prices, set price alerts, and analyze stocks with fundamental data and valuation tools.

## Overview

The Watchlists feature is a **Pro feature** that provides a central hub for monitoring stocks you are interested in trading or investing in. You can organize symbols into multiple watchlists, view live price data, set price alerts, and access detailed stock analysis including an 8-pillar fundamental scoring system and DCF valuation calculator.

!!! info "Pro Feature"
    Watchlists, price alerts, and stock analysis are available to Pro tier users only. Free tier users will see an upgrade prompt when navigating to this section.

Navigate to **Markets** to access the watchlists dashboard.

## Markets Dashboard

The Markets page is organized into two tabs:

- **Watchlists** -- manage your watchlists and their symbols
- **Price Alerts** -- view and manage all active price alerts across your watchlists

## Creating a Watchlist

1. Navigate to **Markets**
2. Click **Create Watchlist**
3. Enter a **Name** for the watchlist
4. Optionally add a **Description**
5. Click **Save**

Each user starts with the ability to create multiple watchlists. One watchlist can be marked as **Default**, which appears first in the list and is indicated with a badge.

## Managing Watchlists

Each watchlist card displays:

- Watchlist name and description
- Number of symbols tracked
- Number of active price alerts for symbols in the watchlist

From any watchlist card you can:

- **Click** the card to open the watchlist detail view
- **Edit** to rename or update the description
- **Delete** to remove the watchlist (not available for the default watchlist)

## Adding Symbols to a Watchlist

1. Open a watchlist by clicking on its card
2. Click **Add Symbol** in the top right
3. Enter the ticker symbol (for example, AAPL, TSLA, SPY)
4. Optionally add **Notes** for the symbol (for example, "Watching for breakout above 150")
5. Click **Add**

## Watchlist Detail View

When you open a watchlist, the detail view displays a table of all symbols with the following columns:

| Column | Description |
|---|---|
| **Symbol** | Ticker symbol and any notes you added |
| **Current Price** | Latest price from market data feeds |
| **Change** | Dollar amount change from previous close |
| **% Change** | Percentage change from previous close |
| **Added** | Date the symbol was added to the watchlist |
| **Actions** | Alert, Edit, and Remove buttons |

Price data is sourced from the price monitoring system, which polls market data APIs for current quotes.

### Symbol Actions

For each symbol in the watchlist, you can:

- **Alert** -- create a price alert for the symbol
- **Edit** -- update the notes attached to the symbol
- **Remove** -- delete the symbol from the watchlist

## Price Alerts

Price alerts notify you when a symbol reaches a target price. You can create alerts from the watchlist detail view or from the **Price Alerts** tab on the Markets page.

### Creating a Price Alert

1. Click **Alert** next to any symbol in your watchlist
2. Set the **Target Price**
3. Choose the **Condition** (above or below the target)
4. Save the alert

Active alerts are counted and displayed on each watchlist card.

### Managing Alerts

The **Price Alerts** tab on the Markets page provides a consolidated view of all your active alerts across all watchlists. From here you can review, edit, or delete individual alerts.

## News Feed

When your watchlist contains symbols, a **Recent News** section appears below the symbol table. This section aggregates news articles related to the symbols in your watchlist, providing:

- Article headlines with links to the source
- Publication date
- Source attribution

News data is fetched from the integrated news service and updates periodically.

## Earnings Data

The watchlist detail view also includes earnings information for tracked symbols. Upcoming and recent earnings dates help you stay informed about potential volatility events for the stocks you are watching.

## Stock Analysis

For deeper research on any symbol, TradeTally provides a dedicated stock analysis view. Navigate to it by searching for a symbol or clicking through from relevant screens.

### Summary Card

The analysis summary displays:

- **Current Price** -- latest market price
- **Market Cap** -- total market capitalization
- **Industry** -- the company's industry classification
- **Data Periods** -- number of years of financial data analyzed
- **Last Updated** -- when the analysis was most recently refreshed

### Price Chart

An interactive price chart displays historical price action for the symbol, allowing you to visualize trends and key price levels.

### 8 Pillars Analysis

The core of the stock analysis is the **8 Pillars Analysis**, based on Paul Gabrail's value investing methodology. Each pillar evaluates a different fundamental aspect of the company:

| Pillar | Focus Area |
|---|---|
| Pillar 1 | Revenue consistency and growth |
| Pillar 2 | Earnings quality and stability |
| Pillar 3 | Balance sheet strength |
| Pillar 4 | Cash flow generation |
| Pillar 5 | Debt management |
| Pillar 6 | Return on equity and capital |
| Pillar 7 | Dividend history and sustainability |
| Pillar 8 | Valuation relative to intrinsic value |

Each pillar displays a pass or fail status along with calculation details when expanded. A summary at the bottom shows the total **Pillars Passed** out of 8.

!!! tip "Using the 8 Pillars"
    A higher number of pillars passed generally indicates a more fundamentally sound company. However, this is one tool among many -- always combine pillar analysis with your own research and trading plan.

### Financial Statement Tabs

Below the pillars, a tabbed section provides access to the company's financial statements:

- Income statement data
- Balance sheet data
- Cash flow statement data

These statements show multiple periods of historical data for trend analysis.

### DCF Valuation Calculator

The **DCF (Discounted Cash Flow) Valuation** section lets you estimate the intrinsic value of a stock by adjusting key assumptions:

- Growth rate projections
- Discount rate
- Terminal value assumptions

The calculator uses the company's financial data as a starting point and allows you to modify inputs to explore different valuation scenarios.

## Stock Screener

Navigate to **Investments** to access the **Stock Screener** tab. The screener allows you to scan for stocks that meet specific fundamental criteria based on the 8 Pillars system.

### Running a Scan

1. Select the **Investments** page
2. Click the **Stock Screener** tab
3. Configure your pillar filter criteria using the filter chips
4. Run the scan to find matching stocks

Scan results are displayed in a table showing each stock's pillar scores and overall pass count. You can click through to the full stock analysis for any result.

### Holdings Tab

The Investments page also includes a **Holdings** tab where you can track long-term investment positions separately from active trades. Click **Add Position** to record a new holding with its symbol, entry price, and quantity.

## Adding to Holdings from Analysis

When viewing a stock analysis, click **Add to Holdings** in the top right to quickly add the stock as a tracked holding with the current price pre-filled.

## Configuration Notes

!!! note "Market Data APIs"
    Real-time price data requires a configured Finnhub API key. The stock analysis and 8 Pillars features use Alpha Vantage for financial data. Free API tiers have rate limits -- see the deployment documentation for details on API configuration.
