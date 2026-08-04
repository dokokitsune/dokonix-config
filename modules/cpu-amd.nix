{
  flake.modules.nixos.cpu-amd = {
    hardware.cpu.amd.updateMicrocode = true;
  };
}
