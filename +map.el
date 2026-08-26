(map! :g "M-1" #'centaur-tabs-backward
      :g "M-2" #'centaur-tabs-forward)

(map! :leader
      :desc "Take a screenshot" "S" #'screenshot)

(map! :n "C-;" #'embark-act)

(map! :leader
      :desc "Aphelia buffer on/off" "A" #'apheleia-mode)

(map! :leader
      :desc "Live preview" "o v" #'httpd-serve-directory)

(map! :map meow-normal-state-keymap
      :desc "align-regexp" "`" #'align-regexp)

(map! :leader
      :desc "Kill current buffer" "b q" #'kill-current-buffer)

(after! meow
  (meow-normal-define-key
   '("F"   . +helm/projectile-find-file)
   '("X"   . meow-kill)
   '("S"   . +default/search-project)
   '("s"   . swiper-helm)
   '("Y"   . +lookup/references)
   '("y"   . +lookup/definition)
   '("p"   . devdocs-lookup)
   '("P"   . +lookup/in-all-docsets)
   '("G"   . goto-line)
   '("C"   . meow-save)
   '("V"   . meow-yank)
   '("R"   . undo-redo)
   '("Q"   . meow-undo)
   '("c"   . my/code-action)
   '("i"   . meow-prev)
   '("k"   . meow-next)
   '("j"   . meow-left)
   '("l"   . meow-right)
   '("C-i" . backward-paragraph)
   '("C-k" . forward-paragraph)
   '("u"   . backward-word)
   '("o"   . forward-word)
   '("<"   . mc/mark-previous-symbol-like-this)
   '(">"   . mc/mark-next-like-this)
   '("\""  . (lambda () (interactive) (my/meow-wrap-region "\"" "\"")))
   '("'"   . (lambda () (interactive) (my/meow-wrap-region "'" "'")))
   '("("   . (lambda () (interactive) (my/meow-wrap-region "(" ")")))
   '(")"   . (lambda () (interactive) (my/meow-wrap-region "(" ")")))
   '("["   . (lambda () (interactive) (my/meow-wrap-region "[" "]")))
   '("]"   . (lambda () (interactive) (my/meow-wrap-region "[" "]")))
   '("{"   . (lambda () (interactive) (my/meow-wrap-region "{" "}")))
   '("}"   . (lambda () (interactive) (my/meow-wrap-region "{" "}")))))
