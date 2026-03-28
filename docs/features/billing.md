# Billing and Tiers

Understand the Free and Pro tier system, feature access, and subscription management.

## Overview

TradeTally uses a two-tier system -- **Free** and **Pro** -- to control access to features. The SaaS version at [tradetally.io](https://tradetally.io) enforces these tiers with Stripe-powered billing. Self-hosted instances have all features unlocked by default with no tier restrictions.

## Self-Hosted Users

!!! info "All features unlocked"
    Self-hosted deployments have billing disabled by default. Every user on a self-hosted instance gets full access to all Pro features at no cost. No Stripe configuration is needed.

When billing is disabled:

- All users are treated as Pro tier
- No subscription management UI is shown
- API keys, webhooks, watchlists, price alerts, and all other Pro features are available
- The pricing page is not displayed

To explicitly enable billing on a self-hosted instance, set `BILLING_ENABLED=true` in your `.env` file and configure Stripe credentials. This is only necessary if you want to run your own paid service.

## Tier Comparison

The following table compares features available in each tier.

### Core Features

| Feature | Free | Pro |
|---------|------|-----|
| Dashboard | Yes | Yes |
| News feed | Yes | Yes |
| Earnings calendar | Yes | Yes |
| Trade import (CSV) | Yes (100 per batch) | Yes (unlimited per batch) |
| Total trade storage | Unlimited | Unlimited |
| Manual trade entry | Yes | Yes |
| Trade tagging | Yes | Yes |
| Core metrics (P&L, win rate) | Yes | Yes |
| Basic charts | Yes | Yes |
| Calendar view | Yes | Yes |
| Journal entries | Unlimited | Unlimited |

### Analytics

| Feature | Free | Pro |
|---------|------|-----|
| Basic P&L and win rate | Yes | Yes |
| SQN analysis | -- | Yes |
| Kelly Criterion | -- | Yes |
| MAE/MFE analysis | -- | Yes |
| K-Ratio | -- | Yes |
| Sector breakdown | -- | Yes |
| Time analysis | -- | Yes |
| Day-of-week analysis | -- | Yes |
| Symbol analytics | -- | Yes |
| Strategy analytics | -- | Yes |
| Behavioral analytics | -- | Yes |
| Health analytics | -- | Yes |

### Alerts and Monitoring

| Feature | Free | Pro |
|---------|------|-----|
| Price alerts | -- | Up to 100 |
| Email alerts | -- | Yes |
| Push notifications | -- | Yes |
| Real-time monitoring | -- | Yes |
| Watchlists | -- | Up to 20 (100 symbols each) |

### AI Features

| Feature | Free | Pro |
|---------|------|-----|
| AI credits per month | -- | 100 |
| AI follow-up questions | -- | Up to 5 per session |
| AI trade analysis | -- | Yes |
| AI conversations | -- | Yes |

### Integrations

| Feature | Free | Pro |
|---------|------|-----|
| API access | -- | Yes (10,000 calls/day) |
| Webhooks | -- | Yes |
| Playbook adherence reviews | -- | Yes |

### Leaderboards

| Feature | Free | Pro |
|---------|------|-----|
| View leaderboard | Top 10 only | Full rankings |
| Participate in leaderboard | -- | Yes |
| Leaderboard filters | -- | Yes |

### Other Pro Features

- Advanced filtering and custom metrics
- Export reports
- Trade blocking
- Behavioral alerts (revenge trading, overconfidence, loss aversion)
- Personality typing

## Pricing

Pro subscriptions are available in two billing intervals:

| Plan | Price | Billing |
|------|-------|---------|
| **Pro Monthly** | $8.00/month | Billed monthly |
| **Pro Yearly** | $80.00/year | Billed annually (save 17%) |

## Free Trial

New users can start a **14-day free trial** of Pro features:

1. Navigate to **Billing** or click the upgrade prompt.
2. Click **Start Free Trial**.
3. All Pro features are immediately unlocked for 14 days.
4. No credit card is required for the trial.
5. After 14 days, your account reverts to the Free tier unless you subscribe.

!!! note "One trial per account"
    Each account can only use the free trial once. The system tracks trial usage to prevent repeated activations.

## Subscribing to Pro

### Web (Stripe Checkout)

1. Navigate to **Billing** from the user menu or visit the **Pricing** page.
2. Select your preferred plan (Monthly or Yearly).
3. Click **Subscribe** to be redirected to Stripe Checkout.
4. Enter your payment details and confirm.
5. After successful payment, your account is immediately upgraded to Pro.

### iOS (In-App Purchase)

1. Open the TradeTally iOS app.
2. Navigate to the subscription screen.
3. Select your plan and complete the purchase through the App Store.
4. The transaction is verified server-side and your account is upgraded.

## Managing Your Subscription

### Billing Portal

Pro subscribers can manage their subscription through the Stripe Customer Portal:

1. Navigate to **Billing**.
2. Click **Manage Subscription** to open the Stripe portal.
3. From the portal, you can:
    - Update your payment method
    - View invoice history
    - Cancel your subscription (effective at the end of the billing period)

### Cancellation

When you cancel:

- Your Pro features remain active until the end of the current billing period.
- After the period ends, your account reverts to the Free tier.
- Your trade data and journal entries are preserved regardless of tier.
- You can re-subscribe at any time to restore Pro access.

!!! tip "Your data is safe"
    Downgrading to Free tier never deletes your data. Trades, journal entries, and historical analytics are fully preserved. You simply lose access to Pro-only features until you re-subscribe.

## Tier Overrides (Admin)

Instance administrators can manually grant Pro tier access to specific users through tier overrides. This is useful for:

- Granting complimentary access to beta testers
- Supporting users during billing issues
- Running promotional periods

Tier overrides can have an optional expiration date, after which the user's tier reverts to their subscription-based tier.

## Environment Variables

For self-hosted instances that want to enable billing:

| Variable | Description |
|----------|-------------|
| `BILLING_ENABLED` | Set to `true` to enable billing and tier enforcement |
| `STRIPE_SECRET_KEY` | Stripe API secret key |
| `STRIPE_WEBHOOK_SECRET` | Stripe webhook endpoint secret for event verification |

Stripe price IDs for monthly and yearly plans are configured through the admin settings panel, stored as `stripe_price_id_monthly` and `stripe_price_id_yearly` in the `admin_settings` table.
