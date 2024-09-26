{
  pkgs,
  config,
  ...
}:
{

  home = {
    packages = with pkgs; [
      dotnet-sdk_8
    ];
    sessionPath = [
      "$HOME/.dotnet/tools"
    ];
    sessionVariables.DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";

    persistence."/persist/home/${config.home.username}" = {
      directories = [".microsoft/usersecrets"];
    };
  };
}
