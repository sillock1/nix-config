{ ... }:
{
  imports = [
    ../global
    ../features/desktop/wayland/hyprland
    ../features/development
    ../features/games
  ];

  modules = {
    desktop = {
      hyprland = {
        enable = true;
        settings = {
          monitor = [
            "desc:Dell Inc. DELL U2515H 9X2VY53O0BYL,2560x1440, 0x0, 1"
            "desc:Dell Inc. DELL S2721DGF H2TBP83,2560x1440, 2560x0, 1"
            "desc:Dell Inc. DELL U2515H 9X2VY58J018L,2560x1440, 5120x0, 1"
          ];
          exec = ["xrandr --output DP-2 --primary"];
          workspace = [
            "1, monitor:desc:Dell Inc. DELL U2515H 9X2VY53O0BYL, default:true"
            "2, monitor:desc:Dell Inc. DELL U2515H 9X2VY53O0BYL"
            "3, monitor:desc:Dell Inc. DELL U2515H 9X2VY53O0BYL"
            "4, monitor:desc:Dell Inc. DELL S2721DGF H2TBP83, default:true"
            "5, monitor:desc:Dell Inc. DELL S2721DGF H2TBP83"
            "6, monitor:desc:Dell Inc. DELL S2721DGF H2TBP83"
            "7, monitor:desc:Dell Inc. DELL U2515H 9X2VY58J018L, default:true"
            "8, monitor:desc:Dell Inc. DELL U2515H 9X2VY58J018L"
            "9, monitor:desc:Dell Inc. DELL U2515H 9X2VY58J018L"
            "10, monitor:desc:Dell Inc. DELL S2721DGF H2TBP83"
          ];
        };
      };
    };
  };
}
