# Broker Column Verification - Code vs Documentation

## Summary of Findings

### ✅ Supported File Formats
- **CSV ONLY** - TradeTally does NOT support XML files
- File filter accepts: `.csv`, `text/csv`, `application/csv`

---

## Broker-by-Broker Verification

### 1. Lightspeed ✅ VERIFIED
**Code expects:**
- `Symbol`
- `Trade Date`
- `Execution Time` OR `Raw Exec. Time`
- `Price`
- `Qty`
- `Side` OR `Buy/Sell` OR `Principal Amount` OR `NET Amount`
- `Commission Amount`
- `Trade Number` (optional)
- `Security Type` (optional)

**Documentation status:** ✅ Correct

---

### 2. Charles Schwab ✅ VERIFIED
**Code expects:**
- `Symbol`
- `Opened Date`
- `Closed Date`
- `Quantity`
- `Cost Per Share`
- `Proceeds Per Share`
- `Gain/Loss ($)`
- `Term` (optional - for notes)
- `Wash Sale?` (optional - for notes)

**Documentation status:** ✅ Correct

**Important notes:**
- Schwab does NOT provide commission/fees separately (code sets to 0)
- Schwab does NOT provide trade times (code uses default 09:30/16:00)
- This is why docs warn about missing trade times

---

### 3. ThinkorSwim ⚠️ NEEDS REVIEW
**Code expects:**
- `DESCRIPTION` OR `Description` - contains trade details like "BOT +1,000 82655M107 @.77"
- `TYPE` OR `Type` - must be "TRD" for trades
- `DATE` OR `Date`
- `TIME` OR `Time`
- `Misc Fees`
- `Commissions & Fees`

**Documentation says:**
- Exec Time, Spread, Side, Qty, Pos Effect, Symbol, Exp, Strike, Type, Price, Net Price

**Status:** ❌ MISMATCH - Documentation lists wrong columns!

---

### 4. Interactive Brokers (Activity Statement) ✅ VERIFIED
**Code expects:**
- `Symbol`
- `DateTime` OR `Date/Time` (both supported)
- `Quantity` (signed: positive=buy, negative=sell)
- `Price`
- `Commission` (optional, negative values)
- `Fees` (optional)

**Documentation status:** ✅ Correct after latest fixes

**Date formats:**
- Activity Statement: `MM-DD-YY` or `MM-DD-YY HH:MM`
- Trade Confirmation: `YYYYMMDD;HHMMSS`

---

### 5. Interactive Brokers (Trade Confirmation) ✅ VERIFIED
**Code expects:**
- `Symbol`
- `UnderlyingSymbol`
- `Strike`
- `Expiry` (YYYYMMDD format)
- `Date/Time` (YYYYMMDD;HHMMSS format)
- `Put/Call`
- `Quantity`
- `Multiplier`
- `Buy/Sell`
- `Price`
- `Commission`

**Documentation status:** ✅ Mentioned but not detailed (acceptable)

---

### 6. E*TRADE ✅ VERIFIED
**Code expects:**
- `Symbol`
- `Transaction Date`
- `Price`
- `Quantity`
- `Transaction Type` (must include "Buy" or not for sell)
- `Commission` (optional)
- `Fees` (optional)

**Documentation status:** ✅ Correct

---

### 7. ProjectX ✅ VERIFIED
**Code expects:**
- `Id` (or with BOM: `﻿Id`, `\uFEFFId`)
- `ContractName`
- `EnteredAt`
- `ExitedAt`
- `EntryPrice`
- `ExitPrice`
- `Fees`
- `PnL`
- `Size`
- `Type`
- `TradeDay` (optional)
- `TradeDuration` (optional)
- `Commissions` (optional)

**Documentation status:** ⚠️ NOT DOCUMENTED - docs don't specify required columns

---

## Critical Fixes Needed

### 1. IBKR - Remove XML Reference ❌ HIGH PRIORITY
- TradeTally does NOT support XML
- Must only mention CSV

### 2. ThinkorSwim - Wrong Columns Listed ❌ HIGH PRIORITY
- Current docs list wrong columns
- Need to document actual format from Account Statement export

### 3. ProjectX - Missing Column Details ⚠️ MEDIUM PRIORITY
- Should list the actual column names expected

---

## Additional Findings

### Auto-Detection Logic
The code auto-detects broker formats by checking for specific column combinations:

- **IBKR (Activity)**: `symbol`, `datetime` or `date/time`, `quantity`, `price`
- **IBKR (Trade Confirmation)**: `underlyingsymbol`, `strike`, `expiry`, `put/call`, `multiplier`, `buy/sell`
- **E*TRADE**: `transaction date`, `transaction type`, (`buy` or `sell`)
- **Lightspeed**: `trade date`, `execution time`, `qty`, `price`
- **ThinkorSwim**: `date`, `time`, `type`, `description` (with "type" in description section)
- **Schwab**: `opened date`, `closed date`, `cost per share`, `proceeds per share`
- **ProjectX**: `contractname`, `enteredat`, `exitedat`, `entryprice`, `exitprice`
