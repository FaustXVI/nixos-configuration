{ mylib, pkgs, ... }:
let
  llama-server = pkgs.lib.getExe' pkgs.llama-cpp-rocm "llama-server";
in
{
  config = mylib.mkIfComputerHasPurpose "llm" {
    environment.systemPackages = with pkgs; [ opencode ];
    services = {
      llama-swap = {
        enable = true;
        openFirewall = true;
        port = 11434;
        listenAddress = "0.0.0.0";
        settings = {
          healthCheckTimeout = 60; # Give the server 60s to boot before timing out
          startPort = 10001; # Ports automatically increment from here for ${PORT}

          models =
            let
              qwen3_6 = pkgs.fetchurl {
                url = "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/main/Qwen3.6-35B-A3B-UD-Q4_K_M.gguf?download=true";
                hash = "sha256-rA4sEYngVfqjbv82FYDnnFvW+Odr/7TOVH8WfVPjGmE=";
              };
              qwen3_5 = pkgs.fetchurl {
                url = "https://huggingface.co/unsloth/Qwen3.5-9B-GGUF/resolve/main/Qwen3.5-9B-UD-Q8_K_XL.gguf?download=true";
                hash = "sha256-LE4I4OcsaNjBg1om9b5AdYlN+epb6cwgokZRev1qDLY=";
              };
              gemma4 = pkgs.fetchurl {
                url = "https://huggingface.co/unsloth/gemma-4-E4B-it-GGUF/resolve/main/gemma-4-E4B-it-UD-Q8_K_XL.gguf?download=true";
                hash = "sha256-b4NXjMRnk/PVYpDoPR/Id9CelO59sbS2w5ek8As4yIk=";
              };
            in
            {
              "qwen3.6" = {
                cmd = "${llama-server} --port \${PORT} -m ${qwen3_6} -c 131072 -fa on -ngl 999 --n-cpu-moe 24 -t 12 -b 2048 -ub 2048 -ctk q8_0 -ctv q8_0 --no-mmap --jinja";
                aliases = [ "general" ];
              };
              "qwen3.5" = {
                cmd = "${llama-server} --port \${PORT} -m ${qwen3_5} -c 131072 -fa on -ngl 999 --n-cpu-moe 24 -t 12 -b 2048 -ub 2048 -ctk q8_0 -ctv q8_0 --no-mmap --jinja";
                aliases = [ "medium" ];
              };
              "gemma4" = {
                cmd = "${llama-server} --port \${PORT} -m ${gemma4} -c 131072 -fa on --no-mmap --jinja";
                aliases = [ "fast" ];
              };
            };
        };
      };
      open-webui = {
        enable = true;
        port = 1337;
        host = "0.0.0.0";
        openFirewall = true;
      };
    };
    systemd.services.llama-swap.serviceConfig.ProcSubset = pkgs.lib.mkForce "all";
  };
}
