{
  pkgs,
  username,
  inputs,
  ...
}: {
  imports = [./hardware.nix ../../system];

  networking = {
    hostName = "seamoth";
    networkmanager.enable = true;
    firewall.trustedInterfaces = ["virbr0"];
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      grub.useOSProber = false;
      efi = {
        efiSysMountPoint = "/boot/efi";
        canTouchEfiVariables = true;
      };
    };
  };

  security.sudo.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  services = {
    pcscd.enable = true;
    displayManager = {
      gdm.enable = false;
      sddm = {
        enable = true;
        autoNumlock = true;
        theme = "catppuccin-mocha-rosewater";
      };
    };
    xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
      xkb = {
        layout = "za";
        variant = "";
      };
    };
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    avahi.enable = false;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    fwupd.enable = true;
  };

  hardware.bluetooth.enable = true;

  programs = {
    virt-manager.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    steam = {
      enable = true;
      extraPackages = with pkgs; [javaPackages.compiler.openjdk21];
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };

  qt = {
    enable = true;
    style = "adwaita-dark";
  };

  security.rtkit.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };

  users.users."${username}".extraGroups = ["networkmanager" "libvirtd" "kvm"];

  hardware.cpu.intel.updateMicrocode = true;

  environment.systemPackages = with pkgs; [
    (
      pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        accent = "rosewater";
        font = "Inter";
        fontSize = "9";
        loginBackground = true;
      }
    )
    weston
  ];

  home-manager.users.${username} = {
    imports = [
      inputs.noctalia.homeModules.default
      ../../home/modules/cli
      ../../home/modules/tui
      ../../home/modules/gui
      ../../home/modules/gui/hyprland.nix
    ];

    me.cli.git.signingkey = "CB029F0E386B37C7";
  };
}
