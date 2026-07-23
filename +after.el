(after! company
  (setq company-idle-delay 0.0
        company-minimum-prefix-length 1))
(add-hook 'text-mode-hook #'completion-preview-mode)
(add-hook 'conf-mode-hook #'completion-preview-mode)

(after! meow
  (meow-normal-define-key
   '("k" . my/code-action)))


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

(after! eglot
  (add-to-list 'eglot-ignored-server-capabilities :documentFormattingProvider))

(after! python
  (add-hook 'python-mode-hook
            (lambda ()
              (setq-local lsp-enabled-clients '(pyright ruff)))))

(after! transient
  (setq transient-display-buffer-action
        '(display-buffer-in-side-window
          (side . bottom)
          (dedicated . t)
          (window-height . 0.4)))
  (setq transient-show-menu t)
  (setq transient-show-common-commands t))

(after! screenshot
  (advice-add 'read-file-name :around
              (lambda (orig-fun prompt &optional dir default-filename mustmatch initial predicate)
                (let ((new-dir (if (string-prefix-p "Save as: " prompt)
                                   "/home/trasha/images/"
                                 dir)))
                  (funcall orig-fun prompt new-dir default-filename mustmatch initial predicate)))))
