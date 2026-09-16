{ mylib, config, ... }:

{
  home-manager.users.xadet = {
    programs.opencode = {
      settings = {
        model = "scaleway/deepseek-v4-flash-0731";
        provider = {
          scaleway = {
            name = "Scaleway";
            options = {
                apiKey = ''{file:${config.sops.secrets."scaleway.token".path}}'';
                baseURL = "https://api.scaleway.ai/v1";
            };
            models = {
              "deepseek-v4-flash-0731" = {
                name = "deepseek-v4-flash-0731";
                tool_call = true;
              };
            };
          };
        };
      };
    };
  };
}
