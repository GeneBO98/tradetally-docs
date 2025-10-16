#!/bin/bash

# MkDocs build script
# Usage: ./build.sh

MKDOCS_PATH="/Users/brennonoverton/Library/Python/3.9/bin/mkdocs"

echo "Building MkDocs documentation..."
echo ""

$MKDOCS_PATH build --clean

if [ $? -eq 0 ]; then
    echo ""
    echo "Build successful!"
    echo "Output directory: site/"
    echo ""
    echo "To deploy to GitHub Pages, run:"
    echo "  $MKDOCS_PATH gh-deploy"
fi
