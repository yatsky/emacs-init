;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                    ;          Global keybindings         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Remap SPC in evil mode to a leader key
(general-create-definer my-global-leader
  ;; :prefix my-leader
  :prefix "SPC")

(general-create-definer my-global-text-leader
  ;; for faster text operations
  :prefix ",")

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

  ;"set-key expects an interactive command
  "i e" (lambda() (interactive) (find-file "~/.emacs.d"))

  ; l -> load
  "l i" (lambda() (interactive) (load-file "~/.emacs.d/init.el"))
  "m u" 'mu4e
  "o a" 'org-agenda
  "." 'evil-repeat

  ;d -> delete
  "d o w" 'delete-other-windows
  ; r -> run

  ;; helm-M-x is helmized execute-extended-command
  ;"r" 'execute-extended-command
  "r" 'helm-M-x

  ; s -> switch
  ; switch to buffer
  "s t b" 'switch-to-buffer
  "s t f" 'other-frame

  ; s -> search
  "s i" 'isearch-forward

  ; s -> save
  "s b" 'save-buffer

  ; o -> open
  "o f" 'helm-find-files
  ; Frame size
  ; inc frame width
  "i f w" 'inc-frame-width
  "d f w" 'dec-frame-width
  "i f h" 'inc-frame-height
  "d f h" 'dec-frame-height

  ; magit-status
  "m s" 'magit-status
  )



(with-eval-after-load 'gif-screencast
  (define-key gif-screencast-mode-map (kbd "<f8>") 'gif-screencast-toggle-pause)
  (define-key gif-screencast-mode-map (kbd "<f9>") 'gif-screencast-stop))
