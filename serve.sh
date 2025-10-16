#!/bin/bash

# MkDocs serve script
# Usage: ./serve.sh

MKDOCS_PATH="/Users/brennonoverton/Library/Python/3.9/bin/mkdocs"

echo "Starting MkDocs development server..."
echo "Visit: http://127.0.0.1:8000"
echo "Press Ctrl+C to stop"
echo ""

$MKDOCS_PATH serve
