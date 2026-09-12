#!/bin/bash
set -e

# Find Python in venv (direnv or GitHub Actions)
if [ -f ".direnv/python-3.14/bin/python3.14" ]; then
  PYTHON=".direnv/python-3.14/bin/python3.14"
elif [ -f ".venv/bin/python" ]; then
  PYTHON=".venv/bin/python"
elif [ -f "venv/bin/python" ]; then
  PYTHON="venv/bin/python"
else
  PYTHON="python3"
fi

# Prepare documentation structure
rm -rf docs/services
mkdir -p docs/services

# Copy services index
cp services/index.md docs/services/ 2>/dev/null || true

# Copy each service with its directory structure
for service in services/*/; do
  service_name=$(basename "$service")
  if [ -d "$service/docs" ]; then
    mkdir -p "docs/services/$service_name"
    cp -r "$service/docs"/* "docs/services/$service_name/" 2>/dev/null || true
  fi
  if [ -d "$service/design" ]; then
    mkdir -p "docs/services/$service_name"
    cp -r "$service/design"/* "docs/services/$service_name/" 2>/dev/null || true
  fi
done

# Build first to ensure latest content, then serve with hot reload
"$PYTHON" -m zensical build -f zensical.toml
"$PYTHON" -m zensical serve -f zensical.toml
