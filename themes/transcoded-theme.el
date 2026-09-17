;;; transcoded-theme.el --- ported from Vim's ir_black colorscheme, personal fork -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Author: trasha <https://github.com/makulatorn> <https://gitlab.com/trasha>
;; Maintainer: Trasha (personal fork)
;; Source: https://github.com/twerth/ir_black
;;
;;; Commentary:
;;; Code:

(require 'doom-themes)

;;
;;; Variables

(defgroup transcoded nil
  "Options for the `transcoded' theme."
  :group 'doom-themes)

(defcustom transcoded-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'transcoded
  :type 'boolean)

(defcustom transcoded-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.

Can be an integer to determine the exact padding."
  :group 'transcoded
  :type '(or integer boolean))

;;
;;; Theme definition

(def-doom-theme transcoded
    "A port of the original IR Black colorscheme (personal fork)."

  ;; name        default          256           16
  ((bg         '("#000000" "black" "black"))
   (fg         '("#f6f3e8" "#f6f3e8" "brightwhite"))

   (bg-alt     '("#121212" "black" "black"))
   (fg-alt     '("#5B6268" "#2d2d2d" "white"))

   (base0      '("#1B2229" "black" "black"))
   (base1      '("#1c1f24" "#1e1e1e" "brightblack"))
   (base2      '("#202328" "#2e2e2e" "brightblack"))
   (base3      '("#23272e" "#262626" "brightblack"))
   (base4      '("#3f444a" "#3f3f3f" "brightblack"))
   (base5      '("#5B6268" "#525252" "brightblack"))
   (base6      '("#7d838a" "#6b6b6b" "brightblack"))
   (base7      '("#979797" "#979797" "brightblack"))
   (base8      '("#DFDFDF" "#dfdfdf" "white"))
   (white      '("#ffffff" "#ffffff" "white"))

   (grey base4)
   (red        '("#FF5E5E" "#FF5E5E" "red"))
   (red-alt    '("#FF529A" "#FF529A" "red"))
   (orange     '("#DDF3AB" "#DDF3AB" "brightred"))
   (orange-alt '("#C0A9F5" "#C0A9F5" "brightred"))
   (green      '("#60FFB7" "#60FFB7" "green"))
   (green-alt  '("#A1E1CA" "#A1E1CA" "green"))
   (teal       '("#00A0A0" "#00A0A0" "brightgreen"))
   (yellow     '("#FFFFB6" "#FFFFB6" "yellow"))
   (blue       '("#5BCEFA" "#5BCEFA" "brightblue"))
   (dark-blue  '("#2257A0" "#2257A0" "blue"))
   (magenta    '("#FF8CA5" "#FF8CA5" "magenta"))
   (violet     '("#a9a1e1" "#a9a1e1" "brightmagenta"))
   (cyan       '("#96CBFE" "#96CBFE" "brightcyan"))
   (dark-cyan  '("#5699AF" "#5699AF" "cyan"))

   ;; face categories -- required for all themes
   (highlight blue)
   (vertical-bar base5)
   (selection cyan)
   (builtin base8)
   (comments
    (if transcoded-brighter-comments base6 base6))
   (doc-comments
    (doom-lighten
     (if transcoded-brighter-comments base6 base6) 0.25))
   (constants base8)
   (functions fg)
   (keywords white)
   (methods base7)
   (operators white)
   (type fg)
   (strings base8)
   (variables fg)
   (numbers red-alt)
   (region `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base0) 0.35)))
   (error red)
   (warning yellow)
   (success green)
   (vc-modified orange-alt)
   (vc-added green)
   (vc-deleted red)

   ;; custom categories
   (-modeline-pad
    (when transcoded-padded-modeline
      (if (integerp transcoded-padded-modeline) transcoded-padded-modeline 4)))

   (modeline-fg white)
   (modeline-fg-alt base5)
   (modeline-bg base4)
   (modeline-bg-inactive base3))

;;;; Base theme face overrides
  (((font-lock-comment-face &override)
    :background (if transcoded-brighter-comments (doom-lighten bg 0.05) 'unspecified))
   ((font-lock-keyword-face &override) :weight 'bold)
   ((font-lock-function-name-face &override) :weight 'bold)
   ((font-lock-builtin-face &override) :weight 'bold)
   ((font-lock-constant-face &override) :weight 'bold :slant 'italic)
   ((font-lock-type-face &override) :slant 'italic)
   ((font-lock-variable-name-face &override) :slant 'italic)
   ((line-number &override) :foreground base5)

;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property         :foreground white)
   (css-property                     :foreground base6)
   (css-selector                     :foreground white)

;;;; elscreen
   (elscreen-tab-other-screen-face   :background "#353a42"
                                     :foreground "#1e2022")

;;;; markdown-mode
   (markdown-markup-face             :foreground base5)
   (markdown-header-face             :inherit 'bold
                                     :foreground red)
   (markdown-code-face               :background (doom-lighten base3 0.05))


;;;; centaur-tabs
   (centaur-tabs-default             :background bg
                                     :foreground bg)
   (centaur-tabs-selected            :background bg-alt
                                     :foreground fg)
   (centaur-tabs-selected-modified   :background bg-alt
                                     :foreground blue)
   (centaur-tabs-unselected          :background bg
                                     :foreground base5)
   (centaur-tabs-unselected-modified :background bg
                                     :foreground blue)
   (centaur-tabs-active-bar-face     :background blue)

;;;; gnus (explicit overrides — doom-themes' base fallback
;;;; creates a mutual inheritance cycle between these two if left unset)
   (gnus-group-mail-1                :foreground magenta :weight 'bold)
   (gnus-group-mail-1-empty          :foreground base5)
   (gnus-group-news-low              :foreground base6)
   (gnus-group-news-low-empty        :foreground base5))

  ;;;; Base theme variable overrides
  ;; ()
  )

;;; transcoded-theme.el ends here
