{ mylib, pkgs, ... }:
{
  config = mylib.mkIfComputerHasPurpose "llm" {
  environment.systemPackages = with pkgs; [ opencode ];
    services = {
      ollama = {
        enable = false;
        environmentVariables={
            OLLAMA_CONTEXT_LENGTH="128000";
        };
      };
      llama-cpp = {
        enable = false;
        package = pkgs.llama-cpp-rocm;
      };
      open-webui = {
        enable = true;
        port = 1337;
      };
      nextjs-ollama-llm-ui = {
        enable = false;
        port = 1337;
      };
    };
  };
}
