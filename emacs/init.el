
(setq ring-bell-function 'ignore)

(delete-selection-mode 1)    ;; You can select text and delete it by typing.
(electric-indent-mode -1)    ;; Turn off the weird indenting that Emacs does by default.
(electric-pair-mode 1)       ;; Turns on automatic parens pairing
;; The following prevents <> from auto-pairing when electric-pair-mode is on.
;; Otherwise, org-tempo is broken when you try to <s TAB...
(add-hook 'org-mode-hook (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))
(global-auto-revert-mode t)  ;; Automatically show changes if the file has changed
(global-display-line-numbers-mode 1) ;; Display line numbers
(global-visual-line-mode t)  ;; Enable truncated lines
(menu-bar-mode -1)           ;; Disable the menu bar 
(scroll-bar-mode -1)         ;; Disable the scroll bar
(tool-bar-mode -1)           ;; Disable the tool bar
(setq org-edit-src-content-indentation 0) ;; Set src block automatic indent to 0 instead of 2.

;(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(global-hl-line-mode 1)


(add-to-list 'load-path "~/.config/emacs/mods/")
(add-to-list 'load-path "~/.config/emacs/mods/svg-lib/")
(add-to-list 'load-path "~/.config/emacs/mods/nano-sidebar/")
(add-to-list 'custom-theme-load-path "./lisp/themes/")
(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/nano-theme/")


;; Customize the hl-line face color
(set-face-background 'hl-line "#292c3c") ;;
(set-face-background 'cursor "#94e2d5") ;;
;; In normal mode, use a box cursor
(setq evil-normal-state-cursor 'box)
;; In insert mode, use a bar cursor
(setq evil-insert-state-cursor 'bar)
;; In visual mode, use a hollow cursor
(setq evil-visual-state-cursor 'hollow)
(load-theme 'elegant t)
