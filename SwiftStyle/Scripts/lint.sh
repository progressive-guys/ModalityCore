#!/bin/sh
set -eu

kit_root=$(CDPATH= cd "$(dirname "$0")/.." && pwd)
config_root=${SWIFT_STYLE_CONFIG_ROOT:-$kit_root}

autocorrect=false
if [ "${1:-}" = "--fix" ]; then
  autocorrect=true
  shift
fi

if [ "$#" -eq 0 ]; then
  set -- .
fi

export PATH="${PATH}:${HOME}/.local/bin:/opt/homebrew/bin:/usr/local/bin"
unset SDKROOT

for config in .swiftlint.yml .swiftformat; do
  if [ ! -f "$config_root/$config" ]; then
    echo "SwiftStyle: link $config from the kit into $config_root before running lint." >&2
    exit 1
  fi
done

swiftlint=$(cd "$kit_root" && mise which swiftlint)
swiftformat=$(cd "$kit_root" && mise which swiftformat)

# Use the same architecture for SwiftLint and SourceKit, including when mise runs through Rosetta.
host_arch=$(uname -m)
if [ "$(/usr/sbin/sysctl -n hw.optional.arm64 2>/dev/null || true)" = "1" ]; then
  host_arch=arm64
fi

run_swiftlint() {
  if [ "${1:-}" = --fix ]; then
    /usr/bin/arch "-$host_arch" "$swiftlint" lint --config "$config_root/.swiftlint.yml" --force-exclude --quiet "$@"
  else
    /usr/bin/arch "-$host_arch" "$swiftlint" lint --config "$config_root/.swiftlint.yml" --force-exclude --quiet "$@"
  fi
}

run_swiftformat() {
  format_mode=$1
  shift
  format_status=0
  for input in "$@"; do
    if [ -e "$input" ]; then
      if [ "$format_mode" = fix ]; then
        /usr/bin/arch "-$host_arch" "$swiftformat" "$input" --config "$config_root/.swiftformat" --quiet || format_status=1
      else
        /usr/bin/arch "-$host_arch" "$swiftformat" "$input" --config "$config_root/.swiftformat" --lint --quiet || format_status=1
      fi
    fi
  done
  return "$format_status"
}

# The replacement SwiftStyle engine is unavailable. Run the native tools during builds.
# The CLI and fixture tests report the missing engine separately.
case "${CI:-}" in
  ""|false|0)
    if [ "$autocorrect" = true ]; then
      run_swiftformat fix "$@"
      run_swiftlint --fix "$@"
    fi
    ;;
esac

status=0
run_swiftformat lint "$@" || status=1
run_swiftlint "$@" || status=1
exit "$status"
