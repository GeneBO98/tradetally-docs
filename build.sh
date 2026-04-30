#!/bin/bash

set -e

MKDOCS_PATH="${MKDOCS_PATH:-$(command -v mkdocs || true)}"

if [ -z "$MKDOCS_PATH" ]; then
    echo "mkdocs is not installed or not on PATH."
    echo "Install it with: pip install mkdocs mkdocs-material mkdocs-minify-plugin"
    exit 1
fi

echo "Building MkDocs documentation..."
echo ""

"$MKDOCS_PATH" build --clean

echo ""
echo "Build successful!"
echo "Output directory: site/"
