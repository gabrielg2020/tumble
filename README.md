# Tumble

A 2D physics playground in Odin, visualised with raylib.

## Build

With Odin on your PATH:

```sh
odin build src -out:tumble
./tumble
```

CI runs checking, linting, physics tests and the build on Ubuntu with Odin
`dev-2026-06` for pushes and pull requests.

## Checks and Tests

```sh
odin check src
odin check src -vet -vet-style -vet-semicolon -vet-tabs
odin test src/physics -vet -vet-style -vet-semicolon -vet-tabs -out:/tmp/tumble-physics-tests
```

Linting uses Odin's built-in checks for unused variables/imports, shadowing,
trailing commas, unnecessary semicolons and tab indentation. Physics tests use
`core:testing` and run without a window. They cover integration, numerical
convergence, gravity changes and wall collision response.

## Pre-commit Hook

Enable the hook once per clone, from the repository root:

```sh
ln -s ../../.githooks/pre-commit .git/hooks/pre-commit
```

The hook builds the staged source in a temporary directory, then replaces and
stages `tumble` so the executable is included in the commit. Unstaged source
changes are not included in the build. A failed build blocks the commit and
leaves the existing executable untouched. Odin must be on PATH, including when
committing from an editor.

The executable is built for your local platform; the current development target
is Linux. CI verifies the code and does not commit its output.

---

Built with 💻 by Gabriel Guimaraes
