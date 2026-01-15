# weather-fish

Fast, non-blocking weather for the Fish shell using
[wttr.in](https://wttr.in).

`weather-fish` integrates weather information into your prompt without
overwriting or interfering with existing prompt setups, including Starship
and Tide.

---

## Features

- 🌤 Weather via wttr.in
- ⏱ 15-minute TTL caching
- 🐢 Slow-network detection with automatic backoff
- 🧵 Non-blocking prompt updates
- 🧩 Safe left-prompt prepending (no prompt overwrite)
- 👉 Right-prompt auto-fallback for Starship and Tide
- 🎨 Optional colorized output
- 📁 Per-directory disable via sentinel file
- ⚙️ Format presets and custom formats
- 🔌 Automatic SSH disable (configurable)
- 🧠 Fisher-compatible, zero setup after install

---

## Installation

Using [fisher](https://github.com/jorgebucaran/fisher):

```fish
fisher install Dragonrun1/weather-fish
```

Restart your shell or reload configuration:

```fish
source ~/.config/fish/config.fish
```
## Usage

### Command usage

Print the currently cached weather:

```fish
wttr
```

This command **never performs a network request**. It only prints cached data.

### Prompt usage (automatic)

| Environment | Weather display         |
| ----------- | ----------------------- |
| Plain Fish  | Left prompt (prepended) |
| Starship    | Right prompt            |
| Tide        | Right prompt            |
| SSH         | Disabled (default)      |

Integration is done by wrapping the existing prompt, not redefining it.

## Configuration

All configuration options are optional and global.

### Location

```fish
set -g WTTR_DEFAULT_LOCATION Berlin
```

Accepted values include:

  * City names
  * Airport codes
  * `latitude,longitude`

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

Presets override the default format.


#### Custom format

To fully control output:

```fish
set -g WTTR_FORMAT "%c %t"
```

If `WTTR_FORMAT` is set, it overrides presets.

Format strings follow wttr.in conventions.

### Colorized output

Color output is disabled by default.

Enable it with:

```fish
set -g WTTR_COLOR 1
```

Currently, the weather segment is rendered using `set_color cyan`.

### SSH and prompt framework guards

By default, weather is disabled in the following environments:

```fish
set -g WTTR_DISABLE_SSH 1
set -g WTTR_DISABLE_STARSHIP 1
set -g WTTR_DISABLE_TIDE 1
```

Set any of these to `0` to force-enable weather in that environment.

## Per-directory disable

To disable weather for a specific directory and its subdirectories, create a sentinel file:

```fish
touch .weather-fish-disable
```

This is useful for:

  * Minimal prompts in repositories
  * Demos or presentations
  * Performance-sensitive environments

## Performance and caching

  * Cache TTL: 15 minutes
  * Network timeout: 2 seconds
  * Slow-network backoff: 30 minutes
  * Cache location:
    * `$XDG_CACHE_HOME/wttr/`
    * Fallback: `~/.cache/wttr/`

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

