(defun my/code-action ()
  "I do NOT like the emacs keybind for running code actions using eglot, it was seemingly hard to configure the keybind so this defun interactively calls the eglot-code-actions, so I can map my desired to key to run this function
  "
  (interactive)
  (cond ((bound-and-true-p eglot--managed-mode)
         (call-interactively #'eglot-code-actions))
        ((bound-and-true-p lsp-mode)
         (call-interactively #'lsp-execute-code-action))
        (t (user-error "No active LSP client"))))

(defun my/meow-wrap-region (open close)
  "Wrap active region or character at point with OPEN and CLOSE."
  (interactive)
  (if (use-region-p)
      (let ((beg (region-beginning))
            (end (region-end)))
        (save-excursion
          (goto-char end)
          (insert close)
          (goto-char beg)
          (insert open)))
    (insert open close)
    (backward-char (length close))))
