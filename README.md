# nixology/environments

Reusable nix development environments for common languages and tools.

This flake provides named `shellEnvs` and flake components that can be used
directly with `nix develop` or imported by other nixology flakes.

## Development Shells

Enter a shell directly with nix:

```sh
nix develop .#bash
nix develop .#c
nix develop .#clojure
nix develop .#csharp
nix develop .#dart
nix develop .#elixir
nix develop .#erlang
nix develop .#go
nix develop .#haskell
nix develop .#java
nix develop .#kotlin
nix develop .#lua
nix develop .#node
nix develop .#ocaml
nix develop .#perl
nix develop .#php
nix develop .#python
nix develop .#r
nix develop .#ruby
nix develop .#rust
nix develop .#scala
nix develop .#swift
nix develop .#zig
```

The default shell combines the just and nix environments:

```sh
nix develop
```

If `just` is available, the repository includes shortcuts that open each shell
using your current `$SHELL`:

```sh
just bash-env
just c-env
just clojure-env
just csharp-env
just dart-env
just elixir-env
just erlang-env
just go-env
just haskell-env
just java-env
just kotlin-env
just lua-env
just node-env
just ocaml-env
just perl-env
just php-env
just python-env
just r-env
just ruby-env
just rust-env
just scala-env
just swift-env
just zig-env
```

## Included Environments

| Environment | Packages and tooling                                               |
| ----------- | ------------------------------------------------------------------ |
| `bash`      | `bash-language-server`, `shellcheck`, `shfmt` formatting           |
| `c`         | GCC, Clang tooling, CMake, Make, GDB, `pkg-config`                 |
| `clojure`   | Clojure CLI, Leiningen, clj-kondo                                  |
| `csharp`    | .NET SDK                                                           |
| `dart`      | Dart SDK                                                           |
| `elixir`    | Elixir, ElixirLS                                                   |
| `erlang`    | Erlang, rebar3                                                     |
| `go`        | `go`, `gotools`, `golangci-lint`, `goimports` formatting           |
| `haskell`   | GHC, Cabal, Haskell Language Server                                |
| `java`      | `jdk`, `gradle`, `maven`, `google-java-format` formatting          |
| `kotlin`    | Kotlin, Kotlin language server, Gradle                             |
| `lua`       | `lua5_1`, `stylua` formatting                                      |
| `node`      | `nodejs`, `corepack`, TypeScript tooling, Prettier formatting      |
| `ocaml`     | OCaml, Dune, OCaml LSP, ocamlformat, utop                          |
| `perl`      | Perl, Perl::Critic, perltidy                                       |
| `php`       | PHP, Composer, Phpactor                                            |
| `python`    | `python3`, `pyright`, `ruff`, Black and Ruff formatting            |
| `r`         | R, R languageserver                                                |
| `ruby`      | `ruby`, `rubocop` formatting                                       |
| `rust`      | `rustc`, `cargo`, `clippy`, `rust-analyzer`, `rustfmt` formatting  |
| `scala`     | Scala, sbt, Metals                                                 |
| `swift`     | `swift`, `swiftpm`, `swiftpm2nix`, `sourcekit-lsp`, `swift-format` |
| `zig`       | Zig, ZLS                                                           |
| `nix`       | Re-exported from `github:nixology/flake`                           |
| `just`      | `just`, generated recipe aliases, Just formatting                  |

## Consuming Components

This flake is intended to be imported by other flakes that use
`github:nixology/flake`.

```nix
{
  inputs.flake.url = "github:nixology/flake";
  inputs.environments.url = "github:nixology/environments";

  outputs =
    inputs:
    inputs.flake.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.environments.components.nixology.environments.go.module
      ];
    };
}
```

Available component names include:

- `nixology.environments.bash`
- `nixology.environments.c`
- `nixology.environments.clojure`
- `nixology.environments.csharp`
- `nixology.environments.dart`
- `nixology.environments.elixir`
- `nixology.environments.erlang`
- `nixology.environments.go`
- `nixology.environments.haskell`
- `nixology.environments.just`
- `nixology.environments.java`
- `nixology.environments.kotlin`
- `nixology.environments.lua`
- `nixology.environments.nix`
- `nixology.environments.node`
- `nixology.environments.ocaml`
- `nixology.environments.perl`
- `nixology.environments.php`
- `nixology.environments.python`
- `nixology.environments.r`
- `nixology.environments.ruby`
- `nixology.environments.rust`
- `nixology.environments.scala`
- `nixology.environments.swift`
- `nixology.environments.zig`

## Maintenance

Run formatters through the treefmt integration exposed by the upstream nixology
flake:

```sh
nix fmt
```
