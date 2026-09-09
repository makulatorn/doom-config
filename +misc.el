
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

(use-package! poimap
  :init
  (setq poimap-height 1.35
        poimap-width 0.38)
  :config
  (poimap-mode 1)

  (require 'poimap-bookmark)
  (setq poimap-bookmark-vertical-position 0.37)
  (poimap-bookmark 1)

  (require 'poimap-bm)
  (setq poimap-bm-vertical-position 0.37)
  (poimap-bm 1)

  (require 'poimap-current-symbol)
  (setq poimap-current-symbol-vertical-position 0.65)
  (poimap-current-symbol 1)

  (require 'poimap-diff-hl)
  (poimap-diff-hl 1)

  (require 'poimap-flymake)
  (setq poimap-flymake-vertical-position 0.37)
  (poimap-flymake 1)

  (require 'poimap-imenu)
  (poimap-imenu 1)

  (require 'poimap-isearch)
  (setq poimap-isearch-vertical-position 0.65)
  (poimap-isearch 1)

  (require 'poimap-register)
  (setq poimap-register-vertical-position 0.37)
  (poimap-register 1)

  (require 'poimap-swiper)
  (setq poimap-swiper-vertical-position 0.65)
  (poimap-swiper 1))
