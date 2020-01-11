;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                    ;          Global keybindings         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Remap SPC in evil mode to a leader key
(general-create-definer my-global-leader-def
  ;; :prefix my-leader
  :prefix "SPC")

;; Remap SPC o to org mode leader key
(general-create-definer yaoni-org-leader-def
  :prefix "SPC o")

(my-global-leader-def
 :keymaps 'normal
  "e" 'evil-end-of-line
  ;"set-key expects an interactive command
  "i e" (lambda() (interactive) (find-file "~/.emacs.d"))
  "i l" (lambda() (interactive) (load-file "~/.emacs.d/init.el"))
  "k" 'describe-key
  "f" 'describe-function
  "m u" 'mu4e
  "o a" 'org-agenda
 )



(with-eval-after-load 'gif-screencast
  (define-key gif-screencast-mode-map (kbd "<f8>") 'gif-screencast-toggle-pause)
  (define-key gif-screencast-mode-map (kbd "<f9>") 'gif-screencast-stop))
