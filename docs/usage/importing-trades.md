# Importing Trades

Learn how to import your trades from various brokers into TradeTally.

## Supported Brokers

TradeTally supports importing trades from the following brokers:

| Broker | Format | FIFO Matching | Commission Tracking |
|--------|--------|---------------|---------------------|
| Lightspeed | CSV | Yes | Yes |
| Charles Schwab | CSV | No (uses broker P&L) | Yes |
| ThinkorSwim | CSV | Yes | Yes |
| Interactive Brokers | CSV | Yes | Yes |
| E*TRADE | CSV | Yes | Yes |
| ProjectX (Futures) | CSV | Yes | Yes |
| Questrade | CSV | Yes | Yes |
| Tastytrade | CSV | Yes | Yes |
| Generic | CSV | No | Optional |

## Import Process

!!! info "Supported File Format"
    TradeTally **only supports CSV files**. If your broker offers multiple export formats (like XML, Excel, or PDF), always select **CSV format**.

### Step 1: Export from Your Broker

=== "Lightspeed"

    ### Web Portal Export

    1. Log into **Lightspeed.com** website
    2. Navigate to **My Account** → **Reports**
    3. From the Reports dropdown, select **Account List**
    4. From the STATEMENTS dropdown, select your **account number**
    5. From the reports menu, select **Blotter**
    6. Select your desired **date range**
    7. Click **Apply** to display trades
    8. Click the **CSV button** to download
    9. **Extract the ZIP file** (downloads as ZIP format)

    !!! tip "Alternative Navigation"
        **My View** → **Reports** from top menu → Click **Confirm** (top right) → Select your account → Choose **Blotter** from submenu

    !!! note "Important"
        - Export is from **Lightspeed website**, not desktop application
        - File downloads as ZIP - must extract before importing
        - Depending on browser, you may need to right-click and "Save As"

    **Required Columns**:
    - Symbol
    - Trade Date
    - Execution Time
    - Price
    - Qty (Quantity)
    - Side (Buy/Sell)
    - Commission Amount

=== "Charles Schwab"

    ### Method 1: Export Realized Gains/Losses (For Closed Positions)

    1. Log into **Schwab.com**
    2. Click **Accounts** tab (upper left)
    3. Select **History** from dropdown
    4. Click the **Realized Gain/Loss** tab
    5. Select specific account from dropdown (if multiple accounts)
    6. Choose appropriate **date range/tax year**
    7. Click **Export** button (upper right)
    8. Save the CSV file to your computer

    ### Method 2: Export Transaction History

    1. Log into **Schwab.com**
    2. Click **Accounts** → **Transaction History**
    3. Select desired account from dropdown (if multiple)
    4. Select date range or choose **Custom** for specific dates
    5. Click **Search**
    6. Click **Export** (top right)
    7. Select **CSV** as export type
    8. Click **Export** again to download

    !!! warning "Critical Limitations"
        - **Maximum 10,000 records per download** - for larger datasets, export smaller time periods separately
        - **Schwab does not include trade times** - options data may be incomplete
        - Consider using ThinkorSwim instead for complete options information

    **Required Columns**:
    - Symbol
    - Opened Date
    - Closed Date
    - Quantity
    - Cost Per Share
    - Proceeds Per Share
    - Gain/Loss ($)

=== "ThinkorSwim"

    ### Desktop Platform Export

    1. Open **ThinkorSwim desktop platform**
    2. Go to **Monitor** tab
    3. Open **Account Statement** page
    4. Adjust time frame selector at top of page (default shows past day)
    5. Verify correct account is selected
    6. Click the **menu icon** (three lines) in upper right corner
    7. Select **"Export to file"** from dropdown
    8. CSV file saves to your computer as **AccountStatement.csv**

    !!! warning "Export Limitation"
        **Maximum 365 days (1 year) per export** - for multi-year data, export separate files for each year

    !!! tip "Alternative Method"
        Via TD Ameritrade website: **My Account** → **History & Statements** → **Transactions** → Set Type to "All transaction types" → Select date range → Click **Download**

    **Required Columns** (Account Statement export includes these):
    - **DESCRIPTION** or **Description** - Contains trade details (e.g., "BOT +1,000 AAPL @150.00")
    - **TYPE** or **Type** - Must be "TRD" for trade rows
    - **DATE** or **Date** - Trade date
    - **TIME** or **Time** - Trade time
    - **Misc Fees** - Optional fees
    - **Commissions & Fees** - Optional commission

    !!! note "How ThinkorSwim Format Works"
        ThinkorSwim Account Statement exports include trade details in the DESCRIPTION field. The parser extracts:

        - Action (BOT/SOLD) from description
        - Quantity from description
        - Symbol from description
        - Price from description

        Example: `"BOT +1,000 AAPL @150.00"` is parsed as Buy 1000 shares of AAPL at $150.00

