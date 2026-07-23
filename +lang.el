;; --- PYTHON ---
(after! python
  (add-hook 'python-mode-hook
            (lambda ()
              (setq-local lsp-enabled-clients '(pyright ruff)))))
