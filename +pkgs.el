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
  (setq completion-preview-minimum-symbol-length 3
        completion-preview-idle-delay 0.6))

(use-package! eldoc-box
  :ghook ('(eglot-managed-mode-hook lsp-mode-hook) #'eldoc-box-hover-mode)
  :config
  (add-hook 'eldoc-box-buffer-setup-hook #'eldoc-box-prettify-ts-errors 0 t)
  (custom-set-faces!
    '(eldoc-box-body :inherit tooltip)
    '(eldoc-box-border :inherit tooltip))
  (setq eldoc-idle-delay 0.5)
  (setq eldoc-box-frame-parameters
        '((alpha-background . 75)
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
  (blamer-face ((t :foreground "#f5a9b8"
                   :height 0.9)))
  :config
  (setq blamer-prettify-time-p nil
        blamer-datetime-formatter "[%s]"
        blamer-entire-formatter " %s"))

(use-package! flx)

(setq css-fontify-colors nil)

(remove-hook! '(prog-mode-hook
                text-mode-hook
                css-mode-hook
                web-mode-hook
                emacs-lisp-mode-hook)
  #'rainbow-mode
  #'+rainbow-mode-h
  #'+rainbow-init-h)

(use-package colorful-mode
  ;; :diminish
  ;; :ensure t ; Optional
  :custom
  (colorful-use-prefix nil)
  (colorful-only-strings 'only-prog)
  (css-fontify-colors nil)
  (colorful-highlight-in-comments t)
  :config
  (add-to-list 'colorful-extra-color-keyword-functions
               '(prog-mode . (colorful-add-hex-colors
                              colorful-add-rgb-colors
                              colorful-add-hsl-colors
                              colorful-add-oklab-oklch-colors
                              colorful-add-css-variables-colors
                              colorful-add-web-color-names
                              colorful-add-emacs-color-names
                              colorful-add-latex-colors
                              colorful-add-ansi-shell-colors)))
  (global-colorful-mode t)
  (add-to-list 'global-colorful-modes 'helpful-mode))

(use-package! scopeline
  :hook (prog-mode . scopeline-mode))
