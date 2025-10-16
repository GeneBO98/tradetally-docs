# TradeTally Documentation

This repository contains the documentation for TradeTally, built with MkDocs and Material theme.

## Building the Documentation

### Prerequisites

- Python 3.9+
- MkDocs and dependencies (already installed)

### Quick Start

**Easy way** - Use the provided scripts:

```bash
# Start development server
./serve.sh

# Build static site
./build.sh
```

**Manual way** - Use MkDocs directly:

```bash
# Start development server
/Users/brennonoverton/Library/Python/3.9/bin/mkdocs serve

# Build static site
/Users/brennonoverton/Library/Python/3.9/bin/mkdocs build
```

### Development

Run the documentation site locally:

```bash
./serve.sh
```

The site will be available at `http://127.0.0.1:8000`

Press `Ctrl+C` to stop the server.

### Building

Build the static site:

```bash
./build.sh
```

The built site will be in the `site/` directory.

### Installation (if needed)

If MkDocs is not installed:

```bash
pip install mkdocs mkdocs-material mkdocs-minify-plugin --break-system-packages
```

## Project Structure

```
tradetally-docs/
├── docs/
│   ├── index.md                       # Home page
│   ├── getting-started/
│   │   ├── installation.md            # Installation guide
│   │   ├── quick-start.md             # Quick start guide
│   │   └── api-keys.md                # API configuration
│   ├── deployment/
│   │   └── docker.md                  # Docker deployment
│   ├── usage/
│   │   └── importing-trades.md        # Trade import guide
│   ├── features/
│   │   ├── dashboard.md               # Dashboard features
│   │   └── analytics.md               # Analytics features
│   └── stylesheets/
│       └── extra.css                  # Custom styles
├── mkdocs.yml                         # MkDocs configuration
└── README.md                          # This file
```

## Contributing

To add or update documentation:

1. Edit the relevant `.md` file in the `docs/` directory
2. Test locally with `mkdocs serve`
3. Commit and push changes
4. Documentation will be automatically built and deployed

## MkDocs Material Features

This documentation uses MkDocs Material theme with:

- Instant loading
- Dark/light mode toggle
- Search with suggestions
- Code block copying
- Tabbed content
- Admonitions (notes, warnings, etc.)
- Navigation tabs
- Table of contents

## Links

- **Live Demo**: https://tradetally.io
- **GitHub**: https://github.com/GeneBO98/tradetally
- **Docker Hub**: https://hub.docker.com/r/potentialmidas/tradetally
- **Forum**: https://forum.tradetally.io

## License

Documentation is part of the TradeTally project.
