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
- 👉 Right-prompt auto-fallback for Fish, Starship, and Tide
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

| Environment    | Weather display            | Logic                    |
|----------------|----------------------------|--------------------------|
| **Plain Fish** | Left (default) or Right    | Wraps prompt functions   |
| **Starship**   | Left (default) or Right    | Wraps prompt functions   |
| **Tide**       | Left (default) or Right    | Uses Tide's item system  |
| **SSH**        | Disabled (default)         | Checks `$SSH_CONNECTION` |

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

All configuration options are optional. The recommended way to configure `weather-fish` is via its own configuration file.

### Fish Configuration file (Recommended)

You can use a separate configuration file located at `~/.config/weather-fish/config.fish`. This file is sourced automatically if it exists.

An example configuration file is provided in the project root as `config.fish.example`. You can use it as a starting point:

```fish
mkdir -p ~/.config/weather-fish
cp config.fish.example ~/.config/weather-fish/config.fish
```

When using this file, we recommend using `export` to ensure the variables are available to the fetch process:

```fish
# ~/.config/weather-fish/config.fish

export WTTR_DEFAULT_LOCATION="Paris"
export WTTR_UNITS="m"
export WTTR_LANGUAGE="fr"
export WTTR_COLOR=1
export WTTR_CACHE_TTL=3600
export WTTR_PRESET="compact"
```

### Configuration Options

#### Location

By default, `weather-fish` uses your IP address to determine your location. You
can override this by setting `WTTR_DEFAULT_LOCATION`.

Accepted values include:

  * City names (e.g., `Berlin`, `New York`, `Paris`)
  * Airport codes (e.g., `SFO`, `LHR`)
  * Domain names (e.g., `@google.com`)
  * `latitude,longitude` (e.g., `-37.817,144.967`)

#### Format & Presets

##### Presets (recommended)

Available presets via `WTTR_PRESET`:

| Preset    | Output            |
|-----------|-------------------|
| `compact` | `%c %t`           |
| `icon`    | `%c`              |
| `temp`    | `%t`              |
| `full`    | `%l: %c %t %h %w` |

If no preset is matched, the default of `%c%t` is used. If `WTTR_PRESET` is set, it overrides `WTTR_FORMAT`.

##### Custom format

To fully control output, set `WTTR_FORMAT`. Format strings follow [wttr.in conventions](https://github.com/chubin/wttr.in#format).

#### Units and Localization

*   `WTTR_UNITS`: `m` (metric), `u` (USCS), or any other wttr.in supported unit flag.
*   `WTTR_LANGUAGE`: `en`, `fr`, `de`, etc.

#### Colorized output

Color output is disabled by default. Enable it by setting `WTTR_COLOR` to `1`.

By default, colorized output uses `cyan`. To match your prompt's background (and avoid "white triangles" or broken segments in frameworks like Tide), you can pass a full `set_color` string:

```fish
export WTTR_COLOR="--background blue cyan"
```

#### Cache and timeout configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `WTTR_CACHE_TTL` | `900` | Cache duration in seconds (15 minutes). |
| `WTTR_BACKOFF` | `1800` | Backoff duration in seconds after a failed fetch (30 minutes). |
| `WTTR_TIMEOUT` | `30` | Network timeout for `curl` in seconds. |

#### SSH and prompt framework guards

By default, weather is enabled in all environments. You can disable it for specific frameworks by setting these to `1`:

| Variable | Default | Description |
|----------|---------|-------------|
| `WTTR_DISABLE_SSH` | `1` | Set to `1` to disable in SSH sessions (default). |
| `WTTR_DISABLE_STARSHIP` | `0` | Set to `1` to disable when Starship is detected. |
| `WTTR_DISABLE_TIDE` | `0` | Set to `1` to disable when Tide is detected. |

When Starship is detected but its integration is disabled (`WTTR_DISABLE_STARSHIP=1`), or when Tide is used but `wttr` is not in its prompt items, `weather-fish` will automatically fall back to showing the weather in the right prompt (`fish_right_prompt`).

#### Prompt Side

| Variable | Default | Description |
|----------|---------|-------------|
| `WTTR_PROMPT_SIDE` | `left` | Position of weather for plain Fish, Starship, and Tide (`left` or `right`). |

### Overriding configuration in a session

You can override any configuration option in your current terminal session.

#### With exporting

If you want the change to take effect for future weather fetches in the current session (recommended):

```fish
export WTTR_PRESET="full"
```

#### Without exporting (Global variables)

You can also set a global fish variable, which will be picked up by the next fetch:

```fish
set -g WTTR_PRESET "full"
```

Note that `export` (which sets an environment variable) is generally preferred for ensuring the background fetch process sees the updated value immediately.

### Tide Integration

`weather-fish` provides a custom Tide item `wttr` via the `functions/_tide_item_wttr.fish` file. It automatically attempts to add `wttr` to your `tide_left_prompt_items` (or `tide_right_prompt_items` if `WTTR_PROMPT_SIDE` is set to `right`) if it's not already present in either left or right prompt items.

For more information on customizing Tide, see the [Tide documentation](https://github.com/IlanCosman/tide).

If you want to move it to the right prompt:

```fish
export WTTR_PROMPT_SIDE=right
```

Alternatively, you can manually manage Tide items:
1.  **Remove from the left prompt**:
    ```fish
    set -e (contains -i wttr $tide_left_prompt_items)
    ```
2.  **Add to the right prompt**:
    ```fish
    set -gp tide_right_prompt_items wttr
    ```

### Starship Integration

`weather-fish` prepends the weather to your `fish_prompt` by wrapping it, which works seamlessly with Starship as it also relies on `fish_prompt`. By default, it is enabled when Starship is detected and placed in the left prompt.

For more information on configuring Starship, see the [Starship documentation](https://starship.rs).

#### Change Prompt Side

If you want to move the weather to the right prompt while using Starship, Tide, or plain Fish:

```fish
export WTTR_PROMPT_SIDE=right
```

#### Native Starship Module (Custom Module)

For even better integration, you can use `weather-fish` as a [Starship custom module](https://starship.rs/config/#custom-commands). This allows you to place the weather anywhere in your Starship layout and leverage Starship's styling.

1.  **Disable automatic integration** in your Fish config to prevent double-printing in the prompt:
    ```fish
    export WTTR_DISABLE_STARSHIP=1
    ```
    *Note: Even when disabled, background fetching continues to work when called by Starship.*

2.  **Add the custom module** to your `~/.config/starship.toml`:
    ```toml
    [custom.weather]
    command = "wttr"
    when = "true"
    shell = ["fish", "--command"]
    format = "[$output]($style) "
    style = "cyan" # Match your WTTR_COLOR if desired
    ```

3.  **Add the module to your prompt** by adding `${custom.weather}` to the `format` or `right_format` in `starship.toml`.

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

  * Fish shell ≥ 3.6 (uses `argparse`)
  * curl

No additional dependencies are required.

## Testing

`weather-fish` uses `doctest.fish` to verify that documentation examples remain correct.

To run the tests, use the provided test runner:

```fish
fish tests/run_tests.fish
```

This will extract examples from the function files and verify them against the actual implementation.

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
5. **Framework conflicts**: If you use Tide, `weather-fish` defaults to the left prompt. Ensure your terminal is wide enough to show it.
6. **Sentinel file**: Ensure you don't have a `.weather-fish-disable` file in your current or parent directories.

### Weather is not updating
`weather-fish` uses a configurable cache (default: 15 minutes). It will not fetch new data until the TTL expires. You can force an update by deleting the `meta` file in the cache directory or by reducing `WTTR_CACHE_TTL`.

