(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))


(package-initialize)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(use-package which-key
  :ensure t
  :init (which-key-mode))
(use-package powerline
  :ensure t
  :init (powerline-center-theme))
(use-package projectile
  :ensure t)
(use-package rust-mode
  :ensure t)
(use-package racer
  :ensure t)
(use-package company
  :ensure t)


(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "450f3382907de50be905ae8a242ecede05ea9b858a8ed3cc8d1fbdf2d57090af" default)))
 '(package-selected-packages
   (quote
    (zygospore flycheck-rust flycheck projectile company dash racer rust-mode powerline color-theme-sanityinc-tomorrow which-key use-package))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "MS  " :family "Consolas")))))


(setq make-backup-files nil)
(setq auto-save-default nil)


(defalias 'yes-or-no-p 'y-or-n-p)

(defvar term-shell "/bin/zsh")
(defadvice term (before force-zsh)
  (interactive (list term-shell)))
(ad-activate 'term)

(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'company-mode)

(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

(use-package flycheck
  :ensure t
  :hook (prog-mode . flycheck-mode))
(use-package flycheck-rust
  :ensure t
  :config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;; Package zygospore
(use-package zygospore
  :init
  (global-set-key "\C-x1" 'zygospore-toggle-delete-other-windows)
  (global-set-key "\C-j" 'newline-and-indent))
