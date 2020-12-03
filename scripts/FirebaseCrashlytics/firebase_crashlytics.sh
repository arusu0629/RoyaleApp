PATH_TO_GOOGLE_PLISTS="${PROJECT_DIR}/RoyaleApp"
if [ "${CONFIGURATION}" = "Release" || "${CONFIGURATION}" = "Staging" ]; then
    "${PROJECT_DIR}/scripts/FirebaseCrashlytics/run" -gsp "$PATH_TO_GOOGLE_PLISTS/GoogleService-Info.plist"
else
    "${PROJECT_DIR}/scripts/FirebaseCrashlytics/run" -gsp "$PATH_TO_GOOGLE_PLISTS/GoogleService-Info-Dev.plist"
fi
