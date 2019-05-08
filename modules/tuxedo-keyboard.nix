{ config, lib, pkgs, ... }:

with lib;

let 
    cfg = config.tuxedo-keyboard;
    tuxedo-keyboard = (pkgs.callPackage ../pkgs/tuxedo-keyboard/default.nix {});

in
  {
    options.tuxedo-keyboard = {
      enable = mkEnableOption "tuxedo-keyboard";
      color = mkOption {
        type = types.str;
        default = "FF0000";
      };
      brightness = mkOption {
        type = types.ints.positive;
        default = 255;
      };
    };

    config = mkIf cfg.enable 
    {
         boot.kernelModules = ["tuxedo_keyboard"];
         boot.extraModulePackages =   [ tuxedo-keyboard ];
         boot.kernelParams = [
           "tuxedo_keyboard.mode=0"
           "tuxedo_keyboard.brightness=${toString cfg.brightness}"
           "tuxedo_keyboard.color_left=0x${cfg.color}"
         ]; 
    };
  }
