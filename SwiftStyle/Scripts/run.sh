#!/bin/sh
set -eu

script_directory=$(CDPATH= cd "$(dirname "$0")" && pwd)
source_directory="$script_directory/../Sources/SwiftStyle"
compiler=$(xcrun --find swiftc)
sdk=$(xcrun --sdk macosx --show-sdk-path)
host_libraries=$(CDPATH= cd "$(dirname "$compiler")/../lib/swift/host" && pwd)
cache_root=${SWIFT_STYLE_CACHE:-${HOME}/Library/Caches/SwiftStyle}
cache_key=$({ "$compiler" -sdk "$sdk" -module-cache-path "$cache_root/ModuleCache" --version 2>/dev/null; printf '%s\n' "$compiler" "$sdk"; cat "$source_directory"/*.swift "$script_directory/run.sh"; } | shasum -a 256 | cut -d ' ' -f 1)
binary="$cache_root/$cache_key/swift-style"

if [ ! -x "$binary" ]; then
  mkdir -p "$cache_root/$cache_key"
  build_directory=$(mktemp -d "$cache_root/$cache_key/build.XXXXXX")
  trap 'rm -rf "$build_directory"' EXIT HUP INT TERM
  "$compiler" -sdk "$sdk" -parse-as-library -swift-version 6 \
    -module-cache-path "$cache_root/ModuleCache" \
    -I "$host_libraries" -L "$host_libraries" \
    -Xlinker -rpath -Xlinker "$host_libraries" \
    "$source_directory"/*.swift -o "$build_directory/swift-style"
  mv "$build_directory/swift-style" "$binary"
fi

"$binary" "$@"
