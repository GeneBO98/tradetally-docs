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
| Generic | CSV | No | Optional |

## Import Process

### Step 1: Export from Your Broker

=== "Lightspeed"

    1. Log in to Lightspeed Trader
    2. Go to **Reports/Account List**
    3. Select your account
    4. Go to **Blotter**
    5. Select date range
    6. Export as CSV

    **Required Columns**:
    - Symbol
    - Trade Date
    - Execution Time
    - Price
    - Qty (Quantity)
    - Side (Buy/Sell)
    - Commission Amount

=== "Charles Schwab"

    1. Login to Schwab.com
    2. Go to **Accounts** → **History**
    3. Select **Closed Positions**
    4. Export as CSV

    **Required Columns**:
    - Symbol
    - Opened Date
    - Closed Date
    - Quantity
    - Cost Per Share
    - Proceeds Per Share
    - Gain/Loss ($)

=== "ThinkorSwim"

    1. Open ThinkorSwim
    2. Go to **Monitor** → **Account Statement**
    3. Select **Trade History**
    4. Export as CSV

    **Required Columns**:
    - Symbol
    - Exec Time
    - Price
    - Qty
    - Side
    - Commission

=== "Interactive Brokers"

    1. Login to IBKR Portal
    2. Go to **Reports** → **Activity Statement**
    3. Select date range
    4. Download CSV format

    **Required Columns**:
    - Symbol
    - DateTime
    - Price
    - Quantity
    - Commission

=== "E*TRADE"

    1. Login to E*TRADE
    2. Go to **Accounts** → **Transactions**
    3. Select date range
    4. Download as CSV

    **Required Columns**:
    - Symbol
    - Transaction Date
    - Price
    - Quantity
    - Transaction Type
    - Commission

### Step 2: Import into TradeTally

1. Navigate to the **Import** tab in TradeTally
2. Click **Choose File** and select your CSV
3. Select your broker from the dropdown:
   - If your broker matches exactly, select it
   - If unsure, select **Auto-detect** (recommended)
   - For custom formats, select **Generic CSV**
4. Review the import preview
5. Click **Import** to confirm

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
