# Leaderboards and Gamification

Track achievements, compete with peers, and level up your trading skills through TradeTally's gamification system.

## Overview

The **Leaderboard** page brings a gamification layer to your trading journey. Earn experience points (XP) by unlocking achievements, climb leaderboard rankings across multiple categories, and join community challenges -- all designed to encourage disciplined trading habits rather than reckless risk-taking.

!!! info "Requires Configuration"
    The gamification system must be enabled by the instance administrator. Set the environment variable `ENABLE_GAMIFICATION=true` in your `.env` file. When disabled, the Leaderboard page is not available.

## XP and Leveling

Every achievement you unlock awards XP, which accumulates to determine your level. Your current level, total points, and progress toward the next level are displayed in the page header alongside a radial progress indicator.

**Level progression formula:**

| Level | XP Required to Reach | Cumulative XP |
|-------|---------------------|---------------|
| 1     | 0                   | 0             |
| 2     | 100                 | 100           |
| 3     | 150                 | 250           |
| 4     | 200                 | 450           |
| 5     | 250                 | 700           |
| 6     | 300                 | 1,000         |

Each subsequent level requires 50 more XP than the previous increment. The system scales indefinitely, so there is no level cap.

## Page Tabs

The Leaderboard page is organized into three tabs:

### Overview

The Overview tab provides a quick snapshot of your gamification progress:

- **Achievements** -- Total number of achievements earned
- **Rank** -- Your current overall leaderboard position
- **Current Streak** -- Consecutive days with trading activity
- **Progress** -- XP bar showing progress toward the next level

Below the stats cards, the **Recent Achievements** section lists your most recently unlocked achievements with their XP values. Use the "Check for new achievements" button to trigger an immediate check against your latest trading data.

### Achievements

A grid of all available achievements, each displayed as a card showing:

- Achievement name and description
- XP reward value
- Earned or Locked status
- Date earned (if unlocked)

Earned achievements appear with a highlighted border and "Earned" badge. Locked achievements are dimmed with a lock indicator.

**Achievement categories include:**

- **Trading Milestones** -- First trade, trade count thresholds (10, 50, 100, 500 trades)
- **Profitability** -- First profitable trade, green days, profitable streaks, weekly P&L targets
- **Risk Management** -- Setting stop losses, maintaining risk/reward ratios, risk adherence
- **Discipline** -- No revenge trading for consecutive days, discipline score maintenance
- **Activity** -- Trading streaks, early/late market trades, weekend activity
- **Diversity** -- Trading different symbols, sector diversity
- **Community** -- Completing challenges, peer group rankings

### Rankings

The Rankings tab displays two sections:

1. **My Rankings** -- Your personal position across all active leaderboards, with optional peer group filtering
2. **All Leaderboards** -- Full ranked tables for each leaderboard category

## Leaderboard Categories

| Category | Metric | Period |
|----------|--------|--------|
| All-Time P&L | Total cumulative profit/loss | All time |
| Monthly P&L | Profit/loss for the current month | Monthly (resets) |
| Weekly P&L | Profit/loss for the current week | Weekly (resets) |
| Best Trade | Highest single-trade profit | All time |
| Consistency | Score based on profitable day percentage and P&L stability | Configurable |

The **Consistency Score** rewards traders who maintain steady, reliable results. It factors in the percentage of profitable trading days and penalizes high P&L standard deviation, favoring consistent performers over those with volatile swings.

## Peer Group Filtering

!!! tip "Compare with Similar Traders"
    Use the "Filter by Peers" button on the Rankings tab to narrow leaderboard results to traders with similar characteristics.

Available filters:

- **Trading Strategy** -- Filter by strategy type (scalping, day trading, swing, etc.)
- **Average Position Size** -- Micro (under $1K), Small ($1K-$10K), Medium ($10K-$50K), Large ($50K+)
- **Average Profit Per Trade** -- Group by typical trade profit ranges

Filters persist across sessions via local storage.

## Challenges

!!! note "Pro Feature"
    Challenges are available to Pro tier users.

Challenges are time-limited objectives that test specific aspects of trading discipline:

- **Trades Without Revenge** -- Complete a set number of trades without any revenge trading events
- **Maintain Discipline** -- Keep your discipline score above a threshold for a specified number of days
- **Risk Management** -- Execute trades within proper risk parameters
- **Consecutive Profits** -- Achieve a streak of consecutive profitable trading days
- **Community Improvement** -- Aggregate metric-based challenges that track collective progress

**How challenges work:**

1. Browse active challenges from the Challenges section
2. Join a challenge to begin tracking your progress
3. Progress updates automatically based on your trading activity
4. Completing a challenge awards bonus XP and may unlock a linked achievement
5. Challenges that pass their end date without completion are marked as expired

## Privacy and Anonymous Usernames

All leaderboard entries use **anonymous display names** rather than real usernames to protect trader privacy. Your anonymous leaderboard name is shown at the top of the page.

Privacy controls are managed through the `gamification_privacy` table and allow users to:

- **Show on Leaderboards** -- Toggle whether your data appears in any leaderboard rankings
- **Participate in Challenges** -- Toggle whether you can join community challenges

!!! warning "Opting Out"
    If you disable leaderboard visibility, your scores are excluded from all leaderboard calculations. You will not appear in any rankings and other users cannot see your performance data.

## Free vs. Pro Tier

| Feature | Free | Pro |
|---------|------|-----|
| Achievements | Full access | Full access |
| Leaderboard visibility | Top 10 entries only | Full leaderboard (up to 100) |
| Challenges | Not available | Full access |
| Peer group filtering | Available | Available |
| XP and leveling | Full access | Full access |

!!! info "Self-Hosted Instances"
    On self-hosted instances without billing enabled, all users have full access to all gamification features with no tier restrictions.

## How XP Is Earned

XP is earned exclusively through unlocking achievements. Each achievement has a defined point value that is added to your total XP upon earning it. There is no XP awarded for simply placing trades or generating profit -- the system rewards disciplined behavior patterns.

When new achievements are earned:

1. XP is added to your `user_gamification_stats` record
2. Your level is recalculated based on the updated XP total
3. If your level increased, a level-up notification is sent
4. Leaderboard rankings are refreshed to reflect your new score
5. An achievement notification appears in your notification feed
