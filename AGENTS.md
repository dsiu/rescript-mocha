# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ReScript bindings for the Mocha testing framework. Fork of the abandoned bs-mocha, updated for ReScript v12. Provides type-safe `describe`/`it` test functions in three flavors: synchronous, promise-based, and callback-based async.

## Build & Test Commands

- **Build**: `yarn build`
- **Watch**: `yarn watch` (or `yarn start`)
- **Test all**: `yarn test` (builds then runs mocha)
- **Clean**: `yarn clean`
- **Run single test file**: `yarn build && npx mocha test/Test_Mocha.res.mjs`

## Documentation References

**IMPORTANT**: Always refer to official ReScript docs when writing or modifying ReScript code:
- **LLM docs**: https://rescript-lang.org/llms/manual/llms.txt
- **Full LLM docs**: https://rescript-lang.org/llms/manual/llm-full.txt
- **Manual**: https://rescript-lang.org/docs/manual/introduction

## Architecture

### Source modules (`src/`)
- **Internal.res** — Core implementation: type definitions, `@val @scope("globalThis")` external bindings to Mocha globals, wrapper functions that apply `timeout`/`retries`/`slow` options via `@this` context
- **Mocha.res/.resi** — Public sync API: `describe`, `it`, lifecycle hooks, plus `_only`/`_skip` variants
- **Promise_.res/.resi** — Public promise API: same shape but callbacks return `promise<'a>`
- **Async.res/.resi** — Public callback API: uses done-style `(~error: JsExn.t=?, unit) => unit`
- **Assert.res / AssertLabels.res** — Bindings to Node.js `assert` module

### Test files (`test/`)
- **Test_Mocha.res**, **Test_Promise.res**, **Test_Async.res** — One per API flavor
- Tests compile to `.res.mjs` and Mocha discovers them recursively

### Key binding patterns
- Mocha globals bound via `@val @scope("globalThis")` (e.g., `describe`, `it`)
- `.only`/`.skip` variants use tuple scope: `@scope(("globalThis", "it"))`
- `@this` annotation captures Mocha context for per-test option methods
- Options (`timeout`, `retries`, `slow`) applied as method calls on the Mocha `this` context

## ReScript Conventions

- **ReScript v12** with ES modules (`.res.mjs` output, in-source compilation)
- **Never** use `Belt` or `Js` modules — these are legacy
- Use `JSON.t` for JSON types
- Prefer `async/await` over callback patterns for promises
- Use `option` and `Result` types for error handling; avoid exceptions

## Development Tools

### ReScript LSP Integration
If the rescript-lsp plugin is available in Claude Code, prefer LSP features for document symbols, go-to-definition, type info, and module navigation.

## Commit & Test Policy

- Each test should have a single expect statement (use tuples for multiple results)
- Use conventional commits spec for commit messages
- Run tests and ensure all pass before committing
