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

.PHONY: bootstrap
bootstrap:
	brew update
	brew install mint
	mint bootstrap
	mint run XcodeGen xcodegen

.PHONY: project
project:
	mint run Carthage/Carthage carthage bootstrap --platform iOS --cache-builds
	mint run Carthage/Carthage carthage update --platform iOS
	mint run SwiftGen/SwiftGen swiftgen
	mint run XcodeGen xcodegen

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