{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot/efi";
              mountOptions = ["umask=0077"];
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptlvm";
              settings.allowDiscards = true;
              content = {
                type = "lvm_pv";
                vg = "vg";
              };
            };
          };
        };
      };
    };

    lvm_vg.vg = {
      type = "lvm_vg";
      lvs = {
        swap = {
          size = "16G";
          content.type = "swap";
        };
        root = {
          size = "100%FREE";
          content = {
            type = "btrfs";
            subvolumes = {
              "@".mountpoint = "/";
              "@home".mountpoint = "/home";
              "@nix".mountpoint = "/nix";
            };
          };
        };
      };
    };
  };
}
