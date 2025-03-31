#!/bin/bash

# Check if an argument is provided
if [ -z "$1" ]; then
  # No argument provided, use the default path
  INDEX_JS_PATH="build/index.js"
else
  # Argument provided, use it as the path
  INDEX_JS_PATH="$1"
fi

echo "Using index.js path: $INDEX_JS_PATH"

# Run the inspector command with the determined path
npx @modelcontextprotocol/inspector node "$INDEX_JS_PATH"
