;; --- PYTHON ---
(setq major-mode-remap-alist
      '((python-mode . python-ts-mode)))

(after! python
  (add-hook 'python-mode-hook
            (lambda ()
              (setq-local lsp-enabled-clients '(pyright ruff)))))

;; --- TREESITTER ---
(setq treesit-language-source-alist
      '((python     . ("https://github.com/tree-sitter/tree-sitter-python"))
        (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
        (elisp      . ("https://github.com/Wilfred/tree-sitter-elisp"))
        (json       . ("https://github.com/tree-sitter/tree-sitter-json"))
        ))
(setq treesit-extra-load-path
      '("/etc/profiles/per-user/trasha/lib"))
