(use-package! rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(setq treesit-extra-load-path
      (append (list (expand-file-name "tree-sitter" doom-cache-dir))
              (let ((profiles (split-string (or (getenv "NIX_PROFILES") ""))))
                (cl-loop for profile in profiles
                         append (list (expand-file-name "lib/tree-sitter" profile)
                                      (expand-file-name "lib" profile))))))

(use-package! aggressive-indent
  :hook (emacs-lisp-mode . aggressive-indent-mode))

(use-package! completion-preview
  :hook (prog-mode . completion-preview-mode)
  :config
  (setq completion-preview-minimum-symbol-length 1
        completion-preview-idle-delay 0.0))

(use-package! eldoc-box
  :ghook ('(eglot-managed-mode-hook lsp-mode-hook) #'eldoc-box-hover-mode)
  :config
  (add-hook 'eldoc-box-buffer-setup-hook #'eldoc-box-prettify-ts-errors 0 t)
  (custom-set-faces!
    '(eldoc-box-body :inherit tooltip)
    '(eldoc-box-border :inherit tooltip))
  (setq eldoc-box-frame-parameters
        '((alpha-background . 80)
          (undecorated . t)
          (no-accept-focus . t)
          (internal-border-width . 10))))

(use-package! apheleia
  :config
  (apheleia-global-mode +1)

  (set-formatter! 'ruff '("ruff" "format" "--stdin-filename" filepath "-")
    :modes '(python-mode python-ts-mode))

  (set-formatter! 'prettierd '("prettierd" "--stdin-filepath" filepath))
  (setq apheleia-mode-alist
        (append '((html-mode   . prettierd)
                  (web-mode    . prettierd)
                  (css-mode    . prettierd)
                  (scss-mode   . prettierd)
                  (js-mode     . prettierd)
                  (js-ts-mode  . prettierd)
                  (js2-mode    . prettierd)
                  (rjsx-mode   . prettierd)
                  (python-mode . ruff)
                  (python-ts-mode . ruff))
                apheleia-mode-alist)))

(use-package! blamer
  :bind (("s-i" . blamer-show-commit-info))
  :init
  (global-blamer-mode 1)
  :custom
  (blamer-idle-time 0.5)
  (blamer-min-offset 40)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                   :height 0.9)))
  :config
  (setq blamer-prettify-time-p nil
        blamer-datetime-formatter "[%s]"
        blamer-entire-formatter " %s"))

(use-package! tamagotchi
  :defer t
  :commands (tamagotchi tamacare tamastatus)
  :init
  (setq tamagotchi-save-file "~/.config/doom/.tamagotchi"))

(use-package! flx)

(use-package! rainbow-mode
  :hook ((prog-mode text-mode) . rainbow-mode)
  :config
  (add-hook 'magit-mode-hook (lambda () (rainbow-mode -1))))
