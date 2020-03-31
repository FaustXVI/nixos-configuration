(require 'package)

(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
             (package-initialize)

(defvar my-packages '(better-defaults
                      projectile
                      clojure-mode
                      cider
                      auto-complete
                      rainbow-delimiters
                      haskell-mode
		      ergoemacs-mode
                      auctex
                      use-package))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(set-face-attribute 'region nil :background "#999")
(setq x-select-enable-clipboard t)
(setq ispell-list-command "--list")

(global-set-key (kbd "C-z") 'undo)
