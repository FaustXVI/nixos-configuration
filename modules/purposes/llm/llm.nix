{ mylib, pkgs, ... }:
{
  config = mylib.mkIfComputerHasPurpose "llm" {
    services = {
      ollama = {
        enable = true;
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
