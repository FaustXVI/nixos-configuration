{ pkgs, ... }:
{
  programs = {
    vim = {
      enable = true;
      packageConfigurable = pkgs.vim;
      extraConfig = ''
            filetype indent on
            " allow backspacing over everything in insert mode
            set backspace=indent,eol,start
            " I like 4 spaces for indenting
            set shiftwidth=4
            " I like 4 stops
            set tabstop=4
            " Spaces instead of tabs
            set expandtab
            " Always  set auto indenting on
            set autoindent
            " select when using the mouse
            set selectmode=mouse
            " do not keep a backup files 
            set nobackup
            set nowritebackup
            " keep 50 lines of command line history
            set history=50  
            " show the cursor position all the time
            set ruler       
            " show (partial) commands
            set showcmd     
            " do incremental searches (annoying but handy);
        set incsearch 
            " Set ignorecase on
            set ignorecase
            " Set status line
            set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*
            " Always display a status line at the bottom of the window
            set laststatus=2
            " showmatch: Show the matching bracket for the last ')'?
            set showmatch
            syntax on
            set hlsearch
            set number
      '';
    };
  };
}
