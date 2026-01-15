# weather-fish

[![GitHub release](https://img.shields.io/github/v/release/Dragonrun1/weather-fish?include_prereleases)](https://github.com/Dragonrun1/weather-fish/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Fish Shell Version](https://img.shields.io/badge/fish-%3E%3D%203.6-blue.svg)](https://fishshell.com)

Fast, non-blocking weather for the Fish shell using
[wttr.in](https://wttr.in).

`weather-fish` integrates weather information into your prompt without
overwriting or interfering with existing prompt setups, including Starship
and Tide.

---

## Features

- 🌤 Weather via wttr.in
- ⏱ Configurable TTL caching (default: 15 minutes)
- 🐢 Slow-network detection with automatic backoff
- 🧵 Non-blocking prompt updates
- 🧩 Safe left-prompt prepending (no prompt overwrite)
- 👉 Right-prompt auto-fallback for Starship and Tide
- 🎨 Optional colorized output
- 📁 Per-directory disable via sentinel file
- ⚙️ Format presets and custom formats
- 🔌 Automatic SSH disable (configurable)
- 🧠 Fisher-compatible, zero setup after install
- 🧪 Robust and lightweight (written in pure Fish)

---

## Installation

### Using [fisher](https://github.com/jorgebucaran/fisher) (recommended)

```fish
fisher install Dragonrun1/weather-fish
```

### Manual Installation

Clone the repository and copy the files to your fish configuration directory:

```bash
git clone https://github.com/Dragonrun1/weather-fish.git
cd weather-fish
cp conf.d/*.fish ~/.config/fish/conf.d/
cp functions/*.fish ~/.config/fish/functions/
cp completions/*.fish ~/.config/fish/completions/
```

### Post-installation

Restart your shell or reload the configuration:

```fish
source ~/.config/fish/config.fish
```
## Usage

### Summary of Prompt Support

`weather-fish` automatically detects your environment and places the weather accordingly:

| Environment    | Weather display         | Logic                    |
|----------------|-------------------------|--------------------------|
| **Plain Fish** | Left prompt (prepended) | Wraps `fish_prompt`      |
| **Starship**   | Right prompt            | Uses `fish_right_prompt` |
| **Tide**       | Right prompt            | Uses `fish_right_prompt` |
| **SSH**        | Disabled (default)      | Checks `$SSH_CONNECTION` |

### Command usage

Print the currently cached weather:

```fish
wttr
```

This command **never performs a network request**. It only prints cached data.

> **Note**: `wttr` prints the data exactly as cached (using `echo -n`), so it
> may not append a newline when run directly in the terminal.

Integration is done by wrapping the existing prompt, not redefining it.

## Configuration

All configuration options are optional and global.

### Location

```fish
set -g WTTR_DEFAULT_LOCATION "New York"
```

Accepted values include:

  * City names (e.g., `Berlin`, `New York`, `Paris`)
  * Airport codes (e.g., `SFO`, `LHR`)
  * Domain names (e.g., `@google.com`)
  * `latitude,longitude` (e.g., `-37.817,144.967`)

### Format configuration

#### Presets (recommended)

```fish
set -g WTTR_PRESET compact
```

Available presets:

| Preset    | Output            |
|-----------|-------------------|
| `compact` | `%c %t`           |
| `icon`    | `%c`              |
| `temp`    | `%t`              |
| `full`    | `%l: %c %t %h %w` |

If no preset is matched, the default of `%c%t` is used.

If `WTTR_PRESET` is set, it overrides `WTTR_FORMAT` and the default format.


#### Custom format

To fully control output:

```fish
set -g WTTR_FORMAT "%c %t"
```

If `WTTR_PRESET` is not set, `WTTR_FORMAT` overrides the default format of `%c%t`.

Format strings follow [wttr.in conventions](https://github.com/chubin/wttr.in#format).

### Colorized output

Color output is disabled by default.

Enable it with:

```fish
set -g WTTR_COLOR 1
```

By default, colorized output uses `cyan`.

### SSH and prompt framework guards

By default, weather is disabled in the following environments:

```fish
set -g WTTR_DISABLE_SSH 1
set -g WTTR_DISABLE_STARSHIP 1
set -g WTTR_DISABLE_TIDE 1
```

Set any of these to `0` to force-enable weather in that environment
(e.g., if you want weather in your Starship right prompt).

### Cache and timeout configuration

```fish
set -g WTTR_CACHE_TTL 900
set -g WTTR_BACKOFF 1800
set -g WTTR_TIMEOUT 2
```

| Variable | Default | Description |
|----------|---------|-------------|
| `WTTR_CACHE_TTL` | `900` | Cache duration in seconds (15 minutes). |
| `WTTR_BACKOFF` | `1800` | Backoff duration in seconds after a failed fetch (30 minutes). |
| `WTTR_TIMEOUT` | `2` | Network timeout for `curl` in seconds. |

## Per-directory disable

To disable weather for a specific directory and its subdirectories, create a
sentinel file:

```fish
touch .weather-fish-disable
```

This is useful for:

  * Minimal prompts in repositories
  * Demos or presentations
  * Performance-sensitive environments

## Performance and caching

  * Cache TTL: 15 minutes (configurable via `WTTR_CACHE_TTL`)
  * Network timeout: 2 seconds (configurable via `WTTR_TIMEOUT`)
  * Slow-network backoff: 30 minutes (configurable via `WTTR_BACKOFF`)
  * Cache location:
    * `$XDG_CACHE_HOME/wttr/`
    * Fallback: `~/.cache/wttr/`
    * Data: `.../wttr/data`
    * Metadata: `.../wttr/meta`

Weather data is fetched:

  * Only after prompt rendering
  * Only when the TTL expires
  * Never during shell startup
  * Never when backoff is active

## Dependencies

  * Fish shell ≥ 3.6
  * curl

No additional dependencies are required.

## Design guarantees

  * Existing prompts are never overwritten
  * No blocking I/O during prompt rendering
  * Safe coexistence with Starship and Tide
  * Silent failure on network errors
  * Fisher-idiomatic layout
  * Minimal global state

## Troubleshooting

### No weather is displayed after installation
1. **Wait for the first fetch**: `weather-fish` fetches weather *after* the prompt is rendered. Try pressing Enter once or twice.
2. **Check for errors**: Run `__wttr_fetch` manually to see if there are any network errors (it usually fails silently).
3. **Check cache**: See if `$XDG_CACHE_HOME/wttr/data` (or `~/.cache/wttr/data`) exists and contains data.
4. **Framework conflicts**: If you use Starship or Tide, `weather-fish` defaults to the right prompt. Ensure your terminal is wide enough to show it.
5. **Sentinel file**: Ensure you don't have a `.weather-fish-disable` file in your current or parent directories.

### Weather is not updating
`weather-fish` uses a configurable cache (default: 15 minutes). It will not fetch new data until the TTL expires. You can force an update by deleting the `meta` file in the cache directory or by reducing `WTTR_CACHE_TTL`.

