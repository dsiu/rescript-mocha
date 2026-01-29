## Unreleased

## Released

### 0.11.0

- Upgraded to ReScript v12 with ES modules support
- Changed output suffix to `.res.mjs` (in-source compilation)
- Removed legacy `uncurried` config (ReScript v12 is uncurried by default)
- Updated package for npm publishing under `@dsiu/rescript-mocha`

### 0.10.0

Upgraded mocha to 10 and ReScript to 11.
Set `uncurried: false` in `bsconfig.json` for the moment. There is a `modern-api` branch that is more likely to support uncurried use; that's still in progress.

### 0.9.0

Initial release after rename; no changes. Just updated the mocha dependency to v9.
