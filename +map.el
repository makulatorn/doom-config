(map! :g "M-1" #'centaur-tabs-backward
      :g "M-2" #'centaur-tabs-forward)

(map! :nv "M-<left>" #'+workspace/switch-left
      :nv "M-<right>" #'+workspace/switch-right)

(setq +workspace-cycle-wrap t)

(map! :leader
      :desc "Take a screenshot" "S" #'screenshot)

(map! :n "C-;" #'embark-act)

(map! :leader
      :desc "Aphelia buffer on/off" "A" #'apheleia-mode)

(map! :leader
      :desc "Live preview" "o v" #'httpd-serve-directory)

(map! :map meow-normal-state-keymap
      :desc "align-regexp" "`" #'align-regexp)

(after! meow
  (meow-normal-define-key
   '("k" . my/code-action)
   '("<" . mc/mark-previous-symbol-like-this)
   '(">" . mc/mark-next-like-this)
   '("\"" . (lambda () (interactive) (my/meow-wrap-region "\"" "\"")))
   '("'"  . (lambda () (interactive) (my/meow-wrap-region "'" "'")))
   '("("  . (lambda () (interactive) (my/meow-wrap-region "(" ")")))
   '(")"  . (lambda () (interactive) (my/meow-wrap-region "(" ")")))
   '("["  . (lambda () (interactive) (my/meow-wrap-region "[" "]")))
   '("]"  . (lambda () (interactive) (my/meow-wrap-region "[" "]")))
   '("{"  . (lambda () (interactive) (my/meow-wrap-region "{" "}")))
   '("}"  . (lambda () (interactive) (my/meow-wrap-region "{" "}")))))
