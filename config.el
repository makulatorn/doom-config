;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq doom-theme 'doom-ir-black)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")

;; Consolidated Path and Environment Logic
(setq-default load-path (append package-activated-list load-path))
(use-package! exec-path-from-shell
  :config
  (setq exec-path-from-shell-variables '("PATH" "MANPATH" "NIX_PROFILES" "NIX_SSL_CERT_FILE"))
  (when (memq window-system '(x pgtk))
    (exec-path-from-shell-initialize))
  ;; Add cargo after the shell sync to ensure it persists
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

(global-aggressive-indent-mode 1)
(after! aggressive-indent
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'web-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'nunjucks-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'django-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'python-mode))

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

;; Eshell
(after! eshell
  (set-eshell-alias!
   "pre-commit"
   "docker exec ${docker ps -qf \"ancestor=easyrf\"} pre-commit run --all-files"))

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
  :hook (lsp-mode . eldoc-box-hover-at-point-mode)
  :config
  (setq eldoc-box-hover-display-frame-above-point t
        eldoc-box-max-pixel-width 600
        eldoc-box-max-pixel-height 400
        eldoc-box-offset '(20 20 20)
        eldoc-box-frame-parameters
        '((alpha . 85)
          (undecorated . t)
          (no-accept-focus . t))))

;; LSP & Python
(after! lsp-mode
  (setq lsp-idle-delay 0.1
        lsp-ui-doc-delay 0.1
        lsp-signature-doc-lines 1)
  (setq lsp-enable-file-watchers nil)
  (setq lsp-file-watch-threshold 500)
  (setq lsp-pyright-langserver-command "basedpyright"
        lsp-pyright-type-checking-mode "basic"
        lsp-pyright-auto-import-completions t
        lsp-headerline-breadcrumb-enable nil
        lsp-ui-doc-enable nil
        lsp-eldoc-render-all t
        lsp-signature-auto-activate t
        lsp-signature-render-documentation t)

  (let ((nix-python-path (expand-file-name
                          (concat "~/.nix-profile/lib/python"
                                  (string-trim (shell-command-to-string "python3 -c 'import sys; print(f\"{sys.version_info.major}.{sys.version_info.minor}\")'"))
                                  "/site-packages"))))
    (setq lsp-pyright-extra-paths (vector nix-python-path))))

(after! python
  (setq-hook! 'python-mode-hook +format-with-ruff-ts-mode t)
  (add-hook 'python-mode-hook
            (lambda ()
              (setq-local lsp-enabled-clients '(pyright ruff)))))
(setq +format-on-save-enabled-modes '(python-mode))

(after! apheleia
  (set-formatter! 'prettierd '("prettierd" "--stdin-filepath" filepath))
  (setq apheleia-mode-alist
        (append '((html-mode . prettierd)
                  (web-mode . prettierd)
                  (css-mode . prettierd)
                  (scss-mode . prettierd))
                apheleia-mode-alist))
  (setq apheleia-formatters-respect-indent-level nil)
  (set-formatter! 'ruff '("ruff" "format" "--stdin-filename" filepath "-") :modes '(python-mode))
  (setq apheleia-mode-alist (cons '(python-mode . ruff)
                                  (assoc-delete-all 'python-mode apheleia-mode-alist))))

(after! vertico
  (setq vertico-cycle t)
  (setq vertico-resize t))

(after! consult
  (setq consult-preview-key 'any)
  (setq consult-project-function (lambda (_) (projectile-project-root))))

(after! transient
  (setq transient-display-buffer-action
        '(display-buffer-in-side-window
          (side . bottom)
          (dedicated . t)
          (window-height . 0.4)))
  (setq transient-show-popup t)
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
