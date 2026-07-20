;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq doom-theme 'doom-ir-black)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")

;; Consolidated Path and Environment Logic
(use-package! exec-path-from-shell
  :config
  (setq exec-path-from-shell-variables '("PATH" "MANPATH" "NIX_PROFILES" "NIX_SSL_CERT_FILE"))
  (when (memq window-system '(x pgtk))
    (exec-path-from-shell-initialize))
  ;; Add cargo after the shell sync to ensure it persists
  (add-to-list 'exec-path "/home/trasha/.npm/bin")
  (setenv "PATH" (concat "/home/trasha/.npm/bin:" (getenv "PATH")))
  (add-to-list 'exec-path "/home/trasha/.cargo/bin")
  (setenv "PATH" (concat "/home/trasha/.cargo/bin:" (getenv "PATH"))))

;; Packages & Modes
(use-package! rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(setq treesit-extra-load-path
      (append (list (expand-file-name "tree-sitter" doom-cache-dir))
              (let ((profiles (split-string (or (getenv "NIX_PROFILES") ""))))
                (cl-loop for profile in profiles
                         append (list (expand-file-name "lib/tree-sitter" profile)
                                      (expand-file-name "lib" profile))))))
(use-package aggressive-indent
  :hook (emacs-lisp-mode . aggressive-indent-mode))

(use-package! completion-preview
  :hook (prog-mode . completion-preview-mode)
  :config
  (setq completion-preview-minimum-symbol-length 1
        completion-preview-idle-delay 0.0))

(after! company
  (setq company-idle-delay 0.0
        company-minimum-prefix-length 1))
(add-hook 'text-mode-hook #'completion-preview-mode)
(add-hook 'conf-mode-hook #'completion-preview-mode)

;; Keybindings & Workspaces
(map! :g "M-1" #'centaur-tabs-backward
      :g "M-2" #'centaur-tabs-forward)
(map! :nv "M-<left>" #'+workspace/switch-left
      :nv "M-<right>" #'+workspace/switch-right)
(setq +workspace-cycle-wrap t)
(map! :leader
      :desc "Take a screenshot" "S" #'screenshot)
(map! :n "C-;" #'embark-act)
(map! :leader
      :desc "Aphelia buffer on/off" "A" #'apheleia-mode)
(map! :leader
      :desc "Live preview" "o v" #'httpd-serve-directory)

(meow-normal-define-key
 '("<" . mc/mark-previous-like-this)
 '(">" . mc/mark-next-like-this))

;; Indentation Defaults
(setq-default tab-width 2
              evil-shift-width 2)
(setq css-indent-offset 2
      js-indent-level 2
      typescript-indent-level 2
      web-mode-code-indent-offset 2
      web-mode-markup-indent-offset 2)

;; Git Blame
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

;; Eldoc Box (The working version)
(use-package! eldoc-box
  :ghook ('(eglot-managed-mode-hook lsp-mode-hook) #'eldoc-box-hover-at-point-mode)
  :config
  (custom-set-faces!
    '(eldoc-box-body :inherit tooltip)
    '(eldoc-box-border :inherit tooltip))

  (setq eldoc-box-max-pixel-width 600
        eldoc-box-max-pixel-height 400
        eldoc-box-offset '(20 20 20)
        eldoc-box-frame-parameters
        '((alpha . 95)
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
        (append '((html-mode . prettierd)
                  (web-mode . prettierd)
                  (css-mode . prettierd)
                  (scss-mode . prettierd)
                  (python-mode . ruff)
                  (python-ts-mode . ruff))
                apheleia-mode-alist)))

(after! eglot
  (add-to-list 'eglot-ignored-server-capabilities :documentFormattingProvider))

(after! python
  (add-hook 'python-mode-hook
            (lambda ()
              (setq-local lsp-enabled-clients '(pyright ruff)))))

(after! transient
  (setq transient-display-buffer-action
        '(display-buffer-in-side-window
          (side . bottom)
          (dedicated . t)
          (window-height . 0.4)))
  (setq transient-show-menu t)
  (setq transient-show-common-commands t))

(after! screenshot
  (advice-add 'read-file-name :around
              (lambda (orig-fun prompt &optional dir default-filename mustmatch initial predicate)
                (let ((new-dir (if (string-prefix-p "Save as: " prompt)
                                   "/home/trasha/images/"
                                 dir)))
                  (funcall orig-fun prompt new-dir default-filename mustmatch initial predicate)))))

(setq-default flycheck-stylelintrc "/home/trasha/.stylelintrc")

(use-package! tamagotchi
  :defer t
  :commands (tamagotchi tamacare tamastatus)
  :init
  (setq tamagotchi-save-file "~/.config/doom/.tamagotchi"))

(defun my/code-action ()
  "Run code action"
  (interactive)
  (cond ((bound-and-true-p eglot--managed-mode)
         (call-interactively #'eglot-code-actions))
        ((bound-and-true-p lsp-mode)
         (call-interactively #'lsp-execute-code-action))
        (t (user-error "No active LSP client"))))

(after! meow
  (meow-normal-define-key
   '("k" . my/code-action)))

(use-package! flx)

(after! helm
  (custom-set-faces!
    ;; The active/selected line in Helm
    `(helm-selection :background "#262626" :foreground "#ffffff" :weight bold)
    ;; The general Helm buffer background and normal text
    `(helm-source-header :background "#1c1c1c" :foreground "#FFD700" :weight bold)
    ;; Fuzzy matching / search highlights
    `(helm-match :foreground "#FF5F87" :weight bold)
    `(helm-moccur-buffer :foreground "#8787FF")
    ;; Header line at the top of Helm
    `(helm-header :background "#121212" :foreground "#767676")))
