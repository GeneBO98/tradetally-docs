# Cashflow & Equity Tracking

Track deposits, withdrawals, and account balances to maintain a complete picture of your trading capital over time.

## Overview

The Cashflow feature lets you record financial transactions against your brokerage accounts and view daily cash movement. Combined with Equity History snapshots, you get a full view of how your account value changes -- not just from trading P&L, but from all capital flows in and out of your accounts.

Navigate to **Accounts** > **Cashflow** to access the cashflow dashboard.

## Cashflow Dashboard Layout

The cashflow page is divided into two sections:

- **Left panel (2/3 width)** -- date filters, summary cards, and the daily cashflow table
- **Right panel (1/3 width)** -- account management, transaction entry form, and recent transactions

## Adding Transactions

Use the **Add Transaction** form on the right side of the cashflow page to record capital movements.

1. Select an **Account** from the dropdown (you must have at least one account configured)
2. Choose the **Type**:
    - **Deposit** -- money added to the account
    - **Withdrawal** -- money removed from the account
3. Enter the **Amount** in dollars
4. Set the **Date** of the transaction
5. Optionally add a **Description** (for example, "Monthly deposit" or "Tax withdrawal")
6. Click **Add Transaction**

!!! tip "Record All Capital Movements"
    For accurate equity tracking, record every deposit and withdrawal -- not just trades. This ensures your balance calculations reflect real account values rather than just trading P&L.

## Summary Cards

When an account is selected and cashflow data is available, five summary cards appear at the top:

| Metric | Description |
|---|---|
| **YTD Deposits** | Total deposits for the current calendar year |
| **YTD Withdrawals** | Total withdrawals for the current calendar year |
| **Current Balance** | Calculated current account balance |
| **Total Inflow** | Sum of all inflows in the filtered date range |
| **Total Outflow** | Sum of all outflows in the filtered date range |

## Daily Cashflow Table

The main table displays one row per trading day with the following columns:

- **Date** -- the trading day
- **Inflow** -- deposits and other credits for that day
- **Outflow** -- withdrawals and other debits for that day
- **Net** -- the difference between inflow and outflow
- **Balance** -- the running account balance as of that day

Use the date filter at the top to narrow the view to a specific period. Click **Apply** to update the table, or **Reset** to return to the default range.

## Account Management

The right panel includes an **Accounts** section where you can manage your brokerage accounts.

### Creating an Account

1. Click **Add Account** in the accounts panel
2. Enter the **Account Name** (for example, "Schwab Main" or "IBKR Paper")
3. Optionally specify the **Broker** associated with the account
4. Set the **Initial Balance** -- the starting equity when you began tracking
5. Optionally mark the account as **Primary**
6. Click **Save**

### Editing and Deleting Accounts

- Click the pencil icon on any account card to edit its details
- Click the trash icon to delete an account

!!! warning "Deleting Accounts"
    Deleting an account removes the account record and its associated cashflow data. Trades linked to the account are not deleted but will no longer be associated with that account identifier.

### Selecting an Account

Click on any account card to select it. The selected account is highlighted with a ring indicator, and the cashflow table updates to show data for that account only.

## Recent Transactions

The **Recent Transactions** section below the transaction form shows the five most recent transactions for the selected account. Each entry displays:

- Transaction type (deposit or withdrawal) with color coding
- Amount
- Date and optional description
- A delete button to remove the transaction

## Equity History

Navigate to **Settings** > **Equity History** to track your account equity over time using a calendar-based interface.

### Recording Equity Snapshots

The equity history page displays a monthly calendar where each day can hold an equity snapshot.

1. Navigate to the desired month using the arrow buttons
2. Click on any day in the calendar
3. Enter your account equity amount for that date
4. Save the snapshot

Days with recorded equity values display the amount in green. A green dot indicator appears in the corner of days that have snapshots. Today's date is marked with a blue dot.

!!! info "One Snapshot Per Day"
    Each date can hold only one equity snapshot per user. If you save a new value for a date that already has a snapshot, the existing value is updated.

### Monthly Summary

Below the calendar, three summary cards display:

- **Month Start** -- equity value at the beginning of the displayed month
- **Month End** -- equity value at the end of the displayed month (or latest available)
- **Monthly Change** -- the difference between start and end values

### Updating Current Equity

You can also update your current equity through the settings page. When you update current equity, TradeTally automatically creates a snapshot for today's date, keeping your equity history up to date without manual calendar entries.

## K-Ratio Calculation

The K-Ratio measures the consistency of your equity growth by comparing average returns against their volatility. It is calculated from your equity snapshots.

**Formula:** K-Ratio = Average Daily Return / Standard Deviation of Daily Returns

The calculation requires:

- At least **2 equity snapshots** (3 or more recommended for meaningful results)
- Snapshots within the analysis period (default: 90 days)

| K-Ratio Value | Interpretation |
|---|---|
| Above 1.0 | Strong, consistent equity growth |
| 0.5 to 1.0 | Moderate consistency |
| 0.0 to 0.5 | Low consistency, high volatility relative to returns |
| Below 0.0 | Negative average returns |

!!! note "Data Requirements"
    If fewer than 2 equity snapshots exist in the selected period, the K-Ratio will display as unavailable. Add more equity snapshots to enable this calculation.

The K-Ratio endpoint also returns supporting data including the number of data points used, the average return, standard deviation, and the date range of the analysis.

## How Cashflow Connects to Account Management

Cashflow data ties directly to accounts configured in TradeTally. The relationship works as follows:

- Each **account** has an initial balance and an associated broker
- **Transactions** (deposits and withdrawals) are recorded against a specific account
- The **daily cashflow table** aggregates all transactions by date for the selected account
- **Equity snapshots** provide point-in-time account values independent of transaction tracking
- The **K-Ratio** uses equity snapshots to measure growth consistency

Together, these features give you a complete financial picture: how much capital you have deployed, how it moves over time, and how consistently your equity grows.

## Equity Curve Visualization

The equity curve is available on the main analytics dashboard and uses equity snapshot data to render a line chart of your account value over time. The curve helps you visually identify:

- Drawdown periods where equity declined
- Recovery speed after drawdowns
- Overall growth trajectory
- The impact of deposits and withdrawals on total equity

!!! tip "Regular Snapshots for Better Charts"
    Record equity snapshots at regular intervals (daily or weekly) for the smoothest and most informative equity curve. Sparse data points produce a less useful visualization.
