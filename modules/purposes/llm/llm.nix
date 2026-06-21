{ mylib, pkgs, ... }:
{
  config = mylib.mkIfComputerHasPurpose "llm" {
  environment.systemPackages = with pkgs; [ opencode ];
    services = {
      llama-cpp = {
        enable = true;
        package = pkgs.llama-cpp-rocm;
        model = pkgs.fetchurl {
            url = "https://huggingface.co/Abiray/Qwen3.6-35B-A3B-Q4_K_M-GGUF/resolve/main/Qwen3.6-35B-A3B-Q4_K_M.gguf?download=true";
            hash = "sha256-BMF1b2BOruCJVW8WBNuzoWpOyZGwKhUS37OJeTtIiz8=";
        };
        #model = pkgs.fetchurl {
        #    url = "https://huggingface.co/unsloth/gemma-4-26B-A4B-it-qat-GGUF/resolve/main/gemma-4-26B-A4B-it-qat-UD-Q4_K_XL.gguf?download=true";
        #    hash = "sha256-3PF5qRFT46fs55LkjvhyGA2dbvm3Z38KC9PoPP5iTV4=";
        #};
        #model = pkgs.fetchurl {
        #    url = "https://huggingface.co/unsloth/Qwen3.5-9B-GGUF/resolve/main/Qwen3.5-9B-UD-Q8_K_XL.gguf?download=true";
        #    hash = "sha256-LE4I4OcsaNjBg1om9b5AdYlN+epb6cwgokZRev1qDLY=";
        #};
        extraFlags = [
        #"-c" "262144" "-fa" "on" "-ngl" "999" "--n-cpu-moe" "24" "-t" "12" "-b" "2048" "-ub" "2048" "-ctk" "q8_0" "-ctv" "q8_0" "--no-mmap" "--jinja"
        "-c" "131072" "-fa" "on" "-ngl" "999" "--n-cpu-moe" "24" "-t" "12" "-b" "2048" "-ub" "2048" "-ctk" "q8_0" "-ctv" "q8_0" "--no-mmap" "--jinja"
        #"-c" "65536" "-fa" "on" "-ngl" "999" "--n-cpu-moe" "24" "-t" "12" "-b" "2048" "-ub" "2048" "-ctk" "q8_0" "-ctv" "q8_0" "--no-mmap" "--jinja"
        #"-c" "262144" "-fa" "on" "-ngl" "999" "--n-cpu-moe" "20" "-t" "12" "-b" "2048" "-ub" "2048" "--no-mmap" "--jinja"
        #"-c" "131072" "-fa" "on" "-ngl" "999" "-t" "12" "-b" "2048" "-ub" "2048" "-ctk" "q8_0" "-ctv" "q8_0" "--no-mmap" "--jinja"
        ];
        openFirewall = true;
        port = 11434;
        host = "0.0.0.0";
      };
      open-webui = {
        enable = true;
        port = 1337;
        host = "0.0.0.0";
        openFirewall = true;
      };
    };
  };
}
