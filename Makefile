PRODUCT_NAME := RoyaleApp
SCHEME_NAME := ${PRODUCT_NAME}
PROJECT_NAME := ${PRODUCT_NAME}.xcodeproj
UI_TESTS_TARGET_NAME := ${PRODUCT_NAME}UITests

TEST_SDK := iphonesimulator
TEST_CONFIGURATION := Debug
TEST_PLATFORM := iOS Simulator
TEST_DEVICE ?= iPhone 11 Pro Max
TEST_OS ?= 13.4.1
TEST_DESTINATION := 'platform=${TEST_PLATFORM},name=${TEST_DEVICE},OS=${TEST_OS}'

.PHONY: setup
setup-with-mint:
	brew update
	brew install mint
	$(MAKE) install-mint
	$(MAKE) install-carthage
	$(MAKE) generate-xcodeproj

.PHONY: setup-without-mint
setup-without-mint:
	$(MAKE) install-mint
	$(MAKE) install-carthage
	$(MAKE) generate-xcodeproj

.PHONY: install-mint
install-mint:
	mint bootstrap --overwrite y

.PHONY: install-carthage
install-carthage:
	./Scripts/Carthage/carthage.sh bootstrap --platform iOS --cache-builds
	@$(MAKE) show-carthage-dependencies


.PHONY: update-carthage
update-carthage:
	./Scripts/Carthage/carthage.sh update --platform iOS --cache-builds
	@$(MAKE) show-carthage-dependencies

.PHONY: show-carthage-dependencies
show-carthage-dependencies:
	@echo '*** Resolved dependencies:'
	@cat 'Cartfile.resolved'

.PHONY: generate-xcodeproj
generate-xcodeproj:
	mint run xcodegen xcodegen generate
	$(MAKE) open

.PHONY: swiftgen
swiftgen:
	mint run SwiftGen/SwiftGen swiftgen

.PHONY: xcodegen
xcodegen:
	mint run XcodeGen xcodegen

.PHONY: open
open:
	open ./${PROJECT_NAME}

.PHONY: show-devices
show-devices:
	instruments -s devices

.PHONY: build-debug
build-debug:
	set -o pipefail && \
xcodebuild \
-sdk ${TEST_SDK} \
-configuration ${TEST_CONFIGURATION} \
-project ${PROJECT_NAME} \
-scheme ${SCHEME_NAME} \
build \
| xcpretty

.PHONY: test
test:
	set -o pipefail && \
xcodebuild \
-sdk ${TEST_SDK} \
-configuration ${TEST_CONFIGURATION} \
-project ${PROJECT_NAME} \
-scheme ${SCHEME_NAME} \
-destination ${TEST_DESTINATION} \
-skip-testing:${UI_TESTS_TARGET_NAME} \
clean test \
| xcpretty

.PHONY: archive-debug
archive-debug:
	set -o pipefail && \
xcodebuild \
-workspace ${PROJECT_NAME}/project.xcworkspace \
-scheme ${SCHEME_NAME} \
-configuration Debug \
archive -archivePath ./build/archive && \
xcodebuild \
-exportArchive -archivePath ./build/archive.xcarchive \
-exportPath ~/Desktop/RoyaleApp-Dev/ -exportOptionsPlist ./build/ExportOptions-Dev.plist \
| xcpretty

.PHONY: archive-release
archive-release:
	set -o pipefail && \
xcodebuild \
-workspace ${PROJECT_NAME}/project.xcworkspace \
-scheme ${SCHEME_NAME} \
-configuration Release \
archive -archivePath ./build/archive && \
xcodebuild \
-exportArchive -archivePath ./build/archive.xcarchive \
-exportPath ~/Desktop/RoyaleApp-Release/ -exportOptionsPlist ./build/ExportOptions-Release.plist \
| xcpretty
