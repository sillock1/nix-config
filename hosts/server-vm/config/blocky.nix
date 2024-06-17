let
  ads-whitelist = builtins.toFile "ads-whitelist" ''
    google.com
  '';
in
{
  ports = {
    dns = "0.0.0.0:5454";
    http = 4000;
  };
  upstreams.groups.default = [
    # Cloudflare
    "tcp-tls:1.1.1.1:853"
    "tcp-tls:1.0.0.1:853"
  ];

  # configuration of client name resolution
  clientLookup.upstream = "127.0.0.1:5353";

  ecs.useAsClient = true;

  prometheus = {
    enable = true;
    path = "/metrics";
  };

  blocking = {
    loading.downloads.timeout = "4m";
    blackLists = {
      ads = [
        "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
      ];
      fakenews = [
        "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-only/hosts"
      ];
      gambling = [
        "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-only/hosts"
      ];
      facebook = [
        "https://raw.githubusercontent.com/jmdugan/blocklists/master/corporations/facebook/all"
        "https://www.github.developerdan.com/hosts/lists/facebook-extended.txt"
        "https://raw.githubusercontent.com/anudeepND/blacklist/master/facebook.txt"
      ];
      twitter = [
        "https://raw.githubusercontent.com/jmdugan/blocklists/master/corporations/twitter/all"
      ];
      # Temporary till https://github.com/jmdugan/blocklists/pull/97 is merged
      tiktok = [
        "https://raw.githubusercontent.com/drduh/blocklists/wip-tiktok/corporations/tiktok/all"
      ];
      # Temporary till https://github.com/jmdugan/blocklists/pull/89 is merged
      reddit = [
        "https://raw.githubusercontent.com/shff/blocklists/block-reddit/corporations/reddit/all"
      ];
    };

    whiteLists = {
      ads = [
        "file://${ads-whitelist}"
      ];
    };

    clientGroupsBlock = {
      default = [
        "ads"
        "fakenews"
        "gambling"
      ];
      "luna.sillock.internal" = [
        "ads"
        "fakenews"
        "gambling"
        "facebook"
        "twitter"
        "tiktok"
        "reddit"
      ];
    };
  };
}