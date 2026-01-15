# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
