(defun my/code-action ()
  "I do NOT like the emacs keybind for running code actions using eglot, it was seemingly hard to configure the keybind so this defun interactively calls the eglot-code-actions, so I can map my desired to key to run this function
  "
  (interactive)
  (cond ((bound-and-true-p eglot--managed-mode)
         (call-interactively #'eglot-code-actions))
        ((bound-and-true-p lsp-mode)
         (call-interactively #'lsp-execute-code-action))
        (t (user-error "No active LSP client"))))
