# Auto-detect system architecture
system := `nix eval --impure --raw --expr 'builtins.currentSystem'`

show:
    nix flake show | grep -v omitted

bash-env:
    nix develop .#bash -c $SHELL

c-env:
    nix develop .#c -c $SHELL

clojure-env:
    nix develop .#clojure -c $SHELL

csharp-env:
    nix develop .#csharp -c $SHELL

dart-env:
    nix develop .#dart -c $SHELL

elixir-env:
    nix develop .#elixir -c $SHELL

erlang-env:
    nix develop .#erlang -c $SHELL

go-env:
    nix develop .#go -c $SHELL

haskell-env:
    nix develop .#haskell -c $SHELL

java-env:
    nix develop .#java -c $SHELL

kotlin-env:
    nix develop .#kotlin -c $SHELL

lua-env:
    nix develop .#lua -c $SHELL

node-env:
    nix develop .#node -c $SHELL

ocaml-env:
    nix develop .#ocaml -c $SHELL

perl-env:
    nix develop .#perl -c $SHELL

php-env:
    nix develop .#php -c $SHELL

python-env:
    nix develop .#python -c $SHELL

r-env:
    nix develop .#r -c $SHELL

ruby-env:
    nix develop .#ruby -c $SHELL

rust-env:
    nix develop .#rust -c $SHELL

scala-env:
    nix develop .#scala -c $SHELL

swift-env:
    nix develop .#swift -c $SHELL

zig-env:
    nix develop .#zig -c $SHELL
