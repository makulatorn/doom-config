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
    `(helm-selection :background "#262626" :foreground "#5BCEFA" :weight bold)
    ;; The general Helm buffer background and normal text
    `(helm-source-header :background "#1c1c1c" :foreground "#F5A9B8" :weight bold)
    ;; Fuzzy matching / search highlights
    `(helm-match :foreground "#FFFFFF" :weight bold)
    `(helm-moccur-buffer :foreground "#F5A9B8")
    ;; Header line at the top of Helm
    `(helm-header :background "#121212" :foreground "#5BCEFA")))

(after! (helm xref)
  (setq xref-show-xrefs-function #'helm-xref-show-xrefs
        xref-show-definitions-function #'helm-xref-show-defs-with-pager))
