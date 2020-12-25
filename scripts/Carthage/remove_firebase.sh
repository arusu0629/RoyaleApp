# xcode12 で CocoaPods 以外で Firebase をインストールした場合に AppStoreConnect へのアップロードが失敗するための対処法
# 参考：https://blog.ch3cooh.jp/entry/ios/failure_to_upload_to_appstore_when_using_firebase

rm -rf "${TARGET_BUILD_DIR}/${PRODUCT_NAME}.app/Frameworks/FIRAnalyticsConnector.framework"
rm -rf "${TARGET_BUILD_DIR}/${PRODUCT_NAME}.app/Frameworks/FirebaseAnalytics.framework"
rm -rf "${TARGET_BUILD_DIR}/${PRODUCT_NAME}.app/Frameworks/FirebaseCore.framework"
rm -rf "${TARGET_BUILD_DIR}/${PRODUCT_NAME}.app/Frameworks/FirebaseCoreDiagnostics.framework"
rm -rf "${TARGET_BUILD_DIR}/${PRODUCT_NAME}.app/Frameworks/FirebaseCrashlytics.framework"
rm -rf "${TARGET_BUILD_DIR}/${PRODUCT_NAME}.app/Frameworks/FirebaseInstallations.framework"
rm -rf "${TARGET_BUILD_DIR}/${PRODUCT_NAME}.app/Frameworks/FirebaseRemoteConfig.framework"
rm -rf "${TARGET_BUILD_DIR}/${PRODUCT_NAME}.app/Frameworks/GoogleAppMeasurement.framework"
rm -rf "${TARGET_BUILD_DIR}/${PRODUCT_NAME}.app/Frameworks/GoogleDataTransport.framework"
rm -rf "${TARGET_BUILD_DIR}/${PRODUCT_NAME}.app/Frameworks/GoogleMobileAds.framework"
rm -rf "${TARGET_BUILD_DIR}/${PRODUCT_NAME}.app/Frameworks/GoogleUtilities.framework"
rm -rf "${TARGET_BUILD_DIR}/${PRODUCT_NAME}.app/Frameworks/nanopb.framework"
rm -rf "${TARGET_BUILD_DIR}/${PRODUCT_NAME}.app/Frameworks/PromisesObjC.framework"
