#!bin/sh

# Install Mint
brew install mint
mint bootstrap -m ../Mintfile --overwrite y

# Setup Carthage
mint run Carthage carthage bootstrap --platform iOS --cache-builds --use-xcframeworks --project-directory ../

# Generate xcodeproj
mint run xcodegen xcodegen generate -s ../project.yml