{pkgs, ...}: {
  imports = [./default.nix];

  # :: PACKAGES {
  home.packages = with pkgs; [
    uv
    azure-cli
    # Windows VS Code's own `code` launcher (WSL-aware), located through the
    # Windows user's %LOCALAPPDATA% at call time rather than a fixed username.
    (writeShellScriptBin "code" ''
      localappdata=$(cd /mnt/c && cmd.exe /c 'echo %LOCALAPPDATA%' | tr -d '\r')
      for dir in "$(wslpath -u "$localappdata")/Programs/Microsoft VS Code" "/mnt/c/Program Files/Microsoft VS Code"; do
        [ -x "$dir/bin/code" ] && exec "$dir/bin/code" "$@"
      done
      echo "code: no Windows VS Code install found" >&2
      exit 1
    '')
  ];
  # :: }

  # :: SESSION VARIABLES {
  home.sessionVariables.LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc}/lib";
  # :: }

  # :: SESSION PATH {
  # `wsl.wslConf.interop.appendWindowsPath` is off (it drags the whole Windows
  # PATH in), so expose just the Windows directories worth calling from here.
  # Appended rather than via `home.sessionPath` (which prepends) so lookups
  # don't hit the slow /mnt/c mount before the Linux paths.
  home.sessionVariablesExtra = ''
    export PATH="$PATH:/mnt/c/Windows/System32:/mnt/c/Windows"
  '';
  # :: }

  # :: ME {
  # Delta on top of the common profile in ./default.nix.
  me.tools.ssh.extraConfig = {
    "vs-ssh.visualstudio.com" = {
      addKeysToAgent = "yes";
      identityFile = "~/.ssh/sb.key";
      kbdInteractiveAuthentication = "yes";
      passwordAuthentication = "no";
    };
  };
  # :: }
}
