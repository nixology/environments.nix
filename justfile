bash-env:
  nix develop .#bash -c $SHELL

go-env:
  nix develop .#go -c $SHELL

lua-env:
  nix develop .#lua -c $SHELL

swift-env:
  nix develop .#swift -c $SHELL
