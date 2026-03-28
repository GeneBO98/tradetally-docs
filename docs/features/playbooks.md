# Playbooks

Define structured trading setups with checklists and hard rules, then score trades against them to measure plan adherence.

## Overview

Playbooks are formalized descriptions of your trading strategies. Each playbook defines the conditions a trade should meet -- side, timeframe, risk parameters, and a step-by-step checklist. After closing a trade, you review it against the relevant playbook to get an adherence score that quantifies how well you followed your plan.

Navigate to **Playbooks** from the main sidebar.

## Why Use Playbooks

- **Consistency** -- Codify what a valid trade looks like for each strategy so you stop guessing.
- **Accountability** -- Score every trade against objective criteria rather than relying on memory.
- **Performance insight** -- Compare win rates, profit factors, and average R across playbooks to see which strategies actually work best.
- **Discipline feedback** -- Track "followed plan" vs "broke plan" rates over time to measure improvement.

## Creating a Playbook

1. Go to **Playbooks** and click **New Playbook**.
2. Fill in the playbook definition:

### Core Fields

| Field | Description |
|-------|-------------|
| **Name** | A unique name for this setup (e.g., "Opening Range Breakout", "VWAP Reversal") |
| **Description** | Optional explanation of when and how you use this strategy |
| **Market** | The market context (e.g., "Small caps", "SPY options", "Large cap momentum") |
| **Side** | Long, Short, or Both |
| **Timeframe** | Scalper, Day Trading, Swing, Position, or Any |

### Hard Rules

Hard rules are pass/fail conditions that apply automatic penalties to the adherence score when violated. Configure the rules that apply to this playbook:

| Rule | What it checks |
|------|----------------|
| **Require Stop Loss** | Trade must have a stop loss set. Violation applies a 12-point penalty. |
| **Minimum Target R** | The planned risk-to-reward ratio must meet this threshold (e.g., 2.0R). Violation applies a 12-point penalty. |
| **Required Strategy** | The trade's strategy field must match this value exactly. |
| **Required Setup** | The trade's setup field must match this value exactly. |
| **Required Tags** | The trade must contain all specified tags (comma-separated). |

!!! info
    Side and timeframe matching are also enforced as hard rules when specified. If a playbook is set to "Long" side, a short trade reviewed against it will receive a penalty.

### Checklist Items

The checklist is the core of the playbook. Each item represents a condition or step you should verify before or during a trade.

1. Click **Add item** to add a checklist entry.
2. For each item, provide:
    - **Label** -- what the item checks (e.g., "Volume above average at entry", "Confirmed support bounce")
    - **Weight** -- how much this item contributes to the score (default: 1, increase for more important items)
    - **Required** -- whether this item is mandatory

3. Click **Save Playbook**.

!!! tip
    Start with 5-8 checklist items. Too many items make reviews tedious; too few fail to capture the nuances of your strategy.

## Reviewing a Trade Against a Playbook

After closing a trade, you can review it against any active playbook:

1. Open a trade from the **Trades** list.
2. In the trade detail view, find the **Playbook Review** section.
3. Select the playbook to review against.
4. Go through the checklist and check each item that was satisfied.
5. Indicate whether you **Followed Plan** overall (Yes/No).
6. Optionally add **Review Notes** for additional context.
7. Click **Save Review**.

TradeTally then calculates the scores and stores the review.

## Adherence Scoring

The adherence score is a 0-100 scale that combines checklist completion with hard rule evaluation.

### How It Works

1. **Checklist Score** -- Calculated as a weighted percentage of checked items:

    ```
    Checklist Score = (Sum of checked item weights / Total weight of all items) x 100
    ```

2. **Rule Evaluation** -- Each hard rule is evaluated against the trade data:
    - Stop loss present (if required)
    - Minimum target R met (if specified)
    - Side matches playbook
    - Timeframe matches playbook
    - Strategy matches (if specified)
    - Setup matches (if specified)
    - Required tags present (if specified)

