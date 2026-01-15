# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
