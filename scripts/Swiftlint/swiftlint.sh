if which mint >/dev/null; then
  mint run swiftlint swiftlint --fix --format
  mint run swiftlint swiftlint
else
  echo "warning: Mint not installed, download from https://github.com/yonaskolb/Mint"
fi
