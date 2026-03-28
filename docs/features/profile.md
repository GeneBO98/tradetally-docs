# Profile

Manage your account information, security settings, and public trading presence.

## Overview

The **Profile** page is your central hub for account management. From here you can update your personal information, configure security features like two-factor authentication and passkeys, manage your subscription, and control how your trading activity is shared publicly.

## Profile Information

### Editable Fields

| Field | Description | Notes |
|-------|-------------|-------|
| Full Name | Your display name | Optional |
| Email | Account email address | Requires 2FA to be enabled before changes are allowed |
| Timezone | Preferred timezone | All trade times display in this timezone |
| Time Format | 12-hour or 24-hour | Affects time display across the entire application |

!!! note "Username Is Permanent"
    Your username is set during registration and cannot be changed. It serves as your unique identifier and forms part of your public profile URL.

### Updating Your Profile

1. Navigate to **Profile** from the user menu
2. Modify any of the editable fields
3. Click **Update Profile** to save changes

## Public Profile

Every user has a public profile page accessible at `/u/:username`. This page is visible to anyone, even without a TradeTally account.

### What the Public Profile Shows

- **Avatar** -- Your profile picture or a generated initial-based avatar
- **Username** -- Displayed as @username
- **Full Name** -- If provided
- **Member Since** -- Account creation date
- **Public Trades** -- Any trades you have explicitly shared publicly

### Public Trade Sharing

Trades that you mark as public appear on your profile page. Each shared trade displays:

- Symbol, side (long/short), and open/closed status
- Entry and exit prices
- Quantity
- P&L in dollars and percentage
- Tags applied to the trade
- Notes (if any)

Visitors can click through to view full trade details.

!!! tip "Building a Track Record"
    Public trade sharing is useful for building a verifiable trading track record. Share your best setups to demonstrate your trading approach to others.

### Profile Privacy

If your profile is set to private, visitors will see a "This profile is private" message instead of your trading data. Profiles that do not exist return a "User not found" message.

## Two-Factor Authentication (2FA)

Two-factor authentication adds an extra layer of security by requiring a code from an authenticator app in addition to your password.

### Enabling 2FA

1. Navigate to **Profile**
2. Scroll to the **Two-Factor Authentication** section
3. Click **Enable 2FA**
4. Scan the QR code with your authenticator app (Google Authenticator, Authy, etc.)
5. Enter the verification code to confirm setup
6. Save your backup codes in a secure location

### When 2FA Is Enabled

- A green status indicator confirms 2FA is active
- The number of remaining backup codes is displayed
- You can disable 2FA using the **Disable 2FA** button
- Email address changes become available (locked when 2FA is off)

!!! warning "Backup Codes"
    Store your backup codes securely. If you lose access to your authenticator app, backup codes are the only way to recover your account.

### Disabling 2FA

1. Click **Disable 2FA** in the Two-Factor Authentication section
2. Confirm the action when prompted

After disabling 2FA, email changes are locked again until 2FA is re-enabled.

## Passkeys

Passkeys provide passwordless sign-in using your device's biometrics, security key, or PIN. This is a modern authentication method that is both more secure and more convenient than traditional passwords.

### Managing Passkeys

The Passkeys section displays all registered passkeys with:

- **Device Name** -- Identifier for the passkey
- **Date Added** -- When the passkey was registered
- **Last Used** -- Most recent sign-in using this passkey

### Adding a Passkey

1. Navigate to **Profile**
2. Scroll to the **Passkeys** section
3. Click **Add passkey**
4. Follow your browser or device prompt to register the credential
5. The new passkey appears in your list

### Removing a Passkey

1. Locate the passkey in the list
2. Click **Delete** next to the passkey
3. Confirm the deletion

!!! info "Browser Support"
    Passkey support depends on your browser and operating system. Most modern browsers on recent OS versions support passkeys. Check your browser documentation for compatibility details.

## Subscription Management

!!! note "Hosted Instances Only"
    The subscription section only appears on instances where billing is enabled. Self-hosted users will not see this section.

When billing is available, the Profile page displays your current subscription status:

- **Current Plan** -- Your active plan name (e.g., Pro Plan)
- **Status** -- Active, cancelled, or expiring
- **Next Billing Date** -- When your next payment is due
- **Cancellation Date** -- If your subscription is set to cancel, shows the end date

From this section you can:

- View your current plan details
- Manage your subscription through the billing portal
- See cancellation status if applicable

## Community Features

Your profile connects you to the broader TradeTally community:

- **Public Trades** -- Share trades on your profile for others to learn from
- **Leaderboard Participation** -- Your anonymous leaderboard name links back to your gamification activity (see [Leaderboards](leaderboards.md))
- **Peer Comparisons** -- Other users with similar trading characteristics can find you through filtered peer groups

## Settings Related to Profile

Several settings that affect your profile experience are managed from the **Settings** page rather than the Profile page:

- **Theme color** -- Customizes the accent color across the application
- **Dark mode** -- Toggle between light and dark appearance
- **Account deletion** -- Permanently remove your account and all data
- **Data export** -- Download a complete backup of your trading data
