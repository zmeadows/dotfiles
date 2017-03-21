;;; dotemacs -- Summary:
;;; emacs config file for Z. Meadows (2017)
;;; Commentary:
;;; Primarily a duplication of my originl vim setup
;;; Code:
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

;; BASIC EMACS SETTINGS
(setq custom-file "~/.emacs-custom.el")
(load custom-file)
(setq frame-background-mode 'dark)

(menu-bar-mode -1)
(show-paren-mode 1)

;; USE-PACKAGE

;; Install 'use-package' if necessary
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Enable use-package
(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant

;; PLUGINS

(use-package company
  :ensure t
  :defer t
  :init (global-company-mode)
  :diminish company-mode
  :config
  (progn
    (setq company-idle-delay 0.1))
  )

(use-package projectile
  :ensure   projectile
  :config   (projectile-global-mode t)
  :diminish projectile-mode
  )

(use-package helm
  :ensure t
  :diminish helm-mode
  :config
  (helm-mode 1)
  :init (progn
	  (use-package helm-projectile
	    :ensure    helm-projectile
	    :bind      ("C-c h" . helm-projectile))
	  )
  )

(use-package flycheck
  :ensure t
  :defer t
  :config
  (set-face-attribute 'flycheck-error nil :foreground "white" :background "red")
  :init
  (global-flycheck-mode)
  )

(use-package intero
  :ensure t
  :defer t
  :init (add-hook 'haskell-mode-hook 'intero-mode)
  )

(use-package rust-mode
  :ensure t
  :defer t
  )

(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-default-dark t)
  )

(use-package magit
  :ensure t
  :defer t
  )

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package evil
  :ensure t
  :diminish evil
  :config
  (use-package evil-leader
    :ensure t
    :init (global-evil-leader-mode)
    :config
    (progn
      (setq evil-leader/in-all-states t)
      (evil-leader/set-leader "<SPC>")
      ;; keyboard shortcuts
      (evil-leader/set-key
	"f" 'helm-projectile
	"g" 'magit-status
	)))
  (use-package evil-magit
    :ensure t)
  (evil-mode 1)
  (define-key evil-visual-state-map (kbd "RET") 'align-regexp)
  )
