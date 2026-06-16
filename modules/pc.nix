{ config, pkgs, ... }:
{
  networking.hostName = "elaines-pc"

  # virtual machines
  specialisation = {
    vm.configuration = {
      # virtual machines, must switch monitor to motherboard port
        programs.virt-manager.enable = true;
        virtualisation.spiceUSBRedirection.enable = true;
        virtualisation.libvirtd = {
          enable = true;
          qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = true;
            swtpm.enable = true;
          };
        };
  
      users.extraUsers.elaine.extraGroups = [ "libvirtd" ];
      boot.initrd.kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
      ];
      boot.kernelParams = [
        "amd_iommu=on"
        "vfio-pci.ids=1002:7550,1002:ab40"
      ];
    };
  };

  # maybe fix ethernet
  systemd.services.force-r8169 = {
    description = "Force load r8169 Realtek Driver";
    wantedBy = [ "multi-user.target" ];
    before = [ "network-pre.target" ];
    # Wants = [ "network-pre.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.kmod}/bin/modprobe r8169";
      RemainAfterExit = true;
    };
  };
}
