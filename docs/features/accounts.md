# Trading Accounts

Manage multiple brokerage accounts and track cashflow across your trading portfolio.

## Overview

TradeTally supports tracking trades across multiple brokerage accounts. Each account can be associated with trades during import, allowing you to:

- Track performance per account
- Monitor cashflow for each account
- Filter trades by account
- Organize multi-account portfolios

## Managing Accounts

### Accessing Account Management

Navigate to **Settings** > **Trading Accounts** or click **"Trading Accounts"** in the navigation menu under **More**.

### Creating an Account

1. Click **"Add Account"** button
2. Fill in the account details:
   - **Account Name** - A friendly name (e.g., "Schwab IRA", "IBKR Main")
   - **Account Identifier** - The broker's account number (privacy-redacted in display)
   - **Broker** - Select the broker this account belongs to
   - **Initial Balance** - Starting balance for cashflow tracking
   - **Balance Date** - Date of the initial balance
   - **Primary Account** - Check if this is your main trading account
3. Click **"Save"**

### Account Privacy

Account identifiers are automatically privacy-redacted throughout the application:

- Full identifier: `12345678` displays as `****5678`
- Only the last 4 characters are shown
- Original values are stored securely for matching during imports

### Editing an Account

1. Click the **pencil icon** next to the account
2. Update the desired fields
3. Click **"Update"**

### Deleting an Account

1. Click the **trash icon** next to the account
2. Confirm the deletion

!!! warning "Deleting Accounts"
    Deleting an account removes its association with trades but does not delete the trades themselves.

## Account Detection During Import

### Automatic Detection

TradeTally automatically detects account columns in CSV files using flexible matching:

**Supported Column Names:**

- `Account`
- `Account ID` / `AccountId`
- `Account Number` / `AccountNumber`
- `AcctId` / `Acct_Id` / `Acct`
- `Account_Identifier`
- `Brokerage_Account`
- `Trading_Account`
- `Portfolio`

Column matching is case-insensitive and ignores separators (spaces, underscores, dashes).

### ThinkorSwim Header Detection

ThinkorSwim Account Statement exports include the account number in the header rows. TradeTally extracts this automatically:

```
Account Statement for 12345678
...
```

The account is extracted and redacted before associating with trades.

### Auto-Creation of Accounts

When importing trades with account identifiers that don't exist:

1. TradeTally automatically creates new accounts
2. Account names are generated based on broker (e.g., "Schwab Account")
3. New accounts appear in the Trading Accounts list
4. You can edit the auto-created accounts to add friendly names

## Import with Account Selection

### When Accounts Exist

If you have defined accounts, the import page shows an **Account Selection** dropdown:

1. **Select an existing account** - Associates all imported trades with that account
2. **"None (different broker/account)"** - Use when importing from a new or different account

### Import Priority

Account association follows this priority:

1. **CSV Column** - If account column detected, uses that value
2. **Manual Selection** - If no column detected, uses dropdown selection
3. **Auto-Create** - New identifiers create new accounts automatically

## Cashflow Tracking

### Viewing Cashflow

Navigate to **Trading Accounts** > **Cashflow** tab or **More** > **Cashflow** in the navigation.

### Transaction Types

Track various cashflow transactions:

- **Deposit** - Funds added to account
- **Withdrawal** - Funds removed from account
- **Transfer** - Movement between accounts
- **Dividend** - Dividend payments
- **Interest** - Interest earned/paid
- **Fee** - Account fees

### Adding Transactions

1. Select the account
2. Click **"Add Transaction"**
3. Enter transaction details:
   - Type
   - Amount
   - Date
   - Description
4. Click **"Save"**

### Viewing Balance History

The Cashflow view shows:

- Current balance
- Transaction history
- Running balance over time
- Summary statistics

## Filtering Trades by Account

### In Trade List

Use the **Account** filter in the Trade List to view trades for specific accounts:

1. Click **Filters**
2. Select one or more accounts from the **Account** dropdown
3. Trade list updates to show only matching trades

### In Analytics

Account filtering applies to all analytics, showing:

- P&L for selected accounts
- Win rate for selected accounts
- Performance metrics per account

## Best Practices

### Naming Conventions

Use clear, descriptive names:

- Include broker name: "Schwab Day Trading"
- Include account type: "IBKR IRA"
- Include strategy: "ThinkorSwim Options"

### Primary Account

Set your most-used account as primary:

- Auto-selected during imports
- Default filter in analytics
- Highlighted in account list

### Regular Reconciliation

Periodically verify:

- Account balances match broker
- Trades are associated with correct accounts
- Cashflow transactions are complete

## Troubleshooting

### Account Not Detected During Import

**Causes:**

- Column name not in supported list
- Column name has unusual characters

**Solutions:**

- Use manual account selection
- Rename CSV column to "Account"
- Select broker format that supports account detection

### Duplicate Accounts Created

**Causes:**

- Different identifier formats in CSV files
- Account number variations

**Solutions:**

- Merge accounts manually (delete duplicate, reassign trades)
- Use consistent CSV exports

### Missing Account in Dropdown

**Causes:**

- Account was deleted
- Viewing different user's data

**Solutions:**

- Create the account in Trading Accounts
- Check user login

## Next Steps

- [Importing Trades](../usage/importing-trades.md) - Learn about import options
- [Analytics](analytics.md) - Analyze performance by account
- [Dashboard](dashboard.md) - View account summaries
