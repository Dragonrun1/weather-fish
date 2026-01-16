# Contributing to weather-fish

:+1::tada: First off, thanks for taking the time to contribute! :tada::+1:

weather-fish aims to be a small, reliable, and Fish-native plugin. Contributions
that improve correctness, clarity, or maintainability are very welcome.

---

## Code of Conduct

Please note that this project has a [Contributor Covenant Code of Conduct]. By
participating in this project, you agree to abide by its terms. Instances of
abusive, harassing, or otherwise unacceptable behavior may be reported to the
project maintainer at:

* [mailto:mgcummings@yahoo.com?subject=CoC%20weather-fish](mailto:mgcummings@yahoo.com?subject=CoC%20weather-fish)

---

## What to contribute

Good candidates for contributions include:

* Bug fixes (especially Fish-version-specific issues)
* Prompt integration improvements (Fish, Tide, Starship)
* Documentation corrections or clarifications
* Performance or reliability improvements
* Tests for existing or fixed behavior

Please open an issue before starting large or opinionated changes.

---

## Style guidelines

### Fish shell code

weather-fish is written in **pure Fish** and targets **Fish 3.8+**.

Please follow these guidelines:

* Prefer simple, readable Fish code over clever constructs
* Avoid subshells and external commands unless strictly necessary
* Use `set -l` for local variables and `set -g` for configuration
* Do not rely on `export` for internal configuration
* Quote variables unless intentional word-splitting is required
* Keep functions small and focused

If you add new functions:

* Use the `__wttr_*` prefix for internal helpers
* Place them under `functions/`

---

### Documentation

* Keep documentation accurate to actual behavior
* Avoid suggesting unsupported or deprecated usage
* Prefer small, targeted changes over large rewrites
* Examples should work when copied verbatim

When changing only documentation, consider marking the commit accordingly (see
below).

---

## Git commit messages

Please follow these conventions:

* Use the **present tense** ("Add feature", not "Added feature")
* Use the **imperative mood** ("Fix bug", not "Fixes bug")
* Limit the first line to **72 characters or fewer**
* Reference related issues or pull requests when applicable
* Group related changes into a single logical commit

When only changing documentation, include `[ci skip]` in the commit title.

You may optionally prefix commits with a gitmoji if you find that helpful.

---

## Testing

weather-fish includes lightweight Fish-based tests.

Before submitting a pull request:

```fish
fish tests/run_tests.fish
```

If you add new behavior, please add or update tests where practical.

---

## Pull request process

1. Fork the repository
2. Create a topic branch from `main`
3. Make your changes with clear, focused commits
4. Ensure tests pass
5. Open a pull request with a clear description of the change

Small, focused pull requests are easier to review and more likely to be merged
quickly.

---

## Questions

If you are unsure about an approach or design decision, feel free to open an
issue to discuss it before writing code.

---

[Contributor Covenant Code of Conduct]: CODE_OF_CONDUCT.md
[gitmoji]: https://gitmoji.dev/
