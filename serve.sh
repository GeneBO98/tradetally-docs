#!/bin/bash

set -e

MKDOCS_PATH="${MKDOCS_PATH:-$(command -v mkdocs || true)}"

if [ -z "$MKDOCS_PATH" ]; then
    echo "mkdocs is not installed or not on PATH."
    echo "Install it with: pip install mkdocs mkdocs-material mkdocs-minify-plugin"
    exit 1
fi

echo "Starting MkDocs development server..."
echo "Visit: http://127.0.0.1:8000"
echo "Press Ctrl+C to stop"
echo ""

"$MKDOCS_PATH" serve
