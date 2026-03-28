# Alerts and Notifications

Set price alerts on symbols and receive real-time notifications when targets are hit.

## Overview

TradeTally's alerts and notifications system lets you monitor price movements and receive timely updates through multiple channels. Price alerts are a **Pro tier** feature that support in-app browser notifications, email alerts, and push notifications to mobile devices.

The notification system also delivers other event types including trade comments from the community, earnings announcements, news alerts for open positions, behavioral pattern warnings, and achievement updates.

## Price Alerts

### Alert Types

TradeTally supports three types of price alerts:

| Alert Type | Description | Required Field |
|-----------|-------------|----------------|
| **Above** | Triggers when the price rises above a target | `target_price` |
| **Below** | Triggers when the price falls below a target | `target_price` |
| **Change Percent** | Triggers when the price changes by a given percentage | `change_percent` |

### Creating a Price Alert

1. Navigate to **Price Alerts** from the main navigation.
2. Click **Create Alert**.
3. Enter the stock symbol (e.g., `AAPL`).
4. Select the alert type: **Above**, **Below**, or **Change Percent**.
5. Enter the target price or percentage threshold.
6. Choose notification methods:
    - **Browser notifications** -- real-time in-app alerts via SSE (Server-Sent Events)
    - **Email notifications** -- sends an email when the alert triggers
7. Optionally enable **Repeat** to keep the alert active after it triggers.
8. Click **Create**.

!!! note "Price validation"
    The system validates your target against the current market price. An "above" alert must have a target price higher than the current price, and a "below" alert must have a target lower.

### Managing Alerts

From the **Price Alerts** page, you can:

- View all active and triggered alerts with current market prices
- Edit an alert's target price, percentage threshold, or notification preferences
- Reactivate a triggered alert by toggling it back to active
- Delete alerts you no longer need
- Filter alerts by symbol or active/inactive status

### How Alerts Trigger

A background monitoring process periodically checks active alerts against current market data from the `price_monitoring` table:

- **Above alerts** trigger when the current price is greater than or equal to the target price
- **Below alerts** trigger when the current price is less than or equal to the target price
- **Change percent alerts** trigger when the absolute percentage change meets or exceeds the threshold

When an alert triggers:

1. A notification record is created in `alert_notifications`
2. A browser notification is pushed via SSE if the user is connected
3. A push notification is sent to registered mobile devices
4. The alert is either deleted (one-time) or marked as triggered (if repeat is enabled)

### Testing Alerts

Each alert has a **Test** option that sends a test notification through all configured channels without requiring the actual price condition to be met. Use this to verify your notification setup is working.

## Notification Channels

### In-App Browser Notifications

Real-time notifications are delivered through Server-Sent Events (SSE). When you are logged in and have the application open, you automatically connect to the notification stream.

The notification bell in the navigation bar shows your unread count and provides quick access to recent notifications.

!!! info "Pro tier required"
    Real-time SSE notifications require Pro tier. On self-hosted instances where billing is disabled, all users have access.

### Email Notifications

Email alerts are sent when price targets are hit, provided:

- Email is enabled on the alert (`email_enabled: true`)
- Email is configured on the server (SMTP settings in `.env`)
- The user has email notifications enabled in their preferences

!!! warning "Email configuration required"
    Email alerts require a working SMTP configuration. Self-hosted users must configure `EMAIL_HOST`, `EMAIL_USER`, and `EMAIL_PASS` environment variables. See the deployment documentation for details.

### Push Notifications (Mobile)

Push notifications are delivered to registered iOS devices via Apple Push Notification Service (APNS). This requires:

- `ENABLE_PUSH_NOTIFICATIONS=true` in the environment
- APNS key file and credentials configured (`APNS_KEY_PATH`, `APNS_KEY_ID`, `APNS_TEAM_ID`)
- A registered device token from the mobile app

Push notifications are sent for price alerts, trade alerts, news alerts, and earnings announcements.

## Notification Types

Beyond price alerts, the system delivers several other notification types:

| Notification Type | Description | Preference Setting |
|------------------|-------------|-------------------|
| **Price Alerts** | Target price reached or percentage change exceeded | `notify_price_alerts` |
| **Earnings Announcements** | Upcoming earnings for watchlist and open positions | `notify_earnings_announcements` |
| **News on Open Positions** | Breaking news for stocks you currently hold | `notify_news_open_positions` |
| **Trade Reminders** | Behavioral analytics alerts (revenge trading, overconfidence) | `notify_trade_reminders` |
| **Trade Comments** | Comments on your public trades from other users | Always enabled |
| **Achievement Earned** | Gamification achievements unlocked | Always enabled |
| **Level Up** | XP level progression updates | Always enabled |
| **Challenge Updates** | Challenge joined or completed | Always enabled |

## Managing Notification Preferences

### Global Preferences

1. Navigate to **Settings** > **Notifications** (or access via the notification preferences endpoint).
2. Toggle each notification category on or off:
    - **News on Open Positions** -- receive alerts when news breaks for your current holdings
    - **Earnings Announcements** -- get notified about upcoming earnings
    - **Price Alerts** -- enable or disable all price alert notifications
    - **Trade Reminders** -- behavioral pattern warnings and trade-related reminders

### Per-Alert Preferences

Each individual price alert has its own notification method settings:

- **Browser enabled** -- receive in-app real-time notification
- **Email enabled** -- receive email notification

At least one notification method must be enabled per alert.

## Notification Center

The **Notifications** page provides a unified view of all your notifications:

- View price alert triggers, trade comments, and system notifications in one feed
- Filter to show only unread notifications
- Mark individual notifications or all notifications as read
- Delete notifications you no longer need
- Paginated view with newest notifications first

### Unread Count

The notification badge in the navigation bar displays the count of unread notifications from the past 30 days, combining price alert notifications and trade comment notifications.

## Enrichment Updates

When you import trades, the system enriches them with additional data (company names, sectors, etc.). The notification stream delivers real-time enrichment status updates so you can see progress without refreshing the page.

## System Announcements

Administrators can broadcast system-wide announcements to all connected users through the notification stream. These appear as system notifications in the notification center.
