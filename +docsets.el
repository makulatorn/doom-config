(use-package! devdocs
  :bind (:map doom-leader-map
              ("h D" . devdocs-lookup))
  :init
  (defmacro my/devdocs-hook (mode &rest docs)
    `(add-hook ',mode (lambda () (setq-local devdocs-current-docs ',docs))))

  (my/devdocs-hook python-ts-mode-hook "python~3.12" "django~5.1")
  (my/devdocs-hook js-ts-mode-hook     "javascript" "node")
  (my/devdocs-hook web-mode-hook       "html" "css" "django~5.1")
  (my/devdocs-hook emacs-lisp-mode-hook "elisp")
  :config
  (add-hook 'devdocs-mode-hook (lambda ()
                                 (visual-line-mode 1)
                                 (adaptive-wrap-prefix-mode 1))))
