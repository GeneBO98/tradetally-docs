# Broker Sync

Automatically import trades from your brokerage accounts via API instead of manual CSV uploads.

## Overview

Broker Sync connects directly to your brokerage account and pulls in trade data automatically. This eliminates repetitive CSV exports and keeps your TradeTally dashboard current with minimal manual work.

Currently supported brokers:

- **Interactive Brokers (IBKR)** -- via Flex Query API
- **Charles Schwab** -- via OAuth API

Navigate to **Settings** > **Broker Sync** to manage your connections.

## Prerequisites

Before setting up any broker connection, configure this environment variable on your server:

| Variable | Purpose | How to generate |
|----------|---------|-----------------|
| `BROKER_ENCRYPTION_KEY` | Encrypts stored broker credentials at rest | `openssl rand -hex 32` |

!!! warning
    Without `BROKER_ENCRYPTION_KEY`, broker sync will not function.

## Interactive Brokers (IBKR)

### Setting Up a Flex Query

1. Log in to the [IBKR Client Portal](https://www.interactivebrokers.com/sso/Login).
2. Navigate to **Performance & Reports** > **Flex Queries**.
3. Create an **Activity Flex Query** that includes the **Trades** section.
4. Save the query and copy the **Query ID**.
5. Open **Configure Flex Web Service** and copy the **Current Token**.

### Connecting IBKR to TradeTally

1. Go to **Settings** > **Broker Sync**.
2. Click the **Interactive Brokers** card.
3. Enter:
    - an optional account label
    - your Flex Token
    - your Flex Query ID
    - optional auto-sync settings
4. Click **Connect**.

### Multiple IBKR Accounts

You can connect more than one IBKR account. Each connection keeps its own token, query ID, and sync schedule.

## Charles Schwab

### Required Environment Variables

| Variable | Purpose |
|----------|---------|
| `SCHWAB_CLIENT_ID` | Your Schwab API application client ID |
| `SCHWAB_CLIENT_SECRET` | Your Schwab API application client secret |
| `SCHWAB_REDIRECT_URI` | OAuth callback URL, for example `https://yourdomain.com/api/broker-sync/connections/schwab/callback` |

!!! note
    Schwab requires HTTPS for production callback URLs.

### Connecting Schwab

1. Go to **Settings** > **Broker Sync**.
2. Click the **Charles Schwab** card.
3. Approve the OAuth request at Schwab.
4. Return to TradeTally and confirm the success message.

Only one Schwab connection is allowed per TradeTally account.

### Schwab Limitations

!!! warning "Former TD Ameritrade Users"
    The Schwab API only returns trades made natively on Schwab. Historical TD Ameritrade trades are not available through the Schwab API.

Recommended workflow:

1. Import a full Schwab CSV once for historical data.
2. Use Broker Sync for ongoing native Schwab trades.
3. Let duplicate detection skip already-imported rows.

## Sync Features

### Manual Sync

Use **Sync Now** on any connected broker card to trigger an immediate sync.

### Auto-Sync Scheduling

Available frequencies:

| Frequency | Description |
|-----------|-------------|
| Manual | Manual only |
| Hourly | Every hour |
| Every 4 hours | Four times per day |
| Every 6 hours | Three times per day |
| Every 12 hours | Twice per day |
| Daily | Once per day at your chosen time |

## Troubleshooting

### IBKR Validation Fails

- confirm the Flex Token is current
- confirm the Query ID belongs to an Activity Flex Query
- confirm the query includes the **Trades** section

### Schwab OAuth Fails

- verify `SCHWAB_CLIENT_ID`, `SCHWAB_CLIENT_SECRET`, and `SCHWAB_REDIRECT_URI`
- verify the callback URL matches the Schwab developer app exactly
- try reconnecting after clearing cookies if you get an OAuth state error

### Sync Imports Nothing

- check the duplicates count in Sync History
- verify the source account actually has trades in the requested period
