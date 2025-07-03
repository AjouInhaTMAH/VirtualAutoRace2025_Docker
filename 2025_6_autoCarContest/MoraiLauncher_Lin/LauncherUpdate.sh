#!/bin/sh

# Run the Update
echo "[INFO] Launcher Update will start running..."
SIMULATOR_TRUE_SCRIPT_NAME=$(echo \"$0\" | xargs readlink -f)
SIMULATOR_PROJECT_ROOT=$(dirname "$SIMULATOR_TRUE_SCRIPT_NAME")
echo ${SIMULATOR_TRUE_SCRIPT_NAME}, ${SIMULATOR_PROJECT_ROOT}
chmod +x $SIMULATOR_PROJECT_ROOT/MoraiLauncher_Lin_Data/LauncherUpdater/LauncherUpdater_Lin.x86_64
/$SIMULATOR_PROJECT_ROOT/MoraiLauncher_Lin_Data/LauncherUpdater/LauncherUpdater_Lin.x86_64

