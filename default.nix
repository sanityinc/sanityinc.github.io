{ bundlerEnv
, lib
}:
bundlerEnv {
  name = "sanityinc";
  #ruby = ruby_2_2;
  gemdir = builtins.path { path = ./.; name = "sanityinc"; };
  groups = [ "default" "development" "test" "jekyll_plugins" ];

  meta = with lib;
    {
      description = "Ruby on Rails site";
      platforms = platforms.unix;
    };
}
