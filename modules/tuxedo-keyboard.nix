{ config, lib, pkgs, ... }:

with lib;

let 
    cfg = config.tuxedo-keyboard;
    tuxedo-keyboard = (pkgs.callPackage ../pkgs/tuxedo-keyboard/default.nix {});

in
  {
    options.tuxedo-keyboard = {
        enable = mkEnableOption "tuxedo-keyboard";
    };

    config = mkIf cfg.enable 
    {
         boot.kernelModules = ["tuxedo_keyboard"];
         boot.extraModulePackages =   [ tuxedo-keyboard ];
         
    };
  }
