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

## Updating

### Using fisher

```fish
fisher update Dragonrun1/weather-fish
```

### Manual Update

Pull the latest changes from the repository and overwrite the files:

```bash
cd weather-fish
git pull
cp conf.d/*.fish ~/.config/fish/conf.d/
cp functions/*.fish ~/.config/fish/functions/
cp completions/*.fish ~/.config/fish/completions/
```

Restart your shell or reload the configuration.

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

To force a network fetch and update the cache:

```fish
wttr-fetch
```

This is useful during configuration to see your changes immediately. For more detailed information about the fetch process (e.g., cache status, network requests), use the verbose flag:

```fish
wttr-fetch --verbose
```

> **Note**: `wttr` prints the data exactly as cached (using `echo -n`), so it
> may not append a newline when run directly in the terminal. `wttr-fetch`
> appends a newline for better readability.

Integration is done by wrapping the existing prompt, not redefining it.

## Configuration

All configuration options are optional and global.

### Location

By default, `weather-fish` uses your IP address to determine your location. You
can override this by setting a default location in your `config.fish` (main or plugin-specific):

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

### Units and Localization

You can configure units and language for the weather data:

```fish
# Units: m (metric), u (USCS), or any other wttr.in supported unit flag
set -g WTTR_UNITS "m"

# Language: en, fr, de, etc.
set -g WTTR_LANGUAGE "fr"
```

### Fish Configuration file

Instead of environment variables in `config.fish`, you can use a separate configuration file located at `~/.config/weather-fish/config.fish`. This file is sourced automatically if it exists.

An example configuration file is provided in the project root as `config.fish.example`. You can use it as a starting point:

```bash
mkdir -p ~/.config/weather-fish
cp config.fish.example ~/.config/weather-fish/config.fish
```

Example `config.fish`:

```fish
# weather-fish configuration
set -g WTTR_DEFAULT_LOCATION "Paris"
set -g WTTR_UNITS "m"
set -g WTTR_LANGUAGE "fr"
set -g WTTR_COLOR 1
set -g WTTR_CACHE_TTL 3600
set -g WTTR_PRESET "compact"
```

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
set -g WTTR_TIMEOUT 30
```

| Variable | Default | Description |
|----------|---------|-------------|
| `WTTR_CACHE_TTL` | `900` | Cache duration in seconds (15 minutes). |
| `WTTR_BACKOFF` | `1800` | Backoff duration in seconds after a failed fetch (30 minutes). |
| `WTTR_TIMEOUT` | `30` | Network timeout for `curl` in seconds. |

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
  * Network timeout: 30 seconds (configurable via `WTTR_TIMEOUT`)
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
3. **Force a fetch**: You can use the `wttr-fetch` command to bypass the cache and see what's happening. Use the verbose flag for more details:
   ```fish
   wttr-fetch --verbose
   ```
   This will show cache status, URL being fetched, and any errors from `curl`.
4. **Check cache**: See if `$XDG_CACHE_HOME/wttr/data` (or `~/.cache/wttr/data`) exists and contains data.
5. **Framework conflicts**: If you use Starship or Tide, `weather-fish` defaults to the right prompt. Ensure your terminal is wide enough to show it.
6. **Sentinel file**: Ensure you don't have a `.weather-fish-disable` file in your current or parent directories.

### Weather is not updating
`weather-fish` uses a configurable cache (default: 15 minutes). It will not fetch new data until the TTL expires. You can force an update by deleting the `meta` file in the cache directory or by reducing `WTTR_CACHE_TTL`.

