#!/bin/bash

# Fail on any error and print commands
set -euo pipefail

echo "🚀 Preparing environment and running tox..."

# Load .env if it exists
if [ -f .env ]; then
  echo "📦 Loading environment variables from .env"
  set -a
  source .env
  set +a
else
  echo "❌ .env file not found. Please create one with GEMFURY_USERNAME and GEMFURY_PASSWORD."
  exit 1
fi

# Verify required variables
if [ -z "${GEMFURY_USERNAME:-}" ] || [ -z "${GEMFURY_PASSWORD:-}" ]; then
  echo "❌ Required environment variables GEMFURY_USERNAME or GEMFURY_PASSWORD are missing."
  exit 1
fi

# Run tox
echo "🧪 Running tox..."
tox

echo "✅ Tox completed successfully."
