# TradeTally Documentation

This repository contains the documentation for TradeTally, built with MkDocs and the Material theme.

## Prerequisites

- Python 3.9+
- `mkdocs`
- `mkdocs-material`
- `mkdocs-minify-plugin`

Install dependencies if needed:

```bash
pip install mkdocs mkdocs-material mkdocs-minify-plugin
```

## Local Development

### Start the docs site

```bash
./serve.sh
```

### Build the static site

```bash
./build.sh
```

Both scripts now use `mkdocs` from your `PATH`. You can also override the executable with `MKDOCS_PATH=/path/to/mkdocs`.

## Project Structure

```text
tradetally-docs/
├── docs/
├── mkdocs.yml
├── build.sh
└── serve.sh
```

## Links

- **Live Demo**: https://tradetally.io
- **GitHub**: https://github.com/GeneBO98/tradetally
- **Docker Hub**: https://hub.docker.com/r/potentialmidas/tradetally
- **Forum**: https://forum.tradetally.io
