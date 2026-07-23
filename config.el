;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq doom-theme 'doom-ir-black)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")

(load! "+pkgs")
(load! "+map")
(load! "+after")

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

;; Indentation Defaults
(setq-default tab-width 2
              evil-shift-width 2)
(setq css-indent-offset 2
      js-indent-level 2
      typescript-indent-level 2
      web-mode-code-indent-offset 2
      web-mode-markup-indent-offset 2)

(setq-default flycheck-stylelintrc "/home/trasha/.stylelintrc")

(defun my/code-action ()
  "Run code action"
  (interactive)
  (cond ((bound-and-true-p eglot--managed-mode)
         (call-interactively #'eglot-code-actions))
        ((bound-and-true-p lsp-mode)
         (call-interactively #'lsp-execute-code-action))
        (t (user-error "No active LSP client"))))

(add-hook! 'prog-mode-hook #'+word-wrap-mode)