3. **Penalty Application** -- Each failed rule subtracts a penalty (typically 12 points) from the checklist score.

4. **Final Score**:

    ```
    Adherence Score = max(0, Checklist Score - Total Penalties)
    ```

    The score is clamped between 0 and 100.

### Example

A playbook has 4 checklist items (weight 1 each) and requires a stop loss:

- Trader checks 3 of 4 items: Checklist Score = 75
- Trade has no stop loss: -12 penalty
- **Adherence Score = 75 - 12 = 63**

### Violation Summary

When rules are violated, TradeTally generates a plain-language violation summary. For example:

- "Trade is missing a stop loss."
- "Trade does not meet the minimum planned target R."
- "Trade side does not match the long playbook."

These messages appear in the review detail so you can see exactly what went wrong.

## Timeframe Classification

When a playbook specifies a timeframe, TradeTally automatically classifies the trade's hold time:

| Classification | Hold Duration |
|----------------|---------------|
| Scalper | Less than 15 minutes |
| Day Trading | 15 minutes to 24 hours |
| Swing | 1 to 7 days |
| Position | More than 7 days |

If the trade's timeframe does not match the playbook's expected timeframe, a penalty is applied.

## Adherence Analytics

The Playbooks page includes an analytics section that aggregates data across all your playbook reviews.

### Overview Cards

Four summary cards at the top show:

- **Active playbooks** -- how many playbooks are currently active
- **Reviewed trades** -- total number of trades with playbook reviews
- **Avg adherence** -- the overall average adherence score across all reviews
- **Followed vs broken** -- count of trades where you followed the plan vs broke it

### Per-Playbook Table

A breakdown table shows performance metrics for each playbook:

| Column | Description |
|--------|-------------|
| Playbook | The playbook name |
| Reviewed | Number of trades reviewed against this playbook |
| Win Rate | Percentage of reviewed trades that were profitable |
| Profit Factor | Ratio of gross profits to gross losses |
| Avg R | Average R-value of reviewed trades |
| Adherence | Average adherence score for this playbook |

This table answers the question: "Which of my strategies performs best, and am I following them properly?"

### Recent Reviews

A list of the 20 most recent trade reviews, showing the symbol, date, adherence score, and whether the plan was followed or broken. Click any trade to view its full detail.

## Managing Playbooks

### Editing

Select a playbook from the list to load it into the editor. Modify any field or checklist item, then click **Save Playbook**. Existing reviews are not retroactively recalculated.

### Archiving

Click **Archive** on a playbook to deactivate it. Archived playbooks:

- No longer appear in the review dropdown when scoring trades
- Still retain all historical reviews and analytics data
- Can be viewed by enabling "Include Archived" in the playbook list

### Active vs Archived

Each playbook displays a badge indicating its status:

- **Active** -- available for new trade reviews
- **Archived** -- historical only, no new reviews

## Best Practices

1. **Create one playbook per strategy.** If you trade opening range breakouts and VWAP reversals, create separate playbooks for each.
2. **Be specific with checklist items.** "Good entry" is vague. "Entry within 0.5% of VWAP after a confirmed bounce" is actionable.
3. **Use weights to prioritize.** Give higher weights to the items that most impact trade outcome (e.g., position sizing, stop placement).
4. **Review every trade.** The analytics are only meaningful when you consistently review trades. Skipping reviews creates blind spots.
5. **Compare followed vs broken.** If trades where you "broke plan" still win at a decent rate, your playbook rules may need adjustment.
6. **Monitor adherence trends.** A declining average adherence score is an early warning sign of loosening discipline.
7. **Iterate on playbooks.** As your strategy evolves, update checklist items and rules. Archive playbooks that no longer reflect how you trade.
8. **Use minimum target R.** Setting a minimum reward-to-risk requirement prevents you from taking trades with unfavorable setups.
