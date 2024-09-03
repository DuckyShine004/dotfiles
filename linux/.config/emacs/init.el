;; Install and configure straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Install use-package
(straight-use-package 'use-package)

;; Make use-package use straight.el by default
(setq straight-use-package-by-default t)

;; Always defer loading of packages to speed up startup
(setq use-package-always-defer t)

;; Prevent evil interference
(setq evil-want-keybinding nil)

;; ctrl-u
(setq evil-want-C-u-scroll t)

;; Configurations for GUI
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen t)
(setq use-file-dialog nil)

;; Default scratch message
(use-package emacs
  :init
  (setq initial-scratch-message nil)
  (defun display-startup-echo-area-message ()
    (message "")))

;; Confirmation dialogs
(use-package emacs
  :init
  (defalias 'yes-or-no-p 'y-or-n-p))

;; Make everything use UTF-8
(use-package emacs
  :init
  (set-charset-priority 'unicode)
  (setq locale-coding-system 'utf-8
        coding-system-for-read 'utf-8
        coding-system-for-write 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix)))

;; Use tabs instead of spaces
(use-package emacs
  :init
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2))

;; macOS keybinds
(use-package emacs
  :init
	(when (eq system-type 'darwin)
		(setq mac-command-modifier 'super)
		(setq mac-option-modifier 'meta)
		(setq mac-control-modifier 'control)))

;; Font
(use-package emacs
  :init
  (set-face-attribute 'default nil
        :font "JetBrainsMono NF"
        :height 160))

;; Relative line numbers
(use-package emacs
  :init
  (defun ab/enable-line-numbers ()
    "Enable relative line numbers"
    (interactive)
    (display-line-numbers-mode)
    (setq display-line-numbers 'relative))
  (add-hook 'prog-mode-hook #'ab/enable-line-numbers))

;; Ruler for 80 characters
;; (use-package emacs
;;   :init
;;   (setq-default fill-column 80)
;;   (set-face-attribute 'fill-column-indicator nil
;;                       :foreground "#717C7C" ; katana-gray
;;                       :background "transparent")
;;   (global-display-fill-column-indicator-mode 1))

;; Make the UI title bar match the current theme
(use-package emacs
  :init
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . light))
  (setq ns-use-proxy-icon  nil)
  (setq frame-title-format nil))

;; Store backups in a more conventional way
(use-package emacs
  :config
  (setq backup-directory-alist `(("." . "~/.saves"))))

;; Loading environment paths, so Emacs can find installed binaries
(use-package exec-path-from-shell
  :init
  (exec-path-from-shell-initialize))

;; vim keybinds
(use-package evil
  :demand
  :config
  (evil-mode 1))

;; Doom themes
(use-package doom-themes
  :demand
  :config
  (load-theme 'doom-challenger-deep t))

;; Doom modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; Nerd icons
(use-package nerd-icons)

;; Nyan cat
(use-package nyan-mode
  :straight t
  :init
  (nyan-mode))

;; Which key
(use-package which-key
  :demand
  :init
  (setq which-key-idle-delay 0.5) ; Open after .5s instead of 1s
  :config
  (which-key-mode))

;; Set up general.el for custom keybinds
(use-package general
  :demand
  :config
  (general-evil-setup)

  (general-create-definer leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

  (leader-keys
    "x" '(execute-extended-command :which-key "execute command")
    "r" '(restart-emacs :whick-key "restart emacs")
    "i" '((lambda () (interactive) (find-file user-init-file)) :which-key "open init file")

    ;; Buffer
    "b" '(:ignore t :which-key "buffer")
    ;; Don't show an error because SPC b ESC is undefined, just abort
    "b <escape>" '(keyboard-escape-quit :which-key t)
    "bd"  'kill-current-buffer))

;; File finding
(use-package projectile
  :demand
  :general
  (leader-keys
    :states 'normal
    "SPC" '(projectile-find-file :which-key "find file")

    ;; Buffers
    "b b" '(projectile-switch-to-buffer :which-key "switch buffer")

    ;; Projects
    "p" '(:ignore t :which-key "projects")
    "p <escape>" '(keyboard-escape-quit :which-key t)
    "p p" '(projectile-switch-project :which-key "switch project")
    "p a" '(projectile-add-known-project :which-key "add project")
    "p r" '(projectile-remove-known-project :which-key "remove project"))
  :init
  (projectile-mode +1))

;; Fuzzy finding
(use-package ivy
  :config
  (ivy-mode))

;; Git integration
(use-package magit
  :general
  (leader-keys
    "g" '(:ignore t :which-key "git")
    "g <escape>" '(keyboard-escape-quit :which-key t)
    "g g" '(magit-status :which-key "status")
    "g l" '(magit-log :which-key "log"))
  (general-nmap
    "<escape>" #'transient-quit-one))

;; Better git integration with evil-collection
(use-package evil-collection
  :after evil
  :demand
  :config
  (evil-collection-init))

;; Show diffs in git
(use-package diff-hl
  :init
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  :config
  (global-diff-hl-mode))

;; Terminal
(use-package vterm-toggle
  :general
  (leader-keys
    "'" '(vterm-toggle :which-key "terminal")))

;; Comment lines
(use-package evil-nerd-commenter
  :general
  (general-nvmap
    "gc" 'evilnc-comment-operator))

;; Garbage collection
(use-package gcmh
  :demand
  :config
  (gcmh-mode 1))

;; Don't use escape as a modifier
(use-package emacs
  :init
	(global-set-key (kbd "<escape>") 'keyboard-escape-quit))

;; Code completion
(use-package company-mode
  :init
  (global-company-mode))

;; eglot LSP
(use-package emacs
  :hook (zig-mode . eglot-ensure)
  :hook (rust-mode . eglot-ensure)
  :hook (go-mode . eglot-ensure)
  :hook (typescript-mode . eglot-ensure)
  :hook (c-mode . eglot-ensure)
  :hook (c++-mode . eglot-ensure)
  :hook (python-mode . eglot-ensure)
  :general
  (leader-keys
    "l" '(:ignore t :which-key "lsp")
    "l <escape>" '(keyboard-escape-quit :which-key t)
    "l r" '(eglot-rename :which-key "rename")
    "l a" '(eglot-code-actions :which-key "code actions")))

;; Treesitter for syntax highlighting
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; Tree-sitter configuration
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; Language modes and keybindings

;; Python mode
(use-package python-mode
  :general
  (leader-keys
    "m" '(:ignore t :which-key "mode")
    "m <escape>" '(keyboard-escape-quit :which-key t)
    "m r" '(python-shell-send-buffer :which-key "run buffer")
    "m b" '(python-shell-send-file :which-key "run file")
    "m t" '(python-shell-send-region :which-key "run region")
    "m c" '(python-check :which-key "check")))

;; C/C++ mode
(use-package cc-mode
  :general
  (leader-keys
    "m" '(:ignore t :which-key "mode")
    "m <escape>" '(keyboard-escape-quit :which-key t)
    "m c" '(compile :which-key "compile")
    "m r" '(recompile :which-key "recompile")
    "m d" '(gdb :which-key "debug with gdb")
    "m f" '(ff-find-other-file :which-key "find header/source")))

;; Example configurations for other modes (markdown, rust, etc.)
(use-package markdown-mode
  :config
  (setq markdown-fontify-code-blocks-natively t))

(use-package zig-mode
  :general
  (leader-keys
    "m" '(:ignore t :which-key "mode")
    "m <escape>" '(keyboard-escape-quit :which-key t)
    "m b" '(zig-compile :which-key "build")
    "m r" '(zig-run :which-key "run")
    "m t" '(zig-test :which-key "test")))

(use-package rust-mode
  :general
  (leader-keys
    "m" '(:ignore t :which-key "mode")
    "m <escape>" '(keyboard-escape-quit :which-key t)
    "m b" '(rust-compile :which-key "build")
    "m r" '(rust-run :which-key "run")
    "m t" '(rust-test :which-key "test")
    "m k" '(rust-check :which-key "check")
    "m c" '(rust-run-clippy :which-key "clippy")))

(use-package go-mode)
(use-package gotest
  :general
  (leader-keys
    "m" '(:ignore t :which-key "mode")
    "m <escape>" '(keyboard-escape-quit :which-key t)
    "m t" '(go-test-current-project :which-key "test")
    "m r" '(go-run :which-key "run")))

(use-package typescript-mode)

;; Searching
(use-package rg
  :general
  (leader-keys
    "f" '(rg-menu :which-key "find")))
