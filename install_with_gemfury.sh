#!/bin/bash

# Fail on any error
set -e

echo "Starting installation with Gemfury credentials from .env..."

# Load environment variables from .env if it exists
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo ".env file not found. Please create one with GEMFURY_USERNAME and GEMFURY_PASSWORD."
  exit 1
fi

# Check required env vars
if [ -z "$GEMFURY_USERNAME" ] || [ -z "$GEMFURY_PASSWORD" ]; then
  echo "GEMFURY_USERNAME or GEMFURY_PASSWORD not set in .env"
  exit 1
fi

# Construct the authenticated URL
PIP_EXTRA_INDEX_URL="https://${GEMFURY_USERNAME}:${GEMFURY_PASSWORD}@pypi.fury.io/${GEMFURY_USERNAME}/"

# Choose install method
if [ -f requirements.txt ]; then
  echo "Installing dependencies from requirements.txt..."
  pip install --extra-index-url "$PIP_EXTRA_INDEX_URL" -r requirements.txt
else
  echo "Installing current project (pyproject.toml)..."
  pip install --extra-index-url "$PIP_EXTRA_INDEX_URL" .
fi

echo "Installation complete."
