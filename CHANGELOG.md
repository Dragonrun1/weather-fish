# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.17] - 2026-01-15

### Added
- GitHub Actions workflow to automatically create releases when a new
  version tag is pushed, using the corresponding `CHANGELOG.md` entry
  as release notes.
- `.gitignore` rule to ignore generated project archive ZIP files.

## [0.2.16] - 2026-01-15

### Changed
- Normalized environment variable assignment syntax in
  `config.fish.example` to use Fish-style `VAR=value` for consistency
  and correctness.

## [0.2.15] - 2026-01-15

### Fixed
- Prevent duplicate weather output during Fish 4.x transient prompt renders.
- Avoid duplicate background fetch hooks when the plugin is re-sourced or reloaded.

### Compatibility
- Verified compatibility with Fish shell 3.8 and newer, including Fish 4.x.

## [v0.2.14] - 2026-01-15

### Added
- Integrated `doctest.fish` test suite for verifying documentation examples.
- Added `tests/run_tests.fish` test runner.
- Added testable examples to core functions.
- Updated README with testing instructions.

## [v0.2.13] - 2026-01-15

### Added
- Instructions and support for using `weather-fish` as a native Starship custom module.
- Modified `__wttr_fetch` to allow background updates even when Starship integration is disabled, provided it's being called from within a Starship shell.

## [v0.2.12] - 2026-01-15

### Added
- `WTTR_PROMPT_SIDE` variable to choose between `left` (default) and `right` prompt for Fish, Starship, and Tide.
- Improved fallback logic for `fish_right_prompt` to automatically show weather when prompt wrapping is disabled or not explicitly handled.
- New `__wttr_right_wrap` function for right-prompt integration.

### Changed
- Refactored internal scripts to centralize cache logic in `__wttr_cache_dir`.
- Modernized directory-enabled check with cleaner path traversal.
- Updated defaults: `WTTR_DISABLE_STARSHIP` and `WTTR_DISABLE_TIDE` now default to `0` (enabled) for better out-of-the-box experience.
- `config.fish.example` now uses `export` as the recommended configuration method.

### Fixed
- Improved consistency of weather display across different prompt frameworks.

## [v0.2.11] - 2026-01-15

### Fixed
- Removed extra trailing space in `__wttr_left_wrap` to prevent visual gaps in Powerline-style prompts.

## [v0.2.10] - 2026-01-15

### Changed
- Updated README to clarify that `argparse` (a Fish built-in) is used, confirming the Fish shell ≥ 3.6 dependency.

## [v0.2.9] - 2026-01-15

### Added
- Native Tide prompt integration via `_tide_item_wttr`.
- Automatic addition of `wttr` to `tide_left_prompt_items` if Tide is detected and the item is not already configured.

### Changed
- Default weather display for Tide is now the left prompt (as a Tide item) instead of the right prompt fallback.

## [v0.2.8] - 2026-01-15

### Fixed
- Fixed `fish_right_prompt` to correctly respect `WTTR_DISABLE_TIDE` and `WTTR_DISABLE_STARSHIP` values. This allows users to disable the automatic right-prompt display (by setting them to `0`) when manually integrating `wttr` into their left prompt.
- Added documentation for manual left-prompt integration with the Tide framework.

## [v0.2.7] - 2026-01-15

### Fixed
- Fixed "white triangles" issue in Powerline prompts (Tide, Starship) by allowing `WTTR_COLOR` to include background colors, preventing prompt segment background reset.

## [v0.2.6] - 2026-01-15

### Fixed
- Fixed environment guards (SSH, Starship, Tide) to correctly respect a value of `0` (enabled) instead of only checking if the variable was set.

## [v0.2.5] - 2026-01-15

### Added
- Added `-v` / `--verbose` option to `wttr-fetch` for detailed output during the fetch process, including cache status and network requests.

## [v0.2.4] - 2026-01-15

### Fixed
- Improved detection for Tide prompt framework (version 6+) by checking for the `tide` function, ensuring weather correctly falls back to the right prompt.

## [v0.2.3] - 2026-01-15

### Fixed
- Fixed `wttr-fetch` to pick up changes from the configuration file immediately by re-loading it before performing a fetch.

## [v0.2.2] - 2026-01-15

### Added
- `config.fish.example` file to the project root, providing a commented template for user configuration.

## [v0.2.1] - 2026-01-15

### Changed
- Replaced TOML configuration file with a native Fish configuration file (`~/.config/weather-fish/config.fish`). This removes the need for a custom parser and allows for more flexible configuration using Fish syntax.

### Removed
- `__wttr_load_config` internal helper function.

## [v0.2.0] - 2026-01-15

### Added
- Support for TOML configuration file at `~/.config/weather-fish/config.toml`.
- New configuration options: `WTTR_UNITS` and `WTTR_LANGUAGE`.
- Internal helper `__wttr_load_config` for parsing the TOML configuration.

## [v0.1.9] - 2026-01-15

### Added
- New `wttr-fetch` command to force a network update and display the result. This simplifies manual testing and configuration.
- Shell completions for `wttr-fetch`.

## [v0.1.8] - 2026-01-15

### Changed
- Increased default network timeout (`WTTR_TIMEOUT`) from 2 to 30 seconds to improve reliability on slower connections.

## [v0.1.7] - 2026-01-15

### Added
- Manual testing instructions to the Troubleshooting section of README.

## [v0.1.6] - 2026-01-15

### Fixed
- Robust URL handling for locations with spaces.
- Corrected `curl` command to quote URL and use modern redirection (`2>/dev/null`).

## [v0.1.5] - 2026-01-15

### Changed
- Updated README to clarify that `WTTR_DEFAULT_LOCATION` is optional and defaults to IP-based geolocation.

## [v0.1.4] - 2026-01-15

### Added
- "Updating" section to README for both Fisher and manual installation methods.

## [v0.1.3] - 2026-01-15

### Fixed
- "Invalid number" error in `__wttr_fetch` by adding validation for cache metadata.

## [v0.1.2] - 2026-01-14

### Added
- Configurable cache TTL, backoff duration, and network timeout.
- New configuration variables: `WTTR_CACHE_TTL`, `WTTR_BACKOFF`, and `WTTR_TIMEOUT`.
- SPDX license headers to all scripts for better compliance and tracking.
- Status badges (Release, License, Fish version) to README.
- Detailed troubleshooting and manual installation sections in README.

### Changed
- Converted `LICENSE` to `LICENSE.md` (formatted Markdown).
- Improved README layout and clarified configuration priority (Presets vs Format).
- Updated default format to `%c%t` (no space) to match implementation.
- Refactored `__wttr_left_wrap` to skip transient prompt re-rendering.

## [v0.1.1] - 2026-01-14

### Added
- Configurable guards for SSH, Starship, and Tide environments.
- Helper functions for better weather integration and formatting.
- Detailed README with usage, installation, and configuration instructions.
- Support for per-directory disabling via `.weather-fish-disable` sentinel file.

### Fixed
- Updated `.gitignore` to include `.idea/` directory.

## [v0.1.0] - 2026-01-14

### Added
- Initial release of `weather-fish`.
- Fast, non-blocking weather integration for Fish shell.
- 15-minute TTL caching and slow-network detection.
- Support for various format presets.
