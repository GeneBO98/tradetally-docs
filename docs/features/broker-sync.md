# Broker Sync

Automatically import trades from your brokerage accounts via API instead of manual CSV uploads.

## Overview

Broker Sync connects directly to your brokerage account and pulls in trade data automatically. This eliminates the need for repetitive CSV exports and ensures your TradeTally dashboard stays current with minimal effort.

Currently supported brokers:

- **Interactive Brokers (IBKR)** -- via Flex Query API
- **Charles Schwab** -- via OAuth API

Navigate to **Settings** > **Broker Sync** to manage your connections.

## Prerequisites

Before setting up any broker connection, the following environment variable must be configured on your TradeTally server:

| Variable | Purpose | How to generate |
|----------|---------|-----------------|
| `BROKER_ENCRYPTION_KEY` | Encrypts stored broker credentials at rest | `openssl rand -hex 32` |

!!! warning
    Without `BROKER_ENCRYPTION_KEY`, broker sync will not function. Add it to your `.env` file before attempting to connect any broker.

## Interactive Brokers (IBKR)

### Setting Up a Flex Query

IBKR uses a system called Flex Queries to export trade data. You need to create one in the IBKR Client Portal, then provide TradeTally with the resulting token and query ID.

1. Log in to the [IBKR Client Portal](https://www.interactivebrokers.com/sso/Login).
2. Navigate to **Performance & Reports** > **Flex Queries**.
3. Under "Activity Flex Query", click the **+** button to create a new query.
4. Name your query (e.g., "TradeTally Sync"), select **Trades** in the Sections, then save.
5. Note the **Query ID** displayed next to your saved query.
6. Click the **gear icon** next to "Configure Flex Web Service".
7. Generate or copy your **Current Token**.

!!! tip
    For detailed instructions, see [IBKR's official Flex Query documentation](https://www.interactivebrokers.com/en/software/am/am/reports/activityflexqueries.htm).

### Connecting IBKR to TradeTally

1. Go to **Settings** > **Broker Sync**.
2. Click the **Interactive Brokers** card under "Add Broker Connection".
3. Fill in the connection form:
    - **Account Label** (optional) -- a friendly name like "Main Account" or "Paper Trading"
    - **Flex Token** -- the token from step 7 above
    - **Flex Query ID** -- the query ID from step 5 above
    - **Auto-Sync** -- toggle on to enable scheduled syncing
    - **Sync Time** -- the time of day to run the auto-sync (your local timezone)
4. Click **Connect**. TradeTally validates your credentials with IBKR before saving.

### Multiple IBKR Accounts

You can connect more than one IBKR account. Each connection has its own Flex Token, Query ID, and sync schedule. This is useful if you trade across multiple accounts (e.g., a live account and a paper trading account).

To add another IBKR account, click the **Interactive Brokers** card again. The button text changes to "Add another IBKR account" once you have at least one connection.

## Charles Schwab

### Required Environment Variables

Schwab integration uses OAuth and requires additional server configuration:

| Variable | Purpose |
|----------|---------|
| `SCHWAB_CLIENT_ID` | Your Schwab API application client ID |
| `SCHWAB_CLIENT_SECRET` | Your Schwab API application client secret |
| `SCHWAB_REDIRECT_URI` | The OAuth callback URL (e.g., `https://yourdomain.com/api/broker-sync/schwab/callback`) |

!!! note
    You must register a developer application with Schwab to obtain these credentials. Self-hosted users who do not need Schwab sync can skip this configuration entirely.

### Connecting Schwab

1. Go to **Settings** > **Broker Sync**.
2. Click the **Charles Schwab** card.
3. You will be redirected to the Schwab authorization page.
4. Log in with your Schwab credentials and approve the connection.
5. After approval, you are redirected back to TradeTally with a success message.

Only one Schwab connection is allowed per TradeTally account.

### Schwab Limitations

!!! warning "Former TD Ameritrade Users"
    The Schwab API only returns trades made natively on Schwab. If your account was migrated from TD Ameritrade, historical TDA trades (marked with "TDA TRAN" in CSV exports) are **not** available via the API.

    **Recommended workflow:**

    1. Import a full CSV export from Schwab once to capture all historical data (including TDA trades).
    2. Use Broker Sync for ongoing native Schwab trades.
    3. Duplicate detection prevents the same trades from being imported twice.

Schwab OAuth tokens require manual re-authentication approximately every 7 days due to refresh token limitations. When the token expires, the connection status changes to "expired" and you will need to reconnect.

## Sync Features

### Manual Sync

Click the **Sync Now** button on any connected broker card to trigger an immediate sync. The sync runs in the background and you can monitor progress in the Sync History table below.

### Auto-Sync Scheduling

Enable auto-sync when creating or editing a connection. Available frequencies:

| Frequency | Description |
|-----------|-------------|
| Manual | No automatic syncing; manual only |
| Hourly | Every hour |
| Every 4 hours | Four times per day |
| Every 6 hours | Three times per day |
| Every 12 hours | Twice per day |
| Daily | Once per day at your chosen sync time |

When using the **Daily** frequency, you can set a specific **Sync Time** in your local timezone (e.g., 06:00 to sync each morning before market open).

### Duplicate Detection

Every sync automatically detects and skips duplicate trades. The Sync History table shows both the number of trades imported and the number of duplicates detected, so you always know exactly what changed.

## Managing Connections

Each connected broker displays as a card with the following information:

- **Connection status** -- Active, Error, or Expired
- **Account label** -- your custom name for the connection
- **Auto-sync status** -- whether scheduled syncing is enabled and its frequency
- **Last sync time** -- when the most recent sync occurred
- **Trades imported** -- count from the last sync

### Available Actions

Click the three-dot menu on any broker card to access these actions:

| Action | Description |
|--------|-------------|
| **Settings** | Change account label, auto-sync toggle, sync frequency, and sync time |
| **Test Connection** | Validates that credentials are still working |
| **Delete All Trades** | Permanently removes all trades imported via this broker sync (does not affect manually imported trades) |
| **Disconnect** | Removes the broker connection but keeps previously imported trades |

!!! info
    **Delete All Trades** only removes trades that were imported through broker sync for that specific connection. Manually imported trades (via CSV) are never affected.

## Sync History

The Sync History table at the bottom of the page shows a log of all sync operations across all connected brokers. Each row includes:

- **Broker** -- which broker the sync was for
- **Type** -- manual or scheduled
- **Status** -- completed, failed, or in-progress (started, fetching, parsing, importing)
- **Imported** -- number of new trades added
- **Duplicates** -- number of duplicate trades skipped
- **Date** -- when the sync occurred

Click **Refresh** to update the table with the latest sync results.

## Troubleshooting

### IBKR Connection Fails Validation

- Verify your Flex Token has not expired. Tokens can be regenerated in the IBKR Client Portal.
- Confirm the Query ID matches an existing Activity Flex Query (not a different query type).
- Ensure the Flex Query includes the **Trades** section.

### Schwab OAuth Fails

- Check that `SCHWAB_CLIENT_ID`, `SCHWAB_CLIENT_SECRET`, and `SCHWAB_REDIRECT_URI` are correctly set in your `.env` file.
- Verify the redirect URI matches exactly what is registered in your Schwab developer application.
- If the error mentions "invalid_state" or "missing_params", try clearing your browser cookies and reconnecting.

### Sync Completes but No Trades Imported

- The sync may have detected all trades as duplicates. Check the "Duplicates" column in Sync History.
- For IBKR, verify your Flex Query date range covers the period you expect.
- For Schwab, remember that TD Ameritrade historical trades are not available via the API.

### Connection Status Shows "Error"

- Use the **Test Connection** action to get a specific error message.
- For Schwab, an "expired" status means you need to re-authenticate via OAuth.
- For IBKR, an expired Flex Token needs to be regenerated in the Client Portal and updated in TradeTally connection settings.
