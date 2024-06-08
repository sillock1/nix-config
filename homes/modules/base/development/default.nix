{
  lib,
  ...
}:
{
  imports = [
    ./utilities
  ];

  options.modules.base.development = {
    enable = lib.mkEnableOption "development";
  };
}