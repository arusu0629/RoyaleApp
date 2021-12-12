#!bin/sh

# Install Mint
brew install mint

# Setup Carthage
mint run Carthage copy-frameworks

# Generate xcodeproj
mint run xcodegen xcodegen generate -s ../project.yml
