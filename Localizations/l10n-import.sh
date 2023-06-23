#!/usr/bin/env bash
set -e
source $(dirname "$0")/l10n-config.sh

if [ ! -d "${TARGET_DIR}" ]; then
    echo "The translations directory is missing. Run 'l10n-export.sh' first."
    exit 1
fi

echo "Importing translations..."
for language in "${TRANSLATIONS[@]}"; do
    xcodebuild -importLocalizations -localizationPath "${TARGET_DIR}/${language}.xcloc" \
        -workspace "${WORKSPACE_FILE_PATH}" ${EXPORT_LANG} \
        -scheme "${PROJECT_NAME}" \
        -disableAutomaticPackageResolution -onlyUsePackageVersionsFromResolvedFile -skipPackageUpdates \
        PRODUCT_NAME="\$(TARGET_NAME)"
done
echo "Done."
