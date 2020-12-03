PATH_TO_GOOGLE_PLISTS="${PROJECT_DIR}/RoyaleApp"
if [ "${CONFIGURATION}" = "Release" || "${CONFIGURATION}" = "Staging" ]; then
    "${PROJECT_DIR}/scripts/FirebaseCrashlytics/upload-symbols" -gsp "$PATH_TO_GOOGLE_PLISTS/GoogleService-Info.plist" -p ios "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}"
else
"${PROJECT_DIR}/scripts/FirebaseCrashlytics/upload-symbols" -gsp "$PATH_TO_GOOGLE_PLISTS/GoogleService-Info-Dev.plist" -p ios "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}"
fi
