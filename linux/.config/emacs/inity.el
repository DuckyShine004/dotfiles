(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(use-package lsp-mode
  :ensure t
  :hook ((c++-mode . lsp)
         (c-mode . lsp))
  :commands lsp
  :config
  (setq lsp-clients-clangd-executable "/usr/bin/clangd")
  (setq lsp-enable-on-type-formatting nil))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-enable nil
        lsp-ui-doc-enable t
        lsp-ui-doc-show-with-cursor t))

(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1)
  (add-to-list 'company-backends 'company-capf))

(use-package clang-format
  :ensure t
  :bind ("C-c f" . clang-format-buffer)
  :config
  (setq clang-format-style-option "llvm"))

(use-package tree-sitter
  :ensure t
  :hook ((c-mode . tree-sitter-mode)
         (c++-mode . tree-sitter-mode)))

(use-package tree-sitter-langs
  :ensure t)

(use-package format-all
  :ensure t
  :hook ((prog-mode . format-all-ensure-formatter)
         (prog-mode . format-all-mode))
  :config
  (setq format-all-default-formatters
        '(("Python" black)
          ("JavaScript" prettier)
          ("TypeScript" prettier)
          ("C++" clang-format)
          ("C" clang-format)))

  (defun format-all-buffer-on-save ()
    "Format the buffer with format-all before saving."
    (when format-all-mode
      (format-all-buffer)))

  (add-hook 'before-save-hook 'format-all-buffer-on-save))

(use-package yasnippet
  :ensure t
  :hook ((c-mode . yas-minor-mode)
         (c++-mode . yas-minor-mode))
  :config
  (yas-global-mode 1))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(electric-pair-mode 1)

(global-auto-revert-mode 1)  ;; Enable auto-revert-mode globally
(setq auto-revert-verbose t)  ;; Enable notifications for buffer reverts

(use-package catppuccin-theme
  :ensure t
  :config
  (setq catppuccin-flavor 'mocha)  ;; Choose the flavor: 'latte, 'frappe, 'macchiato, 'mocha
  (catppuccin-set-color 'base "#0E1018")
  (catppuccin-reload)
  (load-theme 'catppuccin t))
