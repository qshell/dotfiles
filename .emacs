;;; package --- qshell
;;; Commentary:
;.

(require 'package)

;;; Code:

; Init repo and packages
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


; Package list (base)
(use-package which-key
  :ensure t
  :init (which-key-mode))
(use-package powerline
  :ensure t
  :init (powerline-center-theme))
(use-package projectile
  :ensure t)
(use-package company
  :ensure t)
(use-package flycheck
  :ensure t
  :hook (prog-mode . flycheck-mode))
; Restore closed window
(use-package zygospore
  :init
  (global-set-key "\C-x1" 'zygospore-toggle-delete-other-windows)
  (global-set-key "\C-j" 'newline-and-indent))
(use-package expand-region
  :init
  (global-set-key (kbd "C-=") 'er/expand-region)
  :ensure t)
(use-package ace-jump-mode
  :init
  (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
  (autoload
    'ace-jump-mode
    "ace-jump-mode"
    "Emacs quick move minor mode"
    t)
  :ensure t)
(use-package yasnippet
  :init
  (require 'yasnippet)
  (yas-global-mode 1)
  :ensure t)
(use-package yasnippet-snippets
  :ensure t)
(use-package magit
  :ensure t)
(use-package evil
  :init
  (evil-mode 1)
  :ensure t)
;;(use-package dired
;;  :ensure t)

; Disable all GUI elements
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)


; Theme
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(beacon-color "#f2777a")
 '(custom-enabled-themes (quote (doom-gruvbox)))
 '(custom-safe-themes
   (quote
    ("071f5702a5445970105be9456a48423a87b8b9cfa4b1f76d15699b29123fb7d8" "f951343d4bbe5a90dba0f058de8317ca58a6822faa65d8463b0e751a07ec887c" "2a3ffb7775b2fe3643b179f2046493891b0d1153e57ec74bbe69580b951699ca" "70ed3a0f434c63206a23012d9cdfbe6c6d4bb4685ad64154f37f3c15c10f3b90" "d6f04b6c269500d8a38f3fabadc1caa3c8fdf46e7e63ee15605af75a09d5441e" "0fe9f7a04e7a00ad99ecacc875c8ccb4153204e29d3e57e9669691e6ed8340ce" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "450f3382907de50be905ae8a242ecede05ea9b858a8ed3cc8d1fbdf2d57090af" default)))
 '(fci-rule-color "#37474f")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote dark))
 '(hl-sexp-background-color "#1c1f26")
 '(jdee-db-active-breakpoint-face-colors (cons "#0d0d0d" "#81a2be"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#0d0d0d" "#b5bd68"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#0d0d0d" "#5a5b5a"))
 '(objed-cursor-color "#cc6666")
 '(package-selected-packages
   (quote
    (doom-themes material-theme color-theme-sanityinc-solarized py-autopep8 elpy evil yasnippet-snippets dired magit yasnippet ace-jump-mode expand-region zygospore flycheck-rust flycheck projectile company dash racer rust-mode powerline color-theme-sanityinc-tomorrow which-key use-package)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#f36c60")
     (40 . "#ff9800")
     (60 . "#fff59d")
     (80 . "#8bc34a")
     (100 . "#81d4fa")
     (120 . "#4dd0e1")
     (140 . "#b39ddb")
     (160 . "#f36c60")
     (180 . "#ff9800")
     (200 . "#fff59d")
     (220 . "#8bc34a")
     (240 . "#81d4fa")
     (260 . "#4dd0e1")
     (280 . "#b39ddb")
     (300 . "#f36c60")
     (320 . "#ff9800")
     (340 . "#fff59d")
     (360 . "#8bc34a"))))
 '(vc-annotate-very-old-color nil)
 '(window-divider-mode nil))


; Font
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "MS  " :family "Consolas")))))


; No backups
(setq make-backup-files nil)
(setq auto-save-default nil)


; Rust
(use-package rust-mode
  :ensure t)
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'company-mode)
(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)
(use-package racer
  :ensure t)
(use-package flycheck-rust
  :ensure t
  :config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))


; Python
(use-package elpy
  :ensure t
  :init
  (elpy-enable))
(use-package flycheck
  :ensure t)
(use-package py-autopep8
  :ensure t
  :init
  (require 'py-autopep8)
  (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save))
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")


; Other
(defalias 'yes-or-no-p 'y-or-n-p)
(defvar term-shell "/bin/zsh")
(defadvice term (before force-zsh)
  (interactive (list term-shell)))
(ad-activate 'term)
(global-linum-mode 1)
(setq linum-format "%4d ")


(provide '.emacs)
;;; .emacs ends here
