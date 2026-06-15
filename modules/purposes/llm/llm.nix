{ mylib, pkgs, ... }:
{
  config = mylib.mkIfComputerHasPurpose "llm" {
  environment.systemPackages = with pkgs; [ opencode ];
    services = {
      llama-cpp = {
        enable = true;
        package = pkgs.llama-cpp-rocm;
        model = pkgs.requireFile {
            name =  "Qwen_Qwen3.6-35B-A3B-Q4_K_M.gguf";
            url = "https://huggingface.co/Abiray/Qwen3.6-35B-A3B-Q4_K_M-GGUF/resolve/main/Qwen3.6-35B-A3B-Q4_K_M.gguf?download=true";
            hash = "sha256-tG/t0z4L+wyuMIqjwVjQpLLEodIYWh7W8JPNrzkGR3I=";
        };
        extraFlags = [
        "-c" "65536" "-fa" "on" "-ngl" "999" "--n-cpu-moe" "20" "-t" "12" "-b" "2048" "-ub" "2048" "--no-mmap" "--jinja"
        ];
        openFirewall = true;
        port = 11434;
      };
      open-webui = {
        enable = true;
        port = 1337;
      };
    };
  };
}
