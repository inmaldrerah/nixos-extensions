{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "shell-starter";
  text = ''
    /bin/sh $HOME/.shell $@
  '';
}
