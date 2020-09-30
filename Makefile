PROJECT_NAME := RoyaleApp
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

.PHONY: project
project:
	mint run Carthage/Carthage carthage bootstrap --platform iOS --cache-builds
	mint run Carthage/Carthage carthage update --platform iOS
	mint run SwiftGen/SwiftGen swiftgen

.PHONY: open
open:
	open ./${PROJECT_NAME}
