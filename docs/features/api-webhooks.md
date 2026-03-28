# API Keys and Webhooks

User-facing API keys and webhook subscriptions for programmatic access to your TradeTally data.

## Overview

TradeTally provides a REST API (v1) that allows you to read and write trade data programmatically. Access is controlled through personal API keys, which are a **Pro tier** feature. Webhooks extend the API by pushing real-time event notifications to your own endpoints when trades are created, updated, or deleted.

This page covers the user-facing API key and webhook features. For configuring external service API keys (Finnhub, Alpha Vantage, etc.), see the [API Configuration](../getting-started/api-keys.md) documentation.

## API Keys

### Creating an API Key

1. Navigate to **Settings** > **API Keys**.
2. Click **Create API Key**.
3. Provide a descriptive name for the key (e.g., "Trading Bot" or "Spreadsheet Sync").
4. Select the permissions level:
    - **Read** -- query trades, analytics, watchlists, accounts, investments, and alerts
    - **Write** -- create, update, and delete trades, watchlists, and alerts (includes read access)
    - **Admin** -- full access including administrative endpoints (requires admin role)
5. Optionally select granular scopes to restrict access further.
6. Optionally set an expiration period in days.
7. Click **Create**. The full key is displayed once -- copy it immediately.

!!! warning "Store your key securely"
    The full API key is only shown at creation time. If you lose it, you must revoke the key and create a new one.

### Key Format

All API keys follow the prefix format:

```
tt_live_<random_string>
```

The `tt_live_` prefix makes keys easy to identify in logs and configuration files.

### Available Scopes

Scopes provide fine-grained control over what an API key can access. When you select a permission level, the corresponding scopes are automatically included.

| Scope | Permission Level | Description |
|-------|-----------------|-------------|
| `trades:read` | Read | List and retrieve trades |
| `analytics:read` | Read | Access analytics endpoints |
| `watchlists:read` | Read | List watchlists and symbols |
| `accounts:read` | Read | View account information |
| `investments:read` | Read | View investment data |
| `alerts:read` | Read | View price alerts |
| `trades:write` | Write | Create, update, and delete trades |
| `watchlists:write` | Write | Manage watchlists |
| `alerts:write` | Write | Create and manage alerts |
| `admin:*` | Admin | Full administrative access |

!!! note
    Write permission automatically includes all read scopes. Admin permission includes all scopes.

### Revoking an API Key

1. Navigate to **Settings** > **API Keys**.
2. Find the key you want to revoke.
3. Click **Delete** and confirm.

Revoked keys stop working immediately. Any requests using a revoked key receive a `401 Unauthorized` response.

### Managing API Keys

From the API Keys settings page, you can:

- View all active keys with their name, permissions, creation date, and expiration
- Update the name or permissions of an existing key
- Delete keys that are no longer needed
- Administrators can view all API keys across all users

## REST API v1

The v1 API is available at the base path `/api/v1/` and supports both JWT authentication and API key authentication.

### Authentication Methods

**JWT Bearer Token** -- Used by the web and mobile apps:

```
Authorization: Bearer <access_token>
```

**API Key** -- Used for external integrations:

```
Authorization: Bearer tt_live_<your_key>
```

Both methods work interchangeably on endpoints that support `flexibleAuth`. Some internal endpoints (import, export, journal entries) require JWT authentication only.

### Available Endpoints

| Method | Endpoint | Scope Required | Description |
|--------|----------|---------------|-------------|
| `GET` | `/api/v1/trades` | `trades:read` | List trades with pagination and filtering |
| `POST` | `/api/v1/trades` | `trades:write` | Create a single trade |
| `GET` | `/api/v1/trades/:id` | `trades:read` | Get trade by ID |
| `PUT` | `/api/v1/trades/:id` | `trades:write` | Update a trade |
| `DELETE` | `/api/v1/trades/:id` | `trades:write` | Delete a trade |
| `POST` | `/api/v1/trades/bulk` | `trades:write` | Bulk create trades |
| `PUT` | `/api/v1/trades/bulk` | `trades:write` | Bulk update trades |
| `DELETE` | `/api/v1/trades/bulk` | `trades:write` | Bulk delete trades |
| `GET` | `/api/v1/trades/summary/quick` | `trades:read` | Quick trading summary |
| `GET` | `/api/v1/trades/recent` | `trades:read` | Recent trades list |
| `GET` | `/api/v1/analytics/*` | `analytics:read` | Analytics endpoints |
| `GET` | `/api/v1/health` | None | API health check |

