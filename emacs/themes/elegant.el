;;; elegant-theme.el --- elegant Theme

;;; Code:
(deftheme elegant)


;;;; Configuration options:

(defgroup elegant nil
          "elegant theme options.

          The theme has to be reloaded after changing anything in this group."
          :group 'faces)

(defcustom elegant-enlarge-headings t
           "Use different font sizes for some headings and titles."
           :type 'boolean
           :group 'elegant)

(defcustom elegant-height-title-1 1.3
           "Font size 100%."
           :type 'number
           :group 'elegant)

(defcustom elegant-height-title-2 1.1
           "Font size 110%."
           :type 'number
           :group 'elegant)

(defcustom elegant-height-title-3 1.0
           "Font size 130%."
           :type 'number
           :group 'elegant)

(defcustom elegant-height-doc-title 1.44
           "Font size 144%."
           :type 'number
           :group 'elegant)

(defcustom elegant-alternate-mode-line-and-minibuffer nil
           "Use less bold and pink in the minibuffer."
           :type 'boolean
           :group 'elegant)

(defvar elegant-use-24-bit-colors-on-256-colors-terms nil
  "Use true colors even on terminals announcing less capabilities.

  Beware the use of this variable.  Using it may lead to unwanted
  behavior, the most common one being an ugly blue background on
  terminals, which don't understand 24 bit colors.  To avoid this
  blue background, when using this variable, one can try to add the
  following lines in their config file after having load the
  elegant theme:

  (unless (display-graphic-p)
    (set-face-background \\='default \"black\" nil))

  There is a lot of discussion behind the 256 colors theme (see URL
                                                                `https://github.com/elegant/emacs/pull/57').  Please take time to
  read it before opening a new issue about your will.")

;; Assigment form: VARIABLE COLOR [256-COLOR [TTY-COLOR]]
(let ((colors '(;; Upstream theme color
                (elegant-bg      "#1e1e2e" "unspecified-bg" "unspecified-bg") ; official background
                (elegant-fg      "#cdd6f4" "#cdd6f4" "brightwhite") ; official foreground
                (elegant-current "#44475a" "#232136" "brightblack") ; official current-line/selection
                (elegant-comment "#5b6078" "#5b6078" "blue")        ; official comment
                (elegant-heading "#e0def4" "#e0def4" "blue")        ; official comment
                (elegant-cyan    "#89dceb" "#91d7e3" "brightcyan")  ; official cyan
                (elegant-green   "#a6e3a1" "#a6da95" "green")       ; official green
                (elegant-teal   "#94e2d5" "#a6e3a1" "teal")       ; official green
                (elegant-orange  "#fab387" "#f5a97f" "brightred")   ; official orange    ;; #94e2d5
                (elegant-pink    "#f5c2e7" "#f5bde6" "magenta")     ; official pink
                (elegant-purple  "#cba6f7" "#c6a0f6" "brightmagenta") ; official purple
                (elegant-red     "#f38ba8" "#ed8796" "red")         ; official red
                (elegant-red-darker     "#d20f39" "#d20f39" "red")         ; official red
                (elegant-yellow  "#f1fa8c" "#eed49f" "yellow")      ; official yellow
                ;; Other colors
                (bg2             "#373844" "#121212" "brightblack")
                (bg3             "#565761" "#444444" "brightblack")
                (fg2             "#bac2de" "#bac2de" "brightwhite")
                (fg3             "#a6adc8" "#a6adc8" "white")
                (fg4             "#9399b2" "#9399b2" "white")
                (dark-red        "#880000" "#870000" "red") ; 40% darker
                (dark-green      "#037a22" "#00af00" "green") ; 40% darker
                (dark-blue       "#0189cc" "#0087ff" "brightblue")
                (elegant-maroon-0 "#ea999c")
                (tokyo-bg "#24283b")
                (tokyo-bg-dark "#1f2335")
                (tokyo-bg-hl "#292e42")
                (tokyo-fg "#c0caf5")
                (tokyo-fg-1 "#a9b1d6")
                (tokyo-fg-2 "#3b4261")
                (tokyo-white "#ffffff")
                (tokyo-black "#414868")
                (tokyo-comment "#565f89")
                (tokyo-dark "#545c7e")
                (tokyo-dark+1 "#737aa2")
                (tokyo-blue-1 "#394b70")
                (tokyo-blue "#3d59a1")
                (tokyo-blue+1 "#7aa2f7")
                (tokyo-blue+2 "#2ac3d3")
                (tokyo-blue+3 "#0db9d7")
                (tokyo-blue+4 "#89ddff")
                (tokyo-blue+5 "#b4f9f8")
                (tokyo-cyan "#7dcfff")
                (tokyo-magenta "#bb9af7")
                (tokyo-magenta+1 "#ff007c")
                (tokyo-purple "#9d7cd8")
                (tokyo-orange "#ff9e64")
                (tokyo-yellow "#e0af68")
                (tokyo-green "#9ece6a")
                (tokyo-teal-1 "#41a6b5")
                (tokyo-teal "#1abc9c")
                (tokyo-teal+1 "#73daca")
                (tokyo-red-1 "#db4b4b")
                (tokyo-red "#f7768e")
                ))
      (faces '(;; default / basic faces


               (dashboard-heading :foreground ,elegant-fg)
               (dashboard-text-banner :foreground ,elegant-purple)
               (dashboard-heading :foreground ,elegant-purple)
               (dashboard-banner-logo-title :foreground ,elegant-comment)         
               (dashboard-footer-face  :foreground ,elegant-fg)                 
               (dashboard-footer-icon-face  :foreground ,elegant-fg)            
               (dashboard-items-face  :foreground ,elegant-fg)                  
               (dashboard-navigator   :foreground ,elegant-fg)                  
               (dashboard-no-items-face   :foreground ,elegant-fg)              

               (line-number-current-line :foreground ,elegant-green :weight bold)
               (line-number :slant italic :foreground ,bg3 :background ,elegant-bg)

               (org-level-1 :inherit bold :foreground ,elegant-heading
                            ,@(when elegant-enlarge-headings
                                (list :height elegant-height-title-1)))
               (org-level-2 :inherit bold :foreground ,elegant-heading
                            ,@(when elegant-enlarge-headings
                                (list :height elegant-height-title-2)))
               (org-level-3 :weight normal :foreground ,elegant-heading
                            ,@(when elegant-enlarge-headings
                                (list :height elegant-height-title-3)))
               (org-level-4 :weight normal :foreground ,elegant-heading)
               (org-level-5 :weight normal :foreground ,elegant-heading)
               (org-level-6 :weight normal :foreground ,elegant-heading)
               (org-level-7 :weight normal :foreground ,elegant-heading)
               (org-level-8 :weight normal :foreground ,elegant-heading)


               (marginalia-date :foreground ,elegant-teal)


               (orderless-match-face-0  :foreground ,elegant-red-darker)
               (corfu-annotations  :foreground ,elegant-comment)


               (cursor :background ,fg3)
               (default :background ,elegant-bg :foreground ,elegant-fg)
               (default-italic :slant italic)
               (error :foreground ,elegant-red)
               (ffap :foreground ,fg4)
               (fringe :background ,elegant-bg :foreground ,fg4)
               (header-line :inherit 'mode-line)
               (highlight :foreground ,fg3 :background ,elegant-current)
               (hl-line :background ,elegant-current :extend t)
               (info-quoted-name :foreground ,elegant-orange)
               (info-string :foreground ,elegant-yellow)
               (lazy-highlight :foreground ,fg2 :background ,bg2)
               (link :foreground ,elegant-teal :underline t)
               (linum :slant italic :foreground ,bg3 :background ,elegant-bg)
               (match :background ,elegant-yellow :foreground ,elegant-bg)
               (menu :background ,elegant-current :inverse-video nil
                     ,@(if elegant-alternate-mode-line-and-minibuffer
                         (list :foreground fg3)
                         (list :foreground elegant-fg)))
               (minibuffer-prompt
                 ,@(if elegant-alternate-mode-line-and-minibuffer
                     (list :weight 'normal :foreground elegant-fg)
                     (list :weight 'bold :foreground elegant-pink)))
               (mode-line :background ,elegant-current
                          :box ,elegant-current :inverse-video nil
                          ,@(if elegant-alternate-mode-line-and-minibuffer
                              (list :foreground fg3)
                              (list :foreground elegant-fg)))
               (mode-line-inactive
                 :background ,elegant-bg :inverse-video nil
                 ,@(if elegant-alternate-mode-line-and-minibuffer
                     (list :foreground elegant-comment :box elegant-bg)
                     (list :foreground fg4 :box bg2)))
               (read-multiple-choice-face :inherit completions-first-difference)
               (region :background ,elegant-current :extend nil)
               (shadow :foreground ,elegant-comment)
               (success :foreground ,elegant-green)
               (tooltip :foreground ,elegant-fg :background ,elegant-current)
               (trailing-whitespace :background ,elegant-orange)
               (vertical-border :foreground ,bg2)
               (warning :foreground ,elegant-orange)
               
               ;; syntax / font-lock
               (font-lock-builtin-face :foreground ,tokyo-teal :slant italic)
               (font-lock-comment-face :inherit shadow)
               (font-lock-comment-delimiter-face :inherit shadow)
               (font-lock-constant-face :foreground ,tokyo-teal)
               (font-lock-doc-face :foreground ,elegant-comment)
               (font-lock-function-name-face :foreground ,tokyo-blue+1 :weight bold)
               (font-lock-keyword-face :foreground ,tokyo-red :weight normal :slant italic)
               (font-lock-negation-char-face :foreground ,elegant-cyan)
               (font-lock-number-face :foreground ,elegant-purple)
               (font-lock-operator-face :foreground ,elegant-pink)
               (font-lock-preprocessor-face :foreground ,tokyo-cyan)
               (font-lock-reference-face :inherit font-lock-constant-face) ;; obsolete
               (font-lock-regexp-grouping-backslash :foreground ,elegant-cyan)
               (font-lock-regexp-grouping-construct :foreground ,elegant-purple)
               (font-lock-string-face :foreground ,tokyo-green)
               (font-lock-type-face :inherit font-lock-builtin-face)
               (font-lock-variable-name-face :foreground ,elegant-fg :weight bold)
               (font-lock-warning-face :inherit warning :background ,bg2)







               ;; auto-complete
               (ac-completion-face :underline t :foreground ,elegant-pink)
               ;; ansi-color
               (ansi-color-black :foreground ,elegant-bg :background ,elegant-bg)
               (ansi-color-bright-black :foreground "black" :background "black")
               (ansi-color-blue :foreground ,elegant-purple :background ,elegant-purple)
               (ansi-color-bright-blue :foreground ,elegant-purple
                                       :background ,elegant-purple
                                       :weight bold)
               (ansi-color-cyan :foreground ,elegant-cyan :background ,elegant-cyan)
               (ansi-color-bright-cyan :foreground ,elegant-cyan
                                       :background ,elegant-cyan
                                       :weight bold)
               (ansi-color-green :foreground ,elegant-green :background ,elegant-green)
               (ansi-color-bright-green :foreground ,elegant-green
                                        :background ,elegant-green
                                        :weight bold)
               (ansi-color-magenta :foreground ,elegant-pink :background ,elegant-pink)
               (ansi-color-bright-magenta :foreground ,elegant-pink
                                          :background ,elegant-pink
                                          :weight bold)
               (ansi-color-red :foreground ,elegant-red :background ,elegant-red)
               (ansi-color-bright-red :foreground ,elegant-red
                                      :background ,elegant-red
                                      :weight bold)
               (ansi-color-white :foreground ,elegant-fg :background ,elegant-fg)
               (ansi-color-bright-white :foreground "white" :background "white")
               (ansi-color-yellow :foreground ,elegant-yellow :background ,elegant-yellow)
               (ansi-color-bright-yellow :foreground ,elegant-yellow
                                         :background ,elegant-yellow
                                         :weight bold)
               ;; bookmarks
               (bookmark-face :foreground ,elegant-pink)
               ;; diff
               (diff-added :background ,dark-green :foreground ,elegant-fg :extend t)
               (diff-removed :background ,dark-red :foreground ,elegant-fg :extend t)
               (diff-refine-added :background ,elegant-green
                                  :foreground ,elegant-bg)
               (diff-refine-removed :background ,elegant-red
                                    :foreground ,elegant-fg)
               (diff-indicator-added :foreground ,elegant-green)
               (diff-indicator-removed :foreground ,elegant-red)
               (diff-indicator-changed :foreground ,elegant-orange)
               (diff-error :foreground ,elegant-red, :background ,elegant-bg
                           :weight bold)
               ;; diff-hl
               (diff-hl-change :foreground ,elegant-orange :background ,elegant-orange)
               (diff-hl-delete :foreground ,elegant-red :background ,elegant-red)
               (diff-hl-insert :foreground ,elegant-green :background ,elegant-green)
               ;; dired
               (dired-directory :foreground ,elegant-green :weight normal)
               (dired-flagged :foreground ,elegant-pink)
               (dired-header :foreground ,fg3 :background ,elegant-bg)
               (dired-ignored :inherit shadow)
               (dired-mark :foreground ,elegant-fg :weight bold)
               (dired-marked :foreground ,elegant-orange :weight bold)
               (dired-perm-write :foreground ,fg3 :underline t)
               (dired-symlink :foreground ,elegant-yellow :weight normal :slant italic)
               (dired-warning :foreground ,elegant-orange :underline t)
               (diredp-compressed-file-name :foreground ,fg3)
               (diredp-compressed-file-suffix :foreground ,fg4)
               (diredp-date-time :foreground ,elegant-fg)
               (diredp-deletion-file-name :foreground ,elegant-pink :background ,elegant-current)
               (diredp-deletion :foreground ,elegant-pink :weight bold)
               (diredp-dir-heading :foreground ,fg2 :background ,bg3)
               (diredp-dir-name :inherit dired-directory)
               (diredp-dir-priv :inherit dired-directory)
               (diredp-executable-tag :foreground ,elegant-orange)
               (diredp-file-name :foreground ,elegant-fg)
               (diredp-file-suffix :foreground ,fg4)
               (diredp-flag-mark-line :foreground ,fg2 :slant italic :background ,elegant-current)
               (diredp-flag-mark :foreground ,fg2 :weight bold :background ,elegant-current)
               (diredp-ignored-file-name :foreground ,elegant-fg)
               (diredp-mode-line-flagged :foreground ,elegant-orange)
               (diredp-mode-line-marked :foreground ,elegant-orange)
               (diredp-no-priv :foreground ,elegant-fg)
               (diredp-number :foreground ,elegant-cyan)
               (diredp-other-priv :foreground ,elegant-orange)
               (diredp-rare-priv :foreground ,elegant-orange)
               (diredp-read-priv :foreground ,elegant-purple)
               (diredp-write-priv :foreground ,elegant-pink)
               (diredp-exec-priv :foreground ,elegant-yellow)
               (diredp-symlink :foreground ,elegant-orange)
               (diredp-link-priv :foreground ,elegant-orange)
               (diredp-autofile-name :foreground ,elegant-yellow)
               (diredp-tagged-autofile-name :foreground ,elegant-yellow)
               ;; ediff
               (ediff-current-diff-A :background ,dark-red)
               (ediff-fine-diff-A :background ,elegant-red :foreground ,elegant-fg)
               (ediff-current-diff-B :background ,dark-green)
               (ediff-fine-diff-B :background ,elegant-green :foreground ,elegant-bg)
               (ediff-current-diff-C :background ,dark-blue)
               (ediff-fine-diff-C :background ,elegant-cyan :foreground ,elegant-bg)
               ;; eglot
               (eglot-diagnostic-tag-unnecessary-face :inherit warning)
               (eglot-diagnostic-tag-deprecated-face :inherit warning :strike-through t)
               ;; eldoc-box
               (eldoc-box-border :background ,elegant-current)
               (eldoc-box-body :background ,elegant-current)
               ;; elfeed
               (elfeed-search-date-face :foreground ,elegant-comment)
               (elfeed-search-title-face :foreground ,elegant-fg)
               (elfeed-search-unread-title-face :foreground ,elegant-pink :weight bold)
               (elfeed-search-feed-face :foreground ,elegant-fg :weight bold)
               (elfeed-search-tag-face :foreground ,elegant-green)
               (elfeed-search-last-update-face :weight bold)
               (elfeed-search-unread-count-face :foreground ,elegant-pink)
               (elfeed-search-filter-face :foreground ,elegant-green :weight bold)
               ;;(elfeed-log-date-face :inherit font-lock-type-face)
               (elfeed-log-error-level-face :foreground ,elegant-red)
               (elfeed-log-warn-level-face :foreground ,elegant-orange)
               (elfeed-log-info-level-face :foreground ,elegant-cyan)
               (elfeed-log-debug-level-face :foreground ,elegant-comment)
               ;; flyspell
               (flyspell-duplicate :underline (:style wave :color ,elegant-orange))
               (flyspell-incorrect :underline (:style wave :color ,elegant-red))
               ;; font-latex
               (font-latex-bold-face :foreground ,elegant-purple)
               (font-latex-italic-face :foreground ,elegant-pink :slant italic)
               (font-latex-match-reference-keywords :foreground ,elegant-cyan)
               (font-latex-match-variable-keywords :foreground ,elegant-fg)
               (font-latex-string-face :foreground ,elegant-yellow)
               ;; highlight-indentation minor mode
               (highlight-indentation-face :background ,bg2)
               ;; isearch
               (isearch :inherit match :weight bold)
               (isearch-fail :foreground ,elegant-bg :background ,elegant-orange)
               ;; lsp
               (lsp-ui-peek-peek :background ,elegant-bg)
               (lsp-ui-peek-list :background ,bg2)
               (lsp-ui-peek-filename :foreground ,elegant-pink :weight bold)
               (lsp-ui-peek-line-number :foreground ,elegant-fg)
               (lsp-ui-peek-highlight :inherit highlight :distant-foreground ,elegant-bg)
               (lsp-ui-peek-header :background ,elegant-current :foreground ,fg3, :weight bold)
               (lsp-ui-peek-footer :inherit lsp-ui-peek-header)
               (lsp-ui-peek-selection :inherit match)
               (lsp-ui-sideline-symbol :foreground ,fg4 :box (:line-width -1 :color ,fg4) :height 0.99)
               (lsp-ui-sideline-current-symbol :foreground ,elegant-fg :weight ultra-bold
                                               :box (:line-width -1 :color ,elegant-fg) :height 0.99)
               (lsp-ui-sideline-code-action :foreground ,elegant-yellow)
               (lsp-ui-sideline-symbol-info :slant italic :height 0.99)
               (lsp-ui-doc-background :background ,elegant-bg)
               (lsp-ui-doc-header :foreground ,elegant-bg :background ,elegant-cyan)
               ;; message
               (message-header-to :foreground ,elegant-fg :weight bold)
               (message-header-cc :foreground ,elegant-fg :bold bold)
               (message-header-subject :foreground ,elegant-orange)
               (message-header-newsgroups :foreground ,elegant-purple)
               (message-header-other :foreground ,elegant-purple)
               (message-header-name :foreground ,elegant-green)
               (message-header-xheader :foreground ,elegant-cyan)
               (message-separator :foreground ,elegant-cyan :slant italic)
               (message-cited-text :foreground ,elegant-purple)
               (message-cited-text-1 :foreground ,elegant-purple)
               (message-cited-text-2 :foreground ,elegant-orange)
               (message-cited-text-3 :foreground ,elegant-comment)
               (message-cited-text-4 :foreground ,fg2)
               (message-mml :foreground ,elegant-green :weight normal)
               ;; mini-modeline
               (mini-modeline-mode-line :inherit mode-line :height 0.1 :box nil)
               ;; mu4e
               (mu4e-unread-face :foreground ,elegant-pink :weight normal)
               (mu4e-view-url-number-face :foreground ,elegant-purple)
               (mu4e-highlight-face :background ,elegant-bg
                                    :foreground ,elegant-yellow
                                    :extend t)
               (mu4e-header-highlight-face :background ,elegant-current
                                           :foreground ,elegant-fg
                                           :underline nil :weight bold
                                           :extend t)
               (mu4e-header-key-face :inherit message-mml)
               (mu4e-header-marks-face :foreground ,elegant-purple)
               (mu4e-cited-1-face :foreground ,elegant-purple)
               (mu4e-cited-2-face :foreground ,elegant-orange)
               (mu4e-cited-3-face :foreground ,elegant-comment)
               (mu4e-cited-4-face :foreground ,fg2)
               (mu4e-cited-5-face :foreground ,fg3)
               ;; neotree
               (neo-banner-face :foreground ,elegant-orange :weight bold)
               ;;(neo-button-face :underline nil)
               (neo-dir-link-face :foreground ,elegant-purple)
               (neo-expand-btn-face :foreground ,elegant-fg)
               (neo-file-link-face :foreground ,elegant-cyan)
               (neo-header-face :background ,elegant-bg
                                :foreground ,elegant-fg
                                :weight bold)
               (neo-root-dir-face :foreground ,elegant-purple :weight bold)
               (neo-vc-added-face :foreground ,elegant-orange)
               (neo-vc-conflict-face :foreground ,elegant-red)
               (neo-vc-default-face :inherit neo-file-link-face)
               (neo-vc-edited-face :foreground ,elegant-orange)
               (neo-vc-ignored-face :foreground ,elegant-comment)
               (neo-vc-missing-face :foreground ,elegant-red)
               (neo-vc-needs-merge-face :foreground ,elegant-red
                                        :weight bold)
               ;;(neo-vc-needs-update-face :underline t)
               ;;(neo-vc-removed-face :strike-through t)
               (neo-vc-unlocked-changes-face :foreground ,elegant-red)
               ;;(neo-vc-unregistered-face nil)
               (neo-vc-up-to-date-face :foreground ,elegant-green)
               (neo-vc-user-face :foreground ,elegant-purple)
               ;; org
               (org-agenda-date :foreground ,elegant-cyan :underline nil)
               (org-agenda-dimmed-todo-face :foreground ,elegant-comment)
               (org-agenda-done :foreground ,elegant-green)
               (org-agenda-structure :foreground ,elegant-purple)
               (org-block :foreground ,elegant-orange)
               (org-code :foreground ,elegant-green)
               (org-column :background ,bg3)
               (org-column-title :inherit org-column :weight bold :underline t)
               (org-date :foreground ,elegant-cyan :underline t)
               (org-document-info :foreground ,elegant-teal)
               (org-document-info-keyword :foreground ,elegant-comment)
               (org-document-title :weight bold :foreground ,elegant-teal
                                   ,@(when elegant-enlarge-headings
                                       (list :height elegant-height-doc-title)))
               (org-done :foreground ,elegant-green)
               (org-ellipsis :foreground ,elegant-comment)
               (org-footnote :foreground ,dark-blue)
               (org-formula :foreground ,elegant-pink)
               (org-headline-done :foreground ,elegant-comment
                                  :weight normal :strike-through t)
               (org-hide :foreground ,elegant-bg :background ,elegant-bg)
               (org-link :foreground ,elegant-green :underline t)
               (org-priority :foreground ,elegant-cyan)
               (org-quote :foreground ,elegant-yellow :slant italic)
               (org-scheduled :foreground ,elegant-green)
               (org-scheduled-previously :foreground ,elegant-yellow)
               (org-scheduled-today :foreground ,elegant-green)
               (org-sexp-date :foreground ,fg4)
               (org-special-keyword :foreground ,elegant-yellow)
               (org-table :foreground ,fg2)
               (org-tag :foreground ,elegant-pink :weight bold :background ,bg2)
               (org-todo :foreground ,elegant-orange :weight bold :background ,bg2)
               (org-upcoming-deadline :foreground ,elegant-yellow)
               (org-verbatim :inherit org-quote)
               (org-warning :weight bold :foreground ,elegant-pink)

               ;; org-mordern
               (org-modern-date-active :foreground ,elegant-teal)
               (org-meta-line :foreground ,elegant-teal)


               ;; outline
               (outline-1 :foreground ,elegant-pink)
               (outline-2 :foreground ,elegant-purple)
               (outline-3 :foreground ,elegant-green)
               (outline-4 :foreground ,elegant-yellow)
               (outline-5 :foreground ,elegant-cyan)
               (outline-6 :foreground ,elegant-orange)
               ;; perspective
               (persp-selected-face :weight bold :foreground ,elegant-pink)
               ;; rainbow-delimiters
               (rainbow-delimiters-depth-1-face :foreground ,elegant-fg)
               (rainbow-delimiters-depth-2-face :foreground ,elegant-cyan)
               (rainbow-delimiters-depth-3-face :foreground ,elegant-purple)
               (rainbow-delimiters-depth-4-face :foreground ,elegant-pink)
               (rainbow-delimiters-depth-5-face :foreground ,elegant-orange)
               (rainbow-delimiters-depth-6-face :foreground ,elegant-green)
               (rainbow-delimiters-depth-7-face :foreground ,elegant-yellow)
               (rainbow-delimiters-depth-8-face :foreground ,dark-blue)
               (rainbow-delimiters-unmatched-face :foreground ,elegant-orange)
               ;; show-paren
               (show-paren-match-face :background unspecified
                                      :foreground ,elegant-cyan
                                      :weight bold)
               (show-paren-match :background unspecified
                                 :foreground ,elegant-cyan
                                 :weight bold)
               (show-paren-match-expression :inherit match)
               (show-paren-mismatch :inherit font-lock-warning-face)
               ;; shr
               (shr-h1 :foreground ,elegant-pink :weight bold :height 1.3)
               (shr-h2 :foreground ,elegant-purple :weight bold)
               (shr-h3 :foreground ,elegant-green :slant italic)
               (shr-h4 :foreground ,elegant-yellow)
               (shr-h5 :foreground ,elegant-cyan)
               (shr-h6 :foreground ,elegant-orange)
               ;; slime
               (slime-repl-inputed-output-face :foreground ,elegant-purple)
               ;; solaire-mode
               (solaire-default-face :background ,bg2)
               ;; spam
               (spam :inherit gnus-summary-normal-read :foreground ,elegant-orange
                     :strike-through t :slant oblique)
               ;; speedbar (and sr-speedbar)
               (speedbar-button-face :foreground ,elegant-green)
               (speedbar-file-face :foreground ,elegant-cyan)
               (speedbar-directory-face :foreground ,elegant-purple)
               (speedbar-tag-face :foreground ,elegant-yellow)
               (speedbar-selected-face :foreground ,elegant-pink)
               (speedbar-highlight-face :inherit match)
               (speedbar-separator-face :background ,elegant-bg
                                        :foreground ,elegant-fg
                                        :weight bold)
               ;; tab-bar & tab-line (since Emacs 27.1)
               (tab-bar :foreground ,elegant-purple :background ,elegant-current
                        :inherit variable-pitch)
               (tab-bar-tab :foreground ,elegant-pink :background ,elegant-bg
                            :box (:line-width 2 :color ,elegant-bg :style nil))
               (tab-bar-tab-inactive :foreground ,elegant-purple :background ,bg2
                                     :box (:line-width 2 :color ,bg2 :style nil))
               (tab-line :foreground ,elegant-purple :background ,elegant-current
                         :height 0.9 :inherit variable-pitch)
               (tab-line-tab :foreground ,elegant-pink :background ,elegant-bg
                             :box (:line-width 2 :color ,elegant-bg :style nil))
               (tab-line-tab-inactive :foreground ,elegant-purple :background ,bg2
                                      :box (:line-width 2 :color ,bg2 :style nil))
               (tab-line-tab-current :inherit tab-line-tab)
               (tab-line-close-highlight :foreground ,elegant-red)
               ;; --               
               ;; tree-sitter
               ;; --
               (tree-sitter-hl-face:attribute :inherit font-lock-constant-face)
               (tree-sitter-hl-face:comment :inherit font-lock-comment-face)
               (tree-sitter-hl-face:constant :inherit font-lock-constant-face)
               (tree-sitter-hl-face:constant.builtin :inherit font-lock-builtin-face)
               (tree-sitter-hl-face:constructor :inherit font-lock-constant-face)
               (tree-sitter-hl-face:escape :foreground ,elegant-pink)
               (tree-sitter-hl-face:function :inherit font-lock-function-name-face)
               (tree-sitter-hl-face:function.builtin :inherit font-lock-builtin-face)
               (tree-sitter-hl-face:function.call :inherit font-lock-function-name-face
                                                  :weight normal)
               (tree-sitter-hl-face:function.macro :inherit font-lock-preprocessor-face)
               (tree-sitter-hl-face:function.special :inherit font-lock-preprocessor-face)
               (tree-sitter-hl-face:keyword :inherit font-lock-keyword-face)
               (tree-sitter-hl-face:punctuation :foreground ,elegant-pink)
               (tree-sitter-hl-face:punctuation.bracket :foreground ,elegant-fg)
               (tree-sitter-hl-face:punctuation.delimiter :foreground ,elegant-fg)
               (tree-sitter-hl-face:punctuation.special :foreground ,elegant-pink)
               (tree-sitter-hl-face:string :inherit font-lock-string-face)
               (tree-sitter-hl-face:string.special :foreground ,elegant-red)
               (tree-sitter-hl-face:tag :inherit font-lock-keyword-face)
               (tree-sitter-hl-face:type :inherit font-lock-type-face)
               (tree-sitter-hl-face:type.parameter :foreground ,elegant-pink)
               (tree-sitter-hl-face:variable :inherit font-lock-variable-name-face)
               (tree-sitter-hl-face:variable.parameter :inherit tree-sitter-hl-face:variable
                                                       :weight normal)
               ;; undo-tree
               (undo-tree-visualizer-current-face :foreground ,elegant-orange)
               (undo-tree-visualizer-default-face :foreground ,fg2)
               (undo-tree-visualizer-register-face :foreground ,elegant-purple)
               (undo-tree-visualizer-unmodified-face :foreground ,elegant-fg)
               ;; which-func
               (which-func :inherit font-lock-function-name-face)
               ;; which-key
               (which-key-key-face :inherit font-lock-builtin-face)
               (which-key-command-description-face :inherit default)
               (which-key-separator-face :inherit font-lock-comment-delimiter-face)
               (which-key-local-map-description-face :foreground ,elegant-green)
               ;; whitespace
               (whitespace-big-indent :background ,elegant-red :foreground ,elegant-red)
               (whitespace-empty :background ,elegant-orange :foreground ,elegant-red)
               (whitespace-hspace :background ,elegant-current :foreground ,elegant-comment)
               (whitespace-indentation :background ,elegant-orange :foreground ,elegant-red)
               (whitespace-line :background ,elegant-bg :foreground ,elegant-pink)
               (whitespace-newline :foreground ,elegant-comment)
               (whitespace-space :background ,elegant-bg :foreground ,elegant-comment)
               (whitespace-space-after-tab :background ,elegant-orange :foreground ,elegant-red)
               (whitespace-space-before-tab :background ,elegant-orange :foreground ,elegant-red)
               (whitespace-tab :background ,bg2 :foreground ,elegant-comment)
               (whitespace-trailing :inherit trailing-whitespace)
               ;; yard-mode
               (yard-tag-face :inherit font-lock-builtin-face)
               (yard-directive-face :inherit font-lock-builtin-face))))

  (apply #'custom-theme-set-faces
         'elegant
         (let ((expand-with-func
                 (lambda (func spec)
                   (let (reduced-color-list)
                     (dolist (col colors reduced-color-list)
                       (push (list (car col) (funcall func col))
                             reduced-color-list))
                     (eval `(let ,reduced-color-list
                              (backquote ,spec))))))
               whole-theme)
           (pcase-dolist (`(,face . ,spec) faces)
                         (push `(,face
                                  ((((min-colors 16777216)) ; fully graphical envs
                                    ,(funcall expand-with-func 'cadr spec))
                                   (((min-colors 256))      ; terminal withs 256 colors
                                    ,(if elegant-use-24-bit-colors-on-256-colors-terms
                                       (funcall expand-with-func 'cadr spec)
                                       (funcall expand-with-func 'caddr spec)))
                                   (t                       ; should be only tty-like envs
                                     ,(funcall expand-with-func 'cadddr spec))))
                               whole-theme))
           whole-theme)))


;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'elegant)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;;; elegant-theme.el ends here
