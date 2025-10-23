{ pkgs, ... }:
pkgs.writeShellScriptBin "shell-starter" ''
  /bin/sh $HOME/.shell $@
''
