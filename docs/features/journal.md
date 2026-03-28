# Trading Journal

Document your daily market outlook, trading plans, and post-session reflections.

## Overview

The Trading Journal (also called Diary) is where you record your thoughts before, during, and after each trading session. Consistent journaling helps you identify patterns in your decision-making, track whether you followed your plan, and build discipline over time.

Navigate to **Journal** from the main sidebar to access the journal.

## Views

The journal page offers four views, accessible from the toggle bar at the top:

| View | Purpose |
|------|---------|
| **List** | Chronological list of all journal entries with filters |
| **Calendar** | Monthly calendar showing which days have entries |
| **Templates** | Manage reusable entry templates |
| **AI Analysis** | AI-powered analysis of your journal entries over a date range |

## Entry Types

Each journal entry has a type that categorizes its purpose:

- **Diary** -- General daily reflection and market notes. The default entry type.
- **Playbook** -- Structured plan entries tied to a specific trading strategy.

You can filter entries by type using the **Type** dropdown in the filter bar.

## Creating a Journal Entry

1. Click the **New Entry** button in the top-right corner.
2. Optionally select a template to pre-fill the form (see [Templates](#templates) below).
3. Fill in the entry fields:

| Field | Description |
|-------|-------------|
| **Entry Date** | The date this entry applies to (defaults to today) |
| **Entry Type** | Diary or Playbook |
| **Title** | A short summary of the day or session |
| **Market Bias** | Your directional outlook: Bullish, Bearish, or Neutral |
| **Content** | The main body of your journal entry (free-form text) |
| **Key Levels** | Important price levels you are watching |
| **Watchlist** | Symbols you plan to trade or monitor |
| **Tags** | Custom labels for organizing entries (e.g., "earnings", "fed-day") |
| **Followed Plan** | Whether you stuck to your trading plan (Yes/No) |
| **Lessons Learned** | Key takeaways from the session |

4. Click **Save** to create the entry.

!!! tip
    If an entry already exists for the selected date and entry type, TradeTally will ask whether you want to append to or overwrite the existing entry.

## Editing and Deleting Entries

- To edit an entry, click on it from the list or calendar view to open the detail page, then click **Edit**.
- To delete an entry, open it and click **Delete**. This action is permanent.

## Image Attachments

You can upload images to any journal entry (e.g., chart screenshots, market analysis). Images are automatically compressed to WebP format to save storage space.

- Upload images from the entry detail page.
- Each image is stored privately and only accessible to the entry owner.
- Delete individual images from the attachment list.

## Filtering and Search

The filter bar at the top of the list view provides several ways to narrow down entries:

| Filter | Options |
|--------|---------|
| **Type** | All Types, Diary, Playbook |
| **Market Bias** | All Bias, Bullish, Bearish, Neutral |
| **Start Date** | Show entries on or after this date |
| **End Date** | Show entries on or before this date |
| **Search** | Free-text search across titles, content, key levels, and lessons learned |

### Tag Search

Type `#` followed by a tag name in the search box to search by tag. As you type, matching tags from your existing entries will appear as suggestions.

## Templates

Templates let you save pre-filled journal structures so you can start each entry from a consistent format.

### Creating a Template

1. Switch to the **Templates** view from the toggle bar.
2. Click **New Template**.
3. Fill in the template fields:
    - **Name** -- a descriptive name (e.g., "Pre-Market Plan", "Post-Session Review")
    - **Description** -- optional summary of when to use this template
    - **Entry Type** -- Diary or Playbook
    - All other journal fields (title, content, market bias, key levels, watchlist, tags, etc.)
4. Optionally mark the template as **Default** for its entry type.
5. Click **Save**.

### Using a Template

When creating a new journal entry, a "Use a Template" section appears at the top of the form. Click any template to pre-fill the form fields with the template's values. You can then modify any field before saving.

### Managing Templates

- **Edit** -- Update any template from the Templates view.
- **Duplicate** -- Create a copy of an existing template with a new name.
- **Set as Default** -- The default template auto-loads when creating a new entry of that type. Only one default per entry type.
- **Delete** -- Remove a template permanently.

Templates track a **use count** that increments each time you apply them, helping you identify your most-used formats.

## AI Analysis

The AI Analysis view uses your configured AI provider (Google Gemini or compatible) to analyze journal entries over a date range and provide actionable feedback.

### Running an Analysis

1. Switch to the **AI Analysis** view from the toggle bar.
2. Select a **Start Date** and **End Date** for the analysis period.
3. Click **Analyze**.
4. The AI reviews all entries in the range and generates a report covering:
    - **Summary** of the trading period
    - **Strengths** identified in your journaling
    - **Areas for improvement**
    - **Key insights** about trading psychology and discipline
    - **Actionable recommendations** (3-5 specific steps)
    - **Risk management assessment**
    - **Emotional discipline** evaluation

!!! info
    AI Analysis requires a configured AI provider. If you see an error about "AI provider not configured", check your AI settings in **Settings** > **Preferences**.

!!! note
    The analysis is only as good as the detail in your entries. More thorough journal entries produce more useful AI feedback.

## Statistics

TradeTally tracks journal statistics including:

- **Total entries** by type
- **Market bias distribution** (bullish, bearish, neutral days)
- **Plan adherence rate** (percentage of entries where you followed your plan)

These statistics help you understand your journaling consistency and identify trends in your market outlook.

## Best Practices

1. **Write daily.** Even on days you do not trade, documenting your market analysis builds the habit and creates a reference library.
2. **Be specific.** Instead of "market was choppy", note specific levels, catalysts, and how price reacted at key zones.
3. **Record your plan before trading.** Use the pre-market fields (market bias, key levels, watchlist) to commit to a plan before the session begins.
4. **Review honestly.** The "Followed Plan" and "Lessons Learned" fields are most valuable when you are candid about mistakes.
5. **Use tags consistently.** Tags like "overtraded", "revenge-trade", "a-plus-setup", or "earnings" make it easy to search for patterns later.
6. **Use templates.** Create templates for your common entry types so you spend less time formatting and more time reflecting.
7. **Run AI analysis regularly.** A weekly or monthly AI review can surface patterns you might not notice day-to-day.
