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

(meow-normal-define-key
 '("<" . mc/mark-previous-like-this)
 '(">" . mc/mark-next-like-this))