=== "Interactive Brokers"

    ### Creating an Activity Flex Query

    **Step 1: Access Flex Queries**

    1. Log into [IBKR Client Portal](https://www.interactivebrokers.co.uk/sso/Login?RL=1)
    2. Navigate to **Performance & Reports** → **Flex Queries**
       - *Alternative*: Menu (top-left) → Reporting → Flex Queries

    **Step 2: Create New Query**

    1. Click the **"+" icon** in top-right corner of Activity Flex Query panel
    2. Enter descriptive **Query Name** (e.g., "Export" or "Trade History")

    **Step 3: Select Sections** (Click each section, Select All, then Save)

    - ✅ Cash Transactions
    - ✅ Corporate Actions
    - ✅ Financial Instrument Information
    - ✅ Grant Activity
    - ✅ Incoming/Outgoing Trade Transfers
    - ✅ Option Exercises, Assignments and Expirations
    - ✅ **Trades** (most important)
    - ✅ Transaction Fees
    - ✅ Transfers

    **Step 4: Configure Delivery Settings**

    - **Accounts**: Click Add/Edit Accounts (important if multiple/migrated accounts)
    - **Format**: Select **CSV** (TradeTally does not support XML)
    - **Period**: Choose from Last 365 Calendar Days, Custom Date Range, etc.

    **Step 5: Configure General Settings** (OPTIONAL - default works fine)

    TradeTally supports multiple IBKR date formats automatically. The default settings work for most users.

    For Trade Confirmation format, you can optionally set:
    - **Date Format**: **yyyyMMdd** (e.g., 20241225)
    - **Time Format**: **HHmmss** (e.g., 093000)
    - **Date/Time Separator**: **semicolon (;)**

    For Activity Statement format (most common), dates are in **MM-DD-YY** format (e.g., 12-25-24) and work automatically.

    **Step 6: Finalize and Run**

    1. Click **Continue** to review
    2. Click **Create**, then **OK**
    3. Select all relevant accounts
    4. Click the **arrow icon** next to your query name
    5. Choose your **time period** (max 1 year)
    6. Select **CSV** format
    7. Click **Run** and download the file

    !!! warning "Export Limitation"
        **Maximum 365 days (1 year) per export** - for older portfolios, create separate exports for each year using custom date ranges

    !!! tip "Simpler Method"
        For quick exports: **Account Management** → **Statements** → **Activity Statements** → Choose CSV format → Select frequency (daily, monthly, annual, or custom)

    **Required Columns (Activity Statement)**:
    - **Symbol** - Ticker symbol
    - **DateTime** OR **Date/Time** - Both column names supported
    - **Quantity** - Signed value (positive = buy, negative = sell)
    - **Price** - Execution price
    - **Commission** - Optional (negative values in IBKR CSVs)
    - **Conid** - Contract ID (CRITICAL for options - see below)

    !!! warning "Options Trading: Include the Conid Column"
        **For options trades, the `Conid` column is essential.** The Conid (Contract ID) is IBKR's unique identifier for each options contract and ensures trades are grouped correctly.

        **Why Conid matters:**

        - Options symbols can be complex and parsing may vary
        - Multiple partial fills on the same contract need to be grouped together
        - Different strikes/expirations of the same underlying must be tracked separately
        - Conid guarantees accurate trade matching regardless of symbol format

        **How to include Conid in your export:**

        1. When creating your Flex Query, expand the **Trades** section
        2. Find and enable the **Conid** checkbox
        3. Save and run your query

        Without the Conid column, options trades may be incorrectly grouped or split into separate trades.

    **Expected Date Formats**:
    - Activity Statement: `DD-MM-YY` (e.g., `16-02-24`) or `DD-MM-YY HH:MM` - also supports `MM-DD-YY` automatically
    - Trade Confirmation: `YYYYMMDD;HHMMSS` (e.g., `20241225;093000`)

    !!! note "IBKR Uses Signed Quantities"
        Unlike other brokers, IBKR uses signed quantities instead of a separate Buy/Sell column:

        - **Positive quantity** = Buy transaction
        - **Negative quantity** = Sell transaction

=== "E*TRADE"

    ### Method 1: Power E*TRADE Platform

    1. Open **Power E*TRADE** platform
    2. Navigate to **Account** tab → **Orders** page
    3. Locate time frame selector at top:
       - Predefined: "Today," "This Week," "This Month," "Year-to-Date"
       - Custom: Use calendar icons for specific start/end dates
    4. Click **download icon** (upper right corner)
    5. CSV file automatically downloads as **"DownloadTxnHistory.csv"**

    ### Method 2: E*TRADE Website

    1. Log into **E*TRADE.com**
    2. Click **Accounts** tab
    3. Select **Transactions** from dropdown
    4. Choose **"Custom Time Period"** from dropdown
    5. Enter **From** and **To** dates
    6. Click **Search**
    7. After report loads, click **Download icon** (upper right)
    8. Verify account and time frame are correct
    9. Select **"Spreadsheet Format including Microsoft Excel Details"**
    10. Click **Download** button (lower right)

    !!! note "Supported Formats"
        Both CSV and Excel formats (XLS/XLSX) are supported. No apparent maximum record or date limitation.

    **Required Columns**:
    - Symbol
    - Transaction Date
    - Price
    - Quantity
    - Transaction Type
    - Commission

=== "ProjectX (Futures)"

    ### Export from Trades Tab

    1. Log into your **ProjectX prop firm account**
    2. Navigate to the **"Trades" tab**
    3. Locate **"EXPORT"** button in **bottom right corner**
    4. Click the **EXPORT** button
    5. Select desired **date range** for trades
    6. Click **Export** to confirm
    7. CSV file saves to your desktop

    !!! tip "Troubleshooting Blank Files"
        If exported file appears blank, widen your date range:

        - Start one day **before** first trade
        - End a few days **after** last trade

    !!! warning "Important"
        **Only export from "Trades" tab** for compatibility - files from other tabs may not import correctly

    **Required Columns** (ProjectX CSV export includes):
    - **Id** - Trade ID (may have BOM character prefix)
    - **ContractName** - Futures contract name
    - **EnteredAt** - Entry timestamp (format: "10/01/2025 21:13:23 +02:00")
    - **ExitedAt** - Exit timestamp
    - **EntryPrice** - Entry price
    - **ExitPrice** - Exit price
    - **Fees** - Trading fees
    - **PnL** - Profit/Loss
    - **Size** - Position size
    - **Type** - Long/Short
    - **TradeDay** - Optional
    - **TradeDuration** - Optional
    - **Commissions** - Optional

    **Supported Prop Firms:**

    This works for all ProjectX-backed prop firms including:

    - Topstep
    - Alpha Futures
    - TickTickTrader
    - Bulenox
    - TradeDay
    - Blusky
    - Goat Futures
    - The Futures Desk
    - DayTraders
    - E8 Futures
    - Blue Guardian Futures
    - FuturesElite
    - FXIFY
    - Hola Prime
    - Top One Futures
    - Funding Futures
    - TX3 Funding

=== "Tastytrade"

    ### Export Transaction History

    1. Log into your **Tastytrade** account at [tastytrade.com](https://tastytrade.com)
    2. Navigate to **History** tab
    3. Select **Transactions** sub-tab
    4. Set your desired **date range** using the date filters
    5. Click the **CSV** export/download button
    6. Save the file to your computer

    !!! tip "Transaction Types"
        The Tastytrade CSV export includes multiple row types (Trade, Receive Deliver, Money Movement). TradeTally automatically filters for **Trade** rows only and ignores non-trade entries.

    !!! note "Options Support"
        Tastytrade exports include full options data with OCC-format symbols. The parser automatically detects options contracts and applies the correct 100x multiplier for equity options.

    **Required Columns** (included in standard Tastytrade export):

    - **Date** - Execution timestamp (ISO 8601 format)
    - **Type** - Row type (only "Trade" rows are processed)
    - **Action** - BUY_TO_OPEN, SELL_TO_CLOSE, etc.
    - **Symbol** - Ticker or OCC option symbol
    - **Instrument Type** - Equity, Equity Option, Future, etc.
    - **Quantity** - Number of shares/contracts
    - **Average Price** - Execution price
    - **Commissions** - Trading commissions
    - **Fees** - Exchange and regulatory fees
    - **Multiplier** - Contract multiplier (100 for equity options)
    - **Root Symbol** - Underlying ticker for options
    - **Underlying Symbol** - Underlying symbol
    - **Expiration Date** - Options expiration date
    - **Strike Price** - Options strike price
    - **Call or Put** - Option type

=== "Questrade"

    ### Export from Questrade Edge Application

    !!! tip "Recommended Export Method"
        Use the **Questrade Edge desktop application** for the most complete trade data. The web interface exports Excel files with less information.

    **Step 1: Open Account Window**

    1. Launch **Questrade Edge** desktop application
    2. Click **Tools** in the top menu bar
    3. Select **Account** from the dropdown

    **Step 2: Configure Columns**

    1. Click the **Executions** tab in the Account window
    2. Right-click on the column headers
    3. Select **"Edit columns"**
    4. Click **"Restore Defaults"** in the bottom left
    5. Scroll through the list and check the following columns:
       - Currency
       - Exec time
       - Option
       - Strategy
       - Commission
    6. Click **OK** to save your column configuration

    **Step 3: Export Trades**

    1. Right-click on the column headers again
    2. Click **"Export..."**
    3. Choose a location (e.g., Desktop)
    4. Save the file with a descriptive name
    5. File will be saved as CSV format

    !!! note "Options Trading Support"
        Questrade exports support both stocks and options. Options use the following action codes:

        - **BTO** - Buy to Open (opening a long options position)
        - **STC** - Sell to Close (closing a long options position)
        - **STO** - Sell to Open (opening a short options position)
        - **BTC** - Buy to Close (closing a short options position)

    !!! info "Multi-Currency Support"
        Questrade supports both CAD and USD trading. The currency column is automatically detected and preserved during import.

    **Required Columns** (automatically included in Questrade Edge export):

    - **Symbol** - Stock ticker or options symbol (e.g., `ECHI.TO` or `SLV20Feb26C55.00`)
    - **Action** - Trade action (Buy, Sell, BTO, STC, BTC, STO)
    - **Fill qty** - Number of shares or contracts filled
    - **Fill price** - Execution price per share/contract
    - **Currency** - Trading currency (CAD or USD)
    - **Exec time** - Execution timestamp
    - **Option** - Option type (Call/Put) or empty for stocks
    - **Commission** - Trading commission

    **Sample CSV Format**:

    ```csv
    "Symbol","Action","Fill qty","Fill price","Currency","Exec time","Total value","Time placed","Option","Strategy","Commission","Account"
    "ECHI.TO","Buy","700","11.26","CAD","16 Dec 2025 11:15:58 AM","7,882.00","16 Dec 2025 11:15:58 AM","","","0.00","12345678 - Margin +"
    "SLV20Feb26C55.00","BTO","4","6.95","USD","17 Dec 2025 09:38:14 AM","2,780.00","17 Dec 2025 09:38:14 AM","Call","","3.96","23456789 - TFSA (+)"
    "SLV20Feb26C55.00","STC","4","10.30","USD","24 Dec 2025 10:47:11 AM","4,120.00","24 Dec 2025 10:47:11 AM","Call","","3.96","23456789 - TFSA (+)"
    ```

### Step 2: Import into TradeTally

1. Navigate to the **Import** tab in TradeTally
2. Click **Choose File** and select your CSV
3. Select your broker from the dropdown:
   - If your broker matches exactly, select it
   - If unsure, select **Auto-detect** (recommended)
   - For custom formats, select **Generic CSV**
4. **Select Trading Account** (if you have accounts defined):
   - Choose an account to associate imported trades with
   - Select **"None (different broker/account)"** if importing for a new/different account
   - If account is auto-detected in CSV, it will be used automatically
5. Review the import preview
6. Click **Import** to confirm

!!! tip "Account Association"
    TradeTally automatically detects account columns in CSV files with flexible matching (Account, Account ID, AcctId, etc.). Account identifiers are privacy-redacted to show only the last 4 characters (e.g., `****5678`). New accounts are auto-created when unrecognized identifiers are found during import.

### Step 3: Review Imported Trades

1. Go to **Trade List** to view all imported trades
2. Verify trade details are correct:
   - Entry/exit dates and times
   - Prices and quantities
   - P&L calculations
   - Commissions and fees
3. Edit any trades that need corrections
4. Add tags, notes, or attachments as needed

## CSV Format Requirements

### Generic CSV Format

If your broker is not listed, you can use the generic CSV format:

```csv
Symbol,Entry Date,Exit Date,Quantity,Entry Price,Exit Price,P&L,Commission
AAPL,2025-01-15,2025-01-16,100,150.00,155.00,500.00,2.00
MSFT,2025-01-15,2025-01-16,50,380.00,385.00,250.00,1.00
```

**Required Columns**:
- `Symbol` or `Ticker`
- `Entry Date` or `Open Date`
- `Exit Date` or `Close Date`
- `Quantity` or `Qty` or `Size`
- `Entry Price` or `Open Price`
- `Exit Price` or `Close Price`

**Optional Columns**:
- `P&L` or `Profit Loss`
- `Commission` or `Fees`
- `Side` or `Direction` (Long/Short)
- `Currency` (for multi-currency trades)

### Date Formats Supported

TradeTally automatically detects and parses various date formats:

- `YYYY-MM-DD` (ISO format)
- `MM/DD/YYYY` (US format)
- `DD/MM/YYYY` (European format)
- `YYYY-MM-DD HH:MM:SS` (with time)
- `MM/DD/YYYY HH:MM:SS AM/PM`

### Options and Futures

TradeTally supports options and futures trading:

**Options Format**:
```csv
Symbol,Entry Date,Exit Date,Quantity,Entry Price,Exit Price,P&L
QQQ 251001P00599000,2025-10-01,2025-10-01,10,0.59,0.47,-120.00
```

**Futures Format**:
```csv
Symbol,Entry Date,Exit Date,Quantity,Entry Price,Exit Price,P&L
MNQZ5,2025-10-01,2025-10-01,8,25024.75,25027.25,-40.00
```

The system automatically detects instrument types and applies correct multipliers.

## Multi-Currency Support

TradeTally supports importing trades in multiple currencies:

### Adding Currency Column

Add a `Currency` column to your CSV:

```csv
Symbol,Entry Date,Exit Date,Quantity,Entry Price,Exit Price,P&L,Currency
AAPL,2025-01-15,2025-01-16,100,150.00,155.00,500.00,USD
HKD:2828,2025-01-15,2025-01-16,1000,50.00,52.00,2000.00,HKD
```

### Supported Currencies

TradeTally uses Finnhub forex API for currency conversion:

- USD (US Dollar)
- EUR (Euro)
- GBP (British Pound)
- HKD (Hong Kong Dollar)
- JPY (Japanese Yen)
- CAD (Canadian Dollar)
- AUD (Australian Dollar)
- And many more...

### Conversion Process

1. System detects `Currency` column in CSV
2. Fetches historical exchange rate for trade date
3. Converts all values to USD
4. Stores both original and converted values
5. All analytics use USD for consistency

!!! note "Pro Feature"
    Currency conversion requires a Pro subscription on SaaS platform or `FINNHUB_API_KEY` for self-hosted.

## CUSIP Resolution

Some brokers use CUSIP codes instead of ticker symbols. TradeTally automatically resolves these.

### Automatic Resolution

During import, TradeTally attempts to resolve CUSIPs using:

1. **Cache**: Previously resolved mappings
2. **Finnhub**: Symbol search API
3. **OpenFIGI**: Bloomberg's CUSIP database
4. **AI Fallback**: Optional (disabled by default)

### Manual Resolution

If CUSIPs remain unresolved:

1. Go to **Import** → **Resolve Unresolved CUSIPs**
2. View list of unresolved CUSIPs
3. Click **Add Mapping** for each CUSIP
4. Enter the correct ticker symbol
5. Click **Save**

### Managing CUSIP Mappings

**Add Custom Mapping**:
```
CUSIP: 037833100
Ticker: AAPL
```

**Delete Incorrect Mapping**:
Click the trash icon next to the mapping

**Export Mappings**:
Mappings are stored in `backend/src/data/cusip_cache.json`

## Duplicate Detection

TradeTally prevents duplicate imports:

- Checks for existing trades with same:
  - Symbol
  - Entry date/time
  - Quantity
  - Price
- Skips duplicates automatically
- Shows count of skipped trades

## Import Validation

TradeTally validates imported data:

### Errors Caught

- Missing required columns
- Invalid date formats
- Invalid price or quantity values
- Unsupported symbols
- Malformed CSV structure

### Warnings

- CUSIP codes detected (will attempt resolution)
- Missing optional columns
- Unusual trade patterns
- Large position sizes

## Advanced Import Options

### Filtering Trades

Before importing, you can filter trades:

- Date range filters
- Symbol filters
- Minimum P&L filters
- Side filters (long/short only)

### Bulk Import

Import multiple CSV files:

1. Select multiple files in file picker
2. System processes each file sequentially
3. Combined results shown in preview
4. Single import confirmation

### Re-import

To re-import corrected data:

1. Delete existing trades (if needed)
2. Import corrected CSV file
3. Duplicate detection prevents re-importing unchanged trades

## Troubleshooting

### No Trades Imported

**Common Causes**:
- All trades are duplicates
- CSV format not recognized
- Required columns missing
- Invalid date formats

**Solutions**:
- Check broker format selection
- Verify CSV column names
- Try **Auto-detect** broker format
- Use generic CSV format with correct columns

### Wrong P&L Calculations

**Causes**:
- Options multiplier not applied
- Commission not included
- Wash sales not accounted for
- Currency conversion issues

**Solutions**:
- Verify instrument type is detected correctly
- Check commission values in CSV
- Edit trades manually to correct P&L
- Ensure currency column is present

### CUSIP Resolution Failing

**Causes**:
- API keys not configured
- Rate limits exceeded
- Invalid CUSIP codes
- Network connectivity issues

**Solutions**:
- Configure `FINNHUB_API_KEY` and `OPENFIGI_API_KEY`
- Wait a few minutes for rate limits to reset
- Use manual CUSIP mapping
- Check console logs for errors

### Date Parsing Issues

**Causes**:
- Unicode quotes in CSV (e.g., '' instead of '')
- Unsupported date format
- Timezone inconsistencies

**Solutions**:
- Remove quotes from date fields
- Use standard date formats (YYYY-MM-DD)
- Check for Unicode characters in CSV

## Best Practices

### Before Importing

1. Review your broker's CSV export format
2. Verify all required columns are present
3. Check for CUSIP codes vs. ticker symbols
4. Note any special characters or formatting

### During Import

1. Use **Auto-detect** for broker format
2. Review the import preview carefully
3. Check for validation warnings
4. Verify trade counts match expectations

### After Import

1. Review imported trades in Trade List
2. Verify P&L calculations
3. Add tags and notes for organization
4. Check for unresolved CUSIPs
5. Backup your data

### Regular Imports

1. Export trades regularly from broker
2. Keep CSV files organized by date
3. Import frequently to track real-time performance
4. Use duplicate detection to avoid re-imports

## Next Steps

- [Dashboard Guide](../features/dashboard.md) - View your performance
- [Analytics](../features/analytics.md) - Analyze your trades
- [Trade Management](trade-management.md) - Edit and organize trades
