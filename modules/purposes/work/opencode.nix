{ mylib, config, ... }:

{
  home-manager.users.xadet = {
    programs.opencode = {
      settings = {
        model = "scaleway/qwen3.6-35b-a3b";
        provider = {
          scaleway = {
            apiKey = ''''${FILE:${config.sops.secrets."scaleway.token".path}}'';
            name = "Scaleway";
            apiUrl = "https://llm-inference.scaleway.ai/v1";
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
