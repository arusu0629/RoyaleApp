PATH_TO_GOOGLE_PLISTS="${PROJECT_DIR}/RoyaleApp"
case "${CONFIGURATION}" in
   "Debug" )
       cp -r "$PATH_TO_GOOGLE_PLISTS/GoogleService-Info-Dev.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist" ;;
   "Staging")
       cp -r "$PATH_TO_GOOGLE_PLISTS/GoogleService-Info.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist" ;;
   "Release" )
       cp -r "$PATH_TO_GOOGLE_PLISTS/GoogleService-Info.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist" ;;
      *)
        ;;
esac
