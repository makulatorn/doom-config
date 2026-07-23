(after! company
  (setq company-idle-delay 0.0
        company-minimum-prefix-length 1))
(add-hook 'text-mode-hook #'completion-preview-mode)
(add-hook 'conf-mode-hook #'completion-preview-mode)

(after! eglot
  (add-to-list 'eglot-ignored-server-capabilities :documentFormattingProvider))

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

(after! (helm xref)
  (setq xref-show-xrefs-function #'helm-xref-show-xrefs
        xref-show-definitions-function #'helm-xref-show-defs-with-pager))
