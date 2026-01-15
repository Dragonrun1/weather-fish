# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
