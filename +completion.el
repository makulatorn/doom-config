(after! company
  (setq company-idle-delay 0.3
        company-minimum-prefix-length 3))
(add-hook 'text-mode-hook #'completion-preview-mode)
(add-hook 'conf-mode-hook #'completion-preview-mode)

(after! eglot
  (add-to-list 'eglot-ignored-server-capabilities :documentFormattingProvider))

(after! (helm xref)
  (setq xref-show-xrefs-function #'helm-xref-show-xrefs
        xref-show-definitions-function #'helm-xref-show-defs-with-pager))

(after! flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp emacs-lisp-checkdoc)))
