# Safari Cache Cleaner

A shell script to automatically clean Safari's CloudKit cache assets when they exceed a specified size threshold.

## Why This Script Was Created

Safari has a known bug where CloudKit assets can accumulate and fill up your entire disk space during active usage. These cached files can grow to enormous sizes (sometimes 100GB+) without any user intervention or notification.

Instead of manually clearing Safari's entire cache (which would log you out of all websites), this script selectively removes only the large CloudKit asset folders while preserving your login sessions and browsing data.

## What It Does

The script:
- Scans Safari's CloudKit cache directories
- Identifies asset folders larger than the configured threshold (default: 20GB)
- Safely removes only the oversized cache files
- Preserves your Safari sessions, passwords, and other browsing data
- Provides clear feedback on what was cleaned

## Requirements

- macOS
- Terminal with Full Disk Access permissions

## Setup

### 1. Grant Full Disk Access to Terminal

This is **required** for the script to access Safari's cache directories.

1. Open **System Preferences** → **Security & Privacy** → **Privacy**
2. Select **Full Disk Access** from the left sidebar
3. Click the lock icon and enter your password
4. Click the **+** button
5. Navigate to `/Applications/Utilities/Terminal.app` and select it
6. Ensure Terminal is checked in the list

### 2. Make Script Executable

```bash
chmod +x SafariCacheCleaner.command
```

## Usage

### Run the Script

You can run the script in two ways:

**Method 1: Terminal**
```bash
./SafariCacheCleaner.command
```

**Method 2: Double-click**
- Simply double-click `SafariCacheCleaner.command` in Finder
- The script will open in Terminal and run automatically

### Configuration

You can modify the size threshold by editing the script:

```bash
# Change this line to adjust the threshold (currently 20GB)
THRESHOLD=$((20 * 1024 * 1024 * 1024))

# Examples:
# 10GB: THRESHOLD=$((10 * 1024 * 1024 * 1024))
# 5GB:  THRESHOLD=$((5 * 1024 * 1024 * 1024))
# 1GB:  THRESHOLD=$((1 * 1024 * 1024 * 1024))
```

## Sample Output

```
Scanning CloudKit assets folders for sizes greater than 20 GB...
✔️  OK: /Users/user/Library/Containers/com.apple.Safari/Data/Library/Caches/CloudKit/abc123/Assets (150 MB)
⚠️  Large folder found: /Users/user/Library/Containers/com.apple.Safari/Data/Library/Caches/CloudKit/def456/Assets (25600 MB)
🧹 Cleaning up...
✅ Cleaned: /Users/user/Library/Containers/com.apple.Safari/Data/Library/Caches/CloudKit/def456/Assets
✅ Cleanup complete.
```

## Safety

- The script only removes files from CloudKit asset directories
- Your Safari bookmarks, passwords, and login sessions remain intact
- The script requires explicit Full Disk Access - it won't run without proper permissions
- Uses safety checks to prevent accidental deletion of wrong directories

## Icon

The application icon was created using [Recraft.ai](https://www.recraft.ai/).

## Troubleshooting

**"Cannot read CloudKit directory" error:**
- Ensure Terminal has Full Disk Access (see Setup section)
- Restart Terminal after granting permissions

**No large folders found:**
- Your Safari cache might already be clean
- Try lowering the threshold if you want to clean smaller caches

## License

The MIT License (MIT)

Copyright © 2025 Heorhii Savoiskyi d3f0ld@proton.me