### Pagination

List endpoints use limit/offset pagination:

```
GET /api/v1/trades?limit=50&offset=0
```

Responses include a `pagination` object:

```json
{
  "data": [...],
  "pagination": {
    "limit": 50,
    "offset": 0,
    "total": 234,
    "hasMore": true
  }
}
```

### Idempotency

Write endpoints (`POST /api/v1/trades` and `POST /api/v1/trades/bulk`) support idempotency keys to safely retry requests without creating duplicates:

```
Idempotency-Key: unique-request-id-12345
```

### API Documentation

Interactive API documentation is available at `/api-docs` when Swagger is enabled on your instance.

## Webhooks

Webhooks allow TradeTally to push real-time event notifications to your own HTTP endpoints. This is a **Pro tier** feature and requires the `ENABLE_V1_WEBHOOKS=true` environment variable.

### Enabling Webhooks

Add the following to your `.env` file:

```bash
ENABLE_V1_WEBHOOKS=true
```

!!! info "Self-hosted users"
    Webhooks are disabled by default. Set the environment variable and restart the application to enable them.

### Creating a Webhook

1. Send a `POST` request to `/api/v1/webhooks` with the following body:

```json
{
  "url": "https://your-server.com/webhook-receiver",
  "description": "My trade notification webhook",
  "eventTypes": ["trade.created", "trade.updated", "trade.deleted"],
  "isActive": true
}
```

A webhook secret is automatically generated (prefixed with `whsec_`) and returned in the response. Use this secret to verify incoming webhook signatures.

### Supported Event Types

| Event Type | Description |
|-----------|-------------|
| `trade.created` | A new trade was created |
| `trade.updated` | An existing trade was updated |
| `trade.deleted` | A trade was deleted |
| `import.completed` | A trade import finished |
| `broker_sync.completed` | A broker sync completed |
| `price_alert.triggered` | A price alert was triggered |
| `enrichment.completed` | Trade enrichment finished |

If no event types are specified, the webhook defaults to `trade.created`, `trade.updated`, and `trade.deleted`.

### Webhook Payload

Each delivery sends a `POST` request to your endpoint with the following structure:

```json
{
  "id": "event-uuid",
  "type": "trade.created",
  "createdAt": "2026-03-28T12:00:00.000Z",
  "data": { ... },
  "metadata": {}
}
```

### Signature Verification

Every webhook delivery includes signature headers for verification:

| Header | Description |
|--------|-------------|
| `X-TradeTally-Event` | The event type (e.g., `trade.created`) |
| `X-TradeTally-Timestamp` | Unix timestamp of the delivery |
| `X-TradeTally-Signature` | HMAC-SHA256 signature (`sha256=<hex>`) |
| `User-Agent` | `TradeTally-Webhooks/1.0` |

To verify the signature, compute `HMAC-SHA256(secret, "<timestamp>.<json_body>")` and compare with the provided signature.

### Managing Webhooks

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/v1/webhooks` | List all webhooks |
| `POST` | `/api/v1/webhooks` | Create a webhook |
| `PUT` | `/api/v1/webhooks/:id` | Update a webhook |
| `DELETE` | `/api/v1/webhooks/:id` | Delete a webhook |
| `POST` | `/api/v1/webhooks/:id/test` | Send a test delivery |
| `GET` | `/api/v1/webhooks/:id/deliveries` | View delivery history |

### Failure Handling

- Webhooks that return non-2xx responses are marked as failed.
- After 5 consecutive failures (configurable via `WEBHOOK_FAILURE_THRESHOLD`), the webhook is automatically disabled.
- Successful deliveries reset the failure counter.
- Delivery timeout defaults to 10 seconds (configurable via `WEBHOOK_TIMEOUT_MS`).

!!! tip "Testing webhooks"
    Use the `POST /api/v1/webhooks/:id/test` endpoint to send a test delivery and verify your receiver is working correctly before relying on live events.

### Secret Rotation

To rotate a webhook secret, send an update request with `rotateSecret: true`:

```json
PUT /api/v1/webhooks/:id
{
  "rotateSecret": true
}
```

The new secret is returned in the response. Update your verification logic to use the new secret.
