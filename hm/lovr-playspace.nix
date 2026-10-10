# SPDX-FileCopyrightText: 2026 Citlali del Rey <nullobsi@unix.dog>
#
# SPDX-License-Identifier: MIT

{
  pkgs,
  config,
  lib,
  ...
}:

with lib;

let
  cfg = config.programs.lovr-playspace;
  colorType = mkOptionType {
    name = "RGBA color";
    description = "list of 4 float";
    descriptionClass = "composite";
    check = x: (length x == 4);
    merge =
      loc: defs:
      let
        list = options.getValues defs;
      in
      if length list == 1 then
        head list
      else
        throw "Cannot merge definitions of `${options.showOption loc}'. Definition values:${options.showDefs defs}";
    emptyValue = { };
  };
  coordType = mkOptionType {
    name = "2D coordinate";
    description = "list of 2 float";
    descriptionClass = "composite";
    check = x: (length x == 2);
    merge =
      loc: defs:
      let
        list = options.getValues defs;
      in
      if length list == 1 then
        head list
      else
        throw "Cannot merge definitions of `${options.showOption loc}'. Definition values:${options.showDefs defs}";
    emptyValue = { };
  };
in
{
  options.programs.lovr-playspace = {
    enable = mkEnableOption "lovr-playspace";

    colors.grid.close = mkOption {
      default = [
        0.45
        0.69
        0.79
        0.5
      ];
      type = colorType;
      description = ''
        Grid color when considered close to playspace boundary.
      '';
    };
    colors.grid.far = mkOption {
      default = [
        0.45
        0.69
        0.79
        0
      ];
      type = colorType;
      description = ''
        Grid color when considered far from playspace boundary.
      '';
    };
    colors.corners.close = mkOption {
      default = [
        0.45
        0.69
        0.79
        1
      ];
      type = colorType;
      description = ''
        Corner and edge color when considered close to playspace boundary.
      '';
    };
    colors.corners.far = mkOption {
      default = [
        0.45
        0.69
        0.79
        0
      ];
      type = colorType;
      description = ''
        Corner and edge color when considered far from playspace boundary.
      '';
    };

    fade.start = mkOption {
      default = 0.5;
      type = types.numbers.nonnegative;
      description = ''
        Distance from playspace boundary to start fade from close to far color, in meters.
      '';
    };
    fade.stop = mkOption {
      default = 2;
      type = types.numbers.nonnegative;
      description = ''
        Distance from playspace boundary to stop fade from close to far color, in meters.
      '';
    };

    grid.density = mkOption {
      default = 1;
      type = types.numbers.nonnegative;
      description = ''
        Density of boundary grid.
      '';
    };
    grid.bottom = mkOption {
      default = 0;
      type = types.numbers.nonnegative;
      description = ''
        Distance, in meters, from the floor to where the bottom of the grid begins.
      '';
    };
    grid.top = mkOption {
      default = 3;
      type = types.numbers.nonnegative;
      description = ''
        Distance, in meters, from the floor to where the top of the grid ends.
      '';
    };

    actionButton = mkOption {
      default = "trigger";
      type = types.str;
      description = ''
        OpenXR button for placing points.
      '';
    };

    points.immutable = mkOption {
      default = false;
      type = types.bool;
      description = ''
        When enabled, the set of points defining the playspace are immutable. Leave this off to use the initial setup tool.
      '';
    };

    points.values = mkOption {
      default = [ ];
      type = types.listOf coordType;
      description = ''
        List of 2D coordinates defining the playspace boundary.
      '';
    };

    startWithMonado = mkOption {
      default = false;
      type = types.bool;
      description = ''
        When enabled, the systemd user service will bind to monado.service, starting and stopping with it.
      '';
    };
  };

  config = mkIf cfg.enable {
    xdg.dataFile =
      attrsets.mapAttrs' (name: value: nameValuePair ("LOVR/lovr-playspace/" + name) value)
        {
          "action_button.txt".text = cfg.actionButton;
          "color_close_corners.json".text = builtins.toJSON cfg.colors.corners.close;
          "color_close_grid.json".text = builtins.toJSON cfg.colors.grid.close;
          "color_far_corners.json".text = builtins.toJSON cfg.colors.corners.far;
          "color_far_grid.json".text = builtins.toJSON cfg.colors.grid.far;
          "fade_start.txt".text = builtins.toJSON cfg.fade.start;
          "fade_stop.txt".text = builtins.toJSON cfg.fade.stop;
          "grid_bottom.txt".text = builtins.toJSON cfg.grid.bottom;
          "grid_top.txt".text = builtins.toJSON cfg.grid.top;
          "points.json".text = builtins.toJSON cfg.points.values;
          "points.json".enable = cfg.points.immutable;
        };
    systemd.user.services.lovr-playspace = {
      Unit = {
        Description = "OpenXR chaperone overlay";
      }
      // mkIf cfg.startWithMonado {
        BindsTo = [ "monado.service" ];
        After = [ "monado.service" ];
      };

      Install = mkIf cfg.startWithMonado {
        WantedBy = [ "monado.service" ];
      };

      Service = {
        Type = "exec";
        ExecStart = "${pkgs.lib.getExe pkgs.lovr-playspace}";
      };
    };
  };
}
