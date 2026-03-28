# Mobile App

Access TradeTally from your iOS device with native mobile app support.

## Overview

TradeTally includes a companion iOS mobile app that connects to your TradeTally instance through the REST API v1. The mobile app provides access to your trades, analytics, and alerts on the go, with native push notifications and device management.

The mobile API is available at `/api/v1/` and includes dedicated endpoints for device registration, authentication with refresh tokens, push notification management, and data synchronization.

## Getting Started

### iOS TestFlight

The TradeTally iOS app is available through Apple TestFlight for beta testing. Visit the [TradeTally mobile app repository](https://github.com/tradetally/mobile-app) for TestFlight access links and installation instructions.

### Connecting to Your Instance

1. Open the TradeTally app on your iOS device.
2. Enter your TradeTally server URL (e.g., `https://tradetally.example.com`).
3. Sign in with your email and password.
4. The app automatically registers your device and establishes a secure session.

!!! info "Self-hosted users"
    Your server must be accessible from your mobile device. Ensure your instance is reachable over HTTPS and that CORS is configured to allow requests from the mobile app.

## Authentication

### Login with Device Registration

The mobile app uses an enhanced login flow that registers the device during authentication:

1. The app sends credentials along with device information (device name, model, OS version, fingerprint).
2. The server authenticates the user and registers or updates the device record.
3. Both an access token and a refresh token are returned.

### JWT Refresh Token Flow

Mobile sessions use a refresh token system for seamless authentication:

1. **Access token** -- Short-lived JWT used for API requests. Sent as `Authorization: Bearer <token>`.
2. **Refresh token** -- Long-lived token used to obtain new access tokens without re-entering credentials.
3. When the access token expires, the app sends the refresh token to `POST /api/v1/auth/refresh`.
4. A new access token and rotated refresh token are returned.

```
POST /api/v1/auth/refresh
{
  "refreshToken": "<refresh_token>"
}
```

!!! tip "Token rotation"
    Each refresh request issues a new refresh token, invalidating the previous one. This limits the window of exposure if a token is compromised.

### Session Management

The v1 API provides several session management endpoints:

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/v1/auth/login/device` | POST | Login with device registration |
| `/api/v1/auth/refresh` | POST | Refresh access token |
| `/api/v1/auth/logout` | POST | Logout current session |
| `/api/v1/auth/logout/device` | POST | Logout from a specific device |
| `/api/v1/auth/logout/all-devices` | POST | Logout from all devices |
| `/api/v1/auth/session/status` | GET | View active sessions |
| `/api/v1/auth/session/extend` | POST | Extend current session |

## Device Management

### Registering a Device

Devices are registered automatically during the login flow or can be registered manually:

```
POST /api/v1/devices
{
  "name": "iPhone 15 Pro",
  "deviceType": "ios",
  "model": "iPhone15,3",
  "osVersion": "18.0",
  "appVersion": "1.0.0",
  "fingerprint": "unique-device-fingerprint"
}
```

### Device Limits

Each user can register up to a configurable number of devices (default: 10). This limit is controlled by the `MAX_DEVICES_PER_USER` environment variable.

When the device limit is reached, you must remove an existing device before registering a new one.

### Trusted Devices

Devices can be marked as trusted or untrusted for security purposes:

- **Trust a device** -- `POST /api/v1/devices/:id/trust`
- **Untrust a device** -- `POST /api/v1/devices/:id/untrust`

Trusted devices may receive enhanced session durations or reduced re-authentication requirements.

### Device Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/v1/devices` | GET | List all registered devices |
| `/api/v1/devices` | POST | Register a new device |
| `/api/v1/devices/:id` | GET | Get device details |
| `/api/v1/devices/:id` | PUT | Update device information |
| `/api/v1/devices/:id` | DELETE | Remove a device |
| `/api/v1/devices/:id/trust` | POST | Mark device as trusted |
| `/api/v1/devices/:id/untrust` | POST | Remove trusted status |
| `/api/v1/devices/:id/sessions` | GET | View active sessions for a device |
| `/api/v1/devices/:id/sessions` | DELETE | Revoke all sessions for a device |
| `/api/v1/devices/current/info` | GET | Get current device info |
| `/api/v1/devices/current/push-token` | POST | Register push notification token |
| `/api/v1/devices/current/push-token` | DELETE | Remove push notification token |
| `/api/v1/devices/current/heartbeat` | POST | Record device heartbeat |

!!! note "Device identification"
    The current device is identified via the `X-Device-ID` header. The mobile app should include this header with every request.

## Push Notifications

### Enabling Push Notifications

Push notifications require server-side configuration with Apple Push Notification Service (APNS) credentials.

**Required environment variables:**

```bash
ENABLE_PUSH_NOTIFICATIONS=true
APNS_KEY_PATH=/path/to/AuthKey_XXXXXXXXXX.p8
APNS_KEY_ID=XXXXXXXXXX
APNS_TEAM_ID=YYYYYYYYYY
```

| Variable | Description |
|----------|-------------|
| `ENABLE_PUSH_NOTIFICATIONS` | Set to `true` to enable push notification support |
| `APNS_KEY_PATH` | Path to the Apple Push Notification Authentication Key (.p8 file) |
| `APNS_KEY_ID` | The Key ID from your Apple Developer account |
| `APNS_TEAM_ID` | Your Apple Developer Team ID |

!!! warning "APNS key file required"
    The `.p8` key file must be present on the server at the configured path. Without it, push notifications are silently disabled.

### Registering a Push Token

After the mobile app obtains a device token from iOS, it registers the token with the server:

```
POST /api/v1/devices/current/push-token
{
  "token": "<apns_device_token>",
  "platform": "ios"
}
```

### Supported Push Notification Types

The following events trigger push notifications to registered devices:

| Event | Description |
|-------|-------------|
| **Price Alert** | A price alert target was reached |
| **Trade Alert** | A trade execution notification |
| **News Alert** | Breaking news for stocks in open positions |
| **Earnings Alert** | Upcoming earnings announcement |
| **Test** | Manual test notification |

### Token Lifecycle

- Tokens are marked as **active** when registered.
- If Apple reports a token as invalid (`BadDeviceToken` or `410` status), the token is automatically marked inactive.
- Users can manually remove push tokens via `DELETE /api/v1/devices/current/push-token`.

## File Uploads

The mobile API supports file uploads with a default maximum size of **52 MB**. This is used for importing trade CSV files from your mobile device. The upload limit can be adjusted via server configuration.

## Available API Endpoints

The mobile app has access to the full v1 API, including:

- **Trades** -- List, create, update, delete, and bulk operations
- **Analytics** -- Trading performance metrics and summaries
- **Settings** -- User preferences and configuration
- **Devices** -- Device management and push tokens
- **Server** -- Server information and health checks

For complete API endpoint documentation, see the [API Keys and Webhooks](api-webhooks.md) page or the interactive API docs at `/api-docs` on your instance.

## Billing (iOS In-App Purchase)

The mobile app supports Apple In-App Purchase for Pro tier subscriptions. Transactions are verified server-side using StoreKit 2 JWS signed transactions. The server validates the transaction, grants Pro tier access, and stores the transaction record.

For self-hosted instances, billing is typically disabled and all features are available to all users regardless of the app's purchase flow.
