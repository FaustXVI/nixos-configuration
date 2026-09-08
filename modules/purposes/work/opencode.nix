{ mylib, config, ... }:

{
  home-manager.users.xadet = {
    programs.opencode = {
      settings = {
        model = "scaleway/qwen3.6-35b-a3b";
        provider = {
          scaleway = {
            name = "Scaleway";
            options = {
                apiKey = ''{file:${config.sops.secrets."scaleway.token".path}}'';
                baseURL = "https://api.scaleway.ai/v1";
            };
            models = {
              "qwen3.6-35b-a3b" = {
                name = "qwen3.6-35b-a3b";
                tool_call = true;
              };
            };
          };
        };
      };
    };
  };
}
