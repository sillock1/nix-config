{
  pkgs,
  config,
  ...
}:
{

  home = {
    packages = with pkgs; [
      dotnet-sdk_9
    ];
    sessionPath = [
      "$HOME/.dotnet/tools"
    ];
    sessionVariables.DOTNET_ROOT = "${pkgs.dotnet-sdk_9}";

    persistence."/persist/home/${config.home.username}" = {
      directories = [".microsoft/usersecrets"];
    };
  };
}
