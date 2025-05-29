#!/bin/zsh

# Set the base path to Safari CloudKit Assets
BASE_PATH="$HOME/Library/Containers/com.apple.Safari/Data/Library/Caches/CloudKit"

# Size threshold in bytes (20 GB)
THRESHOLD=$((20 * 1024 * 1024 * 1024))
# Examples:
# 10GB: THRESHOLD=$((10 * 1024 * 1024 * 1024))
# 5GB:  THRESHOLD=$((5 * 1024 * 1024 * 1024))
# 1GB:  THRESHOLD=$((1 * 1024 * 1024 * 1024))

echo "Scanning CloudKit assets folders for sizes greater than $((THRESHOLD / 1024 / 1024 / 1024)) GB..."
if [ ! -r "$BASE_PATH" ]; then
  echo "❌ Cannot read CloudKit directory. Please grant Full Disk Access to the terminal."
  exit 1
fi

# Loop through each CloudKit subdirectory
find "$BASE_PATH" -type d -name "Assets" | while read -r assets_dir; do
    # Get the size in bytes using find and awk for accurate calculation
    size_bytes=$(find "$assets_dir" -type f -exec stat -f%z {} \; 2>/dev/null | awk '{sum += $1} END {print sum+0}')

    size_mb=$((size_bytes / 1024 / 1024))

    if [ "$size_bytes" -gt "$THRESHOLD" ]; then
        echo "⚠️  Large folder found: $assets_dir (${size_mb} MB)"
        echo "🧹 Cleaning up..."
        rm -rf "${assets_dir:?}/"*
        echo "✅ Cleaned: $assets_dir"
    else
        echo "✔️  OK: $assets_dir (${size_mb} MB)"
    fi
done

echo "✅ Cleanup complete."
