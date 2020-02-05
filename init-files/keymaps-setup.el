;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                    ;      Functions for key bindings     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                    ;          Global keybindings         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(general-define-key
 :states '(motion normal)
 :keymaps 'override
  ; r -> redo
  "r" 'undo-tree-redo
  "2" 'other-window
  "3" 'split-window-right
  "4" 'delete-other-windows

 )
;; Remap SPC in evil mode to a leader key
(general-create-definer my-global-leader
  ;; :prefix my-leader
  :prefix "SPC")

(general-create-definer my-global-text-leader
  ;; for faster text operations
  :prefix ",")

(general-create-definer my-global-misc-leader
  ;; for future operations
  :prefix "m")

;; Remap SPC o to org mode leader key
(general-create-definer yaoni-org-leader-def
  :prefix "SPC o")

(my-global-text-leader
  :states '(motion normal)
  :keymaps 'override

  "e" 'evil-end-of-line
  "a" 'evil-append-line
  )

(my-global-leader
  :states '(motion normal)
  :keymaps 'override


  ; l -> load
  "l i" (lambda() (interactive) (load-file "~/.emacs.d/init.el"))
  "m u" 'mu4e
  "o a" 'org-agenda
  "." 'evil-repeat

  ;d -> delete
  "d o w" 'delete-other-windows
  ; r -> run

  ;; helm-M-x is helmized execute-extended-command
  ;"e" 'execute-extended-command
  ; e -> execute
  "e" 'helm-M-x

  ; s -> switch
  ; switch to buffer
  "s b" 'switch-to-buffer
  "s f" 'other-frame
  "s w l" 'evil-window-right
  "s w h" 'evil-window-left
  "s w k" 'evil-window-up
  "s w j" 'evil-window-down

  ; s -> search
  "s i" 'isearch-forward

  ; w -> write
  "w b" 'save-buffer

  ; o -> open
  "o f" 'helm-find-files
  ;"set-key expects an interactive command
  "o i" (lambda() (interactive) (find-file "~/.emacs.d"))
  ; Frame size
  ; inc frame width
  "i f w" 'inc-frame-width
  "d f w" 'dec-frame-width
  "i f h" 'inc-frame-height
  "d f h" 'dec-frame-height

  ; magit-status
  "m s" 'magit-status


  ; eX command
  "x" 'evil-ex
  )



(with-eval-after-load 'gif-screencast
  (define-key gif-screencast-mode-map (kbd "<f8>") 'gif-screencast-toggle-pause)
  (define-key gif-screencast-mode-map (kbd "<f9>") 'gif-screencast-stop))

;; auto-complete
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
