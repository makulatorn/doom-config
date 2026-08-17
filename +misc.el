
(after! screenshot
  (advice-add 'read-file-name :around
              (lambda (orig-fun prompt &optional dir default-filename mustmatch initial predicate)
                (let ((new-dir (if (string-prefix-p "Save as: " prompt)
                                   "/home/trasha/images/"
                                 dir)))
                  (funcall orig-fun prompt new-dir default-filename mustmatch initial predicate)))))

(after! transient
  (setq transient-display-buffer-action
        '(display-buffer-in-side-window
          (side . bottom)
          (dedicated . t)
          (window-height . 0.4)))
  (setq transient-show-menu t)
  (setq transient-show-common-commands t))

(use-package! showkey
  :commands (showkey-tooltip-mode showkey-log-mode)
  :init
  (map! :leader
        (:prefix-map ("t" . "toggle")
         :desc "Showkey tooltip" "k" #'showkey-tooltip-mode
         :desc "Showkey log"     "K" #'showkey-log-mode)))
