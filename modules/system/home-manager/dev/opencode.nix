{ config, pkgs, ... }:
let
  ip_local_llm = "192.168.1.184";
in
{
  programs.opencode = {
    enable = true;
    context = ./AGENTS.md;
    settings = {
      model = pkgs.lib.mkDefault "llama-cpp/general";
      provider = {
        llama-cpp = {
          npm = "@ai-sdk/openai-compatible";
          name = "llama.cpp (local)";
          options = {
            baseURL = "http://${ip_local_llm}:11434/v1";
            timeout = false;
          };
          models = {
            general = {
              name = "general";
              tool_call = true;
              limit = {
                context = 131072;
                output = 81920;
              };
            };
            coder = {
              name = "coder";
              tool_call = true;
              limit = {
                context = 131072;
                output = 81920;
              };
              options = {
                temperature = 0.1;
                min_p = 0.1;
                repetition_penalty = 1.1;
              };
            };
            medium = {
              name = "medium";
              tool_call = true;
              limit = {
                context = 131072;
                output = 65536;
              };
            };
            fast = {
              name = "fast";
              tool_call = true;
              limit = {
                context = 131072;
                output = 65536;
              };
            };
          };
        };
      };
    };
  };
}
